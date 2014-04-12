Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:55243 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755055AbaDLBf1 (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 11 Apr 2014 21:35:27 -0400
Received: by mail-pa0-f54.google.com with SMTP id lf10so6049976pab.41
        for <backports@vger.kernel.org>; Fri, 11 Apr 2014 18:35:25 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 09/10] backports: nuke support for kernels < 3.0
Date: Fri, 11 Apr 2014 18:34:34 -0700
Message-Id: <1397266475-14442-10-git-send-email-mcgrof@do-not-panic.com> (sfid-20140412_033541_807298_3C62891A)
In-Reply-To: <1397266475-14442-1-git-send-email-mcgrof@do-not-panic.com>
References: <1397266475-14442-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

mcgrof@drvbp1 ~/backports (git::master)$ time ./gentree.py --clean
/home/mcgrof/linux-next /home/mcgrof/build/next-20140409
Copy original source files ...
Apply patches ...
Modify Kconfig tree ...
Rewrite Makefiles and Kconfig files ...
Done!

real    1m30.186s
user    9m25.180s
sys     0m24.428s

mcgrof@drvbp1 ~/build/next-20140409 $ time ckmake --allyesconfig
1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.54              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.79              [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.29             [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.10             [  OK  ]
14  3.13.2              [  OK  ]
15  3.14-rc1            [  OK  ]

real    26m54.859s
user    744m15.764s
sys     83m47.440s

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
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
 backport/backport-include/linux/device.h           |  94 +--
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
 backport/backport-include/linux/netdevice.h        | 432 +---------
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
 backport/scripts/backport_firmware_install.sh      |  21 -
 backport/udev/50-compat_firmware.rules             |   4 -
 backport/udev/compat_firmware.sh                   |  35 -
 backport/udev/ubuntu/compat_firmware.sh            |  29 -
 dependencies                                       |  65 --
 devel/backports-update-manager                     |  57 --
 gentree.py                                         |   2 +-
 .../0003-technisat-usb2-led-rename.patch           |   0
 .../0004-bt8xx-rename-dst-ops.patch}               |   0
 .../0005-uapi-compromise}/INFO                     |   0
 .../0005-uapi-compromise}/mwifiex.patch            |   0
 patches/backport-adjustments/sch_codel.patch       |  98 ---
 patches/backport-adjustments/sch_fq_codel.patch    | 106 ---
 .../generic/0001-sysfs-api/INFO                    |  36 +
 .../0001-sysfs-api}/drivers_bcma.patch             |   0
 .../drivers_media_v4l2-core_v4l2-dev.patch}        |   0
 .../0001-sysfs-api}/drivers_ssb.patch              |   0
 .../net_ieee802154_wpan-class.patch                |   0
 .../0001-sysfs-api}/net_wireless_sysfs.patch       |   0
 patches/collateral-evolutions/generic/README       |   1 +
 ...t.patch => 0001-dma_mmap_coherent-revert.patch} |   0
 .../network/0001-ndo_ioctl.patch                   |  51 --
 .../network/0001-netdev_ops.cocci                  |   6 -
 ...link-portid.cocci => 0001-netlink-portid.cocci} |   0
 ... 0002-disable-dump-adjust-on-old-kernels.patch} |   0
 .../network/0002-net-misc/INFO                     |   8 -
 .../network/0002-net-misc/libertas.patch           |  17 -
 .../INFO                                           |   0
 .../include_net_cfg80211.patch                     |   0
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
 .../net_wireless_nl80211.patch                     |   0
 .../drivers_net_wireless_ipw2x00_ipw2100.patch     |   0
 .../network/0015-threaded-irq.cocci                |  75 --
 .../network/0015-threaded-irq/INFO                 |   5 -
 .../drivers_net_wireless_iwlwifi_iwl-trans.patch   |  12 -
 .../INFO                                           |   0
 .../drivers_net_wireless_libertas_if_usb.patch     |   0
 .../network/0016-threaded-irq-one-shot.patch       |  38 -
 .../{54-get_ts_info => 0017-get_ts_info}/INFO      |   0
 .../drivers_net_usb_usbnet.patch                   |   0
 .../INFO                                           |   2 +
 .../drivers_net_wireless_iwlwifi_iwl-debug.patch   |   0
 .../net_mac80211_trace.patch                       |   0
 ..._driver_lpm.cocci => 0019-usb_driver_lpm.cocci} |   0
 .../{63-tty-termios => 0020-tty-termios}/INFO      |   2 +
 .../drivers_bluetooth_hci_ath.patch                |   0
 .../net_bluetooth_rfcomm_tty.patch                 |   0
 .../drivers_net_wireless_ath_ath9k_debug.patch     |   0
 .../network/0022-define-tracing/INFO               |   9 +
 .../ath6kl.patch                                   |   0
 .../cfg80211.patch                                 |   0
 .../wil6210.patch                                  |   0
 .../{77-led-blink-api => 0024-led-blink-api}/INFO  |   0
 .../mac80211.patch                                 |   0
 .../network/{78-usb-sg => 0025-usb-sg}/INFO        |   5 +
 .../{78-usb-sg => 0025-usb-sg}/usbnet.patch        |   0
 .../network/{80-ipv6_stub => 0026-ipv6_stub}/INFO  |   3 +
 .../cdc_mbim.patch                                 |   0
 .../network/0027-genl-const/INFO                   |  15 +
 .../{81-genl-const => 0027-genl-const}/hwsim.patch |   0
 .../ieee802154.patch                               |   0
 .../{81-genl-const => 0027-genl-const}/nfc.patch   |   0
 .../nl80211.patch                                  |   0
 .../{83-select_queue => 0028-select_queue}/INFO    |   3 +
 .../mac80211.patch                                 |   0
 .../mwifiex.patch                                  |   0
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
 .../0001-igb_net_device_ops.patch                  |   0
 .../0002-igb_pci_sriov_configure.patch             |   0
 .../0001-ethernet-igb}/0004-igb_err_handler.patch  |   0
 .../0001-ethernet-igb}/0005-igb_mdi.patch          |   0
 .../0001-ethernet-igb}/0006-igb_eee.patch          |   0
 .../0001-ethernet-igb}/0007-igb_ethtool_ops.patch  |   0
 .../0001-ethernet-igb}/0008-igb_no_fcs.patch       |   0
 .../0001-ethernet-igb}/0009-igb_vlan_rx_vid.patch  |   0
 .../0001-ethernet-igb}/0010-igb_ethtool_ops.patch  |   0
 .../0001-ethernet-igb}/0011-igb_ethtool_ops.patch  |   0
 .../0012-igb_ndo_set_vf_spoofchk.patch             |   0
 .../0001-ethernet-igb}/0013-igb_hwmon.patch        |   0
 .../0001-ethernet-igb/INFO                         |  10 +
 337 files changed, 157 insertions(+), 13138 deletions(-)
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
 rename patches/collateral-evolutions/{network/76-sysfs-api => generic/0001-sysfs-api}/drivers_ssb.patch (100%)
 rename patches/collateral-evolutions/{network/76-sysfs-api => generic/0001-sysfs-api}/net_ieee802154_wpan-class.patch (100%)
 rename patches/collateral-evolutions/{network/76-sysfs-api => generic/0001-sysfs-api}/net_wireless_sysfs.patch (100%)
 create mode 100644 patches/collateral-evolutions/generic/README
 rename patches/collateral-evolutions/media/{0002-dma_mmap_coherent-revert.patch => 0001-dma_mmap_coherent-revert.patch} (100%)
 delete mode 100644 patches/collateral-evolutions/network/0001-ndo_ioctl.patch
 delete mode 100644 patches/collateral-evolutions/network/0001-netdev_ops.cocci
 rename patches/collateral-evolutions/network/{0005-netlink-portid.cocci => 0001-netlink-portid.cocci} (100%)
 rename patches/collateral-evolutions/network/{0006-disable-dump-adjust-on-old-kernels.patch => 0002-disable-dump-adjust-on-old-kernels.patch} (100%)
 delete mode 100644 patches/collateral-evolutions/network/0002-net-misc/INFO
 delete mode 100644 patches/collateral-evolutions/network/0002-net-misc/libertas.patch
 rename patches/collateral-evolutions/network/{09-cfg80211-wext-padding => 0003-cfg80211-wext-padding}/INFO (100%)
 rename patches/collateral-evolutions/network/{09-cfg80211-wext-padding => 0003-cfg80211-wext-padding}/include_net_cfg80211.patch (100%)
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
 rename patches/collateral-evolutions/network/{42-netlink_seq => 0014-netlink_seq}/net_wireless_nl80211.patch (100%)
 rename patches/collateral-evolutions/network/{43-rename_pm_qos_request => 0015-rename_pm_qos_request}/drivers_net_wireless_ipw2x00_ipw2100.patch (100%)
 delete mode 100644 patches/collateral-evolutions/network/0015-threaded-irq.cocci
 delete mode 100644 patches/collateral-evolutions/network/0015-threaded-irq/INFO
 delete mode 100644 patches/collateral-evolutions/network/0015-threaded-irq/drivers_net_wireless_iwlwifi_iwl-trans.patch
 rename patches/collateral-evolutions/network/{50-libertas-olpc-ec-wakeup => 0016-libertas-olpc-ec-wakeup}/INFO (100%)
 rename patches/collateral-evolutions/network/{50-libertas-olpc-ec-wakeup => 0016-libertas-olpc-ec-wakeup}/drivers_net_wireless_libertas_if_usb.patch (100%)
 delete mode 100644 patches/collateral-evolutions/network/0016-threaded-irq-one-shot.patch
 rename patches/collateral-evolutions/network/{54-get_ts_info => 0017-get_ts_info}/INFO (100%)
 rename patches/collateral-evolutions/network/{54-get_ts_info => 0017-get_ts_info}/drivers_net_usb_usbnet.patch (100%)
 rename patches/collateral-evolutions/network/{55-iwlwifi-msg-trace-fix => 0018-pv-trace-fixes}/INFO (71%)
 rename patches/collateral-evolutions/network/{55-iwlwifi-msg-trace-fix => 0018-pv-trace-fixes}/drivers_net_wireless_iwlwifi_iwl-debug.patch (100%)
 rename patches/collateral-evolutions/network/{56-mac80211-trace-fix => 0018-pv-trace-fixes}/net_mac80211_trace.patch (100%)
 rename patches/collateral-evolutions/network/{62-usb_driver_lpm.cocci => 0019-usb_driver_lpm.cocci} (100%)
 rename patches/collateral-evolutions/network/{63-tty-termios => 0020-tty-termios}/INFO (85%)
 rename patches/collateral-evolutions/network/{63-tty-termios => 0020-tty-termios}/drivers_bluetooth_hci_ath.patch (100%)
 rename patches/collateral-evolutions/network/{63-tty-termios => 0020-tty-termios}/net_bluetooth_rfcomm_tty.patch (100%)
 rename patches/collateral-evolutions/network/{70-umode_t-api-change => 0021-umode_t-api-change}/drivers_net_wireless_ath_ath9k_debug.patch (100%)
 create mode 100644 patches/collateral-evolutions/network/0022-define-tracing/INFO
 rename patches/collateral-evolutions/network/{74-define-tracing => 0022-define-tracing}/ath6kl.patch (100%)
 rename patches/collateral-evolutions/network/{74-define-tracing => 0022-define-tracing}/cfg80211.patch (100%)
 rename patches/collateral-evolutions/network/{74-define-tracing => 0022-define-tracing}/wil6210.patch (100%)
 rename patches/collateral-evolutions/network/{77-led-blink-api => 0024-led-blink-api}/INFO (100%)
 rename patches/collateral-evolutions/network/{77-led-blink-api => 0024-led-blink-api}/mac80211.patch (100%)
 rename patches/collateral-evolutions/network/{78-usb-sg => 0025-usb-sg}/INFO (68%)
 rename patches/collateral-evolutions/network/{78-usb-sg => 0025-usb-sg}/usbnet.patch (100%)
 rename patches/collateral-evolutions/network/{80-ipv6_stub => 0026-ipv6_stub}/INFO (74%)
 rename patches/collateral-evolutions/network/{80-ipv6_stub => 0026-ipv6_stub}/cdc_mbim.patch (100%)
 create mode 100644 patches/collateral-evolutions/network/0027-genl-const/INFO
 rename patches/collateral-evolutions/network/{81-genl-const => 0027-genl-const}/hwsim.patch (100%)
 rename patches/collateral-evolutions/network/{81-genl-const => 0027-genl-const}/ieee802154.patch (100%)
 rename patches/collateral-evolutions/network/{81-genl-const => 0027-genl-const}/nfc.patch (100%)
 rename patches/collateral-evolutions/network/{81-genl-const => 0027-genl-const}/nl80211.patch (100%)
 rename patches/collateral-evolutions/network/{83-select_queue => 0028-select_queue}/INFO (74%)
 rename patches/collateral-evolutions/network/{83-select_queue => 0028-select_queue}/mac80211.patch (100%)
 rename patches/collateral-evolutions/network/{83-select_queue => 0028-select_queue}/mwifiex.patch (100%)
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
 rename patches/{collateral-evolutions/network/84-ethernet => the-way-not-to-do-backports/0001-ethernet-igb}/0001-igb_net_device_ops.patch (100%)
 rename patches/{collateral-evolutions/network/84-ethernet => the-way-not-to-do-backports/0001-ethernet-igb}/0002-igb_pci_sriov_configure.patch (100%)
 rename patches/{collateral-evolutions/network/84-ethernet => the-way-not-to-do-backports/0001-ethernet-igb}/0004-igb_err_handler.patch (100%)
 rename patches/{collateral-evolutions/network/84-ethernet => the-way-not-to-do-backports/0001-ethernet-igb}/0005-igb_mdi.patch (100%)
 rename patches/{collateral-evolutions/network/84-ethernet => the-way-not-to-do-backports/0001-ethernet-igb}/0006-igb_eee.patch (100%)
 rename patches/{collateral-evolutions/network/84-ethernet => the-way-not-to-do-backports/0001-ethernet-igb}/0007-igb_ethtool_ops.patch (100%)
 rename patches/{collateral-evolutions/network/84-ethernet => the-way-not-to-do-backports/0001-ethernet-igb}/0008-igb_no_fcs.patch (100%)
 rename patches/{collateral-evolutions/network/84-ethernet => the-way-not-to-do-backports/0001-ethernet-igb}/0009-igb_vlan_rx_vid.patch (100%)
 rename patches/{collateral-evolutions/network/84-ethernet => the-way-not-to-do-backports/0001-ethernet-igb}/0010-igb_ethtool_ops.patch (100%)
 rename patches/{collateral-evolutions/network/84-ethernet => the-way-not-to-do-backports/0001-ethernet-igb}/0011-igb_ethtool_ops.patch (100%)
 rename patches/{collateral-evolutions/network/84-ethernet => the-way-not-to-do-backports/0001-ethernet-igb}/0012-igb_ndo_set_vf_spoofchk.patch (100%)
 rename patches/{collateral-evolutions/network/84-ethernet => the-way-not-to-do-backports/0001-ethernet-igb}/0013-igb_hwmon.patch (100%)
 create mode 100644 patches/the-way-not-to-do-backports/0001-ethernet-igb/INFO

diff --git a/README b/README
index 9f7f1d6..50de954 100644
--- a/README
+++ b/README
@@ -12,7 +12,7 @@ down to older kernels. It currently backports the following subsystems:
   * Regulator
 
 This package provides the latest Linux kernel subsystem enhancements
-for kernels 2.6.25 and above.
+for kernels 3.0 and above.
 
 # Documentation
 
diff --git a/backport/Makefile.real b/backport/Makefile.real
index c09663c..b010dd7 100644
--- a/backport/Makefile.real
+++ b/backport/Makefile.real
@@ -90,7 +90,6 @@ install: modules
 	@./scripts/blacklist.sh $(KLIB)/ $(KLIB)/$(KMODDIR)
 	@./scripts/compress_modules.sh $(KLIB)/$(KMODDIR)
 	@./scripts/check_depmod.sh
-	@./scripts/backport_firmware_install.sh
 	@/sbin/depmod -a
 	@./scripts/update-initramfs.sh $(KLIB)
 	@echo
diff --git a/backport/backport-include/asm-generic/pci-dma-compat.h b/backport/backport-include/asm-generic/pci-dma-compat.h
deleted file mode 100644
index aa61f4d..0000000
--- a/backport/backport-include/asm-generic/pci-dma-compat.h
+++ /dev/null
@@ -1,17 +0,0 @@
-#ifndef __BACKPORT_ASM_PCI_DMA_COMPAT_H
-#define __BACKPORT_ASM_PCI_DMA_COMPAT_H
-#include_next <asm-generic/pci-dma-compat.h>
-#include <linux/version.h>
-
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27)
-#include <backport/magic.h>
-
-#define pci_dma_mapping_error1(dma_addr) dma_mapping_error1(dma_addr)
-#define pci_dma_mapping_error2(pdev, dma_addr) dma_mapping_error2(pdev, dma_addr)
-#undef pci_dma_mapping_error
-#define pci_dma_mapping_error(...) \
-	macro_dispatcher(pci_dma_mapping_error, __VA_ARGS__)(__VA_ARGS__)
-#endif
-
-#endif /* __BACKPORT_ASM_PCI_DMA_COMPAT_H */
diff --git a/backport/backport-include/asm/atomic.h b/backport/backport-include/asm/atomic.h
index cabdcfd..1dc93a3 100644
--- a/backport/backport-include/asm/atomic.h
+++ b/backport/backport-include/asm/atomic.h
@@ -12,26 +12,9 @@
  */
 #include <asm/atomic.h>
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,31)) && !defined(ATOMIC64_INIT) && !defined(CONFIG_X86) && !((LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,33)) && defined(CONFIG_ARM) && !defined(CONFIG_GENERIC_ATOMIC64))
+#if (!defined(ATOMIC64_INIT) && !defined(CONFIG_X86) && !(defined(CONFIG_ARM) && !defined(CONFIG_GENERIC_ATOMIC64)))
 #include <asm-generic/atomic64.h>
 #endif
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
-#ifndef CONFIG_64BIT
-
-typedef struct {
-	long long counter;
-} atomic64_t;
-
-#define atomic64_read LINUX_BACKPORT(atomic64_read)
-extern long long atomic64_read(const atomic64_t *v);
-#define atomic64_add_return LINUX_BACKPORT(atomic64_add_return)
-extern long long atomic64_add_return(long long a, atomic64_t *v);
-
-#define atomic64_inc_return(v)          atomic64_add_return(1LL, (v))
-
-#endif
-#endif
-
 #endif /* __BACKPORT_ASM_ATOMIC_H */
diff --git a/backport/backport-include/asm/unaligned.h b/backport/backport-include/asm/unaligned.h
deleted file mode 100644
index 7f552b8..0000000
--- a/backport/backport-include/asm/unaligned.h
+++ /dev/null
@@ -1,213 +0,0 @@
-#ifndef __BACKPORT_ASM_UNALIGNED_H
-#define __BACKPORT_ASM_UNALIGNED_H
-#include_next <asm/unaligned.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,26)
-/*
- * 2.6.26 added its own unaligned API which the
- * new drivers can use. Lets port it here by including it in older
- * kernels and also deal with the architecture handling here.
- */
-#ifdef CONFIG_ALPHA
-
-#include <linux/unaligned/be_struct.h>
-#include <linux/unaligned/le_byteshift.h>
-#include <linux/unaligned/generic.h>
-
-#endif /* alpha */
-#ifdef CONFIG_ARM
-
-/* arm */
-#include <linux/unaligned/le_byteshift.h>
-#include <linux/unaligned/be_byteshift.h>
-#include <linux/unaligned/generic.h>
-
-#endif /* arm */
-#ifdef CONFIG_AVR32
-
-/*
- * AVR32 can handle some unaligned accesses, depending on the
- * implementation.  The AVR32 AP implementation can handle unaligned
- * words, but halfwords must be halfword-aligned, and doublewords must
- * be word-aligned.
- *
- * However, swapped word loads must be word-aligned so we can't
- * optimize word loads in general.
- */
-
-#include <linux/unaligned/be_struct.h>
-#include <linux/unaligned/le_byteshift.h>
-#include <linux/unaligned/generic.h>
-
-#endif
-#ifdef CONFIG_BLACKFIN
-
-#include <linux/unaligned/le_struct.h>
-#include <linux/unaligned/be_byteshift.h>
-#include <linux/unaligned/generic.h>
-
-#endif /* blackfin */
-#ifdef CONFIG_CRIS
-
-/*
- * CRIS can do unaligned accesses itself.
- */
-#include <linux/unaligned/access_ok.h>
-#include <linux/unaligned/generic.h>
-
-#endif /* cris */
-#ifdef CONFIG_FRV
-
-#include <linux/unaligned/le_byteshift.h>
-#include <linux/unaligned/be_byteshift.h>
-#include <linux/unaligned/generic.h>
-
-#endif /* frv */
-#ifdef CONFIG_H8300
-
-#include <linux/unaligned/be_memmove.h>
-#include <linux/unaligned/le_byteshift.h>
-#include <linux/unaligned/generic.h>
-
-#endif /* h8300 */
-#ifdef  CONFIG_IA64
-
-#include <linux/unaligned/le_struct.h>
-#include <linux/unaligned/be_byteshift.h>
-#include <linux/unaligned/generic.h>
-
-#endif /* ia64 */
-#ifdef CONFIG_M32R
-
-#if defined(__LITTLE_ENDIAN__)
-# include <linux/unaligned/le_memmove.h>
-# include <linux/unaligned/be_byteshift.h>
-# include <linux/unaligned/generic.h>
-#else
-# include <linux/unaligned/be_memmove.h>
-# include <linux/unaligned/le_byteshift.h>
-# include <linux/unaligned/generic.h>
-#endif
-
-#endif /* m32r */
-#ifdef CONFIG_M68K /* this handles both m68k and m68knommu */
-
-#ifdef CONFIG_COLDFIRE
-#include <linux/unaligned/be_struct.h>
-#include <linux/unaligned/le_byteshift.h>
-#include <linux/unaligned/generic.h>
-#else
-
-/*
- * The m68k can do unaligned accesses itself.
- */
-#include <linux/unaligned/access_ok.h>
-#include <linux/unaligned/generic.h>
-#endif
-
-#endif /* m68k and m68knommu */
-#ifdef CONFIG_MIPS
-
-#if defined(__MIPSEB__)
-# include <linux/unaligned/be_struct.h>
-# include <linux/unaligned/le_byteshift.h>
-# include <linux/unaligned/generic.h>
-# define get_unaligned  __get_unaligned_be
-# define put_unaligned  __put_unaligned_be
-#elif defined(__MIPSEL__)
-# include <linux/unaligned/le_struct.h>
-# include <linux/unaligned/be_byteshift.h>
-# include <linux/unaligned/generic.h>
-#endif
-
-#endif /* mips */
-#ifdef CONFIG_MN10300
-
-#include <linux/unaligned/access_ok.h>
-#include <linux/unaligned/generic.h>
-
-#endif /* mn10300 */
-#ifdef CONFIG_PARISC
-
-#include <linux/unaligned/be_struct.h>
-#include <linux/unaligned/le_byteshift.h>
-#include <linux/unaligned/generic.h>
-
-#endif /* parisc */
-#ifdef CONFIG_PPC
-/*
- * The PowerPC can do unaligned accesses itself in big endian mode.
- */
-#include <linux/unaligned/access_ok.h>
-#include <linux/unaligned/generic.h>
-
-#endif /* ppc */
-#ifdef CONFIG_S390
-
-/*
- * The S390 can do unaligned accesses itself.
- */
-#include <linux/unaligned/access_ok.h>
-#include <linux/unaligned/generic.h>
-
-#endif /* s390 */
-#ifdef CONFIG_SUPERH
-
-/* SH can't handle unaligned accesses. */
-#ifdef __LITTLE_ENDIAN__
-# include <linux/unaligned/le_struct.h>
-# include <linux/unaligned/be_byteshift.h>
-# include <linux/unaligned/generic.h>
-#else
-# include <linux/unaligned/be_struct.h>
-# include <linux/unaligned/le_byteshift.h>
-# include <linux/unaligned/generic.h>
-#endif
-
-#endif /* sh - SUPERH */
-#ifdef CONFIG_SPARC
-
-/* sparc and sparc64 */
-#include <linux/unaligned/be_struct.h>
-#include <linux/unaligned/le_byteshift.h>
-#include <linux/unaligned/generic.h>
-
-#endif  /* sparc */
-#ifdef CONFIG_UML
-
-#include "asm/arch/unaligned.h"
-
-#endif /* um - uml */
-#ifdef CONFIG_V850
-
-#include <linux/unaligned/be_byteshift.h>
-#include <linux/unaligned/le_byteshift.h>
-#include <linux/unaligned/generic.h>
-
-#endif /* v850 */
-#ifdef CONFIG_X86
-/*
- * The x86 can do unaligned accesses itself.
- */
-#include <linux/unaligned/access_ok.h>
-#include <linux/unaligned/generic.h>
-
-#endif /* x86 */
-#ifdef CONFIG_XTENSA
-
-#ifdef __XTENSA_EL__
-# include <linux/unaligned/le_memmove.h>
-# include <linux/unaligned/be_byteshift.h>
-# include <linux/unaligned/generic.h>
-#elif defined(__XTENSA_EB__)
-# include <linux/unaligned/be_memmove.h>
-# include <linux/unaligned/le_byteshift.h>
-# include <linux/unaligned/generic.h>
-#else
-# error processor byte order undefined!
-#endif
-
-#endif /* xtensa */
-#endif /* < 2.6.26 */
-
-#endif /* __BACKPORT_ASM_UNALIGNED_H */
diff --git a/backport/backport-include/backport/checks.h b/backport/backport-include/backport/checks.h
index 6244559..d2c3492 100644
--- a/backport/backport-include/backport/checks.h
+++ b/backport/backport-include/backport/checks.h
@@ -1,10 +1,6 @@
 #ifndef __BACKPORT_CHECKS
 #define __BACKPORT_CHECKS
 
-#if defined(CPTCFG_BACKPORT_KERNEL_2_6_28) && defined(CONFIG_DYNAMIC_FTRACE)
-#error "You can't build on a 2.6.27 or older kernel with dynamic ftrace, it's broken"
-#endif
-
 #if defined(CONFIG_MAC80211) && defined(CPTCFG_MAC80211)
 #error "You must not have mac80211 built into your kernel if you want to enable it"
 #endif
diff --git a/backport/backport-include/crypto/aes.h b/backport/backport-include/crypto/aes.h
deleted file mode 100644
index 8031a54..0000000
--- a/backport/backport-include/crypto/aes.h
+++ /dev/null
@@ -1,21 +0,0 @@
-#ifndef _COMPAT_CRYPTO_AES_H
-#define _COMPAT_CRYPTO_AES_H
-
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,24))
-#include_next <crypto/aes.h>
-#else
-
-#define AES_MIN_KEY_SIZE	16
-#define AES_MAX_KEY_SIZE	32
-#define AES_KEYSIZE_128		16
-#define AES_KEYSIZE_192		24
-#define AES_KEYSIZE_256		32
-#define AES_BLOCK_SIZE		16
-#define AES_MAX_KEYLENGTH	(15 * 16)
-#define AES_MAX_KEYLENGTH_U32	(AES_MAX_KEYLENGTH / sizeof(u32))
-
-#endif /* (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,24)) */
-
-#endif
diff --git a/backport/backport-include/linux/atomic.h b/backport/backport-include/linux/atomic.h
deleted file mode 100644
index 41b769b..0000000
--- a/backport/backport-include/linux/atomic.h
+++ /dev/null
@@ -1,12 +0,0 @@
-#ifndef _COMPAT_LINUX_ATOMIC_H
-#define _COMPAT_LINUX_ATOMIC_H 1
-
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,36))
-#include_next <linux/atomic.h>
-#else
-#include <asm/atomic.h>
-#endif /* (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,36)) */
-
-#endif	/* _COMPAT_LINUX_ATOMIC_H */
diff --git a/backport/backport-include/linux/bitops.h b/backport/backport-include/linux/bitops.h
deleted file mode 100644
index e13a56b..0000000
--- a/backport/backport-include/linux/bitops.h
+++ /dev/null
@@ -1,35 +0,0 @@
-#ifndef __BACKPORT_BITOPS_H
-#define __BACKPORT_BITOPS_H
-#include_next <linux/bitops.h>
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30))
-static inline unsigned long __ffs64(u64 word)
-{
-#if BITS_PER_LONG == 32
-	if (((u32)word) == 0UL)
-		return __ffs((u32)(word >> 32)) + 32;
-#elif BITS_PER_LONG != 64
-#error BITS_PER_LONG not 32 or 64
-#endif
-	return __ffs((unsigned long)word);
-}
-#endif /* < 2.6.30 */
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,34))
-#define for_each_set_bit(bit, addr, size) \
-	for ((bit) = find_first_bit((addr), (size));		\
-	     (bit) < (size);					\
-	     (bit) = find_next_bit((addr), (size), (bit) + 1))
-#endif /* < 2.6.34 */
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,38))
-#define sign_extend32 LINUX_BACKPORT(sign_extend32)
-static inline __s32 sign_extend32(__u32 value, int index)
-{
-	__u8 shift = 31 - index;
-	return (__s32)(value << shift) >> shift;
-}
-#endif /* < 2.6.38 */
-
-#endif /* __BACKPORT_BITOPS_H */
diff --git a/backport/backport-include/linux/bug.h b/backport/backport-include/linux/bug.h
deleted file mode 100644
index 22c91aa..0000000
--- a/backport/backport-include/linux/bug.h
+++ /dev/null
@@ -1,45 +0,0 @@
-#ifndef __BACKPORT_LINUX_BUG_H
-#define __BACKPORT_LINUX_BUG_H
-#include_next <linux/bug.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,38)
-/* is defined there for older kernels */
-#include <linux/kernel.h>
-/* Backport of:
- *
- * commit 7ef88ad561457c0346355dfd1f53e503ddfde719
- * Author: Rusty Russell <rusty@rustcorp.com.au>
- * Date:   Mon Jan 24 14:45:10 2011 -0600
- *
- *     BUILD_BUG_ON: make it handle more cases
- */
-#undef BUILD_BUG_ON
-/**
- * BUILD_BUG_ON - break compile if a condition is true.
- * @condition: the condition which the compiler should know is false.
- *
- * If you have some code which relies on certain constants being equal, or
- * other compile-time-evaluated condition, you should use BUILD_BUG_ON to
- * detect if someone changes it.
- *
- * The implementation uses gcc's reluctance to create a negative array, but
- * gcc (as of 4.4) only emits that error for obvious cases (eg. not arguments
- * to inline functions).  So as a fallback we use the optimizer; if it can't
- * prove the condition is false, it will cause a link error on the undefined
- * "__build_bug_on_failed".  This error message can be harder to track down
- * though, hence the two different methods.
- */
-#ifndef __OPTIMIZE__
-#define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))
-#else
-extern int __build_bug_on_failed;
-#define BUILD_BUG_ON(condition)					\
-	do {							\
-		((void)sizeof(char[1 - 2*!!(condition)]));	\
-		if (condition) __build_bug_on_failed = 1;	\
-	} while(0)
-#endif
-#endif /* < 2.6.38 */
-
-#endif /* __BACKPORT_LINUX_BUG_H */
diff --git a/backport/backport-include/linux/debugfs.h b/backport/backport-include/linux/debugfs.h
deleted file mode 100644
index d2e6b38..0000000
--- a/backport/backport-include/linux/debugfs.h
+++ /dev/null
@@ -1,29 +0,0 @@
-#ifndef __BACKPORT_LINUX_DEBUGFS_H
-#define __BACKPORT_LINUX_DEBUGFS_H
-#include_next <linux/debugfs.h>
-#include <linux/version.h>
-
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27)
-#define debugfs_remove_recursive LINUX_BACKPORT(debugfs_remove_recursive)
-
-#if defined(CONFIG_DEBUG_FS)
-void debugfs_remove_recursive(struct dentry *dentry);
-#else
-static inline void debugfs_remove_recursive(struct dentry *dentry)
-{ }
-#endif
-#endif /* < 2.6.27 */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35)
-#if RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(6,4)
-static inline struct dentry *debugfs_create_x64(const char *name, umode_t mode,
-						struct dentry *parent,
-						u64 *value)
-{
-	return debugfs_create_u64(name, mode, parent, value);
-}
-#endif
-#endif
-
-#endif /* __BACKPORT_LINUX_DEBUGFS_H */
diff --git a/backport/backport-include/linux/delay.h b/backport/backport-include/linux/delay.h
deleted file mode 100644
index 1f46f58..0000000
--- a/backport/backport-include/linux/delay.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef __BACKPORT_LINUX_DELAY_H
-#define __BACKPORT_LINUX_DELAY_H
-#include_next <linux/delay.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36)
-#define usleep_range(_min, _max)	msleep((_max) / 1000)
-#endif
-
-#endif /* __BACKPORT_LINUX_DELAY_H */
diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index a54756a..3f57bd9 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -19,16 +19,6 @@ typedef int (backport_device_find_function_t)(struct device *, void *);
 			  (backport_device_find_function_t *)(fun))
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30)
-static inline int
-backport_device_move(struct device *dev, struct device *new_parent,
-		     enum dpm_order dpm_order)
-{
-	return device_move(dev, new_parent);
-}
-#define device_move LINUX_BACKPORT(device_move)
-#endif
-
 #ifndef module_driver
 /**
  * module_driver() - Helper macro for drivers that don't do anything
@@ -64,8 +54,7 @@ extern int devres_release(struct device *dev, dr_release_t release,
 			  dr_match_t match, void *match_data);
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0) && \
-    LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,27)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0)
 #include <linux/ratelimit.h>
 
 #define dev_level_ratelimited(dev_level, dev, fmt, ...)			\
@@ -99,86 +88,7 @@ do {									\
 #define dev_dbg_ratelimited(dev, fmt, ...)			\
 	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
 #endif /* dynamic debug */
-#endif /* 2.6.27 <= version <= 3.5 */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36)
-#define device_rename(dev, new_name) device_rename(dev, (char *)new_name)
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37)
-/*
- * This belongs into pm_wakeup.h but that isn't included directly.
- * Note that on 2.6.36, this was defined but not exported, so we
- * need to override it.
- */
-#define pm_wakeup_event LINUX_BACKPORT(pm_wakeup_event)
-static inline void pm_wakeup_event(struct device *dev, unsigned int msec) {}
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,34)
-#define device_lock LINUX_BACKPORT(device_lock)
-static inline void device_lock(struct device *dev)
-{
-#if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_PREEMPT_DESKTOP)
-        mutex_lock(&dev->mutex);
-#else
-	down(&dev->sem);
-#endif
-}
-
-#define device_trylock LINUX_BACKPORT(device_trylock)
-static inline int device_trylock(struct device *dev)
-{
-#if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_PREEMPT_DESKTOP)
-	return mutex_trylock(&dev->mutex);
-#else
-	return down_trylock(&dev->sem);
-#endif
-}
-
-#define device_unlock LINUX_BACKPORT(device_unlock)
-static inline void device_unlock(struct device *dev)
-{
-#if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_PREEMPT_DESKTOP)
-        mutex_unlock(&dev->mutex);
-#else
-	up(&dev->sem);
-#endif
-}
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,26)
-static inline const char *dev_name(struct device *dev)
-{
-	/* will be changed into kobject_name(&dev->kobj) in the near future */
-	return dev->bus_id;
-}
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30)
-static inline void dev_set_uevent_suppress(struct device *dev, int val)
-{
-	dev->uevent_suppress = val;
-}
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27)
-#define device_create(cls, parent, devt, drvdata, fmt, ...)		\
-({									\
-	struct device *_dev;						\
-	_dev = (device_create)(cls, parent, devt, fmt, __VA_ARGS__);	\
-	dev_set_drvdata(_dev, drvdata);					\
-	_dev;								\
-})
-
-#define dev_name(dev) dev_name((struct device *)dev)
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,26)
-#define dev_set_name LINUX_BACKPORT(dev_set_name)
-extern int dev_set_name(struct device *dev, const char *name, ...)
-			__attribute__((format(printf, 2, 3)));
-#endif
+#endif /* <= 3.5 */
 
 #if LINUX_VERSION_CODE <= KERNEL_VERSION(3,6,0)
 static inline void
diff --git a/backport/backport-include/linux/dma-attrs.h b/backport/backport-include/linux/dma-attrs.h
deleted file mode 100644
index ee4cd5f..0000000
--- a/backport/backport-include/linux/dma-attrs.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __BACKPORT_DMA_ATTR_H
-#define __BACKPORT_DMA_ATTR_H
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,26)
-#include_next <linux/dma-attrs.h>
-#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,26) */
-#endif /* __BACKPORT_DMA_ATTR_H */
diff --git a/backport/backport-include/linux/dma-mapping.h b/backport/backport-include/linux/dma-mapping.h
index 6c4973a..9b2bc90 100644
--- a/backport/backport-include/linux/dma-mapping.h
+++ b/backport/backport-include/linux/dma-mapping.h
@@ -15,81 +15,6 @@ static inline void *dma_zalloc_coherent(struct device *dev, size_t size,
 }
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,34)
-/* only include this if DEFINE_DMA_UNMAP_ADDR is not set as debian squeeze also backports this  */
-#ifndef DEFINE_DMA_UNMAP_ADDR
-#ifdef CONFIG_NEED_DMA_MAP_STATE
-#define DEFINE_DMA_UNMAP_ADDR(ADDR_NAME)        dma_addr_t ADDR_NAME
-#define DEFINE_DMA_UNMAP_LEN(LEN_NAME)          __u32 LEN_NAME
-#define dma_unmap_addr(PTR, ADDR_NAME)           ((PTR)->ADDR_NAME)
-#define dma_unmap_addr_set(PTR, ADDR_NAME, VAL)  (((PTR)->ADDR_NAME) = (VAL))
-#define dma_unmap_len(PTR, LEN_NAME)             ((PTR)->LEN_NAME)
-#define dma_unmap_len_set(PTR, LEN_NAME, VAL)    (((PTR)->LEN_NAME) = (VAL))
-#else
-#define DEFINE_DMA_UNMAP_ADDR(ADDR_NAME)
-#define DEFINE_DMA_UNMAP_LEN(LEN_NAME)
-#define dma_unmap_addr(PTR, ADDR_NAME)           (0)
-#define dma_unmap_addr_set(PTR, ADDR_NAME, VAL)  do { } while (0)
-#define dma_unmap_len(PTR, LEN_NAME)             (0)
-#define dma_unmap_len_set(PTR, LEN_NAME, VAL)    do { } while (0)
-#endif
-#endif
-
-/* mask dma_set_coherent_mask as debian squeeze also backports this */
-#define dma_set_coherent_mask LINUX_BACKPORT(dma_set_coherent_mask)
-
-static inline int dma_set_coherent_mask(struct device *dev, u64 mask)
-{
-	if (!dma_supported(dev, mask))
-		return -EIO;
-	dev->coherent_dma_mask = mask;
-	return 0;
-}
-#endif /* < 2.6.34 */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27)
-#include <backport/magic.h>
-/* These really belong to asm/dma-mapping.h but it doesn't really matter */
-/* On 2.6.27 a second argument was added, on older kernels we ignore it */
-static inline int dma_mapping_error1(dma_addr_t dma_addr)
-{
-	/* use an inline to grab the old definition */
-	return dma_mapping_error(dma_addr);
-}
-
-#define dma_mapping_error2(pdef, dma_addr) \
-	dma_mapping_error1(dma_addr)
-
-#undef dma_mapping_error
-#define dma_mapping_error(...) \
-	macro_dispatcher(dma_mapping_error, __VA_ARGS__)(__VA_ARGS__)
-
-/* This kinda belongs into asm/dma-mapping.h or so, but doesn't matter */
-#ifdef CONFIG_ARM
-
-/*
- * The caller asks to handle a range between offset and offset + size,
- * but we process a larger range from 0 to offset + size due to lack of
- * offset support.
- */
-
-static inline void dma_sync_single_range_for_cpu(struct device *dev,
-		dma_addr_t handle, unsigned long offset, size_t size,
-		enum dma_data_direction dir)
-{
-	dma_sync_single_for_cpu(dev, handle, offset + size, dir);
-}
-
-static inline void dma_sync_single_range_for_device(struct device *dev,
-		dma_addr_t handle, unsigned long offset, size_t size,
-		enum dma_data_direction dir)
-{
-	dma_sync_single_for_device(dev, handle, offset + size, dir);
-}
-
-#endif /* arm */
-#endif
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)
 /*
  * Set both the DMA mask and the coherent DMA mask to the same thing.
diff --git a/backport/backport-include/linux/dynamic_debug.h b/backport/backport-include/linux/dynamic_debug.h
index eb6fa81..ee2a67c 100644
--- a/backport/backport-include/linux/dynamic_debug.h
+++ b/backport/backport-include/linux/dynamic_debug.h
@@ -1,9 +1,7 @@
 #ifndef __BACKPORT_LINUX_DYNAMIC_DEBUG_H
 #define __BACKPORT_LINUX_DYNAMIC_DEBUG_H
 #include <linux/version.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,30)
 #include_next <linux/dynamic_debug.h>
-#endif
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0)
 /* backports 07613b0b */
diff --git a/backport/backport-include/linux/err.h b/backport/backport-include/linux/err.h
index 5a83c51..62ee1e8 100644
--- a/backport/backport-include/linux/err.h
+++ b/backport/backport-include/linux/err.h
@@ -3,27 +3,6 @@
 #include_next <linux/err.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39)
-#define PTR_RET LINUX_BACKPORT(PTR_RET)
-static inline int __must_check PTR_RET(const void *ptr)
-{
-	if (IS_ERR(ptr))
-		return PTR_ERR(ptr);
-	else
-		return 0;
-}
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,33)
-/* mask IS_ERR_OR_NULL as debian squeeze also backports this */
-#define IS_ERR_OR_NULL LINUX_BACKPORT(IS_ERR_OR_NULL)
-
-static inline long __must_check IS_ERR_OR_NULL(const void *ptr)
-{
-	return !ptr || IS_ERR_VALUE((unsigned long)ptr);
-}
-#endif
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,12,0)
 #define PTR_ERR_OR_ZERO(p) PTR_RET(p)
 #endif
diff --git a/backport/backport-include/linux/etherdevice.h b/backport/backport-include/linux/etherdevice.h
index 5560c0c..8d09e1f 100644
--- a/backport/backport-include/linux/etherdevice.h
+++ b/backport/backport-include/linux/etherdevice.h
@@ -8,35 +8,7 @@
  */
 #include <asm/unaligned.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,12)
-#define eth_hw_addr_random LINUX_BACKPORT(eth_hw_addr_random)
-static inline void eth_hw_addr_random(struct net_device *dev)
-{
-#error eth_hw_addr_random() needs to be implemented for < 2.6.12
-}
-#elif LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
-#define eth_hw_addr_random LINUX_BACKPORT(eth_hw_addr_random)
-static inline void eth_hw_addr_random(struct net_device *dev)
-{
-	get_random_bytes(dev->dev_addr, ETH_ALEN);
-	dev->dev_addr[0] &= 0xfe;       /* clear multicast bit */
-	dev->dev_addr[0] |= 0x02;       /* set local assignment bit (IEEE802) */
-}
-#elif LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36)
-/* So this is 2.6.31..2.6.35 */
-
-/* Just have the flags present, they won't really mean anything though */
-#define NET_ADDR_PERM		0	/* address is permanent (default) */
-#define NET_ADDR_RANDOM		1	/* address is generated randomly */
-#define NET_ADDR_STOLEN		2	/* address is stolen from other device */
-
-#define eth_hw_addr_random LINUX_BACKPORT(eth_hw_addr_random)
-static inline void eth_hw_addr_random(struct net_device *dev)
-{
-	random_ether_addr(dev->dev_addr);
-}
-
-#elif LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)
 #define eth_hw_addr_random LINUX_BACKPORT(eth_hw_addr_random)
 static inline void eth_hw_addr_random(struct net_device *dev)
 {
@@ -73,7 +45,7 @@ static inline void eth_random_addr(u8 *addr)
 	addr[0] &= 0xfe;        /* clear multicast bit */
 	addr[0] |= 0x02;        /* set local assignment bit (IEEE802) */
 }
-#endif
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
 
@@ -100,24 +72,6 @@ static inline bool ether_addr_equal(const u8 *addr1, const u8 *addr2)
 }
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,38)
-#define alloc_etherdev_mqs(sizeof_priv, tx_q, rx_q) alloc_etherdev_mq(sizeof_priv, tx_q)
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,38)
-/**
- * is_unicast_ether_addr - Determine if the Ethernet address is unicast
- * @addr: Pointer to a six-byte array containing the Ethernet address
- *
- * Return true if the address is a unicast address.
- */
-#define is_unicast_ether_addr LINUX_BACKPORT(is_unicast_ether_addr)
-static inline int is_unicast_ether_addr(const u8 *addr)
-{
-	return !is_multicast_ether_addr(addr);
-}
-#endif
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
 #define eth_prepare_mac_addr_change LINUX_BACKPORT(eth_prepare_mac_addr_change)
 extern int eth_prepare_mac_addr_change(struct net_device *dev, void *p);
@@ -126,19 +80,6 @@ extern int eth_prepare_mac_addr_change(struct net_device *dev, void *p);
 extern void eth_commit_mac_addr_change(struct net_device *dev, void *p);
 #endif /* < 3.9 */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,29)
-#define eth_mac_addr LINUX_BACKPORT(eth_mac_addr)
-extern int eth_mac_addr(struct net_device *dev, void *p);
-#define eth_change_mtu LINUX_BACKPORT(eth_change_mtu)
-extern int eth_change_mtu(struct net_device *dev, int new_mtu);
-#define eth_validate_addr LINUX_BACKPORT(eth_validate_addr)
-extern int eth_validate_addr(struct net_device *dev);
-#endif /* < 2.6.29 */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35)
-#define netdev_hw_addr dev_mc_list
-#endif
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,12,0)
 /**
  * eth_hw_addr_inherit - Copy dev_addr from another net_device
@@ -151,9 +92,7 @@ extern int eth_validate_addr(struct net_device *dev);
 static inline void eth_hw_addr_inherit(struct net_device *dst,
 				       struct net_device *src)
 {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36)
 	dst->addr_assign_type = src->addr_assign_type;
-#endif
 	memcpy(dst->dev_addr, src->dev_addr, ETH_ALEN);
 }
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0) */
diff --git a/backport/backport-include/linux/ethtool.h b/backport/backport-include/linux/ethtool.h
index 647fbf6..7a78bb5 100644
--- a/backport/backport-include/linux/ethtool.h
+++ b/backport/backport-include/linux/ethtool.h
@@ -15,31 +15,4 @@
 #define ETHTOOL_FWVERS_LEN 32
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
-#define SUPPORTED_Backplane            (1 << 16)
-#define SUPPORTED_1000baseKX_Full      (1 << 17)
-#define SUPPORTED_10000baseKX4_Full    (1 << 18)
-#define SUPPORTED_10000baseKR_Full     (1 << 19)
-#define SUPPORTED_10000baseR_FEC       (1 << 20)
-
-#define ADVERTISED_Backplane           (1 << 16)
-#define ADVERTISED_1000baseKX_Full     (1 << 17)
-#define ADVERTISED_10000baseKX4_Full   (1 << 18)
-#define ADVERTISED_10000baseKR_Full    (1 << 19)
-#define ADVERTISED_10000baseR_FEC      (1 << 20)
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27)
-static inline void ethtool_cmd_speed_set(struct ethtool_cmd *ep,
-					 __u32 speed)
-{
-	ep->speed = (__u16)speed;
-}
-
-static inline __u32 ethtool_cmd_speed(const struct ethtool_cmd *ep)
-{
-	return ep->speed;
-}
-#endif
-
 #endif /* __BACKPORT_LINUX_ETHTOOL_H */
diff --git a/backport/backport-include/linux/firmware.h b/backport/backport-include/linux/firmware.h
deleted file mode 100644
index 8db0953..0000000
--- a/backport/backport-include/linux/firmware.h
+++ /dev/null
@@ -1,29 +0,0 @@
-#ifndef __BACKPORT_LINUX_FIRMWARE_H
-#define __BACKPORT_LINUX_FIRMWARE_H
-#include_next <linux/firmware.h>
-#include <linux/version.h>
-
-#if defined(CPTCFG_BACKPORT_BUILD_FW_LOADER_MODULE)
-#define request_firmware_nowait LINUX_BACKPORT(request_firmware_nowait)
-#define request_firmware LINUX_BACKPORT(request_firmware)
-#define release_firmware LINUX_BACKPORT(release_firmware)
-
-int request_firmware(const struct firmware **fw, const char *name,
-		     struct device *device);
-int request_firmware_nowait(
-	struct module *module, int uevent,
-	const char *name, struct device *device, gfp_t gfp, void *context,
-	void (*cont)(const struct firmware *fw, void *context));
-
-void release_firmware(const struct firmware *fw);
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27)
-struct builtin_fw {
-	char *name;
-	void *data;
-	unsigned long size;
-};
-#endif
-
-#endif /* __BACKPORT_LINUX_FIRMWARE_H */
diff --git a/backport/backport-include/linux/fs.h b/backport/backport-include/linux/fs.h
index 9874f81..2790db6 100644
--- a/backport/backport-include/linux/fs.h
+++ b/backport/backport-include/linux/fs.h
@@ -29,15 +29,6 @@ static inline struct inode *file_inode(struct file *f)
 }
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35)
-#define noop_llseek LINUX_BACKPORT(noop_llseek)
-extern loff_t noop_llseek(struct file *file, loff_t offset, int origin);
-
-#define simple_write_to_buffer LINUX_BACKPORT(simple_write_to_buffer)
-extern ssize_t simple_write_to_buffer(void *to, size_t available, loff_t *ppos,
-		const void __user *from, size_t count);
-#endif
-
 #ifndef replace_fops
 /*
  * This one is to be used *ONLY* from ->open() instances.
diff --git a/backport/backport-include/linux/if.h b/backport/backport-include/linux/if.h
index a072579..1045466 100644
--- a/backport/backport-include/linux/if.h
+++ b/backport/backport-include/linux/if.h
@@ -8,23 +8,6 @@
 #define IFF_DONT_BRIDGE 0x800		/* disallow bridging this ether dev */
 #endif
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36))
-#define br_port_exists(dev)	(dev->br_port)
-#else
-/*
- * This is not part of The 2.6.37 kernel yet but we
- * we use it to optimize the backport code we
- * need to implement. Instead of using ifdefs
- * to check what version of the check we use
- * we just replace all checks on current code
- * with this. I'll submit this upstream too, that
- * way all we'd have to do is to implement this
- * for older kernels, then we would not have to
- * edit the upstrema code for backport efforts.
- */
-#define br_port_exists(dev)	(dev->priv_flags & IFF_BRIDGE_PORT)
-#endif
-
 #ifndef  IFF_TX_SKB_SHARING
 #define IFF_TX_SKB_SHARING	0x10000
 #endif
diff --git a/backport/backport-include/linux/if_ether.h b/backport/backport-include/linux/if_ether.h
index e904001..008d2b8 100644
--- a/backport/backport-include/linux/if_ether.h
+++ b/backport/backport-include/linux/if_ether.h
@@ -27,11 +27,6 @@
 #define ETH_P_LINK_CTL	0x886c
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,0,0)
-#define mac_pton LINUX_BACKPORT(mac_pton)
-int mac_pton(const char *s, u8 *mac);
-#endif
-
 #ifndef ETH_P_PAE
 #define ETH_P_PAE 0x888E      /* Port Access Entity (IEEE 802.1X) */
 #endif
diff --git a/backport/backport-include/linux/in.h b/backport/backport-include/linux/in.h
deleted file mode 100644
index 1fcc384..0000000
--- a/backport/backport-include/linux/in.h
+++ /dev/null
@@ -1,25 +0,0 @@
-#ifndef __BACKPORT_IN_H
-#define __BACKPORT_IN_H
-#include_next <linux/in.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37)
-static inline int proto_ports_offset(int proto)
-{
-	switch (proto) {
-	case IPPROTO_TCP:
-	case IPPROTO_UDP:
-	case IPPROTO_DCCP:
-	case IPPROTO_ESP:	/* SPI */
-	case IPPROTO_SCTP:
-	case IPPROTO_UDPLITE:
-		return 0;
-	case IPPROTO_AH:	/* SPI */
-		return 4;
-	default:
-		return -EINVAL;
-	}
-}
-#endif
-
-#endif /* __BACKPORT_IN_H */
diff --git a/backport/backport-include/linux/interrupt.h b/backport/backport-include/linux/interrupt.h
deleted file mode 100644
index a9fb503..0000000
--- a/backport/backport-include/linux/interrupt.h
+++ /dev/null
@@ -1,100 +0,0 @@
-#ifndef __BACKPORT_LINUX_INTERRUPT_H
-#define __BACKPORT_LINUX_INTERRUPT_H
-#include_next <linux/interrupt.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39)
-static inline int irq_set_irq_wake(unsigned int irq, unsigned int on)
-{
-	return set_irq_wake(irq, on);
-}
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30)
-#define IRQ_WAKE_THREAD	(2)
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
-struct compat_threaded_irq {
-	unsigned int irq;
-	irq_handler_t handler;
-	irq_handler_t thread_fn;
-	void *dev_id;
-	char wq_name[64];
-	struct workqueue_struct *wq;
-	struct work_struct work;
-};
-
-static inline
-void compat_irq_work(struct work_struct *work)
-{
-	struct compat_threaded_irq *comp = container_of(work, struct compat_threaded_irq, work);
-	comp->thread_fn(comp->irq, comp->dev_id);
-}
-
-static inline
-irqreturn_t compat_irq_dispatcher(int irq, void *dev_id)
-{
-	struct compat_threaded_irq *comp = dev_id;
-	irqreturn_t res;
-
-	res = comp->handler(irq, comp->dev_id);
-	if (res == IRQ_WAKE_THREAD) {
-		queue_work(comp->wq, &comp->work);
-		res = IRQ_HANDLED;
-	}
-
-	return res;
-}
-
-static inline
-int compat_request_threaded_irq(struct compat_threaded_irq *comp,
-				unsigned int irq,
-				irq_handler_t handler,
-				irq_handler_t thread_fn,
-				unsigned long flags,
-				const char *name,
-				void *dev_id)
-{
-	comp->irq = irq;
-	comp->handler = handler;
-	comp->thread_fn = thread_fn;
-	comp->dev_id = dev_id;
-	INIT_WORK(&comp->work, compat_irq_work);
-
-	if (!comp->wq) {
-		snprintf(comp->wq_name, sizeof(comp->wq_name),
-			 "compirq/%u-%s", irq, name);
-		comp->wq = create_singlethread_workqueue(comp->wq_name);
-		if (!comp->wq) {
-			printk(KERN_ERR "Failed to create compat-threaded-IRQ workqueue %s\n",
-			       comp->wq_name);
-			return -ENOMEM;
-		}
-	}
-	return request_irq(irq, compat_irq_dispatcher, flags, name, comp);
-}
-
-static inline
-void compat_free_threaded_irq(struct compat_threaded_irq *comp)
-{
-	free_irq(comp->irq, comp);
-}
-
-static inline
-void compat_destroy_threaded_irq(struct compat_threaded_irq *comp)
-{
-	if (comp->wq)
-		destroy_workqueue(comp->wq);
-	comp->wq = NULL;
-}
-
-static inline
-void compat_synchronize_threaded_irq(struct compat_threaded_irq *comp)
-{
-	synchronize_irq(comp->irq);
-	cancel_work_sync(&comp->work);
-}
-#endif
-
-#endif /* __BACKPORT_LINUX_INTERRUPT_H */
diff --git a/backport/backport-include/linux/ioport.h b/backport/backport-include/linux/ioport.h
index b9aec4d..3424401 100644
--- a/backport/backport-include/linux/ioport.h
+++ b/backport/backport-include/linux/ioport.h
@@ -6,11 +6,4 @@
 #define IORESOURCE_REG		0x00000300
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27)
-static inline resource_size_t resource_size(const struct resource *res)
-{
-	return res->end - res->start + 1;
-}
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27) */
-
 #endif /* __BACKPORT_LINUX_IOPORT_H */
diff --git a/backport/backport-include/linux/irq.h b/backport/backport-include/linux/irq.h
deleted file mode 100644
index f8d12d9..0000000
--- a/backport/backport-include/linux/irq.h
+++ /dev/null
@@ -1,85 +0,0 @@
-#ifndef __BACKPORT_LINUX_IRQ_H
-#define __BACKPORT_LINUX_IRQ_H
-#include_next <linux/irq.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39)
-static inline int irq_set_chip(unsigned int irq, struct irq_chip *chip)
-{
-	return set_irq_chip(irq, chip);
-}
-static inline int irq_set_handler_data(unsigned int irq, void *data)
-{
-	return set_irq_data(irq, data);
-}
-static inline int irq_set_chip_data(unsigned int irq, void *data)
-{
-	return set_irq_chip_data(irq, data);
-}
-#ifndef irq_set_irq_type
-static inline int irq_set_irq_type(unsigned int irq, unsigned int type)
-{
-	return set_irq_type(irq, type);
-}
-#endif
-static inline int irq_set_msi_desc(unsigned int irq, struct msi_desc *entry)
-{
-	return set_irq_msi(irq, entry);
-}
-static inline struct irq_chip *irq_get_chip(unsigned int irq)
-{
-	return get_irq_chip(irq);
-}
-static inline void *irq_get_chip_data(unsigned int irq)
-{
-	return get_irq_chip_data(irq);
-}
-static inline void *irq_get_handler_data(unsigned int irq)
-{
-	return get_irq_data(irq);
-}
-
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
-static inline void *irq_data_get_irq_handler_data(struct irq_data *d)
-{
-	return irq_data_get_irq_data(d);
-}
-#endif
-
-static inline struct msi_desc *irq_get_msi_desc(unsigned int irq)
-{
-	return get_irq_msi(irq);
-}
-
-static inline void irq_set_noprobe(unsigned int irq)
-{
-	set_irq_noprobe(irq);
-}
-static inline void irq_set_probe(unsigned int irq)
-{
-	set_irq_probe(irq);
-}
-#endif
-
-/* This is really in irqdesc.h, but nothing includes that directly */
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39) && \
-    LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29)
-static inline struct irq_chip *irq_desc_get_chip(struct irq_desc *desc)
-{
-	return get_irq_desc_chip(desc);
-}
-static inline void *irq_desc_get_handler_data(struct irq_desc *desc)
-{
-	return get_irq_desc_data(desc);
-}
-static inline void *irq_desc_get_chip_data(struct irq_desc *desc)
-{
-	return get_irq_desc_chip_data(desc);
-}
-static inline struct msi_desc *irq_desc_get_msi_desc(struct irq_desc *desc)
-{
-	return get_irq_desc_msi(desc);
-}
-#endif
-
-#endif /* __BACKPORT_LINUX_IRQ_H */
diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
index 0224a69..707bed9 100644
--- a/backport/backport-include/linux/kernel.h
+++ b/backport/backport-include/linux/kernel.h
@@ -33,139 +33,6 @@
 	({ unsigned long long _tmp = (ll)+(d)-1; do_div(_tmp, d); _tmp; })
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,0,0)
-#define kstrtoull_from_user LINUX_BACKPORT(kstrtoull_from_user)
-int __must_check kstrtoull_from_user(const char __user *s, size_t count, unsigned int base, unsigned long long *res);
-#define kstrtoll_from_user LINUX_BACKPORT(kstrtoll_from_user)
-int __must_check kstrtoll_from_user(const char __user *s, size_t count, unsigned int base, long long *res);
-#define kstrtoul_from_user LINUX_BACKPORT(kstrtoul_from_user)
-int __must_check kstrtoul_from_user(const char __user *s, size_t count, unsigned int base, unsigned long *res);
-#define kstrtol_from_user LINUX_BACKPORT(kstrtol_from_user)
-int __must_check kstrtol_from_user(const char __user *s, size_t count, unsigned int base, long *res);
-#define kstrtouint_from_user LINUX_BACKPORT(kstrtouint_from_user)
-int __must_check kstrtouint_from_user(const char __user *s, size_t count, unsigned int base, unsigned int *res);
-#define kstrtoint_from_user LINUX_BACKPORT(kstrtoint_from_user)
-int __must_check kstrtoint_from_user(const char __user *s, size_t count, unsigned int base, int *res);
-#define kstrtou16_from_user LINUX_BACKPORT(kstrtou16_from_user)
-int __must_check kstrtou16_from_user(const char __user *s, size_t count, unsigned int base, u16 *res);
-#define kstrtos16_from_user LINUX_BACKPORT(kstrtos16_from_user)
-int __must_check kstrtos16_from_user(const char __user *s, size_t count, unsigned int base, s16 *res);
-#define kstrtou8_from_user LINUX_BACKPORT(kstrtou8_from_user)
-int __must_check kstrtou8_from_user(const char __user *s, size_t count, unsigned int base, u8 *res);
-#define kstrtos8_from_user LINUX_BACKPORT(kstrtos8_from_user)
-int __must_check kstrtos8_from_user(const char __user *s, size_t count, unsigned int base, s8 *res);
-
-#define kstrtou64_from_user LINUX_BACKPORT(kstrtou64_from_user)
-static inline int __must_check kstrtou64_from_user(const char __user *s, size_t count, unsigned int base, u64 *res)
-{
-	return kstrtoull_from_user(s, count, base, res);
-}
-
-#define kstrtos64_from_user LINUX_BACKPORT(kstrtos64_from_user)
-static inline int __must_check kstrtos64_from_user(const char __user *s, size_t count, unsigned int base, s64 *res)
-{
-	return kstrtoll_from_user(s, count, base, res);
-}
-
-#define kstrtou32_from_user LINUX_BACKPORT(kstrtou32_from_user)
-static inline int __must_check kstrtou32_from_user(const char __user *s, size_t count, unsigned int base, u32 *res)
-{
-	return kstrtouint_from_user(s, count, base, res);
-}
-
-#define kstrtos32_from_user LINUX_BACKPORT(kstrtos32_from_user)
-static inline int __must_check kstrtos32_from_user(const char __user *s, size_t count, unsigned int base, s32 *res)
-{
-	return kstrtoint_from_user(s, count, base, res);
-}
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39)
-/* 
- * kstrto* was included in kernel 2.6.38.4 and causes conflicts with the
- * version included in compat-drivers. We use strict_strtol to check if
- * kstrto* is already available.
- */
-#ifndef strict_strtoull
-/* Internal, do not use. */
-#define _kstrtoul LINUX_BACKPORT(_kstrtoul)
-int __must_check _kstrtoul(const char *s, unsigned int base, unsigned long *res);
-#define _kstrtol LINUX_BACKPORT(_kstrtol)
-int __must_check _kstrtol(const char *s, unsigned int base, long *res);
-
-#define kstrtoull LINUX_BACKPORT(kstrtoull)
-int __must_check kstrtoull(const char *s, unsigned int base, unsigned long long *res);
-#define kstrtoll LINUX_BACKPORT(kstrtoll)
-int __must_check kstrtoll(const char *s, unsigned int base, long long *res);
-#define kstrtoul LINUX_BACKPORT(kstrtoul)
-static inline int __must_check kstrtoul(const char *s, unsigned int base, unsigned long *res)
-{
-	/*
-	 * We want to shortcut function call, but
-	 * __builtin_types_compatible_p(unsigned long, unsigned long long) = 0.
-	 */
-	if (sizeof(unsigned long) == sizeof(unsigned long long) &&
-	    __alignof__(unsigned long) == __alignof__(unsigned long long))
-		return kstrtoull(s, base, (unsigned long long *)res);
-	else
-		return _kstrtoul(s, base, res);
-}
-
-#define kstrtol LINUX_BACKPORT(kstrtol)
-static inline int __must_check kstrtol(const char *s, unsigned int base, long *res)
-{
-	/*
-	 * We want to shortcut function call, but
-	 * __builtin_types_compatible_p(long, long long) = 0.
-	 */
-	if (sizeof(long) == sizeof(long long) &&
-	    __alignof__(long) == __alignof__(long long))
-		return kstrtoll(s, base, (long long *)res);
-	else
-		return _kstrtol(s, base, res);
-}
-
-#define kstrtouint LINUX_BACKPORT(kstrtouint)
-int __must_check kstrtouint(const char *s, unsigned int base, unsigned int *res);
-#define kstrtoint LINUX_BACKPORT(kstrtoint)
-int __must_check kstrtoint(const char *s, unsigned int base, int *res);
-
-#define kstrtou64 LINUX_BACKPORT(kstrtou64)
-static inline int __must_check kstrtou64(const char *s, unsigned int base, u64 *res)
-{
-	return kstrtoull(s, base, res);
-}
-
-#define kstrtos64 LINUX_BACKPORT(kstrtos64)
-static inline int __must_check kstrtos64(const char *s, unsigned int base, s64 *res)
-{
-	return kstrtoll(s, base, res);
-}
-
-#define kstrtou32 LINUX_BACKPORT(kstrtou32)
-static inline int __must_check kstrtou32(const char *s, unsigned int base, u32 *res)
-{
-	return kstrtouint(s, base, res);
-}
-
-#define kstrtos32 LINUX_BACKPORT(kstrtos32)
-static inline int __must_check kstrtos32(const char *s, unsigned int base, s32 *res)
-{
-	return kstrtoint(s, base, res);
-}
-
-#define kstrtou16 LINUX_BACKPORT(kstrtou16)
-int __must_check kstrtou16(const char *s, unsigned int base, u16 *res);
-#define kstrtos16 LINUX_BACKPORT(kstrtos16)
-int __must_check kstrtos16(const char *s, unsigned int base, s16 *res);
-#define kstrtou8 LINUX_BACKPORT(kstrtou8)
-int __must_check kstrtou8(const char *s, unsigned int base, u8 *res);
-#define kstrtos8 LINUX_BACKPORT(kstrtos8)
-int __must_check kstrtos8(const char *s, unsigned int base, s8 *res);
-#endif /* ifndef strict_strtol */
-
-#endif /* < 2.6.39 */
-
 #ifndef USHRT_MAX
 #define USHRT_MAX      ((u16)(~0U))
 #endif
@@ -178,11 +45,6 @@ int __must_check kstrtos8(const char *s, unsigned int base, s8 *res);
 #define SHRT_MIN       ((s16)(-SHRT_MAX - 1))
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35)
-#define hex_to_bin LINUX_BACKPORT(hex_to_bin)
-int hex_to_bin(char ch);
-#endif
-
 #ifndef __round_mask
 #define __round_mask(x, y) ((__typeof__(x))((y)-1))
 #define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
diff --git a/backport/backport-include/linux/kfifo.h b/backport/backport-include/linux/kfifo.h
index 379c1cb..b797a0e 100644
--- a/backport/backport-include/linux/kfifo.h
+++ b/backport/backport-include/linux/kfifo.h
@@ -1,10 +1,8 @@
+#ifndef BACKPORT_LINUX_KFIFO_H
+#define BACKPORT_LINUX_KFIFO_H
+
 #include <linux/version.h>
-#ifndef CPTCFG_BACKPORT_BUILD_KFIFO
-#if (RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(6,4))
 #include_next <linux/kfifo.h>
-#else
-#include <linux/kfifo-new.h>
-#endif
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)
 #undef kfifo_put
@@ -50,859 +48,4 @@
 })
 #endif
 
-#else
-/*
- * A generic kernel FIFO implementation
- *
- * Copyright (C) 2013 Stefani Seibold <stefani@seibold.net>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
-
-#ifndef _LINUX_KFIFO_H
-#define _LINUX_KFIFO_H
-
-/*
- * How to porting drivers to the new generic FIFO API:
- *
- * - Modify the declaration of the "struct kfifo *" object into a
- *   in-place "struct kfifo" object
- * - Init the in-place object with kfifo_alloc() or kfifo_init()
- *   Note: The address of the in-place "struct kfifo" object must be
- *   passed as the first argument to this functions
- * - Replace the use of __kfifo_put into kfifo_in and __kfifo_get
- *   into kfifo_out
- * - Replace the use of kfifo_put into kfifo_in_spinlocked and kfifo_get
- *   into kfifo_out_spinlocked
- *   Note: the spinlock pointer formerly passed to kfifo_init/kfifo_alloc
- *   must be passed now to the kfifo_in_spinlocked and kfifo_out_spinlocked
- *   as the last parameter
- * - The formerly __kfifo_* functions are renamed into kfifo_*
- */
-
-/*
- * Note about locking : There is no locking required until only * one reader
- * and one writer is using the fifo and no kfifo_reset() will be * called
- *  kfifo_reset_out() can be safely used, until it will be only called
- * in the reader thread.
- *  For multiple writer and one reader there is only a need to lock the writer.
- * And vice versa for only one writer and multiple reader there is only a need
- * to lock the reader.
- */
-
-#include <linux/kernel.h>
-#include <linux/spinlock.h>
-#include <linux/stddef.h>
-#include <linux/scatterlist.h>
-
-struct __kfifo {
-	unsigned int	in;
-	unsigned int	out;
-	unsigned int	mask;
-	unsigned int	esize;
-	void		*data;
-};
-
-#define __STRUCT_KFIFO_COMMON(datatype, recsize, ptrtype) \
-	union { \
-		struct __kfifo	kfifo; \
-		datatype	*type; \
-		const datatype	*const_type; \
-		char		(*rectype)[recsize]; \
-		ptrtype		*ptr; \
-		ptrtype const	*ptr_const; \
-	}
-
-#define __STRUCT_KFIFO(type, size, recsize, ptrtype) \
-{ \
-	__STRUCT_KFIFO_COMMON(type, recsize, ptrtype); \
-	type		buf[((size < 2) || (size & (size - 1))) ? -1 : size]; \
-}
-
-#define STRUCT_KFIFO(type, size) \
-	struct __STRUCT_KFIFO(type, size, 0, type)
-
-#define __STRUCT_KFIFO_PTR(type, recsize, ptrtype) \
-{ \
-	__STRUCT_KFIFO_COMMON(type, recsize, ptrtype); \
-	type		buf[0]; \
-}
-
-#define STRUCT_KFIFO_PTR(type) \
-	struct __STRUCT_KFIFO_PTR(type, 0, type)
-
-/*
- * define compatibility "struct kfifo" for dynamic allocated fifos
- */
-struct kfifo __STRUCT_KFIFO_PTR(unsigned char, 0, void);
-
-#define STRUCT_KFIFO_REC_1(size) \
-	struct __STRUCT_KFIFO(unsigned char, size, 1, void)
-
-#define STRUCT_KFIFO_REC_2(size) \
-	struct __STRUCT_KFIFO(unsigned char, size, 2, void)
-
-/*
- * define kfifo_rec types
- */
-struct kfifo_rec_ptr_1 __STRUCT_KFIFO_PTR(unsigned char, 1, void);
-struct kfifo_rec_ptr_2 __STRUCT_KFIFO_PTR(unsigned char, 2, void);
-
-/*
- * helper macro to distinguish between real in place fifo where the fifo
- * array is a part of the structure and the fifo type where the array is
- * outside of the fifo structure.
- */
-#define	__is_kfifo_ptr(fifo)	(sizeof(*fifo) == sizeof(struct __kfifo))
-
-/**
- * DECLARE_KFIFO_PTR - macro to declare a fifo pointer object
- * @fifo: name of the declared fifo
- * @type: type of the fifo elements
- */
-#define DECLARE_KFIFO_PTR(fifo, type)	STRUCT_KFIFO_PTR(type) fifo
-
-/**
- * DECLARE_KFIFO - macro to declare a fifo object
- * @fifo: name of the declared fifo
- * @type: type of the fifo elements
- * @size: the number of elements in the fifo, this must be a power of 2
- */
-#define DECLARE_KFIFO(fifo, type, size)	STRUCT_KFIFO(type, size) fifo
-
-/**
- * INIT_KFIFO - Initialize a fifo declared by DECLARE_KFIFO
- * @fifo: name of the declared fifo datatype
- */
-#define INIT_KFIFO(fifo) \
-(void)({ \
-	typeof(&(fifo)) __tmp = &(fifo); \
-	struct __kfifo *__kfifo = &__tmp->kfifo; \
-	__kfifo->in = 0; \
-	__kfifo->out = 0; \
-	__kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : ARRAY_SIZE(__tmp->buf) - 1;\
-	__kfifo->esize = sizeof(*__tmp->buf); \
-	__kfifo->data = __is_kfifo_ptr(__tmp) ?  NULL : __tmp->buf; \
-})
-
-/**
- * DEFINE_KFIFO - macro to define and initialize a fifo
- * @fifo: name of the declared fifo datatype
- * @type: type of the fifo elements
- * @size: the number of elements in the fifo, this must be a power of 2
- *
- * Note: the macro can be used for global and local fifo data type variables.
- */
-#define DEFINE_KFIFO(fifo, type, size) \
-	DECLARE_KFIFO(fifo, type, size) = \
-	(typeof(fifo)) { \
-		{ \
-			{ \
-			.in	= 0, \
-			.out	= 0, \
-			.mask	= __is_kfifo_ptr(&(fifo)) ? \
-				  0 : \
-				  ARRAY_SIZE((fifo).buf) - 1, \
-			.esize	= sizeof(*(fifo).buf), \
-			.data	= __is_kfifo_ptr(&(fifo)) ? \
-				NULL : \
-				(fifo).buf, \
-			} \
-		} \
-	}
-
-
-static inline unsigned int __must_check
-__kfifo_uint_must_check_helper(unsigned int val)
-{
-	return val;
-}
-
-static inline int __must_check
-__kfifo_int_must_check_helper(int val)
-{
-	return val;
-}
-
-#define __kfifo_alloc LINUX_BACKPORT(__kfifo_alloc)
-extern int __kfifo_alloc(struct __kfifo *fifo, unsigned int size,
-	size_t esize, gfp_t gfp_mask);
-
-#define __kfifo_free LINUX_BACKPORT(__kfifo_free)
-extern void __kfifo_free(struct __kfifo *fifo);
-
-#define __kfifo_init LINUX_BACKPORT(__kfifo_init)
-extern int __kfifo_init(struct __kfifo *fifo, void *buffer,
-	unsigned int size, size_t esize);
-
-#define __kfifo_in LINUX_BACKPORT(__kfifo_in)
-extern unsigned int __kfifo_in(struct __kfifo *fifo,
-	const void *buf, unsigned int len);
-
-#define __kfifo_out LINUX_BACKPORT(__kfifo_out)
-extern unsigned int __kfifo_out(struct __kfifo *fifo,
-	void *buf, unsigned int len);
-
-#define __kfifo_from_user LINUX_BACKPORT(__kfifo_from_user)
-extern int __kfifo_from_user(struct __kfifo *fifo,
-	const void __user *from, unsigned long len, unsigned int *copied);
-
-#define __kfifo_to_user LINUX_BACKPORT(__kfifo_to_user)
-extern int __kfifo_to_user(struct __kfifo *fifo,
-	void __user *to, unsigned long len, unsigned int *copied);
-
-#define __kfifo_dma_in_prepare LINUX_BACKPORT(__kfifo_dma_in_prepare)
-extern unsigned int __kfifo_dma_in_prepare(struct __kfifo *fifo,
-	struct scatterlist *sgl, int nents, unsigned int len);
-
-#define __kfifo_dma_out_prepare LINUX_BACKPORT(__kfifo_dma_out_prepare)
-extern unsigned int __kfifo_dma_out_prepare(struct __kfifo *fifo,
-	struct scatterlist *sgl, int nents, unsigned int len);
-
-#define __kfifo_out_peek LINUX_BACKPORT(__kfifo_out_peek)
-extern unsigned int __kfifo_out_peek(struct __kfifo *fifo,
-	void *buf, unsigned int len);
-
-#define __kfifo_in_r LINUX_BACKPORT(__kfifo_in_r)
-extern unsigned int __kfifo_in_r(struct __kfifo *fifo,
-	const void *buf, unsigned int len, size_t recsize);
-
-#define __kfifo_out_r LINUX_BACKPORT(__kfifo_out_r)
-extern unsigned int __kfifo_out_r(struct __kfifo *fifo,
-	void *buf, unsigned int len, size_t recsize);
-
-#define __kfifo_from_user_r LINUX_BACKPORT(__kfifo_from_user_r)
-extern int __kfifo_from_user_r(struct __kfifo *fifo,
-	const void __user *from, unsigned long len, unsigned int *copied,
-	size_t recsize);
-
-#define __kfifo_to_user_r LINUX_BACKPORT(__kfifo_to_user_r)
-extern int __kfifo_to_user_r(struct __kfifo *fifo, void __user *to,
-	unsigned long len, unsigned int *copied, size_t recsize);
-
-#define __kfifo_dma_in_prepare_r LINUX_BACKPORT(__kfifo_dma_in_prepare_r)
-extern unsigned int __kfifo_dma_in_prepare_r(struct __kfifo *fifo,
-	struct scatterlist *sgl, int nents, unsigned int len, size_t recsize);
-
-#define __kfifo_dma_in_finish_r LINUX_BACKPORT(__kfifo_dma_in_finish_r)
-extern void __kfifo_dma_in_finish_r(struct __kfifo *fifo,
-	unsigned int len, size_t recsize);
-
-#define __kfifo_dma_out_prepare_r LINUX_BACKPORT(__kfifo_dma_out_prepare_r)
-extern unsigned int __kfifo_dma_out_prepare_r(struct __kfifo *fifo,
-	struct scatterlist *sgl, int nents, unsigned int len, size_t recsize);
-
-#define __kfifo_dma_out_finish_r LINUX_BACKPORT(__kfifo_dma_out_finish_r)
-extern void __kfifo_dma_out_finish_r(struct __kfifo *fifo, size_t recsize);
-
-#define __kfifo_len_r LINUX_BACKPORT(__kfifo_len_r)
-extern unsigned int __kfifo_len_r(struct __kfifo *fifo, size_t recsize);
-
-#define __kfifo_skip_r LINUX_BACKPORT(__kfifo_skip_r)
-extern void __kfifo_skip_r(struct __kfifo *fifo, size_t recsize);
-
-#define __kfifo_out_peek_r LINUX_BACKPORT(__kfifo_out_peek_r)
-extern unsigned int __kfifo_out_peek_r(struct __kfifo *fifo,
-	void *buf, unsigned int len, size_t recsize);
-
-#define __kfifo_max_r LINUX_BACKPORT(__kfifo_max_r)
-extern unsigned int __kfifo_max_r(unsigned int len, size_t recsize);
-
-/**
- * kfifo_initialized - Check if the fifo is initialized
- * @fifo: address of the fifo to check
- *
- * Return %true if fifo is initialized, otherwise %false.
- * Assumes the fifo was 0 before.
- */
-#define kfifo_initialized(fifo) ((fifo)->kfifo.mask)
-
-/**
- * kfifo_esize - returns the size of the element managed by the fifo
- * @fifo: address of the fifo to be used
- */
-#define kfifo_esize(fifo)	((fifo)->kfifo.esize)
-
-/**
- * kfifo_recsize - returns the size of the record length field
- * @fifo: address of the fifo to be used
- */
-#define kfifo_recsize(fifo)	(sizeof(*(fifo)->rectype))
-
-/**
- * kfifo_size - returns the size of the fifo in elements
- * @fifo: address of the fifo to be used
- */
-#define kfifo_size(fifo)	((fifo)->kfifo.mask + 1)
-
-/**
- * kfifo_reset - removes the entire fifo content
- * @fifo: address of the fifo to be used
- *
- * Note: usage of kfifo_reset() is dangerous. It should be only called when the
- * fifo is exclusived locked or when it is secured that no other thread is
- * accessing the fifo.
- */
-#define kfifo_reset(fifo) \
-(void)({ \
-	typeof((fifo) + 1) __tmp = (fifo); \
-	__tmp->kfifo.in = __tmp->kfifo.out = 0; \
-})
-
-/**
- * kfifo_reset_out - skip fifo content
- * @fifo: address of the fifo to be used
- *
- * Note: The usage of kfifo_reset_out() is safe until it will be only called
- * from the reader thread and there is only one concurrent reader. Otherwise
- * it is dangerous and must be handled in the same way as kfifo_reset().
- */
-#define kfifo_reset_out(fifo)	\
-(void)({ \
-	typeof((fifo) + 1) __tmp = (fifo); \
-	__tmp->kfifo.out = __tmp->kfifo.in; \
-})
-
-/**
- * kfifo_len - returns the number of used elements in the fifo
- * @fifo: address of the fifo to be used
- */
-#define kfifo_len(fifo) \
-({ \
-	typeof((fifo) + 1) __tmpl = (fifo); \
-	__tmpl->kfifo.in - __tmpl->kfifo.out; \
-})
-
-/**
- * kfifo_is_empty - returns true if the fifo is empty
- * @fifo: address of the fifo to be used
- */
-#define	kfifo_is_empty(fifo) \
-({ \
-	typeof((fifo) + 1) __tmpq = (fifo); \
-	__tmpq->kfifo.in == __tmpq->kfifo.out; \
-})
-
-/**
- * kfifo_is_full - returns true if the fifo is full
- * @fifo: address of the fifo to be used
- */
-#define	kfifo_is_full(fifo) \
-({ \
-	typeof((fifo) + 1) __tmpq = (fifo); \
-	kfifo_len(__tmpq) > __tmpq->kfifo.mask; \
-})
-
-/**
- * kfifo_avail - returns the number of unused elements in the fifo
- * @fifo: address of the fifo to be used
- */
-#define	kfifo_avail(fifo) \
-__kfifo_uint_must_check_helper( \
-({ \
-	typeof((fifo) + 1) __tmpq = (fifo); \
-	const size_t __recsize = sizeof(*__tmpq->rectype); \
-	unsigned int __avail = kfifo_size(__tmpq) - kfifo_len(__tmpq); \
-	(__recsize) ? ((__avail <= __recsize) ? 0 : \
-	__kfifo_max_r(__avail - __recsize, __recsize)) : \
-	__avail; \
-}) \
-)
-
-/**
- * kfifo_skip - skip output data
- * @fifo: address of the fifo to be used
- */
-#define	kfifo_skip(fifo) \
-(void)({ \
-	typeof((fifo) + 1) __tmp = (fifo); \
-	const size_t __recsize = sizeof(*__tmp->rectype); \
-	struct __kfifo *__kfifo = &__tmp->kfifo; \
-	if (__recsize) \
-		__kfifo_skip_r(__kfifo, __recsize); \
-	else \
-		__kfifo->out++; \
-})
-
-/**
- * kfifo_peek_len - gets the size of the next fifo record
- * @fifo: address of the fifo to be used
- *
- * This function returns the size of the next fifo record in number of bytes.
- */
-#define kfifo_peek_len(fifo) \
-__kfifo_uint_must_check_helper( \
-({ \
-	typeof((fifo) + 1) __tmp = (fifo); \
-	const size_t __recsize = sizeof(*__tmp->rectype); \
-	struct __kfifo *__kfifo = &__tmp->kfifo; \
-	(!__recsize) ? kfifo_len(__tmp) * sizeof(*__tmp->type) : \
-	__kfifo_len_r(__kfifo, __recsize); \
-}) \
-)
-
-/**
- * kfifo_alloc - dynamically allocates a new fifo buffer
- * @fifo: pointer to the fifo
- * @size: the number of elements in the fifo, this must be a power of 2
- * @gfp_mask: get_free_pages mask, passed to kmalloc()
- *
- * This macro dynamically allocates a new fifo buffer.
- *
- * The numer of elements will be rounded-up to a power of 2.
- * The fifo will be release with kfifo_free().
- * Return 0 if no error, otherwise an error code.
- */
-#define kfifo_alloc(fifo, size, gfp_mask) \
-__kfifo_int_must_check_helper( \
-({ \
-	typeof((fifo) + 1) __tmp = (fifo); \
-	struct __kfifo *__kfifo = &__tmp->kfifo; \
-	__is_kfifo_ptr(__tmp) ? \
-	__kfifo_alloc(__kfifo, size, sizeof(*__tmp->type), gfp_mask) : \
-	-EINVAL; \
-}) \
-)
-
-/**
- * kfifo_free - frees the fifo
- * @fifo: the fifo to be freed
- */
-#define kfifo_free(fifo) \
-({ \
-	typeof((fifo) + 1) __tmp = (fifo); \
-	struct __kfifo *__kfifo = &__tmp->kfifo; \
-	if (__is_kfifo_ptr(__tmp)) \
-		__kfifo_free(__kfifo); \
-})
-
-/**
- * kfifo_init - initialize a fifo using a preallocated buffer
- * @fifo: the fifo to assign the buffer
- * @buffer: the preallocated buffer to be used
- * @size: the size of the internal buffer, this have to be a power of 2
- *
- * This macro initialize a fifo using a preallocated buffer.
- *
- * The numer of elements will be rounded-up to a power of 2.
- * Return 0 if no error, otherwise an error code.
- */
-#define kfifo_init(fifo, buffer, size) \
-({ \
-	typeof((fifo) + 1) __tmp = (fifo); \
-	struct __kfifo *__kfifo = &__tmp->kfifo; \
-	__is_kfifo_ptr(__tmp) ? \
-	__kfifo_init(__kfifo, buffer, size, sizeof(*__tmp->type)) : \
-	-EINVAL; \
-})
-
-/**
- * kfifo_put - put data into the fifo
- * @fifo: address of the fifo to be used
- * @val: the data to be added
- *
- * This macro copies the given value into the fifo.
- * It returns 0 if the fifo was full. Otherwise it returns the number
- * processed elements.
- *
- * Note that with only one concurrent reader and one concurrent
- * writer, you don't need extra locking to use these macro.
- */
-#define	kfifo_put(fifo, val) \
-({ \
-	typeof((fifo) + 1) __tmp = (fifo); \
-	typeof(*__tmp->const_type) __val = (val); \
-	unsigned int __ret; \
-	size_t __recsize = sizeof(*__tmp->rectype); \
-	struct __kfifo *__kfifo = &__tmp->kfifo; \
-	if (__recsize) \
-		__ret = __kfifo_in_r(__kfifo, &__val, sizeof(__val), \
-			__recsize); \
-	else { \
-		__ret = !kfifo_is_full(__tmp); \
-		if (__ret) { \
-			(__is_kfifo_ptr(__tmp) ? \
-			((typeof(__tmp->type))__kfifo->data) : \
-			(__tmp->buf) \
-			)[__kfifo->in & __tmp->kfifo.mask] = \
-				(typeof(*__tmp->type))__val; \
-			smp_wmb(); \
-			__kfifo->in++; \
-		} \
-	} \
-	__ret; \
-})
-
-/**
- * kfifo_get - get data from the fifo
- * @fifo: address of the fifo to be used
- * @val: address where to store the data
- *
- * This macro reads the data from the fifo.
- * It returns 0 if the fifo was empty. Otherwise it returns the number
- * processed elements.
- *
- * Note that with only one concurrent reader and one concurrent
- * writer, you don't need extra locking to use these macro.
- */
-#define	kfifo_get(fifo, val) \
-__kfifo_uint_must_check_helper( \
-({ \
-	typeof((fifo) + 1) __tmp = (fifo); \
-	typeof(__tmp->ptr) __val = (val); \
-	unsigned int __ret; \
-	const size_t __recsize = sizeof(*__tmp->rectype); \
-	struct __kfifo *__kfifo = &__tmp->kfifo; \
-	if (__recsize) \
-		__ret = __kfifo_out_r(__kfifo, __val, sizeof(*__val), \
-			__recsize); \
-	else { \
-		__ret = !kfifo_is_empty(__tmp); \
-		if (__ret) { \
-			*(typeof(__tmp->type))__val = \
-				(__is_kfifo_ptr(__tmp) ? \
-				((typeof(__tmp->type))__kfifo->data) : \
-				(__tmp->buf) \
-				)[__kfifo->out & __tmp->kfifo.mask]; \
-			smp_wmb(); \
-			__kfifo->out++; \
-		} \
-	} \
-	__ret; \
-}) \
-)
-
-/**
- * kfifo_peek - get data from the fifo without removing
- * @fifo: address of the fifo to be used
- * @val: address where to store the data
- *
- * This reads the data from the fifo without removing it from the fifo.
- * It returns 0 if the fifo was empty. Otherwise it returns the number
- * processed elements.
- *
- * Note that with only one concurrent reader and one concurrent
- * writer, you don't need extra locking to use these macro.
- */
-#define	kfifo_peek(fifo, val) \
-__kfifo_uint_must_check_helper( \
-({ \
-	typeof((fifo) + 1) __tmp = (fifo); \
-	typeof(__tmp->ptr) __val = (val); \
-	unsigned int __ret; \
-	const size_t __recsize = sizeof(*__tmp->rectype); \
-	struct __kfifo *__kfifo = &__tmp->kfifo; \
-	if (__recsize) \
-		__ret = __kfifo_out_peek_r(__kfifo, __val, sizeof(*__val), \
-			__recsize); \
-	else { \
-		__ret = !kfifo_is_empty(__tmp); \
-		if (__ret) { \
-			*(typeof(__tmp->type))__val = \
-				(__is_kfifo_ptr(__tmp) ? \
-				((typeof(__tmp->type))__kfifo->data) : \
-				(__tmp->buf) \
-				)[__kfifo->out & __tmp->kfifo.mask]; \
-			smp_wmb(); \
-		} \
-	} \
-	__ret; \
-}) \
-)
-
-/**
- * kfifo_in - put data into the fifo
- * @fifo: address of the fifo to be used
- * @buf: the data to be added
- * @n: number of elements to be added
- *
- * This macro copies the given buffer into the fifo and returns the
- * number of copied elements.
- *
- * Note that with only one concurrent reader and one concurrent
- * writer, you don't need extra locking to use these macro.
- */
-#define	kfifo_in(fifo, buf, n) \
-({ \
-	typeof((fifo) + 1) __tmp = (fifo); \
-	typeof(__tmp->ptr_const) __buf = (buf); \
-	unsigned long __n = (n); \
-	const size_t __recsize = sizeof(*__tmp->rectype); \
-	struct __kfifo *__kfifo = &__tmp->kfifo; \
-	(__recsize) ?\
-	__kfifo_in_r(__kfifo, __buf, __n, __recsize) : \
-	__kfifo_in(__kfifo, __buf, __n); \
-})
-
-/**
- * kfifo_in_spinlocked - put data into the fifo using a spinlock for locking
- * @fifo: address of the fifo to be used
- * @buf: the data to be added
- * @n: number of elements to be added
- * @lock: pointer to the spinlock to use for locking
- *
- * This macro copies the given values buffer into the fifo and returns the
- * number of copied elements.
- */
-#define	kfifo_in_spinlocked(fifo, buf, n, lock) \
-({ \
-	unsigned long __flags; \
-	unsigned int __ret; \
-	spin_lock_irqsave(lock, __flags); \
-	__ret = kfifo_in(fifo, buf, n); \
-	spin_unlock_irqrestore(lock, __flags); \
-	__ret; \
-})
-
-/* alias for kfifo_in_spinlocked, will be removed in a future release */
-#define kfifo_in_locked(fifo, buf, n, lock) \
-		kfifo_in_spinlocked(fifo, buf, n, lock)
-
-/**
- * kfifo_out - get data from the fifo
- * @fifo: address of the fifo to be used
- * @buf: pointer to the storage buffer
- * @n: max. number of elements to get
- *
- * This macro get some data from the fifo and return the numbers of elements
- * copied.
- *
- * Note that with only one concurrent reader and one concurrent
- * writer, you don't need extra locking to use these macro.
- */
-#define	kfifo_out(fifo, buf, n) \
-__kfifo_uint_must_check_helper( \
-({ \
-	typeof((fifo) + 1) __tmp = (fifo); \
-	typeof(__tmp->ptr) __buf = (buf); \
-	unsigned long __n = (n); \
-	const size_t __recsize = sizeof(*__tmp->rectype); \
-	struct __kfifo *__kfifo = &__tmp->kfifo; \
-	(__recsize) ?\
-	__kfifo_out_r(__kfifo, __buf, __n, __recsize) : \
-	__kfifo_out(__kfifo, __buf, __n); \
-}) \
-)
-
-/**
- * kfifo_out_spinlocked - get data from the fifo using a spinlock for locking
- * @fifo: address of the fifo to be used
- * @buf: pointer to the storage buffer
- * @n: max. number of elements to get
- * @lock: pointer to the spinlock to use for locking
- *
- * This macro get the data from the fifo and return the numbers of elements
- * copied.
- */
-#define	kfifo_out_spinlocked(fifo, buf, n, lock) \
-__kfifo_uint_must_check_helper( \
-({ \
-	unsigned long __flags; \
-	unsigned int __ret; \
-	spin_lock_irqsave(lock, __flags); \
-	__ret = kfifo_out(fifo, buf, n); \
-	spin_unlock_irqrestore(lock, __flags); \
-	__ret; \
-}) \
-)
-
-/* alias for kfifo_out_spinlocked, will be removed in a future release */
-#define kfifo_out_locked(fifo, buf, n, lock) \
-		kfifo_out_spinlocked(fifo, buf, n, lock)
-
-/**
- * kfifo_from_user - puts some data from user space into the fifo
- * @fifo: address of the fifo to be used
- * @from: pointer to the data to be added
- * @len: the length of the data to be added
- * @copied: pointer to output variable to store the number of copied bytes
- *
- * This macro copies at most @len bytes from the @from into the
- * fifo, depending of the available space and returns -EFAULT/0.
- *
- * Note that with only one concurrent reader and one concurrent
- * writer, you don't need extra locking to use these macro.
- */
-#define	kfifo_from_user(fifo, from, len, copied) \
-__kfifo_uint_must_check_helper( \
-({ \
-	typeof((fifo) + 1) __tmp = (fifo); \
-	const void __user *__from = (from); \
-	unsigned int __len = (len); \
-	unsigned int *__copied = (copied); \
-	const size_t __recsize = sizeof(*__tmp->rectype); \
-	struct __kfifo *__kfifo = &__tmp->kfifo; \
-	(__recsize) ? \
-	__kfifo_from_user_r(__kfifo, __from, __len,  __copied, __recsize) : \
-	__kfifo_from_user(__kfifo, __from, __len, __copied); \
-}) \
-)
-
-/**
- * kfifo_to_user - copies data from the fifo into user space
- * @fifo: address of the fifo to be used
- * @to: where the data must be copied
- * @len: the size of the destination buffer
- * @copied: pointer to output variable to store the number of copied bytes
- *
- * This macro copies at most @len bytes from the fifo into the
- * @to buffer and returns -EFAULT/0.
- *
- * Note that with only one concurrent reader and one concurrent
- * writer, you don't need extra locking to use these macro.
- */
-#define	kfifo_to_user(fifo, to, len, copied) \
-__kfifo_uint_must_check_helper( \
-({ \
-	typeof((fifo) + 1) __tmp = (fifo); \
-	void __user *__to = (to); \
-	unsigned int __len = (len); \
-	unsigned int *__copied = (copied); \
-	const size_t __recsize = sizeof(*__tmp->rectype); \
-	struct __kfifo *__kfifo = &__tmp->kfifo; \
-	(__recsize) ? \
-	__kfifo_to_user_r(__kfifo, __to, __len, __copied, __recsize) : \
-	__kfifo_to_user(__kfifo, __to, __len, __copied); \
-}) \
-)
-
-/**
- * kfifo_dma_in_prepare - setup a scatterlist for DMA input
- * @fifo: address of the fifo to be used
- * @sgl: pointer to the scatterlist array
- * @nents: number of entries in the scatterlist array
- * @len: number of elements to transfer
- *
- * This macro fills a scatterlist for DMA input.
- * It returns the number entries in the scatterlist array.
- *
- * Note that with only one concurrent reader and one concurrent
- * writer, you don't need extra locking to use these macros.
- */
-#define	kfifo_dma_in_prepare(fifo, sgl, nents, len) \
-({ \
-	typeof((fifo) + 1) __tmp = (fifo); \
-	struct scatterlist *__sgl = (sgl); \
-	int __nents = (nents); \
-	unsigned int __len = (len); \
-	const size_t __recsize = sizeof(*__tmp->rectype); \
-	struct __kfifo *__kfifo = &__tmp->kfifo; \
-	(__recsize) ? \
-	__kfifo_dma_in_prepare_r(__kfifo, __sgl, __nents, __len, __recsize) : \
-	__kfifo_dma_in_prepare(__kfifo, __sgl, __nents, __len); \
-})
-
-/**
- * kfifo_dma_in_finish - finish a DMA IN operation
- * @fifo: address of the fifo to be used
- * @len: number of bytes to received
- *
- * This macro finish a DMA IN operation. The in counter will be updated by
- * the len parameter. No error checking will be done.
- *
- * Note that with only one concurrent reader and one concurrent
- * writer, you don't need extra locking to use these macros.
- */
-#define kfifo_dma_in_finish(fifo, len) \
-(void)({ \
-	typeof((fifo) + 1) __tmp = (fifo); \
-	unsigned int __len = (len); \
-	const size_t __recsize = sizeof(*__tmp->rectype); \
-	struct __kfifo *__kfifo = &__tmp->kfifo; \
-	if (__recsize) \
-		__kfifo_dma_in_finish_r(__kfifo, __len, __recsize); \
-	else \
-		__kfifo->in += __len / sizeof(*__tmp->type); \
-})
-
-/**
- * kfifo_dma_out_prepare - setup a scatterlist for DMA output
- * @fifo: address of the fifo to be used
- * @sgl: pointer to the scatterlist array
- * @nents: number of entries in the scatterlist array
- * @len: number of elements to transfer
- *
- * This macro fills a scatterlist for DMA output which at most @len bytes
- * to transfer.
- * It returns the number entries in the scatterlist array.
- * A zero means there is no space available and the scatterlist is not filled.
- *
- * Note that with only one concurrent reader and one concurrent
- * writer, you don't need extra locking to use these macros.
- */
-#define	kfifo_dma_out_prepare(fifo, sgl, nents, len) \
-({ \
-	typeof((fifo) + 1) __tmp = (fifo);  \
-	struct scatterlist *__sgl = (sgl); \
-	int __nents = (nents); \
-	unsigned int __len = (len); \
-	const size_t __recsize = sizeof(*__tmp->rectype); \
-	struct __kfifo *__kfifo = &__tmp->kfifo; \
-	(__recsize) ? \
-	__kfifo_dma_out_prepare_r(__kfifo, __sgl, __nents, __len, __recsize) : \
-	__kfifo_dma_out_prepare(__kfifo, __sgl, __nents, __len); \
-})
-
-/**
- * kfifo_dma_out_finish - finish a DMA OUT operation
- * @fifo: address of the fifo to be used
- * @len: number of bytes transferd
- *
- * This macro finish a DMA OUT operation. The out counter will be updated by
- * the len parameter. No error checking will be done.
- *
- * Note that with only one concurrent reader and one concurrent
- * writer, you don't need extra locking to use these macros.
- */
-#define kfifo_dma_out_finish(fifo, len) \
-(void)({ \
-	typeof((fifo) + 1) __tmp = (fifo); \
-	unsigned int __len = (len); \
-	const size_t __recsize = sizeof(*__tmp->rectype); \
-	struct __kfifo *__kfifo = &__tmp->kfifo; \
-	if (__recsize) \
-		__kfifo_dma_out_finish_r(__kfifo, __recsize); \
-	else \
-		__kfifo->out += __len / sizeof(*__tmp->type); \
-})
-
-/**
- * kfifo_out_peek - gets some data from the fifo
- * @fifo: address of the fifo to be used
- * @buf: pointer to the storage buffer
- * @n: max. number of elements to get
- *
- * This macro get the data from the fifo and return the numbers of elements
- * copied. The data is not removed from the fifo.
- *
- * Note that with only one concurrent reader and one concurrent
- * writer, you don't need extra locking to use these macro.
- */
-#define	kfifo_out_peek(fifo, buf, n) \
-__kfifo_uint_must_check_helper( \
-({ \
-	typeof((fifo) + 1) __tmp = (fifo); \
-	typeof(__tmp->ptr) __buf = (buf); \
-	unsigned long __n = (n); \
-	const size_t __recsize = sizeof(*__tmp->rectype); \
-	struct __kfifo *__kfifo = &__tmp->kfifo; \
-	(__recsize) ? \
-	__kfifo_out_peek_r(__kfifo, __buf, __n, __recsize) : \
-	__kfifo_out_peek(__kfifo, __buf, __n); \
-}) \
-)
-#endif
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36)) */
+#endif /* BACKPORT_LINUX_KFIFO_H */
diff --git a/backport/backport-include/linux/kmemleak.h b/backport/backport-include/linux/kmemleak.h
deleted file mode 100644
index 99fff66..0000000
--- a/backport/backport-include/linux/kmemleak.h
+++ /dev/null
@@ -1,24 +0,0 @@
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,30))
-#include_next <linux/kmemleak.h>
-#else
-/*
- * kmemleak was introduced on 2.6.31, since older kernels do not have
- * we simply ignore its tuning.
- */
-static inline void kmemleak_ignore(const void *ptr)
-{
-	return;
-}
-
-static inline void kmemleak_not_leak(const void *ptr)
-{
-	return;
-}
-
-static inline void kmemleak_no_scan(const void *ptr)
-{
-	return;
-}
-#endif
diff --git a/backport/backport-include/linux/ktime.h b/backport/backport-include/linux/ktime.h
deleted file mode 100644
index 473ca91..0000000
--- a/backport/backport-include/linux/ktime.h
+++ /dev/null
@@ -1,15 +0,0 @@
-#ifndef __BACKPORT_LINUX_KTIME_H
-#define __BACKPORT_LINUX_KTIME_H
-#include_next <linux/ktime.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35)
-#define ktime_to_ms LINUX_BACKPORT(ktime_to_ms)
-static inline s64 ktime_to_ms(const ktime_t kt)
-{
-	struct timeval tv = ktime_to_timeval(kt);
-	return (s64) tv.tv_sec * MSEC_PER_SEC + tv.tv_usec / USEC_PER_MSEC;
-}
-#endif /* #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35) */
-
-#endif
diff --git a/backport/backport-include/linux/leds.h b/backport/backport-include/linux/leds.h
index 6148040..22679cf 100644
--- a/backport/backport-include/linux/leds.h
+++ b/backport/backport-include/linux/leds.h
@@ -24,22 +24,7 @@
  *   Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
  */
 #define led_set_brightness(_dev, _switch) led_brightness_set(_dev, _switch)
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37) && \
-    !defined(CPTCFG_BACKPORT_BUILD_LEDS)
-#define led_blink_set LINUX_BACKPORT(led_blink_set)
-extern void led_blink_set(struct led_classdev *led_cdev,
-			  unsigned long *delay_on,
-			  unsigned long *delay_off);
-
-#define led_classdev_unregister compat_led_classdev_unregister
-extern void compat_led_classdev_unregister(struct led_classdev *led_cdev);
-
-#define led_brightness_set compat_led_brightness_set
-extern void compat_led_brightness_set(struct led_classdev *led_cdev,
-				      enum led_brightness brightness);
-#endif
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0) */
 
 #include <backport/leds-disabled.h>
 
diff --git a/backport/backport-include/linux/list.h b/backport/backport-include/linux/list.h
index 3835595..4e1b3ca 100644
--- a/backport/backport-include/linux/list.h
+++ b/backport/backport-include/linux/list.h
@@ -50,71 +50,6 @@
 
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,26)
-static inline int list_is_singular(const struct list_head *head)
-{
-	return !list_empty(head) && (head->next == head->prev);
-}
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27)
-static inline void __list_cut_position(struct list_head *list,
-		struct list_head *head, struct list_head *entry)
-{
-	struct list_head *new_first = entry->next;
-	list->next = head->next;
-	list->next->prev = list;
-	list->prev = entry;
-	entry->next = list;
-	head->next = new_first;
-	new_first->prev = head;
-}
-
-static inline void list_cut_position(struct list_head *list,
-		struct list_head *head, struct list_head *entry)
-{
-	if (list_empty(head))
-		return;
-	if (list_is_singular(head) &&
-		(head->next != entry && head != entry))
-		return;
-	if (entry == head)
-		INIT_LIST_HEAD(list);
-	else
-		__list_cut_position(list, head, entry);
-}
-
-static inline void __compat_list_splice_new_27(const struct list_head *list,
-				 struct list_head *prev,
-				 struct list_head *next)
-{
-	struct list_head *first = list->next;
-	struct list_head *last = list->prev;
-
-	first->prev = prev;
-	prev->next = first;
-
-	last->next = next;
-	next->prev = last;
-}
-
-static inline void list_splice_tail(struct list_head *list,
-				struct list_head *head)
-{
-	if (!list_empty(list))
-		__compat_list_splice_new_27(list, head->prev, head);
-}
-
-static inline void list_splice_tail_init(struct list_head *list,
-					 struct list_head *head)
-{
-	if (!list_empty(list)) {
-		__compat_list_splice_new_27(list, head->prev, head);
-		INIT_LIST_HEAD(list);
-	}
-}
-#endif
-
 #ifndef list_first_entry_or_null
 /**
  * list_first_entry_or_null - get the first element from a list
diff --git a/backport/backport-include/linux/lockdep.h b/backport/backport-include/linux/lockdep.h
index c194713..1d4aa65 100644
--- a/backport/backport-include/linux/lockdep.h
+++ b/backport/backport-include/linux/lockdep.h
@@ -3,52 +3,8 @@
 #include_next <linux/lockdep.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,38)
-/* Backport of:
- *
- * commit e159489baa717dbae70f9903770a6a4990865887
- * Author: Tejun Heo <tj@kernel.org>
- * Date:   Sun Jan 9 23:32:15 2011 +0100
- *
- *     workqueue: relax lockdep annotation on flush_work()
- */
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-# ifdef CONFIG_PROVE_LOCKING
-#  define lock_map_acquire_read(l)	lock_acquire(l, 0, 0, 2, 2, NULL, _THIS_IP_)
-# else
-#  define lock_map_acquire_read(l)	lock_acquire(l, 0, 0, 2, 1, NULL, _THIS_IP_)
-# endif
-#else
-# define lock_map_acquire_read(l)		do { } while (0)
-#endif
-
-#endif /* < 2.6.38 */
-
 #ifndef lockdep_assert_held
 #define lockdep_assert_held(l)			do { } while (0)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27)
-/* Backport of:
- *
- * commit 3295f0ef9ff048a4619ede597ad9ec9cab725654
- * Author: Ingo Molnar <mingo@elte.hu>
- * Date:   Mon Aug 11 10:30:30 2008 +0200
- *
- *     lockdep: rename map_[acquire|release]() => lock_map_[acquire|release]()
- */
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-# ifdef CONFIG_PROVE_LOCKING
-#  define lock_map_acquire(l)		lock_acquire(l, 0, 0, 0, 2, NULL, _THIS_IP_)
-# else
-#  define lock_map_acquire(l)		lock_acquire(l, 0, 0, 0, 1, NULL, _THIS_IP_)
-# endif
-# define lock_map_release(l)			lock_release(l, 1, _THIS_IP_)
-#else
-# define lock_map_acquire(l)			do { } while (0)
-# define lock_map_release(l)			do { } while (0)
-#endif
-
-#endif /* < 2.6.27 */
-
 #endif /* __BACKPORT_LINUX_LOCKDEP_H */
diff --git a/backport/backport-include/linux/math64.h b/backport/backport-include/linux/math64.h
deleted file mode 100644
index b65fab3..0000000
--- a/backport/backport-include/linux/math64.h
+++ /dev/null
@@ -1,43 +0,0 @@
-#ifndef _COMPAT_LINUX_MATH64_H
-#define _COMPAT_LINUX_MATH64_H 1
-
-#include <linux/version.h>
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,25))
-#include_next <linux/math64.h>
-#else
-#include <linux/types.h>
-#include <asm/div64.h>
-#endif /* (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,25)) */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,26)
-#if BITS_PER_LONG == 64
-
-static inline u64 div_u64_rem(u64 dividend, u32 divisor, u32 *remainder)
-{
-	*remainder = dividend % divisor;
-	return dividend / divisor;
-}
-
-#elif BITS_PER_LONG == 32
-
-#ifndef div_u64_rem
-static inline u64 div_u64_rem(u64 dividend, u32 divisor, u32 *remainder)
-{
-	*remainder = do_div(dividend, divisor);
-	return dividend;
-}
-#endif
-
-#endif /* BITS_PER_LONG */
-
-#ifndef div_u64
-static inline u64 div_u64(u64 dividend, u32 divisor)
-{
-	u32 remainder;
-	return div_u64_rem(dividend, divisor, &remainder);
-}
-#endif
-
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2,6,26) */
-
-#endif	/* _COMPAT_LINUX_MATH64_H */
diff --git a/backport/backport-include/linux/mmc/core.h b/backport/backport-include/linux/mmc/core.h
deleted file mode 100644
index 02d7a98..0000000
--- a/backport/backport-include/linux/mmc/core.h
+++ /dev/null
@@ -1,12 +0,0 @@
-#ifndef __BACKPORT_MMC_CORE_H
-#define __BACKPORT_MMC_CORE_H
-#include <linux/version.h>
-#include_next <linux/mmc/core.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27) && \
-    LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,24)
-#define mmc_align_data_size LINUX_BACKPORT(mmc_align_data_size)
-extern unsigned int mmc_align_data_size(struct mmc_card *, unsigned int);
-#endif /* 2.6.24 - 2.6.26 */
-
-#endif /* __BACKPORT_MMC_CORE_H */
diff --git a/backport/backport-include/linux/mmc/sdio_func.h b/backport/backport-include/linux/mmc/sdio_func.h
index f32cafc..2d3e92b 100644
--- a/backport/backport-include/linux/mmc/sdio_func.h
+++ b/backport/backport-include/linux/mmc/sdio_func.h
@@ -3,38 +3,8 @@
 #include <linux/version.h>
 #include_next <linux/mmc/sdio_func.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35)
-#define sdio_writeb_readb(func, write_byte, addr, err_ret) sdio_readb(func, addr, err_ret)
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,34)
-/*
- * Backports da68c4eb25
- * sdio: introduce API for special power management features
- *
- * We simply carry around the data structures and flags, and
- * make the host return no flags set by the driver.
- *
- * This is declared in mmc/pm.h upstream, but that files
- * didn't exist before this commit and isn't included directly.
- */
-typedef unsigned int mmc_pm_flag_t;
-
-#define MMC_PM_KEEP_POWER      (1 << 0)        /* preserve card power during suspend */
-#define MMC_PM_WAKE_SDIO_IRQ   (1 << 1)        /* wake up host system on SDIO IRQ assertion */
-
-extern mmc_pm_flag_t sdio_get_host_pm_caps(struct sdio_func *func);
-extern int sdio_set_host_pm_flags(struct sdio_func *func, mmc_pm_flag_t flags);
-#endif
-
 #ifndef dev_to_sdio_func
 #define dev_to_sdio_func(d)	container_of(d, struct sdio_func, dev)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27) && \
-    LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,24)
-#define sdio_align_size LINUX_BACKPORT(sdio_align_size)
-extern unsigned int sdio_align_size(struct sdio_func *func, unsigned int sz);
-#endif /* 2.6.24 - 2.6.26 */
-
 #endif /* __BACKPORT_MMC_SDIO_FUNC_H */
diff --git a/backport/backport-include/linux/mod_devicetable.h b/backport/backport-include/linux/mod_devicetable.h
index 1f85ce6..ec0a3e6 100644
--- a/backport/backport-include/linux/mod_devicetable.h
+++ b/backport/backport-include/linux/mod_devicetable.h
@@ -14,36 +14,4 @@
 #define HID_ANY_ID                             (~0)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28)
-struct hid_device_id {
-	__u16 bus;
-	__u32 vendor;
-	__u32 product;
-	kernel_ulong_t driver_data
-		__attribute__((aligned(sizeof(kernel_ulong_t))));
-};
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,0,0)
-#ifndef BCMA_CORE
-/* Broadcom's specific AMBA core, see drivers/bcma/ */
-struct bcma_device_id {
-	__u16	manuf;
-	__u16	id;
-	__u8	rev;
-	__u8	class;
-};
-#define BCMA_CORE(_manuf, _id, _rev, _class)  \
-	{ .manuf = _manuf, .id = _id, .rev = _rev, .class = _class, }
-#define BCMA_CORETABLE_END  \
-	{ 0, },
-
-#define BCMA_ANY_MANUF		0xFFFF
-#define BCMA_ANY_ID		0xFFFF
-#define BCMA_ANY_REV		0xFF
-#define BCMA_ANY_CLASS		0xFF
-#endif /* BCMA_CORE */
-
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,0,0)) */
-
 #endif /* __BACKPORT_MOD_DEVICETABLE_H */
diff --git a/backport/backport-include/linux/net.h b/backport/backport-include/linux/net.h
index 687ad0b..385f807 100644
--- a/backport/backport-include/linux/net.h
+++ b/backport/backport-include/linux/net.h
@@ -5,7 +5,7 @@
 
 /* This backports:
  *
- * commit 2033e9bf06f07e049bbc77e9452856df846714cc
+ * commit 2033e9bf06f07e049bbc77e9452856df846714cc -- from v3.5
  * Author: Neil Horman <nhorman@tuxdriver.com>
  * Date:   Tue May 29 09:30:40 2012 +0000
  *
diff --git a/backport/backport-include/linux/netdev_features.h b/backport/backport-include/linux/netdev_features.h
index acb7cf8..76fb463 100644
--- a/backport/backport-include/linux/netdev_features.h
+++ b/backport/backport-include/linux/netdev_features.h
@@ -18,9 +18,9 @@
 #define NETIF_F_HW_VLAN_CTAG_FILTER		NETIF_F_HW_VLAN_FILTER
 #endif
 
-#if RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(6,5)
+/* c8f44aff made this u32 but later a861a8b2 changed it to u64 both on v3.3 */
 typedef u32 netdev_features_t;
-#endif
+
 #else
 #include_next <linux/netdev_features.h>
 
diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 5747df9..04b310d 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -93,162 +93,12 @@ enum { /* backport: provide the enum name already */
 };
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,33)
-
-/*
- * We can count on the enum definitions being present so
- * but since we cannot dedeclare the enum but we have to
- * peg the typedef to a similar enum we can just use the
- * same values and then use the #defines below to modify
- * code for older kernels to use the new enum we define
- * here. This works even for switch statements and gcc -Wall.
- * This backports 5b252f0c2
- */
-enum gro_result {
-	BACKPORT_GRO_MERGED 		= GRO_MERGED,
-	BACKPORT_GRO_MERGED_FREE 	= GRO_MERGED_FREE,
-	BACKPORT_GRO_HELD 		= GRO_HELD,
-	BACKPORT_GRO_NORMAL		= GRO_NORMAL,
-	BACKPORT_GRO_DROP		= GRO_DROP,
-};
-
-#define GRO_MERGED	BACKPORT_GRO_MERGED
-#define GRO_MERGED_FREE	BACKPORT_GRO_MERGED_FREE
-#define GRO_HELD	BACKPORT_GRO_HELD
-#define GRO_NORMAL	BACKPORT_GRO_NORMAL
-#define GRO_DROP	BACKPORT_GRO_DROP
-
-typedef enum gro_result gro_result_t;
-
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0) */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
-#define dev_change_net_namespace(a, b, c) (-EOPNOTSUPP)
-
-static inline void SET_NETDEV_DEVTYPE(struct net_device *dev, void *type)
-{
-	/* nothing */
-}
-
-typedef int netdev_tx_t;
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,29)
-/*
- * Older kernels do not have struct net_device_ops but what we can
- * do is just define the data structure and use a caller to let us
- * set the data structure's routines onto the old netdev, essentially
- * doing it the old way. This avoids huge deltas on our backports.
- */
-#define HAVE_NET_DEVICE_OPS
-struct net_device_ops {
-	int			(*ndo_init)(struct net_device *dev);
-	void			(*ndo_uninit)(struct net_device *dev);
-	int			(*ndo_open)(struct net_device *dev);
-	int			(*ndo_stop)(struct net_device *dev);
-	netdev_tx_t		(*ndo_start_xmit) (struct sk_buff *skb,
-						   struct net_device *dev);
-	u16			(*ndo_select_queue)(struct net_device *dev,
-						    struct sk_buff *skb);
-	void			(*ndo_change_rx_flags)(struct net_device *dev,
-						       int flags);
-	void			(*ndo_set_rx_mode)(struct net_device *dev);
-	void			(*ndo_set_multicast_list)(struct net_device *dev);
-	int			(*ndo_set_mac_address)(struct net_device *dev,
-						       void *addr);
-	int			(*ndo_validate_addr)(struct net_device *dev);
-	int			(*ndo_do_ioctl)(struct net_device *dev,
-					        struct ifreq *ifr, int cmd);
-	int			(*ndo_set_config)(struct net_device *dev,
-					          struct ifmap *map);
-	int			(*ndo_change_mtu)(struct net_device *dev,
-						  int new_mtu);
-	int			(*ndo_neigh_setup)(struct net_device *dev,
-						   struct neigh_parms *);
-	void			(*ndo_tx_timeout) (struct net_device *dev);
-
-	struct net_device_stats* (*ndo_get_stats)(struct net_device *dev);
-
-	void			(*ndo_vlan_rx_register)(struct net_device *dev,
-						        struct vlan_group *grp);
-	void			(*ndo_vlan_rx_add_vid)(struct net_device *dev,
-						       unsigned short vid);
-	void			(*ndo_vlan_rx_kill_vid)(struct net_device *dev,
-						        unsigned short vid);
-#ifdef CONFIG_NET_POLL_CONTROLLER
-	void                    (*ndo_poll_controller)(struct net_device *dev);
-#endif
-	int			(*ndo_set_vf_mac)(struct net_device *dev,
-						  int queue, u8 *mac);
-	int			(*ndo_set_vf_vlan)(struct net_device *dev,
-						   int queue, u16 vlan, u8 qos);
-	int			(*ndo_set_vf_tx_rate)(struct net_device *dev,
-						      int vf, int rate);
-#if defined(CONFIG_FCOE) || defined(CONFIG_FCOE_MODULE)
-	int			(*ndo_fcoe_enable)(struct net_device *dev);
-	int			(*ndo_fcoe_disable)(struct net_device *dev);
-	int			(*ndo_fcoe_ddp_setup)(struct net_device *dev,
-						      u16 xid,
-						      struct scatterlist *sgl,
-						      unsigned int sgc);
-	int			(*ndo_fcoe_ddp_done)(struct net_device *dev,
-						     u16 xid);
-#define NETDEV_FCOE_WWNN 0
-#define NETDEV_FCOE_WWPN 1
-	int			(*ndo_fcoe_get_wwn)(struct net_device *dev,
-						    u64 *wwn, int type);
-#endif
-};
-
-static inline struct net_device_stats *dev_get_stats(struct net_device *dev)
-{
-	return dev->get_stats(dev);
-}
-
-#define init_dummy_netdev LINUX_BACKPORT(init_dummy_netdev)
-extern int init_dummy_netdev(struct net_device *dev);
-
-#define napi_gro_receive(napi, skb) netif_receive_skb(skb)
-#endif /* < 2.6.29 */
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,8)
 #define netdev_set_default_ethtool_ops LINUX_BACKPORT(netdev_set_default_ethtool_ops)
 extern void netdev_set_default_ethtool_ops(struct net_device *dev,
 					   const struct ethtool_ops *ops);
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,29)
-#define netdev_attach_ops LINUX_BACKPORT(netdev_attach_ops)
-void netdev_attach_ops(struct net_device *dev,
-		       const struct net_device_ops *ops);
-
-static inline int ndo_do_ioctl(struct net_device *dev,
-			       struct ifreq *ifr,
-			       int cmd)
-{
-	if (dev->do_ioctl)
-		return dev->do_ioctl(dev, ifr, cmd);
-	return -EOPNOTSUPP;
-}
-#else
-/* XXX: this can probably just go upstream ! */
-static inline void netdev_attach_ops(struct net_device *dev,
-		       const struct net_device_ops *ops)
-{
-	dev->netdev_ops = ops;
-}
-
-/* XXX: this can probably just go upstream! */
-static inline int ndo_do_ioctl(struct net_device *dev,
-			       struct ifreq *ifr,
-			       int cmd)
-{
-	if (dev->netdev_ops && dev->netdev_ops->ndo_do_ioctl)
-		return dev->netdev_ops->ndo_do_ioctl(dev, ifr, cmd);
-	return -EOPNOTSUPP;
-}
-#endif
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
 /*
  * BQL was added as of v3.3 but some Linux distributions
@@ -258,26 +108,22 @@ static inline int ndo_do_ioctl(struct net_device *dev,
  * inlines if it was defined
  */
 #ifndef CONFIG_BQL
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,26))
 #define netdev_tx_sent_queue LINUX_BACKPORT(netdev_tx_sent_queue)
 static inline void netdev_tx_sent_queue(struct netdev_queue *dev_queue,
 					unsigned int bytes)
 {
 }
-#endif
 
 #define netdev_sent_queue LINUX_BACKPORT(netdev_sent_queue)
 static inline void netdev_sent_queue(struct net_device *dev, unsigned int bytes)
 {
 }
 
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,26))
 #define netdev_tx_completed_queue LINUX_BACKPORT(netdev_tx_completed_queue)
 static inline void netdev_tx_completed_queue(struct netdev_queue *dev_queue,
 					     unsigned pkts, unsigned bytes)
 {
 }
-#endif
 
 #define netdev_completed_queue LINUX_BACKPORT(netdev_completed_queue)
 static inline void netdev_completed_queue(struct net_device *dev,
@@ -285,12 +131,10 @@ static inline void netdev_completed_queue(struct net_device *dev,
 {
 }
 
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,26))
 #define netdev_tx_reset_queue LINUX_BACKPORT(netdev_tx_reset_queue)
 static inline void netdev_tx_reset_queue(struct netdev_queue *q)
 {
 }
-#endif
 
 #define netdev_reset_queue LINUX_BACKPORT(netdev_reset_queue)
 static inline void netdev_reset_queue(struct net_device *dev_queue)
@@ -299,289 +143,15 @@ static inline void netdev_reset_queue(struct net_device *dev_queue)
 #endif /* CONFIG_BQL */
 #endif /* < 3.3 */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,0,0)
-/*
- * since commit 1c5cae815d19ffe02bdfda1260949ef2b1806171
- * "net: call dev_alloc_name from register_netdevice" dev_alloc_name is
- * called automatically. This is not implemented in older kernel
- * versions so it will result in device wrong names.
- */
-static inline int register_netdevice_name(struct net_device *dev)
-{
-	int err;
-
-	if (strchr(dev->name, '%')) {
-		err = dev_alloc_name(dev, dev->name);
-		if (err < 0)
-			return err;
-	}
-
-	return register_netdevice(dev);
-}
-
-#define register_netdevice(dev) register_netdevice_name(dev)
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,38)
-#define alloc_netdev_mqs(sizeof_priv, name, setup, txqs, rxqs) \
-	alloc_netdev_mq(sizeof_priv, name, setup, \
-			max_t(unsigned int, txqs, rxqs))
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37)
-#define netdev_refcnt_read(a) atomic_read(&a->refcnt)
-
-#define net_ns_type_operations LINUX_BACKPORT(net_ns_type_operations)
-extern struct kobj_ns_type_operations net_ns_type_operations;
-
-#if (RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(6,4))
-#ifdef CONFIG_RPS
-extern int netif_set_real_num_rx_queues(struct net_device *dev,
-					unsigned int rxq);
-#else
-static inline int netif_set_real_num_rx_queues(struct net_device *dev,
-					       unsigned int rxq)
-{
-	return 0;
-}
-#endif
-#endif
-#endif /* < 2.6.37 */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35)
-/*
- * etherdevice.h requires netdev_hw_addr to not have been redefined,
- * so while generally we shouldn't/wouldn't include unrelated header
- * files here it's unavoidable. However, if we got included through
- * it, then we let it sort out the netdev_hw_addr define so that it
- * still gets the correct one later ...
- */
-#include <linux/etherdevice.h>
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35)
-#define netif_set_real_num_tx_queues LINUX_BACKPORT(netif_set_real_num_tx_queues)
-extern int netif_set_real_num_tx_queues(struct net_device *dev,
-					unsigned int txq);
-#define mc_addr(ha) (ha)->dmi_addr
-#else
-#define mc_addr(ha) (ha)->addr
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,34)
-#define netdev_mc_count(dev) ((dev)->mc_count)
-#define netdev_mc_empty(dev) (netdev_mc_count(dev) == 0)
-
-/* mask netdev_for_each_mc_addr as RHEL6 backports this */
-#ifndef netdev_for_each_mc_addr
-#define netdev_for_each_mc_addr(mclist, dev) \
-	for (mclist = dev->mc_list; mclist; mclist = mclist->next)
-#endif
-
-#ifndef netdev_name
-#define netdev_name(__dev) \
-	((__dev->reg_state != NETREG_REGISTERED) ? \
-		"(unregistered net_device)" : __dev->name)
-#endif
-
-#define netdev_printk(level, netdev, format, args...)		\
-	dev_printk(level, (netdev)->dev.parent,			\
-		   "%s: " format,				\
-		   netdev_name(netdev), ##args)
-
-#define netdev_emerg(dev, format, args...)			\
-	netdev_printk(KERN_EMERG, dev, format, ##args)
-#define netdev_alert(dev, format, args...)			\
-	netdev_printk(KERN_ALERT, dev, format, ##args)
-#define netdev_crit(dev, format, args...)			\
-	netdev_printk(KERN_CRIT, dev, format, ##args)
-#define netdev_err(dev, format, args...)			\
-	netdev_printk(KERN_ERR, dev, format, ##args)
-#define netdev_warn(dev, format, args...)			\
-	netdev_printk(KERN_WARNING, dev, format, ##args)
-#define netdev_notice(dev, format, args...)			\
-	netdev_printk(KERN_NOTICE, dev, format, ##args)
-#define netdev_info(dev, format, args...)			\
-	netdev_printk(KERN_INFO, dev, format, ##args)
-
-/* mask netdev_dbg as RHEL6 backports this */
-#if !defined(netdev_dbg)
-
-#if defined(DEBUG)
-#define netdev_dbg(__dev, format, args...)			\
-	netdev_printk(KERN_DEBUG, __dev, format, ##args)
-#elif defined(CONFIG_DYNAMIC_DEBUG)
-#define netdev_dbg(__dev, format, args...)			\
-do {								\
-	dynamic_dev_dbg((__dev)->dev.parent, "%s: " format,	\
-			netdev_name(__dev), ##args);		\
-} while (0)
-#else
-#define netdev_dbg(__dev, format, args...)			\
-({								\
-	if (0)							\
-		netdev_printk(KERN_DEBUG, __dev, format, ##args); \
-	0;							\
-})
-#endif
-
-#endif
-
-/* mask netdev_vdbg as RHEL6 backports this */
-#if !defined(netdev_dbg)
-
-#if defined(VERBOSE_DEBUG)
-#define netdev_vdbg	netdev_dbg
-#else
-
-#define netdev_vdbg(dev, format, args...)			\
-({								\
-	if (0)							\
-		netdev_printk(KERN_DEBUG, dev, format, ##args);	\
-	0;							\
-})
-#endif
-
-#endif
-
-/*
- * netdev_WARN() acts like dev_printk(), but with the key difference
- * of using a WARN/WARN_ON to get the message out, including the
- * file/line information and a backtrace.
- */
-#define netdev_WARN(dev, format, args...)			\
-	WARN(1, "netdevice: %s\n" format, netdev_name(dev), ##args);
-
-/* netif printk helpers, similar to netdev_printk */
-
-#define netif_printk(priv, type, level, dev, fmt, args...)	\
-do {					  			\
-	if (netif_msg_##type(priv))				\
-		netdev_printk(level, (dev), fmt, ##args);	\
-} while (0)
-
-#define netif_emerg(priv, type, dev, fmt, args...)		\
-	netif_printk(priv, type, KERN_EMERG, dev, fmt, ##args)
-#define netif_alert(priv, type, dev, fmt, args...)		\
-	netif_printk(priv, type, KERN_ALERT, dev, fmt, ##args)
-#define netif_crit(priv, type, dev, fmt, args...)		\
-	netif_printk(priv, type, KERN_CRIT, dev, fmt, ##args)
-#define netif_err(priv, type, dev, fmt, args...)		\
-	netif_printk(priv, type, KERN_ERR, dev, fmt, ##args)
-#define netif_warn(priv, type, dev, fmt, args...)		\
-	netif_printk(priv, type, KERN_WARNING, dev, fmt, ##args)
-#define netif_notice(priv, type, dev, fmt, args...)		\
-	netif_printk(priv, type, KERN_NOTICE, dev, fmt, ##args)
-#define netif_info(priv, type, dev, fmt, args...)		\
-	netif_printk(priv, type, KERN_INFO, (dev), fmt, ##args)
-
-/* mask netif_dbg as RHEL6 backports this */
-#if !defined(netif_dbg)
-
-#if defined(DEBUG)
-#define netif_dbg(priv, type, dev, format, args...)		\
-	netif_printk(priv, type, KERN_DEBUG, dev, format, ##args)
-#elif defined(CONFIG_DYNAMIC_DEBUG)
-#define netif_dbg(priv, type, netdev, format, args...)		\
-do {								\
-	if (netif_msg_##type(priv))				\
-		dynamic_dev_dbg((netdev)->dev.parent,		\
-				"%s: " format,			\
-				netdev_name(netdev), ##args);	\
-} while (0)
-#else
-#define netif_dbg(priv, type, dev, format, args...)			\
-({									\
-	if (0)								\
-		netif_printk(priv, type, KERN_DEBUG, dev, format, ##args); \
-	0;								\
-})
-#endif
-
-#endif
-
-/* mask netif_vdbg as RHEL6 backports this */
-#if !defined(netif_vdbg)
-
-#if defined(VERBOSE_DEBUG)
-#define netif_vdbg	netdev_dbg
-#else
-#define netif_vdbg(priv, type, dev, format, args...)		\
-({								\
-	if (0)							\
-		netif_printk(KERN_DEBUG, dev, format, ##args);	\
-	0;							\
-})
-#endif
-#endif
-
-#endif /* < 2.6.34 */
-
-/* mask NETDEV_POST_INIT as RHEL6 backports this */
-/* this will never happen on older kernels */
-#ifndef NETDEV_POST_INIT
-#define NETDEV_POST_INIT 0xffff
-#endif
-
 #ifndef NETDEV_PRE_UP
 #define NETDEV_PRE_UP		0x000D
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27)
-/*
- * On older kernels we do not have net_device Multi Queue support, but
- * since we no longer use MQ on mac80211 we can simply use the 0 queue.
- * Note that if other fullmac drivers make use of this they then need
- * to be backported somehow or deal with just 1 queue from MQ.
- */
-static inline void netif_tx_wake_all_queues(struct net_device *dev)
-{
-	netif_wake_queue(dev);
-}
-static inline void netif_tx_start_all_queues(struct net_device *dev)
-{
-	netif_start_queue(dev);
-}
-static inline void netif_tx_stop_all_queues(struct net_device *dev)
-{
-	netif_stop_queue(dev);
-}
-
-/*
- * The net_device has a spin_lock on newer kernels, on older kernels we're out of luck
- */
-#define netif_addr_lock_bh(dev)
-#define netif_addr_unlock_bh(dev)
-
-#define netif_wake_subqueue netif_start_subqueue
-#endif /* < 2.6.27 */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,26)
-static inline
-struct net *dev_net(const struct net_device *dev)
-{
-#ifdef CONFIG_NET_NS
-	/*
-	 * compat-wirelss backport note:
-	 * For older kernels we may just need to always return init_net,
-	 * not sure when we added dev->nd_net.
-	 */
-	return dev->nd_net;
-#else
-	return &init_net;
-#endif
-}
-#endif
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)
 #define netdev_notifier_info_to_dev(ndev) ndev
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,34) && \
-    LINUX_VERSION_CODE != KERNEL_VERSION(2,6,32)
-/* there is no equivalent function to update arp table */
-#define netdev_notify_peers(dev)
-#elif LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
 #define netdev_notify_peers(dev) netif_notify_peers(dev)
 #define napi_gro_flush(napi, old) napi_gro_flush(napi)
 #endif
diff --git a/backport/backport-include/linux/of.h b/backport/backport-include/linux/of.h
index e7f7ea7..c1ce91c 100644
--- a/backport/backport-include/linux/of.h
+++ b/backport/backport-include/linux/of.h
@@ -2,12 +2,7 @@
 #define _COMPAT_LINUX_OF_H 1
 
 #include <linux/version.h>
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34) || defined(CONFIG_OF)
 #include_next <linux/of.h>
-#else
-struct device_node;
-#endif
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
 #ifdef CONFIG_OF
diff --git a/backport/backport-include/linux/pci-aspm.h b/backport/backport-include/linux/pci-aspm.h
deleted file mode 100644
index d072677..0000000
--- a/backport/backport-include/linux/pci-aspm.h
+++ /dev/null
@@ -1,13 +0,0 @@
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,26))
-#include_next <linux/pci-aspm.h>
-#else
-#define PCIE_LINK_STATE_L0S	1
-#define PCIE_LINK_STATE_L1	2
-#define PCIE_LINK_STATE_CLKPM	4
-
-static inline void pci_disable_link_state(struct pci_dev *pdev, int state)
-{
-}
-#endif
diff --git a/backport/backport-include/linux/phy.h b/backport/backport-include/linux/phy.h
index ff2aacf..4473e4e 100644
--- a/backport/backport-include/linux/phy.h
+++ b/backport/backport-include/linux/phy.h
@@ -8,14 +8,4 @@
 	phy_connect(dev, bus_id, handler, 0, interface)
 #endif
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36))
-#include <linux/mii.h>
-static inline int backport_phy_mii_ioctl(struct phy_device *phydev,
-					 struct ifreq *ifr, int cmd)
-{
-	return phy_mii_ioctl(phydev, if_mii(ifr), cmd);
-}
-#define phy_mii_ioctl LINUX_BACKPORT(phy_mii_ioctl)
-#endif
-
 #endif /* __BACKPORT_LINUX_PHY_H */
diff --git a/backport/backport-include/linux/pkt_sched.h b/backport/backport-include/linux/pkt_sched.h
index 40ed863..89ebeb8 100644
--- a/backport/backport-include/linux/pkt_sched.h
+++ b/backport/backport-include/linux/pkt_sched.h
@@ -10,6 +10,8 @@
  *   From: Eric Dumazet <edumazet@google.com>
  *   Date: Thu, 10 May 2012 07:51:25 +0000
  *   Subject: [PATCH] codel: Controlled Delay AQM
+ *
+ *   Added via v3.5
  */
 #ifndef TCA_CODEL_MAX
 /* CODEL */
diff --git a/backport/backport-include/linux/platform_device.h b/backport/backport-include/linux/platform_device.h
index 3735cc8..5b821ee 100644
--- a/backport/backport-include/linux/platform_device.h
+++ b/backport/backport-include/linux/platform_device.h
@@ -33,10 +33,4 @@ module_exit(__platform_driver##_exit);
                         platform_driver_unregister)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28)
-#define platform_device_register_data LINUX_BACKPORT(platform_device_register_data)
-extern struct platform_device *platform_device_register_data(struct device *,
-		const char *, int, const void *, size_t);
-#endif
-
 #endif /* __BACKPORT_PLATFORM_DEVICE_H */
diff --git a/backport/backport-include/linux/pm.h b/backport/backport-include/linux/pm.h
index d217c81..926b0bf 100644
--- a/backport/backport-include/linux/pm.h
+++ b/backport/backport-include/linux/pm.h
@@ -14,61 +14,4 @@
 #define PMSG_IS_AUTO(msg)	(((msg).event & PM_EVENT_AUTO) != 0)
 #endif
 
-#if LINUX_VERSION_CODE == KERNEL_VERSION(2,6,32)
-#undef SIMPLE_DEV_PM_OPS
-#define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
-const struct dev_pm_ops name = { \
-	.suspend = suspend_fn, \
-	.resume = resume_fn, \
-	.freeze = suspend_fn, \
-	.thaw = resume_fn, \
-	.poweroff = suspend_fn, \
-	.restore = resume_fn, \
-}
-#endif /* 2.6.32 */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
-/*
- * dev_pm_ops is only available on kernels >= 2.6.29, for
- * older kernels we rely on reverting the work to old
- * power management style stuff. On 2.6.29 the pci calls
- * weren't included yet though, so include them here.
- */
-#if LINUX_VERSION_CODE == KERNEL_VERSION(2,6,29)
-#define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn)		\
-struct dev_pm_ops name = {					\
-	.suspend = suspend_fn ## _compat,			\
-	.resume = resume_fn ## _compat,				\
-	.freeze = suspend_fn ## _compat,			\
-	.thaw = resume_fn ## _compat,				\
-	.poweroff = suspend_fn ## _compat,			\
-	.restore = resume_fn ## _compat,			\
-}
-#elif LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,30)
-#define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
-struct dev_pm_ops name = { \
-	.suspend = suspend_fn, \
-	.resume = resume_fn, \
-	.freeze = suspend_fn, \
-	.thaw = resume_fn, \
-	.poweroff = suspend_fn, \
-	.restore = resume_fn, \
-}
-#else
-#define ___BACKPORT_PASTE(a, b) a##b
-#define __BACKPORT_PASTE(a, b) ___BACKPORT_PASTE(a,b)
-#define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
-	struct {} __maybe_unused __BACKPORT_PASTE(__backport_avoid_warning_, __LINE__)
-#endif /* >= 2.6.29 */
-#endif /* < 2.6.32 */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,30)
-enum dpm_order {
-	DPM_ORDER_NONE,
-	DPM_ORDER_DEV_AFTER_PARENT,
-	DPM_ORDER_PARENT_BEFORE_DEV,
-	DPM_ORDER_DEV_LAST,
-};
-#endif
-
 #endif /* __BACKPORT_PM_H */
diff --git a/backport/backport-include/linux/pm_qos.h b/backport/backport-include/linux/pm_qos.h
index 26e23a5..1da2b20 100644
--- a/backport/backport-include/linux/pm_qos.h
+++ b/backport/backport-include/linux/pm_qos.h
@@ -13,43 +13,4 @@
 #define PM_QOS_DEFAULT_VALUE -1
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36)
-struct pm_qos_request_list {
-	u32 qos;
-	void *request;
-};
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35))
-
-#define pm_qos_add_request(_req, _class, _value) do {			\
-	(_req)->request = #_req;					\
-	(_req)->qos = _class;						\
-	pm_qos_add_requirement((_class), (_req)->request, (_value));	\
-    } while(0)
-
-#define pm_qos_update_request(_req, _value)				\
-	pm_qos_update_requirement((_req)->qos, (_req)->request, (_value))
-
-#define pm_qos_remove_request(_req)					\
-	pm_qos_remove_requirement((_req)->qos, (_req)->request)
-
-#else
-
-#define pm_qos_add_request(_req, _class, _value) do {			\
-	(_req)->request = pm_qos_add_request((_class), (_value));	\
-    } while (0)
-
-#define pm_qos_update_request(_req, _value)				\
-	pm_qos_update_request((_req)->request, (_value))
-
-#define pm_qos_remove_request(_req)					\
-	pm_qos_remove_request((_req)->request)
-
-#endif /* < 2.6.35 */
-#endif /* < 2.6.36 */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35)
-#define pm_qos_request(_qos) pm_qos_requirement(_qos)
-#endif
-
 #endif	/* _COMPAT_LINUX_PM_QOS_H */
diff --git a/backport/backport-include/linux/pm_runtime.h b/backport/backport-include/linux/pm_runtime.h
deleted file mode 100644
index 31cfde9..0000000
--- a/backport/backport-include/linux/pm_runtime.h
+++ /dev/null
@@ -1,65 +0,0 @@
-#include <linux/version.h>
-
-#ifndef __COMPAT_LINUX_PM_RUNTIME_H
-#define __COMPAT_LINUX_PM_RUNTIME_H
-
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32))
-#include_next <linux/pm_runtime.h>
-#else
-
-static inline void pm_runtime_enable(struct device *dev) {}
-
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32)) */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
-/*
- * Backports 5e928f77a09a07f9dd595bb8a489965d69a83458
- * run-time power management cannot really be backported
- * given that the implementation added bus specific
- * callbacks that we won't have on older kernels. If
- * you really want run-time power management or good
- * power management upgrade your kernel. We'll just
- * compile this out as if run-time power management was
- * disabled just as the kernel disables run-time power management
- * when CONFIG_PM_RUNTIME is disabled.
- */
-static inline void pm_runtime_init(struct device *dev) {}
-static inline void pm_runtime_remove(struct device *dev) {}
-static inline int pm_runtime_get(struct device *dev)
-{
-	return 0;
-}
-
-static inline int pm_runtime_get_sync(struct device *dev)
-{
-	return 0;
-}
-
-static inline int pm_runtime_put(struct device *dev)
-{
-	return 0;
-}
-
-static inline int pm_runtime_put_sync(struct device *dev)
-{
-	return 0;
-}
-
-static inline int pm_runtime_set_active(struct device *dev)
-{
-	return 0;
-}
-
-static inline void pm_runtime_set_suspended(struct device *dev)
-{
-}
-
-static inline void pm_runtime_disable(struct device *dev)
-{
-}
-
-static inline void pm_runtime_put_noidle(struct device *dev) {}
-static inline void pm_runtime_get_noresume(struct device *dev) {}
-#endif
-
-#endif
diff --git a/backport/backport-include/linux/poll.h b/backport/backport-include/linux/poll.h
index 978b95c..8e961af 100644
--- a/backport/backport-include/linux/poll.h
+++ b/backport/backport-include/linux/poll.h
@@ -3,8 +3,7 @@
 #include_next <linux/poll.h>
 #include <linux/version.h>
 
-#if  LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0) && \
-     LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,31)
+#if  LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)
 #define poll_does_not_wait LINUX_BACKPORT(poll_does_not_wait)
 static inline bool poll_does_not_wait(const poll_table *p)
 {
@@ -16,6 +15,6 @@ static inline unsigned long poll_requested_events(const poll_table *p)
 {
 	return p ? p->key : ~0UL;
 }
-#endif /* 2.6.31 <= version < 3.4 */
+#endif /* < 3.4 */
 
 #endif /* __BACKPORT_LINUX_POLL_H */
diff --git a/backport/backport-include/linux/printk.h b/backport/backport-include/linux/printk.h
index ff7140b..88989a9 100644
--- a/backport/backport-include/linux/printk.h
+++ b/backport/backport-include/linux/printk.h
@@ -2,12 +2,7 @@
 #define _COMPAT_LINUX_PRINTK_H 1
 
 #include <linux/version.h>
-
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,36))
 #include_next <linux/printk.h>
-#else
-#include <linux/kernel.h>
-#endif /* (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,35)) */
 
 /* see pr_fmt at end of file */
 
@@ -52,51 +47,6 @@ do {                                                           \
 })
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,38)
-#define pr_emerg_once(fmt, ...)					\
-	printk_once(KERN_EMERG pr_fmt(fmt), ##__VA_ARGS__)
-#define pr_alert_once(fmt, ...)					\
-	printk_once(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
-#define pr_crit_once(fmt, ...)					\
-	printk_once(KERN_CRIT pr_fmt(fmt), ##__VA_ARGS__)
-#define pr_err_once(fmt, ...)					\
-	printk_once(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
-#define pr_warn_once(fmt, ...)					\
-	printk_once(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
-#define pr_notice_once(fmt, ...)				\
-	printk_once(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
-#define pr_info_once(fmt, ...)					\
-	printk_once(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
-#define pr_cont_once(fmt, ...)					\
-	printk_once(KERN_CONT pr_fmt(fmt), ##__VA_ARGS__)
-#if defined(DEBUG)
-#define pr_debug_once(fmt, ...)					\
-	printk_once(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
-#else
-#define pr_debug_once(fmt, ...)					\
-	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
-#endif
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36)
-/* mask va_format as RHEL6 backports this */
-#define va_format LINUX_BACKPORT(va_format)
-
-struct va_format {
-	const char *fmt;
-	va_list *va;
-};
-
-/*
- * Dummy printk for disabled debugging statements to use whilst maintaining
- * gcc's format and side-effect checking.
- */
-/* mask no_printk as RHEL6 backports this */
-#define no_printk LINUX_BACKPORT(no_printk)
-static inline __attribute__ ((format (printf, 1, 2)))
-int no_printk(const char *s, ...) { return 0; }
-#endif
-
 #ifndef printk_ratelimited
 /*
  * ratelimited messages with local ratelimit_state,
diff --git a/backport/backport-include/linux/ptp_clock_kernel.h b/backport/backport-include/linux/ptp_clock_kernel.h
index ea7386f..869dfdc 100644
--- a/backport/backport-include/linux/ptp_clock_kernel.h
+++ b/backport/backport-include/linux/ptp_clock_kernel.h
@@ -2,7 +2,6 @@
 #define __BACKPORT_PTP_CLOCK_KERNEL_H
 
 #include <linux/version.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,0)
 #include_next <linux/ptp_clock_kernel.h>
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0)
@@ -38,6 +37,4 @@ extern int ptp_clock_index(struct ptp_clock *ptp);
 #define ptp_clock_register(info,parent) ptp_clock_register(info)
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0) */
 
-#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,0) */
-
 #endif /* __BACKPORT_PTP_CLOCK_KERNEL_H */
diff --git a/backport/backport-include/linux/rculist.h b/backport/backport-include/linux/rculist.h
index 73c47df..eb3bcfe 100644
--- a/backport/backport-include/linux/rculist.h
+++ b/backport/backport-include/linux/rculist.h
@@ -1,8 +1,6 @@
 #ifndef __BACKPORT_RCULIST_H
 #define __BACKPORT_RCULIST_H
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,26)
 #include_next <linux/rculist.h>
-#endif
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
 #include <backport/magic.h>
@@ -24,21 +22,6 @@
 	macro_dispatcher(hlist_for_each_entry_rcu, __VA_ARGS__)(__VA_ARGS__)
 #endif /* < 3.9 */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37)
-/**
- * backport:
- *
- * commit 67bdbffd696f29a0b68aa8daa285783a06651583
- * Author: Arnd Bergmann <arnd@arndb.de>
- * Date:   Thu Feb 25 16:55:13 2010 +0100
- *
- *     rculist: avoid __rcu annotations
- */
-#define hlist_first_rcu(head)	(*((struct hlist_node __rcu **)(&(head)->first)))
-#define hlist_next_rcu(node)	(*((struct hlist_node __rcu **)(&(node)->next)))
-
-#endif /* < 2.6.37 */
-
 #ifndef list_for_each_entry_continue_rcu
 #define list_for_each_entry_continue_rcu(pos, head, member) 		\
 	for (pos = list_entry_rcu(pos->member.next, typeof(*pos), member); \
diff --git a/backport/backport-include/linux/rfkill.h b/backport/backport-include/linux/rfkill.h
index 188a23b..44ff2e8 100644
--- a/backport/backport-include/linux/rfkill.h
+++ b/backport/backport-include/linux/rfkill.h
@@ -5,7 +5,6 @@
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
 #include_next <linux/rfkill.h>
 #else
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,33)
 /* API only slightly changed since then */
 #define rfkill_type old_rfkill_type
 #define RFKILL_TYPE_ALL OLD_RFKILL_TYPE_ALL
@@ -31,17 +30,6 @@
 #undef RFKILL_TYPE_NFC
 #undef NUM_RFKILL_TYPES
 #define HAVE_OLD_RFKILL
-#else
-#undef HAVE_OLD_RFKILL
-#include <linux/device.h>
-struct rfkill;
-
-struct rfkill_ops {
-	void	(*poll)(struct rfkill *rfkill, void *data);
-	void	(*query)(struct rfkill *rfkill, void *data);
-	int	(*set_block)(void *data, bool blocked);
-};
-#endif
 
 /* this changes infrequently, backport manually */
 enum rfkill_type {
diff --git a/backport/backport-include/linux/rtnetlink.h b/backport/backport-include/linux/rtnetlink.h
index 81540a3..6dea700 100644
--- a/backport/backport-include/linux/rtnetlink.h
+++ b/backport/backport-include/linux/rtnetlink.h
@@ -13,18 +13,4 @@
 				 lockdep_rtnl_is_held())
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,34)
-#ifdef CONFIG_PROVE_LOCKING
-/*
- * Obviously, this is wrong.  But the base kernel will have rtnl_mutex
- * declared static, with no way to access it.  I think this is the best
- * we can do...
- */
-static inline int lockdep_rtnl_is_held(void)
-{
-        return 1;
-}
-#endif /* #ifdef CONFIG_PROVE_LOCKING */
-#endif /* < 2.6.34 */
-
 #endif /* __BACKPORT_LINUX_RTNETLINK_H */
diff --git a/backport/backport-include/linux/semaphore.h b/backport/backport-include/linux/semaphore.h
deleted file mode 100644
index d242df4..0000000
--- a/backport/backport-include/linux/semaphore.h
+++ /dev/null
@@ -1,12 +0,0 @@
-#ifndef __BACKPORT_LINUX_SEMAPHORE_H
-#define __BACKPORT_LINUX_SEMAPHORE_H
-
-#include <linux/version.h>
-
-#if  LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,26)
-#include_next <linux/semaphore.h>
-#else
-#include <asm/semaphore.h>
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2,6,26) */
-
-#endif /* __BACKPORT_LINUX_SEMAPHORE_H */
diff --git a/backport/backport-include/linux/seq_file.h b/backport/backport-include/linux/seq_file.h
index 17f7b3d..21dce09 100644
--- a/backport/backport-include/linux/seq_file.h
+++ b/backport/backport-include/linux/seq_file.h
@@ -8,7 +8,6 @@
 #include <linux/file.h>
 #include <linux/fs.h>
 #ifdef CONFIG_USER_NS
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,38)
 static inline struct user_namespace *seq_user_ns(struct seq_file *seq)
 {
 	struct file *f = container_of((void *) seq, struct file, private_data);
@@ -18,27 +17,10 @@ static inline struct user_namespace *seq_user_ns(struct seq_file *seq)
 #else
 static inline struct user_namespace *seq_user_ns(struct seq_file *seq)
 {
-	return current_user_ns();
-}
-#endif /* (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,38)) */
-
-#else
-static inline struct user_namespace *seq_user_ns(struct seq_file *seq)
-{
 	extern struct user_namespace init_user_ns;
 	return &init_user_ns;
 }
 #endif /* CONFIG_USER_NS */
 #endif /* < 3.7 */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,34)
-#define seq_hlist_start_head LINUX_BACKPORT(seq_hlist_start_head)
-extern struct hlist_node *seq_hlist_start_head(struct hlist_head *head,
-					       loff_t pos);
-
-#define seq_hlist_next LINUX_BACKPORT(seq_hlist_next)
-extern struct hlist_node *seq_hlist_next(void *v, struct hlist_head *head,
-					 loff_t *ppos);
-#endif
-
 #endif /* __BACKPORT_SEQ_FILE_H */
diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index 2f7d57b..fae13b7 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -3,14 +3,7 @@
 #include_next <linux/skbuff.h>
 #include <linux/version.h>
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28))
-extern void v2_6_28_skb_add_rx_frag(struct sk_buff *skb, int i,
-				    struct page *page,
-				    int off, int size);
-
-#define skb_add_rx_frag(skb, i, page, off, size, truesize) \
-	v2_6_28_skb_add_rx_frag(skb, i, page, off, size)
-#elif (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)) && \
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)) && \
       (RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(6,4)) && \
       !(defined(CONFIG_SUSE_KERNEL) && (LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,0)))
 #define skb_add_rx_frag(skb, i, page, off, size, truesize) \
@@ -71,159 +64,11 @@ static inline struct sk_buff *__netdev_alloc_skb_ip_align(struct net_device *dev
 }
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,38)
-#define skb_checksum_start_offset LINUX_BACKPORT(skb_checksum_start_offset)
-static inline int skb_checksum_start_offset(const struct sk_buff *skb)
-{
-	return skb->csum_start - skb_headroom(skb);
-}
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37)
-#define skb_has_frag_list LINUX_BACKPORT(skb_has_frag_list)
-static inline bool skb_has_frag_list(const struct sk_buff *skb)
-{
-	return skb_shinfo(skb)->frag_list != NULL;
-}
-
-#define skb_checksum_none_assert LINUX_BACKPORT(skb_checksum_none_assert)
-
-static inline void skb_checksum_none_assert(struct sk_buff *skb)
-{
-#ifdef DEBUG
-	BUG_ON(skb->ip_summed != CHECKSUM_NONE);
-#endif
-}
-#endif /* < 2.6.37 */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36)
-static inline bool skb_defer_rx_timestamp(struct sk_buff *skb)
-{
-	return false;
-}
-
-#if (RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(6,4))
-static inline void skb_tx_timestamp(struct sk_buff *skb)
-{
-}
-#endif
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,33)
-/* mask netdev_alloc_skb_ip_align as debian squeeze also backports this */
-#define netdev_alloc_skb_ip_align LINUX_BACKPORT(netdev_alloc_skb_ip_align)
-
-static inline struct sk_buff *netdev_alloc_skb_ip_align(struct net_device *dev,
-                unsigned int length)
-{
-	struct sk_buff *skb = netdev_alloc_skb(dev, length + NET_IP_ALIGN);
-
-	if (NET_IP_ALIGN && skb)
-		skb_reserve(skb, NET_IP_ALIGN);
-	return skb;
-}
-#endif
-
 #ifndef skb_walk_frags
 #define skb_walk_frags(skb, iter)	\
 	for (iter = skb_shinfo(skb)->frag_list; iter; iter = iter->next)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,29)
-static inline bool skb_queue_is_first(const struct sk_buff_head *list,
-				      const struct sk_buff *skb)
-{
-	return (skb->prev == (struct sk_buff *) list);
-}
-
-static inline struct sk_buff *skb_queue_prev(const struct sk_buff_head *list,
-					     const struct sk_buff *skb)
-{
-	BUG_ON(skb_queue_is_first(list, skb));
-	return skb->prev;
-}
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28)
-static inline bool skb_queue_is_last(const struct sk_buff_head *list,
-				     const struct sk_buff *skb)
-{
-	return (skb->next == (struct sk_buff *) list);
-}
-
-static inline struct sk_buff *skb_queue_next(const struct sk_buff_head *list,
-                                             const struct sk_buff *skb)
-{
-	/* This BUG_ON may seem severe, but if we just return then we
-	 * are going to dereference garbage.
-	 */
-	BUG_ON(skb_queue_is_last(list, skb));
-	return skb->next;
-}
-
-static inline void __skb_queue_head_init(struct sk_buff_head *list)
-{
-	list->prev = list->next = (struct sk_buff *)list;
-	list->qlen = 0;
-}
-
-static inline void __skb_queue_splice(const struct sk_buff_head *list,
-				      struct sk_buff *prev,
-				      struct sk_buff *next)
-{
-	struct sk_buff *first = list->next;
-	struct sk_buff *last = list->prev;
-
-	first->prev = prev;
-	prev->next = first;
-
-	last->next = next;
-	next->prev = last;
-}
-
-static inline void skb_queue_splice(const struct sk_buff_head *list,
-				    struct sk_buff_head *head)
-{
-	if (!skb_queue_empty(list)) {
-		__skb_queue_splice(list, (struct sk_buff *) head, head->next);
-		head->qlen += list->qlen;
-	}
-}
-
-static inline void skb_queue_splice_init(struct sk_buff_head *list,
-					 struct sk_buff_head *head)
-{
-	if (!skb_queue_empty(list)) {
-		__skb_queue_splice(list, (struct sk_buff *) head, head->next);
-		head->qlen += list->qlen;
-		__skb_queue_head_init(list);
-	}
-}
-
-static inline void skb_queue_splice_tail_init(struct sk_buff_head *list,
-					      struct sk_buff_head *head)
-{
-	if (!skb_queue_empty(list)) {
-		__skb_queue_splice(list, head->prev, (struct sk_buff *) head);
-		head->qlen += list->qlen;
-		__skb_queue_head_init(list);
-	}
-}
-
-static inline void skb_queue_splice_tail(const struct sk_buff_head *list,
-					 struct sk_buff_head *head)
-{
-	if (!skb_queue_empty(list)) {
-		__skb_queue_splice(list, head->prev, (struct sk_buff *) head);
-		head->qlen += list->qlen;
-	}
-}
-
-#define skb_queue_walk_from(queue, skb)						\
-		for (; skb != (struct sk_buff *)(queue);			\
-		     skb = skb->next)
-#endif /* < 2.6.28 */
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0)
 #define skb_frag_size_sub LINUX_BACKPORT(skb_frag_size_sub)
 static inline void skb_frag_size_sub(skb_frag_t *frag, int delta)
@@ -245,7 +90,7 @@ static inline void *skb_frag_address(const skb_frag_t *frag)
 }
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0) */
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,0) && LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
 /**
  *	__skb_alloc_pages - allocate pages for ps-rx on a skb and preserve pfmemalloc data
  *	@gfp_mask: alloc_pages_node mask. Set __GFP_NOMEMALLOC if not for network packet RX
@@ -289,7 +134,7 @@ static inline struct page *__skb_alloc_page(gfp_t gfp_mask,
 {
 	return __skb_alloc_pages(gfp_mask, skb, 0);
 }
-#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,0) && LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0) */
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
 #ifndef NETDEV_FRAG_PAGE_MAX_ORDER
diff --git a/backport/backport-include/linux/static_key.h b/backport/backport-include/linux/static_key.h
index 0bbb61e..d301a75 100644
--- a/backport/backport-include/linux/static_key.h
+++ b/backport/backport-include/linux/static_key.h
@@ -44,143 +44,6 @@
  * find use for this we could just split the non optimized versions upstream
  * and copy that through an automatic process.
  */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37)
-/*
- * For kernels older than 2.6.37 we just take on the
- * implementation in the kernel that assumes you have
- * either no toolchain or architecture kernel support
- * for the jump labels. Daring folks who wish to embark
- * on a nutty journey may wish to see if they can backport
- * architectural specific changes here.
- *
- * Jump label support was added via commit
- * bf5438fca2950b03c21ad868090cc1a8fcd49536 through kernel
- * v2.6.37-rc1~214^2~33^2~8
- */
-
-/*
- * Jump label support
- *
- * Copyright (C) 2009-2012 Jason Baron <jbaron@redhat.com>
- * Copyright (C) 2011-2012 Peter Zijlstra <pzijlstr@redhat.com>
- *
- * Jump labels provide an interface to generate dynamic branches using
- * self-modifying code. Assuming toolchain and architecture support the result
- * of a "if (static_key_false(&key))" statement is a unconditional branch (which
- * defaults to false - and the true block is placed out of line).
- *
- * However at runtime we can change the branch target using
- * static_key_slow_{inc,dec}(). These function as a 'reference' count on the key
- * object and for as long as there are references all branches referring to
- * that particular key will point to the (out of line) true block.
- *
- * Since this relies on modifying code the static_key_slow_{inc,dec}() functions
- * must be considered absolute slow paths (machine wide synchronization etc.).
- * OTOH, since the affected branches are unconditional their runtime overhead
- * will be absolutely minimal, esp. in the default (off) case where the total
- * effect is a single NOP of appropriate size. The on case will patch in a jump
- * to the out-of-line block.
- *
- * When the control is directly exposed to userspace it is prudent to delay the
- * decrement to avoid high frequency code modifications which can (and do)
- * cause significant performance degradation. Struct static_key_deferred and
- * static_key_slow_dec_deferred() provide for this.
- *
- * Lacking toolchain and or architecture support, it falls back to a simple
- * conditional branch.
- *
- * struct static_key my_key = STATIC_KEY_INIT_TRUE;
- *
- *   if (static_key_true(&my_key)) {
- *   }
- *
- * will result in the true case being in-line and starts the key with a single
- * reference. Mixing static_key_true() and static_key_false() on the same key is not
- * allowed.
- *
- * Not initializing the key (static data is initialized to 0s anyway) is the
- * same as using STATIC_KEY_INIT_FALSE.
- *
-*/
-
-#include <linux/types.h>
-#include <linux/compiler.h>
-#include <linux/bug.h>
-
-/*
- * For the backport we leave out static_key_initialized as
- * no architecture code is provided to support jump labels, so
- * we treat jump labels as simply atomic values which drive
- * branches. Since we don't backport static_key_initialized
- * we leave out all STATIC_KEY_CHECK_USE() uses.
- */
-
-enum jump_label_type {
-	JUMP_LABEL_DISABLE = 0,
-	JUMP_LABEL_ENABLE,
-};
-
-struct module;
-
-#include <linux/atomic.h>
-
-struct static_key {
-	atomic_t enabled;
-};
-
-static __always_inline bool static_key_false(struct static_key *key)
-{
-	if (unlikely(atomic_read(&key->enabled) > 0))
-		return true;
-	return false;
-}
-
-static __always_inline bool static_key_true(struct static_key *key)
-{
-	if (likely(atomic_read(&key->enabled) > 0))
-		return true;
-	return false;
-}
-
-static inline void static_key_slow_inc(struct static_key *key)
-{
-	atomic_inc(&key->enabled);
-}
-
-static inline void static_key_slow_dec(struct static_key *key)
-{
-	atomic_dec(&key->enabled);
-}
-
-static inline int jump_label_text_reserved(void *start, void *end)
-{
-	return 0;
-}
-
-static inline void jump_label_lock(void) {}
-static inline void jump_label_unlock(void) {}
-
-static inline int jump_label_apply_nops(struct module *mod)
-{
-	return 0;
-}
-
-#define STATIC_KEY_INIT_TRUE ((struct static_key) \
-		{ .enabled = ATOMIC_INIT(1) })
-#define STATIC_KEY_INIT_FALSE ((struct static_key) \
-		{ .enabled = ATOMIC_INIT(0) })
-
-
-#define STATIC_KEY_INIT STATIC_KEY_INIT_FALSE
-#define jump_label_enabled static_key_enabled
-
-static inline bool static_key_enabled(struct static_key *key)
-{
-	return (atomic_read(&key->enabled) > 0);
-}
-
-#endif /* kernels older than 2.6.37  */
 #endif /* kernels < 3.3 */
 
 #endif /* _BACKPORTS_LINUX_STATIC_KEY_H */
diff --git a/backport/backport-include/linux/string.h b/backport/backport-include/linux/string.h
index f9f1750..819d141 100644
--- a/backport/backport-include/linux/string.h
+++ b/backport/backport-include/linux/string.h
@@ -8,9 +8,4 @@
 extern size_t memweight(const void *ptr, size_t bytes);
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,0,0)
-#define strtobool LINUX_BACKPORT(strtobool)
-extern int strtobool(const char *s, bool *res);
-#endif
-
 #endif /* __BACKPORT_LINUX_STRING_H */
diff --git a/backport/backport-include/linux/sysfs.h b/backport/backport-include/linux/sysfs.h
index 13bab43..0b71db5 100644
--- a/backport/backport-include/linux/sysfs.h
+++ b/backport/backport-include/linux/sysfs.h
@@ -3,34 +3,6 @@
 #include_next <linux/sysfs.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,34)
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-#define sysfs_attr_init(attr)				\
-do {							\
-	static struct lock_class_key __key;		\
-							\
-	(attr)->key = &__key;				\
-} while(0)
-#else
-#define sysfs_attr_init(attr) do {} while(0)
-#endif
-
-/* mask sysfs_bin_attr_init as RHEL6 backports this */
-#if !defined(sysfs_bin_attr_init)
-/**
- *	sysfs_bin_attr_init - initialize a dynamically allocated bin_attribute
- *	@attr: struct bin_attribute to initialize
- *
- *	Initialize a dynamically allocated struct bin_attribute so we
- *	can make lockdep happy.  This is a new requirement for
- *	attributes and initially this is only needed when lockdep is
- *	enabled.  Lockdep gives a nice error when your attribute is
- *	added to sysfs if you don't have this.
- */
-#define sysfs_bin_attr_init(bin_attr) sysfs_attr_init(&(bin_attr)->attr)
-#endif
-#endif
-
 #ifndef __ATTR_RW
 #define __ATTR_RW(_name) __ATTR(_name, (S_IWUSR | S_IRUGO),		\
 			 _name##_show, _name##_store)
diff --git a/backport/backport-include/linux/time.h b/backport/backport-include/linux/time.h
deleted file mode 100644
index efda485..0000000
--- a/backport/backport-include/linux/time.h
+++ /dev/null
@@ -1,31 +0,0 @@
-#ifndef __BACKPORT_LINUX_TIME_H
-#define __BACKPORT_LINUX_TIME_H
-#include_next <linux/time.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28)
-#define getrawmonotonic(ts) do_posix_clock_monotonic_gettime(ts)
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
-/*
- * Similar to the struct tm in userspace <time.h>, but it needs to be here so
- * that the kernel source is self contained.
- */
-struct tm {
-	int tm_sec;
-	int tm_min;
-	int tm_hour;
-	int tm_mday;
-	int tm_mon;
-	long tm_year;
-	int tm_wday;
-	int tm_yday;
-};
-
-#define time_to_tm LINUX_BACKPORT(time_to_tm)
-void time_to_tm(time_t totalsecs, int offset, struct tm *result);
-
-#endif /* < 2.6.32 */
-
-#endif /* __BACKPORT_LINUX_TIME_H */
diff --git a/backport/backport-include/linux/timer.h b/backport/backport-include/linux/timer.h
deleted file mode 100644
index 2720584..0000000
--- a/backport/backport-include/linux/timer.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef __BACKPORT_LINUX_TIMER_H
-#define __BACKPORT_LINUX_TIMER_H
-#include_next <linux/timer.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28)
-#define round_jiffies_up LINUX_BACKPORT(round_jiffies_up)
-unsigned long round_jiffies_up(unsigned long j);
-#endif
-
-#endif /* __BACKPORT_LINUX_TIMER_H */
diff --git a/backport/backport-include/linux/tracepoint.h b/backport/backport-include/linux/tracepoint.h
deleted file mode 100644
index 0ed65b7..0000000
--- a/backport/backport-include/linux/tracepoint.h
+++ /dev/null
@@ -1,53 +0,0 @@
-#ifndef _COMPAT_LINUX_TRACEPOINT_H
-#define _COMPAT_LINUX_TRACEPOINT_H 1
-
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,32))
-/*
- * Disable all tracing for older kernels
- * < 2.6.27		had no tracing
- * 2.6.27		had broken tracing
- * 2.6.28-2.6.32	didn't have anything like DECLARE_EVENT_CLASS
- *			and faking it would be extremely difficult
- * 2.6.37		moved to using jump labels
- * 3.0			static branch optimiziations through d430d3d7e
- * 3.3			Ingo splits up static key from jump labels,
- *                      Note that git sees this as in v3.5 though!
- * 3.5                  We can start relying on the static_key.h file
- * 3.13			static_key_initialized() STATIC_KEY_CHECK_USE()
- * 			added via commit c4b2c0c5f
- */
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,28))
-/*
- * For 2.6.28+ include the original tracepoint.h (for kernel header
- * files that require it to work) but override the defines the code
- * uses to disable tracing completely.
- */
-#include_next <linux/tracepoint.h>
-#endif
-
-#undef CREATE_TRACE_POINTS
-
-#undef TRACE_EVENT
-#define TRACE_EVENT(name, proto, ...) \
-static inline void trace_ ## name(proto) {}
-#undef DECLARE_EVENT_CLASS
-#define DECLARE_EVENT_CLASS(...)
-#undef DEFINE_EVENT
-#define DEFINE_EVENT(evt_class, name, proto, ...) \
-static inline void trace_ ## name(proto) {}
-#undef EXPORT_TRACEPOINT_SYMBOL
-#define EXPORT_TRACEPOINT_SYMBOL(...)
-
-#define TP_PROTO(args...)	args
-#define TP_ARGS(args...)	args
-#define TP_CONDITION(args...)	args
-
-#else
-/* since 2.6.33, tracing hasn't changed, so just include the kernel's file */
-#include_next <linux/tracepoint.h>
-
-#endif /* (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,32)) */
-
-#endif	/* _COMPAT_LINUX_TRACEPOINT_H */
diff --git a/backport/backport-include/linux/tty.h b/backport/backport-include/linux/tty.h
index 2f79ac5..758c549 100644
--- a/backport/backport-include/linux/tty.h
+++ b/backport/backport-include/linux/tty.h
@@ -2,12 +2,6 @@
 #define __BACKPORT_LINUX_TTY_H
 #include_next <linux/tty.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39) && \
-    LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,27)
-#define tty_set_termios LINUX_BACKPORT(tty_set_termios)
-extern int tty_set_termios(struct tty_struct *tty, struct ktermios *kt);
-#endif
-
 /*
  * This really belongs into uapi/asm-generic/termbits.h but
  * that doesn't usually get included directly.
@@ -16,29 +10,6 @@ extern int tty_set_termios(struct tty_struct *tty, struct ktermios *kt);
 #define EXTPROC	0200000
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36)
-#include <linux/smp_lock.h>
-static inline void tty_lock(void) __acquires(kernel_lock)
-{
-#ifdef CONFIG_LOCK_KERNEL
-	/* kernel_locked is 1 for !CONFIG_LOCK_KERNEL */
-	WARN_ON(kernel_locked());
-#endif
-	lock_kernel();
-}
-static inline void tty_unlock(void) __releases(kernel_lock)
-{
-	unlock_kernel();
-}
-#define tty_locked()           (kernel_locked())
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28)
-#define n_tty_ioctl_helper LINUX_BACKPORT(n_tty_ioctl_helper)
-extern int n_tty_ioctl_helper(struct tty_struct *tty, struct file *file,
-		       unsigned int cmd, unsigned long arg);
-#endif
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
 /* Backports tty_lock: Localise the lock */
 #define tty_lock(__tty) tty_lock()
@@ -48,9 +19,9 @@ extern int n_tty_ioctl_helper(struct tty_struct *tty, struct file *file,
 	tty_register_device(driver, index, device)
 #endif
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)) && (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,28))
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
 extern void tty_port_tty_wakeup(struct tty_port *port);
 extern void tty_port_tty_hangup(struct tty_port *port, bool check_clocal);
-#endif
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0) */
 
 #endif /* __BACKPORT_LINUX_TTY_H */
diff --git a/backport/backport-include/linux/types.h b/backport/backport-include/linux/types.h
deleted file mode 100644
index ec7fe7d..0000000
--- a/backport/backport-include/linux/types.h
+++ /dev/null
@@ -1,51 +0,0 @@
-#ifndef __BACKPORT_TYPES_H
-#define __BACKPORT_TYPES_H
-#include_next <linux/types.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28)
-
-#if defined(CONFIG_X86) || defined(CONFIG_X86_64) || defined(CONFIG_PPC)
-/*
- * CONFIG_PHYS_ADDR_T_64BIT was added as new to all architectures
- * as of 2.6.28 but x86 and ppc had it already.
- */
-#else
-#if defined(CONFIG_64BIT) || defined(CONFIG_X86_PAE) || defined(CONFIG_PPC64) || defined(CONFIG_PHYS_64BIT)
-#define CONFIG_PHYS_ADDR_T_64BIT 1
-typedef u64 phys_addr_t;
-#else
-typedef u32 phys_addr_t;
-#endif
-
-#endif /* non x86 and ppc */
-
-#endif /* < 2.6.28 */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,29) && \
-	(defined(CONFIG_ALPHA) || defined(CONFIG_AVR32) || \
-	 defined(CONFIG_BLACKFIN) || defined(CONFIG_CRIS) || \
-	 defined(CONFIG_H8300) || defined(CONFIG_IA64) || \
-	 defined(CONFIG_M68K) ||  defined(CONFIG_MIPS) || \
-	 defined(CONFIG_PARISC) || defined(CONFIG_S390) || \
-	 defined(CONFIG_PPC64) || defined(CONFIG_PPC32) || \
-	 defined(CONFIG_SUPERH) || defined(CONFIG_SPARC) || \
-	 defined(CONFIG_FRV) || defined(CONFIG_X86) || \
-	 defined(CONFIG_M32R) || defined(CONFIG_M68K) || \
-	 defined(CONFIG_MN10300) || defined(CONFIG_XTENSA) || \
-	 defined(CONFIG_ARM))
-#include <asm/atomic.h>
-#elif LINUX_VERSION_CODE < KERNEL_VERSION(2,6,29)
-typedef struct {
-	volatile int counter;
-} atomic_t;
-
-#ifdef CONFIG_64BIT
-typedef struct {
-	volatile long counter;
-} atomic64_t;
-#endif /* CONFIG_64BIT */
-
-#endif
-
-#endif /* __BACKPORT_TYPES_H */
diff --git a/backport/backport-include/linux/usb.h b/backport/backport-include/linux/usb.h
index a0cfa37..4acbce5 100644
--- a/backport/backport-include/linux/usb.h
+++ b/backport/backport-include/linux/usb.h
@@ -71,96 +71,11 @@
 	.bInterfaceClass = (cl)
 #endif /* USB_DEVICE_INTERFACE_CLASS */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36)
-#ifdef CPTCFG_BACKPORT_OPTION_USB_URB_THREAD_FIX
-#define usb_scuttle_anchored_urbs LINUX_BACKPORT(usb_scuttle_anchored_urbs)
-#define usb_get_from_anchor LINUX_BACKPORT(usb_get_from_anchor)
-
-extern struct urb *usb_get_from_anchor(struct usb_anchor *anchor);
-extern void usb_scuttle_anchored_urbs(struct usb_anchor *anchor);
-#endif
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35)
-/* mask usb_pipe_endpoint as RHEL6 backports this */
-#define usb_pipe_endpoint LINUX_BACKPORT(usb_pipe_endpoint)
-
-static inline struct usb_host_endpoint *
-usb_pipe_endpoint(struct usb_device *dev, unsigned int pipe)
-{
-	struct usb_host_endpoint **eps;
-	eps = usb_pipein(pipe) ? dev->ep_in : dev->ep_out;
-	return eps[usb_pipeendpoint(pipe)];
-}
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,34)
-#define usb_alloc_coherent(dev, size, mem_flags, dma) usb_buffer_alloc(dev, size, mem_flags, dma)
-#define usb_free_coherent(dev, size, addr, dma) usb_buffer_free(dev, size, addr, dma)
-
-/* USB autosuspend and autoresume */
-static inline int usb_enable_autosuspend(struct usb_device *udev)
-{ return 0; }
-static inline int usb_disable_autosuspend(struct usb_device *udev)
-{ return 0; }
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,33)
-#define usb_autopm_get_interface_no_resume LINUX_BACKPORT(usb_autopm_get_interface_no_resume)
-#define usb_autopm_put_interface_no_suspend LINUX_BACKPORT(usb_autopm_put_interface_no_suspend)
-#ifdef CONFIG_USB_SUSPEND
-extern void usb_autopm_get_interface_no_resume(struct usb_interface *intf);
-extern void usb_autopm_put_interface_no_suspend(struct usb_interface *intf);
-#else
-static inline void usb_autopm_get_interface_no_resume(struct usb_interface *intf)
-{
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32))
-	atomic_inc(&intf->pm_usage_cnt);
-#else
-	intf->pm_usage_cnt++;
-#endif
-}
-static inline void usb_autopm_put_interface_no_suspend(struct usb_interface *intf)
-{
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32))
-	atomic_dec(&intf->pm_usage_cnt);
-#else
-	intf->pm_usage_cnt--;
-#endif
-}
-#endif /* CONFIG_USB_SUSPEND */
-#endif /* < 2.6.33 */
-
 #ifndef USB_SUBCLASS_VENDOR_SPEC
 /* this is defined in usb/ch9.h, but we only need it through here */
 #define USB_SUBCLASS_VENDOR_SPEC	0xff
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,29)
-static inline void usb_autopm_put_interface_async(struct usb_interface *intf)
-{ }
-static inline int usb_autopm_get_interface_async(struct usb_interface *intf)
-{ return 0; }
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,29) && \
-    LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,23)
-#if defined(CONFIG_USB) || defined(CONFIG_USB_MODULE)
-#define usb_unpoison_anchored_urbs LINUX_BACKPORT(usb_unpoison_anchored_urbs)
-extern void usb_unpoison_anchored_urbs(struct usb_anchor *anchor);
-#endif /* CONFIG_USB */
-#endif /* 2.6.23 - 2.6.28 */
-
-/* USB anchors were added as of 2.6.23 */
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28) && \
-    LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,23)
-#define usb_unpoison_urb LINUX_BACKPORT(usb_unpoison_urb)
-extern void usb_unpoison_urb(struct urb *urb);
-
-#define usb_anchor_empty LINUX_BACKPORT(usb_anchor_empty)
-extern int usb_anchor_empty(struct usb_anchor *anchor);
-#endif /* 2.6.23-2.6.27 */
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0)
 #define usb_translate_errors LINUX_BACKPORT(usb_translate_errors)
 static inline int usb_translate_errors(int error_code)
@@ -175,6 +90,6 @@ static inline int usb_translate_errors(int error_code)
 		return -EIO;
 	}
 }
-#endif /* < 2.6.39 */
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0) */
 
 #endif /* __BACKPORT_USB_H */
diff --git a/backport/backport-include/linux/usb/ch9.h b/backport/backport-include/linux/usb/ch9.h
index 33c5959..135e24c 100644
--- a/backport/backport-include/linux/usb/ch9.h
+++ b/backport/backport-include/linux/usb/ch9.h
@@ -2,29 +2,7 @@
 #define __BACKPORT__LINUX_USB_CH9_H
 
 #include <linux/version.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
-#define usb_device_speed old_usb_device_speed
-#define USB_SPEED_UNKNOWN OLD_USB_SPEED_UNKNOWN
-#define USB_SPEED_LOW OLD_USB_SPEED_LOW
-#define USB_SPEED_FULL OLD_USB_SPEED_FULL
-#define USB_SPEED_HIGH OLD_USB_SPEED_HIGH
-#include_next <linux/usb/ch9.h>
-#undef usb_device_speed
-#undef USB_SPEED_UNKNOWN
-#undef USB_SPEED_LOW
-#undef USB_SPEED_FULL
-#undef USB_SPEED_HIGH
-enum usb_device_speed {
-	USB_SPEED_UNKNOWN = 0,          /* enumerating */
-	USB_SPEED_LOW, USB_SPEED_FULL,      /* usb 1.1 */
-	USB_SPEED_HIGH,             /* usb 2.0 */
-	USB_SPEED_WIRELESS,         /* wireless (usb 2.5) */
-	USB_SPEED_SUPER,            /* usb 3.0 */
-};
-#else
 #include_next <linux/usb/ch9.h>
-#endif /* < 2.6.30 */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0)
 #include <linux/types.h>    /* __u8 etc */
diff --git a/backport/backport-include/linux/vmalloc.h b/backport/backport-include/linux/vmalloc.h
deleted file mode 100644
index c47536f..0000000
--- a/backport/backport-include/linux/vmalloc.h
+++ /dev/null
@@ -1,11 +0,0 @@
-#ifndef __BACKPORT_LINUX_VMALLOC_H
-#define __BACKPORT_LINUX_VMALLOC_H
-#include_next <linux/vmalloc.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37)
-#define vzalloc LINUX_BACKPORT(vzalloc)
-extern void *vzalloc(unsigned long size);
-#endif
-
-#endif /* __BACKPORT_LINUX_VMALLOC_H */
diff --git a/backport/backport-include/linux/wait.h b/backport/backport-include/linux/wait.h
deleted file mode 100644
index 664f24b..0000000
--- a/backport/backport-include/linux/wait.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef __BACKPORT_LINUX_WAIT_H
-#define __BACKPORT_LINUX_WAIT_H
-#include_next <linux/wait.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28)
-#define wake_up_interruptible_poll(x, m)			\
-	__wake_up(x, TASK_INTERRUPTIBLE, 1, (void *) (m))
-#endif
-
-#endif /* __BACKPORT_LINUX_WAIT_H */
diff --git a/backport/backport-include/linux/watchdog.h b/backport/backport-include/linux/watchdog.h
index 49f6669..380762c 100644
--- a/backport/backport-include/linux/watchdog.h
+++ b/backport/backport-include/linux/watchdog.h
@@ -2,12 +2,10 @@
 #define __BACKPORT_WATCHDOG_H
 #include_next <linux/watchdog.h>
 
-#if (RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(6,4))
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)
 #define watchdog_device LINUX_BACKPORT(watchdog_device)
 struct watchdog_device {
 };
 #endif
-#endif
 
 #endif /* __BACKPORT_WATCHDOG_H */
diff --git a/backport/backport-include/linux/workqueue.h b/backport/backport-include/linux/workqueue.h
index 63a3b17..ec5c230 100644
--- a/backport/backport-include/linux/workqueue.h
+++ b/backport/backport-include/linux/workqueue.h
@@ -14,15 +14,7 @@ bool mod_delayed_work(struct workqueue_struct *wq, struct delayed_work *dwork,
 #define create_freezable_workqueue create_freezeable_workqueue
 #endif
 
-#if LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,36)
-#define WQ_HIGHPRI 0
-#define WQ_MEM_RECLAIM 0
-#endif
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36)
-#define WQ_UNBOUND	0
-#endif
 #define __WQ_ORDERED	0
 /*
  * commit b196be89cdc14a88cc637cdad845a75c5886c82d
@@ -62,61 +54,6 @@ backport_alloc_workqueue(const char *fmt, unsigned int flags,
 void backport_destroy_workqueue(struct workqueue_struct *wq);
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36)
-#define system_wq LINUX_BACKPORT(system_wq)
-extern struct workqueue_struct *system_wq;
-#define system_long_wq LINUX_BACKPORT(system_long_wq)
-extern struct workqueue_struct *system_long_wq;
-#define system_nrt_wq LINUX_BACKPORT(system_nrt_wq)
-extern struct workqueue_struct *system_nrt_wq;
-
-void backport_system_workqueue_create(void);
-void backport_system_workqueue_destroy(void);
-
-#define schedule_work LINUX_BACKPORT(schedule_work)
-int schedule_work(struct work_struct *work);
-#define schedule_delayed_work LINUX_BACKPORT(schedule_delayed_work)
-int schedule_delayed_work(struct delayed_work *dwork,
-			  unsigned long delay);
-#define flush_scheduled_work LINUX_BACKPORT(flush_scheduled_work)
-void flush_scheduled_work(void);
-
-#else
-
-static inline void backport_system_workqueue_create(void)
-{
-}
-
-static inline void backport_system_workqueue_destroy(void)
-{
-}
-#endif /* < 2.6.36 */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27)
-/* I can't find a more suitable replacement... */
-#define flush_work(work) cancel_work_sync(work)
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
-static inline void flush_delayed_work(struct delayed_work *dwork)
-{
-	if (del_timer_sync(&dwork->timer)) {
-		/*
-		 * This is what would happen on 2.6.32 but since we don't have
-		 * access to the singlethread_cpu we can't really backport this,
-		 * so avoid really *flush*ing the work... Oh well. Any better ideas?
-
-		struct cpu_workqueue_struct *cwq;
-		cwq = wq_per_cpu(keventd_wq, get_cpu());
-		__queue_work(cwq, &dwork->work);
-		put_cpu();
-
-		*/
-	}
-	flush_work(&dwork->work);
-}
-#endif
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)
 /* power efficient workqueues were added in commit 0668106ca386. */
 #define system_power_efficient_wq system_wq
diff --git a/backport/backport-include/net/codel.h b/backport/backport-include/net/codel.h
index eee0359..0a89d14 100644
--- a/backport/backport-include/net/codel.h
+++ b/backport/backport-include/net/codel.h
@@ -92,11 +92,7 @@ struct codel_skb_cb {
 static struct codel_skb_cb *get_codel_cb(const struct sk_buff *skb)
 {
 	qdisc_cb_private_validate(skb, sizeof(struct codel_skb_cb));
-#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,37))
-	return (struct codel_skb_cb *)qdisc_skb_cb((struct sk_buff *) skb)->data;
-#else
 	return (struct codel_skb_cb *)qdisc_skb_cb(skb)->data;
-#endif
 }
 
 static codel_time_t codel_get_enqueue_time(const struct sk_buff *skb)
@@ -230,19 +226,10 @@ static bool codel_should_drop(const struct sk_buff *skb,
 	}
 
 	vars->ldelay = now - codel_get_enqueue_time(skb);
-#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,37))
-	sch->qstats.backlog -= qdisc_pkt_len((struct sk_buff *)skb);
-#else
 	sch->qstats.backlog -= qdisc_pkt_len(skb);
-#endif
 
-#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,37))
-	if (unlikely(qdisc_pkt_len((struct sk_buff *)skb) > stats->maxpacket))
-		stats->maxpacket = qdisc_pkt_len((struct sk_buff *)skb);
-#else
 	if (unlikely(qdisc_pkt_len(skb) > stats->maxpacket))
 		stats->maxpacket = qdisc_pkt_len(skb);
-#endif
 
 	if (codel_time_before(vars->ldelay, params->target) ||
 	    sch->qstats.backlog <= stats->maxpacket) {
diff --git a/backport/backport-include/net/dst.h b/backport/backport-include/net/dst.h
deleted file mode 100644
index e4e3d8f..0000000
--- a/backport/backport-include/net/dst.h
+++ /dev/null
@@ -1,35 +0,0 @@
-#ifndef __BACKPORT_NET_DST_H
-#define __BACKPORT_NET_DST_H
-#include_next <net/dst.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
-/*
- * Added via adf30907d63893e4208dfe3f5c88ae12bc2f25d5
- *
- * There is no _sk_dst on older kernels, so just set the
- * old dst to NULL and release it directly.
- */
-static inline void skb_dst_drop(struct sk_buff *skb)
-{
-	dst_release(skb->dst);
-	skb->dst = NULL;
-}
-
-static inline struct dst_entry *skb_dst(const struct sk_buff *skb)
-{
-	return (struct dst_entry *)skb->dst;
-}
-
-static inline void skb_dst_set(struct sk_buff *skb, struct dst_entry *dst)
-{
-	skb->dst = dst;
-}
-
-static inline struct rtable *skb_rtable(const struct sk_buff *skb)
-{
-	return (struct rtable *)skb_dst(skb);
-}
-#endif
-
-#endif /* __BACKPORT_NET_DST_H */
diff --git a/backport/backport-include/net/genetlink.h b/backport/backport-include/net/genetlink.h
index d1ae143..fc7eff4 100644
--- a/backport/backport-include/net/genetlink.h
+++ b/backport/backport-include/net/genetlink.h
@@ -13,56 +13,6 @@
 #define GENLMSG_DEFAULT_SIZE (NLMSG_DEFAULT_SIZE - GENL_HDRLEN)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37)
-struct backport_genl_info {
-	struct genl_info *info;
-
-	u32 snd_seq;
-	u32 snd_pid;
-	struct genlmsghdr *genlhdr;
-	struct nlattr **attrs;
-	void *user_ptr[2];
-};
-#define genl_info LINUX_BACKPORT(genl_info)
-
-/* if info gets overridden, so will family below */
-#define genlmsg_put_reply(_skb, _info, _fam, _flags, _cmd)		\
-	genlmsg_put_reply(_skb, (_info)->info, &(_fam)->family, _flags, _cmd)
-
-struct backport_genl_ops {
-	struct genl_ops ops;
-
-	u8 cmd;
-	u8 internal_flags;
-	unsigned int flags;
-	const struct nla_policy *policy;
-
-	int (*doit)(struct sk_buff *skb, struct genl_info *info);
-	int (*dumpit)(struct sk_buff *skb, struct netlink_callback *cb);
-	int (*done)(struct netlink_callback *cb);
-};
-#define genl_ops LINUX_BACKPORT(genl_ops)
-
-#define genlmsg_reply(_msg, _info) genlmsg_reply(_msg, (_info)->info)
-
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32))
-#define genl_info_net(_info) genl_info_net((_info)->info)
-#endif
-#endif /* 2.6.37 */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
-/*
- * struct genl_multicast_group was made netns aware through
- * patch "genetlink: make netns aware" by johannes, we just
- * force this to always use the default init_net
- */
-#define genl_info_net(x) &init_net
-/* Just use init_net for older kernels */
-#define get_net_ns_by_pid(x) &init_net
-/* net namespace is lost */
-#define genlmsg_unicast(net, skb, pid) genlmsg_unicast(skb, pid)
-#endif
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)
 #define genl_dump_check_consistent(cb, user_hdr, family)
 #endif
@@ -77,10 +27,6 @@ static inline int __real_genl_register_family(struct genl_family *family)
 struct backport_genl_family {
 	struct genl_family family;
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37)
-	struct list_head list;
-#endif
-
 	unsigned int id, hdrsize, version, maxattr;
 	char name[GENL_NAMSIZ];
 	bool netnsok;
@@ -164,11 +110,7 @@ static inline int genlmsg_multicast_netns(struct genl_family *family,
 		return -EINVAL;
 	group = family->mcgrps[group].id;
 	return nlmsg_multicast(
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
-		genl_sock,
-#else
 		net->genl_sock,
-#endif
 		skb, portid, group, flags);
 }
 #define genlmsg_multicast LINUX_BACKPORT(genlmsg_multicast)
@@ -180,11 +122,7 @@ static inline int genlmsg_multicast(struct genl_family *family,
 		return -EINVAL;
 	group = family->mcgrps[group].id;
 	return nlmsg_multicast(
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
-		genl_sock,
-#else
 		init_net.genl_sock,
-#endif
 		skb, portid, group, flags);
 }
 static inline int
@@ -195,11 +133,7 @@ backport_genlmsg_multicast_allns(struct genl_family *family,
 	if (WARN_ON_ONCE(group >= family->n_mcgrps))
 		return -EINVAL;
 	group = family->mcgrps[group].id;
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
-	return nlmsg_multicast(genl_sock, skb, portid, group, flags);
-#else
 	return genlmsg_multicast_allns(skb, portid, group, flags);
-#endif
 }
 #define genlmsg_multicast_allns LINUX_BACKPORT(genlmsg_multicast_allns)
 
diff --git a/backport/backport-include/net/ipv6.h b/backport/backport-include/net/ipv6.h
index 51f55b4..9da13eb 100644
--- a/backport/backport-include/net/ipv6.h
+++ b/backport/backport-include/net/ipv6.h
@@ -23,7 +23,7 @@ struct frag_queue {
 };
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0) */
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)) && (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,25))
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
 #define ipv6_addr_hash LINUX_BACKPORT(ipv6_addr_hash)
 static inline u32 ipv6_addr_hash(const struct in6_addr *a)
 {
diff --git a/backport/backport-include/net/iw_handler.h b/backport/backport-include/net/iw_handler.h
deleted file mode 100644
index c418d7d..0000000
--- a/backport/backport-include/net/iw_handler.h
+++ /dev/null
@@ -1,27 +0,0 @@
-#ifndef __BACKPORT_NET_IW_HANDLER_H
-#define __BACKPORT_NET_IW_HANDLER_H
-#include_next <net/iw_handler.h>
-#include <linux/version.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
-#define wireless_send_event(a, b, c, d) wireless_send_event(a, b, c, (char * ) d)
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27)
-#define iwe_stream_add_value(info, event, value, ends, iwe, event_len) iwe_stream_add_value(event, value, ends, iwe, event_len)
-#define iwe_stream_add_point(info, stream, ends, iwe, extra) iwe_stream_add_point(stream, ends, iwe, extra)
-#define iwe_stream_add_event(info, stream, ends, iwe, event_len) iwe_stream_add_event(stream, ends, iwe, event_len)
-
-#define IW_REQUEST_FLAG_COMPAT	0x0001	/* Compat ioctl call */
-
-static inline int iwe_stream_lcp_len(struct iw_request_info *info)
-{
-#ifdef CONFIG_COMPAT
-	if (info->flags & IW_REQUEST_FLAG_COMPAT)
-		return IW_EV_COMPAT_LCP_LEN;
-#endif
-	return IW_EV_LCP_LEN;
-}
-#endif
-
-#endif /* __BACKPORT_NET_IW_HANDLER_H */
diff --git a/backport/backport-include/net/net_namespace.h b/backport/backport-include/net/net_namespace.h
index efad88e..3ea5d46 100644
--- a/backport/backport-include/net/net_namespace.h
+++ b/backport/backport-include/net/net_namespace.h
@@ -5,59 +5,6 @@
 #include <net/netns/ieee802154_6lowpan.h>
 #include_next <net/net_namespace.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,29)
-#ifdef CONFIG_NET_NS
-static inline void write_pnet(struct net **pnet, struct net *net)
-{
-	*pnet = net;
-}
-
-static inline struct net *read_pnet(struct net * const *pnet)
-{
-	return *pnet;
-}
-
-#else
-#define write_pnet(pnet, net)	do { (void)(net);} while (0)
-#define read_pnet(pnet)		(&init_net)
-#endif
-#endif /* < 2.6.29 */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,26)
-#ifdef CONFIG_NET_NS
-static inline
-int net_eq(const struct net *net1, const struct net *net2)
-{
-	return net1 == net2;
-}
-#else
-static inline
-int net_eq(const struct net *net1, const struct net *net2)
-{
-	return 1;
-}
-#endif
-
-static inline
-void dev_net_set(struct net_device *dev, struct net *net)
-{
-#ifdef CONFIG_NET_NS
-	release_net(dev->nd_net);
-	dev->nd_net = hold_net(net);
-#endif
-}
-
-static inline
-struct net *sock_net(const struct sock *sk)
-{
-#ifdef CONFIG_NET_NS
-	return sk->sk_net;
-#else
-	return &init_net;
-#endif
-}
-#endif /* < 2.6.26 */
-
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0))
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
 /*
@@ -67,13 +14,13 @@ struct net *sock_net(const struct sock *sk)
 extern struct netns_ieee802154_lowpan ieee802154_lowpan;
 struct netns_ieee802154_lowpan *net_ieee802154_lowpan(struct net *net);
 #endif
-#else
+#else /* < 3.5..3.14 */
 /* This can be removed once and if this gets upstream */
 static inline struct netns_ieee802154_lowpan *
 net_ieee802154_lowpan(struct net *net)
 {
 	return &net->ieee802154_lowpan;
 }
-#endif
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0) */
 
 #endif	/* _COMPAT_NET_NET_NAMESPACE_H */
diff --git a/backport/backport-include/net/sch_generic.h b/backport/backport-include/net/sch_generic.h
index 04997c7..a863797 100644
--- a/backport/backport-include/net/sch_generic.h
+++ b/backport/backport-include/net/sch_generic.h
@@ -4,129 +4,17 @@
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
 #if !((LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,9) && LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)) || (LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,23) && LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)))
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,37)
 /* mask qdisc_cb_private_validate as RHEL6 backports this */
 #define qdisc_cb_private_validate(a,b) compat_qdisc_cb_private_validate(a,b)
 static inline void qdisc_cb_private_validate(const struct sk_buff *skb, int sz)
 {
 	BUILD_BUG_ON(sizeof(skb->cb) < sizeof(struct qdisc_skb_cb) + sz);
 }
-#else
-/* mask qdisc_cb_private_validate as RHEL6 backports this */
-#define qdisc_cb_private_validate(a,b) compat_qdisc_cb_private_validate(a,b)
-static inline void qdisc_cb_private_validate(const struct sk_buff *skb, int sz)
-{
-	/* XXX ? */
-}
-#endif
 #endif
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27)
-static inline struct net_device *qdisc_dev(const struct Qdisc *qdisc)
-{
-	return qdisc->dev;
-}
-
-/*
- * Backports 378a2f09 and c27f339a
- * This may need a bit more work.
- */
-enum net_xmit_qdisc_t {
-	__NET_XMIT_STOLEN = 0x00010000,
-	__NET_XMIT_BYPASS = 0x00020000,
-};
-
-struct qdisc_skb_cb {
-	unsigned int            pkt_len;
-	char                    data[];
-};
-
-static inline struct qdisc_skb_cb *qdisc_skb_cb(struct sk_buff *skb)
-{
-	return (struct qdisc_skb_cb *)skb->cb;
-}
-
-static inline unsigned int qdisc_pkt_len(struct sk_buff *skb)
-{
-	return qdisc_skb_cb(skb)->pkt_len;
-}
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,38)
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,30)
-static inline void bstats_update(struct gnet_stats_basic_packed *bstats,
-				 const struct sk_buff *skb)
-{
-	bstats->bytes += qdisc_pkt_len((struct sk_buff *) skb);
-	bstats->packets += skb_is_gso(skb) ? skb_shinfo(skb)->gso_segs : 1;
-}
-static inline void qdisc_bstats_update(struct Qdisc *sch,
-				       const struct sk_buff *skb)
-{
-	bstats_update(&sch->bstats, skb);
-}
-#else
-/*
- * kernels <= 2.6.30 do not pass a const skb to qdisc_pkt_len, and
- * gnet_stats_basic_packed did not exist (see c1a8f1f1c8)
- */
-static inline void bstats_update(struct gnet_stats_basic *bstats,
-				 struct sk_buff *skb)
-{
-	bstats->bytes += qdisc_pkt_len(skb);
-	bstats->packets += skb_is_gso(skb) ? skb_shinfo(skb)->gso_segs : 1;
-}
-static inline void qdisc_bstats_update(struct Qdisc *sch,
-				       struct sk_buff *skb)
-{
-	bstats_update(&sch->bstats, skb);
-}
-#endif
-#endif /* < 2.6.38 */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35)
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,27)
-
-#define qdisc_reset_all_tx_gt LINUX_BACKPORT(qdisc_reset_all_tx_gt)
-
-/* Reset all TX qdiscs greater then index of a device.  */
-static inline void qdisc_reset_all_tx_gt(struct net_device *dev, unsigned int i)
-{
-	struct Qdisc *qdisc;
-
-	for (; i < dev->num_tx_queues; i++) {
-		qdisc = netdev_get_tx_queue(dev, i)->qdisc;
-		if (qdisc) {
-			spin_lock_bh(qdisc_lock(qdisc));
-			qdisc_reset(qdisc);
-			spin_unlock_bh(qdisc_lock(qdisc));
-		}
-	}
-}
-#else
-static inline void qdisc_reset_all_tx_gt(struct net_device *dev, unsigned int i)
-{
-}
-#endif /* >= 2.6.27 */
-#endif /* < 2.6.35 */
-
 #ifndef TCQ_F_CAN_BYPASS
 #define TCQ_F_CAN_BYPASS        4
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
-static inline int qdisc_qlen(const struct Qdisc *q)
-{
-	return q->q.qlen;
-}
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27)
-static inline bool qdisc_all_tx_empty(const struct net_device *dev)
-{
-	return skb_queue_empty(&dev->qdisc->q);
-}
-#endif
-
 #endif /* __BACKPORT_NET_SCH_GENERIC_H */
diff --git a/backport/backport-include/net/sock.h b/backport/backport-include/net/sock.h
index b4f3e6a..ec67b9e 100644
--- a/backport/backport-include/net/sock.h
+++ b/backport/backport-include/net/sock.h
@@ -38,39 +38,4 @@
 #define SOCK_SELECT_ERR_QUEUE (SOCK_QUEUE_SHRUNK + 14)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35)
-static inline wait_queue_head_t *sk_sleep(struct sock *sk)
-{
-	return sk->sk_sleep;
-}
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,34)
-static inline struct sock *sk_entry(const struct hlist_node *node)
-{
-	return hlist_entry(node, struct sock, sk_node);
-}
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,33)
-#define sock_recv_ts_and_drops(msg, sk, skb) sock_recv_timestamp(msg, sk, skb)
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
-static inline int sk_rmem_alloc_get(const struct sock *sk)
-{
-	return atomic_read(&sk->sk_rmem_alloc);
-}
-
-static inline int sk_wmem_alloc_get(const struct sock *sk)
-{
-	return atomic_read(&sk->sk_wmem_alloc) - 1;
-}
-
-static inline bool sk_has_allocations(const struct sock *sk)
-{
-	return sk_wmem_alloc_get(sk) || sk_rmem_alloc_get(sk);
-}
-#endif
-
 #endif /* __BACKPORT_NET_SOCK_H */
diff --git a/backport/backport-include/pcmcia/cistpl.h b/backport/backport-include/pcmcia/cistpl.h
deleted file mode 100644
index 789dc59..0000000
--- a/backport/backport-include/pcmcia/cistpl.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#include <linux/version.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36)
-#include <pcmcia/cs_types.h>
-#endif
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37)
-#include <pcmcia/cs.h>
-#endif
-
-#include_next <pcmcia/cistpl.h>
diff --git a/backport/backport-include/pcmcia/ds.h b/backport/backport-include/pcmcia/ds.h
index 48e8fb4..45ab33a 100644
--- a/backport/backport-include/pcmcia/ds.h
+++ b/backport/backport-include/pcmcia/ds.h
@@ -26,66 +26,4 @@
 			pcmcia_unregister_driver)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37)
-#ifndef pcmcia_enable_device
-#define pcmcia_enable_device(link)	pcmcia_request_configuration(link, &(link)->conf)
-#endif
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36)
-#define pcmcia_read_config_byte LINUX_BACKPORT(pcmcia_read_config_byte)
-static inline int pcmcia_read_config_byte(struct pcmcia_device *p_dev, off_t where, u8 *val)
-{
-        int ret;
-        conf_reg_t reg = { 0, CS_READ, where, 0 };
-        ret = pcmcia_access_configuration_register(p_dev, &reg);
-        *val = reg.Value;
-        return ret;
-}
-
-#define pcmcia_write_config_byte LINUX_BACKPORT(pcmcia_write_config_byte)
-static inline int pcmcia_write_config_byte(struct pcmcia_device *p_dev, off_t where, u8 val)
-{
-	conf_reg_t reg = { 0, CS_WRITE, where, val };
-	return pcmcia_access_configuration_register(p_dev, &reg);
-}
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,33)
-#define pcmcia_request_window(a, b, c) pcmcia_request_window(&a, b, c)
-#define pcmcia_map_mem_page(a, b, c) pcmcia_map_mem_page(b, c)
-
-#define pcmcia_loop_tuple LINUX_BACKPORT(pcmcia_loop_tuple)
-int pcmcia_loop_tuple(struct pcmcia_device *p_dev, cisdata_t code,
-		      int (*loop_tuple) (struct pcmcia_device *p_dev,
-					 tuple_t *tuple,
-					 void *priv_data),
-		      void *priv_data);
-
-#define pccard_loop_tuple LINUX_BACKPORT(pccard_loop_tuple)
-int pccard_loop_tuple(struct pcmcia_socket *s, unsigned int function,
-		      cisdata_t code, cisparse_t *parse, void *priv_data,
-		      int (*loop_tuple) (tuple_t *tuple,
-					 cisparse_t *parse,
-					 void *priv_data));
-#endif /* < 2.6.33 */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,28)
-#ifdef pcmcia_parse_tuple
-#undef pcmcia_parse_tuple
-#define pcmcia_parse_tuple(tuple, parse) pccard_parse_tuple(tuple, parse)
-#endif
-
-/* From : include/pcmcia/ds.h */
-/* loop CIS entries for valid configuration */
-#define pcmcia_loop_config LINUX_BACKPORT(pcmcia_loop_config)
-int pcmcia_loop_config(struct pcmcia_device *p_dev,
-		       int	(*conf_check)	(struct pcmcia_device *p_dev,
-						 cistpl_cftable_entry_t *cfg,
-						 cistpl_cftable_entry_t *dflt,
-						 unsigned int vcc,
-						 void *priv_data),
-		       void *priv_data);
-#endif
-
 #endif /* __BACKPORT_PCMCIA_DS_H */
diff --git a/backport/backport-include/trace/define_trace.h b/backport/backport-include/trace/define_trace.h
deleted file mode 100644
index 0b40727..0000000
--- a/backport/backport-include/trace/define_trace.h
+++ /dev/null
@@ -1,5 +0,0 @@
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,32))
-#include_next <trace/define_trace.h>
-#endif /* (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,32)) */
diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index 1cec8ad..5af7433 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -47,48 +47,12 @@
 #
 #
 # C) similarly, a kconfig symbol for an option, e.g.
-#    BACKPORT_OPTION_BT_SOCK_CREATE_NEEDS_KERN (see below)
+#    BACKPORT_OPTION_SOME_FIX (no examples provided) check git log
 #
 #
 # Variations are obviously possible.
 #
 
-config BACKPORT_BUILD_FW_LOADER
-	tristate
-	# RHEL6, starting from 6.0, backports the FW loader already
-	depends on !BACKPORT_RHEL_KERNEL_6_0
-	depends on !FW_LOADER || BACKPORT_KERNEL_2_6_33
-	default m if BACKPORT_FW_LOADER
-	default m if BACKPORT_USERSEL_BUILD_ALL
-
-config BACKPORT_FW_LOADER
-	bool
-
-config BACKPORT_USERSEL_NET_SCH_CODEL
-	tristate "Controlled Delay AQM (CODEL)"
-	depends on m
-	depends on !BACKPORT_KERNEL_2_6_25
-	default m if NET_SCH_CODEL=n
-	default m if BACKPORT_USERSEL_BUILD_ALL
-	#module-name sch_codel
-	#c-file net/sched/sch_codel.c
-
-config BACKPORT_USERSEL_NET_SCH_FQ_CODEL
-	tristate "Fair Queue Controlled Delay AQM (FQ_CODEL)"
-	depends on m
-	depends on !BACKPORT_KERNEL_2_6_25
-	default m if NET_SCH_FQ_CODEL=n
-	default m if BACKPORT_USERSEL_BUILD_ALL
-	#module-name sch_fq_codel
-	#c-file net/sched/sch_fq_codel.c
-	#c-file net/core/flow_dissector.c
-
-config BACKPORT_BUILD_KFIFO
-	def_bool y
-	# RHEL6, starting from 6.1, backports kfifo already
-	depends on !BACKPORT_RHEL_KERNEL_6_1
-	depends on BACKPORT_KERNEL_2_6_36
-
 config BACKPORT_BUILD_CORDIC
 	tristate
 	depends on !CORDIC
@@ -100,15 +64,6 @@ config BACKPORT_BUILD_CORDIC
 config BACKPORT_CORDIC
 	bool
 
-config BACKPORT_BUILD_GENERIC_ATOMIC64
-	bool
-	default y if !64BIT && !GENERIC_ATOMIC64
-
-config BACKPORT_OPTION_BT_SOCK_CREATE_NEEDS_KERN
-	bool
-	# in RHEL6 (starting from 6.0), the function needs the argument
-	default y if !BACKPORT_KERNEL_2_6_33 || BACKPORT_RHEL_KERNEL_6_0
-
 config BACKPORT_BUILD_AVERAGE
 	bool
 	depends on !AVERAGE
@@ -120,10 +75,6 @@ config BACKPORT_BUILD_AVERAGE
 config BACKPORT_AVERAGE
 	bool
 
-config BACKPORT_OPTION_USB_URB_THREAD_FIX
-	bool
-	default y if BACKPORT_KERNEL_2_6_36
-
 config BACKPORT_MII
 	bool
 
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 3c46a1b..353a71d 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -2,20 +2,7 @@ ccflags-y += -I$(src)
 obj-m += compat.o
 compat-y += main.o
 
-obj-$(CPTCFG_BACKPORT_BUILD_FW_LOADER) += compat_firmware_class.o
-
-# Compat kernel compatibility code
-compat-$(CPTCFG_BACKPORT_KERNEL_2_6_26) += compat-2.6.26.o
-compat-$(CPTCFG_BACKPORT_KERNEL_2_6_27) += compat-2.6.27.o
-compat-$(CPTCFG_BACKPORT_KERNEL_2_6_28) += compat-2.6.28.o
-compat-$(CPTCFG_BACKPORT_KERNEL_2_6_29) += compat-2.6.29.o
-compat-$(CPTCFG_BACKPORT_KERNEL_2_6_32) += compat-2.6.32.o
-compat-$(CPTCFG_BACKPORT_KERNEL_2_6_33) += compat-2.6.33.o
-compat-$(CPTCFG_BACKPORT_KERNEL_2_6_34) += compat-2.6.34.o
-compat-$(CPTCFG_BACKPORT_KERNEL_2_6_35) += compat-2.6.35.o
-compat-$(CPTCFG_BACKPORT_KERNEL_2_6_36) += compat-2.6.36.o
-compat-$(CPTCFG_BACKPORT_KERNEL_2_6_37) += compat-2.6.37.o
-compat-$(CPTCFG_BACKPORT_KERNEL_2_6_39) += compat-2.6.39.o kstrtox.o
+# Kernel backport compatibility code
 compat-$(CPTCFG_BACKPORT_KERNEL_3_0) += compat-3.0.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_1) += compat-3.1.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_2) += backport-3.2.o
@@ -33,6 +20,4 @@ compat-$(CPTCFG_BACKPORT_KERNEL_3_14) += backport-3.14.o
 compat-$(CPTCFG_BACKPORT_KERNEL_3_15) += backport-3.15.o
 
 compat-$(CPTCFG_BACKPORT_BUILD_CRYPTO_CCM) += crypto-ccm.o
-compat-$(CPTCFG_BACKPORT_BUILD_KFIFO) += kfifo.o
-compat-$(CPTCFG_BACKPORT_BUILD_GENERIC_ATOMIC64) += compat_atomic.o
 compat-$(CPTCFG_BACKPORT_BUILD_DMA_SHARED_HELPERS) += dma-shared-helpers.o
diff --git a/backport/compat/compat-2.6.26.c b/backport/compat/compat-2.6.26.c
deleted file mode 100644
index 9ff1f76..0000000
--- a/backport/compat/compat-2.6.26.c
+++ /dev/null
@@ -1,64 +0,0 @@
-/*
- * Copyright 2007-2010	Luis R. Rodriguez <mcgrof@winlab.rutgers.edu>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Backport functionality introduced in Linux 2.6.26.
- *
- * Copyright holders from ported work:
- *
- * Copyright (c) 2002-2003 Patrick Mochel <mochel@osdl.org>
- * Copyright (c) 2006-2007 Greg Kroah-Hartman <greg@kroah.com>
- * Copyright (c) 2006-2007 Novell Inc.
- */
-#include <linux/device.h>
-#include <net/sock.h>
-#include <net/compat.h>
-
-/**
- * kobject_set_name_vargs - Set the name of an kobject
- * @kobj: struct kobject to set the name of
- * @fmt: format string used to build the name
- * @vargs: vargs to format the string.
- */
-static
-int kobject_set_name_vargs(struct kobject *kobj, const char *fmt,
-				  va_list vargs)
-{
-	const char *old_name = kobj->name;
-	char *s;
-
-	if (kobj->name && !fmt)
-		return 0;
-
-	kobj->name = kvasprintf(GFP_KERNEL, fmt, vargs);
-	if (!kobj->name)
-		return -ENOMEM;
-
-	/* ewww... some of these buggers have '/' in the name ... */
-	while ((s = strchr(kobj->name, '/')))
-		s[0] = '!';
-
-	kfree(old_name);
-	return 0;
-}
-
-/**
- * dev_set_name - set a device name
- * @dev: device
- * @fmt: format string for the device's name
- */
-int dev_set_name(struct device *dev, const char *fmt, ...)
-{
-	va_list vargs;
-	int err;
-
-	va_start(vargs, fmt);
-	err = kobject_set_name_vargs(&dev->kobj, fmt, vargs);
-	va_end(vargs);
-	return err;
-}
-EXPORT_SYMBOL_GPL(dev_set_name);
-
diff --git a/backport/compat/compat-2.6.27.c b/backport/compat/compat-2.6.27.c
deleted file mode 100644
index 7235c87..0000000
--- a/backport/compat/compat-2.6.27.c
+++ /dev/null
@@ -1,241 +0,0 @@
-/*
- * Copyright 2007	Luis R. Rodriguez <mcgrof@winlab.rutgers.edu>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Backport functionality introduced in Linux 2.6.27
- */
-#include <linux/debugfs.h>
-#include <linux/compat.h>
-#include <linux/pci.h>
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,24))
-#include <linux/mmc/sdio.h>
-#include <linux/mmc/sdio_func.h>
-#include <linux/mmc/card.h>
-#include <linux/mmc/host.h>
-#endif
-
-/* rfkill notification chain */
-#define RFKILL_STATE_CHANGED            0x0001  /* state of a normal rfkill
-							switch has changed */
-
-/*
- * e5899e1b7d73e67de758a32174a859cc2586c0b9 made pci_pme_capable() external,
- * it was defined internally, some drivers want access to this information.
- *
- * Unfortunately the old kernels do not have ->pm_cap or ->pme_support so
- * we have to call the PCI routines directly.
- */
-
-#ifdef CONFIG_PCI
-/**
- * pci_pme_capable - check the capability of PCI device to generate PME#
- * @dev: PCI device to handle.
- * @state: PCI state from which device will issue PME#.
- *
- * This is the backport code for older kernels for compat-drivers, we read stuff
- * from the initialization stuff from pci_pm_init().
- */
-bool pci_pme_capable(struct pci_dev *dev, pci_power_t state)
-{
-	int pm;
-	u16 pmc = 0;
-	u16 pme_support; /* as from the pci dev */
-	/* find PCI PM capability in list */
-	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
-	if (!pm)
-		return false;
-
-        if ((pmc & PCI_PM_CAP_VER_MASK) > 3) {
-		dev_err(&dev->dev, "unsupported PM cap regs version (%u)\n",
-			pmc & PCI_PM_CAP_VER_MASK);
-		return false;
-        }
-
-	pmc &= PCI_PM_CAP_PME_MASK;
-
-	if (!pmc)
-		return false;
-
-	pme_support = pmc >> PCI_PM_CAP_PME_SHIFT;
-
-	/* Check device's ability to generate PME# */
-
-	return !!(pme_support & (1 << state));
-}
-EXPORT_SYMBOL_GPL(pci_pme_capable);
-#endif
-
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,24))
-/**
- *	mmc_align_data_size - pads a transfer size to a more optimal value
- *	@card: the MMC card associated with the data transfer
- *	@sz: original transfer size
- *
- *	Pads the original data size with a number of extra bytes in
- *	order to avoid controller bugs and/or performance hits
- *	(e.g. some controllers revert to PIO for certain sizes).
- *
- *	Returns the improved size, which might be unmodified.
- *
- *	Note that this function is only relevant when issuing a
- *	single scatter gather entry.
- */
-unsigned int mmc_align_data_size(struct mmc_card *card, unsigned int sz)
-{
-	/*
-	* FIXME: We don't have a system for the controller to tell
-	* the core about its problems yet, so for now we just 32-bit
-	* align the size.
-	*/
-	sz = ((sz + 3) / 4) * 4;
-
-	return sz;
-}
-EXPORT_SYMBOL_GPL(mmc_align_data_size);
-
-/*
- * Calculate the maximum byte mode transfer size
- */
-static inline unsigned int sdio_max_byte_size(struct sdio_func *func)
-{
-	unsigned int mval = (unsigned int) min(func->card->host->max_seg_size,
-			    func->card->host->max_blk_size);
-	mval = min(mval, func->max_blksize);
-	return min(mval, 512u); /* maximum size for byte mode */
-}
-
-/**
- *	sdio_align_size - pads a transfer size to a more optimal value
- *	@func: SDIO function
- *	@sz: original transfer size
- *
- *	Pads the original data size with a number of extra bytes in
- *	order to avoid controller bugs and/or performance hits
- *	(e.g. some controllers revert to PIO for certain sizes).
- *
- *	If possible, it will also adjust the size so that it can be
- *	handled in just a single request.
- *
- *	Returns the improved size, which might be unmodified.
- */
-unsigned int sdio_align_size(struct sdio_func *func, unsigned int sz)
-{
-	unsigned int orig_sz;
-	unsigned int blk_sz, byte_sz;
-	unsigned chunk_sz;
-
-	orig_sz = sz;
-
-	/*
-	 * Do a first check with the controller, in case it
-	 * wants to increase the size up to a point where it
-	 * might need more than one block.
-	 */
-	sz = mmc_align_data_size(func->card, sz);
-
-	/*
-	 * If we can still do this with just a byte transfer, then
-	 * we're done.
-	 */
-	if (sz <= sdio_max_byte_size(func))
-		return sz;
-
-	if (func->card->cccr.multi_block) {
-		/*
-		 * Check if the transfer is already block aligned
-		 */
-		if ((sz % func->cur_blksize) == 0)
-			return sz;
-
-		/*
-		 * Realign it so that it can be done with one request,
-		 * and recheck if the controller still likes it.
-		 */
-		blk_sz = ((sz + func->cur_blksize - 1) /
-			func->cur_blksize) * func->cur_blksize;
-		blk_sz = mmc_align_data_size(func->card, blk_sz);
-
-		/*
-		 * This value is only good if it is still just
-		 * one request.
-		 */
-		if ((blk_sz % func->cur_blksize) == 0)
-			return blk_sz;
-
-		/*
-		 * We failed to do one request, but at least try to
-		 * pad the remainder properly.
-		 */
-		byte_sz = mmc_align_data_size(func->card,
-				sz % func->cur_blksize);
-		if (byte_sz <= sdio_max_byte_size(func)) {
-			blk_sz = sz / func->cur_blksize;
-			return blk_sz * func->cur_blksize + byte_sz;
-		}
-	} else {
-		/*
-		 * We need multiple requests, so first check that the
-		 * controller can handle the chunk size;
-		 */
-		chunk_sz = mmc_align_data_size(func->card,
-				sdio_max_byte_size(func));
-		if (chunk_sz == sdio_max_byte_size(func)) {
-			/*
-			 * Fix up the size of the remainder (if any)
-			 */
-			byte_sz = orig_sz % chunk_sz;
-			if (byte_sz) {
-				byte_sz = mmc_align_data_size(func->card,
-						byte_sz);
-			}
-
-			return (orig_sz / chunk_sz) * chunk_sz + byte_sz;
-		}
-	}
-
-	/*
-	 * The controller is simply incapable of transferring the size
-	 * we want in decent manner, so just return the original size.
-	 */
-	return orig_sz;
-}
-EXPORT_SYMBOL_GPL(sdio_align_size);
-#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,24) */
-
-#ifdef CONFIG_DEBUG_FS
-/*
- * Backport of debugfs_remove_recursive() without using the internals globals
- * which are used by the kernel's version with:
- * simple_release_fs(&debugfs_mount, &debugfs_mount_count);
- */
-void debugfs_remove_recursive(struct dentry *dentry)
-{
-	struct dentry *last = NULL;
-
-	/* Sanity checks */
-	if (!dentry || !dentry->d_parent || !dentry->d_parent->d_inode)
-		return;
-
-	while (dentry != last) {
-		struct dentry *child = dentry;
-
-		/* Find a child without children */
-		while (!list_empty(&child->d_subdirs))
-			child = list_entry(child->d_subdirs.next,
-					   struct dentry,
-					   d_u.d_child);
-
-		/* Bail out if we already tried to remove that entry */
-		if (child == last)
-			return;
-
-		last = child;
-		debugfs_remove(child);
-	}
-}
-EXPORT_SYMBOL_GPL(debugfs_remove_recursive);
-#endif /* CONFIG_DEBUG_FS */
-
diff --git a/backport/compat/compat-2.6.28.c b/backport/compat/compat-2.6.28.c
deleted file mode 100644
index 1a4b01d..0000000
--- a/backport/compat/compat-2.6.28.c
+++ /dev/null
@@ -1,472 +0,0 @@
-/*
- * Copyright 2007	Luis R. Rodriguez <mcgrof@winlab.rutgers.edu>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Backport functionality introduced in Linux 2.6.28.
- */
-
-#include <linux/compat.h>
-#include <linux/usb.h>
-#include <linux/tty.h>
-#include <linux/skbuff.h>
-#include <linux/pci.h>
-#include <asm/poll.h>
-
-/* 2.6.28 compat code goes here */
-
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,23))
-#if defined(CONFIG_USB) || defined(CONFIG_USB_MODULE)
-/*
- * Compat-wireless notes for USB backport stuff:
- *
- * urb->reject exists on 2.6.27, the poison/unpoison helpers
- * did not though. The anchor poison does not exist so we cannot use them.
- *
- * USB anchor poising seems to exist to prevent future driver sumbissions
- * of usb_anchor_urb() to an anchor marked as poisoned. For older kernels
- * we cannot use that, so new usb_anchor_urb()s will be anchored. The down
- * side to this should be submission of URBs will continue being anchored
- * on an anchor instead of having them being rejected immediately when the
- * driver realized we needed to stop. For ar9170 we poison URBs upon the
- * ar9170 mac80211 stop callback(), don't think this should be so bad.
- * It mean there is period of time in older kernels for which we continue
- * to anchor new URBs to a known stopped anchor. We have two anchors
- * (TX, and RX)
- */
-
-#if 0
-/**
- * usb_poison_urb - reliably kill a transfer and prevent further use of an URB
- * @urb: pointer to URB describing a previously submitted request,
- *	may be NULL
- *
- * This routine cancels an in-progress request.  It is guaranteed that
- * upon return all completion handlers will have finished and the URB
- * will be totally idle and cannot be reused.  These features make
- * this an ideal way to stop I/O in a disconnect() callback.
- * If the request has not already finished or been unlinked
- * the completion handler will see urb->status == -ENOENT.
- *
- * After and while the routine runs, attempts to resubmit the URB will fail
- * with error -EPERM.  Thus even if the URB's completion handler always
- * tries to resubmit, it will not succeed and the URB will become idle.
- *
- * This routine may not be used in an interrupt context (such as a bottom
- * half or a completion handler), or when holding a spinlock, or in other
- * situations where the caller can't schedule().
- *
- * This routine should not be called by a driver after its disconnect
- * method has returned.
- */
-void usb_poison_urb(struct urb *urb)
-{
-	might_sleep();
-	if (!(urb && urb->dev && urb->ep))
-		return;
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,28))
-	spin_lock_irq(&usb_reject_lock);
-#endif
-	++urb->reject;
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,28))
-	spin_unlock_irq(&usb_reject_lock);
-#endif
-	/*
-	 * XXX: usb_hcd_unlink_urb() needs backporting... this is defined
-	 * on usb hcd.c but urb.c gets access to it. That is, older kernels
-	 * have usb_hcd_unlink_urb() but its not exported, nor can we
-	 * re-implement it exactly. This essentially dequeues the urb from
-	 * hw, we need to figure out a way to backport this.
-	 */
-	//usb_hcd_unlink_urb(urb, -ENOENT);
-
-	wait_event(usb_kill_urb_queue, atomic_read(&urb->use_count) == 0);
-}
-EXPORT_SYMBOL_GPL(usb_poison_urb);
-#endif
-#endif /* CONFIG_USB */
-
-#if defined(CONFIG_PCMCIA) || defined(CONFIG_PCMCIA_MODULE)
-#include <pcmcia/cistpl.h>
-#include <pcmcia/cs_types.h>
-#include <pcmcia/ds.h>
-struct pcmcia_cfg_mem {
-	tuple_t tuple;
-	cisparse_t parse;
-	u8 buf[256];
-	cistpl_cftable_entry_t dflt;
-};
-/**
- * pcmcia_loop_config() - loop over configuration options
- * @p_dev:	the struct pcmcia_device which we need to loop for.
- * @conf_check:	function to call for each configuration option.
- *		It gets passed the struct pcmcia_device, the CIS data
- *		describing the configuration option, and private data
- *		being passed to pcmcia_loop_config()
- * @priv_data:	private data to be passed to the conf_check function.
- *
- * pcmcia_loop_config() loops over all configuration options, and calls
- * the driver-specific conf_check() for each one, checking whether
- * it is a valid one. Returns 0 on success or errorcode otherwise.
- */
-int pcmcia_loop_config(struct pcmcia_device *p_dev,
-		       int	(*conf_check)	(struct pcmcia_device *p_dev,
-						 cistpl_cftable_entry_t *cfg,
-						 cistpl_cftable_entry_t *dflt,
-						 unsigned int vcc,
-						 void *priv_data),
-		       void *priv_data)
-{
-	struct pcmcia_cfg_mem *cfg_mem;
-
-	tuple_t *tuple;
-	int ret;
-	unsigned int vcc;
-
-	cfg_mem = kzalloc(sizeof(struct pcmcia_cfg_mem), GFP_KERNEL);
-	if (cfg_mem == NULL)
-		return -ENOMEM;
-
-	/* get the current Vcc setting */
-	vcc = p_dev->socket->socket.Vcc;
-
-	tuple = &cfg_mem->tuple;
-	tuple->TupleData = cfg_mem->buf;
-	tuple->TupleDataMax = 255;
-	tuple->TupleOffset = 0;
-	tuple->DesiredTuple = CISTPL_CFTABLE_ENTRY;
-	tuple->Attributes = 0;
-
-	ret = pcmcia_get_first_tuple(p_dev, tuple);
-	while (!ret) {
-		cistpl_cftable_entry_t *cfg = &cfg_mem->parse.cftable_entry;
-
-		if (pcmcia_get_tuple_data(p_dev, tuple))
-			goto next_entry;
-
-		if (pcmcia_parse_tuple(tuple, &cfg_mem->parse))
-			goto next_entry;
-
-		/* default values */
-		p_dev->conf.ConfigIndex = cfg->index;
-		if (cfg->flags & CISTPL_CFTABLE_DEFAULT)
-			cfg_mem->dflt = *cfg;
-
-		ret = conf_check(p_dev, cfg, &cfg_mem->dflt, vcc, priv_data);
-		if (!ret)
-			break;
-
-next_entry:
-		ret = pcmcia_get_next_tuple(p_dev, tuple);
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(pcmcia_loop_config);
-
-#endif /* CONFIG_PCMCIA */
-
-#if defined(CONFIG_USB) || defined(CONFIG_USB_MODULE)
-
-void usb_unpoison_urb(struct urb *urb)
-{
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,28))
-	unsigned long flags;
-#endif
-
-	if (!urb)
-		return;
-
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,28))
-	spin_lock_irqsave(&usb_reject_lock, flags);
-#endif
-	--urb->reject;
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,28))
-	spin_unlock_irqrestore(&usb_reject_lock, flags);
-#endif
-}
-EXPORT_SYMBOL_GPL(usb_unpoison_urb);
-
-
-#if 0
-/**
- * usb_poison_anchored_urbs - cease all traffic from an anchor
- * @anchor: anchor the requests are bound to
- *
- * this allows all outstanding URBs to be poisoned starting
- * from the back of the queue. Newly added URBs will also be
- * poisoned
- *
- * This routine should not be called by a driver after its disconnect
- * method has returned.
- */
-void usb_poison_anchored_urbs(struct usb_anchor *anchor)
-{
-	struct urb *victim;
-
-	spin_lock_irq(&anchor->lock);
-	// anchor->poisoned = 1; /* XXX: Cannot backport */
-	while (!list_empty(&anchor->urb_list)) {
-		victim = list_entry(anchor->urb_list.prev, struct urb,
-				    anchor_list);
-		/* we must make sure the URB isn't freed before we kill it*/
-		usb_get_urb(victim);
-		spin_unlock_irq(&anchor->lock);
-		/* this will unanchor the URB */
-		usb_poison_urb(victim);
-		usb_put_urb(victim);
-		spin_lock_irq(&anchor->lock);
-	}
-	spin_unlock_irq(&anchor->lock);
-}
-EXPORT_SYMBOL_GPL(usb_poison_anchored_urbs);
-#endif
-
-/**
- * usb_anchor_empty - is an anchor empty
- * @anchor: the anchor you want to query
- *
- * returns 1 if the anchor has no urbs associated with it
- */
-int usb_anchor_empty(struct usb_anchor *anchor)
-{
-	return list_empty(&anchor->urb_list);
-}
-
-EXPORT_SYMBOL_GPL(usb_anchor_empty);
-#endif /* CONFIG_USB */
-#endif
-
-#ifdef CONFIG_PCI
-void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar)
-{
-	/*
-	 * Make sure the BAR is actually a memory resource, not an IO resource
-	 */
-	if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM)) {
-		WARN_ON(1);
-		return NULL;
-	}
-	return ioremap_nocache(pci_resource_start(pdev, bar),
-				     pci_resource_len(pdev, bar));
-}
-EXPORT_SYMBOL_GPL(pci_ioremap_bar);
-#endif
-
-static unsigned long round_jiffies_common(unsigned long j, int cpu,
-		bool force_up)
-{
-	int rem;
-	unsigned long original = j;
-
-	/*
-	 * We don't want all cpus firing their timers at once hitting the
-	 * same lock or cachelines, so we skew each extra cpu with an extra
-	 * 3 jiffies. This 3 jiffies came originally from the mm/ code which
-	 * already did this.
-	 * The skew is done by adding 3*cpunr, then round, then subtract this
-	 * extra offset again.
-	 */
-	j += cpu * 3;
-
-	rem = j % HZ;
-
-	/*
-	 * If the target jiffie is just after a whole second (which can happen
-	 * due to delays of the timer irq, long irq off times etc etc) then
-	 * we should round down to the whole second, not up. Use 1/4th second
-	 * as cutoff for this rounding as an extreme upper bound for this.
-	 * But never round down if @force_up is set.
-	 */
-	if (rem < HZ/4 && !force_up) /* round down */
-		j = j - rem;
-	else /* round up */
-		j = j - rem + HZ;
-
-	/* now that we have rounded, subtract the extra skew again */
-	j -= cpu * 3;
-
-	if (j <= jiffies) /* rounding ate our timeout entirely; */
-		return original;
-	return j;
-}
-
-/**
- * round_jiffies_up - function to round jiffies up to a full second
- * @j: the time in (absolute) jiffies that should be rounded
- *
- * This is the same as round_jiffies() except that it will never
- * round down.  This is useful for timeouts for which the exact time
- * of firing does not matter too much, as long as they don't fire too
- * early.
- */
-unsigned long round_jiffies_up(unsigned long j)
-{
-	return round_jiffies_common(j, raw_smp_processor_id(), true);
-}
-EXPORT_SYMBOL_GPL(round_jiffies_up);
-
-void v2_6_28_skb_add_rx_frag(struct sk_buff *skb, int i, struct page *page, int off,
-		int size)
-{
-	skb_fill_page_desc(skb, i, page, off, size);
-	skb->len += size;
-	skb->data_len += size;
-	skb->truesize += size;
-}
-EXPORT_SYMBOL_GPL(v2_6_28_skb_add_rx_frag);
-
-#ifdef CONFIG_TTY
-void tty_write_unlock(struct tty_struct *tty)
-{
-	mutex_unlock(&tty->atomic_write_lock);
-	wake_up_interruptible_poll(&tty->write_wait, POLLOUT);
-}
-
-int tty_write_lock(struct tty_struct *tty, int ndelay)
-{
-	if (!mutex_trylock(&tty->atomic_write_lock)) {
-		if (ndelay)
-			return -EAGAIN;
-		if (mutex_lock_interruptible(&tty->atomic_write_lock))
-			return -ERESTARTSYS;
-	}
-	return 0;
-}
-
-/**
- *	send_prio_char		-	send priority character
- *
- *	Send a high priority character to the tty even if stopped
- *
- *	Locking: none for xchar method, write ordering for write method.
- */
-
-static int send_prio_char(struct tty_struct *tty, char ch)
-{
-	int	was_stopped = tty->stopped;
-
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,26))
-	if (tty->ops->send_xchar) {
-		tty->ops->send_xchar(tty, ch);
-#else
-	if (tty->driver->send_xchar) {
-		tty->driver->send_xchar(tty, ch);
-#endif
-		return 0;
-	}
-
-	if (tty_write_lock(tty, 0) < 0)
-		return -ERESTARTSYS;
-
-	if (was_stopped)
-		start_tty(tty);
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,26))
-	tty->ops->write(tty, &ch, 1);
-#else
-	tty->driver->write(tty, &ch, 1);
-#endif
-	if (was_stopped)
-		stop_tty(tty);
-	tty_write_unlock(tty);
-	return 0;
-}
-
-int n_tty_ioctl_helper(struct tty_struct *tty, struct file *file,
-		       unsigned int cmd, unsigned long arg)
-{
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,26))
-	unsigned long flags;
-#endif
-	int retval;
-
-	switch (cmd) {
-	case TCXONC:
-		retval = tty_check_change(tty);
-		if (retval)
-			return retval;
-		switch (arg) {
-		case TCOOFF:
-			if (!tty->flow_stopped) {
-				tty->flow_stopped = 1;
-				stop_tty(tty);
-			}
-			break;
-		case TCOON:
-			if (tty->flow_stopped) {
-				tty->flow_stopped = 0;
-				start_tty(tty);
-			}
-			break;
-		case TCIOFF:
-			if (STOP_CHAR(tty) != __DISABLED_CHAR)
-				return send_prio_char(tty, STOP_CHAR(tty));
-			break;
-		case TCION:
-			if (START_CHAR(tty) != __DISABLED_CHAR)
-				return send_prio_char(tty, START_CHAR(tty));
-			break;
-		default:
-			return -EINVAL;
-		}
-		return 0;
-	case TCFLSH:
-		return tty_perform_flush(tty, arg);
-	case TIOCPKT:
-	{
-		int pktmode;
-
-		if (tty->driver->type != TTY_DRIVER_TYPE_PTY ||
-		    tty->driver->subtype != PTY_TYPE_MASTER)
-			return -ENOTTY;
-		if (get_user(pktmode, (int __user *) arg))
-			return -EFAULT;
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,26))
-		spin_lock_irqsave(&tty->ctrl_lock, flags);
-#endif
-		if (pktmode) {
-			if (!tty->packet) {
-				tty->packet = 1;
-				tty->link->ctrl_status = 0;
-			}
-		} else
-			tty->packet = 0;
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,26))
-		spin_unlock_irqrestore(&tty->ctrl_lock, flags);
-#endif
-		return 0;
-	}
-	default:
-		/* Try the mode commands */
-		return tty_mode_ioctl(tty, file, cmd, arg);
-	}
-}
-EXPORT_SYMBOL_GPL(n_tty_ioctl_helper);
-#endif /* CONFIG_TTY */
-
-#ifdef CONFIG_PCI
-/**
- * pci_wake_from_d3 - enable/disable device to wake up from D3_hot or D3_cold
- * @dev: PCI device to prepare
- * @enable: True to enable wake-up event generation; false to disable
- *
- * Many drivers want the device to wake up the system from D3_hot or D3_cold
- * and this function allows them to set that up cleanly - pci_enable_wake()
- * should not be called twice in a row to enable wake-up due to PCI PM vs ACPI
- * ordering constraints.
- *
- * This function only returns error code if the device is not capable of
- * generating PME# from both D3_hot and D3_cold, and the platform is unable to
- * enable wake-up power for it.
- */
-int pci_wake_from_d3(struct pci_dev *dev, bool enable)
-{
-	return pci_pme_capable(dev, PCI_D3cold) ?
-			pci_enable_wake(dev, PCI_D3cold, enable) :
-			pci_enable_wake(dev, PCI_D3hot, enable);
-}
-EXPORT_SYMBOL_GPL(pci_wake_from_d3);
-#endif
-
diff --git a/backport/compat/compat-2.6.29.c b/backport/compat/compat-2.6.29.c
deleted file mode 100644
index 65b45f8..0000000
--- a/backport/compat/compat-2.6.29.c
+++ /dev/null
@@ -1,169 +0,0 @@
-/*
- * Copyright 2007-2010	Luis R. Rodriguez <mcgrof@winlab.rutgers.edu>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Backport functionality introduced in Linux 2.6.29.
- */
-
-#include <linux/compat.h>
-#include <linux/usb.h>
-#include <linux/etherdevice.h>
-
-/*
- * If you don't see your net_device_ops implemented on
- * netdev_attach_ops() then you are shit out of luck and
- * you must do the nasty ifdef magic, unless you figure
- * out a way to squeze your hacks into this routine :)
- */
-void netdev_attach_ops(struct net_device *dev,
-		       const struct net_device_ops *ops)
-{
-	if (!ops)
-		return;
-
-	dev->open = ops->ndo_open;
-	dev->init = ops->ndo_init;
-	dev->stop = ops->ndo_stop;
-	dev->hard_start_xmit = ops->ndo_start_xmit;
-	dev->change_rx_flags = ops->ndo_change_rx_flags;
-	dev->set_multicast_list = ops->ndo_set_multicast_list;
-	dev->validate_addr = ops->ndo_validate_addr;
-	dev->do_ioctl = ops->ndo_do_ioctl;
-	dev->set_config = ops->ndo_set_config;
-	dev->change_mtu = ops->ndo_change_mtu;
-	dev->set_mac_address = ops->ndo_set_mac_address;
-	dev->tx_timeout = ops->ndo_tx_timeout;
-	if (ops->ndo_get_stats)
-		dev->get_stats = ops->ndo_get_stats;
-	dev->vlan_rx_register = ops->ndo_vlan_rx_register;
-	dev->vlan_rx_add_vid = ops->ndo_vlan_rx_add_vid;
-	dev->vlan_rx_kill_vid = ops->ndo_vlan_rx_kill_vid;
-#ifdef CONFIG_NET_POLL_CONTROLLER
-	dev->poll_controller = ops->ndo_poll_controller;
-#endif
-
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,27))
-	dev->select_queue = ops->ndo_select_queue;
-#endif
-}
-EXPORT_SYMBOL_GPL(netdev_attach_ops);
-
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,23))
-#if defined(CONFIG_USB) || defined(CONFIG_USB_MODULE)
-/**
- * usb_unpoison_anchored_urbs - let an anchor be used successfully again
- * @anchor: anchor the requests are bound to
- *
- * Reverses the effect of usb_poison_anchored_urbs
- * the anchor can be used normally after it returns
- */
-void usb_unpoison_anchored_urbs(struct usb_anchor *anchor)
-{
-	unsigned long flags;
-	struct urb *lazarus;
-
-	spin_lock_irqsave(&anchor->lock, flags);
-	list_for_each_entry(lazarus, &anchor->urb_list, anchor_list) {
-		usb_unpoison_urb(lazarus);
-	}
-	//anchor->poisoned = 0; /* XXX: cannot backport */
-	spin_unlock_irqrestore(&anchor->lock, flags);
-}
-EXPORT_SYMBOL_GPL(usb_unpoison_anchored_urbs);
-#endif /* CONFIG_USB */
-#endif
-
-/**
- * eth_mac_addr - set new Ethernet hardware address
- * @dev: network device
- * @p: socket address
- * Change hardware address of device.
- *
- * This doesn't change hardware matching, so needs to be overridden
- * for most real devices.
- */
-int eth_mac_addr(struct net_device *dev, void *p)
-{
-	struct sockaddr *addr = p;
-
-	if (netif_running(dev))
-		return -EBUSY;
-	if (!is_valid_ether_addr(addr->sa_data))
-		return -EADDRNOTAVAIL;
-	memcpy(dev->dev_addr, addr->sa_data, ETH_ALEN);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(eth_mac_addr);
-
-/**
- * eth_change_mtu - set new MTU size
- * @dev: network device
- * @new_mtu: new Maximum Transfer Unit
- *
- * Allow changing MTU size. Needs to be overridden for devices
- * supporting jumbo frames.
- */
-int eth_change_mtu(struct net_device *dev, int new_mtu)
-{
-	if (new_mtu < 68 || new_mtu > ETH_DATA_LEN)
-		return -EINVAL;
-	dev->mtu = new_mtu;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(eth_change_mtu);
-
-int eth_validate_addr(struct net_device *dev)
-{
-	if (!is_valid_ether_addr(dev->dev_addr))
-		return -EADDRNOTAVAIL;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(eth_validate_addr);
-/* Source: net/ethernet/eth.c */
-
-#define NETREG_DUMMY 5
-/**
- *	init_dummy_netdev	- init a dummy network device for NAPI
- *	@dev: device to init
- *
- *	This takes a network device structure and initialize the minimum
- *	amount of fields so it can be used to schedule NAPI polls without
- *	registering a full blown interface. This is to be used by drivers
- *	that need to tie several hardware interfaces to a single NAPI
- *	poll scheduler due to HW limitations.
- */
-int init_dummy_netdev(struct net_device *dev)
-{
-	/* Clear everything. Note we don't initialize spinlocks
-	 * are they aren't supposed to be taken by any of the
-	 * NAPI code and this dummy netdev is supposed to be
-	 * only ever used for NAPI polls
-	 */
-	memset(dev, 0, sizeof(struct net_device));
-
-	/* make sure we BUG if trying to hit standard
-	 * register/unregister code path
-	 */
-	dev->reg_state = NETREG_DUMMY;
-
-	/* initialize the ref count */
-	atomic_set(&dev->refcnt, 1);
-
-#ifdef CONFIG_NETPOLL
-	/* NAPI wants this */
-	INIT_LIST_HEAD(&dev->napi_list);
-#endif
-
-	/* a dummy interface is started by default */
-	set_bit(__LINK_STATE_PRESENT, &dev->state);
-	set_bit(__LINK_STATE_START, &dev->state);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(init_dummy_netdev);
-/* Source: net/core/dev.c */
-
diff --git a/backport/compat/compat-2.6.32.c b/backport/compat/compat-2.6.32.c
deleted file mode 100644
index 7d76b40..0000000
--- a/backport/compat/compat-2.6.32.c
+++ /dev/null
@@ -1,217 +0,0 @@
-/*
- * Copyright 2007	Luis R. Rodriguez <mcgrof@winlab.rutgers.edu>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Backport functionality introduced in Linux 2.6.32.
- */
-
-#include <linux/compat.h>
-#include <linux/netdevice.h>
-#include <linux/time.h>
-
-int __dev_addr_add(struct dev_addr_list **list, int *count,
-		   void *addr, int alen, int glbl)
-{
-	struct dev_addr_list *da;
-
-	for (da = *list; da != NULL; da = da->next) {
-		if (memcmp(da->da_addr, addr, da->da_addrlen) == 0 &&
-		    da->da_addrlen == alen) {
-			if (glbl) {
-				int old_glbl = da->da_gusers;
-				da->da_gusers = 1;
-				if (old_glbl)
-					return 0;
-			}
-			da->da_users++;
-			return 0;
-		}
-	}
-
-	da = kzalloc(sizeof(*da), GFP_ATOMIC);
-	if (da == NULL)
-		return -ENOMEM;
-	memcpy(da->da_addr, addr, alen);
-	da->da_addrlen = alen;
-	da->da_users = 1;
-	da->da_gusers = glbl ? 1 : 0;
-	da->next = *list;
-	*list = da;
-	(*count)++;
-	return 0;
-}
-
-int __dev_addr_delete(struct dev_addr_list **list, int *count,
-		      void *addr, int alen, int glbl)
-{
-	struct dev_addr_list *da;
-
-	for (; (da = *list) != NULL; list = &da->next) {
-		if (memcmp(da->da_addr, addr, da->da_addrlen) == 0 &&
-		    alen == da->da_addrlen) {
-			if (glbl) {
-				int old_glbl = da->da_gusers;
-				da->da_gusers = 0;
-				if (old_glbl == 0)
-					break;
-			}
-			if (--da->da_users)
-				return 0;
-
-			*list = da->next;
-			kfree(da);
-			(*count)--;
-			return 0;
-		}
-	}
-	return -ENOENT;
-}
-
-int __dev_addr_sync(struct dev_addr_list **to, int *to_count,
-		    struct dev_addr_list **from, int *from_count)
-{
-	struct dev_addr_list *da, *next;
-	int err = 0;
-
-	da = *from;
-	while (da != NULL) {
-		next = da->next;
-		if (!da->da_synced) {
-			err = __dev_addr_add(to, to_count,
-					     da->da_addr, da->da_addrlen, 0);
-			if (err < 0)
-				break;
-			da->da_synced = 1;
-			da->da_users++;
-		} else if (da->da_users == 1) {
-			__dev_addr_delete(to, to_count,
-					  da->da_addr, da->da_addrlen, 0);
-			__dev_addr_delete(from, from_count,
-					  da->da_addr, da->da_addrlen, 0);
-		}
-		da = next;
-	}
-	return err;
-}
-EXPORT_SYMBOL_GPL(__dev_addr_sync);
-
-void __dev_addr_unsync(struct dev_addr_list **to, int *to_count,
-		       struct dev_addr_list **from, int *from_count)
-{
-	struct dev_addr_list *da, *next;
-
-	da = *from;
-	while (da != NULL) {
-		next = da->next;
-		if (da->da_synced) {
-			__dev_addr_delete(to, to_count,
-					  da->da_addr, da->da_addrlen, 0);
-			da->da_synced = 0;
-			__dev_addr_delete(from, from_count,
-					  da->da_addr, da->da_addrlen, 0);
-		}
-		da = next;
-	}
-}
-EXPORT_SYMBOL_GPL(__dev_addr_unsync);
-
-/*
- * Nonzero if YEAR is a leap year (every 4 years,
- * except every 100th isn't, and every 400th is).
- */
-static int __isleap(long year)
-{
-	return (year) % 4 == 0 && ((year) % 100 != 0 || (year) % 400 == 0);
-}
-
-/* do a mathdiv for long type */
-static long math_div(long a, long b)
-{
-	return a / b - (a % b < 0);
-}
-
-/* How many leap years between y1 and y2, y1 must less or equal to y2 */
-static long leaps_between(long y1, long y2)
-{
-	long leaps1 = math_div(y1 - 1, 4) - math_div(y1 - 1, 100)
-		+ math_div(y1 - 1, 400);
-	long leaps2 = math_div(y2 - 1, 4) - math_div(y2 - 1, 100)
-		+ math_div(y2 - 1, 400);
-	return leaps2 - leaps1;
-}
-
-/* How many days come before each month (0-12). */
-static const unsigned short __mon_yday[2][13] = {
-	/* Normal years. */
-	{0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365},
-	/* Leap years. */
-	{0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335, 366}
-};
-
-#define SECS_PER_HOUR	(60 * 60)
-#define SECS_PER_DAY	(SECS_PER_HOUR * 24)
-
-/**
- * time_to_tm - converts the calendar time to local broken-down time
- *
- * @totalsecs	the number of seconds elapsed since 00:00:00 on January 1, 1970,
- *		Coordinated Universal Time (UTC).
- * @offset	offset seconds adding to totalsecs.
- * @result	pointer to struct tm variable to receive broken-down time
- */
-void time_to_tm(time_t totalsecs, int offset, struct tm *result)
-{
-	long days, rem, y;
-	const unsigned short *ip;
-
-	days = totalsecs / SECS_PER_DAY;
-	rem = totalsecs % SECS_PER_DAY;
-	rem += offset;
-	while (rem < 0) {
-		rem += SECS_PER_DAY;
-		--days;
-	}
-	while (rem >= SECS_PER_DAY) {
-		rem -= SECS_PER_DAY;
-		++days;
-	}
-
-	result->tm_hour = rem / SECS_PER_HOUR;
-	rem %= SECS_PER_HOUR;
-	result->tm_min = rem / 60;
-	result->tm_sec = rem % 60;
-
-	/* January 1, 1970 was a Thursday. */
-	result->tm_wday = (4 + days) % 7;
-	if (result->tm_wday < 0)
-		result->tm_wday += 7;
-
-	y = 1970;
-
-	while (days < 0 || days >= (__isleap(y) ? 366 : 365)) {
-		/* Guess a corrected year, assuming 365 days per year. */
-		long yg = y + math_div(days, 365);
-
-		/* Adjust DAYS and Y to match the guessed year. */
-		days -= (yg - y) * 365 + leaps_between(y, yg);
-		y = yg;
-	}
-
-	result->tm_year = y - 1900;
-
-	result->tm_yday = days;
-
-	ip = __mon_yday[__isleap(y)];
-	for (y = 11; days < ip[y]; y--)
-		continue;
-	days -= ip[y];
-
-	result->tm_mon = y;
-	result->tm_mday = days + 1;
-}
-EXPORT_SYMBOL_GPL(time_to_tm);
-/* source: kernel/time/timeconv.c*/
-
diff --git a/backport/compat/compat-2.6.33.c b/backport/compat/compat-2.6.33.c
deleted file mode 100644
index b6115ba..0000000
--- a/backport/compat/compat-2.6.33.c
+++ /dev/null
@@ -1,233 +0,0 @@
-/*
- * Copyright 2009	Hauke Mehrtens <hauke@hauke-m.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Backport functionality introduced in Linux 2.6.33.
- */
-
-#include <linux/compat.h>
-#include <linux/device.h>
-#include <linux/usb.h>
-#include <linux/pm_runtime.h>
-#include <linux/platform_device.h>
-#include <pcmcia/cs_types.h>
-#include <pcmcia/cistpl.h>
-#include <pcmcia/ds.h>
-
-#ifdef CONFIG_USB_SUSPEND
-/**
- * usb_autopm_get_interface_no_resume - increment a USB interface's PM-usage counter
- * @intf: the usb_interface whose counter should be incremented
- *
- * This routine increments @intf's usage counter but does not carry out an
- * autoresume.
- *
- * This routine can run in atomic context.
- */
-void usb_autopm_get_interface_no_resume(struct usb_interface *intf)
-{
-	struct usb_device       *udev = interface_to_usbdev(intf);
-
-	usb_mark_last_busy(udev);
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32))
-	atomic_inc(&intf->pm_usage_cnt);
-#else
-	intf->pm_usage_cnt++;
-#endif
-	pm_runtime_get_noresume(&intf->dev);
-}
-EXPORT_SYMBOL_GPL(usb_autopm_get_interface_no_resume);
-
-/**
- * usb_autopm_put_interface_no_suspend - decrement a USB interface's PM-usage counter
- * @intf: the usb_interface whose counter should be decremented
- *
- * This routine decrements @intf's usage counter but does not carry out an
- * autosuspend.
- *
- * This routine can run in atomic context.
- */
-void usb_autopm_put_interface_no_suspend(struct usb_interface *intf)
-{
-	struct usb_device       *udev = interface_to_usbdev(intf);
-
-	usb_mark_last_busy(udev);
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32))
-	atomic_dec(&intf->pm_usage_cnt);
-#else
-	intf->pm_usage_cnt--;
-#endif
-	pm_runtime_put_noidle(&intf->dev);
-}
-EXPORT_SYMBOL_GPL(usb_autopm_put_interface_no_suspend);
-#endif /* CONFIG_USB_SUSPEND */
-
-#if defined(CONFIG_PCCARD) || defined(CONFIG_PCCARD_MODULE)
-
-/**
- * pccard_loop_tuple() - loop over tuples in the CIS
- * @s:		the struct pcmcia_socket where the card is inserted
- * @function:	the device function we loop for
- * @code:	which CIS code shall we look for?
- * @parse:	buffer where the tuple shall be parsed (or NULL, if no parse)
- * @priv_data:	private data to be passed to the loop_tuple function.
- * @loop_tuple:	function to call for each CIS entry of type @function. IT
- *		gets passed the raw tuple, the paresed tuple (if @parse is
- *		set) and @priv_data.
- *
- * pccard_loop_tuple() loops over all CIS entries of type @function, and
- * calls the @loop_tuple function for each entry. If the call to @loop_tuple
- * returns 0, the loop exits. Returns 0 on success or errorcode otherwise.
- */
-int pccard_loop_tuple(struct pcmcia_socket *s, unsigned int function,
-		      cisdata_t code, cisparse_t *parse, void *priv_data,
-		      int (*loop_tuple) (tuple_t *tuple,
-					 cisparse_t *parse,
-					 void *priv_data))
-{
-	tuple_t tuple;
-	cisdata_t *buf;
-	int ret;
-
-	buf = kzalloc(256, GFP_KERNEL);
-	if (buf == NULL) {
-		dev_printk(KERN_WARNING, &s->dev, "no memory to read tuple\n");
-		return -ENOMEM;
-	}
-
-	tuple.TupleData = buf;
-	tuple.TupleDataMax = 255;
-	tuple.TupleOffset = 0;
-	tuple.DesiredTuple = code;
-	tuple.Attributes = 0;
-
-	ret = pccard_get_first_tuple(s, function, &tuple);
-	while (!ret) {
-		if (pccard_get_tuple_data(s, &tuple))
-			goto next_entry;
-
-		if (parse)
-			if (pcmcia_parse_tuple(&tuple, parse))
-				goto next_entry;
-
-		ret = loop_tuple(&tuple, parse, priv_data);
-		if (!ret)
-			break;
-
-next_entry:
-		ret = pccard_get_next_tuple(s, function, &tuple);
-	}
-
-	kfree(buf);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(pccard_loop_tuple);
-/* Source: drivers/pcmcia/cistpl.c */
-
-#if defined(CONFIG_PCMCIA) || defined(CONFIG_PCMCIA_MODULE)
-
-struct pcmcia_loop_mem {
-	struct pcmcia_device *p_dev;
-	void *priv_data;
-	int (*loop_tuple) (struct pcmcia_device *p_dev,
-			   tuple_t *tuple,
-			   void *priv_data);
-};
-
-/**
- * pcmcia_do_loop_tuple() - internal helper for pcmcia_loop_config()
- *
- * pcmcia_do_loop_tuple() is the internal callback for the call from
- * pcmcia_loop_tuple() to pccard_loop_tuple(). Data is transferred
- * by a struct pcmcia_cfg_mem.
- */
-static int pcmcia_do_loop_tuple(tuple_t *tuple, cisparse_t *parse, void *priv)
-{
-	struct pcmcia_loop_mem *loop = priv;
-
-	return loop->loop_tuple(loop->p_dev, tuple, loop->priv_data);
-};
-
-/**
- * pcmcia_loop_tuple() - loop over tuples in the CIS
- * @p_dev:	the struct pcmcia_device which we need to loop for.
- * @code:	which CIS code shall we look for?
- * @priv_data:	private data to be passed to the loop_tuple function.
- * @loop_tuple:	function to call for each CIS entry of type @function. IT
- *		gets passed the raw tuple and @priv_data.
- *
- * pcmcia_loop_tuple() loops over all CIS entries of type @function, and
- * calls the @loop_tuple function for each entry. If the call to @loop_tuple
- * returns 0, the loop exits. Returns 0 on success or errorcode otherwise.
- */
-int pcmcia_loop_tuple(struct pcmcia_device *p_dev, cisdata_t code,
-		      int (*loop_tuple) (struct pcmcia_device *p_dev,
-					 tuple_t *tuple,
-					 void *priv_data),
-		      void *priv_data)
-{
-	struct pcmcia_loop_mem loop = {
-		.p_dev = p_dev,
-		.loop_tuple = loop_tuple,
-		.priv_data = priv_data};
-
-	return pccard_loop_tuple(p_dev->socket, p_dev->func, code, NULL,
-				 &loop, pcmcia_do_loop_tuple);
-}
-EXPORT_SYMBOL_GPL(pcmcia_loop_tuple);
-/* Source: drivers/pcmcia/pcmcia_resource.c */
-
-#endif /* CONFIG_PCMCIA */
-
-#endif /* CONFIG_PCCARD */
-
-/**
- * platform_device_register_data
- * @parent: parent device for the device we're adding
- * @name: base name of the device we're adding
- * @id: instance id
- * @data: platform specific data for this platform device
- * @size: size of platform specific data
- *
- * This function creates a simple platform device that requires minimal
- * resource and memory management. Canned release function freeing memory
- * allocated for the device allows drivers using such devices to be
- * unloaded without waiting for the last reference to the device to be
- * dropped.
- */
-struct platform_device *platform_device_register_data(
-		struct device *parent,
-		const char *name, int id,
-		const void *data, size_t size)
-{
-	struct platform_device *pdev;
-	int retval;
-
-	pdev = platform_device_alloc(name, id);
-	if (!pdev) {
-		retval = -ENOMEM;
-		goto error;
-	}
-
-	pdev->dev.parent = parent;
-
-	if (size) {
-		retval = platform_device_add_data(pdev, data, size);
-		if (retval)
-			goto error;
-	}
-
-	retval = platform_device_add(pdev);
-	if (retval)
-		goto error;
-
-	return pdev;
-
-error:
-	platform_device_put(pdev);
-	return ERR_PTR(retval);
-}
-EXPORT_SYMBOL_GPL(platform_device_register_data);
diff --git a/backport/compat/compat-2.6.34.c b/backport/compat/compat-2.6.34.c
deleted file mode 100644
index 4ae7f9a..0000000
--- a/backport/compat/compat-2.6.34.c
+++ /dev/null
@@ -1,88 +0,0 @@
-/*
- * Copyright 2012    Luis R. Rodriguez <mcgrof@do-not-panic.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Backport functionality introduced in Linux 2.6.34.
- */
-
-#include <linux/mmc/sdio_func.h>
-#include <linux/seq_file.h>
-#include "compat-2.6.34.h"
-
-static mmc_pm_flag_t backport_mmc_pm_flags;
-
-void backport_init_mmc_pm_flags(void)
-{
-	backport_mmc_pm_flags = 0;
-}
-
-mmc_pm_flag_t sdio_get_host_pm_caps(struct sdio_func *func)
-{
-	return backport_mmc_pm_flags;
-}
-EXPORT_SYMBOL_GPL(sdio_get_host_pm_caps);
-
-int sdio_set_host_pm_flags(struct sdio_func *func, mmc_pm_flag_t flags)
-{
-	return -EINVAL;
-}
-EXPORT_SYMBOL_GPL(sdio_set_host_pm_flags);
-
-/**
- * seq_hlist_start - start an iteration of a hlist
- * @head: the head of the hlist
- * @pos:  the start position of the sequence
- *
- * Called at seq_file->op->start().
- */
-static struct hlist_node *
-seq_hlist_start(struct hlist_head *head, loff_t pos)
-{
-	struct hlist_node *node;
-
-	hlist_for_each(node, head)
-		if (pos-- == 0)
-			return node;
-	return NULL;
-}
-
-/**
- * seq_hlist_start_head - start an iteration of a hlist
- * @head: the head of the hlist
- * @pos:  the start position of the sequence
- *
- * Called at seq_file->op->start(). Call this function if you want to
- * print a header at the top of the output.
- */
-struct hlist_node *seq_hlist_start_head(struct hlist_head *head, loff_t pos)
-{
-	if (!pos)
-		return SEQ_START_TOKEN;
-
-	return seq_hlist_start(head, pos - 1);
-}
-EXPORT_SYMBOL_GPL(seq_hlist_start_head);
-
-/**
- * seq_hlist_next - move to the next position of the hlist
- * @v:    the current iterator
- * @head: the head of the hlist
- * @ppos: the current position
- *
- * Called at seq_file->op->next().
- */
-struct hlist_node *seq_hlist_next(void *v, struct hlist_head *head,
-				  loff_t *ppos)
-{
-	struct hlist_node *node = v;
-
-	++*ppos;
-	if (v == SEQ_START_TOKEN)
-		return head->first;
-	else
-		return node->next;
-}
-EXPORT_SYMBOL_GPL(seq_hlist_next);
diff --git a/backport/compat/compat-2.6.34.h b/backport/compat/compat-2.6.34.h
deleted file mode 100644
index b36b441..0000000
--- a/backport/compat/compat-2.6.34.h
+++ /dev/null
@@ -1,20 +0,0 @@
-#ifndef LINUX_26_34_COMPAT_PRIVATE_H
-#define LINUX_26_34_COMPAT_PRIVATE_H
-
-#include <linux/version.h>
-
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,34))
-
-#include <linux/mmc/sdio_func.h>
-
-void backport_init_mmc_pm_flags(void);
-
-#else /* Kernels >= 2.6.34 */
-
-static inline void backport_init_mmc_pm_flags(void)
-{
-}
-
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,34)) */
-
-#endif /* LINUX_26_34_COMPAT_PRIVATE_H */
diff --git a/backport/compat/compat-2.6.35.c b/backport/compat/compat-2.6.35.c
deleted file mode 100644
index e59cdc1..0000000
--- a/backport/compat/compat-2.6.35.c
+++ /dev/null
@@ -1,117 +0,0 @@
-/*
- * Copyright 2010    Kshitij Kulshreshtha <kkhere.geo@gmail.com>
- * Copyright 2012    Luis R. Rodriguez <mcgrof@do-not-panic.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Backport functionality introduced in Linux 2.6.35.
- */
-
-#include <linux/compat.h>
-#include <linux/ctype.h>
-#include <linux/netdevice.h>
-#include <linux/module.h>
-#include <linux/fs.h>
-#include <linux/uaccess.h>
-#include <net/sch_generic.h>
-
-/*
- * Routine to help set real_num_tx_queues. To avoid skbs mapped to queues
- * greater then real_num_tx_queues stale skbs on the qdisc must be flushed.
- */
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,27))
-int netif_set_real_num_tx_queues(struct net_device *dev, unsigned int txq)
-{
-	unsigned int real_num = dev->real_num_tx_queues;
-
-	if (unlikely(txq > dev->num_tx_queues))
-		return -EINVAL;
-	else if (txq > real_num)
-		dev->real_num_tx_queues = txq;
-	else if (txq < real_num) {
-		dev->real_num_tx_queues = txq;
-		qdisc_reset_all_tx_gt(dev, txq);
-	}
-	return 0;
-}
-#else
-int netif_set_real_num_tx_queues(struct net_device *dev, unsigned int txq)
-{
-	dev->egress_subqueue_count = txq;
-	/* XXX: consider qdisc reset for older kernels */
-	return 0;
-}
-#endif
-EXPORT_SYMBOL_GPL(netif_set_real_num_tx_queues);
-
-/**
- * hex_to_bin - convert a hex digit to its real value
- * @ch: ascii character represents hex digit
- *
- * hex_to_bin() converts one hex digit to its actual value or -1 in case of bad
- * input.
- */
-int hex_to_bin(char ch)
-{
-	if ((ch >= '0') && (ch <= '9'))
-		return ch - '0';
-	ch = tolower(ch);
-	if ((ch >= 'a') && (ch <= 'f'))
-		return ch - 'a' + 10;
-	return -1;
-}
-EXPORT_SYMBOL_GPL(hex_to_bin);
-
-/**
- * noop_llseek - No Operation Performed llseek implementation
- * @file:	file structure to seek on
- * @offset:	file offset to seek to
- * @origin:	type of seek
- *
- * This is an implementation of ->llseek useable for the rare special case when
- * userspace expects the seek to succeed but the (device) file is actually not
- * able to perform the seek. In this case you use noop_llseek() instead of
- * falling back to the default implementation of ->llseek.
- */
-loff_t noop_llseek(struct file *file, loff_t offset, int origin)
-{
-	return file->f_pos;
-}
-EXPORT_SYMBOL_GPL(noop_llseek);
-
-/**
- * simple_write_to_buffer - copy data from user space to the buffer
- * @to: the buffer to write to
- * @available: the size of the buffer
- * @ppos: the current position in the buffer
- * @from: the user space buffer to read from
- * @count: the maximum number of bytes to read
- *
- * The simple_write_to_buffer() function reads up to @count bytes from the user
- * space address starting at @from into the buffer @to at offset @ppos.
- *
- * On success, the number of bytes written is returned and the offset @ppos is
- * advanced by this number, or negative value is returned on error.
- **/
-ssize_t simple_write_to_buffer(void *to, size_t available, loff_t *ppos,
-		const void __user *from, size_t count)
-{
-	loff_t pos = *ppos;
-	size_t res;
-
-	if (pos < 0)
-		return -EINVAL;
-	if (pos >= available || !count)
-		return 0;
-	if (count > available - pos)
-		count = available - pos;
-	res = copy_from_user(to + pos, from, count);
-	if (res == count)
-		return -EFAULT;
-	count -= res;
-	*ppos = pos + count;
-	return count;
-}
-EXPORT_SYMBOL_GPL(simple_write_to_buffer);
diff --git a/backport/compat/compat-2.6.36.c b/backport/compat/compat-2.6.36.c
deleted file mode 100644
index 2c00bc7..0000000
--- a/backport/compat/compat-2.6.36.c
+++ /dev/null
@@ -1,120 +0,0 @@
-/*
- * Copyright 2010    Hauke Mehrtens <hauke@hauke-m.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Backport functionality introduced in Linux 2.6.36.
- */
-
-#include <linux/compat.h>
-#include <linux/usb.h>
-
-#ifdef CPTCFG_BACKPORT_OPTION_USB_URB_THREAD_FIX
-/* Callers must hold anchor->lock */
-static void __usb_unanchor_urb(struct urb *urb, struct usb_anchor *anchor)
-{
-	urb->anchor = NULL;
-	list_del(&urb->anchor_list);
-	usb_put_urb(urb);
-	if (list_empty(&anchor->urb_list))
-		wake_up(&anchor->wait);
-}
-
-/**
- * usb_get_from_anchor - get an anchor's oldest urb
- * @anchor: the anchor whose urb you want
- *
- * this will take the oldest urb from an anchor,
- * unanchor and return it
- */
-struct urb *usb_get_from_anchor(struct usb_anchor *anchor)
-{
-	struct urb *victim;
-	unsigned long flags;
-
-	spin_lock_irqsave(&anchor->lock, flags);
-	if (!list_empty(&anchor->urb_list)) {
-		victim = list_entry(anchor->urb_list.next, struct urb,
-				    anchor_list);
-		usb_get_urb(victim);
-		__usb_unanchor_urb(victim, anchor);
-	} else {
-		victim = NULL;
-	}
-	spin_unlock_irqrestore(&anchor->lock, flags);
-
-	return victim;
-}
-EXPORT_SYMBOL_GPL(usb_get_from_anchor);
-
-/**
- * usb_scuttle_anchored_urbs - unanchor all an anchor's urbs
- * @anchor: the anchor whose urbs you want to unanchor
- *
- * use this to get rid of all an anchor's urbs
- */
-void usb_scuttle_anchored_urbs(struct usb_anchor *anchor)
-{
-	struct urb *victim;
-	unsigned long flags;
-
-	spin_lock_irqsave(&anchor->lock, flags);
-	while (!list_empty(&anchor->urb_list)) {
-		victim = list_entry(anchor->urb_list.prev, struct urb,
-				    anchor_list);
-		__usb_unanchor_urb(victim, anchor);
-	}
-	spin_unlock_irqrestore(&anchor->lock, flags);
-}
-EXPORT_SYMBOL_GPL(usb_scuttle_anchored_urbs);
-
-#endif /* CPTCFG_BACKPORT_OPTION_USB_URB_THREAD_FIX */
-
-struct workqueue_struct *system_wq __read_mostly;
-struct workqueue_struct *system_long_wq __read_mostly;
-struct workqueue_struct *system_nrt_wq __read_mostly;
-EXPORT_SYMBOL_GPL(system_wq);
-EXPORT_SYMBOL_GPL(system_long_wq);
-EXPORT_SYMBOL_GPL(system_nrt_wq);
-
-int schedule_work(struct work_struct *work)
-{
-	return queue_work(system_wq, work);
-}
-EXPORT_SYMBOL_GPL(schedule_work);
-
-int schedule_delayed_work(struct delayed_work *dwork,
-                                 unsigned long delay)
-{
-	return queue_delayed_work(system_wq, dwork, delay);
-}
-EXPORT_SYMBOL_GPL(schedule_delayed_work);
-
-void flush_scheduled_work(void)
-{
-	/*
-	 * It is debatable which one we should prioritize first, lets
-	 * go with the old kernel's one first for now (keventd_wq) and
-	 * if think its reasonable later we can flip this around.
-	 */
-	flush_workqueue(system_wq);
-	flush_scheduled_work();
-}
-EXPORT_SYMBOL_GPL(flush_scheduled_work);
-
-void backport_system_workqueue_create(void)
-{
-	system_wq = alloc_workqueue("events", 0, 0);
-	system_long_wq = alloc_workqueue("events_long", 0, 0);
-	system_nrt_wq = create_singlethread_workqueue("events_nrt");
-	BUG_ON(!system_wq || !system_long_wq || !system_nrt_wq);
-}
-
-void backport_system_workqueue_destroy(void)
-{
-	destroy_workqueue(system_wq);
-	destroy_workqueue(system_long_wq);
-	destroy_workqueue(system_nrt_wq);
-}
diff --git a/backport/compat/compat-2.6.37.c b/backport/compat/compat-2.6.37.c
deleted file mode 100644
index 8d401e1..0000000
--- a/backport/compat/compat-2.6.37.c
+++ /dev/null
@@ -1,269 +0,0 @@
-/*
- * Copyright 2010    Hauke Mehrtens <hauke@hauke-m.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Backport functionality introduced in Linux 2.6.37.
- */
-
-#include <linux/compat.h>
-#include <linux/netdevice.h>
-#include <net/sock.h>
-#include <linux/nsproxy.h>
-#include <linux/vmalloc.h>
-#include <linux/leds.h>
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35)
-static const void *net_current_ns(void)
-{
-	return current->nsproxy->net_ns;
-}
-
-static const void *net_initial_ns(void)
-{
-	return &init_net;
-}
-
-static const void *net_netlink_ns(struct sock *sk)
-{
-	return sock_net(sk);
-}
-
-struct kobj_ns_type_operations net_ns_type_operations = {
-	.type = KOBJ_NS_TYPE_NET,
-	.current_ns = net_current_ns,
-	.netlink_ns = net_netlink_ns,
-	.initial_ns = net_initial_ns,
-};
-EXPORT_SYMBOL_GPL(net_ns_type_operations);
-#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35)*/ 
-
-#if IS_ENABLED(CONFIG_LEDS_CLASS) && !defined(CPTCFG_BACKPORT_BUILD_LEDS)
-
-#undef led_brightness_set
-#undef led_classdev_unregister
-
-static DEFINE_SPINLOCK(led_lock);
-static LIST_HEAD(led_timers);
-
-struct led_timer {
-	struct list_head list;
-	struct led_classdev *cdev;
-	struct timer_list blink_timer;
-	unsigned long blink_delay_on;
-	unsigned long blink_delay_off;
-	int blink_brightness;
-};
-
-static void led_brightness_set(struct led_classdev *led_cdev,
-			       enum led_brightness brightness)
-{
-	led_cdev->brightness = brightness;
-	led_cdev->brightness_set(led_cdev, brightness);
-}
-
-static struct led_timer *led_get_timer(struct led_classdev *led_cdev)
-{
-	struct led_timer *p;
-	unsigned long flags;
-
-	spin_lock_irqsave(&led_lock, flags);
-	list_for_each_entry(p, &led_timers, list) {
-		if (p->cdev == led_cdev)
-			goto found;
-	}
-	p = NULL;
-found:
-	spin_unlock_irqrestore(&led_lock, flags);
-	return p;
-}
-
-static void led_stop_software_blink(struct led_timer *led)
-{
-	del_timer_sync(&led->blink_timer);
-	led->blink_delay_on = 0;
-	led->blink_delay_off = 0;
-}
-
-static void led_timer_function(unsigned long data)
-{
-	struct led_timer *led = (struct led_timer *)data;
-	unsigned long brightness;
-	unsigned long delay;
-
-	if (!led->blink_delay_on || !led->blink_delay_off) {
-		led->cdev->brightness_set(led->cdev, LED_OFF);
-		return;
-	}
-
-	brightness = led->cdev->brightness;
-	if (!brightness) {
-		/* Time to switch the LED on. */
-		brightness = led->blink_brightness;
-		delay = led->blink_delay_on;
-	} else {
-		/* Store the current brightness value to be able
-		 * to restore it when the delay_off period is over.
-		 */
-		led->blink_brightness = brightness;
-		brightness = LED_OFF;
-		delay = led->blink_delay_off;
-	}
-
-	led_brightness_set(led->cdev, brightness);
-	mod_timer(&led->blink_timer, jiffies + msecs_to_jiffies(delay));
-}
-
-static struct led_timer *led_new_timer(struct led_classdev *led_cdev)
-{
-	struct led_timer *led;
-	unsigned long flags;
-
-	led = kzalloc(sizeof(struct led_timer), GFP_ATOMIC);
-	if (!led)
-		return NULL;
-
-	led->cdev = led_cdev;
-	init_timer(&led->blink_timer);
-	led->blink_timer.function = led_timer_function;
-	led->blink_timer.data = (unsigned long) led;
-
-	spin_lock_irqsave(&led_lock, flags);
-	list_add(&led->list, &led_timers);
-	spin_unlock_irqrestore(&led_lock, flags);
-
-	return led;
-}
-
-void led_blink_set(struct led_classdev *led_cdev,
-		   unsigned long *delay_on,
-		   unsigned long *delay_off)
-{
-	struct led_timer *led;
-	int current_brightness;
-
-	if (led_cdev->blink_set &&
-	    !led_cdev->blink_set(led_cdev, delay_on, delay_off))
-		return;
-
-	led = led_get_timer(led_cdev);
-	if (!led) {
-		led = led_new_timer(led_cdev);
-		if (!led)
-			return;
-	}
-
-	/* blink with 1 Hz as default if nothing specified */
-	if (!*delay_on && !*delay_off)
-		*delay_on = *delay_off = 500;
-
-	if (led->blink_delay_on == *delay_on &&
-	    led->blink_delay_off == *delay_off)
-		return;
-
-	current_brightness = led_cdev->brightness;
-	if (current_brightness)
-		led->blink_brightness = current_brightness;
-	if (!led->blink_brightness)
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,30)
-		led->blink_brightness = led_cdev->max_brightness;
-#else
-		led->blink_brightness = LED_FULL;
-#endif
-
-	led_stop_software_blink(led);
-	led->blink_delay_on = *delay_on;
-	led->blink_delay_off = *delay_off;
-
-	/* never on - don't blink */
-	if (!*delay_on)
-		return;
-
-	/* never off - just set to brightness */
-	if (!*delay_off) {
-		led_brightness_set(led_cdev, led->blink_brightness);
-		return;
-	}
-
-	mod_timer(&led->blink_timer, jiffies + 1);
-}
-EXPORT_SYMBOL_GPL(led_blink_set);
-
-void compat_led_brightness_set(struct led_classdev *led_cdev,
-			       enum led_brightness brightness)
-{
-	struct led_timer *led = led_get_timer(led_cdev);
-
-	if (led)
-		led_stop_software_blink(led);
-
-	return led_cdev->brightness_set(led_cdev, brightness);
-}
-EXPORT_SYMBOL_GPL(compat_led_brightness_set);
-
-void compat_led_classdev_unregister(struct led_classdev *led_cdev)
-{
-	struct led_timer *led = led_get_timer(led_cdev);
-	unsigned long flags;
-
-	if (led) {
-		del_timer_sync(&led->blink_timer);
-		spin_lock_irqsave(&led_lock, flags);
-		list_del(&led->list);
-		spin_unlock_irqrestore(&led_lock, flags);
-		kfree(led);
-	}
-
-	led_classdev_unregister(led_cdev);
-}
-EXPORT_SYMBOL_GPL(compat_led_classdev_unregister);
-#endif
-
-/**
- *	vzalloc - allocate virtually contiguous memory with zero fill
- *	@size:	allocation size
- *	Allocate enough pages to cover @size from the page level
- *	allocator and map them into contiguous kernel virtual space.
- *	The memory allocated is set to zero.
- *
- *	For tight control over page level allocator and protection flags
- *	use __vmalloc() instead.
- */
-void *vzalloc(unsigned long size)
-{
-	void *buf;
-	buf = vmalloc(size);
-	if (buf)
-		memset(buf, 0, size);
-	return buf;
-}
-EXPORT_SYMBOL_GPL(vzalloc);
-
-#if (RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(6,4))
-#ifdef CONFIG_RPS
-/**
- *	netif_set_real_num_rx_queues - set actual number of RX queues used
- *	@dev: Network device
- *	@rxq: Actual number of RX queues
- *
- *	This must be called either with the rtnl_lock held or before
- *	registration of the net device.  Returns 0 on success, or a
- *	negative error code.  If called before registration, it always
- *	succeeds.
- */
-int netif_set_real_num_rx_queues(struct net_device *dev, unsigned int rxq)
-{
-	if (rxq < 1 || rxq > dev->num_rx_queues)
-		return -EINVAL;
-
-	/* we can't update the sysfs object for older kernels */
-	if (dev->reg_state == NETREG_REGISTERED)
-		return -EINVAL;
-	dev->num_rx_queues = rxq;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(netif_set_real_num_rx_queues);
-#endif
-#endif
diff --git a/backport/compat/compat-2.6.39.c b/backport/compat/compat-2.6.39.c
deleted file mode 100644
index 44796da..0000000
--- a/backport/compat/compat-2.6.39.c
+++ /dev/null
@@ -1,117 +0,0 @@
-/*
- * Copyright 2011    Hauke Mehrtens <hauke@hauke-m.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Backport functionality introduced in Linux 2.6.39.
- */
-
-#include <linux/compat.h>
-#include <linux/tty.h>
-#include <linux/sched.h>
-#include <linux/module.h>
-
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,27))
-#ifdef CONFIG_TTY
-/*
- *		Termios Helper Methods
- */
-static void unset_locked_termios(struct ktermios *termios,
-				 struct ktermios *old,
-				 struct ktermios *locked)
-{
-	int	i;
-
-#define NOSET_MASK(x, y, z) (x = ((x) & ~(z)) | ((y) & (z)))
-
-	if (!locked) {
-		printk(KERN_WARNING "Warning?!? termios_locked is NULL.\n");
-		return;
-	}
-
-	NOSET_MASK(termios->c_iflag, old->c_iflag, locked->c_iflag);
-	NOSET_MASK(termios->c_oflag, old->c_oflag, locked->c_oflag);
-	NOSET_MASK(termios->c_cflag, old->c_cflag, locked->c_cflag);
-	NOSET_MASK(termios->c_lflag, old->c_lflag, locked->c_lflag);
-	termios->c_line = locked->c_line ? old->c_line : termios->c_line;
-	for (i = 0; i < NCCS; i++)
-		termios->c_cc[i] = locked->c_cc[i] ?
-			old->c_cc[i] : termios->c_cc[i];
-	/* FIXME: What should we do for i/ospeed */
-}
-
-/**
- *	tty_set_termios		-	update termios values
- *	@tty: tty to update
- *	@new_termios: desired new value
- *
- *	Perform updates to the termios values set on this terminal. There
- *	is a bit of layering violation here with n_tty in terms of the
- *	internal knowledge of this function.
- *
- *	Locking: termios_mutex
- */
-int tty_set_termios(struct tty_struct *tty, struct ktermios *new_termios)
-{
-	struct ktermios old_termios;
-	struct tty_ldisc *ld;
-	unsigned long flags;
-
-	/*
-	 *	Perform the actual termios internal changes under lock.
-	 */
-
-
-	/* FIXME: we need to decide on some locking/ordering semantics
-	   for the set_termios notification eventually */
-	mutex_lock(&tty->termios_mutex);
-	old_termios = *tty->termios;
-	*tty->termios = *new_termios;
-	unset_locked_termios(tty->termios, &old_termios, tty->termios_locked);
-
-	/* See if packet mode change of state. */
-	if (tty->link && tty->link->packet) {
-		int extproc = (old_termios.c_lflag & EXTPROC) |
-				(tty->termios->c_lflag & EXTPROC);
-		int old_flow = ((old_termios.c_iflag & IXON) &&
-				(old_termios.c_cc[VSTOP] == '\023') &&
-				(old_termios.c_cc[VSTART] == '\021'));
-		int new_flow = (I_IXON(tty) &&
-				STOP_CHAR(tty) == '\023' &&
-				START_CHAR(tty) == '\021');
-		if ((old_flow != new_flow) || extproc) {
-			spin_lock_irqsave(&tty->ctrl_lock, flags);
-			if (old_flow != new_flow) {
-				tty->ctrl_status &= ~(TIOCPKT_DOSTOP | TIOCPKT_NOSTOP);
-				if (new_flow)
-					tty->ctrl_status |= TIOCPKT_DOSTOP;
-				else
-					tty->ctrl_status |= TIOCPKT_NOSTOP;
-			}
-			if (extproc)
-				tty->ctrl_status |= TIOCPKT_IOCTL;
-			spin_unlock_irqrestore(&tty->ctrl_lock, flags);
-			wake_up_interruptible(&tty->link->read_wait);
-		}
-	}
-
-	if (tty->ops->set_termios)
-		(*tty->ops->set_termios)(tty, &old_termios);
-	else
-		tty_termios_copy_hw(tty->termios, &old_termios);
-
-	ld = tty_ldisc_ref(tty);
-	if (ld != NULL) {
-		if (ld->ops->set_termios)
-			(ld->ops->set_termios)(tty, &old_termios);
-		tty_ldisc_deref(ld);
-	}
-	mutex_unlock(&tty->termios_mutex);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(tty_set_termios);
-#endif /* CONFIG_TTY */
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,27)) */
-
diff --git a/backport/compat/compat_atomic.c b/backport/compat/compat_atomic.c
deleted file mode 100644
index 5ced5a4..0000000
--- a/backport/compat/compat_atomic.c
+++ /dev/null
@@ -1,43 +0,0 @@
-#include <linux/spinlock.h>
-#include <linux/module.h>
-
-#if !((LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,31)) && (defined(CONFIG_UML) || defined(CONFIG_X86))) && !((LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,33)) && defined(CONFIG_ARM) && !defined(CONFIG_GENERIC_ATOMIC64))
-
-static DEFINE_SPINLOCK(lock);
-
-long long atomic64_read(const atomic64_t *v)
-{
-	unsigned long flags;
-	long long val;
-
-	spin_lock_irqsave(&lock, flags);
-	val = v->counter;
-	spin_unlock_irqrestore(&lock, flags);
-	return val;
-}
-EXPORT_SYMBOL_GPL(atomic64_read);
-
-void atomic64_set(atomic64_t *v, long long i)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&lock, flags);
-	v->counter = i;
-	spin_unlock_irqrestore(&lock, flags);
-}
-EXPORT_SYMBOL_GPL(atomic64_set);
-
-long long atomic64_add_return(long long a, atomic64_t *v)
-{
-	unsigned long flags;
-	long long val;
-
-	spin_lock_irqsave(&lock, flags);
-	val = v->counter += a;
-	spin_unlock_irqrestore(&lock, flags);
-	return val;
-}
-EXPORT_SYMBOL_GPL(atomic64_add_return);
-
-#endif
-
diff --git a/backport/compat/compat_firmware_class.c b/backport/compat/compat_firmware_class.c
deleted file mode 100644
index 9ea5080..0000000
--- a/backport/compat/compat_firmware_class.c
+++ /dev/null
@@ -1,759 +0,0 @@
-/*
- * firmware_class.c - Multi purpose firmware loading support
- *
- * Copyright (c) 2003 Manuel Estrada Sainz
- *
- * Please see Documentation/firmware_class/ for more information.
- *
- */
-
-#include <linux/capability.h>
-#include <linux/device.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/timer.h>
-#include <linux/vmalloc.h>
-#include <linux/interrupt.h>
-#include <linux/bitops.h>
-#include <linux/mutex.h>
-#include <linux/kthread.h>
-#include <linux/highmem.h>
-#include <linux/firmware.h>
-#include <linux/slab.h>
-
-#define backport_firmware_to_dev(obj) container_of(obj, struct device, kobj)
-
-MODULE_AUTHOR("Manuel Estrada Sainz");
-MODULE_DESCRIPTION("Multi purpose firmware loading support");
-MODULE_LICENSE("GPL");
-
-/* Builtin firmware support */
-
-//#ifdef CONFIG_FW_LOADER
-#if 0
-
-extern struct builtin_fw __start_builtin_fw[];
-extern struct builtin_fw __end_builtin_fw[];
-
-static bool fw_get_builtin_firmware(struct firmware *fw, const char *name)
-{
-	struct builtin_fw *b_fw;
-
-	for (b_fw = __start_builtin_fw; b_fw != __end_builtin_fw; b_fw++) {
-		if (strcmp(name, b_fw->name) == 0) {
-			fw->size = b_fw->size;
-			fw->data = b_fw->data;
-			return true;
-		}
-	}
-
-	return false;
-}
-
-static bool fw_is_builtin_firmware(const struct firmware *fw)
-{
-	struct builtin_fw *b_fw;
-
-	for (b_fw = __start_builtin_fw; b_fw != __end_builtin_fw; b_fw++)
-		if (fw->data == b_fw->data)
-			return true;
-
-	return false;
-}
-
-#else /* Module case - no builtin firmware support */
-
-static inline bool fw_get_builtin_firmware(struct firmware *fw, const char *name)
-{
-	return false;
-}
-
-static inline bool fw_is_builtin_firmware(const struct firmware *fw)
-{
-	return false;
-}
-#endif
-
-enum {
-	FW_STATUS_LOADING,
-	FW_STATUS_DONE,
-	FW_STATUS_ABORT,
-};
-
-static int loading_timeout = 60;	/* In seconds */
-
-/* fw_lock could be moved to 'struct firmware_priv' but since it is just
- * guarding for corner cases a global lock should be OK */
-static DEFINE_MUTEX(fw_lock);
-
-struct firmware_priv {
-	struct completion completion;
-	struct firmware *fw;
-	unsigned long status;
-	struct page **pages;
-	int nr_pages;
-	int page_array_size;
-	struct timer_list timeout;
-	struct device dev;
-	bool nowait;
-	char fw_id[];
-};
-
-static struct firmware_priv *to_firmware_priv(struct device *dev)
-{
-	return container_of(dev, struct firmware_priv, dev);
-}
-
-static void fw_load_abort(struct firmware_priv *fw_priv)
-{
-	set_bit(FW_STATUS_ABORT, &fw_priv->status);
-	wmb();
-	complete(&fw_priv->completion);
-}
-
-static ssize_t firmware_timeout_show(struct class *class,
-				     char *buf)
-{
-	return sprintf(buf, "%d\n", loading_timeout);
-}
-
-/**
- * firmware_timeout_store - set number of seconds to wait for firmware
- * @class: device class pointer
- * @buf: buffer to scan for timeout value
- * @count: number of bytes in @buf
- *
- *	Sets the number of seconds to wait for the firmware.  Once
- *	this expires an error will be returned to the driver and no
- *	firmware will be provided.
- *
- *	Note: zero means 'wait forever'.
- **/
-static ssize_t firmware_timeout_store(struct class *class,
-				      const char *buf, size_t count)
-{
-	loading_timeout = simple_strtol(buf, NULL, 10);
-	if (loading_timeout < 0)
-		loading_timeout = 0;
-
-	return count;
-}
-
-static struct class_attribute firmware_class_attrs[] = {
-	__ATTR(timeout, S_IWUSR | S_IRUGO,
-		firmware_timeout_show, firmware_timeout_store),
-	__ATTR_NULL
-};
-
-static void fw_dev_release(struct device *dev)
-{
-	struct firmware_priv *fw_priv = to_firmware_priv(dev);
-	int i;
-
-	for (i = 0; i < fw_priv->nr_pages; i++)
-		__free_page(fw_priv->pages[i]);
-	kfree(fw_priv->pages);
-	kfree(fw_priv);
-
-	module_put(THIS_MODULE);
-}
-
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,24))
-static int firmware_uevent(struct device *dev, struct kobj_uevent_env *env)
-{
-	struct firmware_priv *fw_priv = to_firmware_priv(dev);
-
-	if (add_uevent_var(env, "FIRMWARE=%s", fw_priv->fw_id))
-		return -ENOMEM;
-	if (add_uevent_var(env, "TIMEOUT=%i", loading_timeout))
-		return -ENOMEM;
-	if (add_uevent_var(env, "ASYNC=%d", fw_priv->nowait))
-		return -ENOMEM;
-
-	return 0;
-}
-#else
-static int firmware_uevent(struct device *dev, char **envp,
-			   int num_envp, char *buf, int size)
-{
-	struct firmware_priv *fw_priv = to_firmware_priv(dev);
-	int error, len = 0, i = 0;
-
-	error = add_uevent_var(envp, num_envp, &i,
-			       buf, size, &len,
-			       "FIRMWARE=%s", fw_priv->fw_id);
-	if (error)
-		goto exit;
-
-	error = add_uevent_var(envp, num_envp, &i,
-			       buf, size, &len,
-			       "TIMEOUT=%i", loading_timeout);
-	if (error)
-		goto exit;
-	error = add_uevent_var(envp, num_envp, &i,
-			       buf, size, &len,
-			       "ASYNC=%i", fw_priv->nowait);
-	if (error)
-		goto exit;
-
-	return 0;
-exit:
-	envp[i] = NULL;
-	return error;
-}
-#endif
-
-static struct class firmware_class = {
-	.name		= "compat_firmware",
-	.class_attrs	= firmware_class_attrs,
-	.dev_uevent	= firmware_uevent,
-	.dev_release	= fw_dev_release,
-};
-
-static ssize_t firmware_loading_show(struct device *dev,
-				     struct device_attribute *attr, char *buf)
-{
-	struct firmware_priv *fw_priv = to_firmware_priv(dev);
-	int loading = test_bit(FW_STATUS_LOADING, &fw_priv->status);
-
-	return sprintf(buf, "%d\n", loading);
-}
-
-static void firmware_free_data(const struct firmware *fw)
-{
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
-	int i;
-	vunmap(fw->data);
-	if (fw->pages) {
-		for (i = 0; i < PFN_UP(fw->size); i++)
-			__free_page(fw->pages[i]);
-		kfree(fw->pages);
-	}
-#else
-	vunmap(fw->data);
-#endif
-}
-
-/* Some architectures don't have PAGE_KERNEL_RO */
-#ifndef PAGE_KERNEL_RO
-#define PAGE_KERNEL_RO PAGE_KERNEL
-#endif
-/**
- * firmware_loading_store - set value in the 'loading' control file
- * @dev: device pointer
- * @buf: buffer to scan for loading control value
- * @count: number of bytes in @buf
- *
- *	The relevant values are:
- *
- *	 1: Start a load, discarding any previous partial load.
- *	 0: Conclude the load and hand the data to the driver code.
- *	-1: Conclude the load with an error and discard any written data.
- **/
-static ssize_t firmware_loading_store(struct device *dev,
-				      struct device_attribute *attr,
-				      const char *buf, size_t count)
-{
-	struct firmware_priv *fw_priv = to_firmware_priv(dev);
-	int loading = simple_strtol(buf, NULL, 10);
-	int i;
-
-	switch (loading) {
-	case 1:
-		mutex_lock(&fw_lock);
-		if (!fw_priv->fw) {
-			mutex_unlock(&fw_lock);
-			break;
-		}
-		firmware_free_data(fw_priv->fw);
-		memset(fw_priv->fw, 0, sizeof(struct firmware));
-		/* If the pages are not owned by 'struct firmware' */
-		for (i = 0; i < fw_priv->nr_pages; i++)
-			__free_page(fw_priv->pages[i]);
-		kfree(fw_priv->pages);
-		fw_priv->pages = NULL;
-		fw_priv->page_array_size = 0;
-		fw_priv->nr_pages = 0;
-		set_bit(FW_STATUS_LOADING, &fw_priv->status);
-		mutex_unlock(&fw_lock);
-		break;
-	case 0:
-		if (test_bit(FW_STATUS_LOADING, &fw_priv->status)) {
-			vunmap(fw_priv->fw->data);
-			fw_priv->fw->data = vmap(fw_priv->pages,
-						 fw_priv->nr_pages,
-						 0, PAGE_KERNEL_RO);
-			if (!fw_priv->fw->data) {
-				dev_err(dev, "%s: vmap() failed\n", __func__);
-				goto err;
-			}
-			/* Pages are now owned by 'struct firmware' */
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
-			fw_priv->fw->pages = fw_priv->pages;
-			fw_priv->pages = NULL;
-#endif
-
-			fw_priv->page_array_size = 0;
-			fw_priv->nr_pages = 0;
-			complete(&fw_priv->completion);
-			clear_bit(FW_STATUS_LOADING, &fw_priv->status);
-			break;
-		}
-		/* fallthrough */
-	default:
-		dev_err(dev, "%s: unexpected value (%d)\n", __func__, loading);
-		/* fallthrough */
-	case -1:
-	err:
-		fw_load_abort(fw_priv);
-		break;
-	}
-
-	return count;
-}
-
-static DEVICE_ATTR(loading, 0644, firmware_loading_show, firmware_loading_store);
-
-#if defined(CONFIG_COMPAT_FIRMWARE_DATA_RW_NEEDS_FILP)
-static ssize_t firmware_data_read(struct file *filp, struct kobject *kobj,
-				  struct bin_attribute *bin_attr,
-				  char *buffer, loff_t offset, size_t count)
-#else
-static ssize_t firmware_data_read(struct kobject *kobj,
-				  struct bin_attribute *bin_attr,
-				  char *buffer, loff_t offset, size_t count)
-#endif
-{
-	struct device *dev = backport_firmware_to_dev(kobj);
-	struct firmware_priv *fw_priv = to_firmware_priv(dev);
-	struct firmware *fw;
-	ssize_t ret_count;
-
-	mutex_lock(&fw_lock);
-	fw = fw_priv->fw;
-	if (!fw || test_bit(FW_STATUS_DONE, &fw_priv->status)) {
-		ret_count = -ENODEV;
-		goto out;
-	}
-	if (offset > fw->size) {
-		ret_count = 0;
-		goto out;
-	}
-	if (count > fw->size - offset)
-		count = fw->size - offset;
-
-	ret_count = count;
-
-	while (count) {
-		void *page_data;
-		int page_nr = offset >> PAGE_SHIFT;
-		int page_ofs = offset & (PAGE_SIZE-1);
-		int page_cnt = min_t(size_t, PAGE_SIZE - page_ofs, count);
-
-		page_data = kmap(fw_priv->pages[page_nr]);
-
-		memcpy(buffer, page_data + page_ofs, page_cnt);
-
-		kunmap(fw_priv->pages[page_nr]);
-		buffer += page_cnt;
-		offset += page_cnt;
-		count -= page_cnt;
-	}
-out:
-	mutex_unlock(&fw_lock);
-	return ret_count;
-}
-
-static int fw_realloc_buffer(struct firmware_priv *fw_priv, int min_size)
-{
-	int pages_needed = ALIGN(min_size, PAGE_SIZE) >> PAGE_SHIFT;
-
-	/* If the array of pages is too small, grow it... */
-	if (fw_priv->page_array_size < pages_needed) {
-		int new_array_size = max(pages_needed,
-					 fw_priv->page_array_size * 2);
-		struct page **new_pages;
-
-		new_pages = kmalloc(new_array_size * sizeof(void *),
-				    GFP_KERNEL);
-		if (!new_pages) {
-			fw_load_abort(fw_priv);
-			return -ENOMEM;
-		}
-		memcpy(new_pages, fw_priv->pages,
-		       fw_priv->page_array_size * sizeof(void *));
-		memset(&new_pages[fw_priv->page_array_size], 0, sizeof(void *) *
-		       (new_array_size - fw_priv->page_array_size));
-		kfree(fw_priv->pages);
-		fw_priv->pages = new_pages;
-		fw_priv->page_array_size = new_array_size;
-	}
-
-	while (fw_priv->nr_pages < pages_needed) {
-		fw_priv->pages[fw_priv->nr_pages] =
-			alloc_page(GFP_KERNEL | __GFP_HIGHMEM);
-
-		if (!fw_priv->pages[fw_priv->nr_pages]) {
-			fw_load_abort(fw_priv);
-			return -ENOMEM;
-		}
-		fw_priv->nr_pages++;
-	}
-	return 0;
-}
-
-/**
- * firmware_data_write - write method for firmware
- * @kobj: kobject for the device
- * @bin_attr: bin_attr structure
- * @buffer: buffer being written
- * @offset: buffer offset for write in total data store area
- * @count: buffer size
- *
- *	Data written to the 'data' attribute will be later handed to
- *	the driver as a firmware image.
- **/
-#if defined(CONFIG_COMPAT_FIRMWARE_DATA_RW_NEEDS_FILP)
-static ssize_t firmware_data_write(struct file *filp, struct kobject *kobj,
-				   struct bin_attribute *bin_attr,
-				   char *buffer, loff_t offset, size_t count)
-#else
-static ssize_t firmware_data_write(struct kobject *kobj,
-				   struct bin_attribute *bin_attr,
-				   char *buffer, loff_t offset, size_t count)
-#endif
-{
-	struct device *dev = backport_firmware_to_dev(kobj);
-	struct firmware_priv *fw_priv = to_firmware_priv(dev);
-	struct firmware *fw;
-	ssize_t retval;
-
-	if (!capable(CAP_SYS_RAWIO))
-		return -EPERM;
-
-	mutex_lock(&fw_lock);
-	fw = fw_priv->fw;
-	if (!fw || test_bit(FW_STATUS_DONE, &fw_priv->status)) {
-		retval = -ENODEV;
-		goto out;
-	}
-	retval = fw_realloc_buffer(fw_priv, offset + count);
-	if (retval)
-		goto out;
-
-	retval = count;
-
-	while (count) {
-		void *page_data;
-		int page_nr = offset >> PAGE_SHIFT;
-		int page_ofs = offset & (PAGE_SIZE - 1);
-		int page_cnt = min_t(size_t, PAGE_SIZE - page_ofs, count);
-
-		page_data = kmap(fw_priv->pages[page_nr]);
-
-		memcpy(page_data + page_ofs, buffer, page_cnt);
-
-		kunmap(fw_priv->pages[page_nr]);
-		buffer += page_cnt;
-		offset += page_cnt;
-		count -= page_cnt;
-	}
-
-	fw->size = max_t(size_t, offset, fw->size);
-out:
-	mutex_unlock(&fw_lock);
-	return retval;
-}
-
-static struct bin_attribute firmware_attr_data = {
-	.attr = { .name = "data", .mode = 0644 },
-	.size = 0,
-	.read = firmware_data_read,
-	.write = firmware_data_write,
-};
-
-static void firmware_class_timeout(u_long data)
-{
-	struct firmware_priv *fw_priv = (struct firmware_priv *) data;
-
-	fw_load_abort(fw_priv);
-}
-
-static struct firmware_priv *
-fw_create_instance(struct firmware *firmware, const char *fw_name,
-		   struct device *device, bool uevent, bool nowait)
-{
-	struct firmware_priv *fw_priv;
-	struct device *f_dev;
-	int error;
-
-	fw_priv = kzalloc(sizeof(*fw_priv) + strlen(fw_name) + 1 , GFP_KERNEL);
-	if (!fw_priv) {
-		dev_err(device, "%s: kmalloc failed\n", __func__);
-		error = -ENOMEM;
-		goto err_out;
-	}
-
-	fw_priv->fw = firmware;
-	fw_priv->nowait = nowait;
-	strcpy(fw_priv->fw_id, fw_name);
-	init_completion(&fw_priv->completion);
-	setup_timer(&fw_priv->timeout,
-		    firmware_class_timeout, (u_long) fw_priv);
-
-	f_dev = &fw_priv->dev;
-
-	device_initialize(f_dev);
-	dev_set_name(f_dev, "%s", dev_name(device));
-	f_dev->parent = device;
-	f_dev->class = &firmware_class;
-
-	dev_set_uevent_suppress(f_dev, true);
-
-	/* Need to pin this module until class device is destroyed */
-	__module_get(THIS_MODULE);
-
-	error = device_add(f_dev);
-	if (error) {
-		dev_err(device, "%s: device_register failed\n", __func__);
-		goto err_put_dev;
-	}
-
-	error = device_create_bin_file(f_dev, &firmware_attr_data);
-	if (error) {
-		dev_err(device, "%s: sysfs_create_bin_file failed\n", __func__);
-		goto err_del_dev;
-	}
-
-	error = device_create_file(f_dev, &dev_attr_loading);
-	if (error) {
-		dev_err(device, "%s: device_create_file failed\n", __func__);
-		goto err_del_bin_attr;
-	}
-
-	if (uevent)
-		dev_set_uevent_suppress(f_dev, false);
-
-	return fw_priv;
-
-err_del_bin_attr:
-	device_remove_bin_file(f_dev, &firmware_attr_data);
-err_del_dev:
-	device_del(f_dev);
-err_put_dev:
-	put_device(f_dev);
-err_out:
-	return ERR_PTR(error);
-}
-
-static void fw_destroy_instance(struct firmware_priv *fw_priv)
-{
-	struct device *f_dev = &fw_priv->dev;
-
-	device_remove_file(f_dev, &dev_attr_loading);
-	device_remove_bin_file(f_dev, &firmware_attr_data);
-	device_unregister(f_dev);
-}
-
-static int _request_firmware(const struct firmware **firmware_p,
-			     const char *name, struct device *device,
-			     bool uevent, bool nowait)
-{
-	struct firmware_priv *fw_priv;
-	struct firmware *firmware;
-	int retval = 0;
-
-	if (!firmware_p)
-		return -EINVAL;
-
-	*firmware_p = firmware = kzalloc(sizeof(*firmware), GFP_KERNEL);
-	if (!firmware) {
-		dev_err(device, "%s: kmalloc(struct firmware) failed\n",
-			__func__);
-		retval = -ENOMEM;
-		goto out;
-	}
-
-	if (fw_get_builtin_firmware(firmware, name)) {
-		dev_dbg(device, "firmware: using built-in firmware %s\n", name);
-		return 0;
-	}
-
-	if (uevent)
-		dev_dbg(device, "firmware: requesting %s\n", name);
-
-	fw_priv = fw_create_instance(firmware, name, device, uevent, nowait);
-	if (IS_ERR(fw_priv)) {
-		retval = PTR_ERR(fw_priv);
-		goto out;
-	}
-
-	if (uevent) {
-		if (loading_timeout > 0)
-			mod_timer(&fw_priv->timeout,
-				  round_jiffies_up(jiffies +
-						   loading_timeout * HZ));
-
-		kobject_uevent(&fw_priv->dev.kobj, KOBJ_ADD);
-	}
-
-	wait_for_completion(&fw_priv->completion);
-
-	set_bit(FW_STATUS_DONE, &fw_priv->status);
-	del_timer_sync(&fw_priv->timeout);
-
-	mutex_lock(&fw_lock);
-	if (!fw_priv->fw->size || test_bit(FW_STATUS_ABORT, &fw_priv->status))
-		retval = -ENOENT;
-	fw_priv->fw = NULL;
-	mutex_unlock(&fw_lock);
-
-	fw_destroy_instance(fw_priv);
-
-out:
-	if (retval) {
-		release_firmware(firmware);
-		*firmware_p = NULL;
-	}
-
-	return retval;
-}
-
-/**
- * request_firmware: - send firmware request and wait for it
- * @firmware_p: pointer to firmware image
- * @name: name of firmware file
- * @device: device for which firmware is being loaded
- *
- *      @firmware_p will be used to return a firmware image by the name
- *      of @name for device @device.
- *
- *      Should be called from user context where sleeping is allowed.
- *
- *      @name will be used as $FIRMWARE in the uevent environment and
- *      should be distinctive enough not to be confused with any other
- *      firmware image for this or any other device.
- **/
-int
-request_firmware(const struct firmware **firmware_p, const char *name,
-                 struct device *device)
-{
-        int uevent = 1;
-        return _request_firmware(firmware_p, name, device, uevent, false);
-}
-
-/**
- * release_firmware: - release the resource associated with a firmware image
- * @fw: firmware resource to release
- **/
-void release_firmware(const struct firmware *fw)
-{
-	if (fw) {
-		if (!fw_is_builtin_firmware(fw))
-			firmware_free_data(fw);
-		kfree(fw);
-	}
-}
-
-/* Async support */
-struct firmware_work {
-	struct work_struct work;
-	struct module *module;
-	const char *name;
-	struct device *device;
-	void *context;
-	void (*cont)(const struct firmware *fw, void *context);
-	int uevent;
-};
-
-static int request_firmware_work_func(void *arg)
-{
-	struct firmware_work *fw_work = arg;
-	const struct firmware *fw;
-	int ret;
-
-	if (!arg) {
-		WARN_ON(1);
-		return 0;
-	}
-
-	ret = _request_firmware(&fw, fw_work->name, fw_work->device,
-				fw_work->uevent, true);
-	fw_work->cont(fw, fw_work->context);
-
-	module_put(fw_work->module);
-	kfree(fw_work);
-
-	return ret;
-}
-
-/**
- * request_firmware_nowait - asynchronous version of request_firmware
- * @module: module requesting the firmware
- * @uevent: sends uevent to copy the firmware image if this flag
- *	is non-zero else the firmware copy must be done manually.
- * @name: name of firmware file
- * @device: device for which firmware is being loaded
- * @gfp: allocation flags
- * @context: will be passed over to @cont, and
- *	@fw may be %NULL if firmware request fails.
- * @cont: function will be called asynchronously when the firmware
- *	request is over.
- *
- *	Asynchronous variant of request_firmware() for user contexts where
- *	it is not possible to sleep for long time. It can't be called
- *	in atomic contexts.
- **/
-int
-request_firmware_nowait(
-	struct module *module, int uevent,
-	const char *name, struct device *device, gfp_t gfp, void *context,
-	void (*cont)(const struct firmware *fw, void *context))
-{
-	struct task_struct *task;
-	struct firmware_work *fw_work;
-
-	fw_work = kzalloc(sizeof (struct firmware_work), gfp);
-	if (!fw_work)
-		return -ENOMEM;
-
-	fw_work->module = module;
-	fw_work->name = name;
-	fw_work->device = device;
-	fw_work->context = context;
-	fw_work->cont = cont;
-	fw_work->uevent = uevent;
-
-	if (!try_module_get(module)) {
-		kfree(fw_work);
-		return -EFAULT;
-	}
-
-	task = kthread_run(request_firmware_work_func, fw_work,
-			    "firmware/%s", name);
-	if (IS_ERR(task)) {
-		fw_work->cont(NULL, fw_work->context);
-		module_put(fw_work->module);
-		kfree(fw_work);
-		return PTR_ERR(task);
-	}
-
-	return 0;
-}
-
-static int __init firmware_class_init(void)
-{
-	return class_register(&firmware_class);
-}
-
-static void __exit firmware_class_exit(void)
-{
-	class_unregister(&firmware_class);
-}
-
-fs_initcall(firmware_class_init);
-module_exit(firmware_class_exit);
-
-EXPORT_SYMBOL_GPL(release_firmware);
-EXPORT_SYMBOL_GPL(request_firmware);
-EXPORT_SYMBOL_GPL(request_firmware_nowait);
diff --git a/backport/compat/kfifo.c b/backport/compat/kfifo.c
deleted file mode 100644
index 3c2520f..0000000
--- a/backport/compat/kfifo.c
+++ /dev/null
@@ -1,607 +0,0 @@
-/*
- * A generic kernel FIFO implementation
- *
- * Copyright (C) 2009/2010 Stefani Seibold <stefani@seibold.net>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/export.h>
-#include <linux/slab.h>
-#include <linux/err.h>
-#include <linux/log2.h>
-#include <linux/uaccess.h>
-#include <linux/kfifo.h>
-
-/*
- * internal helper to calculate the unused elements in a fifo
- */
-static inline unsigned int kfifo_unused(struct __kfifo *fifo)
-{
-	return (fifo->mask + 1) - (fifo->in - fifo->out);
-}
-
-int __kfifo_alloc(struct __kfifo *fifo, unsigned int size,
-		size_t esize, gfp_t gfp_mask)
-{
-	/*
-	 * round down to the next power of 2, since our 'let the indices
-	 * wrap' technique works only in this case.
-	 */
-	size = roundup_pow_of_two(size);
-
-	fifo->in = 0;
-	fifo->out = 0;
-	fifo->esize = esize;
-
-	if (size < 2) {
-		fifo->data = NULL;
-		fifo->mask = 0;
-		return -EINVAL;
-	}
-
-	fifo->data = kmalloc(size * esize, gfp_mask);
-
-	if (!fifo->data) {
-		fifo->mask = 0;
-		return -ENOMEM;
-	}
-	fifo->mask = size - 1;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(__kfifo_alloc);
-
-void __kfifo_free(struct __kfifo *fifo)
-{
-	kfree(fifo->data);
-	fifo->in = 0;
-	fifo->out = 0;
-	fifo->esize = 0;
-	fifo->data = NULL;
-	fifo->mask = 0;
-}
-EXPORT_SYMBOL_GPL(__kfifo_free);
-
-int __kfifo_init(struct __kfifo *fifo, void *buffer,
-		unsigned int size, size_t esize)
-{
-	size /= esize;
-
-	size = roundup_pow_of_two(size);
-
-	fifo->in = 0;
-	fifo->out = 0;
-	fifo->esize = esize;
-	fifo->data = buffer;
-
-	if (size < 2) {
-		fifo->mask = 0;
-		return -EINVAL;
-	}
-	fifo->mask = size - 1;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(__kfifo_init);
-
-static void kfifo_copy_in(struct __kfifo *fifo, const void *src,
-		unsigned int len, unsigned int off)
-{
-	unsigned int size = fifo->mask + 1;
-	unsigned int esize = fifo->esize;
-	unsigned int l;
-
-	off &= fifo->mask;
-	if (esize != 1) {
-		off *= esize;
-		size *= esize;
-		len *= esize;
-	}
-	l = min(len, size - off);
-
-	memcpy(fifo->data + off, src, l);
-	memcpy(fifo->data, src + l, len - l);
-	/*
-	 * make sure that the data in the fifo is up to date before
-	 * incrementing the fifo->in index counter
-	 */
-	smp_wmb();
-}
-
-unsigned int __kfifo_in(struct __kfifo *fifo,
-		const void *buf, unsigned int len)
-{
-	unsigned int l;
-
-	l = kfifo_unused(fifo);
-	if (len > l)
-		len = l;
-
-	kfifo_copy_in(fifo, buf, len, fifo->in);
-	fifo->in += len;
-	return len;
-}
-EXPORT_SYMBOL_GPL(__kfifo_in);
-
-static void kfifo_copy_out(struct __kfifo *fifo, void *dst,
-		unsigned int len, unsigned int off)
-{
-	unsigned int size = fifo->mask + 1;
-	unsigned int esize = fifo->esize;
-	unsigned int l;
-
-	off &= fifo->mask;
-	if (esize != 1) {
-		off *= esize;
-		size *= esize;
-		len *= esize;
-	}
-	l = min(len, size - off);
-
-	memcpy(dst, fifo->data + off, l);
-	memcpy(dst + l, fifo->data, len - l);
-	/*
-	 * make sure that the data is copied before
-	 * incrementing the fifo->out index counter
-	 */
-	smp_wmb();
-}
-
-unsigned int __kfifo_out_peek(struct __kfifo *fifo,
-		void *buf, unsigned int len)
-{
-	unsigned int l;
-
-	l = fifo->in - fifo->out;
-	if (len > l)
-		len = l;
-
-	kfifo_copy_out(fifo, buf, len, fifo->out);
-	return len;
-}
-EXPORT_SYMBOL_GPL(__kfifo_out_peek);
-
-unsigned int __kfifo_out(struct __kfifo *fifo,
-		void *buf, unsigned int len)
-{
-	len = __kfifo_out_peek(fifo, buf, len);
-	fifo->out += len;
-	return len;
-}
-EXPORT_SYMBOL_GPL(__kfifo_out);
-
-static unsigned long kfifo_copy_from_user(struct __kfifo *fifo,
-	const void __user *from, unsigned int len, unsigned int off,
-	unsigned int *copied)
-{
-	unsigned int size = fifo->mask + 1;
-	unsigned int esize = fifo->esize;
-	unsigned int l;
-	unsigned long ret;
-
-	off &= fifo->mask;
-	if (esize != 1) {
-		off *= esize;
-		size *= esize;
-		len *= esize;
-	}
-	l = min(len, size - off);
-
-	ret = copy_from_user(fifo->data + off, from, l);
-	if (unlikely(ret))
-		ret = DIV_ROUND_UP(ret + len - l, esize);
-	else {
-		ret = copy_from_user(fifo->data, from + l, len - l);
-		if (unlikely(ret))
-			ret = DIV_ROUND_UP(ret, esize);
-	}
-	/*
-	 * make sure that the data in the fifo is up to date before
-	 * incrementing the fifo->in index counter
-	 */
-	smp_wmb();
-	*copied = len - ret * esize;
-	/* return the number of elements which are not copied */
-	return ret;
-}
-
-int __kfifo_from_user(struct __kfifo *fifo, const void __user *from,
-		unsigned long len, unsigned int *copied)
-{
-	unsigned int l;
-	unsigned long ret;
-	unsigned int esize = fifo->esize;
-	int err;
-
-	if (esize != 1)
-		len /= esize;
-
-	l = kfifo_unused(fifo);
-	if (len > l)
-		len = l;
-
-	ret = kfifo_copy_from_user(fifo, from, len, fifo->in, copied);
-	if (unlikely(ret)) {
-		len -= ret;
-		err = -EFAULT;
-	} else
-		err = 0;
-	fifo->in += len;
-	return err;
-}
-EXPORT_SYMBOL_GPL(__kfifo_from_user);
-
-static unsigned long kfifo_copy_to_user(struct __kfifo *fifo, void __user *to,
-		unsigned int len, unsigned int off, unsigned int *copied)
-{
-	unsigned int l;
-	unsigned long ret;
-	unsigned int size = fifo->mask + 1;
-	unsigned int esize = fifo->esize;
-
-	off &= fifo->mask;
-	if (esize != 1) {
-		off *= esize;
-		size *= esize;
-		len *= esize;
-	}
-	l = min(len, size - off);
-
-	ret = copy_to_user(to, fifo->data + off, l);
-	if (unlikely(ret))
-		ret = DIV_ROUND_UP(ret + len - l, esize);
-	else {
-		ret = copy_to_user(to + l, fifo->data, len - l);
-		if (unlikely(ret))
-			ret = DIV_ROUND_UP(ret, esize);
-	}
-	/*
-	 * make sure that the data is copied before
-	 * incrementing the fifo->out index counter
-	 */
-	smp_wmb();
-	*copied = len - ret * esize;
-	/* return the number of elements which are not copied */
-	return ret;
-}
-
-int __kfifo_to_user(struct __kfifo *fifo, void __user *to,
-		unsigned long len, unsigned int *copied)
-{
-	unsigned int l;
-	unsigned long ret;
-	unsigned int esize = fifo->esize;
-	int err;
-
-	if (esize != 1)
-		len /= esize;
-
-	l = fifo->in - fifo->out;
-	if (len > l)
-		len = l;
-	ret = kfifo_copy_to_user(fifo, to, len, fifo->out, copied);
-	if (unlikely(ret)) {
-		len -= ret;
-		err = -EFAULT;
-	} else
-		err = 0;
-	fifo->out += len;
-	return err;
-}
-EXPORT_SYMBOL_GPL(__kfifo_to_user);
-
-static int setup_sgl_buf(struct scatterlist *sgl, void *buf,
-		int nents, unsigned int len)
-{
-	int n;
-	unsigned int l;
-	unsigned int off;
-	struct page *page;
-
-	if (!nents)
-		return 0;
-
-	if (!len)
-		return 0;
-
-	n = 0;
-	page = virt_to_page(buf);
-	off = offset_in_page(buf);
-	l = 0;
-
-	while (len >= l + PAGE_SIZE - off) {
-		struct page *npage;
-
-		l += PAGE_SIZE;
-		buf += PAGE_SIZE;
-		npage = virt_to_page(buf);
-		if (page_to_phys(page) != page_to_phys(npage) - l) {
-			sg_set_page(sgl, page, l - off, off);
-			sgl = sg_next(sgl);
-			if (++n == nents || sgl == NULL)
-				return n;
-			page = npage;
-			len -= l - off;
-			l = off = 0;
-		}
-	}
-	sg_set_page(sgl, page, len, off);
-	return n + 1;
-}
-
-static unsigned int setup_sgl(struct __kfifo *fifo, struct scatterlist *sgl,
-		int nents, unsigned int len, unsigned int off)
-{
-	unsigned int size = fifo->mask + 1;
-	unsigned int esize = fifo->esize;
-	unsigned int l;
-	unsigned int n;
-
-	off &= fifo->mask;
-	if (esize != 1) {
-		off *= esize;
-		size *= esize;
-		len *= esize;
-	}
-	l = min(len, size - off);
-
-	n = setup_sgl_buf(sgl, fifo->data + off, nents, l);
-	n += setup_sgl_buf(sgl + n, fifo->data, nents - n, len - l);
-
-	return n;
-}
-
-unsigned int __kfifo_dma_in_prepare(struct __kfifo *fifo,
-		struct scatterlist *sgl, int nents, unsigned int len)
-{
-	unsigned int l;
-
-	l = kfifo_unused(fifo);
-	if (len > l)
-		len = l;
-
-	return setup_sgl(fifo, sgl, nents, len, fifo->in);
-}
-EXPORT_SYMBOL_GPL(__kfifo_dma_in_prepare);
-
-unsigned int __kfifo_dma_out_prepare(struct __kfifo *fifo,
-		struct scatterlist *sgl, int nents, unsigned int len)
-{
-	unsigned int l;
-
-	l = fifo->in - fifo->out;
-	if (len > l)
-		len = l;
-
-	return setup_sgl(fifo, sgl, nents, len, fifo->out);
-}
-EXPORT_SYMBOL_GPL(__kfifo_dma_out_prepare);
-
-unsigned int __kfifo_max_r(unsigned int len, size_t recsize)
-{
-	unsigned int max = (1 << (recsize << 3)) - 1;
-
-	if (len > max)
-		return max;
-	return len;
-}
-EXPORT_SYMBOL_GPL(__kfifo_max_r);
-
-#define	__KFIFO_PEEK(data, out, mask) \
-	((data)[(out) & (mask)])
-/*
- * __kfifo_peek_n internal helper function for determinate the length of
- * the next record in the fifo
- */
-static unsigned int __kfifo_peek_n(struct __kfifo *fifo, size_t recsize)
-{
-	unsigned int l;
-	unsigned int mask = fifo->mask;
-	unsigned char *data = fifo->data;
-
-	l = __KFIFO_PEEK(data, fifo->out, mask);
-
-	if (--recsize)
-		l |= __KFIFO_PEEK(data, fifo->out + 1, mask) << 8;
-
-	return l;
-}
-
-#define	__KFIFO_POKE(data, in, mask, val) \
-	( \
-	(data)[(in) & (mask)] = (unsigned char)(val) \
-	)
-
-/*
- * __kfifo_poke_n internal helper function for storeing the length of
- * the record into the fifo
- */
-static void __kfifo_poke_n(struct __kfifo *fifo, unsigned int n, size_t recsize)
-{
-	unsigned int mask = fifo->mask;
-	unsigned char *data = fifo->data;
-
-	__KFIFO_POKE(data, fifo->in, mask, n);
-
-	if (recsize > 1)
-		__KFIFO_POKE(data, fifo->in + 1, mask, n >> 8);
-}
-
-unsigned int __kfifo_len_r(struct __kfifo *fifo, size_t recsize)
-{
-	return __kfifo_peek_n(fifo, recsize);
-}
-EXPORT_SYMBOL_GPL(__kfifo_len_r);
-
-unsigned int __kfifo_in_r(struct __kfifo *fifo, const void *buf,
-		unsigned int len, size_t recsize)
-{
-	if (len + recsize > kfifo_unused(fifo))
-		return 0;
-
-	__kfifo_poke_n(fifo, len, recsize);
-
-	kfifo_copy_in(fifo, buf, len, fifo->in + recsize);
-	fifo->in += len + recsize;
-	return len;
-}
-EXPORT_SYMBOL_GPL(__kfifo_in_r);
-
-static unsigned int kfifo_out_copy_r(struct __kfifo *fifo,
-	void *buf, unsigned int len, size_t recsize, unsigned int *n)
-{
-	*n = __kfifo_peek_n(fifo, recsize);
-
-	if (len > *n)
-		len = *n;
-
-	kfifo_copy_out(fifo, buf, len, fifo->out + recsize);
-	return len;
-}
-
-unsigned int __kfifo_out_peek_r(struct __kfifo *fifo, void *buf,
-		unsigned int len, size_t recsize)
-{
-	unsigned int n;
-
-	if (fifo->in == fifo->out)
-		return 0;
-
-	return kfifo_out_copy_r(fifo, buf, len, recsize, &n);
-}
-EXPORT_SYMBOL_GPL(__kfifo_out_peek_r);
-
-unsigned int __kfifo_out_r(struct __kfifo *fifo, void *buf,
-		unsigned int len, size_t recsize)
-{
-	unsigned int n;
-
-	if (fifo->in == fifo->out)
-		return 0;
-
-	len = kfifo_out_copy_r(fifo, buf, len, recsize, &n);
-	fifo->out += n + recsize;
-	return len;
-}
-EXPORT_SYMBOL_GPL(__kfifo_out_r);
-
-void __kfifo_skip_r(struct __kfifo *fifo, size_t recsize)
-{
-	unsigned int n;
-
-	n = __kfifo_peek_n(fifo, recsize);
-	fifo->out += n + recsize;
-}
-EXPORT_SYMBOL_GPL(__kfifo_skip_r);
-
-int __kfifo_from_user_r(struct __kfifo *fifo, const void __user *from,
-	unsigned long len, unsigned int *copied, size_t recsize)
-{
-	unsigned long ret;
-
-	len = __kfifo_max_r(len, recsize);
-
-	if (len + recsize > kfifo_unused(fifo)) {
-		*copied = 0;
-		return 0;
-	}
-
-	__kfifo_poke_n(fifo, len, recsize);
-
-	ret = kfifo_copy_from_user(fifo, from, len, fifo->in + recsize, copied);
-	if (unlikely(ret)) {
-		*copied = 0;
-		return -EFAULT;
-	}
-	fifo->in += len + recsize;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(__kfifo_from_user_r);
-
-int __kfifo_to_user_r(struct __kfifo *fifo, void __user *to,
-	unsigned long len, unsigned int *copied, size_t recsize)
-{
-	unsigned long ret;
-	unsigned int n;
-
-	if (fifo->in == fifo->out) {
-		*copied = 0;
-		return 0;
-	}
-
-	n = __kfifo_peek_n(fifo, recsize);
-	if (len > n)
-		len = n;
-
-	ret = kfifo_copy_to_user(fifo, to, len, fifo->out + recsize, copied);
-	if (unlikely(ret)) {
-		*copied = 0;
-		return -EFAULT;
-	}
-	fifo->out += n + recsize;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(__kfifo_to_user_r);
-
-unsigned int __kfifo_dma_in_prepare_r(struct __kfifo *fifo,
-	struct scatterlist *sgl, int nents, unsigned int len, size_t recsize)
-{
-	if (!nents)
-		BUG();
-
-	len = __kfifo_max_r(len, recsize);
-
-	if (len + recsize > kfifo_unused(fifo))
-		return 0;
-
-	return setup_sgl(fifo, sgl, nents, len, fifo->in + recsize);
-}
-EXPORT_SYMBOL_GPL(__kfifo_dma_in_prepare_r);
-
-void __kfifo_dma_in_finish_r(struct __kfifo *fifo,
-	unsigned int len, size_t recsize)
-{
-	len = __kfifo_max_r(len, recsize);
-	__kfifo_poke_n(fifo, len, recsize);
-	fifo->in += len + recsize;
-}
-EXPORT_SYMBOL_GPL(__kfifo_dma_in_finish_r);
-
-unsigned int __kfifo_dma_out_prepare_r(struct __kfifo *fifo,
-	struct scatterlist *sgl, int nents, unsigned int len, size_t recsize)
-{
-	if (!nents)
-		BUG();
-
-	len = __kfifo_max_r(len, recsize);
-
-	if (len + recsize > fifo->in - fifo->out)
-		return 0;
-
-	return setup_sgl(fifo, sgl, nents, len, fifo->out + recsize);
-}
-EXPORT_SYMBOL_GPL(__kfifo_dma_out_prepare_r);
-
-void __kfifo_dma_out_finish_r(struct __kfifo *fifo, size_t recsize)
-{
-	unsigned int len;
-
-	len = __kfifo_peek_n(fifo, recsize);
-	fifo->out += len + recsize;
-}
-EXPORT_SYMBOL_GPL(__kfifo_dma_out_finish_r);
diff --git a/backport/compat/kstrtox.c b/backport/compat/kstrtox.c
deleted file mode 100644
index aaaea24..0000000
--- a/backport/compat/kstrtox.c
+++ /dev/null
@@ -1,237 +0,0 @@
-/*
- * Convert integer string representation to an integer.
- * If an integer doesn't fit into specified type, -E is returned.
- *
- * Integer starts with optional sign.
- * kstrtou*() functions do not accept sign "-".
- *
- * Radix 0 means autodetection: leading "0x" implies radix 16,
- * leading "0" implies radix 8, otherwise radix is 10.
- * Autodetection hints work after optional sign, but not before.
- *
- * If -E is returned, result is not touched.
- */
-#include <linux/kernel.h>
-/* 
- * kstrto* was included in kernel 2.6.38.4 and causes conflicts with the
- * version included in compat-drivers. We use strict_strtol to check if
- * kstrto* is already available.
- */
-#ifndef strict_strtoll
-
-#include <linux/ctype.h>
-#include <linux/errno.h>
-#include <linux/kernel.h>
-#include <linux/math64.h>
-#include <linux/module.h>
-#include <linux/types.h>
-
-#define _tolower LINUX_BACKPORT(_tolower)
-static inline char _tolower(const char c)
-{
-	return c | 0x20;
-}
-
-static int _kstrtoull(const char *s, unsigned int base, unsigned long long *res)
-{
-	unsigned long long acc;
-	int ok;
-
-	if (base == 0) {
-		if (s[0] == '0') {
-			if (_tolower(s[1]) == 'x' && isxdigit(s[2]))
-				base = 16;
-			else
-				base = 8;
-		} else
-			base = 10;
-	}
-	if (base == 16 && s[0] == '0' && _tolower(s[1]) == 'x')
-		s += 2;
-
-	acc = 0;
-	ok = 0;
-	while (*s) {
-		unsigned int val;
-
-		if ('0' <= *s && *s <= '9')
-			val = *s - '0';
-		else if ('a' <= _tolower(*s) && _tolower(*s) <= 'f')
-			val = _tolower(*s) - 'a' + 10;
-		else if (*s == '\n') {
-			if (*(s + 1) == '\0')
-				break;
-			else
-				return -EINVAL;
-		} else
-			return -EINVAL;
-
-		if (val >= base)
-			return -EINVAL;
-		if (acc > div_u64(ULLONG_MAX - val, base))
-			return -ERANGE;
-		acc = acc * base + val;
-		ok = 1;
-
-		s++;
-	}
-	if (!ok)
-		return -EINVAL;
-	*res = acc;
-	return 0;
-}
-
-int kstrtoull(const char *s, unsigned int base, unsigned long long *res)
-{
-	if (s[0] == '+')
-		s++;
-	return _kstrtoull(s, base, res);
-}
-EXPORT_SYMBOL_GPL(kstrtoull);
-
-int kstrtoll(const char *s, unsigned int base, long long *res)
-{
-	unsigned long long tmp;
-	int rv;
-
-	if (s[0] == '-') {
-		rv = _kstrtoull(s + 1, base, &tmp);
-		if (rv < 0)
-			return rv;
-		if ((long long)(-tmp) >= 0)
-			return -ERANGE;
-		*res = -tmp;
-	} else {
-		rv = kstrtoull(s, base, &tmp);
-		if (rv < 0)
-			return rv;
-		if ((long long)tmp < 0)
-			return -ERANGE;
-		*res = tmp;
-	}
-	return 0;
-}
-EXPORT_SYMBOL_GPL(kstrtoll);
-
-/* Internal, do not use. */
-int _kstrtoul(const char *s, unsigned int base, unsigned long *res)
-{
-	unsigned long long tmp;
-	int rv;
-
-	rv = kstrtoull(s, base, &tmp);
-	if (rv < 0)
-		return rv;
-	if (tmp != (unsigned long long)(unsigned long)tmp)
-		return -ERANGE;
-	*res = tmp;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(_kstrtoul);
-
-/* Internal, do not use. */
-int _kstrtol(const char *s, unsigned int base, long *res)
-{
-	long long tmp;
-	int rv;
-
-	rv = kstrtoll(s, base, &tmp);
-	if (rv < 0)
-		return rv;
-	if (tmp != (long long)(long)tmp)
-		return -ERANGE;
-	*res = tmp;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(_kstrtol);
-
-int kstrtouint(const char *s, unsigned int base, unsigned int *res)
-{
-	unsigned long long tmp;
-	int rv;
-
-	rv = kstrtoull(s, base, &tmp);
-	if (rv < 0)
-		return rv;
-	if (tmp != (unsigned long long)(unsigned int)tmp)
-		return -ERANGE;
-	*res = tmp;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(kstrtouint);
-
-int kstrtoint(const char *s, unsigned int base, int *res)
-{
-	long long tmp;
-	int rv;
-
-	rv = kstrtoll(s, base, &tmp);
-	if (rv < 0)
-		return rv;
-	if (tmp != (long long)(int)tmp)
-		return -ERANGE;
-	*res = tmp;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(kstrtoint);
-
-int kstrtou16(const char *s, unsigned int base, u16 *res)
-{
-	unsigned long long tmp;
-	int rv;
-
-	rv = kstrtoull(s, base, &tmp);
-	if (rv < 0)
-		return rv;
-	if (tmp != (unsigned long long)(u16)tmp)
-		return -ERANGE;
-	*res = tmp;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(kstrtou16);
-
-int kstrtos16(const char *s, unsigned int base, s16 *res)
-{
-	long long tmp;
-	int rv;
-
-	rv = kstrtoll(s, base, &tmp);
-	if (rv < 0)
-		return rv;
-	if (tmp != (long long)(s16)tmp)
-		return -ERANGE;
-	*res = tmp;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(kstrtos16);
-
-int kstrtou8(const char *s, unsigned int base, u8 *res)
-{
-	unsigned long long tmp;
-	int rv;
-
-	rv = kstrtoull(s, base, &tmp);
-	if (rv < 0)
-		return rv;
-	if (tmp != (unsigned long long)(u8)tmp)
-		return -ERANGE;
-	*res = tmp;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(kstrtou8);
-
-int kstrtos8(const char *s, unsigned int base, s8 *res)
-{
-	long long tmp;
-	int rv;
-
-	rv = kstrtoll(s, base, &tmp);
-	if (rv < 0)
-		return rv;
-	if (tmp != (long long)(s8)tmp)
-		return -ERANGE;
-	*res = tmp;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(kstrtos8);
-#endif /* #ifndef strict_strtol */
diff --git a/backport/compat/main.c b/backport/compat/main.c
index 07efc8c..b3d7661 100644
--- a/backport/compat/main.c
+++ b/backport/compat/main.c
@@ -2,7 +2,6 @@
 #include <linux/init.h>
 #include <linux/pm_qos.h>
 #include <linux/workqueue.h>
-#include "compat-2.6.34.h"
 #include "backports.h"
 
 MODULE_AUTHOR("Luis R. Rodriguez");
@@ -58,8 +57,6 @@ static int __init backport_init(void)
 	if (ret)
 		return ret;
 
-	backport_system_workqueue_create();
-	backport_init_mmc_pm_flags();
 	dma_buf_init();
 
 	printk(KERN_INFO "Loading modules backported from " BACKPORTED_KERNEL_NAME
@@ -79,7 +76,6 @@ subsys_initcall(backport_init);
 
 static void __exit backport_exit(void)
 {
-	backport_system_workqueue_destroy();
 	crypto_ccm_module_exit();
 }
 module_exit(backport_exit);
diff --git a/backport/scripts/backport_firmware_install.sh b/backport/scripts/backport_firmware_install.sh
deleted file mode 100755
index 5a82947..0000000
--- a/backport/scripts/backport_firmware_install.sh
+++ /dev/null
@@ -1,21 +0,0 @@
-#!/bin/sh
-
-if [ -f /usr/bin/lsb_release ]; then
-	LSB_RED_ID=$(/usr/bin/lsb_release -i -s)
-else
-	LSB_RED_ID="Unknown"
-fi
-
-case $LSB_RED_ID in
-"Ubuntu")
-	mkdir -p /lib/udev/ /etc/udev/rules.d/
-	cp udev/ubuntu/compat_firmware.sh /lib/udev/
-	cp udev/50-compat_firmware.rules /etc/udev/rules.d/
-        ;;
-*)
-	mkdir -p /lib/udev/ /lib/udev/rules.d/
-	cp udev/compat_firmware.sh /lib/udev/
-	cp udev/50-compat_firmware.rules /lib/udev/rules.d/
-        ;;
-esac
-
diff --git a/backport/udev/50-compat_firmware.rules b/backport/udev/50-compat_firmware.rules
deleted file mode 100644
index 6473788..0000000
--- a/backport/udev/50-compat_firmware.rules
+++ /dev/null
@@ -1,4 +0,0 @@
-# do not edit this file, it will be overwritten on update
-
-# compat_firmware-class requests, copies files into the kernel
-SUBSYSTEM=="compat_firmware", ACTION=="add", RUN+="compat_firmware.sh"
diff --git a/backport/udev/compat_firmware.sh b/backport/udev/compat_firmware.sh
deleted file mode 100755
index ef609e7..0000000
--- a/backport/udev/compat_firmware.sh
+++ /dev/null
@@ -1,35 +0,0 @@
-#!/bin/sh -e
-
-# This is ported from Ubuntu but ubuntu uses these directories which
-# other distributions don't care about:
-# FIRMWARE_DIRS="/lib/firmware/updates/$(uname -r) /lib/firmware/updates \
-#               /lib/firmware/$(uname -r) /lib/firmware"
-# If your distribution looks for firmware in other directories
-# feel free to extend this and add your own directory here.
-#
-FIRMWARE_DIRS="/lib/firmware"
-
-err() {
-	echo "$@" >&2
-	logger -t "${0##*/}[$$]" "$@" 2>/dev/null || true
-}
-
-if [ ! -e /sys$DEVPATH/loading ]; then
-	err "udev firmware loader misses sysfs directory"
-	exit 1
-fi
-
-for DIR in $FIRMWARE_DIRS; do
-	[ -e "$DIR/$FIRMWARE" ] || continue
-	echo 1 > /sys$DEVPATH/loading
-	cat "$DIR/$FIRMWARE" > /sys$DEVPATH/data
-	echo 0 > /sys$DEVPATH/loading
-	exit 0
-done
-
-echo -1 > /sys$DEVPATH/loading
-err "Cannot find  firmware file '$FIRMWARE'"
-mkdir -p /dev/.udev/firmware-missing
-file=$(echo "$FIRMWARE" | sed 's:/:\\x2f:g')
-ln -s -f "$DEVPATH" /dev/.udev/firmware-missing/$file
-exit 1
diff --git a/backport/udev/ubuntu/compat_firmware.sh b/backport/udev/ubuntu/compat_firmware.sh
deleted file mode 100755
index 9d4659a..0000000
--- a/backport/udev/ubuntu/compat_firmware.sh
+++ /dev/null
@@ -1,29 +0,0 @@
-#!/bin/sh -e
-
-FIRMWARE_DIRS="/lib/firmware/updates/$(uname -r) /lib/firmware/updates \
-               /lib/firmware/$(uname -r) /lib/firmware"
-
-err() {
-	echo "$@" >&2
-	logger -t "${0##*/}[$$]" "$@" 2>/dev/null || true
-}
-
-if [ ! -e /sys$DEVPATH/loading ]; then
-	err "udev firmware loader misses sysfs directory"
-	exit 1
-fi
-
-for DIR in $FIRMWARE_DIRS; do
-	[ -e "$DIR/$FIRMWARE" ] || continue
-	echo 1 > /sys$DEVPATH/loading
-	cat "$DIR/$FIRMWARE" > /sys$DEVPATH/data
-	echo 0 > /sys$DEVPATH/loading
-	exit 0
-done
-
-echo -1 > /sys$DEVPATH/loading
-err "Cannot find  firmware file '$FIRMWARE'"
-mkdir -p /dev/.udev/firmware-missing
-file=$(echo "$FIRMWARE" | sed 's:/:\\x2f:g')
-ln -s -f "$DEVPATH" /dev/.udev/firmware-missing/$file
-exit 1
diff --git a/dependencies b/dependencies
index c5f727d..346694f 100644
--- a/dependencies
+++ b/dependencies
@@ -1,35 +1,7 @@
 # List the minimum kernel version required for each
 # of the listed Kconfig symbols
 
-# platform_get_device_id()
-ATH9K_AHB 2.6.30
-
-BT 3.2
-BT_RFCOMM_TTY 3.2
-BT_HIDP 3.2
-BT_WILINK 3.2
-BT_HIDP 3.2
-
-MAC80211_HWSIM 2.6.31
-
-ATH6KL 2.6.27
-
-WIL6210 2.6.31
-ATH10K 2.6.30
-
 ATL1C 3.5
-ATL1E 2.6.26
-ALX 2.6.31
-
-LIBERTAS 2.6.27
-LIBERTAS_THINFIRM 2.6.27
-LIBERTAS_SDIO 2.6.32
-
-ZD1211RW 2.6.29
-
-USB_NET_RNDIS_WLAN 2.6.29
-
-CARL9170 2.6.29
 
 # depends on -EPROBE_DEFER and others now
 WL1251_SPI 3.5
@@ -37,23 +9,6 @@ WL1251_SPI 3.5
 WL1251_SDIO 3.15
 WLCORE_SDIO 3.15
 
-CW1200_WLAN_SDIO 2.6.32
-CW1200_WLAN_SPI 2.6.35
-
-BRCMFMAC 2.6.29
-
-# b44 depends on mdio_bus
-B44 2.6.28
-
-IGB 3.0
-
-WL_TI 2.6.30
-WLCORE 2.6.30
-# requires irq_modify_status() which was only exported in 3.0
-WL1251 3.0
-
-MWIFIEX 2.6.27
-
 # Regulator
 # Because of -EPROBE_DEFER see commit d1c3414c and note that
 # we can't backport the core regulator as its part of the core
@@ -194,17 +149,6 @@ VIDEO_RENESAS_VSP1 3.6
 DVB_RTL2832 DISABLE
 DVB_USB_RTL28XXU DISABLE
 
-# struct gpio_chip only got the required members in 2.6.28
-BCMA_DRIVER_GPIO 2.6.28
-SSB_DRIVER_GPIO 2.6.28
-
-# GPIOF_OUT_INIT_HIGH definitions were only moved
-# out of #ifdef in kernel 3.0. These are required
-# by some users of BCMA_DRIVER_GPIO. We'd better
-# just backport the definitions, but right now
-# this is easier.
-BCMA_DRIVER_GPIO 3.0
-
 BCMA_DRIVER_MIPS 3.3
 SSB_DRIVER_MIPS 3.3
 
@@ -214,21 +158,12 @@ SSB_DRIVER_MIPS 3.3
 # BCMA_HOST_SOC are set.
 BCMA_HOST_SOC 3.7
 
-# rfkill-regulator uses a kernel header file
-# (rfkill-regulator.h) that we don't backport
-# right now, so make it depend on 3.0
-RFKILL_REGULATOR 3.0
 # drivers/regulator/ab3100.c and drivers/mfd/ab3100-core.c
 # both depend on include/linux/mfd/ab3100.h and we should
 # only backport REGULATOR_AB3100 if the mfd driver is
 # backported as well.
 REGULATOR_AB3100 3.9
 
-# This is a fun one ... the implementation of this
-# uses subdir-ccflags-$(CONFIG_BRCMDBG) which was
-# only introduced in kernel 2.6.30.
-BRCMDBG 2.6.30
-
 # NFC core needs PF_NFC defined in socket.h which was
 # only introduced in kernel 3.1
 NFC 3.1
diff --git a/devel/backports-update-manager b/devel/backports-update-manager
index af54a92..8d2cd08 100755
--- a/devel/backports-update-manager
+++ b/devel/backports-update-manager
@@ -22,21 +22,6 @@ SPACE_PER_KERNEL_DEB=13
 # For example:
 # https://www.kernel.org/releases.json
 KERNEL_URLS = [
-    KPATH + "v2.6.25/linux-headers-2.6.25-020625_2.6.25-020625_all.deb",
-    KPATH + "v2.6.26/linux-headers-2.6.26-020626_2.6.26-020626_all.deb",
-    KPATH + "v2.6.27/linux-headers-2.6.27-020627_2.6.27-020627_all.deb",
-    KPATH + "v2.6.28.10/linux-headers-2.6.28-02062810_2.6.28-02062810_all.deb",
-    KPATH + "v2.6.29.6/linux-headers-2.6.29-02062906_2.6.29-02062906_all.deb",
-    KPATH + "v2.6.30.10/linux-headers-2.6.30-02063010_2.6.30-02063010_all.deb",
-    KPATH + "v2.6.31.13-karmic/linux-headers-2.6.31-02063113_2.6.31-02063113_all.deb",
-    KPATH + "v2.6.32.61-lucid/linux-headers-2.6.32-02063261_2.6.32-02063261.201306101105_all.deb",
-    KPATH + "v2.6.33.20-maverick/linux-headers-2.6.33-02063320_2.6.33-02063320.201111071735_all.deb",
-    KPATH + "v2.6.34.14-maverick/linux-headers-2.6.34-02063414_2.6.34-02063414.201301162135_all.deb",
-    KPATH + "v2.6.35.13-original-maverick/linux-headers-2.6.35-02063513_2.6.35-02063513.201107261012_all.deb",
-    KPATH + "v2.6.36.4-natty/linux-headers-2.6.36-02063604_2.6.36-02063604.201102180911_all.deb",
-    KPATH + "v2.6.37.6-natty/linux-headers-2.6.37-02063706_2.6.37-02063706.201103281005_all.deb",
-    KPATH + "v2.6.38.8-natty/linux-headers-2.6.38-02063808_2.6.38-02063808.201106040910_all.deb",
-    KPATH + "v2.6.39.4-oneiric/linux-headers-2.6.39-02063904_2.6.39-02063904.201108040905_all.deb",
     KPATH + "v3.0.101-oneiric/linux-headers-3.0.101-0300101_3.0.101-0300101.201310220446_all.deb",
     KPATH + "v3.1.10-precise/linux-headers-3.1.10-030110_3.1.10-030110.201201181135_all.deb",
     KPATH + "v3.2.54-precise/linux-headers-3.2.54-030254_3.2.54-030254.201401030035_all.deb",
@@ -474,53 +459,11 @@ class backport_kernel_updater:
         for line in fileinput.input(makefile, inplace=True):
             print("%s" % (re.sub('^/ %', '%', line))),
         fileinput.close()
-    def fix_and_install_header_usr_src(self, dir_path):
-        """
-        Because of a bug in make < 3.82, mixed implicit and normal
-        rules do not cause harm. Since the bug is fixed in the new make
-        we have to adjust older kernel's Makefiles to fix the bug.
-
-        The hunk we end up modifying looks as follows:
-
-        --- Makefile    2009-03-11 21:21:33.000000000 +0000
-        +++ Makefile.new        2013-12-05 13:01:06.000000000 +0000
-        @@ -1519,7 +1519,7 @@
-        $(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
-          # Modules
-          -/ %/: prepare scripts FORCE
-          +%/: prepare scripts FORCE
-
-        The affected kernels on Ubuntu's mainline build system are
-        2.6.24 - 2.6.28. If we use some other source for kernels later
-        we'll need to inspect this, once we deprecate <= 2.6.28 we can
-        remove this fix.
-        """
-        affected_kbuilds = ['2.6.24-0',
-                            '2.6.25-0',
-                            '2.6.26-0',
-                            '2.6.27-0',
-                            '2.6.28-0',
-                            ]
-        for kernel in os.listdir(dir_path):
-            src = os.path.join(dir_path, kernel)
-            dst = os.path.join(self.ksrc_prefix, 'usr/src/' + kernel)
-            kver = self.get_kver(kernel)
-            if any(affected in kernel for affected in affected_kbuilds):
-                makefile_path = os.path.join(src, "Makefile")
-                self.fix_makefile_old_kernels(makefile_path)
-            generic = ''
-            if '-generic' in dst:
-                generic = 'generic solution'
-            sys.stdout.write("%s - installing usr/src/ %s ...\n" % (kver.get('ver'), generic))
-            self.rm_clean_dir(dst)
-            shutil.move(src, dst)
     def sanitize_and_install_kernel_dirs(self, dir_path):
         d_lib_modules = os.path.join(dir_path, "lib/modules")
         d_usr_src     = os.path.join(dir_path, "usr/src")
         if os.path.isdir(d_lib_modules):
             self.fix_and_install_header_lib_modules(d_lib_modules)
-        if os.path.isdir(d_usr_src):
-            self.fix_and_install_header_usr_src(d_usr_src)
     def extract_backport_pkgs(self):
         tmp_prefix = BACKPORTS_KSRC_DIR + '_'
         tmpdir_path = tempfile.mkdtemp(prefix=tmp_prefix)
diff --git a/gentree.py b/gentree.py
index bffa7e4..a90a425 100755
--- a/gentree.py
+++ b/gentree.py
@@ -583,7 +583,7 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
     backport_files = [(x, x) for x in [
         'Kconfig', 'Makefile', 'Makefile.build', 'Makefile.kernel', '.gitignore',
         'Makefile.real', 'compat/', 'backport-include/', 'kconf/', 'defconfigs/',
-        'scripts/', '.blacklist.map', 'udev/',
+        'scripts/', '.blacklist.map',
     ]]
     if not args.git_revision:
         logwrite('Copy original source files ...')
diff --git a/patches/collateral-evolutions/media/0003-technisat-usb2-led-rename.patch b/patches/0000-upstream-backport-changes/0003-technisat-usb2-led-rename.patch
similarity index 100%
rename from patches/collateral-evolutions/media/0003-technisat-usb2-led-rename.patch
rename to patches/0000-upstream-backport-changes/0003-technisat-usb2-led-rename.patch
diff --git a/patches/collateral-evolutions/regulator/0001-bt8xx-rename-dst-ops.patch b/patches/0000-upstream-backport-changes/0004-bt8xx-rename-dst-ops.patch
similarity index 100%
rename from patches/collateral-evolutions/regulator/0001-bt8xx-rename-dst-ops.patch
rename to patches/0000-upstream-backport-changes/0004-bt8xx-rename-dst-ops.patch
diff --git a/patches/collateral-evolutions/network/79-no-uapi/INFO b/patches/0000-upstream-backport-changes/0005-uapi-compromise/INFO
similarity index 100%
rename from patches/collateral-evolutions/network/79-no-uapi/INFO
rename to patches/0000-upstream-backport-changes/0005-uapi-compromise/INFO
diff --git a/patches/collateral-evolutions/network/79-no-uapi/mwifiex.patch b/patches/0000-upstream-backport-changes/0005-uapi-compromise/mwifiex.patch
similarity index 100%
rename from patches/collateral-evolutions/network/79-no-uapi/mwifiex.patch
rename to patches/0000-upstream-backport-changes/0005-uapi-compromise/mwifiex.patch
diff --git a/patches/backport-adjustments/sch_codel.patch b/patches/backport-adjustments/sch_codel.patch
deleted file mode 100644
index c6d6618..0000000
--- a/patches/backport-adjustments/sch_codel.patch
+++ /dev/null
@@ -1,98 +0,0 @@
---- a/compat/net-sched-sch_codel.c
-+++ b/compat/net-sched-sch_codel.c
-@@ -58,6 +58,9 @@ struct codel_sched_data {
- 	struct codel_vars	vars;
- 	struct codel_stats	stats;
- 	u32			drop_overlimit;
-+#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
-+	u32 limit;
-+#endif
- };
- 
- /* This is the specific function called from codel_dequeue()
-@@ -95,11 +98,16 @@ static int codel_qdisc_enqueue(struct sk
- {
- 	struct codel_sched_data *q;
- 
-+	q = qdisc_priv(sch);
-+
-+#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
-+	if (likely(qdisc_qlen(sch) < q->limit)) {
-+#else
- 	if (likely(qdisc_qlen(sch) < sch->limit)) {
-+#endif
- 		codel_set_enqueue_time(skb);
- 		return qdisc_enqueue_tail(skb, sch);
- 	}
--	q = qdisc_priv(sch);
- 	q->drop_overlimit++;
- 	return qdisc_drop(skb, sch);
- }
-@@ -140,13 +148,21 @@ static int codel_change(struct Qdisc *sc
- 	}
- 
- 	if (tb[TCA_CODEL_LIMIT])
-+#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
-+		q->limit = nla_get_u32(tb[TCA_CODEL_LIMIT]);
-+#else
- 		sch->limit = nla_get_u32(tb[TCA_CODEL_LIMIT]);
-+#endif
- 
- 	if (tb[TCA_CODEL_ECN])
- 		q->params.ecn = !!nla_get_u32(tb[TCA_CODEL_ECN]);
- 
- 	qlen = sch->q.qlen;
-+#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
-+	while (sch->q.qlen > q->limit) {
-+#else
- 	while (sch->q.qlen > sch->limit) {
-+#endif
- 		struct sk_buff *skb = __skb_dequeue(&sch->q);
- 
- 		sch->qstats.backlog -= qdisc_pkt_len(skb);
-@@ -162,7 +178,11 @@ static int codel_init(struct Qdisc *sch,
- {
- 	struct codel_sched_data *q = qdisc_priv(sch);
- 
-+#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
-+	q->limit = DEFAULT_CODEL_LIMIT;
-+#else
- 	sch->limit = DEFAULT_CODEL_LIMIT;
-+#endif
- 
- 	codel_params_init(&q->params);
- 	codel_vars_init(&q->vars);
-@@ -175,7 +195,11 @@ static int codel_init(struct Qdisc *sch,
- 			return err;
- 	}
- 
-+#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
-+	if (q->limit >= 1)
-+#else
- 	if (sch->limit >= 1)
-+#endif
- 		sch->flags |= TCQ_F_CAN_BYPASS;
- 	else
- 		sch->flags &= ~TCQ_F_CAN_BYPASS;
-@@ -195,7 +219,11 @@ static int codel_dump(struct Qdisc *sch,
- 	if (nla_put_u32(skb, TCA_CODEL_TARGET,
- 			codel_time_to_us(q->params.target)) ||
- 	    nla_put_u32(skb, TCA_CODEL_LIMIT,
-+#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
-+			q->limit) ||
-+#else
- 			sch->limit) ||
-+#endif
- 	    nla_put_u32(skb, TCA_CODEL_INTERVAL,
- 			codel_time_to_us(q->params.interval)) ||
- 	    nla_put_u32(skb, TCA_CODEL_ECN,
-@@ -248,7 +276,9 @@ static struct Qdisc_ops codel_qdisc_ops
- 
- 	.enqueue	=	codel_qdisc_enqueue,
- 	.dequeue	=	codel_qdisc_dequeue,
-+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,28))
- 	.peek		=	qdisc_peek_dequeued,
-+#endif
- 	.init		=	codel_init,
- 	.reset		=	codel_reset,
- 	.change 	=	codel_change,
diff --git a/patches/backport-adjustments/sch_fq_codel.patch b/patches/backport-adjustments/sch_fq_codel.patch
deleted file mode 100644
index d0b7f77..0000000
--- a/patches/backport-adjustments/sch_fq_codel.patch
+++ /dev/null
@@ -1,106 +0,0 @@
---- a/compat/net-sched-sch_fq_codel.c
-+++ b/compat/net-sched-sch_fq_codel.c
-@@ -65,6 +65,9 @@ struct fq_codel_sched_data {
- 
- 	struct list_head new_flows;	/* list of new flows */
- 	struct list_head old_flows;	/* list of old flows */
-+#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
-+	u32 limit;
-+#endif
- };
- 
- static unsigned int fq_codel_hash(const struct fq_codel_sched_data *q,
-@@ -195,7 +198,11 @@ static int fq_codel_enqueue(struct sk_bu
- 		flow->deficit = q->quantum;
- 		flow->dropped = 0;
- 	}
-+#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
-+	if (++sch->q.qlen <= q->limit)
-+#else
- 	if (++sch->q.qlen <= sch->limit)
-+#endif
- 		return NET_XMIT_SUCCESS;
- 
- 	q->drop_overlimit++;
-@@ -333,7 +340,11 @@ static int fq_codel_change(struct Qdisc
- 	}
- 
- 	if (tb[TCA_FQ_CODEL_LIMIT])
-+#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
-+		q->limit = nla_get_u32(tb[TCA_FQ_CODEL_LIMIT]);
-+#else
- 		sch->limit = nla_get_u32(tb[TCA_FQ_CODEL_LIMIT]);
-+#endif
- 
- 	if (tb[TCA_FQ_CODEL_ECN])
- 		q->cparams.ecn = !!nla_get_u32(tb[TCA_FQ_CODEL_ECN]);
-@@ -341,7 +352,11 @@ static int fq_codel_change(struct Qdisc
- 	if (tb[TCA_FQ_CODEL_QUANTUM])
- 		q->quantum = max(256U, nla_get_u32(tb[TCA_FQ_CODEL_QUANTUM]));
- 
-+#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
-+	while (sch->q.qlen > q->limit) {
-+#else
- 	while (sch->q.qlen > sch->limit) {
-+#endif
- 		struct sk_buff *skb = fq_codel_dequeue(sch);
- 
- 		kfree_skb(skb);
-@@ -377,7 +392,11 @@ static void fq_codel_destroy(struct Qdis
- {
- 	struct fq_codel_sched_data *q = qdisc_priv(sch);
- 
-+#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,25))
-+	tcf_destroy_chain(q->filter_list);
-+#else
- 	tcf_destroy_chain(&q->filter_list);
-+#endif
- 	fq_codel_free(q->backlogs);
- 	fq_codel_free(q->flows);
- }
-@@ -387,7 +406,11 @@ static int fq_codel_init(struct Qdisc *s
- 	struct fq_codel_sched_data *q = qdisc_priv(sch);
- 	int i;
- 
-+#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
-+	q->limit = 10*1024;
-+#else
- 	sch->limit = 10*1024;
-+#endif
- 	q->flows_cnt = 1024;
- 	q->quantum = psched_mtu(qdisc_dev(sch));
- 	q->perturbation = prandom_u32();
-@@ -420,7 +443,11 @@ static int fq_codel_init(struct Qdisc *s
- 			codel_vars_init(&flow->cvars);
- 		}
- 	}
-+#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
-+	if (q->limit >= 1)
-+#else
- 	if (sch->limit >= 1)
-+#endif
- 		sch->flags |= TCQ_F_CAN_BYPASS;
- 	else
- 		sch->flags &= ~TCQ_F_CAN_BYPASS;
-@@ -439,7 +466,11 @@ static int fq_codel_dump(struct Qdisc *s
- 	if (nla_put_u32(skb, TCA_FQ_CODEL_TARGET,
- 			codel_time_to_us(q->cparams.target)) ||
- 	    nla_put_u32(skb, TCA_FQ_CODEL_LIMIT,
-+#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,39))
-+			q->limit) ||
-+#else
- 			sch->limit) ||
-+#endif
- 	    nla_put_u32(skb, TCA_FQ_CODEL_INTERVAL,
- 			codel_time_to_us(q->cparams.interval)) ||
- 	    nla_put_u32(skb, TCA_FQ_CODEL_ECN,
-@@ -598,7 +629,9 @@ static struct Qdisc_ops fq_codel_qdisc_o
- 	.priv_size	=	sizeof(struct fq_codel_sched_data),
- 	.enqueue	=	fq_codel_enqueue,
- 	.dequeue	=	fq_codel_dequeue,
-+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,28))
- 	.peek		=	qdisc_peek_dequeued,
-+#endif
- 	.drop		=	fq_codel_drop,
- 	.init		=	fq_codel_init,
- 	.reset		=	fq_codel_reset,
diff --git a/patches/collateral-evolutions/generic/0001-sysfs-api/INFO b/patches/collateral-evolutions/generic/0001-sysfs-api/INFO
new file mode 100644
index 0000000..8539db8
--- /dev/null
+++ b/patches/collateral-evolutions/generic/0001-sysfs-api/INFO
@@ -0,0 +1,36 @@
+The new attribute sysfs group was added via these commits:
+
+mcgrof@ergon ~/linux (git::master)$ git describe --contains f2f37f58b
+v3.11-rc2~18^2~9
+mcgrof@ergon ~/linux (git::master)$ git describe --contains 3493f69f4
+v3.11-rc2~18^2~2
+
+We backport them with our own respective set of helpers but right now
+this is using old legacy patches, it should be possible to convert all
+this juju legacy backport to SmPL form.
+
+commit f2f37f58b1b933b06d6d84e80a31a1b500fb0db2
+Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+Date:   Sun Jul 14 16:05:52 2013 -0700
+
+    sysfs.h: add ATTRIBUTE_GROUPS() macro
+    
+    To make it easier for driver subsystems to work with attribute groups,
+    create the ATTRIBUTE_GROUPS macro to remove some of the repetitive
+    typing for the most common use for attribute groups.
+    
+    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
+    Tested-by: Guenter Roeck <linux@roeck-us.net>
+    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+
+commit 3493f69f4c4e8703961919a9a56c2d2e6a25b46f
+Author: Oliver Schinagl <oliver@schinagl.nl>
+Date:   Sun Jul 14 16:05:59 2013 -0700
+
+    sysfs: add more helper macro's for (bin_)attribute(_groups)
+    
+    With the recent changes to sysfs there's various helper macro's.
+    However there's no RW, RO BIN_ helper macro's. This patch adds them.
+    
+    Signed-off-by: Oliver Schinagl <oliver@schinagl.nl>
+    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
diff --git a/patches/collateral-evolutions/network/76-sysfs-api/drivers_bcma.patch b/patches/collateral-evolutions/generic/0001-sysfs-api/drivers_bcma.patch
similarity index 100%
rename from patches/collateral-evolutions/network/76-sysfs-api/drivers_bcma.patch
rename to patches/collateral-evolutions/generic/0001-sysfs-api/drivers_bcma.patch
diff --git a/patches/collateral-evolutions/media/0004-sysfs-api.patch b/patches/collateral-evolutions/generic/0001-sysfs-api/drivers_media_v4l2-core_v4l2-dev.patch
similarity index 100%
rename from patches/collateral-evolutions/media/0004-sysfs-api.patch
rename to patches/collateral-evolutions/generic/0001-sysfs-api/drivers_media_v4l2-core_v4l2-dev.patch
diff --git a/patches/collateral-evolutions/network/76-sysfs-api/drivers_ssb.patch b/patches/collateral-evolutions/generic/0001-sysfs-api/drivers_ssb.patch
similarity index 100%
rename from patches/collateral-evolutions/network/76-sysfs-api/drivers_ssb.patch
rename to patches/collateral-evolutions/generic/0001-sysfs-api/drivers_ssb.patch
diff --git a/patches/collateral-evolutions/network/76-sysfs-api/net_ieee802154_wpan-class.patch b/patches/collateral-evolutions/generic/0001-sysfs-api/net_ieee802154_wpan-class.patch
similarity index 100%
rename from patches/collateral-evolutions/network/76-sysfs-api/net_ieee802154_wpan-class.patch
rename to patches/collateral-evolutions/generic/0001-sysfs-api/net_ieee802154_wpan-class.patch
diff --git a/patches/collateral-evolutions/network/76-sysfs-api/net_wireless_sysfs.patch b/patches/collateral-evolutions/generic/0001-sysfs-api/net_wireless_sysfs.patch
similarity index 100%
rename from patches/collateral-evolutions/network/76-sysfs-api/net_wireless_sysfs.patch
rename to patches/collateral-evolutions/generic/0001-sysfs-api/net_wireless_sysfs.patch
diff --git a/patches/collateral-evolutions/generic/README b/patches/collateral-evolutions/generic/README
new file mode 100644
index 0000000..4797e65
--- /dev/null
+++ b/patches/collateral-evolutions/generic/README
@@ -0,0 +1 @@
+This holds collateral evolutions that apply to any driver we backport
diff --git a/patches/collateral-evolutions/media/0002-dma_mmap_coherent-revert.patch b/patches/collateral-evolutions/media/0001-dma_mmap_coherent-revert.patch
similarity index 100%
rename from patches/collateral-evolutions/media/0002-dma_mmap_coherent-revert.patch
rename to patches/collateral-evolutions/media/0001-dma_mmap_coherent-revert.patch
diff --git a/patches/collateral-evolutions/network/0001-ndo_ioctl.patch b/patches/collateral-evolutions/network/0001-ndo_ioctl.patch
deleted file mode 100644
index 74763f3..0000000
--- a/patches/collateral-evolutions/network/0001-ndo_ioctl.patch
+++ /dev/null
@@ -1,51 +0,0 @@
-
-This patch backports the struct net_device_ops changes added on 2.6.29.
-
-If we add the compat.git netdev_attach_ops() implementation
-for newer kernels upstream it means we do not have to use this
-patch at all for older kernels.
-
-mcgrof@tux ~/linux-stable (git::master)$ git describe --contains d314774cf2cd5dfeb39a00d37deee65d4c627927
-v2.6.29-rc1~581^2~677
-
-commit d314774cf2cd5dfeb39a00d37deee65d4c627927
-Author: Stephen Hemminger <shemminger@vyatta.com>
-Date:   Wed Nov 19 21:32:24 2008 -0800
-
-    netdev: network device operations infrastructure
-    
-    This patch changes the network device internal API to move adminstrative
-    operations out of the network device structure and into a separate structure.
-    
-    This patch involves some hackery to maintain compatablity between the
-    new and old model, so all 300+ drivers don't have to be changed at once.
-    For drivers that aren't converted yet, the netdevice_ops virt function list
-    still resides in the net_device structure. For old protocols, the new
-    net_device_ops are copied out to the old net_device pointers.
-    
-    After the transistion is completed the nag message can be changed to
-    an WARN_ON, and the compatiablity code can be made configurable.
-    
-    Some function pointers aren't moved:
-    * destructor can't be in net_device_ops because
-      it may need to be referenced after the module is unloaded.
-    * neighbor setup is manipulated in a couple of places that need special
-      consideration
-    * hard_start_xmit is in the fast path for transmit.
-    
-    Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>
-    Signed-off-by: David S. Miller <davem@davemloft.net>
-
---- a/net/wireless/wext-core.c
-+++ b/net/wireless/wext-core.c
-@@ -925,9 +925,7 @@ static int wireless_process_ioctl(struct
- 			return private(dev, iwr, cmd, info, handler);
- 	}
- 	/* Old driver API : call driver ioctl handler */
--	if (dev->netdev_ops->ndo_do_ioctl)
--		return dev->netdev_ops->ndo_do_ioctl(dev, ifr, cmd);
--	return -EOPNOTSUPP;
-+	return ndo_do_ioctl(dev, ifr, cmd);
- }
- 
- /* If command is `set a parameter', or `get the encoding parameters',
diff --git a/patches/collateral-evolutions/network/0001-netdev_ops.cocci b/patches/collateral-evolutions/network/0001-netdev_ops.cocci
deleted file mode 100644
index 7c3d03a..0000000
--- a/patches/collateral-evolutions/network/0001-netdev_ops.cocci
+++ /dev/null
@@ -1,6 +0,0 @@
-@@
-struct net_device *dev;
-struct net_device_ops ops;
-@@
--dev->netdev_ops = &ops;
-+netdev_attach_ops(dev, &ops);
diff --git a/patches/collateral-evolutions/network/0005-netlink-portid.cocci b/patches/collateral-evolutions/network/0001-netlink-portid.cocci
similarity index 100%
rename from patches/collateral-evolutions/network/0005-netlink-portid.cocci
rename to patches/collateral-evolutions/network/0001-netlink-portid.cocci
diff --git a/patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch b/patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
similarity index 100%
rename from patches/collateral-evolutions/network/0006-disable-dump-adjust-on-old-kernels.patch
rename to patches/collateral-evolutions/network/0002-disable-dump-adjust-on-old-kernels.patch
diff --git a/patches/collateral-evolutions/network/0002-net-misc/INFO b/patches/collateral-evolutions/network/0002-net-misc/INFO
deleted file mode 100644
index fcfb416..0000000
--- a/patches/collateral-evolutions/network/0002-net-misc/INFO
+++ /dev/null
@@ -1,8 +0,0 @@
-These are things that removed in later kernels but no good explanatin
-was provided as to their removal. We should review if this is needed
-and if not remove these hunks.
-
-Pretty sure we can remove the netdev_tx_t hunk change on
-net/bluetooth/bnep/netdev.c, removing that hunk just needs to be
-compile tested against older kernels.
-
diff --git a/patches/collateral-evolutions/network/0002-net-misc/libertas.patch b/patches/collateral-evolutions/network/0002-net-misc/libertas.patch
deleted file mode 100644
index 5039684..0000000
--- a/patches/collateral-evolutions/network/0002-net-misc/libertas.patch
+++ /dev/null
@@ -1,17 +0,0 @@
---- a/drivers/net/wireless/libertas/defs.h
-+++ b/drivers/net/wireless/libertas/defs.h
-@@ -16,6 +16,14 @@
- #define DRV_NAME "libertas"
- #endif
- 
-+/*
-+ * Really nasty hack to avoid stuffing compat.diff with tons of ifdefs,
-+ * we could add this to a compat header file but too lazy to check ml_priv
-+ * is not used anywhere else
-+ */
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,26))
-+#define ml_priv priv
-+#endif
- 
- #define LBS_DEB_ENTER	0x00000001
- #define LBS_DEB_LEAVE	0x00000002
diff --git a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/INFO b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/INFO
similarity index 100%
rename from patches/collateral-evolutions/network/09-cfg80211-wext-padding/INFO
rename to patches/collateral-evolutions/network/0003-cfg80211-wext-padding/INFO
diff --git a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
similarity index 100%
rename from patches/collateral-evolutions/network/09-cfg80211-wext-padding/include_net_cfg80211.patch
rename to patches/collateral-evolutions/network/0003-cfg80211-wext-padding/include_net_cfg80211.patch
diff --git a/patches/collateral-evolutions/network/09-cfg80211-wext-padding/net_wireless_core.patch b/patches/collateral-evolutions/network/0003-cfg80211-wext-padding/net_wireless_core.patch
similarity index 100%
rename from patches/collateral-evolutions/network/09-cfg80211-wext-padding/net_wireless_core.patch
rename to patches/collateral-evolutions/network/0003-cfg80211-wext-padding/net_wireless_core.patch
diff --git a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/INFO b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/INFO
deleted file mode 100644
index be5ad80..0000000
--- a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/INFO
+++ /dev/null
@@ -1,4 +0,0 @@
-This is an optimization introduced on newer kernels, just ignore for
-older kernels on mac80211. For others the netdev->hard_header_len
-could be used.
-
diff --git a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
deleted file mode 100644
index f2cad55..0000000
--- a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/mac80211.patch
+++ /dev/null
@@ -1,18 +0,0 @@
---- a/net/mac80211/iface.c
-+++ b/net/mac80211/iface.c
-@@ -1608,6 +1608,7 @@ int ieee80211_if_add(struct ieee80211_lo
- 			return -ENOMEM;
- 		dev_net_set(ndev, wiphy_net(local->hw.wiphy));
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,26))
- 		ndev->needed_headroom = local->tx_headroom +
- 					4*6 /* four MAC addresses */
- 					+ 2 + 2 + 2 + 2 /* ctl, dur, seq, qos */
-@@ -1616,6 +1617,7 @@ int ieee80211_if_add(struct ieee80211_lo
- 					- ETH_HLEN /* ethernet hard_header_len */
- 					+ IEEE80211_ENCRYPT_HEADROOM;
- 		ndev->needed_tailroom = IEEE80211_ENCRYPT_TAILROOM;
-+#endif
- 
- 		ret = dev_alloc_name(ndev, ndev->name);
- 		if (ret < 0) {
diff --git a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/orinoco.patch b/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/orinoco.patch
deleted file mode 100644
index 94dc523..0000000
--- a/patches/collateral-evolutions/network/0003-netdev-needed_headroom_tailroom/orinoco.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/net/wireless/orinoco/main.c
-+++ b/drivers/net/wireless/orinoco/main.c
-@@ -2279,7 +2279,11 @@ int orinoco_if_add(struct orinoco_privat
- 	/* we use the default eth_mac_addr for setting the MAC addr */
- 
- 	/* Reserve space in skb for the SNAP header */
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,26))
- 	dev->needed_headroom = ENCAPS_OVERHEAD;
-+#else
-+	dev->hard_header_len += ENCAPS_OVERHEAD;
-+#endif
- 
- 	netif_carrier_off(dev);
- 
diff --git a/patches/collateral-evolutions/network/0009-disable-wext-kconfig.patch b/patches/collateral-evolutions/network/0004-disable-wext-kconfig.patch
similarity index 100%
rename from patches/collateral-evolutions/network/0009-disable-wext-kconfig.patch
rename to patches/collateral-evolutions/network/0004-disable-wext-kconfig.patch
diff --git a/patches/collateral-evolutions/network/0004-wext-namespace.patch b/patches/collateral-evolutions/network/0004-wext-namespace.patch
deleted file mode 100644
index 606001b..0000000
--- a/patches/collateral-evolutions/network/0004-wext-namespace.patch
+++ /dev/null
@@ -1,58 +0,0 @@
-
-This patch backports the namespace changes added
-through net/wireless/wext.c.
-
---- a/net/wireless/wext-core.c
-+++ b/net/wireless/wext-core.c
-@@ -342,6 +342,7 @@ static const int compat_event_type_size[
- 
- /* IW event code */
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32))
- static int __net_init wext_pernet_init(struct net *net)
- {
- 	skb_queue_head_init(&net->wext_nlevents);
-@@ -384,6 +385,29 @@ static void wireless_nlevent_process(str
- 
- static DECLARE_WORK(wireless_nlevent_work, wireless_nlevent_process);
- 
-+#else
-+/* Older kernels get the old way of doing stuff*/
-+static struct sk_buff_head wireless_nlevent_queue;
-+
-+static int __init wireless_nlevent_init(void)
-+{
-+	skb_queue_head_init(&wireless_nlevent_queue);
-+	return 0;
-+}
-+
-+subsys_initcall(wireless_nlevent_init);
-+
-+static void wireless_nlevent_process(unsigned long data)
-+{
-+	struct sk_buff *skb;
-+	while ((skb = skb_dequeue(&wireless_nlevent_queue)))
-+		rtnl_notify(skb, &init_net, 0, RTNLGRP_LINK, NULL, GFP_ATOMIC);
-+}
-+
-+static DECLARE_TASKLET(wireless_nlevent_tasklet, wireless_nlevent_process, 0);
-+
-+#endif
-+
- static struct nlmsghdr *rtnetlink_ifinfo_prep(struct net_device *dev,
- 					      struct sk_buff *skb)
- {
-@@ -597,8 +621,13 @@ void wireless_send_event(struct net_devi
- 
- 	skb_shinfo(skb)->frag_list = compskb;
- #endif
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32))
- 	skb_queue_tail(&dev_net(dev)->wext_nlevents, skb);
- 	schedule_work(&wireless_nlevent_work);
-+#else
-+	skb_queue_tail(&wireless_nlevent_queue, skb);
-+	tasklet_schedule(&wireless_nlevent_tasklet);
-+#endif
- }
- EXPORT_SYMBOL(wireless_send_event);
- 
diff --git a/patches/collateral-evolutions/network/0010-disable-usb-net-asix.patch b/patches/collateral-evolutions/network/0005-disable-usb-net-asix.patch
similarity index 100%
rename from patches/collateral-evolutions/network/0010-disable-usb-net-asix.patch
rename to patches/collateral-evolutions/network/0005-disable-usb-net-asix.patch
diff --git a/patches/collateral-evolutions/network/0012-ieee802154-6lowpan-namespace.patch b/patches/collateral-evolutions/network/0006-ieee802154-6lowpan-namespace.patch
similarity index 100%
rename from patches/collateral-evolutions/network/0012-ieee802154-6lowpan-namespace.patch
rename to patches/collateral-evolutions/network/0006-ieee802154-6lowpan-namespace.patch
diff --git a/patches/collateral-evolutions/network/0007-ksize-orinoco.patch b/patches/collateral-evolutions/network/0007-ksize-orinoco.patch
deleted file mode 100644
index 934e2fa..0000000
--- a/patches/collateral-evolutions/network/0007-ksize-orinoco.patch
+++ /dev/null
@@ -1,37 +0,0 @@
-ksize() was added as of 2.6.29, it gives you the actual
-size of the allocated data. Since we have no support for
-this we simply do not optimize for it and deal with
-large alloocations for the IEs.
-
-We technically could backport this as
-
-define ksize(bleh) SOME_LARGE_NUMBER
-
-but doing it this way emphasis careful review
-of the situation.
-
---- a/drivers/net/wireless/orinoco/wext.c
-+++ b/drivers/net/wireless/orinoco/wext.c
-@@ -31,8 +31,22 @@ static int orinoco_set_key(struct orinoc
- 			   enum orinoco_alg alg, const u8 *key, int key_len,
- 			   const u8 *seq, int seq_len)
- {
-+#if LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,28)
-+	int len;
-+	if (!unlikely(ZERO_OR_NULL_PTR(priv->keys[index].key))) {
-+		len = priv->keys[index].key_len;
-+		memset(priv->keys[index].key, 0, len);
-+		kfree(priv->keys[index].key);
-+	}
-+	if (!unlikely(ZERO_OR_NULL_PTR(priv->keys[index].seq))) {
-+		len = priv->keys[index].seq_len;
-+		memset(priv->keys[index].seq, 0, len);
-+		kfree(priv->keys[index].seq);
-+	}
-+#else
- 	kzfree(priv->keys[index].key);
- 	kzfree(priv->keys[index].seq);
-+#endif
- 
- 	if (key_len) {
- 		priv->keys[index].key = kzalloc(key_len, GFP_ATOMIC);
diff --git a/patches/collateral-evolutions/network/0013-lowpan-inet_frag_lru_move.patch b/patches/collateral-evolutions/network/0007-lowpan-inet_frag_lru_move.patch
similarity index 100%
rename from patches/collateral-evolutions/network/0013-lowpan-inet_frag_lru_move.patch
rename to patches/collateral-evolutions/network/0007-lowpan-inet_frag_lru_move.patch
diff --git a/patches/collateral-evolutions/network/0013-net-user-ns.patch b/patches/collateral-evolutions/network/0008-net-user-ns.patch
similarity index 100%
rename from patches/collateral-evolutions/network/0013-net-user-ns.patch
rename to patches/collateral-evolutions/network/0008-net-user-ns.patch
diff --git a/patches/collateral-evolutions/network/0014-inet_frag_evictor.patch b/patches/collateral-evolutions/network/0009-inet_frag_evictor.patch
similarity index 100%
rename from patches/collateral-evolutions/network/0014-inet_frag_evictor.patch
rename to patches/collateral-evolutions/network/0009-inet_frag_evictor.patch
diff --git a/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/INFO b/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/INFO
similarity index 100%
rename from patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/INFO
rename to patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/INFO
diff --git a/patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch b/patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
similarity index 100%
rename from patches/collateral-evolutions/network/10-add-wext-handlers-to-netdev/net_wireless_core.patch
rename to patches/collateral-evolutions/network/0010-add-wext-handlers-to-netdev/net_wireless_core.patch
diff --git a/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/INFO b/patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/INFO
similarity index 100%
rename from patches/collateral-evolutions/network/12-mac80211-disable-tx-status/INFO
rename to patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/INFO
diff --git a/patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch b/patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/net_mac80211_tx.patch
similarity index 100%
rename from patches/collateral-evolutions/network/12-mac80211-disable-tx-status/net_mac80211_tx.patch
rename to patches/collateral-evolutions/network/0011-mac80211-disable-tx-status/net_mac80211_tx.patch
diff --git a/patches/collateral-evolutions/network/0012-driver-quirks/INFO b/patches/collateral-evolutions/network/0012-driver-quirks/INFO
new file mode 100644
index 0000000..56d3cbd
--- /dev/null
+++ b/patches/collateral-evolutions/network/0012-driver-quirks/INFO
@@ -0,0 +1,2 @@
+Some quirks require base kernel updates, these are work
+around for kernels that would not have these quirks.
diff --git a/patches/collateral-evolutions/network/26-sdio-quirks/drivers_net_wireless_cw1200_sdio.patch b/patches/collateral-evolutions/network/0012-driver-quirks/drivers_net_wireless_cw1200_sdio.patch
similarity index 100%
rename from patches/collateral-evolutions/network/26-sdio-quirks/drivers_net_wireless_cw1200_sdio.patch
rename to patches/collateral-evolutions/network/0012-driver-quirks/drivers_net_wireless_cw1200_sdio.patch
diff --git a/patches/collateral-evolutions/network/35-fix-makefile-includes/net_wireless_Makefile.patch b/patches/collateral-evolutions/network/0013-fix-makefile-includes/net_wireless_Makefile.patch
similarity index 100%
rename from patches/collateral-evolutions/network/35-fix-makefile-includes/net_wireless_Makefile.patch
rename to patches/collateral-evolutions/network/0013-fix-makefile-includes/net_wireless_Makefile.patch
diff --git a/patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
similarity index 100%
rename from patches/collateral-evolutions/network/42-netlink_seq/net_wireless_nl80211.patch
rename to patches/collateral-evolutions/network/0014-netlink_seq/net_wireless_nl80211.patch
diff --git a/patches/collateral-evolutions/network/43-rename_pm_qos_request/drivers_net_wireless_ipw2x00_ipw2100.patch b/patches/collateral-evolutions/network/0015-rename_pm_qos_request/drivers_net_wireless_ipw2x00_ipw2100.patch
similarity index 100%
rename from patches/collateral-evolutions/network/43-rename_pm_qos_request/drivers_net_wireless_ipw2x00_ipw2100.patch
rename to patches/collateral-evolutions/network/0015-rename_pm_qos_request/drivers_net_wireless_ipw2x00_ipw2100.patch
diff --git a/patches/collateral-evolutions/network/0015-threaded-irq.cocci b/patches/collateral-evolutions/network/0015-threaded-irq.cocci
deleted file mode 100644
index 9cc668d..0000000
--- a/patches/collateral-evolutions/network/0015-threaded-irq.cocci
+++ /dev/null
@@ -1,75 +0,0 @@
-/*
-Backports threaded IRQ support
-
-The 2.6.31 kernel introduced threaded IRQ support, in order to
-backport threaded IRSs on older kernels we built our own struct
-compat_threaded_irq to queue_work() onto it as the kernel thread
-will be running the thread in process context as well.
-
-For now each driver's private data structure is modified to add
-the their own struct compat_threaded_irq, and that is used by
-the backports module to queue_work() onto it. We can likely avoid
-having to backport this feature by requiring to modify the private
-driver's data structure by relying on an internal worker thread
-within the backports module, this should be revised later.
-*/
-
-@ threaded_irq @
-identifier ret;
-expression irq, irq_handler, irq_thread_handler, flags, name;
-type T;
-T *private;
-@@
-
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,31)
-ret = request_threaded_irq(irq,
-			   irq_handler,
-			   irq_thread_handler,
-			   flags,
-			   name,
-			   private);
-+#else
-+ret = compat_request_threaded_irq(&private->irq_compat,
-+				   irq,
-+				   irq_handler,
-+				   irq_thread_handler,
-+				   flags,
-+				   name,
-+				   private);
-+#endif
-
-@ sync_irq depends on threaded_irq @
-expression irq;
-type threaded_irq.T;
-T *threaded_irq.private;
-@@
-
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,31)
-synchronize_irq(irq);
-+#else
-+compat_synchronize_threaded_irq(&private->irq_compat);
-+#endif
-
-@ free depends on threaded_irq @
-expression irq, dev;
-type threaded_irq.T;
-T *threaded_irq.private;
-@@
-
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,31)
-free_irq(irq, dev);
-+#else
-+compat_free_threaded_irq(&private->irq_compat);
-+compat_destroy_threaded_irq(&dev->irq_compat);
-+#endif
-
-@ modify_private_header depends on threaded_irq @
-type threaded_irq.T;
-@@
-
-T {
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
-+      struct compat_threaded_irq irq_compat;
-+#endif
-...
-};
diff --git a/patches/collateral-evolutions/network/0015-threaded-irq/INFO b/patches/collateral-evolutions/network/0015-threaded-irq/INFO
deleted file mode 100644
index fe0845a..0000000
--- a/patches/collateral-evolutions/network/0015-threaded-irq/INFO
+++ /dev/null
@@ -1,5 +0,0 @@
-The 2.6.31 kernel has threaded IRQ support and b43 is the first
-wireless driver that makes use of it. To support threaded IRSs
-on older kernels we built our own struct compat_threaded_irq
-to queue_work() onto it as the kernel thread will running the
-thread in process context as well.
diff --git a/patches/collateral-evolutions/network/0015-threaded-irq/drivers_net_wireless_iwlwifi_iwl-trans.patch b/patches/collateral-evolutions/network/0015-threaded-irq/drivers_net_wireless_iwlwifi_iwl-trans.patch
deleted file mode 100644
index 519645a..0000000
--- a/patches/collateral-evolutions/network/0015-threaded-irq/drivers_net_wireless_iwlwifi_iwl-trans.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/wireless/iwlwifi/iwl-trans.h
-+++ b/drivers/net/wireless/iwlwifi/iwl-trans.h
-@@ -549,6 +549,9 @@ enum iwl_trans_state {
-  * @dflt_pwr_limit: default power limit fetched from the platform (ACPI)
-  */
- struct iwl_trans {
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,31)
-+	struct compat_threaded_irq irq_compat;
-+#endif
- 	const struct iwl_trans_ops *ops;
- 	struct iwl_op_mode *op_mode;
- 	const struct iwl_cfg *cfg;
diff --git a/patches/collateral-evolutions/network/50-libertas-olpc-ec-wakeup/INFO b/patches/collateral-evolutions/network/0016-libertas-olpc-ec-wakeup/INFO
similarity index 100%
rename from patches/collateral-evolutions/network/50-libertas-olpc-ec-wakeup/INFO
rename to patches/collateral-evolutions/network/0016-libertas-olpc-ec-wakeup/INFO
diff --git a/patches/collateral-evolutions/network/50-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch b/patches/collateral-evolutions/network/0016-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch
similarity index 100%
rename from patches/collateral-evolutions/network/50-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch
rename to patches/collateral-evolutions/network/0016-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch
diff --git a/patches/collateral-evolutions/network/0016-threaded-irq-one-shot.patch b/patches/collateral-evolutions/network/0016-threaded-irq-one-shot.patch
deleted file mode 100644
index c43995e..0000000
--- a/patches/collateral-evolutions/network/0016-threaded-irq-one-shot.patch
+++ /dev/null
@@ -1,38 +0,0 @@
-This backports commit b25c340c1 added by Thomas through kernel v2.6.32
-which added support for IRQF_ONESHOT. This lets drivers that use
-threaded IRQ support to request that the IRQ is not masked after the
-hard interrupt handler as this requires access times devices in hard
-IRQ context and for buses such as i2c and spi this at times is not
-possible.
-
-Note that the TI driver reports this as a platform quirk with
-WL12XX_PLATFORM_QUIRK_EDGE_IRQ. In retrospect this quirk does not
-seem backportable unless IRQF_ONESHOT is really not a requirement,
-but desired. If WL12XX_PLATFORM_QUIRK_EDGE_IRQ is indeed a requirement
-for IRQF_ONESHOT then we should not net probe complete. Its unclear
-if this is a universal thing or not.
-
-mcgrof@ergon ~/linux-next (git::master)$ git describe --contains b25c340c1
-v2.6.32-rc1~722^2~3
-
---- a/drivers/net/wireless/ti/wlcore/main.c
-+++ b/drivers/net/wireless/ti/wlcore/main.c
-@@ -6080,6 +6080,10 @@ static void wlcore_nvs_cb(const struct f
- 	wl->irq = platform_get_irq(pdev, 0);
- 	wl->platform_quirks = pdata->platform_quirks;
- 	wl->if_ops = pdev_data->if_ops;
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32)
-+	irqflags = IRQF_TRIGGER_RISING;
-+	hardirq_fn = wlcore_hardirq;
-+#else
- 
- 	if (wl->platform_quirks & WL12XX_PLATFORM_QUIRK_EDGE_IRQ) {
- 		irqflags = IRQF_TRIGGER_RISING;
-@@ -6087,6 +6091,7 @@ static void wlcore_nvs_cb(const struct f
- 	} else {
- 		irqflags = IRQF_TRIGGER_HIGH | IRQF_ONESHOT;
- 	}
-+#endif
- 
- 	ret = request_threaded_irq(wl->irq, hardirq_fn, wlcore_irq,
- 				   irqflags, pdev->name, wl);
diff --git a/patches/collateral-evolutions/network/54-get_ts_info/INFO b/patches/collateral-evolutions/network/0017-get_ts_info/INFO
similarity index 100%
rename from patches/collateral-evolutions/network/54-get_ts_info/INFO
rename to patches/collateral-evolutions/network/0017-get_ts_info/INFO
diff --git a/patches/collateral-evolutions/network/54-get_ts_info/drivers_net_usb_usbnet.patch b/patches/collateral-evolutions/network/0017-get_ts_info/drivers_net_usb_usbnet.patch
similarity index 100%
rename from patches/collateral-evolutions/network/54-get_ts_info/drivers_net_usb_usbnet.patch
rename to patches/collateral-evolutions/network/0017-get_ts_info/drivers_net_usb_usbnet.patch
diff --git a/patches/collateral-evolutions/network/55-iwlwifi-msg-trace-fix/INFO b/patches/collateral-evolutions/network/0018-pv-trace-fixes/INFO
similarity index 71%
rename from patches/collateral-evolutions/network/55-iwlwifi-msg-trace-fix/INFO
rename to patches/collateral-evolutions/network/0018-pv-trace-fixes/INFO
index 9437ac3..a2c89e9 100644
--- a/patches/collateral-evolutions/network/55-iwlwifi-msg-trace-fix/INFO
+++ b/patches/collateral-evolutions/network/0018-pv-trace-fixes/INFO
@@ -3,3 +3,5 @@ This isn't true for all kernels, so copy the va_list for use
 by the dev_*() functions, otherwise the kernel will crash if
 the message is printed and traced.
 
+This is required for kernels <= 3.1, as otherwise it would
+those kernels would crash.
diff --git a/patches/collateral-evolutions/network/55-iwlwifi-msg-trace-fix/drivers_net_wireless_iwlwifi_iwl-debug.patch b/patches/collateral-evolutions/network/0018-pv-trace-fixes/drivers_net_wireless_iwlwifi_iwl-debug.patch
similarity index 100%
rename from patches/collateral-evolutions/network/55-iwlwifi-msg-trace-fix/drivers_net_wireless_iwlwifi_iwl-debug.patch
rename to patches/collateral-evolutions/network/0018-pv-trace-fixes/drivers_net_wireless_iwlwifi_iwl-debug.patch
diff --git a/patches/collateral-evolutions/network/56-mac80211-trace-fix/net_mac80211_trace.patch b/patches/collateral-evolutions/network/0018-pv-trace-fixes/net_mac80211_trace.patch
similarity index 100%
rename from patches/collateral-evolutions/network/56-mac80211-trace-fix/net_mac80211_trace.patch
rename to patches/collateral-evolutions/network/0018-pv-trace-fixes/net_mac80211_trace.patch
diff --git a/patches/collateral-evolutions/network/62-usb_driver_lpm.cocci b/patches/collateral-evolutions/network/0019-usb_driver_lpm.cocci
similarity index 100%
rename from patches/collateral-evolutions/network/62-usb_driver_lpm.cocci
rename to patches/collateral-evolutions/network/0019-usb_driver_lpm.cocci
diff --git a/patches/collateral-evolutions/network/63-tty-termios/INFO b/patches/collateral-evolutions/network/0020-tty-termios/INFO
similarity index 85%
rename from patches/collateral-evolutions/network/63-tty-termios/INFO
rename to patches/collateral-evolutions/network/0020-tty-termios/INFO
index a5e536d..abd5c36 100644
--- a/patches/collateral-evolutions/network/63-tty-termios/INFO
+++ b/patches/collateral-evolutions/network/0020-tty-termios/INFO
@@ -19,3 +19,5 @@ Date:   Sat Jul 14 15:31:47 2012 +0100
 We cannot use compat.git for this given that the assignment
 was not done through a static inline helper.
 
+mcgrof@ergon ~/linux (git::master)$ git describe --contains adc8d746caa67fff4b53ba3e5163a6cbacc3b523
+v3.7-rc1~172^2~187
diff --git a/patches/collateral-evolutions/network/63-tty-termios/drivers_bluetooth_hci_ath.patch b/patches/collateral-evolutions/network/0020-tty-termios/drivers_bluetooth_hci_ath.patch
similarity index 100%
rename from patches/collateral-evolutions/network/63-tty-termios/drivers_bluetooth_hci_ath.patch
rename to patches/collateral-evolutions/network/0020-tty-termios/drivers_bluetooth_hci_ath.patch
diff --git a/patches/collateral-evolutions/network/63-tty-termios/net_bluetooth_rfcomm_tty.patch b/patches/collateral-evolutions/network/0020-tty-termios/net_bluetooth_rfcomm_tty.patch
similarity index 100%
rename from patches/collateral-evolutions/network/63-tty-termios/net_bluetooth_rfcomm_tty.patch
rename to patches/collateral-evolutions/network/0020-tty-termios/net_bluetooth_rfcomm_tty.patch
diff --git a/patches/collateral-evolutions/network/70-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch b/patches/collateral-evolutions/network/0021-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch
similarity index 100%
rename from patches/collateral-evolutions/network/70-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch
rename to patches/collateral-evolutions/network/0021-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch
diff --git a/patches/collateral-evolutions/network/0022-define-tracing/INFO b/patches/collateral-evolutions/network/0022-define-tracing/INFO
new file mode 100644
index 0000000..1929087
--- /dev/null
+++ b/patches/collateral-evolutions/network/0022-define-tracing/INFO
@@ -0,0 +1,9 @@
+For some reason the tracing on older kernels requires
+the tracing to be declared before it's defined; it's
+broken when the trace header is only included to create
+the tracepoints.
+
+Since new kernels don't, add patches for the two places
+that rely on the new behaviour.
+
+The kernel that requires this has not been identified...
diff --git a/patches/collateral-evolutions/network/74-define-tracing/ath6kl.patch b/patches/collateral-evolutions/network/0022-define-tracing/ath6kl.patch
similarity index 100%
rename from patches/collateral-evolutions/network/74-define-tracing/ath6kl.patch
rename to patches/collateral-evolutions/network/0022-define-tracing/ath6kl.patch
diff --git a/patches/collateral-evolutions/network/74-define-tracing/cfg80211.patch b/patches/collateral-evolutions/network/0022-define-tracing/cfg80211.patch
similarity index 100%
rename from patches/collateral-evolutions/network/74-define-tracing/cfg80211.patch
rename to patches/collateral-evolutions/network/0022-define-tracing/cfg80211.patch
diff --git a/patches/collateral-evolutions/network/74-define-tracing/wil6210.patch b/patches/collateral-evolutions/network/0022-define-tracing/wil6210.patch
similarity index 100%
rename from patches/collateral-evolutions/network/74-define-tracing/wil6210.patch
rename to patches/collateral-evolutions/network/0022-define-tracing/wil6210.patch
diff --git a/patches/collateral-evolutions/network/77-led-blink-api/INFO b/patches/collateral-evolutions/network/0024-led-blink-api/INFO
similarity index 100%
rename from patches/collateral-evolutions/network/77-led-blink-api/INFO
rename to patches/collateral-evolutions/network/0024-led-blink-api/INFO
diff --git a/patches/collateral-evolutions/network/77-led-blink-api/mac80211.patch b/patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
similarity index 100%
rename from patches/collateral-evolutions/network/77-led-blink-api/mac80211.patch
rename to patches/collateral-evolutions/network/0024-led-blink-api/mac80211.patch
diff --git a/patches/collateral-evolutions/network/78-usb-sg/INFO b/patches/collateral-evolutions/network/0025-usb-sg/INFO
similarity index 68%
rename from patches/collateral-evolutions/network/78-usb-sg/INFO
rename to patches/collateral-evolutions/network/0025-usb-sg/INFO
index 2277f82..0d4981a 100644
--- a/patches/collateral-evolutions/network/78-usb-sg/INFO
+++ b/patches/collateral-evolutions/network/0025-usb-sg/INFO
@@ -10,3 +10,8 @@ Author: Ming Lei <ming.lei@canonical.com>
 Date:   Thu Aug 8 21:48:24 2013 +0800
 
     USBNET: support DMA SG
+
+mcgrof@ergon ~/linux (git::master)$ git describe --contains 638c5115a794981441246fa8fa5d95c1875af5ba
+v3.12-rc1~186^2~110
+
+XXX: this patch seems odd, the kernel versoin used seems off.
diff --git a/patches/collateral-evolutions/network/78-usb-sg/usbnet.patch b/patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch
similarity index 100%
rename from patches/collateral-evolutions/network/78-usb-sg/usbnet.patch
rename to patches/collateral-evolutions/network/0025-usb-sg/usbnet.patch
diff --git a/patches/collateral-evolutions/network/80-ipv6_stub/INFO b/patches/collateral-evolutions/network/0026-ipv6_stub/INFO
similarity index 74%
rename from patches/collateral-evolutions/network/80-ipv6_stub/INFO
rename to patches/collateral-evolutions/network/0026-ipv6_stub/INFO
index e244cda..3128b56 100644
--- a/patches/collateral-evolutions/network/80-ipv6_stub/INFO
+++ b/patches/collateral-evolutions/network/0026-ipv6_stub/INFO
@@ -7,3 +7,6 @@ Author: Cong Wang <amwang@redhat.com>
 Date:   Sat Aug 31 13:44:30 2013 +0800
 
     ipv6: export a stub for IPv6 symbols used by vxlan
+
+mcgrof@ergon ~/linux (git::master)$ git describe --contains 5f81bd2e5d804ca93f3ec8873451b22d2f454721
+v3.12-rc1~132^2~101
diff --git a/patches/collateral-evolutions/network/80-ipv6_stub/cdc_mbim.patch b/patches/collateral-evolutions/network/0026-ipv6_stub/cdc_mbim.patch
similarity index 100%
rename from patches/collateral-evolutions/network/80-ipv6_stub/cdc_mbim.patch
rename to patches/collateral-evolutions/network/0026-ipv6_stub/cdc_mbim.patch
diff --git a/patches/collateral-evolutions/network/0027-genl-const/INFO b/patches/collateral-evolutions/network/0027-genl-const/INFO
new file mode 100644
index 0000000..192c5c6
--- /dev/null
+++ b/patches/collateral-evolutions/network/0027-genl-const/INFO
@@ -0,0 +1,15 @@
+Newer kernels make generic netlink ops and multicast groups
+const, but older can't have that. We therefore introduce
+__genl_const, which can be defined depending on the kernel.
+
+What kernel versions require this?
+
+XXX: try to SmPLify
+
+The struct genl_ops gave the *option* to make it const via:
+mcgrof@ergon ~/linux (git::master)$ git describe --contains f84f771d9
+v3.13-rc1~33^2~32^2~2
+
+The struct genl_multicast_group was *forced* to be const via:
+mcgrof@ergon ~/linux (git::master)$ git describe --contains 2a94fe48f
+v3.13-rc1~33^2^2
diff --git a/patches/collateral-evolutions/network/81-genl-const/hwsim.patch b/patches/collateral-evolutions/network/0027-genl-const/hwsim.patch
similarity index 100%
rename from patches/collateral-evolutions/network/81-genl-const/hwsim.patch
rename to patches/collateral-evolutions/network/0027-genl-const/hwsim.patch
diff --git a/patches/collateral-evolutions/network/81-genl-const/ieee802154.patch b/patches/collateral-evolutions/network/0027-genl-const/ieee802154.patch
similarity index 100%
rename from patches/collateral-evolutions/network/81-genl-const/ieee802154.patch
rename to patches/collateral-evolutions/network/0027-genl-const/ieee802154.patch
diff --git a/patches/collateral-evolutions/network/81-genl-const/nfc.patch b/patches/collateral-evolutions/network/0027-genl-const/nfc.patch
similarity index 100%
rename from patches/collateral-evolutions/network/81-genl-const/nfc.patch
rename to patches/collateral-evolutions/network/0027-genl-const/nfc.patch
diff --git a/patches/collateral-evolutions/network/81-genl-const/nl80211.patch b/patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
similarity index 100%
rename from patches/collateral-evolutions/network/81-genl-const/nl80211.patch
rename to patches/collateral-evolutions/network/0027-genl-const/nl80211.patch
diff --git a/patches/collateral-evolutions/network/83-select_queue/INFO b/patches/collateral-evolutions/network/0028-select_queue/INFO
similarity index 74%
rename from patches/collateral-evolutions/network/83-select_queue/INFO
rename to patches/collateral-evolutions/network/0028-select_queue/INFO
index 6925ef7..519e4fc 100644
--- a/patches/collateral-evolutions/network/83-select_queue/INFO
+++ b/patches/collateral-evolutions/network/0028-select_queue/INFO
@@ -7,3 +7,6 @@ Author: Jason Wang <jasowang@redhat.com>
 Date:   Fri Jan 10 16:18:26 2014 +0800
 
     net: core: explicitly select a txq before doing l2 forwarding
+
+mcgrof@ergon ~/linux (git::master)$ git describe --contains f663dd9aaf9ed124f25f0f8452edf238f087ad50
+v3.13-rc8~4^2~2
diff --git a/patches/collateral-evolutions/network/83-select_queue/mac80211.patch b/patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
similarity index 100%
rename from patches/collateral-evolutions/network/83-select_queue/mac80211.patch
rename to patches/collateral-evolutions/network/0028-select_queue/mac80211.patch
diff --git a/patches/collateral-evolutions/network/83-select_queue/mwifiex.patch b/patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
similarity index 100%
rename from patches/collateral-evolutions/network/83-select_queue/mwifiex.patch
rename to patches/collateral-evolutions/network/0028-select_queue/mwifiex.patch
diff --git a/patches/collateral-evolutions/network/0029-struct_hid_ll_driver-extensions/INFO b/patches/collateral-evolutions/network/0029-struct_hid_ll_driver-extensions/INFO
new file mode 100644
index 0000000..0181011
--- /dev/null
+++ b/patches/collateral-evolutions/network/0029-struct_hid_ll_driver-extensions/INFO
@@ -0,0 +1,16 @@
+This is backported because of:
+
+commit cd4dc0821bc97947f25c8483a4aa0711bff8619a
+Author: Frank Praznik <frank.praznik@oh.rr.com>
+Date:   Wed Jan 22 13:49:41 2014 -0500
+
+    HID: Add transport-driver callbacks to the hid_ll_driver struct
+    
+    Add raw_request and output_report callbacks to the hid_ll_driver struct.
+    
+    Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
+    Acked-by: David Herrmann <dh.herrmann@gmail.com>
+    Signed-off-by: Jiri Kosina <jkosina@suse.cz>
+
+This did not make it to v3.14, so its only present on linux-next, its
+available for example on next-20140409
diff --git a/patches/collateral-evolutions/network/85-hid_ll_driver/net_bluetooth_hidp_core.patch b/patches/collateral-evolutions/network/0029-struct_hid_ll_driver-extensions/net_bluetooth_hidp_core.patch
similarity index 100%
rename from patches/collateral-evolutions/network/85-hid_ll_driver/net_bluetooth_hidp_core.patch
rename to patches/collateral-evolutions/network/0029-struct_hid_ll_driver-extensions/net_bluetooth_hidp_core.patch
diff --git a/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/INFO b/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/INFO
new file mode 100644
index 0000000..e5d9623
--- /dev/null
+++ b/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/INFO
@@ -0,0 +1,22 @@
+struct net_device got an extension with the member qdisc_tx_busylock
+as of commit 23d3b8bfb. For older kernels we need to ifdef around that
+as its now available.
+
+mcgrof@ergon ~/linux (git::master)$ git describe --contains 23d3b8bfb
+v3.7-rc1~145^2~208
+
+commit 23d3b8bfb8eb20e7d96afa09991e6a5ed1c83164
+Author: Eric Dumazet <edumazet@google.com>
+Date:   Wed Sep 5 01:02:56 2012 +0000
+
+    net: qdisc busylock needs lockdep annotations
+    
+    It seems we need to provide ability for stacked devices
+    to use specific lock_class_key for sch->busylock
+    
+    We could instead default l2tpeth tx_queue_len to 0 (no qdisc), but
+    a user might use a qdisc anyway.
+    
+    (So same fixes are probably needed on non LLTX stacked drivers)
+
+[ the commit log goes we only include up to here to help with context ]
diff --git a/patches/collateral-evolutions/network/86-qdisc_tx_busylock/ieee802154.patch b/patches/collateral-evolutions/network/0030-qdisc_tx_busylock/ieee802154.patch
similarity index 100%
rename from patches/collateral-evolutions/network/86-qdisc_tx_busylock/ieee802154.patch
rename to patches/collateral-evolutions/network/0030-qdisc_tx_busylock/ieee802154.patch
diff --git a/patches/collateral-evolutions/network/05-usb/INFO b/patches/collateral-evolutions/network/05-usb/INFO
deleted file mode 100644
index 328ba00..0000000
--- a/patches/collateral-evolutions/network/05-usb/INFO
+++ /dev/null
@@ -1,2 +0,0 @@
-USB opt soft_unbid was added as of 2.6.27.
-
diff --git a/patches/collateral-evolutions/network/05-usb/ath9k_htc.patch b/patches/collateral-evolutions/network/05-usb/ath9k_htc.patch
deleted file mode 100644
index 1c7ad21..0000000
--- a/patches/collateral-evolutions/network/05-usb/ath9k_htc.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/wireless/ath/ath9k/hif_usb.c
-+++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
-@@ -1367,7 +1367,9 @@ static struct usb_driver ath9k_hif_usb_d
- 	.reset_resume = ath9k_hif_usb_resume,
- #endif
- 	.id_table = ath9k_hif_usb_ids,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,27))
- 	.soft_unbind = 1,
-+#endif
- 	.disable_hub_initiated_lpm = 1,
- };
- 
diff --git a/patches/collateral-evolutions/network/05-usb/p54usb.patch b/patches/collateral-evolutions/network/05-usb/p54usb.patch
deleted file mode 100644
index e083d98..0000000
--- a/patches/collateral-evolutions/network/05-usb/p54usb.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/wireless/p54/p54usb.c
-+++ b/drivers/net/wireless/p54/p54usb.c
-@@ -1142,7 +1142,9 @@ static struct usb_driver p54u_driver = {
- 	.resume = p54u_resume,
- 	.reset_resume = p54u_resume,
- #endif /* CONFIG_PM */
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,27))
- 	.soft_unbind = 1,
-+#endif
- 	.disable_hub_initiated_lpm = 1,
- };
- 
diff --git a/patches/collateral-evolutions/network/06-header-changes/INFO b/patches/collateral-evolutions/network/06-header-changes/INFO
deleted file mode 100644
index eccf5d6..0000000
--- a/patches/collateral-evolutions/network/06-header-changes/INFO
+++ /dev/null
@@ -1,6 +0,0 @@
-
-Every kernel release there are a few changes to headers
-made. Some code gets shifted around between headers or
-new headers are defined. This patch deals with such
-cases.
-
diff --git a/patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_b43_phy_common.patch b/patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_b43_phy_common.patch
deleted file mode 100644
index 1b8189a..0000000
--- a/patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_b43_phy_common.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/wireless/b43/phy_common.h
-+++ b/drivers/net/wireless/b43/phy_common.h
-@@ -3,6 +3,9 @@
- 
- #include <linux/types.h>
- #include <linux/nl80211.h>
-+#if (LINUX_VERSION_CODE == KERNEL_VERSION(2,6,28))
-+#include <asm/atomic.h>
-+#endif
- 
- struct b43_wldev;
- 
diff --git a/patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_iwlwifi.patch b/patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_iwlwifi.patch
deleted file mode 100644
index b27869c..0000000
--- a/patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_iwlwifi.patch
+++ /dev/null
@@ -1,11 +0,0 @@
---- a/drivers/net/wireless/iwlwifi/mvm/fw-api-d3.h
-+++ b/drivers/net/wireless/iwlwifi/mvm/fw-api-d3.h
-@@ -63,6 +63,8 @@
- #ifndef __fw_api_d3_h__
- #define __fw_api_d3_h__
- 
-+#include <linux/in6.h>
-+
- /**
-  * enum iwl_d3_wakeup_flags - D3 manager wakeup flags
-  * @IWL_WAKEUP_D3_CONFIG_FW_ERROR: wake up on firmware sysassert
diff --git a/patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_mwifiex_usb.patch b/patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_mwifiex_usb.patch
deleted file mode 100644
index 75a3db9..0000000
--- a/patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_mwifiex_usb.patch
+++ /dev/null
@@ -1,10 +0,0 @@
---- a/drivers/net/wireless/mwifiex/usb.c
-+++ b/drivers/net/wireless/mwifiex/usb.c
-@@ -19,6 +19,7 @@
- 
- #include "main.h"
- #include "usb.h"
-+#include <linux/usb/audio.h>
- 
- #define USB_VERSION	"1.0"
- 
diff --git a/patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_rtlwifi_base.patch b/patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_rtlwifi_base.patch
deleted file mode 100644
index d968ccb..0000000
--- a/patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_rtlwifi_base.patch
+++ /dev/null
@@ -1,10 +0,0 @@
---- a/drivers/net/wireless/rtlwifi/base.c
-+++ b/drivers/net/wireless/rtlwifi/base.c
-@@ -36,6 +36,7 @@
- #include "regd.h"
- 
- #include <linux/ip.h>
-+#include <linux/in.h>
- #include <linux/module.h>
- #include <linux/udp.h>
- 
diff --git a/patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_ti_wl1251_main.patch b/patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_ti_wl1251_main.patch
deleted file mode 100644
index 4701f48..0000000
--- a/patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_ti_wl1251_main.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/wireless/ti/wl1251/main.c
-+++ b/drivers/net/wireless/ti/wl1251/main.c
-@@ -24,6 +24,9 @@
- #include <linux/firmware.h>
- #include <linux/delay.h>
- #include <linux/irq.h>
-+#if (LINUX_VERSION_CODE == KERNEL_VERSION(2,6,28))
-+#include <linux/device.h>
-+#endif
- #include <linux/crc32.h>
- #include <linux/etherdevice.h>
- #include <linux/vmalloc.h>
diff --git a/patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_ti_wl1251_spi.patch b/patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_ti_wl1251_spi.patch
deleted file mode 100644
index 9dd6d6b..0000000
--- a/patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_ti_wl1251_spi.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/wireless/ti/wl1251/spi.c
-+++ b/drivers/net/wireless/ti/wl1251/spi.c
-@@ -24,6 +24,9 @@
- #include <linux/module.h>
- #include <linux/slab.h>
- #include <linux/crc7.h>
-+#if (LINUX_VERSION_CODE == KERNEL_VERSION(2,6,28))
-+#include <linux/device.h>
-+#endif
- #include <linux/spi/spi.h>
- #include <linux/wl12xx.h>
- #include <linux/gpio.h>
diff --git a/patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_ti_wlcore_event.patch b/patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_ti_wlcore_event.patch
deleted file mode 100644
index 3bc3396..0000000
--- a/patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_ti_wlcore_event.patch
+++ /dev/null
@@ -1,10 +0,0 @@
---- a/drivers/net/wireless/ti/wlcore/event.c
-+++ b/drivers/net/wireless/ti/wlcore/event.c
-@@ -21,6 +21,7 @@
-  *
-  */
- 
-+#include <linux/export.h>
- #include "wlcore.h"
- #include "debug.h"
- #include "io.h"
diff --git a/patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_ti_wlcore_scan.patch b/patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_ti_wlcore_scan.patch
deleted file mode 100644
index 848aa82..0000000
--- a/patches/collateral-evolutions/network/06-header-changes/drivers_net_wireless_ti_wlcore_scan.patch
+++ /dev/null
@@ -1,10 +0,0 @@
---- a/drivers/net/wireless/ti/wlcore/scan.c
-+++ b/drivers/net/wireless/ti/wlcore/scan.c
-@@ -22,6 +22,7 @@
-  */
- 
- #include <linux/ieee80211.h>
-+#include <linux/export.h>
- 
- #include "wlcore.h"
- #include "debug.h"
diff --git a/patches/collateral-evolutions/network/06-header-changes/net_bluetooth_bnep_sock.patch b/patches/collateral-evolutions/network/06-header-changes/net_bluetooth_bnep_sock.patch
deleted file mode 100644
index 9c949d2..0000000
--- a/patches/collateral-evolutions/network/06-header-changes/net_bluetooth_bnep_sock.patch
+++ /dev/null
@@ -1,10 +0,0 @@
---- a/net/bluetooth/bnep/sock.c
-+++ b/net/bluetooth/bnep/sock.c
-@@ -26,6 +26,7 @@
- 
- #include <linux/export.h>
- #include <linux/file.h>
-+#include <linux/compat.h>
- 
- #include "bnep.h"
- 
diff --git a/patches/collateral-evolutions/network/06-header-changes/net_bluetooth_hci_sock.patch b/patches/collateral-evolutions/network/06-header-changes/net_bluetooth_hci_sock.patch
deleted file mode 100644
index 08d68fd..0000000
--- a/patches/collateral-evolutions/network/06-header-changes/net_bluetooth_hci_sock.patch
+++ /dev/null
@@ -1,10 +0,0 @@
---- a/net/bluetooth/hci_sock.c
-+++ b/net/bluetooth/hci_sock.c
-@@ -25,6 +25,7 @@
- /* Bluetooth HCI sockets. */
- 
- #include <linux/export.h>
-+#include <linux/compat.h>
- #include <asm/unaligned.h>
- 
- #include <net/bluetooth/bluetooth.h>
diff --git a/patches/collateral-evolutions/network/06-header-changes/net_bluetooth_hidp_sock.patch b/patches/collateral-evolutions/network/06-header-changes/net_bluetooth_hidp_sock.patch
deleted file mode 100644
index 1e35176..0000000
--- a/patches/collateral-evolutions/network/06-header-changes/net_bluetooth_hidp_sock.patch
+++ /dev/null
@@ -1,10 +0,0 @@
---- a/net/bluetooth/hidp/sock.c
-+++ b/net/bluetooth/hidp/sock.c
-@@ -22,6 +22,7 @@
- 
- #include <linux/export.h>
- #include <linux/file.h>
-+#include <linux/compat.h>
- 
- #include "hidp.h"
- 
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops.cocci b/patches/collateral-evolutions/network/11-dev-pm-ops.cocci
deleted file mode 100644
index b89e2f1..0000000
--- a/patches/collateral-evolutions/network/11-dev-pm-ops.cocci
+++ /dev/null
@@ -1,42 +0,0 @@
-// The 2.6.29 kernel has new struct dev_pm_ops [1] which are used
-// on the pci device to distinguish power management hooks for suspend
-// to RAM and hibernation. Older kernels don't have these so we need
-// to resort back to the good ol' suspend/resume. Fortunately the calls
-// are not so different so it should be possible to resuse the same
-// calls on compat code with only slight modifications.
-//
-// [1] http://lxr.linux.no/#linux+v2.6.29/include/linux/pm.h#L170
-
-@ module_pci @
-declarer name MODULE_DEVICE_TABLE;
-identifier pci_ids;
-@@
-
-MODULE_DEVICE_TABLE(pci, pci_ids);
-
-@ simple_dev_pm depends on module_pci @
-identifier ops, pci_suspend, pci_resume;
-declarer name SIMPLE_DEV_PM_OPS;
-declarer name compat_pci_suspend;
-declarer name compat_pci_resume;
-@@
-
-+compat_pci_suspend(pci_suspend);
-+compat_pci_resume(pci_resume);
-SIMPLE_DEV_PM_OPS(ops, pci_suspend, pci_resume);
-
-@@
-identifier backport_driver;
-expression pm_ops;
-fresh identifier backports_pci_suspend = simple_dev_pm.pci_suspend ## "_compat";
-fresh identifier backports_pci_resume = simple_dev_pm.pci_resume ## "_compat";
-@@
-
-struct pci_driver backport_driver = {
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
-	.driver.pm  = pm_ops,
-+#elif defined(CONFIG_PM_SLEEP)
-+	.suspend    = backports_pci_suspend,
-+	.resume     = backports_pci_resume,
-+#endif
-};
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_3945-mac.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_3945-mac.patch
deleted file mode 100644
index 08bb6d5..0000000
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_3945-mac.patch
+++ /dev/null
@@ -1,15 +0,0 @@
---- a/drivers/net/wireless/iwlegacy/3945-mac.c
-+++ b/drivers/net/wireless/iwlegacy/3945-mac.c
-@@ -3902,7 +3902,12 @@ static struct pci_driver il3945_driver =
- 	.id_table = il3945_hw_card_ids,
- 	.probe = il3945_pci_probe,
- 	.remove = il3945_pci_remove,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
- 	.driver.pm = IL_LEGACY_PM_OPS,
-+#elif defined(CONFIG_PM)
-+	.suspend = il_pci_suspend_compat,
-+	.resume = il_pci_resume_compat,
-+#endif
- };
- 
- static int __init
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_4965-mac.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_4965-mac.patch
deleted file mode 100644
index 39ca434..0000000
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_4965-mac.patch
+++ /dev/null
@@ -1,15 +0,0 @@
---- a/drivers/net/wireless/iwlegacy/4965-mac.c
-+++ b/drivers/net/wireless/iwlegacy/4965-mac.c
-@@ -6812,7 +6812,12 @@ static struct pci_driver il4965_driver =
- 	.id_table = il4965_hw_card_ids,
- 	.probe = il4965_pci_probe,
- 	.remove = il4965_pci_remove,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
- 	.driver.pm = IL_LEGACY_PM_OPS,
-+#elif defined(CONFIG_PM)
-+	.suspend = il_pci_suspend_compat,
-+	.resume = il_pci_resume_compat,
-+#endif
- };
- 
- static int __init
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_common.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_common.patch
deleted file mode 100644
index 4184e09..0000000
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_iwlegacy_common.patch
+++ /dev/null
@@ -1,35 +0,0 @@
---- a/drivers/net/wireless/iwlegacy/common.c
-+++ b/drivers/net/wireless/iwlegacy/common.c
-@@ -4989,8 +4989,15 @@ il_pci_resume(struct device *device)
- 	return 0;
- }
- 
-+compat_pci_suspend(il_pci_suspend);
-+compat_pci_resume(il_pci_resume);
- SIMPLE_DEV_PM_OPS(il_pm_ops, il_pci_suspend, il_pci_resume);
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
- EXPORT_SYMBOL(il_pm_ops);
-+#else
-+EXPORT_SYMBOL(il_pci_suspend_compat);
-+EXPORT_SYMBOL(il_pci_resume_compat);
-+#endif
- 
- #endif /* CONFIG_PM_SLEEP */
- 
---- a/drivers/net/wireless/iwlegacy/common.h
-+++ b/drivers/net/wireless/iwlegacy/common.h
-@@ -1836,7 +1836,14 @@ __le32 il_add_beacon_time(struct il_priv
- 			  u32 beacon_interval);
- 
- #ifdef CONFIG_PM_SLEEP
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,29))
-+int il_pci_suspend_compat(struct pci_dev *pdev, pm_message_t state);
-+int il_pci_resume_compat(struct pci_dev *pdev);
-+#elif (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,32))
-+extern struct dev_pm_ops il_pm_ops;
-+#else
- extern const struct dev_pm_ops il_pm_ops;
-+#endif
- 
- #define IL_LEGACY_PM_OPS	(&il_pm_ops)
- 
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_libertas_if_spi.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_libertas_if_spi.patch
deleted file mode 100644
index ac630ed..0000000
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_libertas_if_spi.patch
+++ /dev/null
@@ -1,28 +0,0 @@
---- a/drivers/net/wireless/libertas/if_spi.c
-+++ b/drivers/net/wireless/libertas/if_spi.c
-@@ -1244,6 +1244,7 @@ static int libertas_spi_remove(struct sp
- 	return 0;
- }
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
- static int if_spi_suspend(struct device *dev)
- {
- 	struct spi_device *spi = to_spi_device(dev);
-@@ -1277,6 +1278,7 @@ static const struct dev_pm_ops if_spi_pm
- 	.suspend	= if_spi_suspend,
- 	.resume		= if_spi_resume,
- };
-+#endif
- 
- static struct spi_driver libertas_spi_driver = {
- 	.probe	= if_spi_probe,
-@@ -1284,7 +1286,9 @@ static struct spi_driver libertas_spi_dr
- 	.driver = {
- 		.name	= "libertas_spi",
- 		.owner	= THIS_MODULE,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
- 		.pm	= &if_spi_pm_ops,
-+#endif
- 	},
- };
- 
diff --git a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_mwifiex_pcie.patch b/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_mwifiex_pcie.patch
deleted file mode 100644
index 30d8797..0000000
--- a/patches/collateral-evolutions/network/11-dev-pm-ops/drivers_net_wireless_mwifiex_pcie.patch
+++ /dev/null
@@ -1,17 +0,0 @@
---- a/drivers/net/wireless/mwifiex/pcie.c
-+++ b/drivers/net/wireless/mwifiex/pcie.c
-@@ -278,9 +278,14 @@ static struct pci_driver __refdata mwifi
- 	.probe    = mwifiex_pcie_probe,
- 	.remove   = mwifiex_pcie_remove,
- #ifdef CONFIG_PM_SLEEP
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
- 	.driver   = {
- 		.pm = &mwifiex_pcie_pm_ops,
- 	},
-+#else
-+	.suspend    = mwifiex_pcie_suspend_compat,
-+	.resume     = mwifiex_pcie_resume_compat,
-+#endif
- #endif
- 	.shutdown = mwifiex_pcie_shutdown,
- };
diff --git a/patches/collateral-evolutions/network/12-iw_handler-changes/drivers_net_wireless_ipw2x00_ipw2100.patch b/patches/collateral-evolutions/network/12-iw_handler-changes/drivers_net_wireless_ipw2x00_ipw2100.patch
deleted file mode 100644
index 8a3a80d..0000000
--- a/patches/collateral-evolutions/network/12-iw_handler-changes/drivers_net_wireless_ipw2x00_ipw2100.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/net/wireless/ipw2x00/ipw2100.c
-+++ b/drivers/net/wireless/ipw2x00/ipw2100.c
-@@ -6071,7 +6071,11 @@ static struct net_device *ipw2100_alloc_
- 	dev->netdev_ops = &ipw2100_netdev_ops;
- 	dev->ethtool_ops = &ipw2100_ethtool_ops;
- 	dev->wireless_handlers = &ipw2100_wx_handler_def;
-+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,31))
- 	priv->wireless_data.libipw = priv->ieee;
-+#else
-+	priv->wireless_data.ieee80211 = (struct ieee80211_device *) priv->ieee;
-+#endif
- 	dev->wireless_data = &priv->wireless_data;
- 	dev->watchdog_timeo = 3 * HZ;
- 	dev->irq = 0;
diff --git a/patches/collateral-evolutions/network/16-bluetooth/INFO b/patches/collateral-evolutions/network/16-bluetooth/INFO
deleted file mode 100644
index 7df4a68..0000000
--- a/patches/collateral-evolutions/network/16-bluetooth/INFO
+++ /dev/null
@@ -1,3 +0,0 @@
-These changes are required to backport blueooth. A lot can be optimized
-here still, but for now we keep this here.
-
diff --git a/patches/collateral-evolutions/network/16-bluetooth/drivers_bluetooth_hci_ldisc.patch b/patches/collateral-evolutions/network/16-bluetooth/drivers_bluetooth_hci_ldisc.patch
deleted file mode 100644
index da96d99..0000000
--- a/patches/collateral-evolutions/network/16-bluetooth/drivers_bluetooth_hci_ldisc.patch
+++ /dev/null
@@ -1,28 +0,0 @@
---- a/drivers/bluetooth/hci_ldisc.c
-+++ b/drivers/bluetooth/hci_ldisc.c
-@@ -290,8 +290,13 @@ static int hci_uart_tty_open(struct tty_
- 	/* FIXME: why is this needed. Note don't use ldisc_ref here as the
- 	   open path is before the ldisc is referencable */
- 
-+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,30))
- 	if (tty->ldisc->ops->flush_buffer)
- 		tty->ldisc->ops->flush_buffer(tty);
-+#else
-+	if (tty->ldisc.ops->flush_buffer)
-+		tty->ldisc.ops->flush_buffer(tty);
-+#endif
- 	tty_driver_flush_buffer(tty);
- 
- 	return 0;
-@@ -520,7 +525,11 @@ static int hci_uart_tty_ioctl(struct tty
- 		return hu->hdev_flags;
- 
- 	default:
-+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,27))
- 		err = n_tty_ioctl_helper(tty, file, cmd, arg);
-+#else
-+		err = n_tty_ioctl(tty, file, cmd, arg);
-+#endif
- 		break;
- 	}
- 
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_af_bluetooth.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_af_bluetooth.patch
deleted file mode 100644
index bd2d054..0000000
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_af_bluetooth.patch
+++ /dev/null
@@ -1,39 +0,0 @@
---- a/net/bluetooth/af_bluetooth.c
-+++ b/net/bluetooth/af_bluetooth.c
-@@ -104,8 +104,12 @@ void bt_sock_unregister(int proto)
- }
- EXPORT_SYMBOL(bt_sock_unregister);
- 
-+#if defined(CPTCFG_BACKPORT_OPTION_BT_SOCK_CREATE_NEEDS_KERN)
- static int bt_sock_create(struct net *net, struct socket *sock, int proto,
- 			  int kern)
-+#else
-+static int bt_sock_create(struct net *net, struct socket *sock, int proto)
-+#endif
- {
- 	int err;
- 
-@@ -123,7 +127,11 @@ static int bt_sock_create(struct net *ne
- 	read_lock(&bt_proto_lock);
- 
- 	if (bt_proto[proto] && try_module_get(bt_proto[proto]->owner)) {
-+#if defined(CPTCFG_BACKPORT_OPTION_BT_SOCK_CREATE_NEEDS_KERN)
- 		err = bt_proto[proto]->create(net, sock, proto, kern);
-+#else
-+		err = bt_proto[proto]->create(net, sock, proto);
-+#endif
- 		if (!err)
- 			bt_sock_reclassify_lock(sock->sk, proto);
- 		module_put(bt_proto[proto]->owner);
-@@ -459,7 +467,11 @@ int bt_sock_ioctl(struct socket *sock, u
- 		if (sk->sk_state == BT_LISTEN)
- 			return -EINVAL;
- 
-+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,31))
- 		amount = sk->sk_sndbuf - sk_wmem_alloc_get(sk);
-+#else
-+		amount = sk->sk_sndbuf - atomic_read(&sk->sk_wmem_alloc);
-+#endif
- 		if (amount < 0)
- 			amount = 0;
- 		err = put_user(amount, (int __user *) arg);
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_bnep_sock.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_bnep_sock.patch
deleted file mode 100644
index 3e9c40f..0000000
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_bnep_sock.patch
+++ /dev/null
@@ -1,15 +0,0 @@
---- a/net/bluetooth/bnep/sock.c
-+++ b/net/bluetooth/bnep/sock.c
-@@ -186,8 +186,12 @@ static struct proto bnep_proto = {
- 	.obj_size	= sizeof(struct bt_sock)
- };
- 
-+#if defined(CPTCFG_BACKPORT_OPTION_BT_SOCK_CREATE_NEEDS_KERN)
- static int bnep_sock_create(struct net *net, struct socket *sock, int protocol,
- 			    int kern)
-+#else
-+static int bnep_sock_create(struct net *net, struct socket *sock, int protocol)
-+#endif
- {
- 	struct sock *sk;
- 
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_cmtp_capi.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_cmtp_capi.patch
deleted file mode 100644
index 0b7a6e3..0000000
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_cmtp_capi.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/net/bluetooth/cmtp/capi.c
-+++ b/net/bluetooth/cmtp/capi.c
-@@ -384,7 +384,11 @@ static void cmtp_reset_ctr(struct capi_c
- 
- 	BT_DBG("ctrl %p", ctrl);
- 
-+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,30))
- 	capi_ctr_down(ctrl);
-+#else
-+	capi_ctr_reseted(ctrl);
-+#endif
- 
- 	atomic_inc(&session->terminate);
- 	wake_up_process(session->task);
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_cmtp_sock.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_cmtp_sock.patch
deleted file mode 100644
index 24b9355..0000000
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_cmtp_sock.patch
+++ /dev/null
@@ -1,15 +0,0 @@
---- a/net/bluetooth/cmtp/sock.c
-+++ b/net/bluetooth/cmtp/sock.c
-@@ -195,8 +195,12 @@ static struct proto cmtp_proto = {
- 	.obj_size	= sizeof(struct bt_sock)
- };
- 
-+#if defined(CPTCFG_BACKPORT_OPTION_BT_SOCK_CREATE_NEEDS_KERN)
- static int cmtp_sock_create(struct net *net, struct socket *sock, int protocol,
- 			    int kern)
-+#else
-+static int cmtp_sock_create(struct net *net, struct socket *sock, int protocol)
-+#endif
- {
- 	struct sock *sk;
- 
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sock.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sock.patch
deleted file mode 100644
index 5798965..0000000
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hci_sock.patch
+++ /dev/null
@@ -1,29 +0,0 @@
---- a/net/bluetooth/hci_sock.c
-+++ b/net/bluetooth/hci_sock.c
-@@ -1003,8 +1003,13 @@ drop:
- 	goto done;
- }
- 
-+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,31))
- static int hci_sock_setsockopt(struct socket *sock, int level, int optname,
- 			       char __user *optval, unsigned int len)
-+#else
-+static int hci_sock_setsockopt(struct socket *sock, int level, int optname,
-+			       char __user *optval, int len)
-+#endif
- {
- 	struct hci_ufilter uf = { .opcode = 0 };
- 	struct sock *sk = sock->sk;
-@@ -1178,8 +1183,12 @@ static struct proto hci_sk_proto = {
- 	.obj_size	= sizeof(struct hci_pinfo)
- };
- 
-+#if defined(CPTCFG_BACKPORT_OPTION_BT_SOCK_CREATE_NEEDS_KERN)
- static int hci_sock_create(struct net *net, struct socket *sock, int protocol,
- 			   int kern)
-+#else
-+static int hci_sock_create(struct net *net, struct socket *sock, int protocol)
-+#endif
- {
- 	struct sock *sk;
- 
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_sock.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_sock.patch
deleted file mode 100644
index 3bd4644..0000000
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_hidp_sock.patch
+++ /dev/null
@@ -1,15 +0,0 @@
---- a/net/bluetooth/hidp/sock.c
-+++ b/net/bluetooth/hidp/sock.c
-@@ -226,8 +226,12 @@ static struct proto hidp_proto = {
- 	.obj_size	= sizeof(struct bt_sock)
- };
- 
-+#if defined(CPTCFG_BACKPORT_OPTION_BT_SOCK_CREATE_NEEDS_KERN)
- static int hidp_sock_create(struct net *net, struct socket *sock, int protocol,
- 			    int kern)
-+#else
-+static int hidp_sock_create(struct net *net, struct socket *sock, int protocol)
-+#endif
- {
- 	struct sock *sk;
- 
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_l2cap_sock.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_l2cap_sock.patch
deleted file mode 100644
index e5e7c75..0000000
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_l2cap_sock.patch
+++ /dev/null
@@ -1,41 +0,0 @@
---- a/net/bluetooth/l2cap_sock.c
-+++ b/net/bluetooth/l2cap_sock.c
-@@ -733,8 +733,13 @@ static int l2cap_sock_setsockopt_old(str
- 	return err;
- }
- 
-+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,31))
- static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
- 				 char __user *optval, unsigned int optlen)
-+#else
-+static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
-+				 char __user *optval, int optlen)
-+#endif
- {
- 	struct sock *sk = sock->sk;
- 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
-@@ -1527,8 +1532,12 @@ static struct sock *l2cap_sock_alloc(str
- 	return sk;
- }
- 
-+#if defined(CPTCFG_BACKPORT_OPTION_BT_SOCK_CREATE_NEEDS_KERN)
- static int l2cap_sock_create(struct net *net, struct socket *sock, int protocol,
- 			     int kern)
-+#else
-+static int l2cap_sock_create(struct net *net, struct socket *sock, int protocol)
-+#endif
- {
- 	struct sock *sk;
- 
-@@ -1540,7 +1549,11 @@ static int l2cap_sock_create(struct net
- 	    sock->type != SOCK_DGRAM && sock->type != SOCK_RAW)
- 		return -ESOCKTNOSUPPORT;
- 
-+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,32))
- 	if (sock->type == SOCK_RAW && !kern && !capable(CAP_NET_RAW))
-+#else
-+	if (sock->type == SOCK_RAW && !capable(CAP_NET_RAW))
-+#endif
- 		return -EPERM;
- 
- 	sock->ops = &l2cap_sock_ops;
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_sock.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_sock.patch
deleted file mode 100644
index f6b84b5..0000000
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_sock.patch
+++ /dev/null
@@ -1,28 +0,0 @@
---- a/net/bluetooth/rfcomm/sock.c
-+++ b/net/bluetooth/rfcomm/sock.c
-@@ -310,8 +310,13 @@ static struct sock *rfcomm_sock_alloc(st
- 	return sk;
- }
- 
-+#if defined(CPTCFG_BACKPORT_OPTION_BT_SOCK_CREATE_NEEDS_KERN)
- static int rfcomm_sock_create(struct net *net, struct socket *sock,
- 			      int protocol, int kern)
-+#else
-+static int rfcomm_sock_create(struct net *net, struct socket *sock,
-+			      int protocol)
-+#endif
- {
- 	struct sock *sk;
- 
-@@ -681,7 +686,11 @@ static int rfcomm_sock_setsockopt_old(st
- 	return err;
- }
- 
-+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,31))
- static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname, char __user *optval, unsigned int optlen)
-+#else
-+static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname, char __user *optval, int optlen)
-+#endif
- {
- 	struct sock *sk = sock->sk;
- 	struct bt_security sec;
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_tty.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_tty.patch
deleted file mode 100644
index 286e167..0000000
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_rfcomm_tty.patch
+++ /dev/null
@@ -1,38 +0,0 @@
---- a/net/bluetooth/rfcomm/tty.c
-+++ b/net/bluetooth/rfcomm/tty.c
-@@ -822,7 +822,11 @@ static int rfcomm_tty_write_room(struct
- 	return room;
- }
- 
-+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,38))
- static int rfcomm_tty_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
-+#else
-+static int rfcomm_tty_ioctl(struct tty_struct *tty, struct file *filp, unsigned int cmd, unsigned long arg)
-+#endif
- {
- 	BT_DBG("tty %p cmd 0x%02x", tty, cmd);
- 
-@@ -1071,7 +1075,11 @@ static void rfcomm_tty_hangup(struct tty
- 	tty_port_hangup(&dev->port);
- }
- 
-+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,38))
- static int rfcomm_tty_tiocmget(struct tty_struct *tty)
-+#else
-+static int rfcomm_tty_tiocmget(struct tty_struct *tty, struct file *filp)
-+#endif
- {
- 	struct rfcomm_dev *dev = (struct rfcomm_dev *) tty->driver_data;
- 
-@@ -1080,7 +1088,11 @@ static int rfcomm_tty_tiocmget(struct tt
- 	return dev->modem_status;
- }
- 
-+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,38))
- static int rfcomm_tty_tiocmset(struct tty_struct *tty, unsigned int set, unsigned int clear)
-+#else
-+static int rfcomm_tty_tiocmset(struct tty_struct *tty, struct file *filp, unsigned int set, unsigned int clear)
-+#endif
- {
- 	struct rfcomm_dev *dev = (struct rfcomm_dev *) tty->driver_data;
- 	struct rfcomm_dlc *dlc = dev->dlc;
diff --git a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_sco.patch b/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_sco.patch
deleted file mode 100644
index 57d4b61..0000000
--- a/patches/collateral-evolutions/network/16-bluetooth/net_bluetooth_sco.patch
+++ /dev/null
@@ -1,27 +0,0 @@
---- a/net/bluetooth/sco.c
-+++ b/net/bluetooth/sco.c
-@@ -426,8 +426,12 @@ static struct sock *sco_sock_alloc(struc
- 	return sk;
- }
- 
-+#if defined(CPTCFG_BACKPORT_OPTION_BT_SOCK_CREATE_NEEDS_KERN)
- static int sco_sock_create(struct net *net, struct socket *sock, int protocol,
- 			   int kern)
-+#else
-+static int sco_sock_create(struct net *net, struct socket *sock, int protocol)
-+#endif
- {
- 	struct sock *sk;
- 
-@@ -721,7 +725,11 @@ static int sco_sock_recvmsg(struct kiocb
- 	return bt_sock_recvmsg(iocb, sock, msg, len, flags);
- }
- 
-+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,31))
- static int sco_sock_setsockopt(struct socket *sock, int level, int optname, char __user *optval, unsigned int optlen)
-+#else
-+static int sco_sock_setsockopt(struct socket *sock, int level, int optname, char __user *optval, int optlen)
-+#endif
- {
- 	struct sock *sk = sock->sk;
- 	int len, err = 0;
diff --git a/patches/collateral-evolutions/network/17-netdev-queue/INFO b/patches/collateral-evolutions/network/17-netdev-queue/INFO
deleted file mode 100644
index ea3688d..0000000
--- a/patches/collateral-evolutions/network/17-netdev-queue/INFO
+++ /dev/null
@@ -1,14 +0,0 @@
-This patch addresses changes made by usage of new symbols
-like unregister_netdevice_queue() which are not possible to backport
-due to their reliance on internal symbols on net/core/dev.c
-
-The patch that introduced this on mac80211 was:
-
-    mac80211: Speedup ieee80211_remove_interfaces()
-    
-    Speedup ieee80211_remove_interfaces() by factorizing synchronize_rcu() calls
-    
-    Signed-off-by: Eric Dumazet <eric.dumazet@gmail.com>
-    Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
-    Signed-off-by: John W. Linville <linville@tuxdriver.com>
-
diff --git a/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch b/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
deleted file mode 100644
index 70b407a..0000000
--- a/patches/collateral-evolutions/network/17-netdev-queue/net_mac80211_iface.patch
+++ /dev/null
@@ -1,33 +0,0 @@
---- a/net/mac80211/iface.c
-+++ b/net/mac80211/iface.c
-@@ -1732,6 +1732,7 @@ void ieee80211_sdata_stop(struct ieee802
-  * Remove all interfaces, may only be called at hardware unregistration
-  * time because it doesn't do RCU-safe list removals.
-  */
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,33))
- void ieee80211_remove_interfaces(struct ieee80211_local *local)
- {
- 	struct ieee80211_sub_if_data *sdata, *tmp;
-@@ -1768,6 +1769,22 @@ void ieee80211_remove_interfaces(struct
- 		kfree(sdata);
- 	}
- }
-+#else
-+void ieee80211_remove_interfaces(struct ieee80211_local *local)
-+{
-+	struct ieee80211_sub_if_data *sdata, *tmp;
-+
-+	ASSERT_RTNL();
-+
-+	list_for_each_entry_safe(sdata, tmp, &local->interfaces, list) {
-+		mutex_lock(&local->iflist_mtx);
-+		list_del(&sdata->list);
-+		mutex_unlock(&local->iflist_mtx);
-+
-+		unregister_netdevice(sdata->dev);
-+	}
-+}
-+#endif
- 
- static int netdev_notify(struct notifier_block *nb,
- 			 unsigned long state, void *ptr)
diff --git a/patches/collateral-evolutions/network/21-capi-proc_fops/INFO b/patches/collateral-evolutions/network/21-capi-proc_fops/INFO
deleted file mode 100644
index 30afaec..0000000
--- a/patches/collateral-evolutions/network/21-capi-proc_fops/INFO
+++ /dev/null
@@ -1,3 +0,0 @@
-Backport kernel patch 9a58a80a701bdb2d220cdab4914218df5b48d781
-proc_fops: convert drivers/isdn/ to seq_file
-
diff --git a/patches/collateral-evolutions/network/21-capi-proc_fops/net_bluetooth_cmtp_capi.patch b/patches/collateral-evolutions/network/21-capi-proc_fops/net_bluetooth_cmtp_capi.patch
deleted file mode 100644
index 7bc09ca..0000000
--- a/patches/collateral-evolutions/network/21-capi-proc_fops/net_bluetooth_cmtp_capi.patch
+++ /dev/null
@@ -1,70 +0,0 @@
---- a/net/bluetooth/cmtp/capi.c
-+++ b/net/bluetooth/cmtp/capi.c
-@@ -21,8 +21,10 @@
- */
- 
- #include <linux/export.h>
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
- #include <linux/proc_fs.h>
- #include <linux/seq_file.h>
-+#endif
- #include <linux/types.h>
- #include <linux/errno.h>
- #include <linux/kernel.h>
-@@ -522,6 +524,7 @@ static char *cmtp_procinfo(struct capi_c
- 	return "CAPI Message Transport Protocol";
- }
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
- static int cmtp_proc_show(struct seq_file *m, void *v)
- {
- 	struct capi_ctr *ctrl = m->private;
-@@ -554,6 +557,36 @@ static const struct file_operations cmtp
- 	.release	= single_release,
- };
- 
-+#else
-+
-+static int cmtp_ctr_read_proc(char *page, char **start, off_t off, int count, int *eof, struct capi_ctr *ctrl)
-+{
-+	struct cmtp_session *session = ctrl->driverdata;
-+	struct cmtp_application *app;
-+	struct list_head *p, *n;
-+	int len = 0;
-+
-+	len += sprintf(page + len, "%s\n\n", cmtp_procinfo(ctrl));
-+	len += sprintf(page + len, "addr %s\n", session->name);
-+	len += sprintf(page + len, "ctrl %d\n", session->num);
-+
-+	list_for_each_safe(p, n, &session->applications) {
-+		app = list_entry(p, struct cmtp_application, list);
-+		len += sprintf(page + len, "appl %d -> %d\n", app->appl, app->mapping);
-+	}
-+
-+	if (off + count >= len)
-+		*eof = 1;
-+
-+	if (len < off)
-+		return 0;
-+
-+	*start = page + off;
-+
-+	return ((count < len - off) ? count : len - off);
-+}
-+#endif
-+
- int cmtp_attach_device(struct cmtp_session *session)
- {
- 	unsigned char buf[4];
-@@ -592,7 +625,11 @@ int cmtp_attach_device(struct cmtp_sessi
- 	session->ctrl.send_message  = cmtp_send_message;
- 
- 	session->ctrl.procinfo      = cmtp_procinfo;
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
- 	session->ctrl.proc_fops = &cmtp_proc_fops;
-+#else
-+	session->ctrl.ctr_read_proc = cmtp_ctr_read_proc;
-+#endif
- 
- 	if (attach_capi_ctr(&session->ctrl) < 0) {
- 		BT_ERR("Can't attach new controller");
diff --git a/patches/collateral-evolutions/network/22-multiqueue/INFO b/patches/collateral-evolutions/network/22-multiqueue/INFO
deleted file mode 100644
index bcb4eec..0000000
--- a/patches/collateral-evolutions/network/22-multiqueue/INFO
+++ /dev/null
@@ -1,30 +0,0 @@
-Backport multiqueue support for kernels 2.6.23-27
-
-The 2.6.23 kernel added some initial multiqueue support.
-That release relied on the on the notion of struct
-net_device_subqueue attached to the netdevice struct
-as an array. The 2.6.27 renamed these to struct netdev_queue,
-and enhanced MQ support by providing locks separately onto
-each queue. MQ support on 2.6.27 also extended each netdev
-to be able to assign a select_queue callback to be used by
-core networking for prior to pushing the skb out to the device
-driver so that queue selection can be dealt with and
-customized internally on the driver.
-
-For kernels 2.6.23..2.6.26 then we backport MQ support by
-using the equivalent calls on the struct netdev_queue to
-the struct net_device_subqueue. The performance penalty
-here is just that all these queues share a common lock
-so stateful operations on one queue would imply a delay
-on other queues.
-
-The select_queue callback was only added as of 2.6.27 via
-commit eae792b7 so for kernels 2.6.23 up to 2.6.27 we must
-ensure we do the selection of the queue once the core
-networking calls mac80211's dev_hard_start_xmit()
-(ndo_start_xmit() callback on newer kernels).
-
-This patch thus only addresses the lack of select_queue on
-kernels older than 2.6.27, naming differences are handled
-in compat.
-
diff --git a/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch b/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
deleted file mode 100644
index 3894a96..0000000
--- a/patches/collateral-evolutions/network/22-multiqueue/net_mac80211_tx.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/net/mac80211/tx.c
-+++ b/net/mac80211/tx.c
-@@ -1526,6 +1526,10 @@ void ieee80211_xmit(struct ieee80211_sub
- 		}
- 	}
- 
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27))
-+	/* Older kernels do not have the select_queue callback */
-+	skb_set_queue_mapping(skb, ieee80211_select_queue(sdata, skb));
-+#endif
- 	ieee80211_set_qos_hdr(sdata, skb);
- 	ieee80211_tx(sdata, skb, false, band);
- }
diff --git a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bluecard_cs.patch b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bluecard_cs.patch
deleted file mode 100644
index 4bcad40..0000000
--- a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bluecard_cs.patch
+++ /dev/null
@@ -1,191 +0,0 @@
---- a/drivers/bluetooth/bluecard_cs.c
-+++ b/drivers/bluetooth/bluecard_cs.c
-@@ -158,7 +158,12 @@ static void bluecard_detach(struct pcmci
- static void bluecard_activity_led_timeout(u_long arg)
- {
- 	bluecard_info_t *info = (bluecard_info_t *)arg;
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- 	unsigned int iobase = info->p_dev->resource[0]->start;
-+#else
-+	unsigned int iobase = info->p_dev->io.BasePort1;
-+#endif
-+
- 
- 	if (!test_bit(CARD_HAS_PCCARD_ID, &(info->hw_state)))
- 		return;
-@@ -175,7 +180,11 @@ static void bluecard_activity_led_timeou
- 
- static void bluecard_enable_activity_led(bluecard_info_t *info)
- {
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- 	unsigned int iobase = info->p_dev->resource[0]->start;
-+#else
-+	unsigned int iobase = info->p_dev->io.BasePort1;
-+#endif
- 
- 	if (!test_bit(CARD_HAS_PCCARD_ID, &(info->hw_state)))
- 		return;
-@@ -231,7 +240,11 @@ static void bluecard_write_wakeup(blueca
- 	}
- 
- 	do {
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- 		unsigned int iobase = info->p_dev->resource[0]->start;
-+#else
-+		unsigned int iobase = info->p_dev->io.BasePort1;
-+#endif
- 		unsigned int offset;
- 		unsigned char command;
- 		unsigned long ready_bit;
-@@ -379,7 +392,11 @@ static void bluecard_receive(bluecard_in
- 		return;
- 	}
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- 	iobase = info->p_dev->resource[0]->start;
-+#else
-+	iobase = info->p_dev->io.BasePort1;
-+#endif
- 
- 	if (test_bit(XMIT_SENDING_READY, &(info->tx_state)))
- 		bluecard_enable_activity_led(info);
-@@ -508,7 +525,11 @@ static irqreturn_t bluecard_interrupt(in
- 	if (!test_bit(CARD_READY, &(info->hw_state)))
- 		return IRQ_HANDLED;
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- 	iobase = info->p_dev->resource[0]->start;
-+#else
-+	iobase = info->p_dev->io.BasePort1;
-+#endif
- 
- 	spin_lock(&(info->lock));
- 
-@@ -631,7 +652,11 @@ static int bluecard_hci_open(struct hci_
- 		return 0;
- 
- 	if (test_bit(CARD_HAS_PCCARD_ID, &(info->hw_state))) {
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- 		unsigned int iobase = info->p_dev->resource[0]->start;
-+#else
-+		unsigned int iobase = info->p_dev->io.BasePort1;
-+#endif
- 
- 		/* Enable LED */
- 		outb(0x08 | 0x20, iobase + 0x30);
-@@ -651,7 +676,11 @@ static int bluecard_hci_close(struct hci
- 	bluecard_hci_flush(hdev);
- 
- 	if (test_bit(CARD_HAS_PCCARD_ID, &(info->hw_state))) {
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- 		unsigned int iobase = info->p_dev->resource[0]->start;
-+#else
-+		unsigned int iobase = info->p_dev->io.BasePort1;
-+#endif
- 
- 		/* Disable LED */
- 		outb(0x00, iobase + 0x30);
-@@ -693,7 +722,11 @@ static int bluecard_hci_send_frame(struc
- 
- static int bluecard_open(bluecard_info_t *info)
- {
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- 	unsigned int iobase = info->p_dev->resource[0]->start;
-+#else
-+	unsigned int iobase = info->p_dev->io.BasePort1;
-+#endif
- 	struct hci_dev *hdev;
- 	unsigned char id;
- 
-@@ -808,7 +841,11 @@ static int bluecard_open(bluecard_info_t
- 
- static int bluecard_close(bluecard_info_t *info)
- {
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- 	unsigned int iobase = info->p_dev->resource[0]->start;
-+#else
-+	unsigned int iobase = info->p_dev->io.BasePort1;
-+#endif
- 	struct hci_dev *hdev = info->hdev;
- 
- 	if (!hdev)
-@@ -843,7 +880,18 @@ static int bluecard_probe(struct pcmcia_
- 	info->p_dev = link;
- 	link->priv = info;
- 
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35))
-+	link->irq.Attributes = IRQ_TYPE_DYNAMIC_SHARING;
-+
-+	link->irq.Handler = bluecard_interrupt;
-+#endif
-+
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
- 	link->config_flags |= CONF_ENABLE_IRQ;
-+#else
-+	link->conf.Attributes = CONF_ENABLE_IRQ;
-+	link->conf.IntType = INT_MEMORY_AND_IO;
-+#endif
- 
- 	return bluecard_config(link);
- }
-@@ -860,15 +908,30 @@ static int bluecard_config(struct pcmcia
- 	bluecard_info_t *info = link->priv;
- 	int i, n;
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
- 	link->config_index = 0x20;
-+#else
-+	link->conf.ConfigIndex = 0x20;
-+#endif
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- 	link->resource[0]->flags |= IO_DATA_PATH_WIDTH_8;
- 	link->resource[0]->end = 64;
- 	link->io_lines = 6;
-+#else
-+	link->io.Attributes1 = IO_DATA_PATH_WIDTH_8;
-+	link->io.NumPorts1 = 64;
-+	link->io.IOAddrLines = 6;
-+#endif
- 
- 	for (n = 0; n < 0x400; n += 0x40) {
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- 		link->resource[0]->start = n ^ 0x300;
- 		i = pcmcia_request_io(link);
-+#else
-+		link->io.BasePort1 = n ^ 0x300;
-+		i = pcmcia_request_io(link, &link->io);
-+#endif
- 		if (i == 0)
- 			break;
- 	}
-@@ -876,9 +939,15 @@ static int bluecard_config(struct pcmcia
- 	if (i != 0)
- 		goto failed;
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	i = pcmcia_request_irq(link, bluecard_interrupt);
- 	if (i != 0)
- 		goto failed;
-+#else
-+	i = pcmcia_request_irq(link, &link->irq);
-+	if (i != 0)
-+		link->irq.AssignedIRQ = 0;
-+#endif
- 
- 	i = pcmcia_enable_device(link);
- 	if (i != 0)
-@@ -916,7 +985,13 @@ MODULE_DEVICE_TABLE(pcmcia, bluecard_ids
- 
- static struct pcmcia_driver bluecard_driver = {
- 	.owner		= THIS_MODULE,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
- 	.name		= "bluecard_cs",
-+#else
-+	.drv		= {
-+		.name	= "bluecard_cs",
-+	},
-+#endif
- 	.probe		= bluecard_probe,
- 	.remove		= bluecard_detach,
- 	.id_table	= bluecard_ids,
diff --git a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bt3c_cs.patch b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bt3c_cs.patch
deleted file mode 100644
index 80ad588..0000000
--- a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_bt3c_cs.patch
+++ /dev/null
@@ -1,180 +0,0 @@
---- a/drivers/bluetooth/bt3c_cs.c
-+++ b/drivers/bluetooth/bt3c_cs.c
-@@ -186,7 +186,11 @@ static void bt3c_write_wakeup(bt3c_info_
- 		return;
- 
- 	do {
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- 		unsigned int iobase = info->p_dev->resource[0]->start;
-+#else
-+		unsigned int iobase = info->p_dev->io.BasePort1;
-+#endif
- 		register struct sk_buff *skb;
- 		int len;
- 
-@@ -224,7 +228,11 @@ static void bt3c_receive(bt3c_info_t *in
- 		return;
- 	}
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- 	iobase = info->p_dev->resource[0]->start;
-+#else
-+	iobase = info->p_dev->io.BasePort1;
-+#endif
- 
- 	avail = bt3c_read(iobase, 0x7006);
- 	//printk("bt3c_cs: receiving %d bytes\n", avail);
-@@ -345,7 +353,11 @@ static irqreturn_t bt3c_interrupt(int ir
- 		/* our irq handler is shared */
- 		return IRQ_NONE;
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- 	iobase = info->p_dev->resource[0]->start;
-+#else
-+	iobase = info->p_dev->io.BasePort1;
-+#endif
- 
- 	spin_lock(&(info->lock));
- 
-@@ -459,7 +471,11 @@ static int bt3c_load_firmware(bt3c_info_
- 	unsigned int iobase, size, addr, fcs, tmp;
- 	int i, err = 0;
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- 	iobase = info->p_dev->resource[0]->start;
-+#else
-+	iobase = info->p_dev->io.BasePort1;
-+#endif
- 
- 	/* Reset */
- 	bt3c_io_write(iobase, 0x8040, 0x0404);
-@@ -630,8 +646,27 @@ static int bt3c_probe(struct pcmcia_devi
- 	info->p_dev = link;
- 	link->priv = info;
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
- 	link->config_flags |= CONF_ENABLE_IRQ | CONF_AUTO_SET_VPP |
- 		CONF_AUTO_SET_IO;
-+#else
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
-+	link->resource[0]->flags |= IO_DATA_PATH_WIDTH_8;
-+	link->resource[0]->end = 8;
-+#else
-+	link->io.Attributes1 = IO_DATA_PATH_WIDTH_8;
-+	link->io.NumPorts1= 8;
-+#endif
-+
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35))
-+	link->irq.Attributes = IRQ_TYPE_DYNAMIC_SHARING;
-+
-+	link->irq.Handler = bt3c_interrupt;
-+#endif
-+
-+	link->conf.Attributes = CONF_ENABLE_IRQ;
-+	link->conf.IntType = INT_MEMORY_AND_IO;
-+#endif
- 
- 	return bt3c_config(link);
- }
-@@ -642,6 +677,7 @@ static void bt3c_detach(struct pcmcia_de
- 	bt3c_release(link);
- }
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
- static int bt3c_check_config(struct pcmcia_device *p_dev, void *priv_data)
- {
- 	int *try = priv_data;
-@@ -680,6 +716,63 @@ static int bt3c_check_config_notpicky(st
- 	}
- 	return -ENODEV;
- }
-+#else
-+static int bt3c_check_config(struct pcmcia_device *p_dev,
-+			     cistpl_cftable_entry_t *cf,
-+			     cistpl_cftable_entry_t *dflt,
-+			     unsigned int vcc,
-+			     void *priv_data)
-+{
-+	unsigned long try = (unsigned long) priv_data;
-+
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
-+	p_dev->io_lines = (try == 0) ? 16 : cf->io.flags & CISTPL_IO_LINES_MASK;
-+#endif
-+
-+	if (cf->vpp1.present & (1 << CISTPL_POWER_VNOM))
-+		p_dev->conf.Vpp = cf->vpp1.param[CISTPL_POWER_VNOM] / 10000;
-+	if ((cf->io.nwin > 0) && (cf->io.win[0].len == 8) &&
-+	    (cf->io.win[0].base != 0)) {
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
-+		p_dev->resource[0]->start = cf->io.win[0].base;
-+		if (!pcmcia_request_io(p_dev))
-+#else
-+		p_dev->io.BasePort1 = cf->io.win[0].base;
-+		p_dev->io.IOAddrLines = (try == 0) ? 16 :
-+			cf->io.flags & CISTPL_IO_LINES_MASK;
-+		if (!pcmcia_request_io(p_dev, &p_dev->io))
-+#endif
-+			return 0;
-+	}
-+	return -ENODEV;
-+}
-+
-+static int bt3c_check_config_notpicky(struct pcmcia_device *p_dev,
-+				      cistpl_cftable_entry_t *cf,
-+				      cistpl_cftable_entry_t *dflt,
-+				      unsigned int vcc,
-+				      void *priv_data)
-+{
-+	static unsigned int base[5] = { 0x3f8, 0x2f8, 0x3e8, 0x2e8, 0x0 };
-+	int j;
-+
-+	if ((cf->io.nwin > 0) && ((cf->io.flags & CISTPL_IO_LINES_MASK) <= 3)) {
-+		for (j = 0; j < 5; j++) {
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
-+			p_dev->resource[0]->start = base[j];
-+			p_dev->io_lines = base[j] ? 16 : 3;
-+			if (!pcmcia_request_io(p_dev))
-+#else
-+			p_dev->io.BasePort1 = base[j];
-+			p_dev->io.IOAddrLines = base[j] ? 16 : 3;
-+			if (!pcmcia_request_io(p_dev, &p_dev->io))
-+#endif
-+				return 0;
-+		}
-+	}
-+	return -ENODEV;
-+}
-+#endif
- 
- static int bt3c_config(struct pcmcia_device *link)
- {
-@@ -703,9 +796,15 @@ static int bt3c_config(struct pcmcia_dev
- 	goto failed;
- 
- found_port:
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	i = pcmcia_request_irq(link, &bt3c_interrupt);
- 	if (i != 0)
- 		goto failed;
-+#else
-+	i = pcmcia_request_irq(link, &link->irq);
-+	if (i != 0)
-+		link->irq.AssignedIRQ = 0;
-+#endif
- 
- 	i = pcmcia_enable_device(link);
- 	if (i != 0)
-@@ -740,7 +839,13 @@ MODULE_DEVICE_TABLE(pcmcia, bt3c_ids);
- 
- static struct pcmcia_driver bt3c_driver = {
- 	.owner		= THIS_MODULE,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
- 	.name		= "bt3c_cs",
-+#else
-+	.drv		= {
-+		.name	= "bt3c_cs",
-+	},
-+#endif
- 	.probe		= bt3c_probe,
- 	.remove		= bt3c_detach,
- 	.id_table	= bt3c_ids,
diff --git a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_btuart_cs.patch b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_btuart_cs.patch
deleted file mode 100644
index 50941bf..0000000
--- a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_btuart_cs.patch
+++ /dev/null
@@ -1,204 +0,0 @@
---- a/drivers/bluetooth/btuart_cs.c
-+++ b/drivers/bluetooth/btuart_cs.c
-@@ -140,7 +140,11 @@ static void btuart_write_wakeup(btuart_i
- 	}
- 
- 	do {
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- 		unsigned int iobase = info->p_dev->resource[0]->start;
-+#else
-+		unsigned int iobase = info->p_dev->io.BasePort1;
-+#endif
- 		register struct sk_buff *skb;
- 		int len;
- 
-@@ -182,7 +186,11 @@ static void btuart_receive(btuart_info_t
- 		return;
- 	}
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- 	iobase = info->p_dev->resource[0]->start;
-+#else
-+	iobase = info->p_dev->io.BasePort1;
-+#endif
- 
- 	do {
- 		info->hdev->stat.byte_rx++;
-@@ -296,7 +304,11 @@ static irqreturn_t btuart_interrupt(int
- 		/* our irq handler is shared */
- 		return IRQ_NONE;
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- 	iobase = info->p_dev->resource[0]->start;
-+#else
-+	iobase = info->p_dev->io.BasePort1;
-+#endif
- 
- 	spin_lock(&(info->lock));
- 
-@@ -353,7 +365,11 @@ static void btuart_change_speed(btuart_i
- 		return;
- 	}
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- 	iobase = info->p_dev->resource[0]->start;
-+#else
-+	iobase = info->p_dev->io.BasePort1;
-+#endif
- 
- 	spin_lock_irqsave(&(info->lock), flags);
- 
-@@ -458,7 +474,11 @@ static int btuart_hci_send_frame(struct
- static int btuart_open(btuart_info_t *info)
- {
- 	unsigned long flags;
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- 	unsigned int iobase = info->p_dev->resource[0]->start;
-+#else
-+	unsigned int iobase = info->p_dev->io.BasePort1;
-+#endif
- 	struct hci_dev *hdev;
- 
- 	spin_lock_init(&(info->lock));
-@@ -524,7 +544,11 @@ static int btuart_open(btuart_info_t *in
- static int btuart_close(btuart_info_t *info)
- {
- 	unsigned long flags;
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- 	unsigned int iobase = info->p_dev->resource[0]->start;
-+#else
-+	unsigned int iobase = info->p_dev->io.BasePort1;
-+#endif
- 	struct hci_dev *hdev = info->hdev;
- 
- 	if (!hdev)
-@@ -560,8 +584,27 @@ static int btuart_probe(struct pcmcia_de
- 	info->p_dev = link;
- 	link->priv = info;
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
- 	link->config_flags |= CONF_ENABLE_IRQ | CONF_AUTO_SET_VPP |
- 		CONF_AUTO_SET_IO;
-+#else
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
-+	link->resource[0]->flags |= IO_DATA_PATH_WIDTH_8;
-+	link->resource[0]->end = 8;
-+#else
-+	link->io.Attributes1 = IO_DATA_PATH_WIDTH_8;
-+	link->io.NumPorts1= 8;
-+#endif
-+
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35))
-+	link->irq.Attributes = IRQ_TYPE_DYNAMIC_SHARING;
-+
-+	link->irq.Handler = btuart_interrupt;
-+#endif
-+
-+	link->conf.Attributes = CONF_ENABLE_IRQ;
-+	link->conf.IntType = INT_MEMORY_AND_IO;
-+#endif
- 
- 	return btuart_config(link);
- }
-@@ -572,6 +615,7 @@ static void btuart_detach(struct pcmcia_
- 	btuart_release(link);
- }
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
- static int btuart_check_config(struct pcmcia_device *p_dev, void *priv_data)
- {
- 	int *try = priv_data;
-@@ -610,6 +654,63 @@ static int btuart_check_config_notpicky(
- 	}
- 	return -ENODEV;
- }
-+#else
-+static int btuart_check_config(struct pcmcia_device *p_dev,
-+			       cistpl_cftable_entry_t *cf,
-+			       cistpl_cftable_entry_t *dflt,
-+			       unsigned int vcc,
-+			       void *priv_data)
-+{
-+	int *try = priv_data;
-+
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
-+	p_dev->io_lines = (try == 0) ? 16 : cf->io.flags & CISTPL_IO_LINES_MASK;
-+#endif
-+
-+	if (cf->vpp1.present & (1 << CISTPL_POWER_VNOM))
-+		p_dev->conf.Vpp = cf->vpp1.param[CISTPL_POWER_VNOM] / 10000;
-+	if ((cf->io.nwin > 0) && (cf->io.win[0].len == 8) &&
-+	    (cf->io.win[0].base != 0)) {
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
-+		p_dev->resource[0]->start = cf->io.win[0].base;
-+		if (!pcmcia_request_io(p_dev))
-+#else
-+		p_dev->io.BasePort1 = cf->io.win[0].base;
-+		p_dev->io.IOAddrLines = (*try == 0) ? 16 :
-+			cf->io.flags & CISTPL_IO_LINES_MASK;
-+		if (!pcmcia_request_io(p_dev, &p_dev->io))
-+#endif
-+			return 0;
-+	}
-+	return -ENODEV;
-+}
-+
-+static int btuart_check_config_notpicky(struct pcmcia_device *p_dev,
-+					cistpl_cftable_entry_t *cf,
-+					cistpl_cftable_entry_t *dflt,
-+					unsigned int vcc,
-+					void *priv_data)
-+{
-+	static unsigned int base[5] = { 0x3f8, 0x2f8, 0x3e8, 0x2e8, 0x0 };
-+	int j;
-+
-+	if ((cf->io.nwin > 0) && ((cf->io.flags & CISTPL_IO_LINES_MASK) <= 3)) {
-+		for (j = 0; j < 5; j++) {
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
-+			p_dev->resource[0]->start = base[j];
-+			p_dev->io_lines = base[j] ? 16 : 3;
-+			if (!pcmcia_request_io(p_dev))
-+#else
-+			p_dev->io.BasePort1 = base[j];
-+			p_dev->io.IOAddrLines = base[j] ? 16 : 3;
-+			if (!pcmcia_request_io(p_dev, &p_dev->io))
-+#endif
-+				return 0;
-+		}
-+	}
-+	return -ENODEV;
-+}
-+#endif
- 
- static int btuart_config(struct pcmcia_device *link)
- {
-@@ -633,9 +734,15 @@ static int btuart_config(struct pcmcia_d
- 	goto failed;
- 
- found_port:
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	i = pcmcia_request_irq(link, btuart_interrupt);
- 	if (i != 0)
- 		goto failed;
-+#else
-+	i = pcmcia_request_irq(link, &link->irq);
-+	if (i != 0)
-+		link->irq.AssignedIRQ = 0;
-+#endif
- 
- 	i = pcmcia_enable_device(link);
- 	if (i != 0)
-@@ -669,7 +776,13 @@ MODULE_DEVICE_TABLE(pcmcia, btuart_ids);
- 
- static struct pcmcia_driver btuart_driver = {
- 	.owner		= THIS_MODULE,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
- 	.name		= "btuart_cs",
-+#else
-+	.drv		= {
-+		.name	= "btuart_cs",
-+	},
-+#endif
- 	.probe		= btuart_probe,
- 	.remove		= btuart_detach,
- 	.id_table	= btuart_ids,
diff --git a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_dtl1_cs.patch b/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_dtl1_cs.patch
deleted file mode 100644
index 66d4b2f..0000000
--- a/patches/collateral-evolutions/network/24-pcmcia/drivers_bluetooth_dtl1_cs.patch
+++ /dev/null
@@ -1,178 +0,0 @@
---- a/drivers/bluetooth/dtl1_cs.c
-+++ b/drivers/bluetooth/dtl1_cs.c
-@@ -144,7 +144,11 @@ static void dtl1_write_wakeup(dtl1_info_
- 	}
- 
- 	do {
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- 		unsigned int iobase = info->p_dev->resource[0]->start;
-+#else
-+		unsigned int iobase = info->p_dev->io.BasePort1;
-+#endif
- 		register struct sk_buff *skb;
- 		int len;
- 
-@@ -210,7 +214,11 @@ static void dtl1_receive(dtl1_info_t *in
- 		return;
- 	}
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- 	iobase = info->p_dev->resource[0]->start;
-+#else
-+	iobase = info->p_dev->io.BasePort1;
-+#endif
- 
- 	do {
- 		info->hdev->stat.byte_rx++;
-@@ -298,7 +306,11 @@ static irqreturn_t dtl1_interrupt(int ir
- 		/* our irq handler is shared */
- 		return IRQ_NONE;
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- 	iobase = info->p_dev->resource[0]->start;
-+#else
-+	iobase = info->p_dev->io.BasePort1;
-+#endif
- 
- 	spin_lock(&(info->lock));
- 
-@@ -439,7 +451,11 @@ static int dtl1_hci_send_frame(struct hc
- static int dtl1_open(dtl1_info_t *info)
- {
- 	unsigned long flags;
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- 	unsigned int iobase = info->p_dev->resource[0]->start;
-+#else
-+	unsigned int iobase = info->p_dev->io.BasePort1;
-+#endif
- 	struct hci_dev *hdev;
- 
- 	spin_lock_init(&(info->lock));
-@@ -482,8 +498,13 @@ static int dtl1_open(dtl1_info_t *info)
- 	outb(UART_LCR_WLEN8, iobase + UART_LCR);	/* Reset DLAB */
- 	outb((UART_MCR_DTR | UART_MCR_RTS | UART_MCR_OUT2), iobase + UART_MCR);
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- 	info->ri_latch = inb(info->p_dev->resource[0]->start + UART_MSR)
- 				& UART_MSR_RI;
-+#else
-+	info->ri_latch = inb(info->p_dev->io.BasePort1 + UART_MSR)
-+				& UART_MSR_RI;
-+#endif
- 
- 	/* Turn on interrupts */
- 	outb(UART_IER_RLSI | UART_IER_RDI | UART_IER_THRI, iobase + UART_IER);
-@@ -508,7 +529,11 @@ static int dtl1_open(dtl1_info_t *info)
- static int dtl1_close(dtl1_info_t *info)
- {
- 	unsigned long flags;
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- 	unsigned int iobase = info->p_dev->resource[0]->start;
-+#else
-+	unsigned int iobase = info->p_dev->io.BasePort1;
-+#endif
- 	struct hci_dev *hdev = info->hdev;
- 
- 	if (!hdev)
-@@ -544,7 +569,24 @@ static int dtl1_probe(struct pcmcia_devi
- 	info->p_dev = link;
- 	link->priv = info;
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
- 	link->config_flags |= CONF_ENABLE_IRQ | CONF_AUTO_SET_IO;
-+#else
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
-+	link->resource[0]->flags |= IO_DATA_PATH_WIDTH_8;
-+	link->resource[0]->end = 8;
-+#else
-+	link->io.Attributes1 = IO_DATA_PATH_WIDTH_8;
-+	link->io.NumPorts1= 8;
-+#endif
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35))
-+	link->irq.Attributes = IRQ_TYPE_DYNAMIC_SHARING;
-+	link->irq.Handler = dtl1_interrupt;
-+#endif
-+
-+	link->conf.Attributes = CONF_ENABLE_IRQ;
-+	link->conf.IntType = INT_MEMORY_AND_IO;
-+#endif
- 
- 	return dtl1_config(link);
- }
-@@ -558,6 +600,7 @@ static void dtl1_detach(struct pcmcia_de
- 	pcmcia_disable_device(link);
- }
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
- static int dtl1_confcheck(struct pcmcia_device *p_dev, void *priv_data)
- {
- 	if ((p_dev->resource[1]->end) || (p_dev->resource[1]->end < 8))
-@@ -568,6 +611,29 @@ static int dtl1_confcheck(struct pcmcia_
- 
- 	return pcmcia_request_io(p_dev);
- }
-+#else
-+static int dtl1_confcheck(struct pcmcia_device *p_dev,
-+			  cistpl_cftable_entry_t *cf,
-+			  cistpl_cftable_entry_t *dflt,
-+			  unsigned int vcc,
-+			  void *priv_data)
-+{
-+	if ((cf->io.nwin != 1) || (cf->io.win[0].len <= 8))
-+		return -ENODEV;
-+
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
-+	p_dev->resource[0]->start = cf->io.win[0].base;
-+	p_dev->resource[0]->end = cf->io.win[0].len;	/*yo */
-+	p_dev->io_lines = cf->io.flags & CISTPL_IO_LINES_MASK;
-+	return pcmcia_request_io(p_dev);
-+#else
-+	p_dev->io.BasePort1 = cf->io.win[0].base;
-+	p_dev->io.NumPorts1 = cf->io.win[0].len;	/*yo */
-+	p_dev->io.IOAddrLines = cf->io.flags & CISTPL_IO_LINES_MASK;
-+	return pcmcia_request_io(p_dev, &p_dev->io);
-+#endif
-+}
-+#endif
- 
- static int dtl1_config(struct pcmcia_device *link)
- {
-@@ -575,14 +641,24 @@ static int dtl1_config(struct pcmcia_dev
- 	int ret;
- 
- 	/* Look for a generic full-sized window */
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- 	link->resource[0]->end = 8;
-+#else
-+	link->io.NumPorts1 = 8;
-+#endif
- 	ret = pcmcia_loop_config(link, dtl1_confcheck, NULL);
- 	if (ret)
- 		goto failed;
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	ret = pcmcia_request_irq(link, dtl1_interrupt);
- 	if (ret)
- 		goto failed;
-+#else
-+	ret = pcmcia_request_irq(link, &link->irq);
-+	if (ret != 0)
-+		link->irq.AssignedIRQ = 0;
-+#endif
- 
- 	ret = pcmcia_enable_device(link);
- 	if (ret)
-@@ -610,7 +686,13 @@ MODULE_DEVICE_TABLE(pcmcia, dtl1_ids);
- 
- static struct pcmcia_driver dtl1_driver = {
- 	.owner		= THIS_MODULE,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
- 	.name		= "dtl1_cs",
-+#else
-+	.drv		= {
-+		.name	= "dtl1_cs",
-+	},
-+#endif
- 	.probe		= dtl1_probe,
- 	.remove		= dtl1_detach,
- 	.id_table	= dtl1_ids,
diff --git a/patches/collateral-evolutions/network/24-pcmcia/drivers_net_wireless_b43_pcmcia.patch b/patches/collateral-evolutions/network/24-pcmcia/drivers_net_wireless_b43_pcmcia.patch
deleted file mode 100644
index 201cfea..0000000
--- a/patches/collateral-evolutions/network/24-pcmcia/drivers_net_wireless_b43_pcmcia.patch
+++ /dev/null
@@ -1,82 +0,0 @@
---- a/drivers/net/wireless/b43/pcmcia.c
-+++ b/drivers/net/wireless/b43/pcmcia.c
-@@ -63,6 +63,9 @@ static int b43_pcmcia_resume(struct pcmc
- static int b43_pcmcia_probe(struct pcmcia_device *dev)
- {
- 	struct ssb_bus *ssb;
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37))
-+	win_req_t win;
-+#endif
- 	int err = -ENOMEM;
- 	int res = 0;
- 
-@@ -72,6 +75,7 @@ static int b43_pcmcia_probe(struct pcmci
- 
- 	err = -ENODEV;
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
- 	dev->config_flags |= CONF_ENABLE_IRQ;
- 
- 	dev->resource[2]->flags |=  WIN_ENABLE | WIN_DATA_WIDTH_16 |
-@@ -79,21 +83,46 @@ static int b43_pcmcia_probe(struct pcmci
- 	dev->resource[2]->start = 0;
- 	dev->resource[2]->end = SSB_CORE_SIZE;
- 	res = pcmcia_request_window(dev, dev->resource[2], 250);
-+#else
-+	dev->conf.Attributes = CONF_ENABLE_IRQ;
-+	dev->conf.IntType = INT_MEMORY_AND_IO;
-+
-+	win.Attributes =  WIN_ENABLE | WIN_DATA_WIDTH_16 |
-+			 WIN_USE_WAIT;
-+	win.Base = 0;
-+	win.Size = SSB_CORE_SIZE;
-+	win.AccessSpeed = 250;
-+	res = pcmcia_request_window(dev, &win, &dev->win);
-+#endif
- 	if (res != 0)
- 		goto err_kfree_ssb;
--
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
- 	res = pcmcia_map_mem_page(dev, dev->resource[2], 0);
-+#else
-+	res = pcmcia_map_mem_page(dev, dev->win, 0);
-+#endif
- 	if (res != 0)
- 		goto err_disable;
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	if (!dev->irq)
-+#else
-+	dev->irq.Attributes = IRQ_TYPE_DYNAMIC_SHARING;
-+	dev->irq.Handler = NULL; /* The handler is registered later. */
-+	res = pcmcia_request_irq(dev, &dev->irq);
-+	if (res != 0)
-+#endif
- 		goto err_disable;
- 
- 	res = pcmcia_enable_device(dev);
- 	if (res != 0)
- 		goto err_disable;
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
- 	err = ssb_bus_pcmciabus_register(ssb, dev, dev->resource[2]->start);
-+#else
-+	err = ssb_bus_pcmciabus_register(ssb, dev, win.Base);
-+#endif
- 	if (err)
- 		goto err_disable;
- 	dev->priv = ssb;
-@@ -122,7 +151,13 @@ static void b43_pcmcia_remove(struct pcm
- 
- static struct pcmcia_driver b43_pcmcia_driver = {
- 	.owner		= THIS_MODULE,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
- 	.name		= "b43-pcmcia",
-+#else
-+	.drv		= {
-+		.name	= "b43-pcmcia",
-+	},
-+#endif
- 	.id_table	= b43_pcmcia_tbl,
- 	.probe		= b43_pcmcia_probe,
- 	.remove		= b43_pcmcia_remove,
diff --git a/patches/collateral-evolutions/network/24-pcmcia/drivers_net_wireless_libertas_if_cs.patch b/patches/collateral-evolutions/network/24-pcmcia/drivers_net_wireless_libertas_if_cs.patch
deleted file mode 100644
index 4b01d60..0000000
--- a/patches/collateral-evolutions/network/24-pcmcia/drivers_net_wireless_libertas_if_cs.patch
+++ /dev/null
@@ -1,163 +0,0 @@
---- a/drivers/net/wireless/libertas/if_cs.c
-+++ b/drivers/net/wireless/libertas/if_cs.c
-@@ -757,7 +757,11 @@ static void if_cs_prog_firmware(struct l
- 		return;
- 
- 	/* Now actually get the IRQ */
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	ret = request_irq(card->p_dev->irq, if_cs_interrupt,
-+#else
-+	ret = request_irq(card->p_dev->irq.AssignedIRQ, if_cs_interrupt,
-+#endif
- 		IRQF_SHARED, DRV_NAME, card);
- 	if (ret) {
- 		pr_err("error in request_irq\n");
-@@ -775,7 +779,11 @@ static void if_cs_prog_firmware(struct l
- 	priv->fw_ready = 1;
- 	if (lbs_start_card(priv) != 0) {
- 		pr_err("could not activate card\n");
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 		free_irq(card->p_dev->irq, card);
-+#else
-+		free_irq(card->p_dev->irq.AssignedIRQ, card);
-+#endif
- 	}
- }
- 
-@@ -820,7 +828,11 @@ static void if_cs_release(struct pcmcia_
- 
- 	lbs_deb_enter(LBS_DEB_CS);
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	free_irq(p_dev->irq, card);
-+#else
-+	free_irq(p_dev->irq.AssignedIRQ, card);
-+#endif
- 	pcmcia_disable_device(p_dev);
- 	if (card->iobase)
- 		ioport_unmap(card->iobase);
-@@ -828,7 +840,7 @@ static void if_cs_release(struct pcmcia_
- 	lbs_deb_leave(LBS_DEB_CS);
- }
- 
--
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
- static int if_cs_ioprobe(struct pcmcia_device *p_dev, void *priv_data)
- {
- 	p_dev->resource[0]->flags &= ~IO_DATA_PATH_WIDTH;
-@@ -838,9 +850,39 @@ static int if_cs_ioprobe(struct pcmcia_d
- 		pr_err("wrong CIS (check number of IO windows)\n");
- 		return -ENODEV;
- 	}
-+#else
-+static int if_cs_ioprobe(struct pcmcia_device *p_dev,
-+			 cistpl_cftable_entry_t *cfg,
-+			 cistpl_cftable_entry_t *dflt,
-+			 unsigned int vcc,
-+			 void *priv_data)
-+{
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
-+	p_dev->resource[0]->flags |= IO_DATA_PATH_WIDTH_AUTO;
-+	p_dev->resource[0]->start = cfg->io.win[0].base;
-+	p_dev->resource[0]->end = cfg->io.win[0].len;
-+#else
-+	p_dev->io.Attributes1 = IO_DATA_PATH_WIDTH_AUTO;
-+	p_dev->io.BasePort1 = cfg->io.win[0].base;
-+	p_dev->io.NumPorts1 = cfg->io.win[0].len;
-+#endif
-+
-+	/* Do we need to allocate an interrupt? */
-+	p_dev->conf.Attributes |= CONF_ENABLE_IRQ;
-+
-+	/* IO window settings */
-+	if (cfg->io.nwin != 1) {
-+		pr_err("wrong CIS (check number of IO windows)\n");
-+		return -ENODEV;
-+	}
-+#endif
- 
- 	/* This reserves IO space but doesn't actually enable it */
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- 	return pcmcia_request_io(p_dev);
-+#else
-+	return pcmcia_request_io(p_dev, &p_dev->io);
-+#endif
- }
- 
- static int if_cs_probe(struct pcmcia_device *p_dev)
-@@ -859,7 +901,16 @@ static int if_cs_probe(struct pcmcia_dev
- 	card->p_dev = p_dev;
- 	p_dev->priv = card;
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
- 	p_dev->config_flags |= CONF_ENABLE_IRQ | CONF_AUTO_SET_IO;
-+#else
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35))
-+	p_dev->irq.Attributes = IRQ_TYPE_DYNAMIC_SHARING;
-+	p_dev->irq.Handler = NULL;
-+#endif
-+	p_dev->conf.Attributes = 0;
-+	p_dev->conf.IntType = INT_MEMORY_AND_IO;
-+#endif
- 
- 	if (pcmcia_loop_config(p_dev, if_cs_ioprobe, NULL)) {
- 		pr_err("error in pcmcia_loop_config\n");
-@@ -871,12 +922,26 @@ static int if_cs_probe(struct pcmcia_dev
- 	 * a handler to the interrupt, unless the 'Handler' member of
- 	 * the irq structure is initialized.
- 	 */
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	if (!p_dev->irq)
- 		goto out1;
-+#else
-+	if (p_dev->conf.Attributes & CONF_ENABLE_IRQ) {
-+		ret = pcmcia_request_irq(p_dev, &p_dev->irq);
-+		if (ret) {
-+			pr_err("error in pcmcia_request_irq\n");
-+			goto out1;
-+		}
-+	}
-+#endif
- 
- 	/* Initialize io access */
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- 	card->iobase = ioport_map(p_dev->resource[0]->start,
- 				resource_size(p_dev->resource[0]));
-+#else
-+	card->iobase = ioport_map(p_dev->io.BasePort1, p_dev->io.NumPorts1);
-+#endif
- 	if (!card->iobase) {
- 		pr_err("error in ioport_map\n");
- 		ret = -EIO;
-@@ -890,7 +955,17 @@ static int if_cs_probe(struct pcmcia_dev
- 	}
- 
- 	/* Finally, report what we've done */
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- 	lbs_deb_cs("irq %d, io %pR", p_dev->irq, p_dev->resource[0]);
-+#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
-+	lbs_deb_cs("irq %d, io 0x%04x-0x%04x\n",
-+		  p_dev->irq, p_dev->io.BasePort1,
-+		  p_dev->io.BasePort1 + p_dev->io.NumPorts1 - 1);
-+#else
-+	lbs_deb_cs("irq %d, io 0x%04x-0x%04x\n",
-+		  p_dev->irq.AssignedIRQ, p_dev->io.BasePort1,
-+		  p_dev->io.BasePort1 + p_dev->io.NumPorts1 - 1);
-+#endif
- 
- 	/*
- 	 * Most of the libertas cards can do unaligned register access, but some
-@@ -998,7 +1073,13 @@ MODULE_DEVICE_TABLE(pcmcia, if_cs_ids);
- 
- static struct pcmcia_driver lbs_driver = {
- 	.owner		= THIS_MODULE,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
- 	.name		= DRV_NAME,
-+#else
-+	.drv		= {
-+		.name	= DRV_NAME,
-+	},
-+#endif
- 	.probe		= if_cs_probe,
- 	.remove		= if_cs_detach,
- 	.id_table       = if_cs_ids,
diff --git a/patches/collateral-evolutions/network/24-pcmcia/drivers_net_wireless_orinoco_orinoco_cs.patch b/patches/collateral-evolutions/network/24-pcmcia/drivers_net_wireless_orinoco_orinoco_cs.patch
deleted file mode 100644
index 41b8712..0000000
--- a/patches/collateral-evolutions/network/24-pcmcia/drivers_net_wireless_orinoco_orinoco_cs.patch
+++ /dev/null
@@ -1,207 +0,0 @@
---- a/drivers/net/wireless/orinoco/orinoco_cs.c
-+++ b/drivers/net/wireless/orinoco/orinoco_cs.c
-@@ -77,7 +77,11 @@ orinoco_cs_hard_reset(struct orinoco_pri
- 	/* We need atomic ops here, because we're not holding the lock */
- 	set_bit(0, &card->hard_reset_in_progress);
- 
-+#if LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,27)
-+	err = pcmcia_reset_card(link, NULL);
-+#else
- 	err = pcmcia_reset_card(link->socket);
-+#endif
- 	if (err)
- 		return err;
- 
-@@ -107,6 +111,16 @@ orinoco_cs_probe(struct pcmcia_device *l
- 	card->p_dev = link;
- 	link->priv = priv;
- 
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35))
-+	/* Interrupt setup */
-+	link->irq.Attributes = IRQ_TYPE_DYNAMIC_SHARING;
-+	link->irq.Handler = orinoco_interrupt;
-+#endif
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37))
-+	link->conf.Attributes = 0;
-+	link->conf.IntType = INT_MEMORY_AND_IO;
-+#endif
-+
- 	return orinoco_cs_config(link);
- }				/* orinoco_cs_attach */
- 
-@@ -121,6 +135,7 @@ static void orinoco_cs_detach(struct pcm
- 	free_orinocodev(priv);
- }				/* orinoco_cs_detach */
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
- static int orinoco_cs_config_check(struct pcmcia_device *p_dev, void *priv_data)
- {
- 	if (p_dev->config_index == 0)
-@@ -128,6 +143,98 @@ static int orinoco_cs_config_check(struc
- 
- 	return pcmcia_request_io(p_dev);
- };
-+#else
-+static int orinoco_cs_config_check(struct pcmcia_device *p_dev,
-+				   cistpl_cftable_entry_t *cfg,
-+				   cistpl_cftable_entry_t *dflt,
-+				   unsigned int vcc,
-+				   void *priv_data)
-+{
-+	if (cfg->index == 0)
-+		goto next_entry;
-+
-+	/* Use power settings for Vcc and Vpp if present */
-+	/* Note that the CIS values need to be rescaled */
-+	if (cfg->vcc.present & (1 << CISTPL_POWER_VNOM)) {
-+		if (vcc != cfg->vcc.param[CISTPL_POWER_VNOM] / 10000) {
-+			DEBUG(2, "%s: Vcc mismatch (vcc = %d, CIS = %d)\n",
-+			      __func__, vcc,
-+			      cfg->vcc.param[CISTPL_POWER_VNOM] / 10000);
-+			if (!ignore_cis_vcc)
-+				goto next_entry;
-+		}
-+	} else if (dflt->vcc.present & (1 << CISTPL_POWER_VNOM)) {
-+		if (vcc != dflt->vcc.param[CISTPL_POWER_VNOM] / 10000) {
-+			DEBUG(2, "%s: Vcc mismatch (vcc = %d, CIS = %d)\n",
-+			      __func__, vcc,
-+			      dflt->vcc.param[CISTPL_POWER_VNOM] / 10000);
-+			if (!ignore_cis_vcc)
-+				goto next_entry;
-+		}
-+	}
-+
-+	if (cfg->vpp1.present & (1 << CISTPL_POWER_VNOM))
-+		p_dev->conf.Vpp =
-+			cfg->vpp1.param[CISTPL_POWER_VNOM] / 10000;
-+	else if (dflt->vpp1.present & (1 << CISTPL_POWER_VNOM))
-+		p_dev->conf.Vpp =
-+			dflt->vpp1.param[CISTPL_POWER_VNOM] / 10000;
-+
-+	/* Do we need to allocate an interrupt? */
-+	p_dev->conf.Attributes |= CONF_ENABLE_IRQ;
-+
-+	/* IO window settings */
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36)
-+	p_dev->resource[0]->end = p_dev->resource[1]->end = 0;
-+#else
-+	p_dev->io.NumPorts1 = p_dev->io.NumPorts2 = 0;
-+#endif
-+	if ((cfg->io.nwin > 0) || (dflt->io.nwin > 0)) {
-+		cistpl_io_t *io = (cfg->io.nwin) ? &cfg->io : &dflt->io;
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36)
-+		p_dev->io_lines = io->flags & CISTPL_IO_LINES_MASK;
-+		p_dev->resource[0]->flags &= ~IO_DATA_PATH_WIDTH;
-+		p_dev->resource[0]->flags |=
-+			pcmcia_io_cfg_data_width(io->flags);
-+		p_dev->resource[0]->start = io->win[0].base;
-+		p_dev->resource[0]->end = io->win[0].len;
-+#else
-+		p_dev->io.Attributes1 = IO_DATA_PATH_WIDTH_AUTO;
-+		if (!(io->flags & CISTPL_IO_8BIT))
-+			p_dev->io.Attributes1 = IO_DATA_PATH_WIDTH_16;
-+		if (!(io->flags & CISTPL_IO_16BIT))
-+			p_dev->io.Attributes1 = IO_DATA_PATH_WIDTH_8;
-+		p_dev->io.IOAddrLines = io->flags & CISTPL_IO_LINES_MASK;
-+		p_dev->io.BasePort1 = io->win[0].base;
-+		p_dev->io.NumPorts1 = io->win[0].len;
-+#endif
-+		if (io->nwin > 1) {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36)
-+			p_dev->resource[1]->flags = p_dev->resource[0]->flags;
-+			p_dev->resource[1]->start = io->win[1].base;
-+			p_dev->resource[1]->end = io->win[1].len;
-+#else
-+			p_dev->io.Attributes2 = p_dev->io.Attributes1;
-+			p_dev->io.BasePort2 = io->win[1].base;
-+			p_dev->io.NumPorts2 = io->win[1].len;
-+#endif
-+		}
-+
-+		/* This reserves IO space but doesn't actually enable it */
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36)
-+		if (pcmcia_request_io(p_dev) != 0)
-+#else
-+		if (pcmcia_request_io(p_dev, &p_dev->io) != 0)
-+#endif
-+			goto next_entry;
-+	}
-+	return 0;
-+
-+next_entry:
-+	pcmcia_disable_device(p_dev);
-+	return -ENODEV;
-+};
-+#endif
- 
- static int
- orinoco_cs_config(struct pcmcia_device *link)
-@@ -137,10 +244,12 @@ orinoco_cs_config(struct pcmcia_device *
- 	int ret;
- 	void __iomem *mem;
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
- 	link->config_flags |= CONF_AUTO_SET_VPP | CONF_AUTO_CHECK_VCC |
- 		CONF_AUTO_SET_IO | CONF_ENABLE_IRQ;
- 	if (ignore_cis_vcc)
- 		link->config_flags &= ~CONF_AUTO_CHECK_VCC;
-+#endif
- 	ret = pcmcia_loop_config(link, orinoco_cs_config_check, NULL);
- 	if (ret) {
- 		if (!ignore_cis_vcc)
-@@ -150,8 +259,12 @@ orinoco_cs_config(struct pcmcia_device *
- 		goto failed;
- 	}
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36)
- 	mem = ioport_map(link->resource[0]->start,
- 			resource_size(link->resource[0]));
-+#else
-+	mem = ioport_map(link->io.BasePort1, link->io.NumPorts1);
-+#endif
- 	if (!mem)
- 		goto failed;
- 
-@@ -160,7 +273,11 @@ orinoco_cs_config(struct pcmcia_device *
- 	 * called. */
- 	hermes_struct_init(hw, mem, HERMES_16BIT_REGSPACING);
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	ret = pcmcia_request_irq(link, orinoco_interrupt);
-+#else
-+	ret = pcmcia_request_irq(link, &link->irq);
-+#endif
- 	if (ret)
- 		goto failed;
- 
-@@ -175,8 +292,16 @@ orinoco_cs_config(struct pcmcia_device *
- 	}
- 
- 	/* Register an interface with the stack */
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- 	if (orinoco_if_add(priv, link->resource[0]->start,
- 			   link->irq, NULL) != 0) {
-+#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
-+	if (orinoco_if_add(priv, link->io.BasePort1,
-+			   link->irq, NULL) != 0) {
-+#else
-+	if (orinoco_if_add(priv, link->io.BasePort1,
-+			   link->irq.AssignedIRQ, NULL) != 0) {
-+#endif
- 		printk(KERN_ERR PFX "orinoco_if_add() failed\n");
- 		goto failed;
- 	}
-@@ -330,7 +455,13 @@ MODULE_DEVICE_TABLE(pcmcia, orinoco_cs_i
- 
- static struct pcmcia_driver orinoco_driver = {
- 	.owner		= THIS_MODULE,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
- 	.name		= DRIVER_NAME,
-+#else
-+	.drv		= {
-+		.name	= DRIVER_NAME,
-+	},
-+#endif
- 	.probe		= orinoco_cs_probe,
- 	.remove		= orinoco_cs_detach,
- 	.id_table       = orinoco_cs_ids,
diff --git a/patches/collateral-evolutions/network/24-pcmcia/drivers_net_wireless_orinoco_spectrum_cs.patch b/patches/collateral-evolutions/network/24-pcmcia/drivers_net_wireless_orinoco_spectrum_cs.patch
deleted file mode 100644
index 0cdaec3..0000000
--- a/patches/collateral-evolutions/network/24-pcmcia/drivers_net_wireless_orinoco_spectrum_cs.patch
+++ /dev/null
@@ -1,195 +0,0 @@
---- a/drivers/net/wireless/orinoco/spectrum_cs.c
-+++ b/drivers/net/wireless/orinoco/spectrum_cs.c
-@@ -169,6 +169,16 @@ spectrum_cs_probe(struct pcmcia_device *
- 	card->p_dev = link;
- 	link->priv = priv;
- 
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35))
-+	/* Interrupt setup */
-+	link->irq.Attributes = IRQ_TYPE_DYNAMIC_SHARING;
-+	link->irq.Handler = orinoco_interrupt;
-+#endif
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37))
-+	link->conf.Attributes = 0;
-+	link->conf.IntType = INT_MEMORY_AND_IO;
-+#endif
-+
- 	return spectrum_cs_config(link);
- }				/* spectrum_cs_attach */
- 
-@@ -183,6 +193,7 @@ static void spectrum_cs_detach(struct pc
- 	free_orinocodev(priv);
- }				/* spectrum_cs_detach */
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
- static int spectrum_cs_config_check(struct pcmcia_device *p_dev,
- 				    void *priv_data)
- {
-@@ -191,6 +202,98 @@ static int spectrum_cs_config_check(stru
- 
- 	return pcmcia_request_io(p_dev);
- };
-+#else
-+static int spectrum_cs_config_check(struct pcmcia_device *p_dev,
-+				    cistpl_cftable_entry_t *cfg,
-+				    cistpl_cftable_entry_t *dflt,
-+				    unsigned int vcc,
-+				    void *priv_data)
-+{
-+	if (cfg->index == 0)
-+		goto next_entry;
-+
-+	/* Use power settings for Vcc and Vpp if present */
-+	/* Note that the CIS values need to be rescaled */
-+	if (cfg->vcc.present & (1 << CISTPL_POWER_VNOM)) {
-+		if (vcc != cfg->vcc.param[CISTPL_POWER_VNOM] / 10000) {
-+			DEBUG(2, "%s: Vcc mismatch (vcc = %d, CIS = %d)\n",
-+			      __func__, vcc,
-+			      cfg->vcc.param[CISTPL_POWER_VNOM] / 10000);
-+			if (!ignore_cis_vcc)
-+				goto next_entry;
-+		}
-+	} else if (dflt->vcc.present & (1 << CISTPL_POWER_VNOM)) {
-+		if (vcc != dflt->vcc.param[CISTPL_POWER_VNOM] / 10000) {
-+			DEBUG(2, "%s: Vcc mismatch (vcc = %d, CIS = %d)\n",
-+			      __func__, vcc,
-+			      dflt->vcc.param[CISTPL_POWER_VNOM] / 10000);
-+			if (!ignore_cis_vcc)
-+				goto next_entry;
-+		}
-+	}
-+
-+	if (cfg->vpp1.present & (1 << CISTPL_POWER_VNOM))
-+		p_dev->conf.Vpp =
-+			cfg->vpp1.param[CISTPL_POWER_VNOM] / 10000;
-+	else if (dflt->vpp1.present & (1 << CISTPL_POWER_VNOM))
-+		p_dev->conf.Vpp =
-+			dflt->vpp1.param[CISTPL_POWER_VNOM] / 10000;
-+
-+	/* Do we need to allocate an interrupt? */
-+	p_dev->conf.Attributes |= CONF_ENABLE_IRQ;
-+
-+	/* IO window settings */
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36)
-+	p_dev->resource[0]->end = p_dev->resource[1]->end = 0;
-+#else
-+	p_dev->io.NumPorts1 = p_dev->io.NumPorts2 = 0;
-+#endif
-+	if ((cfg->io.nwin > 0) || (dflt->io.nwin > 0)) {
-+		cistpl_io_t *io = (cfg->io.nwin) ? &cfg->io : &dflt->io;
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36)
-+		p_dev->io_lines = io->flags & CISTPL_IO_LINES_MASK;
-+		p_dev->resource[0]->flags &= ~IO_DATA_PATH_WIDTH;
-+		p_dev->resource[0]->flags |=
-+			pcmcia_io_cfg_data_width(io->flags);
-+		p_dev->resource[0]->start = io->win[0].base;
-+		p_dev->resource[0]->end = io->win[0].len;
-+#else
-+		p_dev->io.Attributes1 = IO_DATA_PATH_WIDTH_AUTO;
-+		if (!(io->flags & CISTPL_IO_8BIT))
-+			p_dev->io.Attributes1 = IO_DATA_PATH_WIDTH_16;
-+		if (!(io->flags & CISTPL_IO_16BIT))
-+			p_dev->io.Attributes1 = IO_DATA_PATH_WIDTH_8;
-+		p_dev->io.IOAddrLines = io->flags & CISTPL_IO_LINES_MASK;
-+		p_dev->io.BasePort1 = io->win[0].base;
-+		p_dev->io.NumPorts1 = io->win[0].len;
-+#endif
-+		if (io->nwin > 1) {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36)
-+			p_dev->resource[1]->flags = p_dev->resource[0]->flags;
-+			p_dev->resource[1]->start = io->win[1].base;
-+			p_dev->resource[1]->end = io->win[1].len;
-+#else
-+			p_dev->io.Attributes2 = p_dev->io.Attributes1;
-+			p_dev->io.BasePort2 = io->win[1].base;
-+			p_dev->io.NumPorts2 = io->win[1].len;
-+#endif
-+		}
-+
-+		/* This reserves IO space but doesn't actually enable it */
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36)
-+		if (pcmcia_request_io(p_dev) != 0)
-+#else
-+		if (pcmcia_request_io(p_dev, &p_dev->io) != 0)
-+#endif
-+			goto next_entry;
-+	}
-+	return 0;
-+
-+next_entry:
-+	pcmcia_disable_device(p_dev);
-+	return -ENODEV;
-+};
-+#endif
- 
- static int
- spectrum_cs_config(struct pcmcia_device *link)
-@@ -200,10 +303,12 @@ spectrum_cs_config(struct pcmcia_device
- 	int ret;
- 	void __iomem *mem;
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
- 	link->config_flags |= CONF_AUTO_SET_VPP | CONF_AUTO_CHECK_VCC |
- 		CONF_AUTO_SET_IO | CONF_ENABLE_IRQ;
- 	if (ignore_cis_vcc)
- 		link->config_flags &= ~CONF_AUTO_CHECK_VCC;
-+#endif
- 	ret = pcmcia_loop_config(link, spectrum_cs_config_check, NULL);
- 	if (ret) {
- 		if (!ignore_cis_vcc)
-@@ -213,8 +318,12 @@ spectrum_cs_config(struct pcmcia_device
- 		goto failed;
- 	}
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36)
- 	mem = ioport_map(link->resource[0]->start,
- 			resource_size(link->resource[0]));
-+#else
-+	mem = ioport_map(link->io.BasePort1, link->io.NumPorts1);
-+#endif
- 	if (!mem)
- 		goto failed;
- 
-@@ -224,7 +333,11 @@ spectrum_cs_config(struct pcmcia_device
- 	hermes_struct_init(hw, mem, HERMES_16BIT_REGSPACING);
- 	hw->eeprom_pda = true;
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	ret = pcmcia_request_irq(link, orinoco_interrupt);
-+#else
-+	ret = pcmcia_request_irq(link, &link->irq);
-+#endif
- 	if (ret)
- 		goto failed;
- 
-@@ -243,8 +356,16 @@ spectrum_cs_config(struct pcmcia_device
- 	}
- 
- 	/* Register an interface with the stack */
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- 	if (orinoco_if_add(priv, link->resource[0]->start,
- 			   link->irq, NULL) != 0) {
-+#elif (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
-+	if (orinoco_if_add(priv, link->io.BasePort1,
-+			   link->irq, NULL) != 0) {
-+#else
-+	if (orinoco_if_add(priv, link->io.BasePort1,
-+			   link->irq.AssignedIRQ, NULL) != 0) {
-+#endif
- 		printk(KERN_ERR PFX "orinoco_if_add() failed\n");
- 		goto failed;
- 	}
-@@ -310,7 +431,13 @@ MODULE_DEVICE_TABLE(pcmcia, spectrum_cs_
- 
- static struct pcmcia_driver orinoco_driver = {
- 	.owner		= THIS_MODULE,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
- 	.name		= DRIVER_NAME,
-+#else
-+	.drv		= {
-+		.name	= DRIVER_NAME,
-+	},
-+#endif
- 	.probe		= spectrum_cs_probe,
- 	.remove		= spectrum_cs_detach,
- 	.suspend	= spectrum_cs_suspend,
diff --git a/patches/collateral-evolutions/network/24-pcmcia/drivers_ssb_main.patch b/patches/collateral-evolutions/network/24-pcmcia/drivers_ssb_main.patch
deleted file mode 100644
index 3320cb1..0000000
--- a/patches/collateral-evolutions/network/24-pcmcia/drivers_ssb_main.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/ssb/main.c
-+++ b/drivers/ssb/main.c
-@@ -520,7 +520,11 @@ static int ssb_devices_register(struct s
- 			break;
- 		case SSB_BUSTYPE_PCMCIA:
- #ifdef CONFIG_SSB_PCMCIAHOST
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 			sdev->irq = bus->host_pcmcia->irq;
-+#else
-+			sdev->irq = bus->host_pcmcia->irq.AssignedIRQ;
-+#endif
- 			dev->parent = &bus->host_pcmcia->dev;
- #endif
- 			break;
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/INFO b/patches/collateral-evolutions/network/25-multicast-list_head/INFO
deleted file mode 100644
index 09b605b..0000000
--- a/patches/collateral-evolutions/network/25-multicast-list_head/INFO
+++ /dev/null
@@ -1,13 +0,0 @@
-Backport commit 22bedad3ce112d5ca1eaf043d4990fa2ed698c87:
-  net: convert multicast list to list_head
-
-  Converts the list and the core manipulating with it to be the same as uc_list.
-
-  +uses two functions for adding/removing mc address (normal and "global"
-   variant) instead of a function parameter.
-  +removes dev_mcast.c completely.
-  +exposes netdev_hw_addr_list_* macros along with __hw_addr_* functions for
-   manipulation with lists on a sandbox (used in bonding and 80211 drivers)
-
-This also backport commit 2f787b0b76bf5de2eaa3ca3a29d89123ae03c856
-
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_adm8211.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_adm8211.patch
deleted file mode 100644
index 049512c..0000000
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_adm8211.patch
+++ /dev/null
@@ -1,41 +0,0 @@
---- a/drivers/net/wireless/adm8211.c
-+++ b/drivers/net/wireless/adm8211.c
-@@ -1320,19 +1320,37 @@ static void adm8211_bss_info_changed(str
- }
- 
- static u64 adm8211_prepare_multicast(struct ieee80211_hw *hw,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 				     struct netdev_hw_addr_list *mc_list)
-+#else
-+				     int mc_count, struct dev_addr_list *ha)
-+#endif
- {
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	unsigned int bit_nr;
--	u32 mc_filter[2];
- 	struct netdev_hw_addr *ha;
-+#else
-+	unsigned int bit_nr, i;
-+#endif
-+	u32 mc_filter[2];
- 
- 	mc_filter[1] = mc_filter[0] = 0;
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	netdev_hw_addr_list_for_each(ha, mc_list) {
- 		bit_nr = ether_crc(ETH_ALEN, ha->addr) >> 26;
-+#else
-+	for (i = 0; i < mc_count; i++) {
-+		if (!ha)
-+			break;
-+		bit_nr = ether_crc(ETH_ALEN, ha->dmi_addr) >> 26;
-+#endif
- 
- 		bit_nr &= 0x3F;
- 		mc_filter[bit_nr >> 5] |= 1 << (bit_nr & 31);
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35))
-+		ha = ha->next;
-+#endif
- 	}
- 
- 	return mc_filter[0] | ((u64)(mc_filter[1]) << 32);
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ath_ath5k_mac80211-ops.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ath_ath5k_mac80211-ops.patch
deleted file mode 100644
index 741c49a..0000000
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ath_ath5k_mac80211-ops.patch
+++ /dev/null
@@ -1,55 +0,0 @@
---- a/drivers/net/wireless/ath/ath5k/mac80211-ops.c
-+++ b/drivers/net/wireless/ath/ath5k/mac80211-ops.c
-@@ -318,20 +318,42 @@ ath5k_bss_info_changed(struct ieee80211_
- 
- static u64
- ath5k_prepare_multicast(struct ieee80211_hw *hw,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 			struct netdev_hw_addr_list *mc_list)
-+#else
-+			int mc_count, struct dev_addr_list *ha)
-+#endif
- {
- 	u32 mfilt[2], val;
- 	u8 pos;
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	struct netdev_hw_addr *ha;
-+#else
-+	int i;
-+#endif
- 
- 	mfilt[0] = 0;
- 	mfilt[1] = 0;
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	netdev_hw_addr_list_for_each(ha, mc_list) {
-+#else
-+	for (i = 0; i < mc_count; i++) {
-+		if (!ha)
-+			break;
-+#endif
- 		/* calculate XOR of eight 6-bit values */
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 		val = get_unaligned_le32(ha->addr + 0);
-+#else
-+		val = get_unaligned_le32(ha->dmi_addr + 0);
-+#endif
- 		pos = (val >> 18) ^ (val >> 12) ^ (val >> 6) ^ val;
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 		val = get_unaligned_le32(ha->addr + 3);
-+#else
-+		val = get_unaligned_le32(ha->dmi_addr + 3);
-+#endif
- 		pos ^= (val >> 18) ^ (val >> 12) ^ (val >> 6) ^ val;
- 		pos &= 0x3f;
- 		mfilt[pos / 32] |= (1 << (pos % 32));
-@@ -340,6 +362,9 @@ ath5k_prepare_multicast(struct ieee80211
- 		* need to inform below not to reset the mcast */
- 		/* ath5k_hw_set_mcast_filterindex(ah,
- 		 *      ha->addr[5]); */
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35))
-+		ha = ha->next;
-+#endif
- 	}
- 
- 	return ((u64)(mfilt[1]) << 32) | mfilt[0];
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ath_carl9170_main.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ath_carl9170_main.patch
deleted file mode 100644
index 844dff5..0000000
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ath_carl9170_main.patch
+++ /dev/null
@@ -1,38 +0,0 @@
---- a/drivers/net/wireless/ath/carl9170/main.c
-+++ b/drivers/net/wireless/ath/carl9170/main.c
-@@ -969,17 +969,35 @@ out:
- 	return err;
- }
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- static u64 carl9170_op_prepare_multicast(struct ieee80211_hw *hw,
- 					 struct netdev_hw_addr_list *mc_list)
-+#else
-+static u64 carl9170_op_prepare_multicast(struct ieee80211_hw *hw, int mc_count,
-+					 struct dev_addr_list *ha)
-+#endif
- {
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	struct netdev_hw_addr *ha;
-+#else
-+	int i;
-+#endif
- 	u64 mchash;
- 
- 	/* always get broadcast frames */
- 	mchash = 1ULL << (0xff >> 2);
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	netdev_hw_addr_list_for_each(ha, mc_list)
- 		mchash |= 1ULL << (ha->addr[5] >> 2);
-+#else
-+	for (i = 0; i < mc_count; i++) {
-+		if (WARN_ON(!ha))
-+			break;
-+		mchash |= 1ULL << (ha->dmi_addr[5] >> 2);
-+		ha = ha->next;
-+	}
-+#endif
- 
- 	return mchash;
- }
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_cw1200_sta.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_cw1200_sta.patch
deleted file mode 100644
index 3974eb3..0000000
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_cw1200_sta.patch
+++ /dev/null
@@ -1,77 +0,0 @@
---- a/drivers/net/wireless/cw1200/sta.c
-+++ b/drivers/net/wireless/cw1200/sta.c
-@@ -531,8 +531,13 @@ void cw1200_set_beacon_wakeup_period_wor
- 				     priv->join_dtim_period, 0);
- }
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- u64 cw1200_prepare_multicast(struct ieee80211_hw *hw,
- 			     struct netdev_hw_addr_list *mc_list)
-+#else
-+u64 cw1200_prepare_multicast(struct ieee80211_hw *hw, int mc_count,
-+			     struct dev_addr_list *ha)
-+#endif
- {
- 	static u8 broadcast_ipv6[ETH_ALEN] = {
- 		0x33, 0x33, 0x00, 0x00, 0x00, 0x01
-@@ -541,13 +546,16 @@ u64 cw1200_prepare_multicast(struct ieee
- 		0x01, 0x00, 0x5e, 0x00, 0x00, 0x01
- 	};
- 	struct cw1200_common *priv = hw->priv;
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	struct netdev_hw_addr *ha;
-+#endif
- 	int count = 0;
- 
- 	/* Disable multicast filtering */
- 	priv->has_multicast_subscription = false;
- 	memset(&priv->multicast_filter, 0x00, sizeof(priv->multicast_filter));
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	if (netdev_hw_addr_list_count(mc_list) > WSM_MAX_GRP_ADDRTABLE_ENTRIES)
- 		return 0;
- 
-@@ -561,13 +569,26 @@ u64 cw1200_prepare_multicast(struct ieee
- 			priv->has_multicast_subscription = true;
- 		count++;
- 	}
-+#else
-+	while (ha &&
-+	       count < mc_count &&
-+	       count < WSM_MAX_GRP_ADDRTABLE_ENTRIES) {
-+		memcpy(&priv->multicast_filter.macaddrs[count],
-+		       ha->dmi_addr, ETH_ALEN);
-+		if (memcmp(ha->dmi_addr, broadcast_ipv4, ETH_ALEN) &&
-+		    memcmp(ha->dmi_addr, broadcast_ipv6, ETH_ALEN))
-+			priv->has_multicast_subscription = true;
-+		count++;
-+		ha = ha->next;
-+	}
-+#endif
- 
- 	if (count) {
- 		priv->multicast_filter.enable = __cpu_to_le32(1);
- 		priv->multicast_filter.num_addrs = __cpu_to_le32(count);
- 	}
- 
--	return netdev_hw_addr_list_count(mc_list);
-+	return count;
- }
- 
- void cw1200_configure_filter(struct ieee80211_hw *dev,
---- a/drivers/net/wireless/cw1200/sta.h
-+++ b/drivers/net/wireless/cw1200/sta.h
-@@ -42,8 +42,13 @@ int cw1200_set_rts_threshold(struct ieee
- 
- void cw1200_flush(struct ieee80211_hw *hw, u32 queues, bool drop);
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- u64 cw1200_prepare_multicast(struct ieee80211_hw *hw,
- 			     struct netdev_hw_addr_list *mc_list);
-+#else
-+u64 cw1200_prepare_multicast(struct ieee80211_hw *dev, int mc_count,
-+			     struct dev_addr_list *ha);
-+#endif
- 
- int cw1200_set_pm(struct cw1200_common *priv, const struct wsm_set_pm *arg);
- 
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_iwlwifi.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_iwlwifi.patch
deleted file mode 100644
index c8f9a1e..0000000
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_iwlwifi.patch
+++ /dev/null
@@ -1,42 +0,0 @@
---- a/drivers/net/wireless/iwlwifi/mvm/mac80211.c
-+++ b/drivers/net/wireless/iwlwifi/mvm/mac80211.c
-@@ -1029,12 +1029,21 @@ static void iwl_mvm_recalc_multicast(str
- }
- 
- static u64 iwl_mvm_prepare_multicast(struct ieee80211_hw *hw,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 				     struct netdev_hw_addr_list *mc_list)
-+#else
-+				     int addr_count,
-+				     struct dev_addr_list *mc_list)
-+#endif
- {
- 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
- 	struct iwl_mcast_filter_cmd *cmd;
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	struct netdev_hw_addr *addr;
- 	int addr_count = netdev_hw_addr_list_count(mc_list);
-+#else
-+	struct dev_mc_list *addr;
-+#endif
- 	bool pass_all = false;
- 	int len;
- 
-@@ -1053,11 +1062,15 @@ static u64 iwl_mvm_prepare_multicast(str
- 		return (u64)(unsigned long)cmd;
- 	}
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	netdev_hw_addr_list_for_each(addr, mc_list) {
-+#else
-+	for (addr = mc_list; addr; addr = addr->next) {
-+#endif
- 		IWL_DEBUG_MAC80211(mvm, "mcast addr (%d): %pM\n",
--				   cmd->count, addr->addr);
-+				   cmd->count, mc_addr(addr));
- 		memcpy(&cmd->addr_list[cmd->count * ETH_ALEN],
--		       addr->addr, ETH_ALEN);
-+		       mc_addr(addr), ETH_ALEN);
- 		cmd->count++;
- 	}
- 
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_libertas_tf_main.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_libertas_tf_main.patch
deleted file mode 100644
index f3536d4..0000000
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_libertas_tf_main.patch
+++ /dev/null
@@ -1,39 +0,0 @@
---- a/drivers/net/wireless/libertas_tf/main.c
-+++ b/drivers/net/wireless/libertas_tf/main.c
-@@ -421,20 +421,36 @@ static int lbtf_op_config(struct ieee802
- }
- 
- static u64 lbtf_op_prepare_multicast(struct ieee80211_hw *hw,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 				     struct netdev_hw_addr_list *mc_list)
-+#else
-+				     int mc_count, struct dev_addr_list *ha)
-+#endif
- {
- 	struct lbtf_private *priv = hw->priv;
- 	int i;
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	struct netdev_hw_addr *ha;
- 	int mc_count = netdev_hw_addr_list_count(mc_list);
-+#endif
- 
- 	if (!mc_count || mc_count > MRVDRV_MAX_MULTICAST_LIST_SIZE)
- 		return mc_count;
- 
- 	priv->nr_of_multicastmacaddr = mc_count;
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	i = 0;
- 	netdev_hw_addr_list_for_each(ha, mc_list)
- 		memcpy(&priv->multicastlist[i++], ha->addr, ETH_ALEN);
-+#else
-+	for (i = 0; i < mc_count; i++) {
-+		if (!ha)
-+			break;
-+		memcpy(&priv->multicastlist[i], ha->da_addr,
-+				ETH_ALEN);
-+		ha = ha->next;
-+	}
-+#endif
- 
- 	return mc_count;
- }
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_mwl8k.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_mwl8k.patch
deleted file mode 100644
index ccc8448..0000000
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_mwl8k.patch
+++ /dev/null
@@ -1,88 +0,0 @@
---- a/drivers/net/wireless/mwl8k.c
-+++ b/drivers/net/wireless/mwl8k.c
-@@ -2672,15 +2672,21 @@ struct mwl8k_cmd_mac_multicast_adr {
- 
- static struct mwl8k_cmd_pkt *
- __mwl8k_cmd_mac_multicast_adr(struct ieee80211_hw *hw, int allmulti,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 			      struct netdev_hw_addr_list *mc_list)
-+#else
-+			      int mc_count, struct dev_addr_list *ha)
-+#endif
- {
- 	struct mwl8k_priv *priv = hw->priv;
- 	struct mwl8k_cmd_mac_multicast_adr *cmd;
- 	int size;
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	int mc_count = 0;
- 
- 	if (mc_list)
- 		mc_count = netdev_hw_addr_list_count(mc_list);
-+#endif
- 
- 	if (allmulti || mc_count > priv->num_mcaddrs) {
- 		allmulti = 1;
-@@ -2701,13 +2707,27 @@ __mwl8k_cmd_mac_multicast_adr(struct iee
- 	if (allmulti) {
- 		cmd->action |= cpu_to_le16(MWL8K_ENABLE_RX_ALL_MULTICAST);
- 	} else if (mc_count) {
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 		struct netdev_hw_addr *ha;
- 		int i = 0;
-+#else
-+		int i;
-+#endif
- 
- 		cmd->action |= cpu_to_le16(MWL8K_ENABLE_RX_MULTICAST);
- 		cmd->numaddr = cpu_to_le16(mc_count);
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 		netdev_hw_addr_list_for_each(ha, mc_list) {
- 			memcpy(cmd->addr[i], ha->addr, ETH_ALEN);
-+#else
-+		for (i = 0; i < mc_count && ha; i++) {
-+			if (ha->da_addrlen != ETH_ALEN) {
-+				kfree(cmd);
-+				return NULL;
-+			}
-+			memcpy(cmd->addr[i], ha->da_addr, ETH_ALEN);
-+			ha = ha->next;
-+#endif
- 		}
- 	}
- 
-@@ -5158,7 +5178,11 @@ mwl8k_bss_info_changed(struct ieee80211_
- }
- 
- static u64 mwl8k_prepare_multicast(struct ieee80211_hw *hw,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 				   struct netdev_hw_addr_list *mc_list)
-+#else
-+				   int mc_count, struct dev_addr_list *ha)
-+#endif
- {
- 	struct mwl8k_cmd_pkt *cmd;
- 
-@@ -5169,7 +5193,11 @@ static u64 mwl8k_prepare_multicast(struc
- 	 * we'll end up throwing this packet away and creating a new
- 	 * one in mwl8k_configure_filter().
- 	 */
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	cmd = __mwl8k_cmd_mac_multicast_adr(hw, 0, mc_list);
-+#else
-+	cmd = __mwl8k_cmd_mac_multicast_adr(hw, 0, mc_count, ha);
-+#endif
- 
- 	return (unsigned long)cmd;
- }
-@@ -5291,7 +5319,11 @@ static void mwl8k_configure_filter(struc
- 	 */
- 	if (*total_flags & FIF_ALLMULTI) {
- 		kfree(cmd);
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 		cmd = __mwl8k_cmd_mac_multicast_adr(hw, 1, NULL);
-+#else
-+		cmd = __mwl8k_cmd_mac_multicast_adr(hw, 1, 0, NULL);
-+#endif
- 	}
- 
- 	if (cmd != NULL) {
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_p54_main.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_p54_main.patch
deleted file mode 100644
index 635a19b..0000000
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_p54_main.patch
+++ /dev/null
@@ -1,45 +0,0 @@
---- a/drivers/net/wireless/p54/main.c
-+++ b/drivers/net/wireless/p54/main.c
-@@ -363,11 +363,18 @@ out:
- 	return ret;
- }
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- static u64 p54_prepare_multicast(struct ieee80211_hw *dev,
- 				 struct netdev_hw_addr_list *mc_list)
-+#else
-+static u64 p54_prepare_multicast(struct ieee80211_hw *dev, int mc_count,
-+				 struct dev_addr_list *ha)
-+#endif
- {
- 	struct p54_common *priv = dev->priv;
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	struct netdev_hw_addr *ha;
-+#endif
- 	int i;
- 
- 	BUILD_BUG_ON(ARRAY_SIZE(priv->mc_maclist) !=
-@@ -377,12 +384,23 @@ static u64 p54_prepare_multicast(struct
- 	 * Otherwise the firmware will drop it and ARP will no longer work.
- 	 */
- 	i = 1;
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	priv->mc_maclist_num = netdev_hw_addr_list_count(mc_list) + i;
- 	netdev_hw_addr_list_for_each(ha, mc_list) {
- 		memcpy(&priv->mc_maclist[i], ha->addr, ETH_ALEN);
-+#else
-+	priv->mc_maclist_num = mc_count + i;
-+	while (i <= mc_count) {
-+		if (!ha)
-+			break;
-+		memcpy(&priv->mc_maclist[i], ha->dmi_addr, ETH_ALEN);
-+#endif
- 		i++;
- 		if (i >= ARRAY_SIZE(priv->mc_maclist))
- 			break;
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,35))
-+		ha = ha->next;
-+#endif
- 	}
- 
- 	return 1; /* update */
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_rtl818x_rtl8180_dev.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_rtl818x_rtl8180_dev.patch
deleted file mode 100644
index f97461e..0000000
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_rtl818x_rtl8180_dev.patch
+++ /dev/null
@@ -1,22 +0,0 @@
---- a/drivers/net/wireless/rtl818x/rtl8180/dev.c
-+++ b/drivers/net/wireless/rtl818x/rtl8180/dev.c
-@@ -987,10 +987,19 @@ static void rtl8180_bss_info_changed(str
- 	}
- }
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- static u64 rtl8180_prepare_multicast(struct ieee80211_hw *dev,
- 				     struct netdev_hw_addr_list *mc_list)
-+#else
-+static u64 rtl8180_prepare_multicast(struct ieee80211_hw *dev, int mc_count,
-+				     struct dev_addr_list *mc_list)
-+#endif
- {
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	return netdev_hw_addr_list_count(mc_list);
-+#else
-+	return mc_count;
-+#endif
- }
- 
- static void rtl8180_configure_filter(struct ieee80211_hw *dev,
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_rtl818x_rtl8187_dev.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_rtl818x_rtl8187_dev.patch
deleted file mode 100644
index 014e47f..0000000
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_rtl818x_rtl8187_dev.patch
+++ /dev/null
@@ -1,20 +0,0 @@
---- a/drivers/net/wireless/rtl818x/rtl8187/dev.c
-+++ b/drivers/net/wireless/rtl818x/rtl8187/dev.c
-@@ -1294,9 +1294,17 @@ static void rtl8187_bss_info_changed(str
- }
- 
- static u64 rtl8187_prepare_multicast(struct ieee80211_hw *dev,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 				     struct netdev_hw_addr_list *mc_list)
-+#else
-+				     int mc_count, struct dev_addr_list *mc_list)
-+#endif
- {
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	return netdev_hw_addr_list_count(mc_list);
-+#else
-+	return mc_count;
-+#endif
- }
- 
- static void rtl8187_configure_filter(struct ieee80211_hw *dev,
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ti_wlcore_main.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ti_wlcore_main.patch
deleted file mode 100644
index 2c2a87f..0000000
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_ti_wlcore_main.patch
+++ /dev/null
@@ -1,64 +0,0 @@
---- a/drivers/net/wireless/ti/wlcore/main.c
-+++ b/drivers/net/wireless/ti/wlcore/main.c
-@@ -3053,11 +3053,20 @@ struct wl1271_filter_params {
- 	u8 mc_list[ACX_MC_ADDRESS_GROUP_MAX][ETH_ALEN];
- };
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- static u64 wl1271_op_prepare_multicast(struct ieee80211_hw *hw,
- 				       struct netdev_hw_addr_list *mc_list)
-+#else
-+static u64 wl1271_op_prepare_multicast(struct ieee80211_hw *hw, int mc_count,
-+				       struct dev_addr_list *mc_list)
-+#endif
- {
- 	struct wl1271_filter_params *fp;
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	struct netdev_hw_addr *ha;
-+#else
-+	int i;
-+#endif
- 
- 	fp = kzalloc(sizeof(*fp), GFP_ATOMIC);
- 	if (!fp) {
-@@ -3066,16 +3075,40 @@ static u64 wl1271_op_prepare_multicast(s
- 	}
- 
- 	/* update multicast filtering parameters */
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	fp->mc_list_length = 0;
- 	if (netdev_hw_addr_list_count(mc_list) > ACX_MC_ADDRESS_GROUP_MAX) {
-+#else
-+	fp->enabled = true;
-+	if (mc_count > ACX_MC_ADDRESS_GROUP_MAX) {
-+		mc_count = 0;
-+#endif
- 		fp->enabled = false;
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	} else {
- 		fp->enabled = true;
- 		netdev_hw_addr_list_for_each(ha, mc_list) {
-+#else
-+	}
-+
-+	fp->mc_list_length = 0;
-+	for (i = 0; i < mc_count; i++) {
-+		if (mc_list->da_addrlen == ETH_ALEN) {
-+#endif
- 			memcpy(fp->mc_list[fp->mc_list_length],
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 					ha->addr, ETH_ALEN);
-+#else
-+			       mc_list->da_addr, ETH_ALEN);
-+#endif
- 			fp->mc_list_length++;
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 		}
-+#else
-+		} else
-+			wl1271_warning("Unknown mc address length.");
-+		mc_list = mc_list->next;
-+#endif
- 	}
- 
- 	return (u64)(unsigned long)fp;
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_zd1211rw_zd_mac.patch b/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_zd1211rw_zd_mac.patch
deleted file mode 100644
index d7aa319..0000000
--- a/patches/collateral-evolutions/network/25-multicast-list_head/drivers_net_wireless_zd1211rw_zd_mac.patch
+++ /dev/null
@@ -1,37 +0,0 @@
---- a/drivers/net/wireless/zd1211rw/zd_mac.c
-+++ b/drivers/net/wireless/zd1211rw/zd_mac.c
-@@ -1213,17 +1213,34 @@ static void zd_process_intr(struct work_
- 
- 
- static u64 zd_op_prepare_multicast(struct ieee80211_hw *hw,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 				   struct netdev_hw_addr_list *mc_list)
-+#else
-+				   int mc_count, struct dev_addr_list *ha)
-+#endif
- {
- 	struct zd_mac *mac = zd_hw_mac(hw);
- 	struct zd_mc_hash hash;
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	struct netdev_hw_addr *ha;
-+#else
-+	int i;
-+#endif
- 
- 	zd_mc_clear(&hash);
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	netdev_hw_addr_list_for_each(ha, mc_list) {
- 		dev_dbg_f(zd_mac_dev(mac), "mc addr %pM\n", ha->addr);
- 		zd_mc_add_addr(&hash, ha->addr);
-+#else
-+	for (i = 0; i < mc_count; i++) {
-+		if (!ha)
-+			break;
-+		dev_dbg_f(zd_mac_dev(mac), "mc addr %pM\n", ha->dmi_addr);
-+		zd_mc_add_addr(&hash, ha->dmi_addr);
-+		ha = ha->next;
-+#endif
- 	}
- 
- 	return hash.low | ((u64)hash.high << 32);
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch b/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
deleted file mode 100644
index 53ef060..0000000
--- a/patches/collateral-evolutions/network/25-multicast-list_head/include_net_mac80211.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/include/net/mac80211.h
-+++ b/include/net/mac80211.h
-@@ -2780,7 +2780,11 @@ struct ieee80211_ops {
- 	void (*stop_ap)(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
- 
- 	u64 (*prepare_multicast)(struct ieee80211_hw *hw,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 				 struct netdev_hw_addr_list *mc_list);
-+#else
-+				 int mc_count, struct dev_addr_list *mc_list);
-+#endif
- 	void (*configure_filter)(struct ieee80211_hw *hw,
- 				 unsigned int changed_flags,
- 				 unsigned int *total_flags,
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_driver-ops.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_driver-ops.patch
deleted file mode 100644
index 0332c91..0000000
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_driver-ops.patch
+++ /dev/null
@@ -1,31 +0,0 @@
---- a/net/mac80211/driver-ops.h
-+++ b/net/mac80211/driver-ops.h
-@@ -228,14 +228,28 @@ static inline void drv_bss_info_changed(
- }
- 
- static inline u64 drv_prepare_multicast(struct ieee80211_local *local,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 					struct netdev_hw_addr_list *mc_list)
-+#else
-+					int mc_count,
-+					struct dev_addr_list *mc_list)
-+#endif
- {
- 	u64 ret = 0;
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	trace_drv_prepare_multicast(local, mc_list->count);
-+#else
-+	trace_drv_prepare_multicast(local, mc_count);
-+#endif
- 
- 	if (local->ops->prepare_multicast)
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 		ret = local->ops->prepare_multicast(&local->hw, mc_list);
-+#else
-+		ret = local->ops->prepare_multicast(&local->hw, mc_count,
-+						    mc_list);
-+#endif
- 
- 	trace_drv_return_u64(local, ret);
- 
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
deleted file mode 100644
index 1019fa2..0000000
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_ieee80211_i.patch
+++ /dev/null
@@ -1,15 +0,0 @@
---- a/net/mac80211/ieee80211_i.h
-+++ b/net/mac80211/ieee80211_i.h
-@@ -1017,7 +1017,12 @@ struct ieee80211_local {
- 	struct work_struct reconfig_filter;
- 
- 	/* aggregated multicast list */
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	struct netdev_hw_addr_list mc_list;
-+#else
-+	struct dev_addr_list *mc_list;
-+	int mc_count;
-+#endif
- 
- 	bool tim_in_locked_section; /* see ieee80211_beacon_get() */
- 
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
deleted file mode 100644
index 612d81b..0000000
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_iface.patch
+++ /dev/null
@@ -1,29 +0,0 @@
---- a/net/mac80211/iface.c
-+++ b/net/mac80211/iface.c
-@@ -818,8 +818,13 @@ static void ieee80211_do_stop(struct iee
- 	if (sdata->dev) {
- 		netif_addr_lock_bh(sdata->dev);
- 		spin_lock_bh(&local->filter_lock);
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 		__hw_addr_unsync(&local->mc_list, &sdata->dev->mc,
- 				 sdata->dev->addr_len);
-+#else
-+		__dev_addr_unsync(&local->mc_list, &local->mc_count,
-+				  &sdata->dev->mc_list, &sdata->dev->mc_count);
-+#endif
- 		spin_unlock_bh(&local->filter_lock);
- 		netif_addr_unlock_bh(sdata->dev);
- 	}
-@@ -1021,7 +1026,12 @@ static void ieee80211_set_multicast_list
- 		sdata->flags ^= IEEE80211_SDATA_PROMISC;
- 	}
- 	spin_lock_bh(&local->filter_lock);
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	__hw_addr_sync(&local->mc_list, &dev->mc, dev->addr_len);
-+#else
-+	__dev_addr_sync(&local->mc_list, &local->mc_count,
-+			&dev->mc_list, &dev->mc_count);
-+#endif
- 	spin_unlock_bh(&local->filter_lock);
- 	ieee80211_queue_work(&local->hw, &local->reconfig_filter);
- }
diff --git a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_main.patch b/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_main.patch
deleted file mode 100644
index b88e485..0000000
--- a/patches/collateral-evolutions/network/25-multicast-list_head/net_mac80211_main.patch
+++ /dev/null
@@ -1,26 +0,0 @@
---- a/net/mac80211/main.c
-+++ b/net/mac80211/main.c
-@@ -71,7 +71,11 @@ void ieee80211_configure_filter(struct i
- 	spin_lock_bh(&local->filter_lock);
- 	changed_flags = local->filter_flags ^ new_flags;
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	mc = drv_prepare_multicast(local, &local->mc_list);
-+#else
-+	mc = drv_prepare_multicast(local, local->mc_count, local->mc_list);
-+#endif
- 	spin_unlock_bh(&local->filter_lock);
- 
- 	/* be a bit nasty */
-@@ -586,9 +590,11 @@ struct ieee80211_hw *ieee80211_alloc_hw(
- 	wiphy->vht_capa_mod_mask = &mac80211_vht_capa_mod_mask;
- 
- 	INIT_LIST_HEAD(&local->interfaces);
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 
- 	__hw_addr_init(&local->mc_list);
- 
-+#endif
- 	mutex_init(&local->iflist_mtx);
- 	mutex_init(&local->mtx);
- 
diff --git a/patches/collateral-evolutions/network/25-multicast.cocci b/patches/collateral-evolutions/network/25-multicast.cocci
deleted file mode 100644
index 2d3d495..0000000
--- a/patches/collateral-evolutions/network/25-multicast.cocci
+++ /dev/null
@@ -1,11 +0,0 @@
-@@
-identifier ha;
-expression netdev;
-iterator name netdev_for_each_mc_addr;
-@@
- netdev_for_each_mc_addr(ha, netdev) {
- <...
--ha->addr
-+mc_addr(ha)
- ...>
- }
diff --git a/patches/collateral-evolutions/network/26-sdio-quirks/INFO b/patches/collateral-evolutions/network/26-sdio-quirks/INFO
deleted file mode 100644
index e0b21b2..0000000
--- a/patches/collateral-evolutions/network/26-sdio-quirks/INFO
+++ /dev/null
@@ -1,2 +0,0 @@
-The quirks attribute is not available on older kernels.
-
diff --git a/patches/collateral-evolutions/network/26-sdio-quirks/drivers_net_wireless_libertas_if_sdio.patch b/patches/collateral-evolutions/network/26-sdio-quirks/drivers_net_wireless_libertas_if_sdio.patch
deleted file mode 100644
index 412f36e..0000000
--- a/patches/collateral-evolutions/network/26-sdio-quirks/drivers_net_wireless_libertas_if_sdio.patch
+++ /dev/null
@@ -1,18 +0,0 @@
---- a/drivers/net/wireless/libertas/if_sdio.c
-+++ b/drivers/net/wireless/libertas/if_sdio.c
-@@ -873,6 +873,7 @@ static int if_sdio_power_on(struct if_sd
- 	if (ret)
- 		goto release;
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32))
- 	/* For 1-bit transfers to the 8686 model, we need to enable the
- 	 * interrupt flag in the CCCR register. Set the MMC_QUIRK_LENIENT_FN0
- 	 * bit to allow access to non-vendor registers. */
-@@ -891,6 +892,7 @@ static int if_sdio_power_on(struct if_sd
- 		if (ret)
- 			goto disable;
- 	}
-+#endif
- 
- 	card->ioport = sdio_readb(func, IF_SDIO_IOPORT, &ret);
- 	if (ret)
diff --git a/patches/collateral-evolutions/network/26-sdio-quirks/drivers_net_wireless_mwifiex_sdio.patch b/patches/collateral-evolutions/network/26-sdio-quirks/drivers_net_wireless_mwifiex_sdio.patch
deleted file mode 100644
index d46f5ee..0000000
--- a/patches/collateral-evolutions/network/26-sdio-quirks/drivers_net_wireless_mwifiex_sdio.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/wireless/mwifiex/sdio.c
-+++ b/drivers/net/wireless/mwifiex/sdio.c
-@@ -73,7 +73,9 @@ mwifiex_sdio_probe(struct sdio_func *fun
- 
- 	card->func = func;
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
- 	func->card->quirks |= MMC_QUIRK_BLKSZ_FOR_BYTE_MODE;
-+#endif
- 
- 	if (id->driver_data) {
- 		struct mwifiex_sdio_device *data = (void *)id->driver_data;
diff --git a/patches/collateral-evolutions/network/27-hermes-read-pda-conflict/INFO b/patches/collateral-evolutions/network/27-hermes-read-pda-conflict/INFO
deleted file mode 100644
index f4bf2d2..0000000
--- a/patches/collateral-evolutions/network/27-hermes-read-pda-conflict/INFO
+++ /dev/null
@@ -1,3 +0,0 @@
-Rename read_pda to something else because this symbol is used in a
-define for something else in arch/um/include/asm/pda.h on older kernels.
-
diff --git a/patches/collateral-evolutions/network/27-hermes-read-pda-conflict/drivers_net_wireless_orinoco_fw.patch b/patches/collateral-evolutions/network/27-hermes-read-pda-conflict/drivers_net_wireless_orinoco_fw.patch
deleted file mode 100644
index 371edb2..0000000
--- a/patches/collateral-evolutions/network/27-hermes-read-pda-conflict/drivers_net_wireless_orinoco_fw.patch
+++ /dev/null
@@ -1,20 +0,0 @@
---- a/drivers/net/wireless/orinoco/fw.c
-+++ b/drivers/net/wireless/orinoco/fw.c
-@@ -123,7 +123,7 @@ orinoco_dl_firmware(struct orinoco_priva
- 	dev_dbg(dev, "Attempting to download firmware %s\n", firmware);
- 
- 	/* Read current plug data */
--	err = hw->ops->read_pda(hw, pda, fw->pda_addr, fw->pda_size);
-+	err = hw->ops->read_pda_h(hw, pda, fw->pda_addr, fw->pda_size);
- 	dev_dbg(dev, "Read PDA returned %d\n", err);
- 	if (err)
- 		goto free;
-@@ -225,7 +225,7 @@ symbol_dl_image(struct orinoco_private *
- 		if (!pda)
- 			return -ENOMEM;
- 
--		ret = hw->ops->read_pda(hw, pda, fw->pda_addr, fw->pda_size);
-+		ret = hw->ops->read_pda_h(hw, pda, fw->pda_addr, fw->pda_size);
- 		if (ret)
- 			goto free;
- 	}
diff --git a/patches/collateral-evolutions/network/27-hermes-read-pda-conflict/drivers_net_wireless_orinoco_hermes.patch b/patches/collateral-evolutions/network/27-hermes-read-pda-conflict/drivers_net_wireless_orinoco_hermes.patch
deleted file mode 100644
index 70bca92..0000000
--- a/patches/collateral-evolutions/network/27-hermes-read-pda-conflict/drivers_net_wireless_orinoco_hermes.patch
+++ /dev/null
@@ -1,22 +0,0 @@
---- a/drivers/net/wireless/orinoco/hermes.c
-+++ b/drivers/net/wireless/orinoco/hermes.c
-@@ -766,7 +766,7 @@ static const struct hermes_ops hermes_op
- 	.write_ltv = hermes_write_ltv,
- 	.bap_pread = hermes_bap_pread,
- 	.bap_pwrite = hermes_bap_pwrite,
--	.read_pda = hermes_read_pda,
-+	.read_pda_h = hermes_read_pda,
- 	.program_init = hermesi_program_init,
- 	.program_end = hermesi_program_end,
- 	.program = hermes_program_bytes,
---- a/drivers/net/wireless/orinoco/hermes.h
-+++ b/drivers/net/wireless/orinoco/hermes.h
-@@ -393,7 +393,7 @@ struct hermes_ops {
- 			 u16 id, u16 offset);
- 	int (*bap_pwrite)(struct hermes *hw, int bap, const void *buf,
- 			  int len, u16 id, u16 offset);
--	int (*read_pda)(struct hermes *hw, __le16 *pda,
-+	int (*read_pda_h)(struct hermes *hw, __le16 *pda,
- 			u32 pda_addr, u16 pda_len);
- 	int (*program_init)(struct hermes *hw, u32 entry_point);
- 	int (*program_end)(struct hermes *hw);
diff --git a/patches/collateral-evolutions/network/27-hermes-read-pda-conflict/drivers_net_wireless_orinoco_orinoco_usb.patch b/patches/collateral-evolutions/network/27-hermes-read-pda-conflict/drivers_net_wireless_orinoco_orinoco_usb.patch
deleted file mode 100644
index aa08ba8..0000000
--- a/patches/collateral-evolutions/network/27-hermes-read-pda-conflict/drivers_net_wireless_orinoco_orinoco_usb.patch
+++ /dev/null
@@ -1,11 +0,0 @@
---- a/drivers/net/wireless/orinoco/orinoco_usb.c
-+++ b/drivers/net/wireless/orinoco/orinoco_usb.c
-@@ -1553,7 +1553,7 @@ static const struct hermes_ops ezusb_ops
- 	.read_ltv = ezusb_read_ltv,
- 	.write_ltv = ezusb_write_ltv,
- 	.bap_pread = ezusb_bap_pread,
--	.read_pda = ezusb_read_pda,
-+	.read_pda_h = ezusb_read_pda,
- 	.program_init = ezusb_program_init,
- 	.program_end = ezusb_program_end,
- 	.program = ezusb_program,
diff --git a/patches/collateral-evolutions/network/29-sdio_no_suspend/INFO b/patches/collateral-evolutions/network/29-sdio_no_suspend/INFO
deleted file mode 100644
index c5e2fe4..0000000
--- a/patches/collateral-evolutions/network/29-sdio_no_suspend/INFO
+++ /dev/null
@@ -1,5 +0,0 @@
-Starting with commit 66fceb69b72ff7e9cd8da2ca70033982d5376e0e
-"libertas: Added callback functions to support SDIO suspend/resume."
-libertas uses new functions from the in kernel sdio framework for
-suspend and resume that are not backported.
-
diff --git a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_bluetooth_btmrvl_sdio.patch b/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_bluetooth_btmrvl_sdio.patch
deleted file mode 100644
index 5d0023b..0000000
--- a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_bluetooth_btmrvl_sdio.patch
+++ /dev/null
@@ -1,28 +0,0 @@
---- a/drivers/bluetooth/btmrvl_sdio.c
-+++ b/drivers/bluetooth/btmrvl_sdio.c
-@@ -1075,6 +1075,7 @@ static void btmrvl_sdio_remove(struct sd
- 	}
- }
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
- static int btmrvl_sdio_suspend(struct device *dev)
- {
- 	struct sdio_func *func = dev_to_sdio_func(dev);
-@@ -1170,6 +1171,7 @@ static const struct dev_pm_ops btmrvl_sd
- 	.suspend	= btmrvl_sdio_suspend,
- 	.resume		= btmrvl_sdio_resume,
- };
-+#endif
- 
- static struct sdio_driver bt_mrvl_sdio = {
- 	.name		= "btmrvl_sdio",
-@@ -1178,7 +1180,9 @@ static struct sdio_driver bt_mrvl_sdio =
- 	.remove		= btmrvl_sdio_remove,
- 	.drv = {
- 		.owner = THIS_MODULE,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
- 		.pm = &btmrvl_sdio_pm_ops,
-+#endif
- 	}
- };
- 
diff --git a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_ath_ath6kl_sdio.patch b/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_ath_ath6kl_sdio.patch
deleted file mode 100644
index 71bf82a..0000000
--- a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_ath_ath6kl_sdio.patch
+++ /dev/null
@@ -1,47 +0,0 @@
---- a/drivers/net/wireless/ath/ath6kl/sdio.c
-+++ b/drivers/net/wireless/ath/ath6kl/sdio.c
-@@ -817,6 +817,7 @@ out:
- 	return ret;
- }
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
- static int ath6kl_set_sdio_pm_caps(struct ath6kl *ar)
- {
- 	struct ath6kl_sdio *ar_sdio = ath6kl_sdio_priv(ar);
-@@ -950,6 +951,17 @@ static int ath6kl_sdio_resume(struct ath
- 
- 	return 0;
- }
-+#else
-+static int ath6kl_sdio_suspend(struct ath6kl *ar, struct cfg80211_wowlan *wow)
-+{
-+	return 0;
-+}
-+
-+static int ath6kl_sdio_resume(struct ath6kl *ar)
-+{
-+	return 0;
-+}
-+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34)) */
- 
- /* set the window address register (using 4-byte register access ). */
- static int ath6kl_set_addrwin_reg(struct ath6kl *ar, u32 reg_addr, u32 addr)
-@@ -1263,7 +1275,7 @@ static const struct ath6kl_hif_ops ath6k
- 	.stop = ath6kl_sdio_stop,
- };
- 
--#ifdef CONFIG_PM_SLEEP
-+#if defined(CONFIG_PM_SLEEP) && (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
- 
- /*
-  * Empty handlers so that mmc subsystem doesn't remove us entirely during
-@@ -1413,7 +1425,9 @@ static struct sdio_driver ath6kl_sdio_dr
- 	.id_table = ath6kl_sdio_devices,
- 	.probe = ath6kl_sdio_probe,
- 	.remove = ath6kl_sdio_remove,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
- 	.drv.pm = ATH6KL_SDIO_PM_OPS,
-+#endif
- };
- 
- static int __init ath6kl_sdio_init(void)
diff --git a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_brcm80211_brcmfmac_bcmsdh_sdmmc.patch b/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_brcm80211_brcmfmac_bcmsdh_sdmmc.patch
deleted file mode 100644
index 5b358f9..0000000
--- a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_brcm80211_brcmfmac_bcmsdh_sdmmc.patch
+++ /dev/null
@@ -1,38 +0,0 @@
---- a/drivers/net/wireless/brcm80211/brcmfmac/bcmsdh_sdmmc.c
-+++ b/drivers/net/wireless/brcm80211/brcmfmac/bcmsdh_sdmmc.c
-@@ -66,7 +66,7 @@ bool
- brcmf_pm_resume_error(struct brcmf_sdio_dev *sdiodev)
- {
- 	bool is_err = false;
--#ifdef CONFIG_PM_SLEEP
-+#if defined(CONFIG_PM_SLEEP) && (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
- 	is_err = atomic_read(&sdiodev->suspend);
- #endif
- 	return is_err;
-@@ -75,7 +75,7 @@ brcmf_pm_resume_error(struct brcmf_sdio_
- void
- brcmf_pm_resume_wait(struct brcmf_sdio_dev *sdiodev, wait_queue_head_t *wq)
- {
--#ifdef CONFIG_PM_SLEEP
-+#if defined(CONFIG_PM_SLEEP) && (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
- 	int retry = 0;
- 	while (atomic_read(&sdiodev->suspend) && retry++ != 30)
- 		wait_event_timeout(*wq, false, HZ/100);
-@@ -432,7 +432,7 @@ static void brcmf_ops_sdio_remove(struct
- 	brcmf_dbg(SDIO, "Exit\n");
- }
- 
--#ifdef CONFIG_PM_SLEEP
-+#if defined(CONFIG_PM_SLEEP) && (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
- static int brcmf_sdio_suspend(struct device *dev)
- {
- 	mmc_pm_flag_t sdio_flags;
-@@ -482,7 +482,7 @@ static struct sdio_driver brcmf_sdmmc_dr
- 	.remove = brcmf_ops_sdio_remove,
- 	.name = BRCMFMAC_SDIO_PDATA_NAME,
- 	.id_table = brcmf_sdmmc_ids,
--#ifdef CONFIG_PM_SLEEP
-+#if defined(CONFIG_PM_SLEEP) && (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
- 	.drv = {
- 		.pm = &brcmf_sdio_pm_ops,
- 	},
diff --git a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_libertas_if_sdio.patch b/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_libertas_if_sdio.patch
deleted file mode 100644
index 30d18b3..0000000
--- a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_libertas_if_sdio.patch
+++ /dev/null
@@ -1,29 +0,0 @@
---- a/drivers/net/wireless/libertas/if_sdio.c
-+++ b/drivers/net/wireless/libertas/if_sdio.c
-@@ -1341,6 +1341,7 @@ static void if_sdio_remove(struct sdio_f
- 	lbs_deb_leave(LBS_DEB_SDIO);
- }
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
- static int if_sdio_suspend(struct device *dev)
- {
- 	struct sdio_func *func = dev_to_sdio_func(dev);
-@@ -1399,15 +1400,18 @@ static const struct dev_pm_ops if_sdio_p
- 	.suspend	= if_sdio_suspend,
- 	.resume		= if_sdio_resume,
- };
-+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34)) */
- 
- static struct sdio_driver if_sdio_driver = {
- 	.name		= "libertas_sdio",
- 	.id_table	= if_sdio_ids,
- 	.probe		= if_sdio_probe,
- 	.remove		= if_sdio_remove,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
- 	.drv = {
- 		.pm = &if_sdio_pm_ops,
- 	},
-+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34)) */
- };
- 
- /*******************************************************************/
diff --git a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_mwifiex_sdio.patch b/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_mwifiex_sdio.patch
deleted file mode 100644
index 57ced06..0000000
--- a/patches/collateral-evolutions/network/29-sdio_no_suspend/drivers_net_wireless_mwifiex_sdio.patch
+++ /dev/null
@@ -1,68 +0,0 @@
---- a/drivers/net/wireless/mwifiex/sdio.c
-+++ b/drivers/net/wireless/mwifiex/sdio.c
-@@ -112,6 +112,7 @@ mwifiex_sdio_probe(struct sdio_func *fun
- 	return ret;
- }
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
- /*
-  * SDIO resume.
-  *
-@@ -156,6 +157,7 @@ static int mwifiex_sdio_resume(struct de
- 
- 	return 0;
- }
-+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34)) */
- 
- /*
-  * SDIO remove.
-@@ -183,8 +185,10 @@ mwifiex_sdio_remove(struct sdio_func *fu
- 	wait_for_completion(&adapter->fw_load);
- 
- 	if (user_rmmod) {
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
- 		if (adapter->is_suspended)
- 			mwifiex_sdio_resume(adapter->dev);
-+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34)) */
- 
- 		mwifiex_deauthenticate_all(adapter);
- 
-@@ -196,6 +200,7 @@ mwifiex_sdio_remove(struct sdio_func *fu
- 	mwifiex_remove_card(card->adapter, &add_remove_card_sem);
- }
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
- /*
-  * SDIO suspend.
-  *
-@@ -250,6 +255,7 @@ static int mwifiex_sdio_suspend(struct d
- 
- 	return ret;
- }
-+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34)) */
- 
- /* Device ID for SD8786 */
- #define SDIO_DEVICE_ID_MARVELL_8786   (0x9116)
-@@ -275,10 +281,12 @@ static const struct sdio_device_id mwifi
- 
- MODULE_DEVICE_TABLE(sdio, mwifiex_ids);
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
- static const struct dev_pm_ops mwifiex_sdio_pm_ops = {
- 	.suspend = mwifiex_sdio_suspend,
- 	.resume = mwifiex_sdio_resume,
- };
-+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34)) */
- 
- static struct sdio_driver mwifiex_sdio = {
- 	.name = "mwifiex_sdio",
-@@ -287,7 +295,9 @@ static struct sdio_driver mwifiex_sdio =
- 	.remove = mwifiex_sdio_remove,
- 	.drv = {
- 		.owner = THIS_MODULE,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34))
- 		.pm = &mwifiex_sdio_pm_ops,
-+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34)) */
- 	}
- };
- 
diff --git a/patches/collateral-evolutions/network/30-bridge-port/INFO b/patches/collateral-evolutions/network/30-bridge-port/INFO
deleted file mode 100644
index 2d9d24c..0000000
--- a/patches/collateral-evolutions/network/30-bridge-port/INFO
+++ /dev/null
@@ -1,23 +0,0 @@
-The patch titled:
-
-    bridge: use rx_handler_data pointer to store net_bridge_port pointer
-   
-by Jiri Pirko <jpirko@redhat.com> moved the br_ports pointer
-out of the netdev which older kernels relied on and then added
-a flag to the netdev to check for it as follows:
-
--                               dev->br_port) {
-+                   (dev->priv_flags & IFF_BRIDGE_PORT)) {
-
-So to backport this we instead rely on a br_port_exists() call
-which compat.git provides and depending on the kernel it will either
-check for the dev->br_port or the IFF_BRIDGE_PORT flag. A patch
-to get the blow code merged upstream and to use br_port_exists()
-everywhere else will be submitted but not sure if it will be
-accepted.
-
-This patch can be removed once we get br_port_exists() accessible
-to drivers and not just private bridge code. If that patch doesn't
-get accepted upstream we'l have to carry this patch around for
-compat-drivers.
-
diff --git a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
deleted file mode 100644
index ade2b0b..0000000
--- a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_nl80211.patch
+++ /dev/null
@@ -1,11 +0,0 @@
---- a/net/wireless/nl80211.c
-+++ b/net/wireless/nl80211.c
-@@ -2404,7 +2404,7 @@ static int nl80211_valid_4addr(struct cf
- 			       enum nl80211_iftype iftype)
- {
- 	if (!use_4addr) {
--		if (netdev && (netdev->priv_flags & IFF_BRIDGE_PORT))
-+		if (netdev && br_port_exists(netdev))
- 			return -EBUSY;
- 		return 0;
- 	}
diff --git a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_util.patch b/patches/collateral-evolutions/network/30-bridge-port/net_wireless_util.patch
deleted file mode 100644
index f0b1c9e..0000000
--- a/patches/collateral-evolutions/network/30-bridge-port/net_wireless_util.patch
+++ /dev/null
@@ -1,11 +0,0 @@
---- a/net/wireless/util.c
-+++ b/net/wireless/util.c
-@@ -882,7 +882,7 @@ int cfg80211_change_iface(struct cfg8021
- 		return -EOPNOTSUPP;
- 
- 	/* if it's part of a bridge, reject changing type to station/ibss */
--	if ((dev->priv_flags & IFF_BRIDGE_PORT) &&
-+	if (br_port_exists(dev) &&
- 	    (ntype == NL80211_IFTYPE_ADHOC ||
- 	     ntype == NL80211_IFTYPE_STATION ||
- 	     ntype == NL80211_IFTYPE_P2P_CLIENT))
diff --git a/patches/collateral-evolutions/network/32-remove-ns-type/net_wireless_sysfs.patch b/patches/collateral-evolutions/network/32-remove-ns-type/net_wireless_sysfs.patch
deleted file mode 100644
index 7db2dde..0000000
--- a/patches/collateral-evolutions/network/32-remove-ns-type/net_wireless_sysfs.patch
+++ /dev/null
@@ -1,28 +0,0 @@
---- a/net/wireless/sysfs.c
-+++ b/net/wireless/sysfs.c
-@@ -138,12 +138,14 @@ static int wiphy_resume(struct device *d
- }
- #endif
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- static const void *wiphy_namespace(struct device *d)
- {
- 	struct wiphy *wiphy = container_of(d, struct wiphy, dev);
- 
- 	return wiphy_net(wiphy);
- }
-+#endif
- 
- struct class ieee80211_class = {
- 	.name = "ieee80211",
-@@ -155,8 +157,10 @@ struct class ieee80211_class = {
- 	.suspend = wiphy_suspend,
- 	.resume = wiphy_resume,
- #endif
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	.ns_type = &net_ns_type_operations,
- 	.namespace = wiphy_namespace,
-+#endif
- };
- 
- int wiphy_sysfs_init(void)
diff --git a/patches/collateral-evolutions/network/36-workqueue/INFO b/patches/collateral-evolutions/network/36-workqueue/INFO
deleted file mode 100644
index a09aaa2..0000000
--- a/patches/collateral-evolutions/network/36-workqueue/INFO
+++ /dev/null
@@ -1,3 +0,0 @@
-Backport commit 99b88a0ecbdbc6df03527292571b2b442965814a
-The rest is backported in include/linux/compat-2.6.37.h
-
diff --git a/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch b/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch
deleted file mode 100644
index 31788e1..0000000
--- a/patches/collateral-evolutions/network/36-workqueue/net_mac80211_main.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/net/mac80211/main.c
-+++ b/net/mac80211/main.c
-@@ -1212,6 +1212,10 @@ static void __exit ieee80211_exit(void)
- 	rc80211_minstrel_ht_exit();
- 	rc80211_minstrel_exit();
- 
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,37))
-+	flush_scheduled_work();
-+#endif
-+
- 	ieee80211s_stop();
- 
- 	ieee80211_iface_exit();
diff --git a/patches/collateral-evolutions/network/37-vsnprintk/drivers_net_wireless_ath_main.patch b/patches/collateral-evolutions/network/37-vsnprintk/drivers_net_wireless_ath_main.patch
deleted file mode 100644
index b63faee..0000000
--- a/patches/collateral-evolutions/network/37-vsnprintk/drivers_net_wireless_ath_main.patch
+++ /dev/null
@@ -1,35 +0,0 @@
---- a/drivers/net/wireless/ath/main.c
-+++ b/drivers/net/wireless/ath/main.c
-@@ -67,6 +67,7 @@ bool ath_is_mybeacon(struct ath_common *
- }
- EXPORT_SYMBOL(ath_is_mybeacon);
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- void ath_printk(const char *level, const struct ath_common* common,
- 		const char *fmt, ...)
- {
-@@ -86,4 +87,24 @@ void ath_printk(const char *level, const
- 
- 	va_end(args);
- }
-+#else
-+void ath_printk(const char *level, const struct ath_common* common,
-+		const char *fmt, ...)
-+{
-+	va_list args;
-+
-+	va_start(args, fmt);
-+
-+	if (common && common->hw && common->hw->wiphy)
-+		printk("%sath: %s: ",
-+		       level, wiphy_name(common->hw->wiphy));
-+	else
-+		printk("%sath: ", level);
-+
-+	vprintk(fmt, args);
-+
-+	va_end(args);
-+}
-+#endif
-+
- EXPORT_SYMBOL(ath_printk);
diff --git a/patches/collateral-evolutions/network/38-led-max-brightness/drivers_net_wireless_iwlegacy_common.patch b/patches/collateral-evolutions/network/38-led-max-brightness/drivers_net_wireless_iwlegacy_common.patch
deleted file mode 100644
index 6e4a76c..0000000
--- a/patches/collateral-evolutions/network/38-led-max-brightness/drivers_net_wireless_iwlegacy_common.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/wireless/iwlegacy/common.c
-+++ b/drivers/net/wireless/iwlegacy/common.c
-@@ -561,7 +561,9 @@ il_leds_init(struct il_priv *il)
- 	    kasprintf(GFP_KERNEL, "%s-led", wiphy_name(il->hw->wiphy));
- 	il->led.brightness_set = il_led_brightness_set;
- 	il->led.blink_set = il_led_blink_set;
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,30)
- 	il->led.max_brightness = 1;
-+#endif
- 
- 	switch (mode) {
- 	case IL_LED_DEFAULT:
diff --git a/patches/collateral-evolutions/network/38-led-max-brightness/drivers_net_wireless_iwlwifi_dvm_led.patch b/patches/collateral-evolutions/network/38-led-max-brightness/drivers_net_wireless_iwlwifi_dvm_led.patch
deleted file mode 100644
index 05461b7..0000000
--- a/patches/collateral-evolutions/network/38-led-max-brightness/drivers_net_wireless_iwlwifi_dvm_led.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/wireless/iwlwifi/dvm/led.c
-+++ b/drivers/net/wireless/iwlwifi/dvm/led.c
-@@ -186,7 +186,9 @@ void iwl_leds_init(struct iwl_priv *priv
- 				   wiphy_name(priv->hw->wiphy));
- 	priv->led.brightness_set = iwl_led_brightness_set;
- 	priv->led.blink_set = iwl_led_blink_set;
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,30)
- 	priv->led.max_brightness = 1;
-+#endif
- 
- 	switch (mode) {
- 	case IWL_LED_DEFAULT:
diff --git a/patches/collateral-evolutions/network/38-led-max-brightness/drivers_net_wireless_iwlwifi_mvm_led.patch b/patches/collateral-evolutions/network/38-led-max-brightness/drivers_net_wireless_iwlwifi_mvm_led.patch
deleted file mode 100644
index 1f21097..0000000
--- a/patches/collateral-evolutions/network/38-led-max-brightness/drivers_net_wireless_iwlwifi_mvm_led.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/wireless/iwlwifi/mvm/led.c
-+++ b/drivers/net/wireless/iwlwifi/mvm/led.c
-@@ -110,7 +110,9 @@ int iwl_mvm_leds_init(struct iwl_mvm *mv
- 	mvm->led.name = kasprintf(GFP_KERNEL, "%s-led",
- 				   wiphy_name(mvm->hw->wiphy));
- 	mvm->led.brightness_set = iwl_led_brightness_set;
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,30)
- 	mvm->led.max_brightness = 1;
-+#endif
- 
- 	if (mode == IWL_LED_RF_STATE)
- 		mvm->led.default_trigger =
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/INFO b/patches/collateral-evolutions/network/40-netdev-hw-features/INFO
deleted file mode 100644
index 169682c..0000000
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/INFO
+++ /dev/null
@@ -1,20 +0,0 @@
-This reverts the commits that deal with hw_features and
-set_features, fix_features for kernels < 2.6.39.
-
-Below is one example commit being reverted, but we also do
-this for ath6kl and any driver that uses this in this file.
-
-commit 782d640afd15af7a1faf01cfe566ca4ac511319d
-Author: Michał Mirosław <mirq-linux@rere.qmqm.pl>
-Date:   Thu Apr 7 07:32:18 2011 +0000
-
-    net: atl*: convert to hw_features
-    
-    Things left as they were:
-     - atl1: is RX checksum really enabled?
-     - atl2: copy-paste from atl1, with-errors-on-modify I presume
-     - atl1c: there's a bug: MTU can't be changed if device is not up
-    
-    Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
-    Signed-off-by: David S. Miller <davem@davemloft.net>
-
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch
deleted file mode 100644
index ac4b617..0000000
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_alx_main.patch
+++ /dev/null
@@ -1,58 +0,0 @@
---- a/drivers/net/ethernet/atheros/alx/main.c
-+++ b/drivers/net/ethernet/atheros/alx/main.c
-@@ -733,6 +733,7 @@ static int alx_init_sw(struct alx_priv *
- }
- 
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
- static netdev_features_t alx_fix_features(struct net_device *netdev,
- 					  netdev_features_t features)
- {
-@@ -741,6 +742,7 @@ static netdev_features_t alx_fix_feature
- 
- 	return features;
- }
-+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39)) */
- 
- static void alx_netif_stop(struct alx_priv *alx)
- {
-@@ -817,7 +819,17 @@ static int alx_change_mtu(struct net_dev
- 	alx->hw.mtu = mtu;
- 	alx->rxbuf_size = mtu > ALX_DEF_RXBUF_SIZE ?
- 			   ALIGN(max_frame, 8) : ALX_DEF_RXBUF_SIZE;
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39))
-+	if (mtu > (7*1024)) {
-+		netdev->features &= ~NETIF_F_TSO;
-+		netdev->features &= ~NETIF_F_TSO6;
-+	} else {
-+		netdev->features |= NETIF_F_TSO;
-+		netdev->features |= NETIF_F_TSO6;
-+	}
-+#else
- 	netdev_update_features(netdev);
-+#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39)) */
- 	if (netif_running(netdev))
- 		alx_reinit(alx);
- 	return 0;
-@@ -1226,7 +1238,9 @@ static const struct net_device_ops alx_n
- 	.ndo_change_mtu         = alx_change_mtu,
- 	.ndo_do_ioctl           = alx_ioctl,
- 	.ndo_tx_timeout         = alx_tx_timeout,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
- 	.ndo_fix_features	= alx_fix_features,
-+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39)) */
- #ifdef CONFIG_NET_POLL_CONTROLLER
- 	.ndo_poll_controller    = alx_poll_controller,
- #endif
-@@ -1339,7 +1353,11 @@ static int alx_probe(struct pci_dev *pde
- 		}
- 	}
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
- 	netdev->hw_features = NETIF_F_SG | NETIF_F_HW_CSUM;
-+#else
-+	netdev->features = NETIF_F_SG | NETIF_F_HW_CSUM;
-+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39)) */
- 
- 	if (alx_get_perm_macaddr(hw, hw->perm_addr)) {
- 		dev_warn(&pdev->dev,
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1c_atl1c_ethtool.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1c_atl1c_ethtool.patch
deleted file mode 100644
index 2f762f1..0000000
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1c_atl1c_ethtool.patch
+++ /dev/null
@@ -1,28 +0,0 @@
---- a/drivers/net/ethernet/atheros/atl1c/atl1c_ethtool.c
-+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_ethtool.c
-@@ -114,6 +114,13 @@ static int atl1c_set_settings(struct net
- 	return 0;
- }
- 
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39))
-+static u32 atl1c_get_tx_csum(struct net_device *netdev)
-+{
-+	return (netdev->features & NETIF_F_HW_CSUM) != 0;
-+}
-+#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39)) */
-+
- static u32 atl1c_get_msglevel(struct net_device *netdev)
- {
- 	struct atl1c_adapter *adapter = netdev_priv(netdev);
-@@ -301,6 +308,11 @@ static const struct ethtool_ops atl1c_et
- 	.get_link               = ethtool_op_get_link,
- 	.get_eeprom_len         = atl1c_get_eeprom_len,
- 	.get_eeprom             = atl1c_get_eeprom,
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39))
-+	.get_tx_csum            = atl1c_get_tx_csum,
-+	.get_sg                 = ethtool_op_get_sg,
-+	.set_sg                 = ethtool_op_set_sg,
-+#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39)) */
- };
- 
- void atl1c_set_ethtool_ops(struct net_device *netdev)
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
deleted file mode 100644
index be9c1b8..0000000
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
+++ /dev/null
@@ -1,72 +0,0 @@
---- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
-+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
-@@ -494,6 +494,7 @@ static void atl1c_set_rxbufsize(struct a
- 	adapter->rx_frag_size = roundup_pow_of_two(head_size);
- }
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
- static netdev_features_t atl1c_fix_features(struct net_device *netdev,
- 	netdev_features_t features)
- {
-@@ -522,6 +523,7 @@ static int atl1c_set_features(struct net
- 
- 	return 0;
- }
-+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39)) */
- 
- /**
-  * atl1c_change_mtu - Change the Maximum Transfer Unit
-@@ -554,8 +556,19 @@ static int atl1c_change_mtu(struct net_d
- 		netdev->mtu = new_mtu;
- 		adapter->hw.max_frame_size = new_mtu;
- 		atl1c_set_rxbufsize(adapter, netdev);
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39))
-+		if (new_mtu > MAX_TSO_FRAME_SIZE) {
-+			adapter->netdev->features &= ~NETIF_F_TSO;
-+			adapter->netdev->features &= ~NETIF_F_TSO6;
-+		} else {
-+			adapter->netdev->features |= NETIF_F_TSO;
-+			adapter->netdev->features |= NETIF_F_TSO6;
-+		}
-+#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39)) */
- 		atl1c_down(adapter);
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
- 		netdev_update_features(netdev);
-+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39)) */
- 		atl1c_up(adapter);
- 		clear_bit(__AT_RESETTING, &adapter->flags);
- 	}
-@@ -2504,8 +2517,10 @@ static const struct net_device_ops atl1c
- 	.ndo_set_mac_address	= atl1c_set_mac_addr,
- 	.ndo_set_rx_mode	= atl1c_set_multi,
- 	.ndo_change_mtu		= atl1c_change_mtu,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
- 	.ndo_fix_features	= atl1c_fix_features,
- 	.ndo_set_features	= atl1c_set_features,
-+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39)) */
- 	.ndo_do_ioctl		= atl1c_ioctl,
- 	.ndo_tx_timeout		= atl1c_tx_timeout,
- 	.ndo_get_stats		= atl1c_get_stats,
-@@ -2523,6 +2538,7 @@ static int atl1c_init_netdev(struct net_
- 	netdev->watchdog_timeo = AT_TX_WATCHDOG;
- 	atl1c_set_ethtool_ops(netdev);
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
- 	/* TODO: add when ready */
- 	netdev->hw_features =	NETIF_F_SG		|
- 				NETIF_F_HW_CSUM		|
-@@ -2531,6 +2547,14 @@ static int atl1c_init_netdev(struct net_
- 				NETIF_F_TSO6;
- 	netdev->features =	netdev->hw_features	|
- 				NETIF_F_HW_VLAN_CTAG_TX;
-+#else
-+	netdev->features =	NETIF_F_SG	   |
-+				NETIF_F_HW_CSUM	   |
-+				NETIF_F_HW_VLAN_TX |
-+				NETIF_F_HW_VLAN_RX |
-+				NETIF_F_TSO	   |
-+				NETIF_F_TSO6;
-+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39)) */
- 	return 0;
- }
- 
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1e_atl1e_ethtool.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1e_atl1e_ethtool.patch
deleted file mode 100644
index 7445db6..0000000
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1e_atl1e_ethtool.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/net/ethernet/atheros/atl1e/atl1e_ethtool.c
-+++ b/drivers/net/ethernet/atheros/atl1e/atl1e_ethtool.c
-@@ -384,6 +384,11 @@ static const struct ethtool_ops atl1e_et
- 	.get_eeprom_len         = atl1e_get_eeprom_len,
- 	.get_eeprom             = atl1e_get_eeprom,
- 	.set_eeprom             = atl1e_set_eeprom,
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39))
-+	.set_tx_csum            = ethtool_op_set_tx_hw_csum,
-+	.set_sg                 = ethtool_op_set_sg,
-+	.set_tso                = ethtool_op_set_tso,
-+#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39)) */
- };
- 
- void atl1e_set_ethtool_ops(struct net_device *netdev)
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1e_atl1e_main.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1e_atl1e_main.patch
deleted file mode 100644
index 72488f9..0000000
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atl1e_atl1e_main.patch
+++ /dev/null
@@ -1,75 +0,0 @@
---- a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
-+++ b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
-@@ -313,6 +313,7 @@ static void atl1e_set_multi(struct net_d
- 	}
- }
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
- static void __atl1e_rx_mode(netdev_features_t features, u32 *mac_ctrl_data)
- {
- 
-@@ -339,6 +340,7 @@ static void atl1e_rx_mode(struct net_dev
- 	AT_WRITE_REG(&adapter->hw, REG_MAC_CTRL, mac_ctrl_data);
- 	atl1e_irq_enable(adapter);
- }
-+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39)) */
- 
- 
- static void __atl1e_vlan_mode(netdev_features_t features, u32 *mac_ctrl_data)
-@@ -399,6 +401,7 @@ static int atl1e_set_mac_addr(struct net
- 	return 0;
- }
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
- static netdev_features_t atl1e_fix_features(struct net_device *netdev,
- 	netdev_features_t features)
- {
-@@ -428,6 +431,7 @@ static int atl1e_set_features(struct net
- 
- 	return 0;
- }
-+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39)) */
- 
- /**
-  * atl1e_change_mtu - Change the Maximum Transfer Unit
-@@ -1995,7 +1999,11 @@ void atl1e_down(struct atl1e_adapter *ad
- 	 * reschedule our watchdog timer */
- 	set_bit(__AT_DOWN, &adapter->flags);
- 
-+#if defined(NETIF_F_LLTX) || (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
- 	netif_stop_queue(netdev);
-+#else
-+	netif_tx_disable(netdev);
-+#endif
- 
- 	/* reset MAC to disable all RX/TX */
- 	atl1e_reset_hw(&adapter->hw);
-@@ -2265,8 +2273,10 @@ static const struct net_device_ops atl1e
- 	.ndo_set_rx_mode	= atl1e_set_multi,
- 	.ndo_validate_addr	= eth_validate_addr,
- 	.ndo_set_mac_address	= atl1e_set_mac_addr,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
- 	.ndo_fix_features	= atl1e_fix_features,
- 	.ndo_set_features	= atl1e_set_features,
-+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39)) */
- 	.ndo_change_mtu		= atl1e_change_mtu,
- 	.ndo_do_ioctl		= atl1e_ioctl,
- 	.ndo_tx_timeout		= atl1e_tx_timeout,
-@@ -2286,12 +2296,17 @@ static int atl1e_init_netdev(struct net_
- 	netdev->watchdog_timeo = AT_TX_WATCHDOG;
- 	atl1e_set_ethtool_ops(netdev);
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
- 	netdev->hw_features = NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_TSO |
- 			      NETIF_F_HW_VLAN_CTAG_RX;
- 	netdev->features = netdev->hw_features | NETIF_F_LLTX |
- 			   NETIF_F_HW_VLAN_CTAG_TX;
- 	/* not enabled by default */
- 	netdev->hw_features |= NETIF_F_RXALL | NETIF_F_RXFCS;
-+#else
-+	netdev->features = NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_TSO |
-+			   NETIF_F_HW_VLAN_RX | NETIF_F_LLTX | NETIF_F_HW_VLAN_TX;
-+#endif
- 	return 0;
- }
- 
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl1.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl1.patch
deleted file mode 100644
index 894bcc7..0000000
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl1.patch
+++ /dev/null
@@ -1,55 +0,0 @@
---- a/drivers/net/ethernet/atheros/atlx/atl1.c
-+++ b/drivers/net/ethernet/atheros/atlx/atl1.c
-@@ -2916,8 +2916,10 @@ static const struct net_device_ops atl1_
- 	.ndo_validate_addr	= eth_validate_addr,
- 	.ndo_set_mac_address	= atl1_set_mac,
- 	.ndo_change_mtu		= atl1_change_mtu,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
- 	.ndo_fix_features	= atlx_fix_features,
- 	.ndo_set_features	= atlx_set_features,
-+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39)) */
- 	.ndo_do_ioctl		= atlx_ioctl,
- 	.ndo_tx_timeout		= atlx_tx_timeout,
- #ifdef CONFIG_NET_POLL_CONTROLLER
-@@ -3027,11 +3029,13 @@ static int atl1_probe(struct pci_dev *pd
- 	netdev->features |= NETIF_F_SG;
- 	netdev->features |= (NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX);
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
- 	netdev->hw_features = NETIF_F_HW_CSUM | NETIF_F_SG | NETIF_F_TSO |
- 			      NETIF_F_HW_VLAN_CTAG_RX;
- 
- 	/* is this valid? see atl1_setup_mac_ctrl() */
- 	netdev->features |= NETIF_F_RXCSUM;
-+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39)) */
- 
- 	/*
- 	 * patch for some L1 of old version,
-@@ -3615,6 +3619,14 @@ static int atl1_set_pauseparam(struct ne
- 	return 0;
- }
- 
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39))
-+/* FIXME: is this right? -- CHS */
-+static u32 atl1_get_rx_csum(struct net_device *netdev)
-+{
-+	return 1;
-+}
-+#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39)) */
-+
- static void atl1_get_strings(struct net_device *netdev, u32 stringset,
- 	u8 *data)
- {
-@@ -3687,6 +3699,12 @@ static const struct ethtool_ops atl1_eth
- 	.nway_reset		= atl1_nway_reset,
- 	.get_ethtool_stats	= atl1_get_ethtool_stats,
- 	.get_sset_count		= atl1_get_sset_count,
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39))
-+	.get_rx_csum		= atl1_get_rx_csum,
-+	.set_tx_csum		= ethtool_op_set_tx_hw_csum,
-+	.set_sg			= ethtool_op_set_sg,
-+	.set_tso		= ethtool_op_set_tso,
-+#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39)) */
- };
- 
- module_pci_driver(atl1_driver);
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl2.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl2.patch
deleted file mode 100644
index f2f05c7..0000000
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atl2.patch
+++ /dev/null
@@ -1,98 +0,0 @@
---- a/drivers/net/ethernet/atheros/atlx/atl2.c
-+++ b/drivers/net/ethernet/atheros/atlx/atl2.c
-@@ -361,6 +361,7 @@ static inline void atl2_irq_disable(stru
-     synchronize_irq(adapter->pdev->irq);
- }
- 
-+#if defined(NETIF_F_HW_VLAN_TX) || (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
- static void __atl2_vlan_mode(netdev_features_t features, u32 *ctrl)
- {
- 	if (features & NETIF_F_HW_VLAN_CTAG_RX) {
-@@ -386,12 +387,16 @@ static void atl2_vlan_mode(struct net_de
- 
- 	atl2_irq_enable(adapter);
- }
-+#endif
- 
- static void atl2_restore_vlan(struct atl2_adapter *adapter)
- {
-+#if defined(NETIF_F_HW_VLAN_TX) || (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
- 	atl2_vlan_mode(adapter->netdev, adapter->netdev->features);
-+#endif
- }
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
- static netdev_features_t atl2_fix_features(struct net_device *netdev,
- 	netdev_features_t features)
- {
-@@ -417,6 +422,7 @@ static int atl2_set_features(struct net_
- 
- 	return 0;
- }
-+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39)) */
- 
- static void atl2_intr_rx(struct atl2_adapter *adapter)
- {
-@@ -1150,7 +1156,9 @@ static void atl2_setup_mac_ctrl(struct a
- 		MAC_CTRL_PRMLEN_SHIFT);
- 
- 	/* vlan */
-+#if defined(NETIF_F_HW_VLAN_TX) || (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
- 	__atl2_vlan_mode(netdev->features, &value);
-+#endif
- 
- 	/* filter mode */
- 	value |= MAC_CTRL_BC_EN;
-@@ -1315,8 +1323,10 @@ static const struct net_device_ops atl2_
- 	.ndo_validate_addr	= eth_validate_addr,
- 	.ndo_set_mac_address	= atl2_set_mac,
- 	.ndo_change_mtu		= atl2_change_mtu,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
- 	.ndo_fix_features	= atl2_fix_features,
- 	.ndo_set_features	= atl2_set_features,
-+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39)) */
- 	.ndo_do_ioctl		= atl2_ioctl,
- 	.ndo_tx_timeout		= atl2_tx_timeout,
- #ifdef CONFIG_NET_POLL_CONTROLLER
-@@ -1413,8 +1423,12 @@ static int atl2_probe(struct pci_dev *pd
- 
- 	err = -EIO;
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
- 	netdev->hw_features = NETIF_F_SG | NETIF_F_HW_VLAN_CTAG_RX;
-+#endif
-+#if defined(NETIF_F_HW_VLAN_TX) || (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
- 	netdev->features |= (NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX);
-+#endif
- 
- 	/* Init PHY as early as possible due to power saving issue  */
- 	atl2_phy_init(&adapter->hw);
-@@ -2088,6 +2102,13 @@ static int atl2_nway_reset(struct net_de
- 	return 0;
- }
- 
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39))
-+static u32 atl2_get_tx_csum(struct net_device *netdev)
-+{
-+	return (netdev->features & NETIF_F_HW_CSUM) != 0;
-+}
-+#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39)) */
-+
- static const struct ethtool_ops atl2_ethtool_ops = {
- 	.get_settings		= atl2_get_settings,
- 	.set_settings		= atl2_set_settings,
-@@ -2103,6 +2124,14 @@ static const struct ethtool_ops atl2_eth
- 	.get_eeprom_len		= atl2_get_eeprom_len,
- 	.get_eeprom		= atl2_get_eeprom,
- 	.set_eeprom		= atl2_set_eeprom,
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39))
-+	.get_tx_csum		= atl2_get_tx_csum,
-+	.get_sg			= ethtool_op_get_sg,
-+	.set_sg			= ethtool_op_set_sg,
-+#ifdef NETIF_F_TSO
-+	.get_tso		= ethtool_op_get_tso,
-+#endif
-+#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,39)) */
- };
- 
- static void atl2_set_ethtool_ops(struct net_device *netdev)
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atlx.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atlx.patch
deleted file mode 100644
index c315e36..0000000
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_ethernet_atheros_atlx_atlx.patch
+++ /dev/null
@@ -1,17 +0,0 @@
---- a/drivers/net/ethernet/atheros/atlx/atlx.c
-+++ b/drivers/net/ethernet/atheros/atlx/atlx.c
-@@ -250,6 +250,7 @@ static void atlx_restore_vlan(struct atl
- 	atlx_vlan_mode(adapter->netdev, adapter->netdev->features);
- }
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
- static netdev_features_t atlx_fix_features(struct net_device *netdev,
- 	netdev_features_t features)
- {
-@@ -275,5 +276,6 @@ static int atlx_set_features(struct net_
- 
- 	return 0;
- }
-+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39)) */
- 
- #endif /* ATLX_C */
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_wireless_ath_ath6kl_main.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_wireless_ath_ath6kl_main.patch
deleted file mode 100644
index f59f657..0000000
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_wireless_ath_ath6kl_main.patch
+++ /dev/null
@@ -1,40 +0,0 @@
---- a/drivers/net/wireless/ath/ath6kl/main.c
-+++ b/drivers/net/wireless/ath/ath6kl/main.c
-@@ -1119,6 +1119,7 @@ static struct net_device_stats *ath6kl_g
- 	return &vif->net_stats;
- }
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
- static int ath6kl_set_features(struct net_device *dev,
- 			       netdev_features_t features)
- {
-@@ -1151,6 +1152,7 @@ static int ath6kl_set_features(struct ne
- 
- 	return err;
- }
-+#endif
- 
- static void ath6kl_set_multicast_list(struct net_device *ndev)
- {
-@@ -1286,7 +1288,9 @@ static const struct net_device_ops ath6k
- 	.ndo_stop               = ath6kl_close,
- 	.ndo_start_xmit         = ath6kl_data_tx,
- 	.ndo_get_stats          = ath6kl_get_stats,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
- 	.ndo_set_features       = ath6kl_set_features,
-+#endif
- 	.ndo_set_rx_mode	= ath6kl_set_multicast_list,
- };
- 
-@@ -1303,7 +1307,11 @@ void init_netdev(struct net_device *dev)
- 					WMI_MAX_TX_META_SZ +
- 					ATH6KL_HTC_ALIGN_BYTES, 4);
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
- 	dev->hw_features |= NETIF_F_IP_CSUM | NETIF_F_RXCSUM;
-+#else
-+	dev->features |= NETIF_F_IP_CSUM;
-+#endif
- 
- 	return;
- }
diff --git a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_wireless_ath_wil6210_netdev.patch b/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_wireless_ath_wil6210_netdev.patch
deleted file mode 100644
index f5db9a4..0000000
--- a/patches/collateral-evolutions/network/40-netdev-hw-features/drivers_net_wireless_ath_wil6210_netdev.patch
+++ /dev/null
@@ -1,16 +0,0 @@
---- a/drivers/net/wireless/ath/wil6210/netdev.c
-+++ b/drivers/net/wireless/ath/wil6210/netdev.c
-@@ -127,9 +127,13 @@ void *wil_if_alloc(struct device *dev, v
- 
- 	ndev->netdev_ops = &wil_netdev_ops;
- 	ndev->ieee80211_ptr = wdev;
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
- 	ndev->hw_features = NETIF_F_HW_CSUM | NETIF_F_RXCSUM |
- 			    NETIF_F_SG | NETIF_F_GRO;
- 	ndev->features |= ndev->hw_features;
-+#else
-+	ndev->features |= NETIF_F_HW_CSUM | NETIF_F_RXCSUM | NETIF_F_SG;
-+#endif
- 	SET_NETDEV_DEV(ndev, wiphy_dev(wdev->wiphy));
- 	wdev->netdev = ndev;
- 
diff --git a/patches/collateral-evolutions/network/45-remove-platform-id-table/drivers_net_wireless_ath_wcn36xx_main.patch b/patches/collateral-evolutions/network/45-remove-platform-id-table/drivers_net_wireless_ath_wcn36xx_main.patch
deleted file mode 100644
index 887162e..0000000
--- a/patches/collateral-evolutions/network/45-remove-platform-id-table/drivers_net_wireless_ath_wcn36xx_main.patch
+++ /dev/null
@@ -1,28 +0,0 @@
---- a/drivers/net/wireless/ath/wcn36xx/main.c
-+++ b/drivers/net/wireless/ath/wcn36xx/main.c
-@@ -1062,6 +1062,7 @@ static int wcn36xx_remove(struct platfor
- 
- 	return 0;
- }
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,30)
- static const struct platform_device_id wcn36xx_platform_id_table[] = {
- 	{
- 		.name = "wcn36xx",
-@@ -1070,6 +1071,7 @@ static const struct platform_device_id w
- 	{}
- };
- MODULE_DEVICE_TABLE(platform, wcn36xx_platform_id_table);
-+#endif
- 
- static struct platform_driver wcn36xx_driver = {
- 	.probe      = wcn36xx_probe,
-@@ -1078,7 +1080,9 @@ static struct platform_driver wcn36xx_dr
- 		.name   = "wcn36xx",
- 		.owner  = THIS_MODULE,
- 	},
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,30)
- 	.id_table    = wcn36xx_platform_id_table,
-+#endif
- };
- 
- static int __init wcn36xx_init(void)
diff --git a/patches/collateral-evolutions/network/45-remove-platform-id-table/drivers_net_wireless_ti_wl12xx_main.patch b/patches/collateral-evolutions/network/45-remove-platform-id-table/drivers_net_wireless_ti_wl12xx_main.patch
deleted file mode 100644
index 4a1662b..0000000
--- a/patches/collateral-evolutions/network/45-remove-platform-id-table/drivers_net_wireless_ti_wl12xx_main.patch
+++ /dev/null
@@ -1,23 +0,0 @@
---- a/drivers/net/wireless/ti/wl12xx/main.c
-+++ b/drivers/net/wireless/ti/wl12xx/main.c
-@@ -1888,16 +1888,20 @@ out:
- 	return wlcore_remove(pdev);
- }
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,30)
- static const struct platform_device_id wl12xx_id_table[] = {
- 	{ "wl12xx", 0 },
- 	{  } /* Terminating Entry */
- };
- MODULE_DEVICE_TABLE(platform, wl12xx_id_table);
-+#endif
- 
- static struct platform_driver wl12xx_driver = {
- 	.probe		= wl12xx_probe,
- 	.remove		= wl12xx_remove,
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,30)
- 	.id_table	= wl12xx_id_table,
-+#endif
- 	.driver = {
- 		.name	= "wl12xx_driver",
- 		.owner	= THIS_MODULE,
diff --git a/patches/collateral-evolutions/network/47-no_trans_start_on_netdev_queue/INFO b/patches/collateral-evolutions/network/47-no_trans_start_on_netdev_queue/INFO
deleted file mode 100644
index dcb74b3..0000000
--- a/patches/collateral-evolutions/network/47-no_trans_start_on_netdev_queue/INFO
+++ /dev/null
@@ -1,4 +0,0 @@
-The struct netdev_queue does not have the attribute trans_start in
-kernel < 2.6.31. trans_start on struct net_device does the same
-on older kernels.
-
diff --git a/patches/collateral-evolutions/network/47-no_trans_start_on_netdev_queue/drivers_net_wireless_mwifiex_init.patch b/patches/collateral-evolutions/network/47-no_trans_start_on_netdev_queue/drivers_net_wireless_mwifiex_init.patch
deleted file mode 100644
index e741007..0000000
--- a/patches/collateral-evolutions/network/47-no_trans_start_on_netdev_queue/drivers_net_wireless_mwifiex_init.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/net/wireless/mwifiex/init.c
-+++ b/drivers/net/wireless/mwifiex/init.c
-@@ -293,8 +293,10 @@ void mwifiex_set_trans_start(struct net_
- {
- 	int i;
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,31))
- 	for (i = 0; i < dev->num_tx_queues; i++)
- 		netdev_get_tx_queue(dev, i)->trans_start = jiffies;
-+#endif
- 
- 	dev->trans_start = jiffies;
- }
diff --git a/patches/collateral-evolutions/network/48-use_skb_get_queue_mapping/INFO b/patches/collateral-evolutions/network/48-use_skb_get_queue_mapping/INFO
deleted file mode 100644
index 7463568..0000000
--- a/patches/collateral-evolutions/network/48-use_skb_get_queue_mapping/INFO
+++ /dev/null
@@ -1,4 +0,0 @@
-Use skb_get_queue_mapping() for getting the queue_mapping member of 
-skb. Some old kernels do not have the member queue_mapping, but this 
-function always returns something.
-
diff --git a/patches/collateral-evolutions/network/48-use_skb_get_queue_mapping/drivers_net_wireless_b43_main.patch b/patches/collateral-evolutions/network/48-use_skb_get_queue_mapping/drivers_net_wireless_b43_main.patch
deleted file mode 100644
index 0c0e7e7..0000000
--- a/patches/collateral-evolutions/network/48-use_skb_get_queue_mapping/drivers_net_wireless_b43_main.patch
+++ /dev/null
@@ -1,17 +0,0 @@
---- a/drivers/net/wireless/b43/main.c
-+++ b/drivers/net/wireless/b43/main.c
-@@ -3456,11 +3456,11 @@ static void b43_op_tx(struct ieee80211_h
- 	}
- 	B43_WARN_ON(skb_shinfo(skb)->nr_frags);
- 
--	skb_queue_tail(&wl->tx_queue[skb->queue_mapping], skb);
--	if (!wl->tx_queue_stopped[skb->queue_mapping]) {
-+	skb_queue_tail(&wl->tx_queue[skb_get_queue_mapping(skb)], skb);
-+	if (!wl->tx_queue_stopped[skb_get_queue_mapping(skb)]) {
- 		ieee80211_queue_work(wl->hw, &wl->tx_work);
- 	} else {
--		ieee80211_stop_queue(wl->hw, skb->queue_mapping);
-+		ieee80211_stop_queue(wl->hw, skb_get_queue_mapping(skb));
- 	}
- }
- 
diff --git a/patches/collateral-evolutions/network/48-use_skb_get_queue_mapping/drivers_net_wireless_b43legacy_main.patch b/patches/collateral-evolutions/network/48-use_skb_get_queue_mapping/drivers_net_wireless_b43legacy_main.patch
deleted file mode 100644
index 8da8a05..0000000
--- a/patches/collateral-evolutions/network/48-use_skb_get_queue_mapping/drivers_net_wireless_b43legacy_main.patch
+++ /dev/null
@@ -1,17 +0,0 @@
---- a/drivers/net/wireless/b43legacy/main.c
-+++ b/drivers/net/wireless/b43legacy/main.c
-@@ -2529,11 +2529,11 @@ static void b43legacy_op_tx(struct ieee8
- 	}
- 	B43legacy_WARN_ON(skb_shinfo(skb)->nr_frags);
- 
--	skb_queue_tail(&wl->tx_queue[skb->queue_mapping], skb);
--	if (!wl->tx_queue_stopped[skb->queue_mapping])
-+	skb_queue_tail(&wl->tx_queue[skb_get_queue_mapping(skb)], skb);
-+	if (!wl->tx_queue_stopped[skb_get_queue_mapping(skb)])
- 		ieee80211_queue_work(wl->hw, &wl->tx_work);
- 	else
--		ieee80211_stop_queue(wl->hw, skb->queue_mapping);
-+		ieee80211_stop_queue(wl->hw, skb_get_queue_mapping(skb));
- }
- 
- static int b43legacy_op_conf_tx(struct ieee80211_hw *hw,
diff --git a/patches/collateral-evolutions/network/52-tty-dev/INFO b/patches/collateral-evolutions/network/52-tty-dev/INFO
deleted file mode 100644
index e9fe2d1..0000000
--- a/patches/collateral-evolutions/network/52-tty-dev/INFO
+++ /dev/null
@@ -1,19 +0,0 @@
-
-tty->dev does not exist until 2.6.37. Typically
-subsystems will assign the tty device to a child
-to make a symlink under /sys/class/foobar. An example
-is the bluetooth subsystem.
-
-commit 7f4b2b04c88377af30c022f36c060190182850fb
-Author: Andrei Warkentin <andreiw@motorola.com>
-Date:   Fri Feb 11 17:19:26 2011 -0600
-
-    Bluetooth: Make hci a child of the corresponding tty device.
-    
-    Make /sys/class/bluetooth/hciX a symlink to
-    path under corresponding tty.
-    
-    Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
-    Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
-
-
diff --git a/patches/collateral-evolutions/network/52-tty-dev/drivers_bluetooth_hci_ldisc.patch b/patches/collateral-evolutions/network/52-tty-dev/drivers_bluetooth_hci_ldisc.patch
deleted file mode 100644
index 611b633..0000000
--- a/patches/collateral-evolutions/network/52-tty-dev/drivers_bluetooth_hci_ldisc.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/bluetooth/hci_ldisc.c
-+++ b/drivers/bluetooth/hci_ldisc.c
-@@ -417,7 +417,10 @@ static int hci_uart_register_dev(struct
- 	hdev->close = hci_uart_close;
- 	hdev->flush = hci_uart_flush;
- 	hdev->send  = hci_uart_send_frame;
-+
-+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,6,36))
- 	SET_HCIDEV_DEV(hdev, hu->tty->dev);
-+#endif
- 
- 	if (test_bit(HCI_UART_RAW_DEVICE, &hu->hdev_flags))
- 		set_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks);
diff --git a/patches/collateral-evolutions/network/61-netdev-addr_assign_type/INFO b/patches/collateral-evolutions/network/61-netdev-addr_assign_type/INFO
deleted file mode 100644
index 08a9b21..0000000
--- a/patches/collateral-evolutions/network/61-netdev-addr_assign_type/INFO
+++ /dev/null
@@ -1,7 +0,0 @@
-You cannot backport assignment of netdev->addr_assign_type
-given that its part of the netdev data structure only in future
-kernels.
-
-mcgrof@tux ~/linux-next (git::master)$ git describe --contains c1f79426
-v2.6.36-rc1~571^2~104
-
diff --git a/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_alx_main.patch b/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_alx_main.patch
deleted file mode 100644
index f3e25d8..0000000
--- a/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_alx_main.patch
+++ /dev/null
@@ -1,13 +0,0 @@
---- a/drivers/net/ethernet/atheros/alx/main.c
-+++ b/drivers/net/ethernet/atheros/alx/main.c
-@@ -495,8 +495,10 @@ static int alx_set_mac_address(struct ne
- 	if (!is_valid_ether_addr(addr->sa_data))
- 		return -EADDRNOTAVAIL;
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- 	if (netdev->addr_assign_type & NET_ADDR_RANDOM)
- 		netdev->addr_assign_type ^= NET_ADDR_RANDOM;
-+#endif
- 
- 	memcpy(netdev->dev_addr, addr->sa_data, netdev->addr_len);
- 	memcpy(hw->mac_addr, addr->sa_data, netdev->addr_len);
diff --git a/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch b/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
deleted file mode 100644
index 34e5951..0000000
--- a/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_atl1c_atl1c_main.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
-+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
-@@ -2667,7 +2667,9 @@ static int atl1c_probe(struct pci_dev *p
- 	}
- 	if (atl1c_read_mac_addr(&adapter->hw)) {
- 		/* got a random MAC address, set NET_ADDR_RANDOM to netdev */
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- 		netdev->addr_assign_type = NET_ADDR_RANDOM;
-+#endif
- 	}
- 	memcpy(netdev->dev_addr, adapter->hw.mac_addr, netdev->addr_len);
- 	if (netif_msg_probe(adapter))
diff --git a/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_atlx_atl1.patch b/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_atlx_atl1.patch
deleted file mode 100644
index 7cdb943..0000000
--- a/patches/collateral-evolutions/network/61-netdev-addr_assign_type/drivers_net_ethernet_atheros_atlx_atl1.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/drivers/net/ethernet/atheros/atlx/atl1.c
-+++ b/drivers/net/ethernet/atheros/atlx/atl1.c
-@@ -3059,7 +3059,9 @@ static int atl1_probe(struct pci_dev *pd
- 	/* copy the MAC address out of the EEPROM */
- 	if (atl1_read_mac_addr(&adapter->hw)) {
- 		/* mark random mac */
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- 		netdev->addr_assign_type = NET_ADDR_RANDOM;
-+#endif
- 	}
- 	memcpy(netdev->dev_addr, adapter->hw.mac_addr, netdev->addr_len);
- 
diff --git a/patches/collateral-evolutions/network/61-netdev-addr_assign_type/net_bluetooth_6lowpan.patch b/patches/collateral-evolutions/network/61-netdev-addr_assign_type/net_bluetooth_6lowpan.patch
deleted file mode 100644
index ad2618f..0000000
--- a/patches/collateral-evolutions/network/61-netdev-addr_assign_type/net_bluetooth_6lowpan.patch
+++ /dev/null
@@ -1,12 +0,0 @@
---- a/net/bluetooth/6lowpan.c
-+++ b/net/bluetooth/6lowpan.c
-@@ -632,7 +632,9 @@ static void set_addr(u8 *eui, u8 *addr,
- static void set_dev_addr(struct net_device *netdev, bdaddr_t *addr,
- 		         u8 addr_type)
- {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36)
- 	netdev->addr_assign_type = NET_ADDR_PERM;
-+#endif
- 	set_addr(netdev->dev_addr, addr->b, addr_type);
- 	netdev->dev_addr[0] ^= 2;
- }
diff --git a/patches/collateral-evolutions/network/61-netdev-addr_assign_type/usbnet.patch b/patches/collateral-evolutions/network/61-netdev-addr_assign_type/usbnet.patch
deleted file mode 100644
index fa27163..0000000
--- a/patches/collateral-evolutions/network/61-netdev-addr_assign_type/usbnet.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/net/usb/usbnet.c
-+++ b/drivers/net/usb/usbnet.c
-@@ -1666,9 +1666,11 @@ usbnet_probe (struct usb_interface *udev
- 		dev->rx_urb_size = dev->hard_mtu;
- 	dev->maxpacket = usb_maxpacket (dev->udev, dev->out, 1);
- 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36)
- 	/* let userspace know we have a random address */
- 	if (ether_addr_equal(net->dev_addr, node_id))
- 		net->addr_assign_type = NET_ADDR_RANDOM;
-+#endif
- 
- 	if ((dev->driver_info->flags & FLAG_WLAN) != 0)
- 		SET_NETDEV_DEVTYPE(net, &wlan_type);
diff --git a/patches/collateral-evolutions/network/64-b44-32bit-stats/INFO b/patches/collateral-evolutions/network/64-b44-32bit-stats/INFO
deleted file mode 100644
index ebe61cf..0000000
--- a/patches/collateral-evolutions/network/64-b44-32bit-stats/INFO
+++ /dev/null
@@ -1,14 +0,0 @@
-This patch requires a manual backport:
-
-commit eeda8585522bcc173f91d6254dfa63e871087c54
-Author: Kevin Groeneveld <kgroeneveld@gmail.com>
-Date:   Tue Jul 17 17:46:01 2012 +0000
-
-    b44: add 64 bit stats
-    
-    Add support for 64 bit stats to Broadcom b44 ethernet driver.
-    
-    Signed-off-by: Kevin Groeneveld <kgroeneveld@gmail.com>
-    Signed-off-by: Eric Dumazet <edumazet@google.com>
-    Signed-off-by: David S. Miller <davem@davemloft.net>
-
diff --git a/patches/collateral-evolutions/network/64-b44-32bit-stats/alx.patch b/patches/collateral-evolutions/network/64-b44-32bit-stats/alx.patch
deleted file mode 100644
index 9e4e6d9..0000000
--- a/patches/collateral-evolutions/network/64-b44-32bit-stats/alx.patch
+++ /dev/null
@@ -1,36 +0,0 @@
-diff --git a/drivers/net/ethernet/atheros/alx/main.c b/drivers/net/ethernet/atheros/alx/main.c
-index e92ffd6..78bf4f4 100644
---- a/drivers/net/ethernet/atheros/alx/main.c
-+++ b/drivers/net/ethernet/atheros/alx/main.c
-@@ -1180,11 +1180,19 @@ static void alx_poll_controller(struct n
- }
- #endif
- 
-+
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- static struct rtnl_link_stats64 *alx_get_stats64(struct net_device *dev,
- 					struct rtnl_link_stats64 *net_stats)
-+#else
-+static struct net_device_stats *alx_get_stats(struct net_device *dev)
-+#endif
- {
- 	struct alx_priv *alx = netdev_priv(dev);
- 	struct alx_hw_stats *hw_stats = &alx->hw.stats;
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36))
-+	struct net_device_stats *net_stats = &dev->stats;
-+#endif
- 
- 	spin_lock(&alx->stats_lock);
- 
-@@ -1233,7 +1241,11 @@ static const struct net_device_ops alx_n
- 	.ndo_open               = alx_open,
- 	.ndo_stop               = alx_stop,
- 	.ndo_start_xmit         = alx_start_xmit,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- 	.ndo_get_stats64        = alx_get_stats64,
-+#else
-+	.ndo_get_stats		= alx_get_stats,
-+#endif
- 	.ndo_set_rx_mode        = alx_set_rx_mode,
- 	.ndo_validate_addr      = eth_validate_addr,
- 	.ndo_set_mac_address    = alx_set_mac_address,
diff --git a/patches/collateral-evolutions/network/64-b44-32bit-stats/drivers_net_ethernet_broadcom_b44.patch b/patches/collateral-evolutions/network/64-b44-32bit-stats/drivers_net_ethernet_broadcom_b44.patch
deleted file mode 100644
index 7fb9718..0000000
--- a/patches/collateral-evolutions/network/64-b44-32bit-stats/drivers_net_ethernet_broadcom_b44.patch
+++ /dev/null
@@ -1,40 +0,0 @@
---- a/drivers/net/ethernet/broadcom/b44.c
-+++ b/drivers/net/ethernet/broadcom/b44.c
-@@ -31,6 +31,7 @@
- #include <linux/ssb/ssb.h>
- #include <linux/slab.h>
- #include <linux/phy.h>
-+#include <linux/u64_stats_sync.h>
- 
- #include <asm/uaccess.h>
- #include <asm/io.h>
-@@ -1677,10 +1678,17 @@ static int b44_close(struct net_device *
- 	return 0;
- }
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- static struct rtnl_link_stats64 *b44_get_stats64(struct net_device *dev,
- 					struct rtnl_link_stats64 *nstat)
-+#else
-+static struct net_device_stats *b44_get_stats(struct net_device *dev)
-+#endif
- {
- 	struct b44 *bp = netdev_priv(dev);
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36))
-+	struct net_device_stats *nstat = &dev->stats;
-+#endif
- 	struct b44_hw_stats *hwstat = &bp->hw_stats;
- 	unsigned int start;
- 
-@@ -2190,7 +2198,11 @@ static const struct net_device_ops b44_n
- 	.ndo_open		= b44_open,
- 	.ndo_stop		= b44_close,
- 	.ndo_start_xmit		= b44_start_xmit,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
- 	.ndo_get_stats64	= b44_get_stats64,
-+#else
-+	.ndo_get_stats		= b44_get_stats,
-+#endif
- 	.ndo_set_rx_mode	= b44_set_rx_mode,
- 	.ndo_set_mac_address	= b44_set_mac_addr,
- 	.ndo_validate_addr	= eth_validate_addr,
diff --git a/patches/collateral-evolutions/network/65-ignore-dismantle/INFO b/patches/collateral-evolutions/network/65-ignore-dismantle/INFO
deleted file mode 100644
index 6872df6..0000000
--- a/patches/collateral-evolutions/network/65-ignore-dismantle/INFO
+++ /dev/null
@@ -1,9 +0,0 @@
-The following patch makes use of the dismantle member in struct 
-net_device, this patch removes that access on older kernels.
-
-commit 9d5d496c3464b7ad0ba942b4ada5f27c07e07079
-Author: Daniel Drake <dsd@laptop.org>
-Date:   Mon Jul 30 22:58:04 2012 +0100
-
-    libertas: don't reset card on error when it is being removed
-
diff --git a/patches/collateral-evolutions/network/65-ignore-dismantle/drivers_net_wireless_libertas_main.patch b/patches/collateral-evolutions/network/65-ignore-dismantle/drivers_net_wireless_libertas_main.patch
deleted file mode 100644
index 6cd74c5..0000000
--- a/patches/collateral-evolutions/network/65-ignore-dismantle/drivers_net_wireless_libertas_main.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/net/wireless/libertas/main.c
-+++ b/drivers/net/wireless/libertas/main.c
-@@ -574,7 +574,11 @@ static int lbs_thread(void *data)
- 
- 			/* Reset card, but only when it isn't in the process
- 			 * of being shutdown anyway. */
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,0))
- 			if (!dev->dismantle && priv->reset_card)
-+#else
-+			if (priv->reset_card)
-+#endif
- 				priv->reset_card(priv);
- 		}
- 		priv->cmd_timed_out = 0;
diff --git a/patches/collateral-evolutions/network/67-fix-section-mismatch/drivers_net_wireless_ath_ath5k_led.patch b/patches/collateral-evolutions/network/67-fix-section-mismatch/drivers_net_wireless_ath_ath5k_led.patch
deleted file mode 100644
index 5b9583d..0000000
--- a/patches/collateral-evolutions/network/67-fix-section-mismatch/drivers_net_wireless_ath_ath5k_led.patch
+++ /dev/null
@@ -1,11 +0,0 @@
---- a/drivers/net/wireless/ath/ath5k/led.c
-+++ b/drivers/net/wireless/ath/ath5k/led.c
-@@ -53,7 +53,7 @@
- #define ATH_POLARITY(data) ((data) & 0xff)
- 
- /* Devices we match on for LED config info (typically laptops) */
--static DEFINE_PCI_DEVICE_TABLE(ath5k_led_devices) = {
-+static const struct pci_device_id ath5k_led_devices[] = {
- 	/* AR5211 */
- 	{ PCI_VDEVICE(ATHEROS, PCI_DEVICE_ID_ATHEROS_AR5211), ATH_LED(0, 0) },
- 	/* HP Compaq nc6xx, nc4000, nx6000 */
diff --git a/patches/collateral-evolutions/network/67-ipv6-dev-list/INFO b/patches/collateral-evolutions/network/67-ipv6-dev-list/INFO
deleted file mode 100644
index 6f9d619..0000000
--- a/patches/collateral-evolutions/network/67-ipv6-dev-list/INFO
+++ /dev/null
@@ -1,8 +0,0 @@
-This backports:
-
-commit 502a2ffd7376ae27cfde6172257db0ff9d8cfec2
-Author: stephen hemminger <shemminger@vyatta.com>
-Date:   Wed Mar 17 20:31:13 2010 +0000
-
-    ipv6: convert idev_list to list macros
-
diff --git a/patches/collateral-evolutions/network/67-ipv6-dev-list/drivers_net_wireless_iwlwifi_mvm_d3.patch b/patches/collateral-evolutions/network/67-ipv6-dev-list/drivers_net_wireless_iwlwifi_mvm_d3.patch
deleted file mode 100644
index d4bbf7b..0000000
--- a/patches/collateral-evolutions/network/67-ipv6-dev-list/drivers_net_wireless_iwlwifi_mvm_d3.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/net/wireless/iwlwifi/mvm/d3.c
-+++ b/drivers/net/wireless/iwlwifi/mvm/d3.c
-@@ -103,7 +103,11 @@ void iwl_mvm_ipv6_addr_change(struct iee
- 	int idx = 0;
- 
- 	read_lock_bh(&idev->lock);
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- 	list_for_each_entry(ifa, &idev->addr_list, if_list) {
-+#else
-+	for (ifa = idev->addr_list; ifa; ifa = ifa->if_next) {
-+#endif
- 		mvmvif->target_ipv6_addrs[idx] = ifa->addr;
- 		idx++;
- 		if (idx >= IWL_PROTO_OFFLOAD_NUM_IPV6_ADDRS_MAX)
diff --git a/patches/collateral-evolutions/network/69-wowlan-no-socket/INFO b/patches/collateral-evolutions/network/69-wowlan-no-socket/INFO
deleted file mode 100644
index 3fa37c2..0000000
--- a/patches/collateral-evolutions/network/69-wowlan-no-socket/INFO
+++ /dev/null
@@ -1,2 +0,0 @@
-__sock_create() is not available on kernel version < 2.6.37.
-
diff --git a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch b/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
deleted file mode 100644
index 1452a4b..0000000
--- a/patches/collateral-evolutions/network/69-wowlan-no-socket/net_wireless_nl80211.patch
+++ /dev/null
@@ -1,11 +0,0 @@
---- a/net/wireless/nl80211.c
-+++ b/net/wireless/nl80211.c
-@@ -8319,7 +8319,7 @@ static int nl80211_parse_wowlan_tcp(stru
- 		port = nla_get_u16(tb[NL80211_WOWLAN_TCP_SRC_PORT]);
- 	else
- 		port = 0;
--#ifdef CONFIG_INET
-+#if defined(CONFIG_INET) && (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
- 	/* allocate a socket and port for it and use it */
- 	err = __sock_create(wiphy_net(&rdev->wiphy), PF_INET, SOCK_STREAM,
- 			    IPPROTO_TCP, &cfg->sock, 1);
diff --git a/patches/collateral-evolutions/network/71-bin_attribute-api-change/drivers_net_wireless_ti_wlcore_main.patch b/patches/collateral-evolutions/network/71-bin_attribute-api-change/drivers_net_wireless_ti_wlcore_main.patch
deleted file mode 100644
index 919aafa..0000000
--- a/patches/collateral-evolutions/network/71-bin_attribute-api-change/drivers_net_wireless_ti_wlcore_main.patch
+++ /dev/null
@@ -1,14 +0,0 @@
---- a/drivers/net/wireless/ti/wlcore/sysfs.c
-+++ b/drivers/net/wireless/ti/wlcore/sysfs.c
-@@ -106,7 +106,11 @@ static ssize_t wl1271_sysfs_show_hw_pg_v
- static DEVICE_ATTR(hw_pg_ver, S_IRUGO,
- 		   wl1271_sysfs_show_hw_pg_ver, NULL);
- 
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,35))
- static ssize_t wl1271_sysfs_read_fwlog(struct file *filp, struct kobject *kobj,
-+#else
-+static ssize_t wl1271_sysfs_read_fwlog(struct kobject *kobj,
-+#endif
- 				       struct bin_attribute *bin_attr,
- 				       char *buffer, loff_t pos, size_t count)
- {
diff --git a/patches/collateral-evolutions/network/72-brcm80211-makefiles/INFO b/patches/collateral-evolutions/network/72-brcm80211-makefiles/INFO
deleted file mode 100644
index bdd5316..0000000
--- a/patches/collateral-evolutions/network/72-brcm80211-makefiles/INFO
+++ /dev/null
@@ -1,3 +0,0 @@
-Modify the brcm80211 Makefiles to allow our simple
-Makefile parser to understand them and not disable
-brcm80211 due to the weird variable indirection.
diff --git a/patches/collateral-evolutions/network/73-ath5k-tracing/INFO b/patches/collateral-evolutions/network/73-ath5k-tracing/INFO
deleted file mode 100644
index 038272b..0000000
--- a/patches/collateral-evolutions/network/73-ath5k-tracing/INFO
+++ /dev/null
@@ -1,11 +0,0 @@
-ath5k tracing uses
-
-#define TRACE_INCLUDE_PATH ../../drivers/net/wireless/ath/ath5k
-
-This is problematic because it means that if you build the
-backported modules against a full kernel tree the build
-uses the original trace.h, not the one from backport, and
-this fails (due to the config symbol mangling, but it's more
-generally an issue)
-
-Fix this by doing the same all other drivers do.
diff --git a/patches/collateral-evolutions/network/75-cw1200-workqueues/cw1200_workqueues.patch b/patches/collateral-evolutions/network/75-cw1200-workqueues/cw1200_workqueues.patch
deleted file mode 100644
index eee33dd..0000000
--- a/patches/collateral-evolutions/network/75-cw1200-workqueues/cw1200_workqueues.patch
+++ /dev/null
@@ -1,129 +0,0 @@
---- a/drivers/net/wireless/cw1200/bh.c
-+++ b/drivers/net/wireless/cw1200/bh.c
-@@ -48,16 +48,22 @@ enum cw1200_bh_pm_state {
- typedef int (*cw1200_wsm_handler)(struct cw1200_common *priv,
- 	u8 *data, size_t size);
- 
-+#ifndef CW1200_USE_COMPAT_KTHREAD
- static void cw1200_bh_work(struct work_struct *work)
- {
- 	struct cw1200_common *priv =
- 	container_of(work, struct cw1200_common, bh_work);
- 	cw1200_bh(priv);
- }
-+#endif
- 
- int cw1200_register_bh(struct cw1200_common *priv)
- {
- 	int err = 0;
-+#ifdef CW1200_USE_COMPAT_KTHREAD
-+	struct sched_param param = { .sched_priority = 1 };
-+	BUG_ON(priv->bh_thread);
-+#else
- 	/* Realtime workqueue */
- 	priv->bh_workqueue = alloc_workqueue("cw1200_bh",
- 				WQ_MEM_RECLAIM | WQ_HIGHPRI
-@@ -67,6 +73,7 @@ int cw1200_register_bh(struct cw1200_com
- 		return -ENOMEM;
- 
- 	INIT_WORK(&priv->bh_work, cw1200_bh_work);
-+#endif
- 
- 	pr_debug("[BH] register.\n");
- 
-@@ -81,20 +88,44 @@ int cw1200_register_bh(struct cw1200_com
- 	init_waitqueue_head(&priv->bh_wq);
- 	init_waitqueue_head(&priv->bh_evt_wq);
- 
-+#ifdef CW1200_USE_COMPAT_KTHREAD
-+	priv->bh_thread = kthread_create(&cw1200_bh, priv, "cw1200_bh");
-+	if (IS_ERR(priv->bh_thread)) {
-+		err = PTR_ERR(priv->bh_thread);
-+		priv->bh_thread = NULL;
-+	} else {
-+		WARN_ON(sched_setscheduler(priv->bh_thread,
-+					   SCHED_FIFO, &param));
-+		wake_up_process(priv->bh_thread);
-+	}
-+#else
- 	err = !queue_work(priv->bh_workqueue, &priv->bh_work);
- 	WARN_ON(err);
-+#endif
-+
- 	return err;
- }
- 
- void cw1200_unregister_bh(struct cw1200_common *priv)
- {
-+#ifdef CW1200_USE_COMPAT_KTHREAD
-+	struct task_struct *thread = priv->bh_thread;
-+	if (WARN_ON(!thread))
-+		return;
-+#endif
-+
- 	atomic_add(1, &priv->bh_term);
- 	wake_up(&priv->bh_wq);
- 
-+#ifdef CW1200_USE_COMPAT_KTHREAD
-+	kthread_stop(thread);
-+	priv->bh_thread = NULL;
-+#else
- 	flush_workqueue(priv->bh_workqueue);
- 
- 	destroy_workqueue(priv->bh_workqueue);
- 	priv->bh_workqueue = NULL;
-+#endif
- 
- 	pr_debug("[BH] unregistered.\n");
- }
-@@ -614,6 +645,16 @@ static int cw1200_bh(void *arg)
- 		pr_err("[BH] Fatal error, exiting.\n");
- 		priv->bh_error = 1;
- 		/* TODO: schedule_work(recovery) */
-+#ifdef CW1200_USE_COMPAT_KTHREAD
-+		for (;;) {
-+			int status = wait_event_interruptible(priv->bh_wq, ({
-+				term = atomic_xchg(&priv->bh_term, 0);
-+				(term);
-+			}));
-+		if (status || term)
-+			break;
-+	}
-+#endif
- 	}
- 	return 0;
- }
---- a/drivers/net/wireless/cw1200/cw1200.h
-+++ b/drivers/net/wireless/cw1200/cw1200.h
-@@ -23,12 +23,18 @@
- #include <linux/workqueue.h>
- #include <net/mac80211.h>
- 
-+#include <linux/version.h>
-+
- #include "queue.h"
- #include "wsm.h"
- #include "scan.h"
- #include "txrx.h"
- #include "pm.h"
- 
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 36))
-+#define CW1200_USE_COMPAT_KTHREAD
-+#endif
-+
- /* Forward declarations */
- struct hwbus_ops;
- struct task_struct;
-@@ -190,8 +196,12 @@ struct cw1200_common {
- 	atomic_t			bh_term;
- 	atomic_t			bh_suspend;
- 
-+#ifdef CW1200_USE_COMPAT_KTHREAD
-+	struct task_struct              *bh_thread;
-+#else
- 	struct workqueue_struct         *bh_workqueue;
- 	struct work_struct              bh_work;
-+#endif
- 
- 	int				bh_error;
- 	wait_queue_head_t		bh_wq;
diff --git a/patches/collateral-evolutions/network/81-genl-const/INFO b/patches/collateral-evolutions/network/81-genl-const/INFO
deleted file mode 100644
index 242f9f8..0000000
--- a/patches/collateral-evolutions/network/81-genl-const/INFO
+++ /dev/null
@@ -1,3 +0,0 @@
-Newer kernels make generic netlink ops and multicast groups
-const, but older can't have that. We therefore introduce
-__genl_const, which can be defined depending on the kernel.
diff --git a/patches/collateral-evolutions/network/82-struct_property_missing/INFO b/patches/collateral-evolutions/network/82-struct_property_missing/INFO
deleted file mode 100644
index b3e0ced..0000000
--- a/patches/collateral-evolutions/network/82-struct_property_missing/INFO
+++ /dev/null
@@ -1,4 +0,0 @@
-struct property is missing in the general header files in older kernel 
-versions. There are different versions of this header depending on the 
-architecture code in use. This removed the access to any members of 
-struct property
diff --git a/patches/collateral-evolutions/network/82-struct_property_missing/mwifiex.patch b/patches/collateral-evolutions/network/82-struct_property_missing/mwifiex.patch
deleted file mode 100644
index 3c06e43..0000000
--- a/patches/collateral-evolutions/network/82-struct_property_missing/mwifiex.patch
+++ /dev/null
@@ -1,32 +0,0 @@
---- a/drivers/net/wireless/mwifiex/sta_cmd.c
-+++ b/drivers/net/wireless/mwifiex/sta_cmd.c
-@@ -25,6 +25,7 @@
- #include "wmm.h"
- #include "11n.h"
- #include "11ac.h"
-+#include <linux/of.h>
- 
- /*
-  * This function prepares command to set/get RSSI information.
-@@ -1444,9 +1445,10 @@ static int mwifiex_cmd_cfg_data(struct m
- 	struct property *prop = data_buf;
- 	u32 len;
- 	u8 *data = (u8 *)cmd + S_DS_GEN;
--	int ret;
- 
- 	if (prop) {
-+#if defined(CONFIG_OF) || (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,39))
-+		int ret;
- 		len = prop->length;
- 		ret = of_property_read_u8_array(adapter->dt_node, prop->name,
- 						data, len);
-@@ -1454,6 +1456,9 @@ static int mwifiex_cmd_cfg_data(struct m
- 			return ret;
- 		dev_dbg(adapter->dev,
- 			"download cfg_data from device tree: %s\n", prop->name);
-+#else
-+		return -1;
-+#endif
- 	} else if (adapter->cal_data->data && adapter->cal_data->size > 0) {
- 		len = mwifiex_parse_cal_cfg((u8 *)adapter->cal_data->data,
- 					    adapter->cal_data->size, data);
diff --git a/patches/collateral-evolutions/network/84-ethernet/0001-igb_net_device_ops.patch b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0001-igb_net_device_ops.patch
similarity index 100%
rename from patches/collateral-evolutions/network/84-ethernet/0001-igb_net_device_ops.patch
rename to patches/the-way-not-to-do-backports/0001-ethernet-igb/0001-igb_net_device_ops.patch
diff --git a/patches/collateral-evolutions/network/84-ethernet/0002-igb_pci_sriov_configure.patch b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0002-igb_pci_sriov_configure.patch
similarity index 100%
rename from patches/collateral-evolutions/network/84-ethernet/0002-igb_pci_sriov_configure.patch
rename to patches/the-way-not-to-do-backports/0001-ethernet-igb/0002-igb_pci_sriov_configure.patch
diff --git a/patches/collateral-evolutions/network/84-ethernet/0004-igb_err_handler.patch b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0004-igb_err_handler.patch
similarity index 100%
rename from patches/collateral-evolutions/network/84-ethernet/0004-igb_err_handler.patch
rename to patches/the-way-not-to-do-backports/0001-ethernet-igb/0004-igb_err_handler.patch
diff --git a/patches/collateral-evolutions/network/84-ethernet/0005-igb_mdi.patch b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0005-igb_mdi.patch
similarity index 100%
rename from patches/collateral-evolutions/network/84-ethernet/0005-igb_mdi.patch
rename to patches/the-way-not-to-do-backports/0001-ethernet-igb/0005-igb_mdi.patch
diff --git a/patches/collateral-evolutions/network/84-ethernet/0006-igb_eee.patch b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0006-igb_eee.patch
similarity index 100%
rename from patches/collateral-evolutions/network/84-ethernet/0006-igb_eee.patch
rename to patches/the-way-not-to-do-backports/0001-ethernet-igb/0006-igb_eee.patch
diff --git a/patches/collateral-evolutions/network/84-ethernet/0007-igb_ethtool_ops.patch b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0007-igb_ethtool_ops.patch
similarity index 100%
rename from patches/collateral-evolutions/network/84-ethernet/0007-igb_ethtool_ops.patch
rename to patches/the-way-not-to-do-backports/0001-ethernet-igb/0007-igb_ethtool_ops.patch
diff --git a/patches/collateral-evolutions/network/84-ethernet/0008-igb_no_fcs.patch b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0008-igb_no_fcs.patch
similarity index 100%
rename from patches/collateral-evolutions/network/84-ethernet/0008-igb_no_fcs.patch
rename to patches/the-way-not-to-do-backports/0001-ethernet-igb/0008-igb_no_fcs.patch
diff --git a/patches/collateral-evolutions/network/84-ethernet/0009-igb_vlan_rx_vid.patch b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0009-igb_vlan_rx_vid.patch
similarity index 100%
rename from patches/collateral-evolutions/network/84-ethernet/0009-igb_vlan_rx_vid.patch
rename to patches/the-way-not-to-do-backports/0001-ethernet-igb/0009-igb_vlan_rx_vid.patch
diff --git a/patches/collateral-evolutions/network/84-ethernet/0010-igb_ethtool_ops.patch b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0010-igb_ethtool_ops.patch
similarity index 100%
rename from patches/collateral-evolutions/network/84-ethernet/0010-igb_ethtool_ops.patch
rename to patches/the-way-not-to-do-backports/0001-ethernet-igb/0010-igb_ethtool_ops.patch
diff --git a/patches/collateral-evolutions/network/84-ethernet/0011-igb_ethtool_ops.patch b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0011-igb_ethtool_ops.patch
similarity index 100%
rename from patches/collateral-evolutions/network/84-ethernet/0011-igb_ethtool_ops.patch
rename to patches/the-way-not-to-do-backports/0001-ethernet-igb/0011-igb_ethtool_ops.patch
diff --git a/patches/collateral-evolutions/network/84-ethernet/0012-igb_ndo_set_vf_spoofchk.patch b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0012-igb_ndo_set_vf_spoofchk.patch
similarity index 100%
rename from patches/collateral-evolutions/network/84-ethernet/0012-igb_ndo_set_vf_spoofchk.patch
rename to patches/the-way-not-to-do-backports/0001-ethernet-igb/0012-igb_ndo_set_vf_spoofchk.patch
diff --git a/patches/collateral-evolutions/network/84-ethernet/0013-igb_hwmon.patch b/patches/the-way-not-to-do-backports/0001-ethernet-igb/0013-igb_hwmon.patch
similarity index 100%
rename from patches/collateral-evolutions/network/84-ethernet/0013-igb_hwmon.patch
rename to patches/the-way-not-to-do-backports/0001-ethernet-igb/0013-igb_hwmon.patch
diff --git a/patches/the-way-not-to-do-backports/0001-ethernet-igb/INFO b/patches/the-way-not-to-do-backports/0001-ethernet-igb/INFO
new file mode 100644
index 0000000..0b91989
--- /dev/null
+++ b/patches/the-way-not-to-do-backports/0001-ethernet-igb/INFO
@@ -0,0 +1,10 @@
+This series needs work, each atomic patch backport requirements needs to be
+split out atomically into either an existing matching series under
+
+patches/collateral-evolutions/network/
+patches/collateral-evolutions/generic/
+
+Or a new series for either of them needs to be created, each change must
+document the original patch that introduced the change that incurred the
+backport being peformed, and the respective kernel in which it was introduced
+which can be obtained by 'git describe --contains sha1sum'.
-- 
1.9.1

