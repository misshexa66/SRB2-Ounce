#
# Makefile for Switch 2 (ounce) + libounce
#

SDL=1
NONX86=1
NOHW=1
NOUPNP=1
NOEXECINFO=1
NO_IPV6=1
NOGME=1
NOOPENMPT=1

EXENAME?=srb2-switch2.elf

PKG_CONFIG:=$(DEVKITPRO)/portlibs/switch2/bin/aarch64-none-elf-pkg-config

ounce_arch:=-march=armv8-a+crc+crypto -mtune=cortex-a57 -mtp=soft -fPIE -ftls-model=local-exec

opts+=$(ounce_arch) -std=gnu11 -D_OUNCE -D__SWITCH2__\
    -I$(DEVKITPRO)/portlibs/switch2/include \
    -isystem $(DEVKITPRO)/libounce/include \
    -DHAVE_DOSSTR_FUNCS -DLOGMESSAGES \
    -Dstricmp=strcasecmp -Dstrnicmp=strncasecmp

SDL_PKGCONFIG:=sdl2 SDL2_mixer
PNG_CONFIG:=$(DEVKITPRO)/portlibs/switch/bin/libpng-config
PNG_STATIC=1
CURLCONFIG:=$(DEVKITPRO)/portlibs/switch/bin/curl-config

libs+=$(ounce_arch) -specs=$(DEVKITPRO)/libounce/switch.specs \
    -L$(DEVKITPRO)/portlibs/switch2/lib \
    -L$(DEVKITPRO)/libounce/lib \
    -L$(DEVKITPRO)/portlibs/switch/lib \
    -Wl,--start-group -lnx -lm

# SRB2 appends LDFLAGS after all dependency libraries.
LDFLAGS+=-Wl,--end-group