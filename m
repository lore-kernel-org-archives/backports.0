Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:40300 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755055AbaDLBem (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 11 Apr 2014 21:34:42 -0400
Received: by mail-pb0-f45.google.com with SMTP id uo5so6069981pbc.32
        for <backports@vger.kernel.org>; Fri, 11 Apr 2014 18:34:41 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 00/10] backports: catch up to next-20140411
Date: Fri, 11 Apr 2014 18:34:25 -0700
Message-Id: <1397266475-14442-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20140412_033451_790149_DC4D2192)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

And we've made it! We're back in synch with linux-next!

This gets us up to next-20140411. It has in place the deletion of
old kernel support, anything  prior to 3.0. If you use ckmake all
you have to do after applying these patches (or waiting for
them to get merged) is just run:

./devel/backports-update-manager

That will remove the older kernel series from your system so
ckmake won't use them for test compilation. The overall compile
time savings, as well as code generation time is not that
significant but that's not the reason I was pooking to see if
we should do this, the gains will come from less work. I don't
have the time to be maintaining old patches, and if we don't
maintain them then there is little point leaving the old code
in place.

After the deletion I just renamed patch series to account for the
shuffle and while at it, made sure the ones we have left are atomic.
There was one series that turns out is generic accross two subsystems
to I've merged those two. There was only one series that was clearly
not atomic and because of that moved it outside of collateral-evolutions.
Moving forward I will be a bit more strict about patches and atomicity,
the goal will be to help us scale by trying to embrace Coccinelle
SmPL where it makes sense. It may not be evident at first a change
might use SmPL grammar at first but as more drivers get backported
this will become more important.

Stefan, please look at the 0001-ethernet-igb series, which although
its greatly welcomed we backport more drivers its imperative that
we break patches down atomically to help with taking advantage
of the backport for more drivers. If a series already exist that
addresses the change you have you can then just split out the small
change into the respective series that already exists under
collateral-evolutions. If its new you can add a new series, but please
be sure to describe on the INFO page the details of what commits
introduced the change, and describe the backport as best as possible.

A tool we could use in the future is one that can help us nuke
old kernel support from header files and maybe the compat code.
We might be able to use unifdef.

The all-in-one patch that catches us up is:

http://drvbp1.linux-foundation.org/~mcgrof/patches/backports/2014/04/11/pend-20140411-1.patch

The patch that deletes tons of patches is huge so its available at:

http://drvbp1.linux-foundation.org/~mcgrof/patches/backports/2014/04/11/0010-backports-refresh-patches-for-next-20140409-and-next.patch

Arik Nemtsov (1):
  backports: device: don't redefine DEVICE_ATTR_RO

Johannes Berg (2):
  backports: add hwsim defconfig
  backports: add napi_gro_flush()

Luis R. Rodriguez (7):
  backports: drop display output class support
  backports: adjust flow_dissector.patch
  backports: backport dev_consume_skb_any()
  backports: backport define of SIOCGHWTSTAMP
  backports: bump bluetooth reqs to 3.2
  backports: nuke support for kernels < 3.0
  backports: refresh patches for next-20140409 and next-20140411

 README                                             |   2 +-
 backport/Makefile.real                             |   1 -
 .../backport-include/asm-generic/pci-dma-compat.h  |  17 -
 backport/backport-include/asm/atomic.h             |  19 +-
 backport/backport-include/asm/unaligned.h          | 213 -----
 backport/backport-include/backport/checks.h        |   4 -
 backport/backport-include/crypto/aes.h             |  21 -
 backport/backport-include/linux/atomic.h           |  12 -
 backport/backport-include/linux/bitops.h           |  35 -
 backport/backport-include/linux/bug.h              |  45 --
 backport/backport-include/linux/debugfs.h          |  29 -
 backport/backport-include/linux/delay.h            |  10 -
 backport/backport-include/linux/device.h           |  96 +--
 backport/backport-include/linux/dma-attrs.h        |   6 -
 backport/backport-include/linux/dma-mapping.h      |  75 --
 backport/backport-include/linux/dynamic_debug.h    |   2 -
 backport/backport-include/linux/err.h              |  21 -
 backport/backport-include/linux/etherdevice.h      |  65 +-
 backport/backport-include/linux/ethtool.h          |  27 -
 backport/backport-include/linux/firmware.h         |  29 -
 backport/backport-include/linux/fs.h               |   9 -
 backport/backport-include/linux/if.h               |  17 -
 backport/backport-include/linux/if_ether.h         |   5 -
 backport/backport-include/linux/in.h               |  25 -
 backport/backport-include/linux/interrupt.h        | 100 ---
 backport/backport-include/linux/ioport.h           |   7 -
 backport/backport-include/linux/irq.h              |  85 --
 backport/backport-include/linux/kernel.h           | 138 ----
 backport/backport-include/linux/kfifo.h            | 865 +--------------------
 backport/backport-include/linux/kmemleak.h         |  24 -
 backport/backport-include/linux/ktime.h            |  15 -
 backport/backport-include/linux/leds.h             |  17 +-
 backport/backport-include/linux/list.h             |  65 --
 backport/backport-include/linux/lockdep.h          |  44 --
 backport/backport-include/linux/math64.h           |  43 -
 backport/backport-include/linux/mmc/core.h         |  12 -
 backport/backport-include/linux/mmc/sdio_func.h    |  30 -
 backport/backport-include/linux/mod_devicetable.h  |  32 -
 backport/backport-include/linux/net.h              |   2 +-
 backport/backport-include/linux/netdev_features.h  |   4 +-
 backport/backport-include/linux/netdevice.h        | 491 ++----------
 backport/backport-include/linux/of.h               |   5 -
 backport/backport-include/linux/pci-aspm.h         |  13 -
 backport/backport-include/linux/phy.h              |  10 -
 backport/backport-include/linux/pkt_sched.h        |   2 +
 backport/backport-include/linux/platform_device.h  |   6 -
 backport/backport-include/linux/pm.h               |  57 --
 backport/backport-include/linux/pm_qos.h           |  39 -
 backport/backport-include/linux/pm_runtime.h       |  65 --
 backport/backport-include/linux/poll.h             |   5 +-
 backport/backport-include/linux/printk.h           |  50 --
 backport/backport-include/linux/ptp_clock_kernel.h |   3 -
 backport/backport-include/linux/rculist.h          |  17 -
 backport/backport-include/linux/rfkill.h           |  12 -
 backport/backport-include/linux/rtnetlink.h        |  14 -
 backport/backport-include/linux/semaphore.h        |  12 -
 backport/backport-include/linux/seq_file.h         |  18 -
 backport/backport-include/linux/skbuff.h           | 161 +---
 backport/backport-include/linux/static_key.h       | 137 ----
 backport/backport-include/linux/string.h           |   5 -
 backport/backport-include/linux/sysfs.h            |  28 -
 backport/backport-include/linux/time.h             |  31 -
 backport/backport-include/linux/timer.h            |  10 -
 backport/backport-include/linux/tracepoint.h       |  53 --
 backport/backport-include/linux/tty.h              |  33 +-
 backport/backport-include/linux/types.h            |  51 --
 backport/backport-include/linux/usb.h              |  87 +--
 backport/backport-include/linux/usb/ch9.h          |  22 -
 backport/backport-include/linux/vmalloc.h          |  11 -
 backport/backport-include/linux/wait.h             |  10 -
 backport/backport-include/linux/watchdog.h         |   2 -
 backport/backport-include/linux/workqueue.h        |  63 --
 backport/backport-include/net/codel.h              |  13 -
 backport/backport-include/net/dst.h                |  35 -
 backport/backport-include/net/genetlink.h          |  66 --
 backport/backport-include/net/ipv6.h               |   2 +-
 backport/backport-include/net/iw_handler.h         |  27 -
 backport/backport-include/net/net_namespace.h      |  57 +-
 backport/backport-include/net/sch_generic.h        | 112 ---
 backport/backport-include/net/sock.h               |  35 -
 backport/backport-include/pcmcia/cistpl.h          |  10 -
 backport/backport-include/pcmcia/ds.h              |  62 --
 backport/backport-include/trace/define_trace.h     |   5 -
 backport/backport-include/uapi/linux/sockios.h     |  31 +
 backport/compat/Kconfig                            |  51 +-
 backport/compat/Makefile                           |  17 +-
 backport/compat/compat-2.6.26.c                    |  64 --
 backport/compat/compat-2.6.27.c                    | 241 ------
 backport/compat/compat-2.6.28.c                    | 472 -----------
 backport/compat/compat-2.6.29.c                    | 169 ----
 backport/compat/compat-2.6.32.c                    | 217 ------
 backport/compat/compat-2.6.33.c                    | 233 ------
 backport/compat/compat-2.6.34.c                    |  88 ---
 backport/compat/compat-2.6.34.h                    |  20 -
 backport/compat/compat-2.6.35.c                    | 117 ---
 backport/compat/compat-2.6.36.c                    | 120 ---
 backport/compat/compat-2.6.37.c                    | 269 -------
 backport/compat/compat-2.6.39.c                    | 117 ---
 backport/compat/compat_atomic.c                    |  43 -
 backport/compat/compat_firmware_class.c            | 759 ------------------
 backport/compat/kfifo.c                            | 607 ---------------
 backport/compat/kstrtox.c                          | 237 ------
 backport/compat/main.c                             |   4 -
 backport/defconfigs/hwsim                          |  12 +
 backport/scripts/backport_firmware_install.sh      |  21 -
 backport/udev/50-compat_firmware.rules             |   4 -
 backport/udev/compat_firmware.sh                   |  35 -
 backport/udev/ubuntu/compat_firmware.sh            |  29 -
 copy-list                                          |   1 -
 dependencies                                       |  73 --
 devel/backports-update-manager                     |  57 --
 gentree.py                                         |   2 +-
 .../0003-technisat-usb2-led-rename.patch           |   0
 .../0004-bt8xx-rename-dst-ops.patch}               |   0
 .../0005-uapi-compromise}/INFO                     |   0
 .../0005-uapi-compromise}/mwifiex.patch            |   0
 patches/backport-adjustments/flow_dissector.patch  |  10 +-
 patches/backport-adjustments/sch_codel.patch       |  98 ---
 patches/backport-adjustments/sch_fq_codel.patch    | 106 ---
 .../generic/0001-sysfs-api/INFO                    |  36 +
 .../0001-sysfs-api}/drivers_bcma.patch             |   0
 .../drivers_media_v4l2-core_v4l2-dev.patch}        |   0
 .../0001-sysfs-api}/drivers_ssb.patch              |   2 +-
 .../net_ieee802154_wpan-class.patch                |   2 +-
 .../0001-sysfs-api}/net_wireless_sysfs.patch       |   4 +-
 patches/collateral-evolutions/generic/README       |   1 +
 ...t.patch => 0001-dma_mmap_coherent-revert.patch} |   0
 .../network/0001-ndo_ioctl.patch                   |  51 --
 .../network/0001-netdev_ops.cocci                  |   6 -
 ...link-portid.cocci => 0001-netlink-portid.cocci} |   0
 ... 0002-disable-dump-adjust-on-old-kernels.patch} |   4 +-
 .../network/0002-net-misc/INFO                     |   8 -
 .../network/0002-net-misc/libertas.patch           |  17 -
 .../INFO                                           |   0
 .../include_net_cfg80211.patch                     |   2 +-
 .../net_wireless_core.patch                        |   0
 .../0003-netdev-needed_headroom_tailroom/INFO      |   4 -
 .../mac80211.patch                                 |  18 -
 .../orinoco.patch                                  |  14 -
 ...onfig.patch => 0004-disable-wext-kconfig.patch} |   0
 .../network/0004-wext-namespace.patch              |  58 --
 ...-asix.patch => 0005-disable-usb-net-asix.patch} |   0
 ...tch => 0006-ieee802154-6lowpan-namespace.patch} |   0
 .../network/0007-ksize-orinoco.patch               |  37 -
 ....patch => 0007-lowpan-inet_frag_lru_move.patch} |   0
 ...13-net-user-ns.patch => 0008-net-user-ns.patch} |   0
 ..._evictor.patch => 0009-inet_frag_evictor.patch} |   0
 .../INFO                                           |   0
 .../net_wireless_core.patch                        |   0
 .../INFO                                           |   0
 .../net_mac80211_tx.patch                          |   0
 .../network/0012-driver-quirks/INFO                |   2 +
 .../drivers_net_wireless_cw1200_sdio.patch         |   0
 .../net_wireless_Makefile.patch                    |   0
 .../net_wireless_nl80211.patch                     |   2 +-
 .../drivers_net_wireless_ipw2x00_ipw2100.patch     |   0
 .../network/0015-threaded-irq.cocci                |  75 --
 .../network/0015-threaded-irq/INFO                 |   5 -
 .../drivers_net_wireless_iwlwifi_iwl-trans.patch   |  12 -
 .../INFO                                           |   0
 .../drivers_net_wireless_libertas_if_usb.patch     |   0
 .../network/0016-threaded-irq-one-shot.patch       |  38 -
 .../{54-get_ts_info => 0017-get_ts_info}/INFO      |   0
 .../drivers_net_usb_usbnet.patch                   |   2 +-
 .../INFO                                           |   2 +
 .../drivers_net_wireless_iwlwifi_iwl-debug.patch   |   0
 .../net_mac80211_trace.patch                       |   0
 ..._driver_lpm.cocci => 0019-usb_driver_lpm.cocci} |   0
 .../{63-tty-termios => 0020-tty-termios}/INFO      |   2 +
 .../drivers_bluetooth_hci_ath.patch                |   0
 .../net_bluetooth_rfcomm_tty.patch                 |   2 +-
 .../drivers_net_wireless_ath_ath9k_debug.patch     |   0
 .../network/0022-define-tracing/INFO               |   9 +
 .../ath6kl.patch                                   |   0
 .../cfg80211.patch                                 |   0
 .../wil6210.patch                                  |   0
 .../{77-led-blink-api => 0024-led-blink-api}/INFO  |   0
 .../mac80211.patch                                 |   2 +-
 .../network/{78-usb-sg => 0025-usb-sg}/INFO        |   5 +
 .../{78-usb-sg => 0025-usb-sg}/usbnet.patch        |  12 +-
 .../network/{80-ipv6_stub => 0026-ipv6_stub}/INFO  |   3 +
 .../cdc_mbim.patch                                 |   0
 .../network/0027-genl-const/INFO                   |  15 +
 .../{81-genl-const => 0027-genl-const}/hwsim.patch |   0
 .../ieee802154.patch                               |   2 +-
 .../{81-genl-const => 0027-genl-const}/nfc.patch   |   0
 .../nl80211.patch                                  |   6 +-
 .../{83-select_queue => 0028-select_queue}/INFO    |   3 +
 .../mac80211.patch                                 |   4 +-
 .../mwifiex.patch                                  |   2 +-
 .../0029-struct_hid_ll_driver-extensions/INFO      |  16 +
 .../net_bluetooth_hidp_core.patch                  |   0
 .../network/0030-qdisc_tx_busylock/INFO            |  22 +
 .../ieee802154.patch                               |   0
 patches/collateral-evolutions/network/05-usb/INFO  |   2 -
 .../network/05-usb/ath9k_htc.patch                 |  12 -
 .../network/05-usb/p54usb.patch                    |  12 -
 .../network/06-header-changes/INFO                 |   6 -
 .../drivers_net_wireless_b43_phy_common.patch      |  12 -
 .../drivers_net_wireless_iwlwifi.patch             |  11 -
 .../drivers_net_wireless_mwifiex_usb.patch         |  10 -
 .../drivers_net_wireless_rtlwifi_base.patch        |  10 -
 .../drivers_net_wireless_ti_wl1251_main.patch      |  12 -
 .../drivers_net_wireless_ti_wl1251_spi.patch       |  12 -
 .../drivers_net_wireless_ti_wlcore_event.patch     |  10 -
 .../drivers_net_wireless_ti_wlcore_scan.patch      |  10 -
 .../net_bluetooth_bnep_sock.patch                  |  10 -
 .../06-header-changes/net_bluetooth_hci_sock.patch |  10 -
 .../net_bluetooth_hidp_sock.patch                  |  10 -
 .../network/11-dev-pm-ops.cocci                    |  42 -
 .../drivers_net_wireless_iwlegacy_3945-mac.patch   |  15 -
 .../drivers_net_wireless_iwlegacy_4965-mac.patch   |  15 -
 .../drivers_net_wireless_iwlegacy_common.patch     |  35 -
 .../drivers_net_wireless_libertas_if_spi.patch     |  28 -
 .../drivers_net_wireless_mwifiex_pcie.patch        |  17 -
 .../drivers_net_wireless_ipw2x00_ipw2100.patch     |  14 -
 .../network/16-bluetooth/INFO                      |   3 -
 .../16-bluetooth/drivers_bluetooth_hci_ldisc.patch |  28 -
 .../16-bluetooth/net_bluetooth_af_bluetooth.patch  |  39 -
 .../16-bluetooth/net_bluetooth_bnep_sock.patch     |  15 -
 .../16-bluetooth/net_bluetooth_cmtp_capi.patch     |  14 -
 .../16-bluetooth/net_bluetooth_cmtp_sock.patch     |  15 -
 .../16-bluetooth/net_bluetooth_hci_sock.patch      |  29 -
 .../16-bluetooth/net_bluetooth_hidp_sock.patch     |  15 -
 .../16-bluetooth/net_bluetooth_l2cap_sock.patch    |  41 -
 .../16-bluetooth/net_bluetooth_rfcomm_sock.patch   |  28 -
 .../16-bluetooth/net_bluetooth_rfcomm_tty.patch    |  38 -
 .../network/16-bluetooth/net_bluetooth_sco.patch   |  27 -
 .../network/17-netdev-queue/INFO                   |  14 -
 .../17-netdev-queue/net_mac80211_iface.patch       |  33 -
 .../network/21-capi-proc_fops/INFO                 |   3 -
 .../net_bluetooth_cmtp_capi.patch                  |  70 --
 .../network/22-multiqueue/INFO                     |  30 -
 .../network/22-multiqueue/net_mac80211_tx.patch    |  13 -
 .../24-pcmcia/drivers_bluetooth_bluecard_cs.patch  | 191 -----
 .../24-pcmcia/drivers_bluetooth_bt3c_cs.patch      | 180 -----
 .../24-pcmcia/drivers_bluetooth_btuart_cs.patch    | 204 -----
 .../24-pcmcia/drivers_bluetooth_dtl1_cs.patch      | 178 -----
 .../drivers_net_wireless_b43_pcmcia.patch          |  82 --
 .../drivers_net_wireless_libertas_if_cs.patch      | 163 ----
 .../drivers_net_wireless_orinoco_orinoco_cs.patch  | 207 -----
 .../drivers_net_wireless_orinoco_spectrum_cs.patch | 195 -----
 .../network/24-pcmcia/drivers_ssb_main.patch       |  14 -
 .../network/25-multicast-list_head/INFO            |  13 -
 .../drivers_net_wireless_adm8211.patch             |  41 -
 ...ivers_net_wireless_ath_ath5k_mac80211-ops.patch |  55 --
 .../drivers_net_wireless_ath_carl9170_main.patch   |  38 -
 .../drivers_net_wireless_cw1200_sta.patch          |  77 --
 .../drivers_net_wireless_iwlwifi.patch             |  42 -
 .../drivers_net_wireless_libertas_tf_main.patch    |  39 -
 .../drivers_net_wireless_mwl8k.patch               |  88 ---
 .../drivers_net_wireless_p54_main.patch            |  45 --
 .../drivers_net_wireless_rtl818x_rtl8180_dev.patch |  22 -
 .../drivers_net_wireless_rtl818x_rtl8187_dev.patch |  20 -
 .../drivers_net_wireless_ti_wlcore_main.patch      |  64 --
 .../drivers_net_wireless_zd1211rw_zd_mac.patch     |  37 -
 .../include_net_mac80211.patch                     |  14 -
 .../net_mac80211_driver-ops.patch                  |  31 -
 .../net_mac80211_ieee80211_i.patch                 |  15 -
 .../net_mac80211_iface.patch                       |  29 -
 .../25-multicast-list_head/net_mac80211_main.patch |  26 -
 .../network/25-multicast.cocci                     |  11 -
 .../network/26-sdio-quirks/INFO                    |   2 -
 .../drivers_net_wireless_libertas_if_sdio.patch    |  18 -
 .../drivers_net_wireless_mwifiex_sdio.patch        |  12 -
 .../network/27-hermes-read-pda-conflict/INFO       |   3 -
 .../drivers_net_wireless_orinoco_fw.patch          |  20 -
 .../drivers_net_wireless_orinoco_hermes.patch      |  22 -
 .../drivers_net_wireless_orinoco_orinoco_usb.patch |  11 -
 .../network/29-sdio_no_suspend/INFO                |   5 -
 .../drivers_bluetooth_btmrvl_sdio.patch            |  28 -
 .../drivers_net_wireless_ath_ath6kl_sdio.patch     |  47 --
 ..._wireless_brcm80211_brcmfmac_bcmsdh_sdmmc.patch |  38 -
 .../drivers_net_wireless_libertas_if_sdio.patch    |  29 -
 .../drivers_net_wireless_mwifiex_sdio.patch        |  68 --
 .../network/30-bridge-port/INFO                    |  23 -
 .../30-bridge-port/net_wireless_nl80211.patch      |  11 -
 .../network/30-bridge-port/net_wireless_util.patch |  11 -
 .../32-remove-ns-type/net_wireless_sysfs.patch     |  28 -
 .../network/36-workqueue/INFO                      |   3 -
 .../network/36-workqueue/net_mac80211_main.patch   |  13 -
 .../drivers_net_wireless_ath_main.patch            |  35 -
 .../drivers_net_wireless_iwlegacy_common.patch     |  12 -
 .../drivers_net_wireless_iwlwifi_dvm_led.patch     |  12 -
 .../drivers_net_wireless_iwlwifi_mvm_led.patch     |  12 -
 .../network/40-netdev-hw-features/INFO             |  20 -
 .../drivers_net_ethernet_atheros_alx_main.patch    |  58 --
 ..._net_ethernet_atheros_atl1c_atl1c_ethtool.patch |  28 -
 ...ers_net_ethernet_atheros_atl1c_atl1c_main.patch |  72 --
 ..._net_ethernet_atheros_atl1e_atl1e_ethtool.patch |  14 -
 ...ers_net_ethernet_atheros_atl1e_atl1e_main.patch |  75 --
 .../drivers_net_ethernet_atheros_atlx_atl1.patch   |  55 --
 .../drivers_net_ethernet_atheros_atlx_atl2.patch   |  98 ---
 .../drivers_net_ethernet_atheros_atlx_atlx.patch   |  17 -
 .../drivers_net_wireless_ath_ath6kl_main.patch     |  40 -
 .../drivers_net_wireless_ath_wil6210_netdev.patch  |  16 -
 .../drivers_net_wireless_ath_wcn36xx_main.patch    |  28 -
 .../drivers_net_wireless_ti_wl12xx_main.patch      |  23 -
 .../network/47-no_trans_start_on_netdev_queue/INFO |   4 -
 .../drivers_net_wireless_mwifiex_init.patch        |  13 -
 .../network/48-use_skb_get_queue_mapping/INFO      |   4 -
 .../drivers_net_wireless_b43_main.patch            |  17 -
 .../drivers_net_wireless_b43legacy_main.patch      |  17 -
 .../collateral-evolutions/network/52-tty-dev/INFO  |  19 -
 .../52-tty-dev/drivers_bluetooth_hci_ldisc.patch   |  13 -
 .../network/61-netdev-addr_assign_type/INFO        |   7 -
 .../drivers_net_ethernet_atheros_alx_main.patch    |  13 -
 ...ers_net_ethernet_atheros_atl1c_atl1c_main.patch |  12 -
 .../drivers_net_ethernet_atheros_atlx_atl1.patch   |  12 -
 .../net_bluetooth_6lowpan.patch                    |  12 -
 .../61-netdev-addr_assign_type/usbnet.patch        |  14 -
 .../network/64-b44-32bit-stats/INFO                |  14 -
 .../network/64-b44-32bit-stats/alx.patch           |  36 -
 .../drivers_net_ethernet_broadcom_b44.patch        |  40 -
 .../network/65-ignore-dismantle/INFO               |   9 -
 .../drivers_net_wireless_libertas_main.patch       |  14 -
 .../drivers_net_wireless_ath_ath5k_led.patch       |  11 -
 .../network/67-ipv6-dev-list/INFO                  |   8 -
 .../drivers_net_wireless_iwlwifi_mvm_d3.patch      |  14 -
 .../network/69-wowlan-no-socket/INFO               |   2 -
 .../69-wowlan-no-socket/net_wireless_nl80211.patch |  11 -
 .../drivers_net_wireless_ti_wlcore_main.patch      |  14 -
 .../network/72-brcm80211-makefiles/INFO            |   3 -
 .../network/73-ath5k-tracing/INFO                  |  11 -
 .../75-cw1200-workqueues/cw1200_workqueues.patch   | 129 ---
 .../network/81-genl-const/INFO                     |   3 -
 .../network/82-struct_property_missing/INFO        |   4 -
 .../82-struct_property_missing/mwifiex.patch       |  32 -
 .../0001-igb_net_device_ops.patch                  |   6 +-
 .../0002-igb_pci_sriov_configure.patch             |   8 +-
 .../0001-ethernet-igb}/0004-igb_err_handler.patch  |   0
 .../0001-ethernet-igb}/0005-igb_mdi.patch          |   0
 .../0001-ethernet-igb}/0006-igb_eee.patch          |   2 +-
 .../0001-ethernet-igb}/0007-igb_ethtool_ops.patch  |   4 +-
 .../0001-ethernet-igb}/0008-igb_no_fcs.patch       |   2 +-
 .../0001-ethernet-igb}/0009-igb_vlan_rx_vid.patch  |   6 +-
 .../0001-ethernet-igb}/0010-igb_ethtool_ops.patch  |  10 +-
 .../0001-ethernet-igb}/0011-igb_ethtool_ops.patch  |   2 +-
 .../0012-igb_ndo_set_vf_spoofchk.patch             |   8 +-
 .../0001-ethernet-igb}/0013-igb_hwmon.patch        |   0
 .../0001-ethernet-igb/INFO                         |  10 +
 341 files changed, 316 insertions(+), 13198 deletions(-)
 delete mode 100644 backport/backport-include/asm-generic/pci-dma-compat.h
 delete mode 100644 backport/backport-include/asm/unaligned.h
 delete mode 100644 backport/backport-include/crypto/aes.h
 delete mode 100644 backport/backport-include/linux/atomic.h
 delete mode 100644 backport/backport-include/linux/bitops.h
 delete mode 100644 backport/backport-include/linux/bug.h
 delete mode 100644 backport/backport-include/linux/debugfs.h
 delete mode 100644 backport/backport-include/linux/delay.h
 delete mode 100644 backport/backport-include/linux/dma-attrs.h
 delete mode 100644 backport/backport-include/linux/firmware.h
 delete mode 100644 backport/backport-include/linux/in.h
 delete mode 100644 backport/backport-include/linux/interrupt.h
 delete mode 100644 backport/backport-include/linux/irq.h
 delete mode 100644 backport/backport-include/linux/kmemleak.h
 delete mode 100644 backport/backport-include/linux/ktime.h
 delete mode 100644 backport/backport-include/linux/math64.h
 delete mode 100644 backport/backport-include/linux/mmc/core.h
 delete mode 100644 backport/backport-include/linux/pci-aspm.h
 delete mode 100644 backport/backport-include/linux/pm_runtime.h
 delete mode 100644 backport/backport-include/linux/semaphore.h
 delete mode 100644 backport/backport-include/linux/time.h
 delete mode 100644 backport/backport-include/linux/timer.h
 delete mode 100644 backport/backport-include/linux/tracepoint.h
 delete mode 100644 backport/backport-include/linux/types.h
 delete mode 100644 backport/backport-include/linux/vmalloc.h
 delete mode 100644 backport/backport-include/linux/wait.h
 delete mode 100644 backport/backport-include/net/dst.h
 delete mode 100644 backport/backport-include/net/iw_handler.h
 delete mode 100644 backport/backport-include/pcmcia/cistpl.h
 delete mode 100644 backport/backport-include/trace/define_trace.h
 create mode 100644 backport/backport-include/uapi/linux/sockios.h
 delete mode 100644 backport/compat/compat-2.6.26.c
 delete mode 100644 backport/compat/compat-2.6.27.c
 delete mode 100644 backport/compat/compat-2.6.28.c
 delete mode 100644 backport/compat/compat-2.6.29.c
 delete mode 100644 backport/compat/compat-2.6.32.c
 delete mode 100644 backport/compat/compat-2.6.33.c
 delete mode 100644 backport/compat/compat-2.6.34.c
 delete mode 100644 backport/compat/compat-2.6.34.h
 delete mode 100644 backport/compat/compat-2.6.35.c
 delete mode 100644 backport/compat/compat-2.6.36.c
 delete mode 100644 backport/compat/compat-2.6.37.c
 delete mode 100644 backport/compat/compat-2.6.39.c
 delete mode 100644 backport/compat/compat_atomic.c
 delete mode 100644 backport/compat/compat_firmware_class.c
 delete mode 100644 backport/compat/kfifo.c
 delete mode 100644 backport/compat/kstrtox.c
 create mode 100644 backport/defconfigs/hwsim
 delete mode 100755 backport/scripts/backport_firmware_install.sh
 delete mode 100644 backport/udev/50-compat_firmware.rules
 delete mode 100755 backport/udev/compat_firmware.sh
 delete mode 100755 backport/udev/ubuntu/compat_firmware.sh
 rename patches/{collateral-evolutions/media => 0000-upstream-backport-changes}/0003-technisat-usb2-led-rename.patch (100%)
 rename patches/{collateral-evolutions/regulator/0001-bt8xx-rename-dst-ops.patch => 0000-upstream-backport-changes/0004-bt8xx-rename-dst-ops.patch} (100%)
 rename patches/{collateral-evolutions/network/79-no-uapi => 0000-upstream-backport-changes/0005-uapi-compromise}/INFO (100%)
 rename patches/{collateral-evolutions/network/79-no-uapi => 0000-upstream-backport-changes/0005-uapi-compromise}/mwifiex.patch (100%)
 delete mode 100644 patches/backport-adjustments/sch_codel.patch
 delete mode 100644 patches/backport-adjustments/sch_fq_codel.patch
 create mode 100644 patches/collateral-evolutions/generic/0001-sysfs-api/INFO
 rename patches/collateral-evolutions/{network/76-sysfs-api => generic/0001-sysfs-api}/drivers_bcma.patch (100%)
 rename patches/collateral-evolutions/{media/0004-sysfs-api.patch => generic/0001-sysfs-api/drivers_media_v4l2-core_v4l2-dev.patch} (100%)
 rename patches/collateral-evolutions/{network/76-sysfs-api => generic/0001-sysfs-api}/drivers_ssb.patch (93%)
 rename patches/collateral-evolutions/{network/76-sysfs-api => generic/0001-sysfs-api}/net_ieee802154_wpan-class.patch (94%)
 rename patches/collateral-evolutions/{network/76-sysfs-api => generic/0001-sysfs-api}/net_wireless_sysfs.patch (88%)
 create mode 100644 patches/collateral-evolutions/generic/README
 rename patches/collateral-evolutions/media/{0002-dma_mmap_coherent-revert.patch => 0001-dma_mmap_coherent-revert.patch} (100%)
 delete mode 100644 patches/collateral-evolutions/network/0001-ndo_ioctl.patch
 delete mode 100644 patches/collateral-evolutions/network/0001-netdev_ops.cocci
 rename patches/collateral-evolutions/network/{0005-netlink-portid.cocci => 0001-netlink-portid.cocci} (100%)
 rename patches/collateral-evolutions/network/{0006-disable-dump-adjust-on-old-kernels.patch => 0002-disable-dump-adjust-on-old-kernels.patch} (92%)
 delete mode 100644 patches/collateral-evolutions/network/0002-net-misc/INFO
 delete mode 100644 patches/collateral-evolutions/network/0002-net-misc/libertas.patch
 rename patches/collateral-evolutions/network/{09-cfg80211-wext-padding => 0003-cfg80211-wext-padding}/INFO (100%)
 rename patches/collateral-evolutions/network/{09-cfg80211-wext-padding => 0003-cfg80211-wext-padding}/include_net_cfg80211.patch (85%)
 rename patches/collateral-evolutions/network/{09-cfg80211-wext-padding => 0003-cfg80211-wext-padding}/net_wireless_core.patch (100%)
 delete mode 100644 patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/INFO
 delete mode 100644 patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
 delete mode 100644 patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/orinoco.patch
 rename patches/collateral-evolutions/network/{0009-disable-wext-kconfig.patch => 0004-disable-wext-kconfig.patch} (100%)
 delete mode 100644 patches/collateral-evolutions/network/0004-wext-namespace.patch
 rename patches/collateral-evolutions/network/{0010-disable-usb-net-asix.patch => 0005-disable-usb-net-asix.patch} (100%)
 rename patches/collateral-evolutions/network/{0012-ieee802154-6lowpan-namespace.patch => 0006-ieee802154-6lowpan-namespace.patch} (100%)
 delete mode 100644 patches/collateral-evolutions/network/0007-ksize-orinoco.patch
 rename patches/collateral-evolutions/network/{0013-lowpan-inet_frag_lru_move.patch => 0007-lowpan-inet_frag_lru_move.patch} (100%)
 rename patches/collateral-evolutions/network/{0013-net-user-ns.patch => 0008-net-user-ns.patch} (100%)
 rename patches/collateral-evolutions/network/{0014-inet_frag_evictor.patch => 0009-inet_frag_evictor.patch} (100%)
 rename patches/collateral-evolutions/network/{10-add-wext-handlers-to-netdev => 0010-add-wext-handlers-to-netdev}/INFO (100%)
 rename patches/collateral-evolutions/network/{10-add-wext-handlers-to-netdev => 0010-add-wext-handlers-to-netdev}/net_wireless_core.patch (100%)
 rename patches/collateral-evolutions/network/{12-mac80211-disable-tx-status => 0011-mac80211-disable-tx-status}/INFO (100%)
 rename patches/collateral-evolutions/network/{12-mac80211-disable-tx-status => 0011-mac80211-disable-tx-status}/net_mac80211_tx.patch (100%)
 create mode 100644 patches/collateral-evolutions/network/0012-driver-quirks/INFO
 rename patches/collateral-evolutions/network/{26-sdio-quirks => 0012-driver-quirks}/drivers_net_wireless_cw1200_sdio.patch (100%)
 rename patches/collateral-evolutions/network/{35-fix-makefile-includes => 0013-fix-makefile-includes}/net_wireless_Makefile.patch (100%)
 rename patches/collateral-evolutions/network/{42-netlink_seq => 0014-netlink_seq}/net_wireless_nl80211.patch (82%)
 rename patches/collateral-evolutions/network/{43-rename_pm_qos_request => 0015-rename_pm_qos_request}/drivers_net_wireless_ipw2x00_ipw2100.patch (100%)
 delete mode 100644 patches/collateral-evolutions/network/0015-threaded-irq.cocci
 delete mode 100644 patches/collateral-evolutions/network/0015-threaded-irq/INFO
 delete mode 100644 patches/collateral-evolutions/network/0015-threaded-irq/drivers_net_wireless_iwlwifi_iwl-trans.patch
 rename patches/collateral-evolutions/network/{50-libertas-olpc-ec-wakeup => 0016-libertas-olpc-ec-wakeup}/INFO (100%)
 rename patches/collateral-evolutions/network/{50-libertas-olpc-ec-wakeup => 0016-libertas-olpc-ec-wakeup}/drivers_net_wireless_libertas_if_usb.patch (100%)
 delete mode 100644 patches/collateral-evolutions/network/0016-threaded-irq-one-shot.patch
 rename patches/collateral-evolutions/network/{54-get_ts_info => 0017-get_ts_info}/INFO (100%)
 rename patches/collateral-evolutions/network/{54-get_ts_info => 0017-get_ts_info}/drivers_net_usb_usbnet.patch (85%)
 rename patches/collateral-evolutions/network/{55-iwlwifi-msg-trace-fix => 0018-pv-trace-fixes}/INFO (71%)
 rename patches/collateral-evolutions/network/{55-iwlwifi-msg-trace-fix => 0018-pv-trace-fixes}/drivers_net_wireless_iwlwifi_iwl-debug.patch (100%)
 rename patches/collateral-evolutions/network/{56-mac80211-trace-fix => 0018-pv-trace-fixes}/net_mac80211_trace.patch (100%)
 rename patches/collateral-evolutions/network/{62-usb_driver_lpm.cocci => 0019-usb_driver_lpm.cocci} (100%)
 rename patches/collateral-evolutions/network/{63-tty-termios => 0020-tty-termios}/INFO (85%)
 rename patches/collateral-evolutions/network/{63-tty-termios => 0020-tty-termios}/drivers_bluetooth_hci_ath.patch (100%)
 rename patches/collateral-evolutions/network/{63-tty-termios => 0020-tty-termios}/net_bluetooth_rfcomm_tty.patch (86%)
 rename patches/collateral-evolutions/network/{70-umode_t-api-change => 0021-umode_t-api-change}/drivers_net_wireless_ath_ath9k_debug.patch (100%)
 create mode 100644 patches/collateral-evolutions/network/0022-define-tracing/INFO
 rename patches/collateral-evolutions/network/{74-define-tracing => 0022-define-tracing}/ath6kl.patch (100%)
 rename patches/collateral-evolutions/network/{74-define-tracing => 0022-define-tracing}/cfg80211.patch (100%)
 rename patches/collateral-evolutions/network/{74-define-tracing => 0022-define-tracing}/wil6210.patch (100%)
 rename patches/collateral-evolutions/network/{77-led-blink-api => 0024-led-blink-api}/INFO (100%)
 rename patches/collateral-evolutions/network/{77-led-blink-api => 0024-led-blink-api}/mac80211.patch (96%)
 rename patches/collateral-evolutions/network/{78-usb-sg => 0025-usb-sg}/INFO (68%)
 rename patches/collateral-evolutions/network/{78-usb-sg => 0025-usb-sg}/usbnet.patch (83%)
 rename patches/collateral-evolutions/network/{80-ipv6_stub => 0026-ipv6_stub}/INFO (74%)
 rename patches/collateral-evolutions/network/{80-ipv6_stub => 0026-ipv6_stub}/cdc_mbim.patch (100%)
 create mode 100644 patches/collateral-evolutions/network/0027-genl-const/INFO
 rename patches/collateral-evolutions/network/{81-genl-const => 0027-genl-const}/hwsim.patch (100%)
 rename patches/collateral-evolutions/network/{81-genl-const => 0027-genl-const}/ieee802154.patch (90%)
 rename patches/collateral-evolutions/network/{81-genl-const => 0027-genl-const}/nfc.patch (100%)
 rename patches/collateral-evolutions/network/{81-genl-const => 0027-genl-const}/nl80211.patch (90%)
 rename patches/collateral-evolutions/network/{83-select_queue => 0028-select_queue}/INFO (74%)
 rename patches/collateral-evolutions/network/{83-select_queue => 0028-select_queue}/mac80211.patch (91%)
 rename patches/collateral-evolutions/network/{83-select_queue => 0028-select_queue}/mwifiex.patch (92%)
 create mode 100644 patches/collateral-evolutions/network/0029-struct_hid_ll_driver-extensions/INFO
 rename patches/collateral-evolutions/network/{85-hid_ll_driver => 0029-struct_hid_ll_driver-extensions}/net_bluetooth_hidp_core.patch (100%)
 create mode 100644 patches/collateral-evolutions/network/0030-qdisc_tx_busylock/INFO
 rename patches/collateral-evolutions/network/{86-qdisc_tx_busylock => 0030-qdisc_tx_busylock}/ieee802154.patch (100%)
 delete mode 100644 patches/collateral-evolutions/network/05-usb/INFO
 delete mode 100644 patches/collateral-evolutions/network/05-usb/ath9k_htc.patch
 delete mode 100644 patches/collateral-evolutions/network/05-usb/p54usb.patch
 delete mode 100644 patches/collateral-evolutions/network/06-header-changes/INFO
 delete mode 100644 patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_b43_phy_common.patch
 delete mode 100644 patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_iwlwifi.patch
 delete mode 100644 patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_mwifiex_usb.patch
 delete mode 100644 patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_rtlwifi_base.patch
 delete mode 100644 patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_ti_wl1251_main.patch
 delete mode 100644 patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_ti_wl1251_spi.patch
 delete mode 100644 patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_ti_wlcore_event.patch
 delete mode 100644 patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_ti_wlcore_scan.patch
 delete mode 100644 patches/collateral-evolutions/network/06-header-changes/net_bluetooth_bnep_sock.patch
 delete mode 100644 patches/collateral-evolutions/network/06-header-changes/net_bluetooth_hci_sock.patch
 delete mode 100644 patches/collateral-evolutions/network/06-header-changes/net_bluetooth_hidp_sock.patch
 delete mode 100644 patches/collateral-evolutions/network/11-dev-pm-ops.cocci
 delete mode 100644 patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_3945-mac.patch
 delete mode 100644 patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_4965-mac.patch
 delete mode 100644 patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_common.patch
 delete mode 100644 patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_libertas_if_spi.patch
 delete mode 100644 patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_mwifiex_pcie.patch
 delete mode 100644 patches/collateral-evolutions/network/12-iw_handler-changes/drivers_net_wireless_ipw2x00_ipw2100.patch
 delete mode 100644 patches/collateral-evolutions/network/16-bluetooth/INFO
 delete mode 100644 patches/collateral-evolutions/network/16-bluetooth/drivers_bluetooth_hci_ldisc.patch
 delete mode 100644 patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_af_bluetooth.patch
 delete mode 100644 patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_bnep_sock.patch
 delete mode 100644 patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_cmtp_capi.patch
 delete mode 100644 patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_cmtp_sock.patch
 delete mode 100644 patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sock.patch
 delete mode 100644 patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_sock.patch
 delete mode 100644 patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_l2cap_sock.patch
 delete mode 100644 patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_sock.patch
 delete mode 100644 patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_tty.patch
 delete mode 100644 patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_sco.patch
 delete mode 100644 patches/collateral-evolutions/network/17-netdev-queue/INFO
 delete mode 100644 patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
 delete mode 100644 patches/collateral-evolutions/network/21-capi-proc_fops/INFO
 delete mode 100644 patches/collateral-evolutions/network/21-capi-proc_fops/net_bluetooth_cmtp_capi.patch
 delete mode 100644 patches/collateral-evolutions/network/22-multiqueue/INFO
 delete mode 100644 patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
 delete mode 100644 patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bluecard_cs.patch
 delete mode 100644 patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bt3c_cs.patch
 delete mode 100644 patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_btuart_cs.patch
 delete mode 100644 patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_dtl1_cs.patch
 delete mode 100644 patches/collateral-evolutions/network/24-pcmcia/drivers_net_wireless_b43_pcmcia.patch
 delete mode 100644 patches/collateral-evolutions/network/24-pcmcia/drivers_net_wireless_libertas_if_cs.patch
 delete mode 100644 patches/collateral-evolutions/network/24-pcmcia/drivers_net_wireless_orinoco_orinoco_cs.patch
 delete mode 100644 patches/collateral-evolutions/network/24-pcmcia/drivers_net_wireless_orinoco_spectrum_cs.patch
 delete mode 100644 patches/collateral-evolutions/network/24-pcmcia/drivers_ssb_main.patch
 delete mode 100644 patches/collateral-evolutions/network/25-multicast-list_head/INFO
 delete mode 100644 patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_adm8211.patch
 delete mode 100644 patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ath_ath5k_mac80211-ops.patch
 delete mode 100644 patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ath_carl9170_main.patch
 delete mode 100644 patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_cw1200_sta.patch
 delete mode 100644 patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_iwlwifi.patch
 delete mode 100644 patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_libertas_tf_main.patch
 delete mode 100644 patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_mwl8k.patch
 delete mode 100644 patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_p54_main.patch
 delete mode 100644 patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_rtl818x_rtl8180_dev.patch
 delete mode 100644 patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_rtl818x_rtl8187_dev.patch
 delete mode 100644 patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ti_wlcore_main.patch
 delete mode 100644 patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_zd1211rw_zd_mac.patch
 delete mode 100644 patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
 delete mode 100644 patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_driver-ops.patch
 delete mode 100644 patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
 delete mode 100644 patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
 delete mode 100644 patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_main.patch
 delete mode 100644 patches/collateral-evolutions/network/25-multicast.cocci
 delete mode 100644 patches/collateral-evolutions/network/26-sdio-quirks/INFO
 delete mode 100644 patches/collateral-evolutions/network/26-sdio-quirks/drivers_net_wireless_libertas_if_sdio.patch
 delete mode 100644 patches/collateral-evolutions/network/26-sdio-quirks/drivers_net_wireless_mwifiex_sdio.patch
 delete mode 100644 patches/collateral-evolutions/network/27-hermes-read-pda-conflict/INFO
 delete mode 100644 patches/collateral-evolutions/network/27-hermes-read-pda-conflict/drivers_net_wireless_orinoco_fw.patch
 delete mode 100644 patches/collateral-evolutions/network/27-hermes-read-pda-conflict/drivers_net_wireless_orinoco_hermes.patch
 delete mode 100644 patches/collateral-evolutions/network/27-hermes-read-pda-conflict/drivers_net_wireless_orinoco_orinoco_usb.patch
 delete mode 100644 patches/collateral-evolutions/network/29-sdio_no_suspend/INFO
 delete mode 100644 patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_bluetooth_btmrvl_sdio.patch
 delete mode 100644 patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_ath_ath6kl_sdio.patch
 delete mode 100644 patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_brcm80211_brcmfmac_bcmsdh_sdmmc.patch
 delete mode 100644 patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_libertas_if_sdio.patch
 delete mode 100644 patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_mwifiex_sdio.patch
 delete mode 100644 patches/collateral-evolutions/network/30-bridge-port/INFO
 delete mode 100644 patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
 delete mode 100644 patches/collateral-evolutions/network/30-bridge-port/net_wireless_util.patch
 delete mode 100644 patches/collateral-evolutions/network/32-remove-ns-type/net_wireless_sysfs.patch
 delete mode 100644 patches/collateral-evolutions/network/36-workqueue/INFO
 delete mode 100644 patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch
 delete mode 100644 patches/collateral-evolutions/network/37-vsnprintk/drivers_net_wireless_ath_main.patch
 delete mode 100644 patches/collateral-evolutions/network/38-led-max-brightness/drivers_net_wireless_iwlegacy_common.patch
 delete mode 100644 patches/collateral-evolutions/network/38-led-max-brightness/drivers_net_wireless_iwlwifi_dvm_led.patch
 delete mode 100644 patches/collateral-evolutions/network/38-led-max-brightness/drivers_net_wireless_iwlwifi_mvm_led.patch
 delete mode 100644 patches/collateral-evolutions/network/40-netdev-hw-features/INFO
 delete mode 100644 patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch
 delete mode 100644 patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1c_atl1c_ethtool.patch
 delete mode 100644 patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
 delete mode 100644 patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1e_atl1e_ethtool.patch
 delete mode 100644 patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1e_atl1e_main.patch
 delete mode 100644 patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl1.patch
 delete mode 100644 patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl2.patch
 delete mode 100644 patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atlx.patch
 delete mode 100644 patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_wireless_ath_ath6kl_main.patch
 delete mode 100644 patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_wireless_ath_wil6210_netdev.patch
 delete mode 100644 patches/collateral-evolutions/network/45-remove-platform-id-table/drivers_net_wireless_ath_wcn36xx_main.patch
 delete mode 100644 patches/collateral-evolutions/network/45-remove-platform-id-table/drivers_net_wireless_ti_wl12xx_main.patch
 delete mode 100644 patches/collateral-evolutions/network/47-no_trans_start_on_netdev_queue/INFO
 delete mode 100644 patches/collateral-evolutions/network/47-no_trans_start_on_netdev_queue/drivers_net_wireless_mwifiex_init.patch
 delete mode 100644 patches/collateral-evolutions/network/48-use_skb_get_queue_mapping/INFO
 delete mode 100644 patches/collateral-evolutions/network/48-use_skb_get_queue_mapping/drivers_net_wireless_b43_main.patch
 delete mode 100644 patches/collateral-evolutions/network/48-use_skb_get_queue_mapping/drivers_net_wireless_b43legacy_main.patch
 delete mode 100644 patches/collateral-evolutions/network/52-tty-dev/INFO
 delete mode 100644 patches/collateral-evolutions/network/52-tty-dev/drivers_bluetooth_hci_ldisc.patch
 delete mode 100644 patches/collateral-evolutions/network/61-netdev-addr_assign_type/INFO
 delete mode 100644 patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_alx_main.patch
 delete mode 100644 patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
 delete mode 100644 patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_atlx_atl1.patch
 delete mode 100644 patches/collateral-evolutions/network/61-netdev-addr_assign_type/net_bluetooth_6lowpan.patch
 delete mode 100644 patches/collateral-evolutions/network/61-netdev-addr_assign_type/usbnet.patch
 delete mode 100644 patches/collateral-evolutions/network/64-b44-32bit-stats/INFO
 delete mode 100644 patches/collateral-evolutions/network/64-b44-32bit-stats/alx.patch
 delete mode 100644 patches/collateral-evolutions/network/64-b44-32bit-stats/drivers_net_ethernet_broadcom_b44.patch
 delete mode 100644 patches/collateral-evolutions/network/65-ignore-dismantle/INFO
 delete mode 100644 patches/collateral-evolutions/network/65-ignore-dismantle/drivers_net_wireless_libertas_main.patch
 delete mode 100644 patches/collateral-evolutions/network/67-fix-section-mismatch/drivers_net_wireless_ath_ath5k_led.patch
 delete mode 100644 patches/collateral-evolutions/network/67-ipv6-dev-list/INFO
 delete mode 100644 patches/collateral-evolutions/network/67-ipv6-dev-list/drivers_net_wireless_iwlwifi_mvm_d3.patch
 delete mode 100644 patches/collateral-evolutions/network/69-wowlan-no-socket/INFO
 delete mode 100644 patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
 delete mode 100644 patches/collateral-evolutions/network/71-bin_attribute-api-change/drivers_net_wireless_ti_wlcore_main.patch
 delete mode 100644 patches/collateral-evolutions/network/72-brcm80211-makefiles/INFO
 delete mode 100644 patches/collateral-evolutions/network/73-ath5k-tracing/INFO
 delete mode 100644 patches/collateral-evolutions/network/75-cw1200-workqueues/cw1200_workqueues.patch
 delete mode 100644 patches/collateral-evolutions/network/81-genl-const/INFO
 delete mode 100644 patches/collateral-evolutions/network/82-struct_property_missing/INFO
 delete mode 100644 patches/collateral-evolutions/network/82-struct_property_missing/mwifiex.patch
 rename patches/{collateral-evolutions/network/84-ethernet => the-way-not-to-do-backports/0001-ethernet-igb}/0001-igb_net_device_ops.patch (91%)
 rename patches/{collateral-evolutions/network/84-ethernet => the-way-not-to-do-backports/0001-ethernet-igb}/0002-igb_pci_sriov_configure.patch (88%)
 rename patches/{collateral-evolutions/network/84-ethernet => the-way-not-to-do-backports/0001-ethernet-igb}/0004-igb_err_handler.patch (100%)
 rename patches/{collateral-evolutions/network/84-ethernet => the-way-not-to-do-backports/0001-ethernet-igb}/0005-igb_mdi.patch (100%)
 rename patches/{collateral-evolutions/network/84-ethernet => the-way-not-to-do-backports/0001-ethernet-igb}/0006-igb_eee.patch (94%)
 rename patches/{collateral-evolutions/network/84-ethernet => the-way-not-to-do-backports/0001-ethernet-igb}/0007-igb_ethtool_ops.patch (93%)
 rename patches/{collateral-evolutions/network/84-ethernet => the-way-not-to-do-backports/0001-ethernet-igb}/0008-igb_no_fcs.patch (89%)
 rename patches/{collateral-evolutions/network/84-ethernet => the-way-not-to-do-backports/0001-ethernet-igb}/0009-igb_vlan_rx_vid.patch (92%)
 rename patches/{collateral-evolutions/network/84-ethernet => the-way-not-to-do-backports/0001-ethernet-igb}/0010-igb_ethtool_ops.patch (80%)
 rename patches/{collateral-evolutions/network/84-ethernet => the-way-not-to-do-backports/0001-ethernet-igb}/0011-igb_ethtool_ops.patch (94%)
 rename patches/{collateral-evolutions/network/84-ethernet => the-way-not-to-do-backports/0001-ethernet-igb}/0012-igb_ndo_set_vf_spoofchk.patch (88%)
 rename patches/{collateral-evolutions/network/84-ethernet => the-way-not-to-do-backports/0001-ethernet-igb}/0013-igb_hwmon.patch (100%)
 create mode 100644 patches/the-way-not-to-do-backports/0001-ethernet-igb/INFO

-- 
1.9.1

