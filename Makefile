VALID_TOOLCHAINS := glibc pnacl linux

NACL_SDK_ROOT = /home/neko/nacl_sdk/pepper_30
include $(NACL_SDK_ROOT)/tools/common.mk

TARGET = audio
LIBS = $(DEPS) ppapi_cpp ppapi pthread

CFLAGS = -c -O3 -g3 -fno-strict-aliasing -fPIC -D__GNU__
CFLAGS += -DSOUND_OUTPUT=1 -DHAS_YM2612=1 -DHAS_YM3438=1 -DHAS_YM2203=1 -DHAS_YM2610=1 -DHAS_YM2610B=1 -DINLINE="static __inline__"
CFLAGS += -DHAS_YM3812=1 -DHAS_YM3526=1 -DHAS_M65C02=1 -DLSB_FIRST=1 -DHAS_M6803=1 -DHAS_M6808=1 -DHAS_ADSP2105=1
CFLAGS += -DHAS_ES5505=1 -DHAS_ES5506=1 -DHAS_K005289=1 -DHAS_SN76496=1 -DHAS_K007232=1 -DHAS_NAMCO=1
CFLAGS += -DHAS_CEM3394=1 -DHAS_YMZ280B=1 -DHAS_AY8910=1 -DHAS_DAC=1 -DHAS_SEGAPCM=1 -DHAS_OKIM6295=1
CFLAGS += -DHAS_TMS5220=1 -DHAS_ADPCM=1 -DHAS_K051649=1 -DHAS_YM2151_ALT=1 -DHAS_RF5C68=1
CFLAGS += -DHAS_QSOUND=1 -DHAS_K054539=1 -DHAS_UPD7759=1 -DHAS_MULTIPCM=1 -DHAS_YMF278B=1 -DHAS_MSM5232=1
CFLAGS += -DHAS_K053260=1 -DHAS_POKEY=1 -DHAS_HC55516=1 -DHAS_IREMGA20=1 -DHAS_MSM5205=1 -DHAS_C140=1
CFLAGS += -DHAS_BSMT2000=1 -DHAS_HD63701=1 -DHAS_CUSTOM=1 -DHAS_ADSP2100=1 -DHAS_ADSP2101=1 -DHAS_ADSP2115=1
CFLAGS += -DHAS_YMF262=1 -DHAS_YM2413=1 -DHAS_YM2608=1 -DHAS_VLM5030=1 -DHAS_MPEG=1 -DHAS_N7751=1
CFLAGS += -DHAS_PIC16C54=1 -DHAS_PIC16C55=1 -DHAS_PIC16C56=1 -DHAS_PIC16C57=1 -DHAS_PIC16C58=1
CFLAGS += -DHAS_C352=1 -DHAS_YMF271=1 -DHAS_SCSP=1 -DHAS_Y8950=1 -DHAS_ADSP2104=1 -DPATHSEP="/" 
#-DPTR64
# non-"core" defines
CFLAGS += -DPS2=0 -DM1=1 -DUNIX=1 -DNDEBUG=1  -Wno-error
#CFLAGS += -DUSE_DRZ80
CFLAGS += -DUSE_Z80

#LOCAL_C_INCLUDES += $(LOCAL_PATH) $(LOCAL_PATH)/cpu $(LOCAL_PATH)/M1/cpu/drz80 $(LOCAL_PATH)/M1/cpu/cyclone68k $(LOCAL_PATH)/sound $(LOCAL_PATH)/boards $(LOCAL_PATH)/mpeg $(LOCAL_PATH)/expat $(LOCAL_PATH)/zlib 
CFLAGS += -IM1/. -IM1/.. -IM1/cpu -IM1/../cpu -IM1/sound -IM1/../sound -IM1/boards 
CFLAGS += -IM1/../boards -IM1/mpeg -IM1/../mpeg -IM1/expat -IM1/../expat -Wall -IM1/zlib -IM1/../zlib
CFLAGS += -I$(NACL_SDK_ROOT)/include
#CFLAGS += `pkg-config --cflags libpulse` `sdl-config --cflags`

# m1 core objects
SOURCES = M1/m1snd.cpp M1/unzip.c M1/timer.c M1/wavelog.cpp M1/rom.c M1/irem_cpu.cpp
SOURCES += M1/6821pia.c M1/cpuintrf.c M1/sndintrf.c M1/state.c M1/taitosnd.c M1/kabuki.cpp M1/memory.c
SOURCES += M1/trklist.cpp M1/m1queue.cpp M1/m1filter.cpp M1/xmlout.cpp 
SOURCES += M1/chd.c M1/chdcd.c M1/harddisk.c M1/md5.c M1/sha1.c M1/gamelist.cpp

# MPEG decoder objects

SOURCES += M1/mpeg/dump.c M1/mpeg/getbits.c M1/mpeg/getdata.c M1/mpeg/huffman.c M1/mpeg/layer2.c 
SOURCES += M1/mpeg/layer3.c M1/mpeg/misc2.c M1/mpeg/position.c M1/mpeg/transform.c M1/mpeg/util.c M1/mpeg/audio.c

# Zlib objects (avoids dynamic link, allowing use with .NET / Mono)

SOURCES += M1/zlib/adler32.c M1/zlib/compress.c M1/zlib/crc32.c M1/zlib/gzio.c M1/zlib/uncompr.c M1/zlib/deflate.c M1/zlib/trees.c
SOURCES += M1/zlib/zutil.c M1/zlib/inflate.c M1/zlib/infback.c M1/zlib/inftrees.c M1/zlib/inffast.c

# Expat XML parser lib objects

SOURCES += M1/expat/xmlparse.c M1/expat/xmlrole.c M1/expat/xmltok.c



# Boards (drivers)
SOURCES += M1/boards/brd_raiden2.cpp M1/boards/brd_segapcm.cpp M1/boards/brd_taifx1.cpp M1/boards/brd_multi32.cpp 
SOURCES += M1/boards/brd_sys1832.cpp M1/boards/brd_hcastle.cpp M1/boards/brd_segamodel1.cpp M1/boards/brd_cps1.cpp M1/boards/brd_gradius3.cpp 
SOURCES += M1/boards/brd_twin16.cpp M1/boards/brd_qsound.cpp M1/boards/brd_xexex.cpp M1/boards/brd_bubblebobble.cpp M1/boards/brd_parodius.cpp
SOURCES += M1/boards/brd_namsys21.cpp M1/boards/brd_overdrive.cpp M1/boards/brd_contra.cpp M1/boards/brd_gradius.cpp M1/boards/brd_gx.cpp
SOURCES += M1/boards/brd_gyruss.cpp M1/boards/brd_btime.cpp M1/boards/brd_atarisy1.cpp M1/boards/brd_atarisy2.cpp M1/boards/brd_itech32.cpp
SOURCES += M1/boards/brd_f3.cpp M1/boards/brd_gauntlet.cpp M1/boards/brd_gng.cpp M1/boards/brd_starwars.cpp M1/boards/brd_mpatrol.cpp 
SOURCES += M1/boards/brd_macrossplus.cpp M1/boards/brd_braveblade.cpp M1/boards/brd_s1945.cpp
SOURCES += M1/boards/brd_dbz2.cpp M1/boards/brd_null.cpp M1/boards/brd_sharrier.cpp M1/boards/brd_endurobl2.cpp
SOURCES += M1/boards/brd_neogeo.cpp M1/boards/brd_megasys1.cpp M1/boards/brd_ssio.cpp
SOURCES += M1/boards/brd_1942.cpp M1/boards/brd_bjack.cpp M1/boards/brd_88games.cpp M1/boards/brd_sys16.cpp
SOURCES += M1/boards/brd_m72.cpp M1/boards/brd_m92.cpp M1/boards/brd_dcs.cpp M1/boards/brd_chipsqueakdeluxe.cpp
SOURCES += M1/boards/brd_deco8.cpp M1/boards/brd_scsp.cpp M1/boards/brd_wmscvsd.cpp M1/boards/brd_wmsadpcm.cpp 
SOURCES += M1/boards/brd_btoads.cpp M1/boards/brd_lemmings.cpp M1/boards/brd_sidepck.cpp
SOURCES += M1/boards/brd_segasys1.cpp M1/boards/brd_atarijsa.cpp M1/boards/brd_cavez80.cpp M1/boards/brd_sf1.cpp
SOURCES += M1/boards/brd_darius.cpp M1/boards/brd_namsys1.cpp M1/boards/brd_ms32.cpp M1/boards/brd_sun16.cpp
SOURCES += M1/boards/brd_frogger.cpp M1/boards/brd_blzntrnd.cpp M1/boards/brd_ddragon.cpp
SOURCES += M1/boards/brd_magiccat.cpp M1/boards/brd_raizing.cpp M1/boards/brd_ddragon3.cpp M1/boards/brd_tatass.cpp
SOURCES += M1/boards/brd_aquarium.cpp M1/boards/brd_djboy.cpp M1/boards/brd_deco32.cpp M1/boards/brd_skns.cpp
SOURCES += M1/boards/brd_fcombat.cpp M1/boards/brd_legion.cpp M1/boards/brd_dooyong.cpp M1/boards/brd_afega.cpp
SOURCES += M1/boards/brd_nmk16.cpp M1/boards/brd_namsys86.cpp M1/boards/brd_sshang.cpp M1/boards/brd_mappy.cpp
SOURCES += M1/boards/brd_galaga.cpp M1/boards/brd_airbustr.cpp M1/boards/brd_toaplan1.cpp M1/boards/brd_segac2.cpp
SOURCES += M1/boards/brd_cischeat.cpp M1/boards/brd_harddriv.cpp M1/boards/brd_flower.cpp M1/boards/brd_oneshot.cpp
SOURCES += M1/boards/brd_rastan.cpp M1/boards/brd_tecmosys.cpp M1/boards/brd_ssys22.cpp M1/boards/brd_tail2nose.cpp
SOURCES += M1/boards/brd_ajax.cpp M1/boards/brd_nslash.cpp M1/boards/brd_njgaiden.cpp M1/boards/brd_jedi.cpp
SOURCES += M1/boards/brd_dsb.cpp M1/boards/brd_wecleman.cpp M1/boards/brd_dsbz80.cpp M1/boards/brd_bottom9.cpp
SOURCES += M1/boards/brd_tnzs.cpp M1/boards/brd_rushcrash.cpp M1/boards/brd_tecmo16.cpp M1/boards/brd_combatsc.cpp
SOURCES += M1/boards/brd_circusc.cpp M1/boards/brd_bladestl.cpp M1/boards/brd_renegade.cpp M1/boards/brd_rygar.cpp
SOURCES += M1/boards/brd_namh8.cpp  M1/boards/brd_hotrock.cpp M1/boards/brd_psychic5.cpp M1/boards/brd_spi.cpp
SOURCES += M1/boards/brd_fuuki32.cpp M1/boards/brd_slapfight.cpp M1/boards/brd_douni.cpp 
SOURCES += M1/boards/brd_cage.cpp M1/boards/brd_airgallet.cpp M1/boards/brd_gott3.cpp M1/boards/brd_hatch.cpp
SOURCES += M1/boards/brd_psycho.cpp M1/boards/brd_mnight.cpp M1/boards/brd_logicpro.cpp M1/boards/brd_gladiator.cpp
SOURCES += M1/boards/brd_thunder.cpp M1/boards/brd_taitosj.cpp M1/boards/brd_beatmania.cpp M1/boards/brd_pizza.cpp
SOURCES += M1/boards/brd_rallyx.cpp M1/boards/brd_yunsun.cpp M1/boards/brd_bbusters.cpp M1/boards/brd_snk68k.cpp
SOURCES += M1/boards/brd_buggyboy.cpp M1/boards/brd_spacegun.cpp M1/boards/brd_hyperduel.cpp
SOURCES += M1/boards/brd_equites.cpp M1/boards/brd_taito84.cpp M1/boards/brd_tatsumi.cpp M1/boards/brd_namcona.cpp
SOURCES += M1/boards/brd_genesis.cpp M1/boards/brd_jaleco.cpp M1/boards/brd_panicr.cpp M1/boards/brd_mitchell.cpp
SOURCES += M1/boards/brd_arkanoid.cpp M1/boards/brd_hexion.cpp

# Sound cores
SOURCES += M1/sound/fm.c M1/sound/multipcm.c M1/sound/scsp.c M1/sound/segapcm.c M1/sound/scspdsp.c
SOURCES += M1/sound/ym2151.c M1/sound/rf5c68.c M1/sound/ay8910.c M1/sound/ymdeltat.c M1/sound/fmopl.c
SOURCES += M1/sound/k054539.c M1/sound/k053260.c M1/sound/ymf278b.c M1/sound/c140.c M1/sound/tms57002.c 
SOURCES += M1/sound/upd7759.c M1/sound/samples.c M1/sound/dac.c M1/sound/pokey.c M1/sound/es5506.c
SOURCES += M1/sound/adpcm.c M1/sound/k007232.c M1/sound/qsound.c M1/sound/msm5205.c M1/sound/tms5220.c
SOURCES += M1/sound/5220intf.c M1/sound/iremga20.c M1/sound/streams.c M1/sound/hc55516.c
SOURCES += M1/sound/bsmt2000.c M1/sound/k005289.c M1/sound/sn76496.c M1/sound/namco.c M1/sound/cem3394.c
SOURCES += M1/sound/ymz280b.c M1/sound/2203intf.c M1/sound/2610intf.c M1/sound/2612intf.c M1/sound/3812intf.c
SOURCES += M1/sound/k051649.c M1/sound/2151intf.c M1/sound/flower.c M1/sound/ym2413.c M1/sound/2413intf.c
SOURCES += M1/sound/2608intf.c M1/sound/vlm5030.c M1/sound/262intf.c M1/sound/ymf262.c M1/sound/c352.c M1/sound/ymf271.c
SOURCES += M1/sound/dmadac.c M1/sound/rf5c400.c M1/sound/msm5232.c

# CPU cores
SOURCES += M1/cpu/m68kcpu.c M1/cpu/m68kops.c
SOURCES += M1/cpu/m6800.c M1/cpu/m6809.c M1/cpu/m6502.c M1/cpu/h6280.c M1/cpu/i8039.c M1/cpu/nec.c
SOURCES += M1/cpu/adsp2100.c M1/cpu/m37710.c M1/cpu/m37710o0.c M1/cpu/m37710o1.c
SOURCES += M1/cpu/m37710o2.c M1/cpu/m37710o3.c M1/cpu/hd6309.c M1/cpu/tms32010.c M1/cpu/pic16c5x.c
SOURCES += M1/cpu/h83002.c M1/cpu/h8periph.c M1/cpu/tms32031.c M1/cpu/2100dasm.c
SOURCES += M1/cpu/i8085.c
SOURCES += M1/cpu/z80.c 

# asm cores
#SOURCES += M1/cpu/drz80/drz80.S M1/cpu/drz80/drz80_z80.cpp
#SOURCES += M1/cpu/cyclone68k/cyclone.S M1/cpu/cyclone68k/c68000.cpp

# android stuff
#SOURCES += M1Native.c
#SOURCES += m1sdr_android.cpp 

# NaCl stuff
SOURCES += SaltyM1.c

# Build rules generated by macros from common.mk:

$(foreach src,$(SOURCES),$(eval $(call COMPILE_RULE,$(src),$(CFLAGS))))

ifeq ($(CONFIG),Release)
$(eval $(call LINK_RULE,$(TARGET)_unstripped,$(SOURCES),$(LIBS),$(DEPS)))
$(eval $(call STRIP_RULE,$(TARGET),$(TARGET)_unstripped))
else
$(eval $(call LINK_RULE,$(TARGET),$(SOURCES),$(LIBS),$(DEPS)))
endif

$(eval $(call NMF_RULE,$(TARGET),))