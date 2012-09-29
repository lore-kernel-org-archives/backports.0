Return-Path: <mcgrof@gmail.com>
Sender: "Luis R. Rodriguez" <mcgrof@gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 5/5] compat-drivers: enable DRM drivers compilation
Date: Fri, 28 Sep 2012 23:54:46 -0700
Message-Id: <1348901686-15036-6-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1348901686-15036-1-git-send-email-mcgrof@do-not-panic.com>
References: <1348901686-15036-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Ozan Çağlayan had done most of the work to suck in all
the DRM drivers but left out the enablement of compiling
the drm drivers. The DRM drivers were also not load
tested. This patch enables to test compilation by
renaming the DRM Kconfig options with a _COMPAT prefix
and enables compilation by default for the i915 drm
driver which I can test against at run time on my
laptop running on v3.2.

Users and developer can help enable older kernels
down to 3.0 (as this was the oldest supported target
kernel for DRM drivers) or other DRM drivers as they
are run time tested.

The admin-update.sh script is modified to now always
run by including the DRM code and patching it accordingly.
If you happen to only want networking code you can do so
by supplying the network argument to the script as follows:

./scripts/adming-update.sh network

This will disable taking in DRM code.

It should be noted that although only the i915 drm driver
is being enabled all other drivers except the following have
been test compiled to work down to v3.0.

-obj-$(CONFIG_COMPAT_DRM_TDFX)  += tdfx/
-obj-$(CONFIG_COMPAT_DRM_R128)  += r128/
-obj-$(CONFIG_COMPAT_DRM_MGA)   += mga/
-obj-$(CONFIG_COMPAT_DRM_SIS)   += sis/
-obj-$(CONFIG_COMPAT_DRM_SAVAGE)+= savage/
-obj-$(CONFIG_COMPAT_DRM_EXYNOS) +=exynos/
-obj-$(CONFIG_COMPAT_DRM_UDL) += udl/

Apart from the above drivers we should be able to enable the
other drivers as reports come in for run time testing on them.
As it is right now only the i915 goes run time tested -- by me.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 Makefile                                   |    1 +
 config.mk                                  |    9 +++-
 patches/drm/06-rename-config-options.patch |   77 ++++++++++++++++++++++++++++
 patches/drm/99-change-makefile.patch       |   44 ++++++++--------
 scripts/admin-update.sh                    |    3 +-
 scripts/driver-select                      |   28 ++++++++++
 6 files changed, 138 insertions(+), 24 deletions(-)
 create mode 100644 patches/drm/06-rename-config-options.patch

diff --git a/Makefile b/Makefile
index e3c3fa6..6aa03c7 100644
--- a/Makefile
+++ b/Makefile
@@ -40,6 +40,7 @@ NOSTDINC_FLAGS := \
 obj-y := compat/
 
 obj-$(CONFIG_COMPAT_RFKILL) += net/rfkill/
+obj-$(CONFIG_COMPAT_VIDEO_MODULES) += drivers/gpu/drm/
 
 ifeq ($(BT),)
 obj-$(CONFIG_COMPAT_WIRELESS) += net/wireless/ net/mac80211/
diff --git a/config.mk b/config.mk
index 165a6ad..c3872b1 100644
--- a/config.mk
+++ b/config.mk
@@ -17,7 +17,6 @@ else
 KERNEL_26SUBLEVEL := $(shell $(MAKE) -C $(KLIB_BUILD) kernelversion | sed -n 's/^2\.6\.\([0-9]\+\).*/\1/p')
 endif
 
-# FIXME: This lower limit is different (e.g. 3.0) for DRM stuff.
 ifdef CONFIG_COMPAT_KERNEL_2_6_24
 $(error "ERROR: compat-drivers by default supports kernels >= 2.6.24, try enabling only one driver though")
 endif #CONFIG_COMPAT_KERNEL_2_6_24
@@ -697,3 +696,11 @@ endif #CONFIG_LEDS_TRIGGERS
 export CONFIG_RFKILL_BACKPORT_INPUT=y
 endif #CONFIG_COMPAT_KERNEL_2_6_31
 
+# compilation has been tested down to 3.0 but run time
+# tests have only started on 3.2.
+ifndef CONFIG_COMPAT_KERNEL_3_2
+export CONFIG_COMPAT_VIDEO_MODULES=y
+export CONFIG_COMPAT_DRM=m
+export CONFIG_COMPAT_DRM_I915=m
+export CONFIG_COMPAT_DRM_KMS_HELPER=m
+endif #CONFIG_COMPAT_KERNEL_3_2
diff --git a/patches/drm/06-rename-config-options.patch b/patches/drm/06-rename-config-options.patch
new file mode 100644
index 0000000..1096fce
--- /dev/null
+++ b/patches/drm/06-rename-config-options.patch
@@ -0,0 +1,77 @@
+--- a/drivers/gpu/drm/Makefile
++++ b/drivers/gpu/drm/Makefile
+@@ -15,37 +15,37 @@ drm-y       :=	drm_auth.o drm_buffer.o d
+ 		drm_trace_points.o drm_global.o drm_prime.o
+ 
+ drm-$(CONFIG_COMPAT) += drm_ioc32.o
+-drm-$(CONFIG_DRM_GEM_CMA_HELPER) += drm_gem_cma_helper.o
++drm-$(CONFIG_COMPAT_DRM_GEM_CMA_HELPER) += drm_gem_cma_helper.o
+ 
+ drm-usb-y   := drm_usb.o
+ 
+ drm_kms_helper-y := drm_fb_helper.o drm_crtc_helper.o drm_dp_i2c_helper.o
+-drm_kms_helper-$(CONFIG_DRM_LOAD_EDID_FIRMWARE) += drm_edid_load.o
+-drm_kms_helper-$(CONFIG_DRM_KMS_CMA_HELPER) += drm_fb_cma_helper.o
++drm_kms_helper-$(CONFIG_COMPAT_DRM_LOAD_EDID_FIRMWARE) += drm_edid_load.o
++drm_kms_helper-$(CONFIG_COMPAT_DRM_KMS_CMA_HELPER) += drm_fb_cma_helper.o
+ 
+-obj-$(CONFIG_DRM_KMS_HELPER) += drm_kms_helper.o
++obj-$(CONFIG_COMPAT_DRM_KMS_HELPER) += drm_kms_helper.o
+ 
+ CFLAGS_drm_trace_points.o := -I$(src)
+ 
+-obj-$(CONFIG_DRM)	+= drm.o
+-obj-$(CONFIG_DRM_USB)   += drm_usb.o
+-obj-$(CONFIG_DRM_TTM)	+= ttm/
+-obj-$(CONFIG_DRM_TDFX)	+= tdfx/
+-obj-$(CONFIG_DRM_R128)	+= r128/
+-obj-$(CONFIG_DRM_RADEON)+= radeon/
+-obj-$(CONFIG_DRM_MGA)	+= mga/
+-obj-$(CONFIG_DRM_I810)	+= i810/
+-obj-$(CONFIG_DRM_I915)  += i915/
+-obj-$(CONFIG_DRM_MGAG200) += mgag200/
+-obj-$(CONFIG_DRM_CIRRUS_QEMU) += cirrus/
+-obj-$(CONFIG_DRM_SIS)   += sis/
+-obj-$(CONFIG_DRM_SAVAGE)+= savage/
+-obj-$(CONFIG_DRM_VMWGFX)+= vmwgfx/
+-obj-$(CONFIG_DRM_VIA)	+=via/
+-obj-$(CONFIG_DRM_NOUVEAU) +=nouveau/
+-obj-$(CONFIG_DRM_EXYNOS) +=exynos/
+-obj-$(CONFIG_DRM_GMA500) += gma500/
+-obj-$(CONFIG_DRM_UDL) += udl/
+-obj-$(CONFIG_DRM_AST) += ast/
+-obj-$(CONFIG_DRM_SHMOBILE) +=shmobile/
++obj-$(CONFIG_COMPAT_DRM)	+= drm.o
++obj-$(CONFIG_COMPAT_DRM_USB)   += drm_usb.o
++obj-$(CONFIG_COMPAT_DRM_TTM)	+= ttm/
++obj-$(CONFIG_COMPAT_DRM_TDFX)	+= tdfx/
++obj-$(CONFIG_COMPAT_DRM_R128)	+= r128/
++obj-$(CONFIG_COMPAT_DRM_RADEON)+= radeon/
++obj-$(CONFIG_COMPAT_DRM_MGA)	+= mga/
++obj-$(CONFIG_COMPAT_DRM_I810)	+= i810/
++obj-$(CONFIG_COMPAT_DRM_I915)  += i915/
++obj-$(CONFIG_COMPAT_DRM_MGAG200) += mgag200/
++obj-$(CONFIG_COMPAT_DRM_CIRRUS_QEMU) += cirrus/
++obj-$(CONFIG_COMPAT_DRM_SIS)   += sis/
++obj-$(CONFIG_COMPAT_DRM_SAVAGE)+= savage/
++obj-$(CONFIG_COMPAT_DRM_VMWGFX)+= vmwgfx/
++obj-$(CONFIG_COMPAT_DRM_VIA)	+=via/
++obj-$(CONFIG_COMPAT_DRM_NOUVEAU) +=nouveau/
++obj-$(CONFIG_COMPAT_DRM_EXYNOS) +=exynos/
++obj-$(CONFIG_COMPAT_DRM_GMA500) += gma500/
++obj-$(CONFIG_COMPAT_DRM_UDL) += udl/
++obj-$(CONFIG_COMPAT_DRM_AST) += ast/
++obj-$(CONFIG_COMPAT_DRM_SHMOBILE) +=shmobile/
+ obj-y			+= i2c/
+--- a/drivers/gpu/drm/i2c/Makefile
++++ b/drivers/gpu/drm/i2c/Makefile
+@@ -1,7 +1,7 @@
+ ccflags-y := -Iinclude/drm
+ 
+ ch7006-y := ch7006_drv.o ch7006_mode.o
+-obj-$(CONFIG_DRM_I2C_CH7006) += ch7006.o
++obj-$(CONFIG_COMPAT_DRM_I2C_CH7006) += ch7006.o
+ 
+ sil164-y := sil164_drv.o
+-obj-$(CONFIG_DRM_I2C_SIL164) += sil164.o
++obj-$(CONFIG_COMPAT_DRM_I2C_SIL164) += sil164.o
diff --git a/patches/drm/99-change-makefile.patch b/patches/drm/99-change-makefile.patch
index 70b8e15..840ce62 100644
--- a/patches/drm/99-change-makefile.patch
+++ b/patches/drm/99-change-makefile.patch
@@ -2,26 +2,26 @@ Remove drivers that we do not want to build from gpu/drm/Makefile
 
 --- a/drivers/gpu/drm/Makefile
 +++ b/drivers/gpu/drm/Makefile
-@@ -30,22 +30,15 @@ CFLAGS_drm_trace_points.o := -I$(src)
- obj-$(CONFIG_DRM)	+= drm.o
- obj-$(CONFIG_DRM_USB)   += drm_usb.o
- obj-$(CONFIG_DRM_TTM)	+= ttm/
--obj-$(CONFIG_DRM_TDFX)	+= tdfx/
--obj-$(CONFIG_DRM_R128)	+= r128/
- obj-$(CONFIG_DRM_RADEON)+= radeon/
--obj-$(CONFIG_DRM_MGA)	+= mga/
- obj-$(CONFIG_DRM_I810)	+= i810/
- obj-$(CONFIG_DRM_I915)  += i915/
- obj-$(CONFIG_DRM_MGAG200) += mgag200/
- obj-$(CONFIG_DRM_CIRRUS_QEMU) += cirrus/
--obj-$(CONFIG_DRM_SIS)   += sis/
--obj-$(CONFIG_DRM_SAVAGE)+= savage/
- obj-$(CONFIG_DRM_VMWGFX)+= vmwgfx/
- obj-$(CONFIG_DRM_VIA)	+=via/
- obj-$(CONFIG_DRM_NOUVEAU) +=nouveau/
--obj-$(CONFIG_DRM_EXYNOS) +=exynos/
- obj-$(CONFIG_DRM_GMA500) += gma500/
--obj-$(CONFIG_DRM_UDL) += udl/
- obj-$(CONFIG_DRM_AST) += ast/
- obj-$(CONFIG_DRM_SHMOBILE) +=shmobile/
+@@ -30,22 +30,14 @@ CFLAGS_drm_trace_points.o := -I$(src)
+ obj-$(CONFIG_COMPAT_DRM)	+= drm.o
+ obj-$(CONFIG_COMPAT_DRM_USB)   += drm_usb.o
+ obj-$(CONFIG_COMPAT_DRM_TTM)	+= ttm/
+-obj-$(CONFIG_COMPAT_DRM_TDFX)	+= tdfx/
+-obj-$(CONFIG_COMPAT_DRM_R128)	+= r128/
+ obj-$(CONFIG_COMPAT_DRM_RADEON)+= radeon/
+-obj-$(CONFIG_COMPAT_DRM_MGA)	+= mga/
+ obj-$(CONFIG_COMPAT_DRM_I810)	+= i810/
+ obj-$(CONFIG_COMPAT_DRM_I915)  += i915/
+ obj-$(CONFIG_COMPAT_DRM_MGAG200) += mgag200/
+ obj-$(CONFIG_COMPAT_DRM_CIRRUS_QEMU) += cirrus/
+-obj-$(CONFIG_COMPAT_DRM_SIS)   += sis/
+-obj-$(CONFIG_COMPAT_DRM_SAVAGE)+= savage/
+ obj-$(CONFIG_COMPAT_DRM_VMWGFX)+= vmwgfx/
+ obj-$(CONFIG_COMPAT_DRM_VIA)	+=via/
+ obj-$(CONFIG_COMPAT_DRM_NOUVEAU) +=nouveau/
+-obj-$(CONFIG_COMPAT_DRM_EXYNOS) +=exynos/
+ obj-$(CONFIG_COMPAT_DRM_GMA500) += gma500/
+-obj-$(CONFIG_COMPAT_DRM_UDL) += udl/
+ obj-$(CONFIG_COMPAT_DRM_AST) += ast/
+-obj-$(CONFIG_COMPAT_DRM_SHMOBILE) +=shmobile/
  obj-y			+= i2c/
diff --git a/scripts/admin-update.sh b/scripts/admin-update.sh
index 2deb0a4..01ebd2d 100755
--- a/scripts/admin-update.sh
+++ b/scripts/admin-update.sh
@@ -202,7 +202,7 @@ copyDirectories() {
 # compatibility with compat-wireless, wlan/bt/eth drivers are
 # fetched in by default.
 ENABLE_NETWORK=1
-ENABLE_DRM=0
+ENABLE_DRM=1
 SUBSYSTEMS=
 
 EXTRA_PATCHES="patches"
@@ -244,6 +244,7 @@ if [ $# -ge 1 ]; then
 				;;
 			"network")
 				ENABLE_NETWORK=1
+				ENABLE_DRM=0
 				shift
 				;;
 			"drm")
diff --git a/scripts/driver-select b/scripts/driver-select
index 0076f62..640f9fa 100755
--- a/scripts/driver-select
+++ b/scripts/driver-select
@@ -41,6 +41,8 @@ SUPPORTED_80211_DRIVERS="ath5k ath9k ath9k_ap ath9k_htc carl9170 ath6kl wil6210
 # what if you update b44 but not b43? It will bust.
 SUPPORTED_ETH_DRIVERS="atl1 atl2 atl1e atl1c alx"
 
+SUPPORTED_DRM_DRIVERS="i915"
+
 function usage {
 	echo -e "${GREEN}Usage${NORMAL}: ${BOLD}$0${NORMAL} [ ${PURPLE}<driver-name>${NORMAL} | ${CYAN}<driver-group-name>${NORMAL} | ${GREEN}restore${NORMAL} ]"
 
@@ -56,6 +58,11 @@ function usage {
 		echo -e "\t${PURPLE}${i}${NORMAL}"
 	done
 
+	echo -e "Supported DRM drivers:"
+	for i in $SUPPORTED_DRM_DRIVERS; do
+		echo -e "\t${PURPLE}${i}${NORMAL}"
+	done
+
 	# These should match the switch below.
 	echo -e "\nSupported group drivers:"
 	echo -e "\t${CYAN}atheros${NORMAL} < ${PURPLE} ath5k ath9k carl9170 zd1211rw ath6kl wil6210${NORMAL}>"
@@ -70,6 +77,9 @@ function usage {
 	echo -e "\t${CYAN}atlxx${NORMAL} < ${PURPLE} atl1 atl2 atl1e alx${NORMAL}>"
 	echo -e "\t${CYAN}bt${NORMAL} < ${PURPLE} Linux bluetooth drivers ${NORMAL}>"
 
+	echo -e "\nSupported group drivers: DRM:"
+	echo -e "\t${CYAN}drm${NORMAL} < ${PURPLE} i915${NORMAL}>"
+
 	echo -e "Restoring compat-drivers:"
 	echo -e "\t${GREEN}restore${NORMAL}: you can use this option to restore compat-drivers to the original state"
 }
@@ -233,6 +243,18 @@ function disable_update-initramfs
 	perl -i -ne 'print if ! /update-initramfs/' Makefile
 }
 
+function enable_only_drm {
+	backup_file Makefile
+	disable_ethernet
+	disable_staging
+	disable_usbnet
+	disable_var_03
+	disable_bt
+	# rfkill may be needed if you enable b44 as you may have b43
+	disable_rfkill
+	disable_80211
+}
+
 function select_ath_driver 
 {
 	backup_file $ATH_MAKEFILE
@@ -510,6 +532,12 @@ case $1 in
 		disable_staging
 		disable_80211
 		;;
+	i915)
+		enable_only_drm
+		;;
+	drm)
+		enable_only_drm
+		;;
 	*)
 		echo "Unsupported driver"
 		exit
-- 
1.7.10.4
