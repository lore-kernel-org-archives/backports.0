Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <ozancag@gmail.com>
From: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
To: backports@vger.kernel.org
Cc: mcgrof@kernel.org,
	=?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
Subject: [PATCH 4/5] compat-drivers: Move around patches and selectively apply them
Date: Tue, 21 Aug 2012 19:34:54 +0300
Message-Id: <1345566895-22001-4-git-send-email-ozancag@gmail.com>
In-Reply-To: <1345566895-22001-1-git-send-email-ozancag@gmail.com>
References: <1345566895-22001-1-git-send-email-ozancag@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

Put wlan/bt/eth related patches under network/ subdirectories. Apply them
only if the network subsystem is enabled (For now, it is enabled by default).

Create empty network/ placeholders under patch directories.

Signed-off-by: Ozan Çağlayan <ozancag@gmail.com>
---
 ...-QCA-ethernet-driver-which-supercedes-atl.patch |  0
 crap/{ => network}/0002-backport-alx.patch         |  0
 .../0003-remove-atl1c-devices-from-alx.patch       |  0
 ...s-adds-the-802.11ad-60-GHz-wil6210-driver.patch |  0
 patches/{ => network}/0001-netdev_ops.patch        |  0
 patches/{ => network}/0002-net-misc.patch          |  0
 .../0003-netdev-needed_headroom_tailroom.patch     |  0
 patches/{ => network}/0004-wext-namespace.patch    |  0
 patches/{ => network}/02-ksize.patch               |  0
 patches/{ => network}/03-rfkill.patch              |  0
 patches/{ => network}/04-netns.patch               |  0
 patches/{ => network}/05-usb.patch                 |  0
 patches/{ => network}/06-header-changes.patch      |  0
 .../{ => network}/07-change-default-rate-alg.patch |  0
 .../{ => network}/08-rename-config-options.patch   |  0
 .../{ => network}/09-cfg80211-wext-padding.patch   |  0
 patches/{ => network}/09-threaded-irq.patch        |  0
 .../10-add-wext-handlers-to-netdev.patch           |  0
 patches/{ => network}/11-dev-pm-ops.patch          |  0
 patches/{ => network}/12-iw_handler-changes.patch  |  0
 .../12-mac80211-disable-tx-status.patch            |  0
 patches/{ => network}/14-device-type.patch         |  0
 .../{ => network}/15-symbol-export-conflicts.patch |  0
 patches/{ => network}/16-bluetooth.patch           |  0
 patches/{ => network}/17-netdev-queue.patch        |  0
 .../{ => network}/18-rename-usb-net-symbols.patch  |  0
 patches/{ => network}/21-capi-proc_fops.patch      |  0
 patches/{ => network}/22-multiqueue.patch          |  0
 patches/{ => network}/24-pcmcia.patch              |  0
 patches/{ => network}/25-multicast-list_head.patch |  0
 patches/{ => network}/26-sdio-quirks.patch         |  0
 .../27-hermes-read-pda-conflict.patch              |  0
 patches/{ => network}/29-sdio_no_suspend.patch     |  0
 patches/{ => network}/30-bridge-port.patch         |  0
 patches/{ => network}/32-remove-ns-type.patch      |  0
 .../{ => network}/35-fix-makefile-includes.patch   |  0
 patches/{ => network}/36-workqueue.patch           |  0
 patches/{ => network}/37-vsnprintk.patch           |  0
 patches/{ => network}/38-led-max-brightness.patch  |  0
 patches/{ => network}/39-remove_blink_set.patch    |  0
 patches/{ => network}/40-netdev-hw-features.patch  |  0
 patches/{ => network}/42-netlink_seq.patch         |  0
 .../{ => network}/43-rename_pm_qos_request.patch   |  0
 .../44-deactivate-mac80211-tracing.patch           |  0
 .../45-remove-platform-id-table.patch              |  0
 patches/{ => network}/46-use_other_workqueue.patch |  0
 .../47-no_trans_start_on_netdev_queue.patch        |  0
 .../48-use_skb_get_queue_mapping.patch             |  0
 .../{ => network}/50-libertas-olpc-ec-wakeup.patch |  0
 patches/{ => network}/52-tty-dev.patch             |  0
 patches/{ => network}/53-pr_fmt.patch              |  0
 patches/{ => network}/54-get_ts_info.patch         |  0
 .../{ => network}/55-iwlwifi-msg-trace-fix.patch   |  0
 patches/{ => network}/56-mac80211-trace-fix.patch  |  0
 patches/{ => network}/57-iwlwifi-debug-fix.patch   |  0
 .../{ => network}/61-netdev-addr_assign_type.patch |  0
 patches/{ => network}/62-usb_driver_lpm.patch      |  0
 patches/{ => network}/63-tty-termios.patch         |  0
 patches/{ => network}/64-b44-32bit-stats.patch     |  0
 patches/{ => network}/65-ignore-dismantle.patch    |  0
 patches/{ => network}/99-change-makefiles.patch    |  0
 scripts/admin-update.sh                            | 63 +++++++++++++---------
 62 files changed, 39 insertions(+), 24 deletions(-)
 rename crap/{ => network}/0001-alx-add-new-QCA-ethernet-driver-which-supercedes-atl.patch (100%)
 rename crap/{ => network}/0002-backport-alx.patch (100%)
 rename crap/{ => network}/0003-remove-atl1c-devices-from-alx.patch (100%)
 rename crap/{ => network}/0004-wireless-adds-the-802.11ad-60-GHz-wil6210-driver.patch (100%)
 create mode 100644 linux-next-cherry-picks/network/.gitignore
 create mode 100644 linux-next-pending/network/.gitignore
 rename patches/{ => network}/0001-netdev_ops.patch (100%)
 rename patches/{ => network}/0002-net-misc.patch (100%)
 rename patches/{ => network}/0003-netdev-needed_headroom_tailroom.patch (100%)
 rename patches/{ => network}/0004-wext-namespace.patch (100%)
 rename patches/{ => network}/02-ksize.patch (100%)
 rename patches/{ => network}/03-rfkill.patch (100%)
 rename patches/{ => network}/04-netns.patch (100%)
 rename patches/{ => network}/05-usb.patch (100%)
 rename patches/{ => network}/06-header-changes.patch (100%)
 rename patches/{ => network}/07-change-default-rate-alg.patch (100%)
 rename patches/{ => network}/08-rename-config-options.patch (100%)
 rename patches/{ => network}/09-cfg80211-wext-padding.patch (100%)
 rename patches/{ => network}/09-threaded-irq.patch (100%)
 rename patches/{ => network}/10-add-wext-handlers-to-netdev.patch (100%)
 rename patches/{ => network}/11-dev-pm-ops.patch (100%)
 rename patches/{ => network}/12-iw_handler-changes.patch (100%)
 rename patches/{ => network}/12-mac80211-disable-tx-status.patch (100%)
 rename patches/{ => network}/14-device-type.patch (100%)
 rename patches/{ => network}/15-symbol-export-conflicts.patch (100%)
 rename patches/{ => network}/16-bluetooth.patch (100%)
 rename patches/{ => network}/17-netdev-queue.patch (100%)
 rename patches/{ => network}/18-rename-usb-net-symbols.patch (100%)
 rename patches/{ => network}/21-capi-proc_fops.patch (100%)
 rename patches/{ => network}/22-multiqueue.patch (100%)
 rename patches/{ => network}/24-pcmcia.patch (100%)
 rename patches/{ => network}/25-multicast-list_head.patch (100%)
 rename patches/{ => network}/26-sdio-quirks.patch (100%)
 rename patches/{ => network}/27-hermes-read-pda-conflict.patch (100%)
 rename patches/{ => network}/29-sdio_no_suspend.patch (100%)
 rename patches/{ => network}/30-bridge-port.patch (100%)
 rename patches/{ => network}/32-remove-ns-type.patch (100%)
 rename patches/{ => network}/35-fix-makefile-includes.patch (100%)
 rename patches/{ => network}/36-workqueue.patch (100%)
 rename patches/{ => network}/37-vsnprintk.patch (100%)
 rename patches/{ => network}/38-led-max-brightness.patch (100%)
 rename patches/{ => network}/39-remove_blink_set.patch (100%)
 rename patches/{ => network}/40-netdev-hw-features.patch (100%)
 rename patches/{ => network}/42-netlink_seq.patch (100%)
 rename patches/{ => network}/43-rename_pm_qos_request.patch (100%)
 rename patches/{ => network}/44-deactivate-mac80211-tracing.patch (100%)
 rename patches/{ => network}/45-remove-platform-id-table.patch (100%)
 rename patches/{ => network}/46-use_other_workqueue.patch (100%)
 rename patches/{ => network}/47-no_trans_start_on_netdev_queue.patch (100%)
 rename patches/{ => network}/48-use_skb_get_queue_mapping.patch (100%)
 rename patches/{ => network}/50-libertas-olpc-ec-wakeup.patch (100%)
 rename patches/{ => network}/52-tty-dev.patch (100%)
 rename patches/{ => network}/53-pr_fmt.patch (100%)
 rename patches/{ => network}/54-get_ts_info.patch (100%)
 rename patches/{ => network}/55-iwlwifi-msg-trace-fix.patch (100%)
 rename patches/{ => network}/56-mac80211-trace-fix.patch (100%)
 rename patches/{ => network}/57-iwlwifi-debug-fix.patch (100%)
 rename patches/{ => network}/61-netdev-addr_assign_type.patch (100%)
 rename patches/{ => network}/62-usb_driver_lpm.patch (100%)
 rename patches/{ => network}/63-tty-termios.patch (100%)
 rename patches/{ => network}/64-b44-32bit-stats.patch (100%)
 rename patches/{ => network}/65-ignore-dismantle.patch (100%)
 rename patches/{ => network}/99-change-makefiles.patch (100%)
 create mode 100644 pending-stable/network/.gitignore

diff --git a/crap/0001-alx-add-new-QCA-ethernet-driver-which-supercedes-atl.patch b/crap/network/0001-alx-add-new-QCA-ethernet-driver-which-supercedes-atl.patch
similarity index 100%
rename from crap/0001-alx-add-new-QCA-ethernet-driver-which-supercedes-atl.patch
rename to crap/network/0001-alx-add-new-QCA-ethernet-driver-which-supercedes-atl.patch
diff --git a/crap/0002-backport-alx.patch b/crap/network/0002-backport-alx.patch
similarity index 100%
rename from crap/0002-backport-alx.patch
rename to crap/network/0002-backport-alx.patch
diff --git a/crap/0003-remove-atl1c-devices-from-alx.patch b/crap/network/0003-remove-atl1c-devices-from-alx.patch
similarity index 100%
rename from crap/0003-remove-atl1c-devices-from-alx.patch
rename to crap/network/0003-remove-atl1c-devices-from-alx.patch
diff --git a/crap/0004-wireless-adds-the-802.11ad-60-GHz-wil6210-driver.patch b/crap/network/0004-wireless-adds-the-802.11ad-60-GHz-wil6210-driver.patch
similarity index 100%
rename from crap/0004-wireless-adds-the-802.11ad-60-GHz-wil6210-driver.patch
rename to crap/network/0004-wireless-adds-the-802.11ad-60-GHz-wil6210-driver.patch
diff --git a/linux-next-cherry-picks/network/.gitignore b/linux-next-cherry-picks/network/.gitignore
new file mode 100644
index 0000000..e69de29
diff --git a/linux-next-pending/network/.gitignore b/linux-next-pending/network/.gitignore
new file mode 100644
index 0000000..e69de29
diff --git a/patches/0001-netdev_ops.patch b/patches/network/0001-netdev_ops.patch
similarity index 100%
rename from patches/0001-netdev_ops.patch
rename to patches/network/0001-netdev_ops.patch
diff --git a/patches/0002-net-misc.patch b/patches/network/0002-net-misc.patch
similarity index 100%
rename from patches/0002-net-misc.patch
rename to patches/network/0002-net-misc.patch
diff --git a/patches/0003-netdev-needed_headroom_tailroom.patch b/patches/network/0003-netdev-needed_headroom_tailroom.patch
similarity index 100%
rename from patches/0003-netdev-needed_headroom_tailroom.patch
rename to patches/network/0003-netdev-needed_headroom_tailroom.patch
diff --git a/patches/0004-wext-namespace.patch b/patches/network/0004-wext-namespace.patch
similarity index 100%
rename from patches/0004-wext-namespace.patch
rename to patches/network/0004-wext-namespace.patch
diff --git a/patches/02-ksize.patch b/patches/network/02-ksize.patch
similarity index 100%
rename from patches/02-ksize.patch
rename to patches/network/02-ksize.patch
diff --git a/patches/03-rfkill.patch b/patches/network/03-rfkill.patch
similarity index 100%
rename from patches/03-rfkill.patch
rename to patches/network/03-rfkill.patch
diff --git a/patches/04-netns.patch b/patches/network/04-netns.patch
similarity index 100%
rename from patches/04-netns.patch
rename to patches/network/04-netns.patch
diff --git a/patches/05-usb.patch b/patches/network/05-usb.patch
similarity index 100%
rename from patches/05-usb.patch
rename to patches/network/05-usb.patch
diff --git a/patches/06-header-changes.patch b/patches/network/06-header-changes.patch
similarity index 100%
rename from patches/06-header-changes.patch
rename to patches/network/06-header-changes.patch
diff --git a/patches/07-change-default-rate-alg.patch b/patches/network/07-change-default-rate-alg.patch
similarity index 100%
rename from patches/07-change-default-rate-alg.patch
rename to patches/network/07-change-default-rate-alg.patch
diff --git a/patches/08-rename-config-options.patch b/patches/network/08-rename-config-options.patch
similarity index 100%
rename from patches/08-rename-config-options.patch
rename to patches/network/08-rename-config-options.patch
diff --git a/patches/09-cfg80211-wext-padding.patch b/patches/network/09-cfg80211-wext-padding.patch
similarity index 100%
rename from patches/09-cfg80211-wext-padding.patch
rename to patches/network/09-cfg80211-wext-padding.patch
diff --git a/patches/09-threaded-irq.patch b/patches/network/09-threaded-irq.patch
similarity index 100%
rename from patches/09-threaded-irq.patch
rename to patches/network/09-threaded-irq.patch
diff --git a/patches/10-add-wext-handlers-to-netdev.patch b/patches/network/10-add-wext-handlers-to-netdev.patch
similarity index 100%
rename from patches/10-add-wext-handlers-to-netdev.patch
rename to patches/network/10-add-wext-handlers-to-netdev.patch
diff --git a/patches/11-dev-pm-ops.patch b/patches/network/11-dev-pm-ops.patch
similarity index 100%
rename from patches/11-dev-pm-ops.patch
rename to patches/network/11-dev-pm-ops.patch
diff --git a/patches/12-iw_handler-changes.patch b/patches/network/12-iw_handler-changes.patch
similarity index 100%
rename from patches/12-iw_handler-changes.patch
rename to patches/network/12-iw_handler-changes.patch
diff --git a/patches/12-mac80211-disable-tx-status.patch b/patches/network/12-mac80211-disable-tx-status.patch
similarity index 100%
rename from patches/12-mac80211-disable-tx-status.patch
rename to patches/network/12-mac80211-disable-tx-status.patch
diff --git a/patches/14-device-type.patch b/patches/network/14-device-type.patch
similarity index 100%
rename from patches/14-device-type.patch
rename to patches/network/14-device-type.patch
diff --git a/patches/15-symbol-export-conflicts.patch b/patches/network/15-symbol-export-conflicts.patch
similarity index 100%
rename from patches/15-symbol-export-conflicts.patch
rename to patches/network/15-symbol-export-conflicts.patch
diff --git a/patches/16-bluetooth.patch b/patches/network/16-bluetooth.patch
similarity index 100%
rename from patches/16-bluetooth.patch
rename to patches/network/16-bluetooth.patch
diff --git a/patches/17-netdev-queue.patch b/patches/network/17-netdev-queue.patch
similarity index 100%
rename from patches/17-netdev-queue.patch
rename to patches/network/17-netdev-queue.patch
diff --git a/patches/18-rename-usb-net-symbols.patch b/patches/network/18-rename-usb-net-symbols.patch
similarity index 100%
rename from patches/18-rename-usb-net-symbols.patch
rename to patches/network/18-rename-usb-net-symbols.patch
diff --git a/patches/21-capi-proc_fops.patch b/patches/network/21-capi-proc_fops.patch
similarity index 100%
rename from patches/21-capi-proc_fops.patch
rename to patches/network/21-capi-proc_fops.patch
diff --git a/patches/22-multiqueue.patch b/patches/network/22-multiqueue.patch
similarity index 100%
rename from patches/22-multiqueue.patch
rename to patches/network/22-multiqueue.patch
diff --git a/patches/24-pcmcia.patch b/patches/network/24-pcmcia.patch
similarity index 100%
rename from patches/24-pcmcia.patch
rename to patches/network/24-pcmcia.patch
diff --git a/patches/25-multicast-list_head.patch b/patches/network/25-multicast-list_head.patch
similarity index 100%
rename from patches/25-multicast-list_head.patch
rename to patches/network/25-multicast-list_head.patch
diff --git a/patches/26-sdio-quirks.patch b/patches/network/26-sdio-quirks.patch
similarity index 100%
rename from patches/26-sdio-quirks.patch
rename to patches/network/26-sdio-quirks.patch
diff --git a/patches/27-hermes-read-pda-conflict.patch b/patches/network/27-hermes-read-pda-conflict.patch
similarity index 100%
rename from patches/27-hermes-read-pda-conflict.patch
rename to patches/network/27-hermes-read-pda-conflict.patch
diff --git a/patches/29-sdio_no_suspend.patch b/patches/network/29-sdio_no_suspend.patch
similarity index 100%
rename from patches/29-sdio_no_suspend.patch
rename to patches/network/29-sdio_no_suspend.patch
diff --git a/patches/30-bridge-port.patch b/patches/network/30-bridge-port.patch
similarity index 100%
rename from patches/30-bridge-port.patch
rename to patches/network/30-bridge-port.patch
diff --git a/patches/32-remove-ns-type.patch b/patches/network/32-remove-ns-type.patch
similarity index 100%
rename from patches/32-remove-ns-type.patch
rename to patches/network/32-remove-ns-type.patch
diff --git a/patches/35-fix-makefile-includes.patch b/patches/network/35-fix-makefile-includes.patch
similarity index 100%
rename from patches/35-fix-makefile-includes.patch
rename to patches/network/35-fix-makefile-includes.patch
diff --git a/patches/36-workqueue.patch b/patches/network/36-workqueue.patch
similarity index 100%
rename from patches/36-workqueue.patch
rename to patches/network/36-workqueue.patch
diff --git a/patches/37-vsnprintk.patch b/patches/network/37-vsnprintk.patch
similarity index 100%
rename from patches/37-vsnprintk.patch
rename to patches/network/37-vsnprintk.patch
diff --git a/patches/38-led-max-brightness.patch b/patches/network/38-led-max-brightness.patch
similarity index 100%
rename from patches/38-led-max-brightness.patch
rename to patches/network/38-led-max-brightness.patch
diff --git a/patches/39-remove_blink_set.patch b/patches/network/39-remove_blink_set.patch
similarity index 100%
rename from patches/39-remove_blink_set.patch
rename to patches/network/39-remove_blink_set.patch
diff --git a/patches/40-netdev-hw-features.patch b/patches/network/40-netdev-hw-features.patch
similarity index 100%
rename from patches/40-netdev-hw-features.patch
rename to patches/network/40-netdev-hw-features.patch
diff --git a/patches/42-netlink_seq.patch b/patches/network/42-netlink_seq.patch
similarity index 100%
rename from patches/42-netlink_seq.patch
rename to patches/network/42-netlink_seq.patch
diff --git a/patches/43-rename_pm_qos_request.patch b/patches/network/43-rename_pm_qos_request.patch
similarity index 100%
rename from patches/43-rename_pm_qos_request.patch
rename to patches/network/43-rename_pm_qos_request.patch
diff --git a/patches/44-deactivate-mac80211-tracing.patch b/patches/network/44-deactivate-mac80211-tracing.patch
similarity index 100%
rename from patches/44-deactivate-mac80211-tracing.patch
rename to patches/network/44-deactivate-mac80211-tracing.patch
diff --git a/patches/45-remove-platform-id-table.patch b/patches/network/45-remove-platform-id-table.patch
similarity index 100%
rename from patches/45-remove-platform-id-table.patch
rename to patches/network/45-remove-platform-id-table.patch
diff --git a/patches/46-use_other_workqueue.patch b/patches/network/46-use_other_workqueue.patch
similarity index 100%
rename from patches/46-use_other_workqueue.patch
rename to patches/network/46-use_other_workqueue.patch
diff --git a/patches/47-no_trans_start_on_netdev_queue.patch b/patches/network/47-no_trans_start_on_netdev_queue.patch
similarity index 100%
rename from patches/47-no_trans_start_on_netdev_queue.patch
rename to patches/network/47-no_trans_start_on_netdev_queue.patch
diff --git a/patches/48-use_skb_get_queue_mapping.patch b/patches/network/48-use_skb_get_queue_mapping.patch
similarity index 100%
rename from patches/48-use_skb_get_queue_mapping.patch
rename to patches/network/48-use_skb_get_queue_mapping.patch
diff --git a/patches/50-libertas-olpc-ec-wakeup.patch b/patches/network/50-libertas-olpc-ec-wakeup.patch
similarity index 100%
rename from patches/50-libertas-olpc-ec-wakeup.patch
rename to patches/network/50-libertas-olpc-ec-wakeup.patch
diff --git a/patches/52-tty-dev.patch b/patches/network/52-tty-dev.patch
similarity index 100%
rename from patches/52-tty-dev.patch
rename to patches/network/52-tty-dev.patch
diff --git a/patches/53-pr_fmt.patch b/patches/network/53-pr_fmt.patch
similarity index 100%
rename from patches/53-pr_fmt.patch
rename to patches/network/53-pr_fmt.patch
diff --git a/patches/54-get_ts_info.patch b/patches/network/54-get_ts_info.patch
similarity index 100%
rename from patches/54-get_ts_info.patch
rename to patches/network/54-get_ts_info.patch
diff --git a/patches/55-iwlwifi-msg-trace-fix.patch b/patches/network/55-iwlwifi-msg-trace-fix.patch
similarity index 100%
rename from patches/55-iwlwifi-msg-trace-fix.patch
rename to patches/network/55-iwlwifi-msg-trace-fix.patch
diff --git a/patches/56-mac80211-trace-fix.patch b/patches/network/56-mac80211-trace-fix.patch
similarity index 100%
rename from patches/56-mac80211-trace-fix.patch
rename to patches/network/56-mac80211-trace-fix.patch
diff --git a/patches/57-iwlwifi-debug-fix.patch b/patches/network/57-iwlwifi-debug-fix.patch
similarity index 100%
rename from patches/57-iwlwifi-debug-fix.patch
rename to patches/network/57-iwlwifi-debug-fix.patch
diff --git a/patches/61-netdev-addr_assign_type.patch b/patches/network/61-netdev-addr_assign_type.patch
similarity index 100%
rename from patches/61-netdev-addr_assign_type.patch
rename to patches/network/61-netdev-addr_assign_type.patch
diff --git a/patches/62-usb_driver_lpm.patch b/patches/network/62-usb_driver_lpm.patch
similarity index 100%
rename from patches/62-usb_driver_lpm.patch
rename to patches/network/62-usb_driver_lpm.patch
diff --git a/patches/63-tty-termios.patch b/patches/network/63-tty-termios.patch
similarity index 100%
rename from patches/63-tty-termios.patch
rename to patches/network/63-tty-termios.patch
diff --git a/patches/64-b44-32bit-stats.patch b/patches/network/64-b44-32bit-stats.patch
similarity index 100%
rename from patches/64-b44-32bit-stats.patch
rename to patches/network/64-b44-32bit-stats.patch
diff --git a/patches/65-ignore-dismantle.patch b/patches/network/65-ignore-dismantle.patch
similarity index 100%
rename from patches/65-ignore-dismantle.patch
rename to patches/network/65-ignore-dismantle.patch
diff --git a/patches/99-change-makefiles.patch b/patches/network/99-change-makefiles.patch
similarity index 100%
rename from patches/99-change-makefiles.patch
rename to patches/network/99-change-makefiles.patch
diff --git a/pending-stable/network/.gitignore b/pending-stable/network/.gitignore
new file mode 100644
index 0000000..e69de29
diff --git a/scripts/admin-update.sh b/scripts/admin-update.sh
index 0fa46c2..dab73e7 100755
--- a/scripts/admin-update.sh
+++ b/scripts/admin-update.sh
@@ -142,7 +142,7 @@ nagometer() {
 
 	let CHANGES=$ADD+$DEL
 
-	case $1 in
+	case `dirname $1` in
 	"patches")
 		brag_backport $ORIG_CODE $CHANGES $ADD $DEL
 		;;
@@ -203,6 +203,7 @@ copyDirectories() {
 # fetched in by default.
 ENABLE_NETWORK=1
 ENABLE_DRM=0
+SUBSYSTEMS=
 
 EXTRA_PATCHES="patches"
 REFRESH="n"
@@ -263,6 +264,15 @@ if [ $# -ge 1 ]; then
 
 fi
 
+# SUBSYSTEMS is used to select which patches to apply
+if [[ "$ENABLE_NETWORK" == "1" ]]; then
+	SUBSYSTEMS="network"
+fi
+
+if [[ "$ENABLE_DRM" == "1" ]]; then
+	SUBSYSTEMS+=" drm"
+fi
+
 # User exported this variable
 if [ -z $GIT_TREE ]; then
 	GIT_TREE="$HOME/linux-next"
@@ -634,33 +644,38 @@ ORIG_CODE=$(find ./ -type f -name  \*.[ch] |
 printf "\n${CYAN}compat-drivers code metrics${NORMAL}\n\n" > $CODE_METRICS
 printf "${PURPLE}%10s${NORMAL} - Total upstream lines of code being pulled\n" $ORIG_CODE >> $CODE_METRICS
 
-for dir in $EXTRA_PATCHES; do
-	LAST_ELEM=$dir
-done
+for subsystem in $SUBSYSTEMS; do
 
-for dir in $EXTRA_PATCHES; do
-	if [[ ! -d $dir ]]; then
-		echo -e "${RED}Patches: $dir empty, skipping...${NORMAL}\n"
-		continue
-	fi
-	if [[ $LAST_ELEM = $dir && "$REFRESH" = y ]]; then
-		patchRefresh $dir
-	fi
+	for dir in $EXTRA_PATCHES; do
+		LAST_ELEM=$dir
+	done
 
-	FOUND=$(find $dir/ -maxdepth 1 -name \*.patch | wc -l)
-	if [ $FOUND -eq 0 ]; then
-		continue
-	fi
-	for i in $(ls -v $dir/*.patch); do
-		echo -e "${GREEN}Applying backport patch${NORMAL}: ${BLUE}$i${NORMAL}"
-		patch -p1 -N -t < $i
-		RET=$?
-		if [[ $RET -ne 0 ]]; then
-			echo -e "${RED}Patching $i failed${NORMAL}, update it"
-			exit $RET
+	for dir in $EXTRA_PATCHES; do
+		PATCHDIR="$dir/$subsystem"
+		if [[ ! -d $PATCHDIR ]]; then
+			echo -e "${RED}Patches: $PATCHDIR empty, skipping...${NORMAL}"
+			continue
 		fi
+		if [[ $LAST_ELEM = $dir && "$REFRESH" = y ]]; then
+			patchRefresh $PATCHDIR
+		fi
+
+		FOUND=$(find $PATCHDIR/ -maxdepth 1 -name \*.patch | wc -l)
+		if [ $FOUND -eq 0 ]; then
+			continue
+		fi
+
+		for i in $(ls -v $PATCHDIR/*.patch); do
+			echo -e "${GREEN}Applying backport patch${NORMAL}: ${BLUE}$i${NORMAL}"
+			patch -p1 -N -t < $i
+			RET=$?
+			if [[ $RET -ne 0 ]]; then
+				echo -e "${RED}Patching $i failed${NORMAL}, update it"
+				exit $RET
+			fi
+		done
+		nagometer $PATCHDIR $ORIG_CODE >> $CODE_METRICS
 	done
-	nagometer $dir $ORIG_CODE >> $CODE_METRICS
 done
 
 DIR="$PWD"
-- 
1.7.11.4
