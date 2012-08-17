Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:54614 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754993Ab2HQI0x (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 17 Aug 2012 04:26:53 -0400
Received: by eeil10 with SMTP id l10so1135862eei.19
        for <backports@vger.kernel.org>; Fri, 17 Aug 2012 01:26:52 -0700 (PDT)
From: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
To: backports@vger.kernel.org
Cc: mcgrof@kernel.org,
	=?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozancag@gmail.com>
Subject: [PATCH 1/2] compat-drivers: Move around patches and selectively apply them
Date: Fri, 17 Aug 2012 11:26:43 +0300
Message-Id: <1345192004-8563-1-git-send-email-ozancag@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Put wlan/bt/eth related patches under network/ subdirectories. Apply them
only if the network subsystem is enabled (For now, it is enabled by default).

Create empty network/ placeholders under patch directories.

Signed-off-by: Ozan Çağlayan <ozancag@gmail.com>
---

The patch is too big for this mailing list. The link to the patch is:
  http://ozancaglayan.com/files/compat/0001-compat-drivers-Move-around-patches-and-selectively-a.patch

 ...-QCA-ethernet-driver-which-supercedes-atl.patch | 13498 -------------------
 crap/0002-backport-alx.patch                       |   133 -
 crap/0003-remove-atl1c-devices-from-alx.patch      |    19 -
 ...s-adds-the-802.11ad-60-GHz-wil6210-driver.patch |  5757 --------
 ...-QCA-ethernet-driver-which-supercedes-atl.patch | 13498 +++++++++++++++++++
 crap/network/0002-backport-alx.patch               |   133 +
 .../0003-remove-atl1c-devices-from-alx.patch       |    19 +
 ...s-adds-the-802.11ad-60-GHz-wil6210-driver.patch |  5757 ++++++++
 patches/0001-netdev_ops.patch                      |   279 -
 patches/0002-net-misc.patch                        |    68 -
 patches/0003-netdev-needed_headroom_tailroom.patch |    36 -
 patches/0004-wext-namespace.patch                  |    58 -
 patches/02-ksize.patch                             |    69 -
 patches/03-rfkill.patch                            |    66 -
 patches/04-netns.patch                             |   149 -
 patches/05-usb.patch                               |    26 -
 patches/06-header-changes.patch                    |   117 -
 patches/07-change-default-rate-alg.patch           |    34 -
 patches/08-rename-config-options.patch             |   167 -
 patches/09-cfg80211-wext-padding.patch             |    62 -
 patches/09-threaded-irq.patch                      |   129 -
 patches/10-add-wext-handlers-to-netdev.patch       |    47 -
 patches/11-dev-pm-ops.patch                        |   396 -
 patches/12-iw_handler-changes.patch                |    14 -
 patches/12-mac80211-disable-tx-status.patch        |    24 -
 patches/14-device-type.patch                       |    56 -
 patches/15-symbol-export-conflicts.patch           |    18 -
 patches/16-bluetooth.patch                         |   576 -
 patches/17-netdev-queue.patch                      |    47 -
 patches/18-rename-usb-net-symbols.patch            |    53 -
 patches/21-capi-proc_fops.patch                    |    73 -
 patches/22-multiqueue.patch                        |    43 -
 patches/24-pcmcia.patch                            |  1414 --
 patches/25-multicast-list_head.patch               |   820 --
 patches/26-sdio-quirks.patch                       |    32 -
 patches/27-hermes-read-pda-conflict.patch          |    56 -
 patches/29-sdio_no_suspend.patch                   |   199 -
 patches/30-bridge-port.patch                       |    45 -
 patches/32-remove-ns-type.patch                    |    28 -
 patches/35-fix-makefile-includes.patch             |    71 -
 patches/36-workqueue.patch                         |    16 -
 patches/37-vsnprintk.patch                         |    35 -
 patches/38-led-max-brightness.patch                |    24 -
 patches/39-remove_blink_set.patch                  |    56 -
 patches/40-netdev-hw-features.patch                |   372 -
 patches/42-netlink_seq.patch                       |    12 -
 patches/43-rename_pm_qos_request.patch             |    14 -
 patches/44-deactivate-mac80211-tracing.patch       |    15 -
 patches/45-remove-platform-id-table.patch          |    23 -
 patches/46-use_other_workqueue.patch               |    19 -
 patches/47-no_trans_start_on_netdev_queue.patch    |    17 -
 patches/48-use_skb_get_queue_mapping.patch         |    38 -
 patches/50-libertas-olpc-ec-wakeup.patch           |    23 -
 patches/52-tty-dev.patch                           |    32 -
 patches/53-pr_fmt.patch                            |   821 --
 patches/54-get_ts_info.patch                       |    39 -
 patches/55-iwlwifi-msg-trace-fix.patch             |    70 -
 patches/56-mac80211-trace-fix.patch                |    79 -
 patches/57-iwlwifi-debug-fix.patch                 |    19 -
 patches/61-netdev-addr_assign_type.patch           |    53 -
 patches/62-usb_driver_lpm.patch                    |   276 -
 patches/63-tty-termios.patch                       |    49 -
 patches/64-b44-32bit-stats.patch                   |    54 -
 patches/65-ignore-dismantle.patch                  |    23 -
 patches/99-change-makefiles.patch                  |   100 -
 patches/network/0001-netdev_ops.patch              |   279 +
 patches/network/0002-net-misc.patch                |    68 +
 .../0003-netdev-needed_headroom_tailroom.patch     |    36 +
 patches/network/0004-wext-namespace.patch          |    58 +
 patches/network/02-ksize.patch                     |    69 +
 patches/network/03-rfkill.patch                    |    66 +
 patches/network/04-netns.patch                     |   149 +
 patches/network/05-usb.patch                       |    26 +
 patches/network/06-header-changes.patch            |   117 +
 patches/network/07-change-default-rate-alg.patch   |    34 +
 patches/network/08-rename-config-options.patch     |   167 +
 patches/network/09-cfg80211-wext-padding.patch     |    62 +
 patches/network/09-threaded-irq.patch              |   129 +
 .../network/10-add-wext-handlers-to-netdev.patch   |    47 +
 patches/network/11-dev-pm-ops.patch                |   396 +
 patches/network/12-iw_handler-changes.patch        |    14 +
 .../network/12-mac80211-disable-tx-status.patch    |    24 +
 patches/network/14-device-type.patch               |    56 +
 patches/network/15-symbol-export-conflicts.patch   |    18 +
 patches/network/16-bluetooth.patch                 |   576 +
 patches/network/17-netdev-queue.patch              |    47 +
 patches/network/18-rename-usb-net-symbols.patch    |    53 +
 patches/network/21-capi-proc_fops.patch            |    73 +
 patches/network/22-multiqueue.patch                |    43 +
 patches/network/24-pcmcia.patch                    |  1414 ++
 patches/network/25-multicast-list_head.patch       |   820 ++
 patches/network/26-sdio-quirks.patch               |    32 +
 patches/network/27-hermes-read-pda-conflict.patch  |    56 +
 patches/network/29-sdio_no_suspend.patch           |   199 +
 patches/network/30-bridge-port.patch               |    45 +
 patches/network/32-remove-ns-type.patch            |    28 +
 patches/network/35-fix-makefile-includes.patch     |    71 +
 patches/network/36-workqueue.patch                 |    16 +
 patches/network/37-vsnprintk.patch                 |    35 +
 patches/network/38-led-max-brightness.patch        |    24 +
 patches/network/39-remove_blink_set.patch          |    56 +
 patches/network/40-netdev-hw-features.patch        |   372 +
 patches/network/42-netlink_seq.patch               |    12 +
 patches/network/43-rename_pm_qos_request.patch     |    14 +
 .../network/44-deactivate-mac80211-tracing.patch   |    15 +
 patches/network/45-remove-platform-id-table.patch  |    23 +
 patches/network/46-use_other_workqueue.patch       |    19 +
 .../47-no_trans_start_on_netdev_queue.patch        |    17 +
 patches/network/48-use_skb_get_queue_mapping.patch |    38 +
 patches/network/50-libertas-olpc-ec-wakeup.patch   |    23 +
 patches/network/52-tty-dev.patch                   |    32 +
 patches/network/53-pr_fmt.patch                    |   821 ++
 patches/network/54-get_ts_info.patch               |    39 +
 patches/network/55-iwlwifi-msg-trace-fix.patch     |    70 +
 patches/network/56-mac80211-trace-fix.patch        |    79 +
 patches/network/57-iwlwifi-debug-fix.patch         |    19 +
 patches/network/61-netdev-addr_assign_type.patch   |    53 +
 patches/network/62-usb_driver_lpm.patch            |   276 +
 patches/network/63-tty-termios.patch               |    49 +
 patches/network/64-b44-32bit-stats.patch           |    54 +
 patches/network/65-ignore-dismantle.patch          |    23 +
 patches/network/99-change-makefiles.patch          |   100 +
 scripts/admin-update.sh                            |    63 +-
 123 files changed, 26997 insertions(+), 26982 deletions(-)
 delete mode 100644 crap/0001-alx-add-new-QCA-ethernet-driver-which-supercedes-atl.patch
 delete mode 100644 crap/0002-backport-alx.patch
 delete mode 100644 crap/0003-remove-atl1c-devices-from-alx.patch
 delete mode 100644 crap/0004-wireless-adds-the-802.11ad-60-GHz-wil6210-driver.patch
 create mode 100644 crap/network/0001-alx-add-new-QCA-ethernet-driver-which-supercedes-atl.patch
 create mode 100644 crap/network/0002-backport-alx.patch
 create mode 100644 crap/network/0003-remove-atl1c-devices-from-alx.patch
 create mode 100644 crap/network/0004-wireless-adds-the-802.11ad-60-GHz-wil6210-driver.patch
 create mode 100644 linux-next-cherry-picks/network/.gitignore
 create mode 100644 linux-next-pending/network/.gitignore
 delete mode 100644 patches/0001-netdev_ops.patch
 delete mode 100644 patches/0002-net-misc.patch
 delete mode 100644 patches/0003-netdev-needed_headroom_tailroom.patch
 delete mode 100644 patches/0004-wext-namespace.patch
 delete mode 100644 patches/02-ksize.patch
 delete mode 100644 patches/03-rfkill.patch
 delete mode 100644 patches/04-netns.patch
 delete mode 100644 patches/05-usb.patch
 delete mode 100644 patches/06-header-changes.patch
 delete mode 100644 patches/07-change-default-rate-alg.patch
 delete mode 100644 patches/08-rename-config-options.patch
 delete mode 100644 patches/09-cfg80211-wext-padding.patch
 delete mode 100644 patches/09-threaded-irq.patch
 delete mode 100644 patches/10-add-wext-handlers-to-netdev.patch
 delete mode 100644 patches/11-dev-pm-ops.patch
 delete mode 100644 patches/12-iw_handler-changes.patch
 delete mode 100644 patches/12-mac80211-disable-tx-status.patch
 delete mode 100644 patches/14-device-type.patch
 delete mode 100644 patches/15-symbol-export-conflicts.patch
 delete mode 100644 patches/16-bluetooth.patch
 delete mode 100644 patches/17-netdev-queue.patch
 delete mode 100644 patches/18-rename-usb-net-symbols.patch
 delete mode 100644 patches/21-capi-proc_fops.patch
 delete mode 100644 patches/22-multiqueue.patch
 delete mode 100644 patches/24-pcmcia.patch
 delete mode 100644 patches/25-multicast-list_head.patch
 delete mode 100644 patches/26-sdio-quirks.patch
 delete mode 100644 patches/27-hermes-read-pda-conflict.patch
 delete mode 100644 patches/29-sdio_no_suspend.patch
 delete mode 100644 patches/30-bridge-port.patch
 delete mode 100644 patches/32-remove-ns-type.patch
 delete mode 100644 patches/35-fix-makefile-includes.patch
 delete mode 100644 patches/36-workqueue.patch
 delete mode 100644 patches/37-vsnprintk.patch
 delete mode 100644 patches/38-led-max-brightness.patch
 delete mode 100644 patches/39-remove_blink_set.patch
 delete mode 100644 patches/40-netdev-hw-features.patch
 delete mode 100644 patches/42-netlink_seq.patch
 delete mode 100644 patches/43-rename_pm_qos_request.patch
 delete mode 100644 patches/44-deactivate-mac80211-tracing.patch
 delete mode 100644 patches/45-remove-platform-id-table.patch
 delete mode 100644 patches/46-use_other_workqueue.patch
 delete mode 100644 patches/47-no_trans_start_on_netdev_queue.patch
 delete mode 100644 patches/48-use_skb_get_queue_mapping.patch
 delete mode 100644 patches/50-libertas-olpc-ec-wakeup.patch
 delete mode 100644 patches/52-tty-dev.patch
 delete mode 100644 patches/53-pr_fmt.patch
 delete mode 100644 patches/54-get_ts_info.patch
 delete mode 100644 patches/55-iwlwifi-msg-trace-fix.patch
 delete mode 100644 patches/56-mac80211-trace-fix.patch
 delete mode 100644 patches/57-iwlwifi-debug-fix.patch
 delete mode 100644 patches/61-netdev-addr_assign_type.patch
 delete mode 100644 patches/62-usb_driver_lpm.patch
 delete mode 100644 patches/63-tty-termios.patch
 delete mode 100644 patches/64-b44-32bit-stats.patch
 delete mode 100644 patches/65-ignore-dismantle.patch
 delete mode 100644 patches/99-change-makefiles.patch
 create mode 100644 patches/network/0001-netdev_ops.patch
 create mode 100644 patches/network/0002-net-misc.patch
 create mode 100644 patches/network/0003-netdev-needed_headroom_tailroom.patch
 create mode 100644 patches/network/0004-wext-namespace.patch
 create mode 100644 patches/network/02-ksize.patch
 create mode 100644 patches/network/03-rfkill.patch
 create mode 100644 patches/network/04-netns.patch
 create mode 100644 patches/network/05-usb.patch
 create mode 100644 patches/network/06-header-changes.patch
 create mode 100644 patches/network/07-change-default-rate-alg.patch
 create mode 100644 patches/network/08-rename-config-options.patch
 create mode 100644 patches/network/09-cfg80211-wext-padding.patch
 create mode 100644 patches/network/09-threaded-irq.patch
 create mode 100644 patches/network/10-add-wext-handlers-to-netdev.patch
 create mode 100644 patches/network/11-dev-pm-ops.patch
 create mode 100644 patches/network/12-iw_handler-changes.patch
 create mode 100644 patches/network/12-mac80211-disable-tx-status.patch
 create mode 100644 patches/network/14-device-type.patch
 create mode 100644 patches/network/15-symbol-export-conflicts.patch
 create mode 100644 patches/network/16-bluetooth.patch
 create mode 100644 patches/network/17-netdev-queue.patch
 create mode 100644 patches/network/18-rename-usb-net-symbols.patch
 create mode 100644 patches/network/21-capi-proc_fops.patch
 create mode 100644 patches/network/22-multiqueue.patch
 create mode 100644 patches/network/24-pcmcia.patch
 create mode 100644 patches/network/25-multicast-list_head.patch
 create mode 100644 patches/network/26-sdio-quirks.patch
 create mode 100644 patches/network/27-hermes-read-pda-conflict.patch
 create mode 100644 patches/network/29-sdio_no_suspend.patch
 create mode 100644 patches/network/30-bridge-port.patch
 create mode 100644 patches/network/32-remove-ns-type.patch
 create mode 100644 patches/network/35-fix-makefile-includes.patch
 create mode 100644 patches/network/36-workqueue.patch
 create mode 100644 patches/network/37-vsnprintk.patch
 create mode 100644 patches/network/38-led-max-brightness.patch
 create mode 100644 patches/network/39-remove_blink_set.patch
 create mode 100644 patches/network/40-netdev-hw-features.patch
 create mode 100644 patches/network/42-netlink_seq.patch
 create mode 100644 patches/network/43-rename_pm_qos_request.patch
 create mode 100644 patches/network/44-deactivate-mac80211-tracing.patch
 create mode 100644 patches/network/45-remove-platform-id-table.patch
 create mode 100644 patches/network/46-use_other_workqueue.patch
 create mode 100644 patches/network/47-no_trans_start_on_netdev_queue.patch
 create mode 100644 patches/network/48-use_skb_get_queue_mapping.patch
 create mode 100644 patches/network/50-libertas-olpc-ec-wakeup.patch
 create mode 100644 patches/network/52-tty-dev.patch
 create mode 100644 patches/network/53-pr_fmt.patch
 create mode 100644 patches/network/54-get_ts_info.patch
 create mode 100644 patches/network/55-iwlwifi-msg-trace-fix.patch
 create mode 100644 patches/network/56-mac80211-trace-fix.patch
 create mode 100644 patches/network/57-iwlwifi-debug-fix.patch
 create mode 100644 patches/network/61-netdev-addr_assign_type.patch
 create mode 100644 patches/network/62-usb_driver_lpm.patch
 create mode 100644 patches/network/63-tty-termios.patch
 create mode 100644 patches/network/64-b44-32bit-stats.patch
 create mode 100644 patches/network/65-ignore-dismantle.patch
 create mode 100644 patches/network/99-change-makefiles.patch
 create mode 100644 pending-stable/network/.gitignore

-- 
1.7.11.2

