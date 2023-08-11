#if !(defined(linux) || defined(__linux__))
#   error Not available outside of Linux
#endif

#define COLORS "\x1b[1;00m󱓞\t\x1b[1;32m󰯉\t\x1b[1;33m\t"\
               "\x1b[1;34m\t\x1b[1;35m\t\x1b[1;36m\x1b[0m"
#define DEFAULT_STRING_SIZE 128
#define ABORT(...) do {                             \
                   fprintf(stderr, __VA_ARGS__);    \
                   mpFree();                  \
                   exit(EXIT_FAILURE); } while(1);
#define NOCOLOR "\x1b[1;0m"
#define HEADER(A) mp->distro->logo[A], mp->distro->color, NOCOLOR
#define OPTCMP(A, B) (!strcmp(argv[i], "--" A) || !strcmp(argv[i], "-" B))
#define USAGE \
    "minfetch: print system info, version 1.0\n"\
    "\n"\
    "OPTIONS\n"\
    "   --help    -h    print this message\n"\
    "   --nologo  -n    don't print out logo\n"\
    "   --onlyhrs -H    print time in hours\n"

#include <errno.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include <fcntl.h>
#include <pwd.h>
#include <sys/sysinfo.h>
#include <sys/types.h>
#include <sys/utsname.h>

#include "logos.h"

struct uptime {
    long seconds;
    long minutes;
    long hours;
    int days;
};

struct distro {
    char logo[LOGO_HEIGHT][DEFAULT_STRING_SIZE];
    char color[DEFAULT_STRING_SIZE];
    char name[DEFAULT_STRING_SIZE];
    enum {
        GENERIC, ARCH_LINUX, GENTOO_LINUX, DEBIAN_LINUX, FEDORA_LINUX,
    } type;
};

struct system {
    struct sysinfo *sysinfo;
    struct passwd  *passwd;
    struct utsname *utsname;
    struct distro  *distro;
    char hostname[DEFAULT_STRING_SIZE];
    char uptime[DEFAULT_STRING_SIZE];
    char terminal[DEFAULT_STRING_SIZE];
    char editor[DEFAULT_STRING_SIZE];
    long availableram;
    long totalram;
    uid_t uid;
};

static unsigned char opt_flags = 0;
static struct system *mp = NULL;
static void *passwd_tmp_pointer = NULL;

static void *xcalloc(size_t size, size_t len)
{
    void *ret = calloc(size, len);
    if(ret == NULL) {
        fprintf(stderr, "minfetch: couldn't allocate memory: %s\n",
                strerror(errno));
        exit(EXIT_FAILURE);
    }
    return ret;
}

static inline void mpAlloc(void)
{
    mp = xcalloc(1, sizeof(struct system));
    mp->sysinfo = xcalloc(1, sizeof(struct sysinfo));
    mp->utsname = xcalloc(1, sizeof(struct utsname));
    mp->distro = xcalloc(1, sizeof(struct distro));
    mp->passwd = xcalloc(1, sizeof(struct passwd));
    passwd_tmp_pointer = mp->passwd;
}

static inline void mpFree(void)
{
    free(mp->sysinfo);
    free(mp->utsname);
    free(mp->distro);
    free(passwd_tmp_pointer);
    free(mp);
}

static inline void makeThread(pthread_t *thread, void *(*function)(void*), void *input)
{
    if(pthread_create(thread, NULL, function, input))
        ABORT("minfetch: failed creating thread: %s\n", strerror(errno));
}

static void *getKernel(void *arg)
{
    uname((struct utsname*)arg);
    return arg;
}

static void *getOs(void *arg)
{
    FILE *fp;
    char *buf = xcalloc(64, sizeof(char));

    if((fp = fopen("/etc/os-release", "r")) == NULL)
        ABORT("minfetch: failed opening /etc/os-release: %s\n", strerror(errno));

    while(buf[0] != 'N')
        buf = fgets(buf, 64, fp);
    sscanf(buf, "NAME=\"%[^\"]", ((struct distro*)arg)->name);
    free(buf); fclose(fp);

    return arg;
}

static void *getUsername(void *arg)
{
    mp->passwd = getpwuid(mp->uid);
    return arg;
}

static void *getAvailableRam(void *arg)
{
    FILE *fp;
    char *buf = xcalloc(BUFSIZ, sizeof(char));
    char *buffer = xcalloc(BUFSIZ, sizeof(char));

    if((fp = fopen("/proc/meminfo", "r")) == NULL)
        ABORT("minfetch: failed opening /proc/meminfo: %s\n", strerror(errno));

    buf = fgets(buf, BUFSIZ, fp);
    sscanf(buf, "MemTotal: %[^k]", buffer);
    ((struct system*)arg)->totalram = atol(buffer) / 1024;
    
    while(buf[3] != 'A')
        buf = fgets(buf, BUFSIZ, fp);
    sscanf(buf, "MemAvailable: %[^k]", buffer);
    ((struct system*)arg)->availableram = atol(buffer) / 1024;
    free(buf); free(buffer); fclose(fp);

    return arg;
}

static void *getSysInfo(void *arg)
{
    sysinfo(arg);
    return arg;
}

static void *getTerminal(void *arg)
{
    char *buf = xcalloc(128, sizeof(char));
    void *tmp = buf;

    if((buf = getenv("TERM")) == NULL)
        buf = getenv("TERMINAL");
    arg = strcpy(arg, buf);
    free(tmp);

    return arg;
}

static void *getEditor(void *arg)
{
    char *buf = xcalloc(128, sizeof(char));
    void *tmp = buf;

    if((buf = getenv("VISUAL")) == NULL)
        buf = getenv("EDITOR");
    arg = strcpy(arg, buf);
    free(tmp);

    return arg;
}

struct uptime makeUptime(long uptime)
{
    struct uptime ret;
    ret.seconds = uptime;
    ret.minutes = (uptime / 60) % 60;
    ret.hours = uptime / 3600;
    ret.days = ret.hours / 24;
    return ret;
}

static void getUptime(char *string, struct sysinfo *arg)
{
    struct uptime uptime = makeUptime(arg->uptime);
    if(arg->uptime < 60)
        snprintf(string, DEFAULT_STRING_SIZE, "%lds", arg->uptime);
    else if(arg->uptime < 3600)
        snprintf(string, DEFAULT_STRING_SIZE, "%ldm", uptime.minutes);
    else if(uptime.days == 0 || opt_flags & 0x02)
        snprintf(string, DEFAULT_STRING_SIZE, "%ldh %ldm",
                 uptime.hours, uptime.minutes);
    else
        snprintf(string, DEFAULT_STRING_SIZE, "%dd %ldh %ldm",
                 uptime.days, uptime.hours % 24, uptime.minutes);
}

static void getDistro(struct distro *input, char *arg)
{
    if(!strcmp(arg, "Arch Linux"))
        input->type = ARCH_LINUX;
    else if(!strcmp(arg, "Gentoo Linux"))
        input->type = GENTOO_LINUX;
    else if(!strcmp(arg, "Debian Linux"))
        input->type = DEBIAN_LINUX;
    else if(!strcmp(arg, "Fedora Linux"))
        input->type = FEDORA_LINUX;
    else
        input->type = GENERIC;
}

static void allocateLogo(struct distro *distro)
{
    switch(distro->type) {
    case ARCH_LINUX: {
        if(opt_flags & 0x01)
            distro->logo[0][0] = '\0';
        else {
            char assign_logo[LOGO_HEIGHT][DEFAULT_STRING_SIZE] = ARCH_LOGO;
            memcpy(distro->logo, assign_logo, sizeof(assign_logo) * (sizeof(assign_logo[0][0])));
        }
        strcpy(distro->color, "\x1b[1;96m");
    } break;

    case GENTOO_LINUX: {
        if(opt_flags & 0x01)
            distro->logo[0][0] = '\0';
        else {
            char assign_logo[LOGO_HEIGHT][DEFAULT_STRING_SIZE] = GENTOO_LOGO;
            memcpy(distro->logo, assign_logo, sizeof(assign_logo) * (sizeof(assign_logo[0][0])));
        }
        strcpy(distro->color, "\x1b[1;35m");
    } break;

    case DEBIAN_LINUX: {
        if(opt_flags & 0x01)
            distro->logo[0][0] = '\0';
        else {
            char assign_logo[LOGO_HEIGHT][DEFAULT_STRING_SIZE] = DEBIAN_LOGO;
            memcpy(distro->logo, assign_logo, sizeof(assign_logo) * (sizeof(assign_logo[0][0])));
        }
        strcpy(distro->color, "\x1b[1;31m");
    } break;

    case FEDORA_LINUX: {
        if(opt_flags & 0x01)
            distro->logo[0][0] = '\0';
        else {
            char assign_logo[LOGO_HEIGHT][DEFAULT_STRING_SIZE] = FEDORA_LOGO;
            memcpy(distro->logo, assign_logo, sizeof(assign_logo) * (sizeof(assign_logo[0][0])));
        }
        strcpy(distro->color, "\x1b[1;32m");
    } break;

    default:
        if(opt_flags & 0x01)
            distro->logo[0][0] = '\0';
        else {
            char assign_logo[LOGO_HEIGHT][DEFAULT_STRING_SIZE] = GENERIC_LOGO;
            memcpy(distro->logo, assign_logo, sizeof(assign_logo) * (sizeof(assign_logo[0][0])));
        }
        strcpy(distro->color, "\x1b[1;32m");
    }
}

static inline void mpAssign(void)
{
    mp->uid = getuid();
    pthread_t threads[5] = {0};
    makeThread(&threads[0], &getKernel, mp->utsname);
    makeThread(&threads[1], &getOs, mp->distro);
    makeThread(&threads[2], &getUsername, mp->passwd);
    makeThread(&threads[3], &getAvailableRam, mp);
    makeThread(&threads[4], &getTerminal, mp->terminal);
    pthread_join(threads[2], NULL);
    makeThread(&threads[2], &getSysInfo, mp->sysinfo);
    pthread_join(threads[3], NULL);
    makeThread(&threads[3], &getEditor, mp->editor);
    pthread_join(threads[4], NULL);
    getUptime(mp->uptime, mp->sysinfo);
    pthread_join(threads[1], NULL);
    getDistro(mp->distro, mp->distro->name);
    allocateLogo(mp->distro);
    pthread_join(threads[0], NULL);
    pthread_join(threads[2], NULL);
    pthread_join(threads[3], NULL);
}

int main(int argc, char **argv)
{
    for(int i = 0; i < argc; i++) {
        if(OPTCMP("help", "h")) {
            printf(USAGE);
            return EXIT_SUCCESS;
        }
        if(OPTCMP("nologo", "n"))
            opt_flags |= 0x01;
        if(OPTCMP("onlyhrs", "H"))
            opt_flags |= 0x02;
    }

    mpAlloc();
    mpAssign();

    printf("%s%s        %s%s@%s%s\n", mp->distro->logo[0], mp->distro->color, mp->passwd->pw_name, 
           NOCOLOR, mp->distro->color, mp->utsname->nodename);
    printf("%s\n", mp->distro->logo[1]);
    printf("%s%sDistribution%s:   %s\n", HEADER(2), mp->distro->name);
    printf("%s%sOperat. System%s: %s %s\n", HEADER(3), mp->utsname->sysname, mp->utsname->release);
    printf("%s%sSystem Memory%s:  %ldMiB / %luMiB (%ld%%)\n", HEADER(4), mp->totalram - mp->availableram,
            mp->totalram, mp->totalram / (mp->totalram - mp->availableram));
    printf("%s%sCurrent Uptime%s: %s\n", HEADER(5), mp->uptime);
    printf("%s%sShell%s:          %s\n", HEADER(6), mp->passwd->pw_shell);
    printf("%s%sTerminal%s:       %s\n", HEADER(7), mp->terminal);
//    printf("%s%sEditor%s:         %s\n", HEADER(8), mp->editor);
    printf("%s%s%s\n", HEADER(8));
    printf("%s%s\n", mp->distro->logo[9], COLORS);

    mpFree();
    return EXIT_SUCCESS;
}
