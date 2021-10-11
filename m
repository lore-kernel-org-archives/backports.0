Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93813C433EF
	for <backports@archiver.kernel.org>; Mon, 11 Oct 2021 22:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7029760EB4
	for <backports@archiver.kernel.org>; Mon, 11 Oct 2021 22:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbhJKWZD (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 11 Oct 2021 18:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbhJKWY6 (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 11 Oct 2021 18:24:58 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A17C06161C
        for <backports@vger.kernel.org>; Mon, 11 Oct 2021 15:22:57 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4HStbL5t7zzQl0t;
        Tue, 12 Oct 2021 00:22:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1633990972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/Hnc6nVBZXJjdj4EFrDg5sLGBqQtjVBhsIYuOqBgQhY=;
        b=CeN197bEkjk8BGCa8gqAbjqMWRDkZAsC4PFHg9/uL1hB9Y2kMl6TlPMbBLBmnq1IZEMwZI
        k1EBPjkA7dLiBvJoxvOa3hJBsFiHpnfrMXKaxv5122p3Qy2UvhvIalARbWYKmr6qq8Jcd1
        CkuI7TFGooEg7sd6+S7pXDZ7K7uC5HVZU+1ZIrUlL1zL1F8jC6JTPuaep4ZR2GDOPHH4C9
        FmSIj8zX22KTt/u4WgZBGqaUV6oDK3jdWliVDOMI0J2SB2ttVFM8Od5casw+P1UN7+3PFA
        XuBJSfMk18fT9AfYBXn1s64WvnS2yKk33N/V4SjJw7EpBsuBiSjuWgkvm0fcLQ==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes.berg@intel.com, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/14] backports: Remove support for kernel < 4.4
Date:   Tue, 12 Oct 2021 00:22:13 +0200
Message-Id: <20211011222227.1189850-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A9DED18BC
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This removes the code needed to support kernel < 4.4.
Supporting these old kernels costs extra effort and I do not want to 
spend this effort. I didn't runtime tested backprots on these kernels 
for a long time anyway and it also showed some compile problems lately.

This also fixes some problems seen with python3.

Backports based on kernel 5.15 is on its way.
This code is also available here till it gets merged:
https://github.com/hauke/backports/tree/backports-cleanup2


Hauke Mehrtens (14):
  backports: Add support deb with zstd compression
  backports: cmake: Fixes for python3
  backprots: Add *.mod to .gitignore
  backports: Remove 3.X kernel headers
  backports: Remove 3.X kernel patches
  backports: dependencies: Remove dependencies to kernel 3.X
  backports: Remove led subsystem backport
  backports: Remove MII subsystem backport
  backports: Remove coredump subsystem backport
  backports: Remove support for kernel smaller than 4.0
  backports: Remove support for kernel smaller than 4.1
  backports: Remove support for kernel smaller than 4.2
  backports: Remove support for kernel smaller than 4.3
  backports: Remove support for kernel smaller than 4.4

 README                                        |   2 +-
 backport/.gitignore                           |   1 +
 backport/backport-include/acpi/acpi_bus.h     |   4 +-
 .../asm-generic/pci-dma-compat.h              |  17 -
 backport/backport-include/asm/atomic.h        |  19 -
 backport/backport-include/asm/barrier.h       |   3 -
 .../backport-include/backport/leds-disabled.h | 198 --------
 backport/backport-include/crypto/aead.h       |  33 --
 backport/backport-include/crypto/algapi.h     |  16 -
 backport/backport-include/linux/acpi.h        |  61 +--
 .../backport-include/linux/bcm47xx_nvram.h    |  25 -
 backport/backport-include/linux/clk.h         | 116 -----
 backport/backport-include/linux/compat.h      |  21 -
 .../backport-include/linux/compiler-gcc5.h    |   1 -
 .../backport-include/linux/compiler-gcc6.h    |   1 -
 .../backport-include/linux/compiler-gcc7.h    |   1 -
 .../backport-include/linux/compiler-gcc8.h    |   1 -
 .../backport-include/linux/compiler-gcc9.h    |   1 -
 .../backport-include/linux/compiler-gccN.h    | 126 -----
 backport/backport-include/linux/completion.h  |  21 -
 backport/backport-include/linux/cordic.h      |  54 ---
 backport/backport-include/linux/crc7.h        |  14 -
 backport/backport-include/linux/debugfs.h     |  49 --
 .../linux/{bp-devcoredump.h => devcoredump.h} |  12 +-
 backport/backport-include/linux/device.h      | 280 -----------
 backport/backport-include/linux/dma-buf.h     |  54 ---
 backport/backport-include/linux/dma-mapping.h |  35 --
 .../backport-include/linux/dynamic_debug.h    |  36 --
 backport/backport-include/linux/err.h         |  10 -
 backport/backport-include/linux/etherdevice.h | 189 --------
 backport/backport-include/linux/export.h      |  19 -
 backport/backport-include/linux/firmware.h    |   3 -
 backport/backport-include/linux/fs.h          |  44 +-
 .../backport-include/linux/ftrace_event.h     |  10 -
 backport/backport-include/linux/gfp.h         |   4 +-
 backport/backport-include/linux/gpio.h        |  35 --
 backport/backport-include/linux/gpio/driver.h |   8 +-
 backport/backport-include/linux/hashtable.h   |  42 --
 backport/backport-include/linux/hid.h         |  87 ----
 backport/backport-include/linux/hwmon.h       |  34 --
 backport/backport-include/linux/i2c-mux.h     |  14 -
 backport/backport-include/linux/idr.h         |  59 +--
 backport/backport-include/linux/if_vlan.h     |  43 --
 backport/backport-include/linux/iopoll.h      |   2 -
 backport/backport-include/linux/irq.h         |  16 -
 backport/backport-include/linux/irqdomain.h   |   9 -
 backport/backport-include/linux/jiffies.h     |  30 --
 backport/backport-include/linux/kconfig.h     |  28 --
 backport/backport-include/linux/kernel.h      | 191 +-------
 backport/backport-include/linux/kfifo.h       |  51 --
 backport/backport-include/linux/ktime.h       |  18 -
 backport/backport-include/linux/leds.h        |  44 +-
 backport/backport-include/linux/list.h        |  91 ----
 backport/backport-include/linux/lockdep.h     |  15 -
 backport/backport-include/linux/math64.h      |  27 --
 backport/backport-include/linux/mdio.h        |  87 ----
 backport/backport-include/linux/mei_cl_bus.h  |  25 -
 backport/backport-include/linux/mii.h         | 140 ------
 backport/backport-include/linux/mm.h          |   5 -
 backport/backport-include/linux/mmc/host.h    |  16 -
 .../backport-include/linux/mmc/sdio_func.h    |  12 -
 backport/backport-include/linux/module.h      |   5 -
 backport/backport-include/linux/moduleparam.h |  34 --
 backport/backport-include/linux/net.h         |  98 ----
 .../backport-include/linux/netdev_features.h  |  41 --
 backport/backport-include/linux/netdevice.h   | 296 ------------
 backport/backport-include/linux/netlink.h     |   8 -
 backport/backport-include/linux/nl80211.h     |  10 -
 backport/backport-include/linux/of.h          | 259 ----------
 backport/backport-include/linux/of_address.h  |  18 -
 backport/backport-include/linux/of_device.h   |   4 +-
 backport/backport-include/linux/of_irq.h      |  15 -
 backport/backport-include/linux/of_net.h      |   9 -
 backport/backport-include/linux/of_platform.h |  38 --
 backport/backport-include/linux/olpc-ec.h     |  10 -
 backport/backport-include/linux/pci.h         | 181 +------
 backport/backport-include/linux/percpu.h      |  19 -
 backport/backport-include/linux/phy.h         |  10 -
 backport/backport-include/linux/pm_qos.h      |   9 -
 backport/backport-include/linux/pm_runtime.h  |  40 --
 backport/backport-include/linux/poll.h        |  18 +-
 backport/backport-include/linux/printk.h      | 154 ------
 backport/backport-include/linux/proc_fs.h     |  29 --
 backport/backport-include/linux/property.h    |  15 -
 .../backport-include/linux/ptp_clock_kernel.h |  40 --
 backport/backport-include/linux/random.h      |  38 --
 backport/backport-include/linux/rculist.h     |  53 --
 backport/backport-include/linux/regmap.h      |  51 --
 backport/backport-include/linux/rfkill.h      | 167 -------
 backport/backport-include/linux/rtnetlink.h   |  29 --
 backport/backport-include/linux/scatterlist.h | 100 ----
 backport/backport-include/linux/security.h    |  18 -
 backport/backport-include/linux/seq_file.h    |  44 --
 backport/backport-include/linux/skbuff.h      | 325 -------------
 backport/backport-include/linux/slab.h        |  21 -
 backport/backport-include/linux/spi/spi.h     |  69 ---
 backport/backport-include/linux/spinlock.h    |  14 -
 backport/backport-include/linux/static_key.h  |  49 --
 backport/backport-include/linux/string.h      |  25 -
 backport/backport-include/linux/thermal.h     | 110 -----
 backport/backport-include/linux/time64.h      |  46 --
 backport/backport-include/linux/timecounter.h |  25 -
 backport/backport-include/linux/timekeeping.h |  77 +--
 backport/backport-include/linux/tracepoint.h  | 142 ------
 backport/backport-include/linux/tty.h         |  27 --
 backport/backport-include/linux/tty_flip.h    |  11 -
 backport/backport-include/linux/types.h       |   4 -
 .../backport-include/linux/u64_stats_sync.h   | 146 ------
 backport/backport-include/linux/uidgid.h      | 221 ---------
 backport/backport-include/linux/usb.h         |  95 ----
 backport/backport-include/linux/usb/ch9.h     |  16 -
 backport/backport-include/linux/wait.h        |  73 ---
 backport/backport-include/linux/watchdog.h    |  11 -
 backport/backport-include/linux/workqueue.h   |  67 ---
 backport/backport-include/net/addrconf.h      |  26 +-
 backport/backport-include/net/flow_keys.h     |  21 -
 backport/backport-include/net/genetlink.h     |  53 +-
 backport/backport-include/net/ip.h            |  14 -
 backport/backport-include/net/ip6_fib.h       |  26 -
 backport/backport-include/net/ipv6.h          |  35 --
 backport/backport-include/net/iw_handler.h    |  31 +-
 backport/backport-include/net/net_namespace.h |  44 --
 backport/backport-include/net/netlink.h       | 173 -------
 backport/backport-include/net/sch_generic.h   |  20 -
 backport/backport-include/net/sock.h          |  43 --
 backport/backport-include/net/tso.h           |  33 --
 .../{ => uapi}/linux/eventpoll.h              |   2 +-
 .../backport-include/uapi/linux/genetlink.h   |   5 -
 .../backport-include/uapi/linux/sockios.h     |  31 --
 backport/compat/Kconfig                       |  43 --
 backport/compat/Makefile                      |  24 -
 backport/compat/backport-3.10.c               | 237 ---------
 backport/compat/backport-3.11.c               | 124 -----
 backport/compat/backport-3.12.c               |  72 ---
 backport/compat/backport-3.13.c               | 169 -------
 backport/compat/backport-3.14.c               |  90 ----
 backport/compat/backport-3.15.c               |  88 ----
 backport/compat/backport-3.17.c               | 166 -------
 backport/compat/backport-3.18.c               | 332 -------------
 backport/compat/backport-3.19.c               | 165 -------
 backport/compat/backport-3.2.c                |  25 -
 backport/compat/backport-4.0.c                | 199 --------
 backport/compat/backport-4.1.c                |  84 ----
 backport/compat/backport-4.10.c               |   2 -
 backport/compat/backport-4.18.c               |  34 --
 backport/compat/backport-4.2.c                |  76 ---
 backport/compat/backport-4.3.c                | 304 ------------
 backport/compat/backport-4.4.c                | 160 ------
 backport/compat/backport-4.5.c                |   9 -
 backport/compat/backport-4.7.c                |  12 +-
 backport/compat/backport-5.3.c                |   2 -
 backport/compat/backport-genetlink.c          |  36 +-
 backport/compat/backports.h                   |  16 -
 backport/compat/compat-3.0.c                  |  91 ----
 backport/compat/compat-3.1.c                  | 118 -----
 backport/compat/compat-3.3.c                  | 226 ---------
 backport/compat/compat-3.4.c                  | 201 --------
 backport/compat/compat-3.5.c                  | 167 -------
 backport/compat/compat-3.6.c                  |  27 --
 backport/compat/compat-3.7.c                  | 290 -----------
 backport/compat/compat-3.8.c                  | 455 ------------------
 backport/compat/compat-3.9.c                  | 226 ---------
 backport/compat/main.c                        |  11 -
 backport/compat/user_namespace.c              |  68 ---
 dependencies                                  |  69 ---
 devel/backports-update-manager                |  11 +-
 devel/ckmake                                  |   7 +-
 .../0005-uapi-compromise/mwifiex.patch        |  22 -
 .../0001-group_attr_class.cocci               |  80 ---
 .../0001-group-attr/0002-group_attr_bus.cocci |  78 ---
 .../0001-group-attr/0003-class_groups.cocci   |  54 ---
 patches/0001-group-attr/INFO                  |  40 --
 patches/0001-netlink-portid.cocci             |  17 -
 ...2-disable-dump-adjust-on-old-kernels.patch |  46 --
 patches/0012-driver-quirks/INFO               |   2 -
 .../drivers_net_wireless_cw1200_sdio.patch    |  15 -
 .../0013-fix-makefile-includes/ath10k.patch   |  10 -
 .../net_wireless_nl80211.patch                |  12 -
 ...drivers_net_wireless_ipw2x00_ipw2100.patch |  14 -
 patches/0016-libertas-olpc-ec-wakeup/INFO     |   5 -
 ...drivers_net_wireless_libertas_if_usb.patch |  18 -
 patches/0017-get_ts_info/INFO                 |  27 --
 patches/0017-get_ts_info/get_ts_info.cocci    |  19 -
 patches/0019-usb_driver_lpm.cocci             |   9 -
 patches/0020-tty-termios/INFO                 |  23 -
 patches/0021-umode_t-api-change/ath10k.patch  |  14 -
 patches/0021-umode_t-api-change/ath9k.patch   |  14 -
 patches/0022-define-tracing/INFO              |   9 -
 patches/0022-define-tracing/ath6kl.patch      |  12 -
 patches/0022-define-tracing/cfg80211.patch    |  10 -
 patches/0022-define-tracing/mt7601u.patch     |  12 -
 patches/0022-define-tracing/wil6210.patch     |  12 -
 patches/0024-led-blink-api/INFO               |  13 -
 patches/0024-led-blink-api/mac80211.patch     |  51 --
 patches/0025-usb-sg/INFO                      |  17 -
 patches/0025-usb-sg/usbnet.patch              |  73 ---
 patches/0026-ipv6_stub/INFO                   |  12 -
 patches/0026-ipv6_stub/cdc_mbim.patch         |  29 --
 patches/0027-genl-const/INFO                  |  15 -
 patches/0027-genl-const/genl-const.cocci      |  10 -
 patches/0028-select_queue/mac80211.patch      |  24 +-
 patches/0028-select_queue/mwifiex.patch       |  12 +-
 .../0029-struct_hid_ll_driver-extensions/INFO |  16 -
 patches/0030-qdisc_tx_busylock/INFO           |  22 -
 patches/0031-sk_data_ready.cocci              | 119 -----
 patches/0032-sriov_configure/INFO             |  13 -
 .../sriov_configure.cocci                     |  19 -
 patches/0033-ndo_vlan_rx_vid/INFO             |  23 -
 patches/0033-ndo_vlan_rx_vid/cdc_mbim.patch   |  48 --
 patches/0034-ndo_set_vf_spoofchk/INFO         |  12 -
 .../set_vf_spoofchk.cocci                     |  41 --
 patches/0035-skb_no_fcs/INFO                  |  12 -
 patches/0035-skb_no_fcs/skb_no_fcs.cocci      |   7 -
 patches/0036-ethtool_eee/INFO                 |  12 -
 patches/0036-ethtool_eee/ethtool_eee.cocci    |  37 --
 patches/0037-ethtool_get_module/INFO          |  14 -
 .../0037-ethtool_get_module/get_module.cocci  |  37 --
 patches/0038-ethtool_rxfh_indir/INFO          |  13 -
 patches/0039-ethtool_rxnfc/INFO               |  14 -
 patches/0039-ethtool_rxnfc/rxnfc.cocci        |  22 -
 patches/0040-ethtool_cmd_mdix/INFO            |  13 -
 .../ethtool_cmd_mdix.cocci                    |  14 -
 patches/0042-pci_error_handlers/INFO          |  12 -
 .../igb_pci_error_handlers.cocci              |   9 -
 patches/0043-ndo_set_vf_rate/INFO             |  17 -
 .../0043-ndo_set_vf_rate/set_vf_rate.cocci    |  50 --
 .../0049-no-pfmemalloc/no-pfmemalloc.cocci    |   9 -
 patches/0051-no-wakeup_path/ssb.patch         |  12 -
 patches/0052-deactivate-ptp-pin/INFO          |  20 -
 patches/0053-possible_net_t.patch             |  19 -
 patches/0054-struct-proto_ops-sig.cocci       | 177 -------
 patches/0055-name_assign_type/brcmfmac.patch  |  12 -
 patches/0055-netdev-tstats.cocci              |  11 -
 patches/0056-ndo_features_check/INFO          |  12 -
 .../features_check.cocci                      |  19 -
 patches/0058-ptp_getsettime64/INFO            |  11 -
 .../ptp_getsettime64.cocci                    |  33 --
 patches/0059-skb_xmit_more/INFO               |  10 -
 patches/0059-uuid-in-mei/INFO                 |   7 -
 patches/0060-trace_field_struct/INFO          |  11 -
 patches/0060-trace_field_struct/mt7601u.patch |  33 --
 patches/0061-termios_rwsem/INFO               |  11 -
 patches/0062-iff-no-queue.cocci               |   9 -
 patches/0065-ndisc_send_na-argument.cocci     |   9 -
 patches/0069-iwlwifi-pd-string-fix.patch      |  75 ---
 patches/0069-remove-of_irq/bcma.patch         |  24 -
 patches/0070-mac80211-fils.patch              |  54 ---
 patches/0071-skb-head_frag/wireless.patch     |  14 -
 patches/0074-skb-wifi-acked.cocci             |   8 -
 patches/0076-reset-notify.cocci               |  19 -
 patches/0077-genl-ro-after-init/nl80211.patch |   2 +-
 patches/0085-iwlwifi-pci-device-removal.patch |  22 -
 patches/0100-revert-small_ops/mac80211.patch  |   4 +-
 patches/devcoredump.patch                     | 126 -----
 254 files changed, 62 insertions(+), 13174 deletions(-)
 delete mode 100644 backport/backport-include/asm-generic/pci-dma-compat.h
 delete mode 100644 backport/backport-include/asm/atomic.h
 delete mode 100644 backport/backport-include/backport/leds-disabled.h
 delete mode 100644 backport/backport-include/crypto/aead.h
 delete mode 100644 backport/backport-include/crypto/algapi.h
 delete mode 100644 backport/backport-include/linux/bcm47xx_nvram.h
 delete mode 100644 backport/backport-include/linux/clk.h
 delete mode 100644 backport/backport-include/linux/compat.h
 delete mode 100644 backport/backport-include/linux/compiler-gcc5.h
 delete mode 100644 backport/backport-include/linux/compiler-gcc6.h
 delete mode 100644 backport/backport-include/linux/compiler-gcc7.h
 delete mode 100644 backport/backport-include/linux/compiler-gcc8.h
 delete mode 100644 backport/backport-include/linux/compiler-gcc9.h
 delete mode 100644 backport/backport-include/linux/compiler-gccN.h
 delete mode 100644 backport/backport-include/linux/completion.h
 delete mode 100644 backport/backport-include/linux/crc7.h
 rename backport/backport-include/linux/{bp-devcoredump.h => devcoredump.h} (75%)
 delete mode 100644 backport/backport-include/linux/device.h
 delete mode 100644 backport/backport-include/linux/dma-buf.h
 delete mode 100644 backport/backport-include/linux/dma-mapping.h
 delete mode 100644 backport/backport-include/linux/dynamic_debug.h
 delete mode 100644 backport/backport-include/linux/err.h
 delete mode 100644 backport/backport-include/linux/export.h
 delete mode 100644 backport/backport-include/linux/ftrace_event.h
 delete mode 100644 backport/backport-include/linux/gpio.h
 delete mode 100644 backport/backport-include/linux/hashtable.h
 delete mode 100644 backport/backport-include/linux/hid.h
 delete mode 100644 backport/backport-include/linux/hwmon.h
 delete mode 100644 backport/backport-include/linux/i2c-mux.h
 delete mode 100644 backport/backport-include/linux/if_vlan.h
 delete mode 100644 backport/backport-include/linux/irq.h
 delete mode 100644 backport/backport-include/linux/irqdomain.h
 delete mode 100644 backport/backport-include/linux/jiffies.h
 delete mode 100644 backport/backport-include/linux/kfifo.h
 delete mode 100644 backport/backport-include/linux/ktime.h
 delete mode 100644 backport/backport-include/linux/list.h
 delete mode 100644 backport/backport-include/linux/math64.h
 delete mode 100644 backport/backport-include/linux/mdio.h
 delete mode 100644 backport/backport-include/linux/mei_cl_bus.h
 delete mode 100644 backport/backport-include/linux/mmc/host.h
 delete mode 100644 backport/backport-include/linux/nl80211.h
 delete mode 100644 backport/backport-include/linux/of.h
 delete mode 100644 backport/backport-include/linux/of_address.h
 delete mode 100644 backport/backport-include/linux/of_irq.h
 delete mode 100644 backport/backport-include/linux/of_platform.h
 delete mode 100644 backport/backport-include/linux/olpc-ec.h
 delete mode 100644 backport/backport-include/linux/percpu.h
 delete mode 100644 backport/backport-include/linux/pm_runtime.h
 delete mode 100644 backport/backport-include/linux/printk.h
 delete mode 100644 backport/backport-include/linux/proc_fs.h
 delete mode 100644 backport/backport-include/linux/property.h
 delete mode 100644 backport/backport-include/linux/ptp_clock_kernel.h
 delete mode 100644 backport/backport-include/linux/regmap.h
 delete mode 100644 backport/backport-include/linux/rfkill.h
 delete mode 100644 backport/backport-include/linux/rtnetlink.h
 delete mode 100644 backport/backport-include/linux/security.h
 delete mode 100644 backport/backport-include/linux/spi/spi.h
 delete mode 100644 backport/backport-include/linux/static_key.h
 delete mode 100644 backport/backport-include/linux/time64.h
 delete mode 100644 backport/backport-include/linux/timecounter.h
 delete mode 100644 backport/backport-include/linux/tracepoint.h
 delete mode 100644 backport/backport-include/linux/tty_flip.h
 delete mode 100644 backport/backport-include/linux/uidgid.h
 delete mode 100644 backport/backport-include/linux/usb.h
 delete mode 100644 backport/backport-include/linux/watchdog.h
 delete mode 100644 backport/backport-include/linux/workqueue.h
 delete mode 100644 backport/backport-include/net/flow_keys.h
 delete mode 100644 backport/backport-include/net/ip.h
 delete mode 100644 backport/backport-include/net/ip6_fib.h
 delete mode 100644 backport/backport-include/net/net_namespace.h
 delete mode 100644 backport/backport-include/net/sch_generic.h
 delete mode 100644 backport/backport-include/net/tso.h
 rename backport/backport-include/{ => uapi}/linux/eventpoll.h (94%)
 delete mode 100644 backport/backport-include/uapi/linux/sockios.h
 delete mode 100644 backport/compat/backport-3.10.c
 delete mode 100644 backport/compat/backport-3.11.c
 delete mode 100644 backport/compat/backport-3.12.c
 delete mode 100644 backport/compat/backport-3.13.c
 delete mode 100644 backport/compat/backport-3.14.c
 delete mode 100644 backport/compat/backport-3.15.c
 delete mode 100644 backport/compat/backport-3.17.c
 delete mode 100644 backport/compat/backport-3.18.c
 delete mode 100644 backport/compat/backport-3.19.c
 delete mode 100644 backport/compat/backport-3.2.c
 delete mode 100644 backport/compat/backport-4.0.c
 delete mode 100644 backport/compat/backport-4.1.c
 delete mode 100644 backport/compat/backport-4.2.c
 delete mode 100644 backport/compat/backport-4.3.c
 delete mode 100644 backport/compat/backport-4.4.c
 delete mode 100644 backport/compat/backports.h
 delete mode 100644 backport/compat/compat-3.0.c
 delete mode 100644 backport/compat/compat-3.1.c
 delete mode 100644 backport/compat/compat-3.3.c
 delete mode 100644 backport/compat/compat-3.4.c
 delete mode 100644 backport/compat/compat-3.5.c
 delete mode 100644 backport/compat/compat-3.6.c
 delete mode 100644 backport/compat/compat-3.7.c
 delete mode 100644 backport/compat/compat-3.8.c
 delete mode 100644 backport/compat/compat-3.9.c
 delete mode 100644 backport/compat/user_namespace.c
 delete mode 100644 patches/0000-upstream-backport-changes/0005-uapi-compromise/mwifiex.patch
 delete mode 100644 patches/0001-group-attr/0001-group_attr_class.cocci
 delete mode 100644 patches/0001-group-attr/0002-group_attr_bus.cocci
 delete mode 100644 patches/0001-group-attr/0003-class_groups.cocci
 delete mode 100644 patches/0001-group-attr/INFO
 delete mode 100644 patches/0001-netlink-portid.cocci
 delete mode 100644 patches/0002-disable-dump-adjust-on-old-kernels.patch
 delete mode 100644 patches/0012-driver-quirks/INFO
 delete mode 100644 patches/0012-driver-quirks/drivers_net_wireless_cw1200_sdio.patch
 delete mode 100644 patches/0013-fix-makefile-includes/ath10k.patch
 delete mode 100644 patches/0014-netlink_seq/net_wireless_nl80211.patch
 delete mode 100644 patches/0015-rename_pm_qos_request/drivers_net_wireless_ipw2x00_ipw2100.patch
 delete mode 100644 patches/0016-libertas-olpc-ec-wakeup/INFO
 delete mode 100644 patches/0016-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch
 delete mode 100644 patches/0017-get_ts_info/INFO
 delete mode 100644 patches/0017-get_ts_info/get_ts_info.cocci
 delete mode 100644 patches/0019-usb_driver_lpm.cocci
 delete mode 100644 patches/0020-tty-termios/INFO
 delete mode 100644 patches/0021-umode_t-api-change/ath10k.patch
 delete mode 100644 patches/0021-umode_t-api-change/ath9k.patch
 delete mode 100644 patches/0022-define-tracing/INFO
 delete mode 100644 patches/0022-define-tracing/ath6kl.patch
 delete mode 100644 patches/0022-define-tracing/cfg80211.patch
 delete mode 100644 patches/0022-define-tracing/mt7601u.patch
 delete mode 100644 patches/0022-define-tracing/wil6210.patch
 delete mode 100644 patches/0024-led-blink-api/INFO
 delete mode 100644 patches/0024-led-blink-api/mac80211.patch
 delete mode 100644 patches/0025-usb-sg/INFO
 delete mode 100644 patches/0025-usb-sg/usbnet.patch
 delete mode 100644 patches/0026-ipv6_stub/INFO
 delete mode 100644 patches/0026-ipv6_stub/cdc_mbim.patch
 delete mode 100644 patches/0027-genl-const/INFO
 delete mode 100644 patches/0027-genl-const/genl-const.cocci
 delete mode 100644 patches/0029-struct_hid_ll_driver-extensions/INFO
 delete mode 100644 patches/0030-qdisc_tx_busylock/INFO
 delete mode 100644 patches/0031-sk_data_ready.cocci
 delete mode 100644 patches/0032-sriov_configure/INFO
 delete mode 100644 patches/0032-sriov_configure/sriov_configure.cocci
 delete mode 100644 patches/0033-ndo_vlan_rx_vid/INFO
 delete mode 100644 patches/0033-ndo_vlan_rx_vid/cdc_mbim.patch
 delete mode 100644 patches/0034-ndo_set_vf_spoofchk/INFO
 delete mode 100644 patches/0034-ndo_set_vf_spoofchk/set_vf_spoofchk.cocci
 delete mode 100644 patches/0035-skb_no_fcs/INFO
 delete mode 100644 patches/0035-skb_no_fcs/skb_no_fcs.cocci
 delete mode 100644 patches/0036-ethtool_eee/INFO
 delete mode 100644 patches/0036-ethtool_eee/ethtool_eee.cocci
 delete mode 100644 patches/0037-ethtool_get_module/INFO
 delete mode 100644 patches/0037-ethtool_get_module/get_module.cocci
 delete mode 100644 patches/0038-ethtool_rxfh_indir/INFO
 delete mode 100644 patches/0039-ethtool_rxnfc/INFO
 delete mode 100644 patches/0039-ethtool_rxnfc/rxnfc.cocci
 delete mode 100644 patches/0040-ethtool_cmd_mdix/INFO
 delete mode 100644 patches/0040-ethtool_cmd_mdix/ethtool_cmd_mdix.cocci
 delete mode 100644 patches/0042-pci_error_handlers/INFO
 delete mode 100644 patches/0042-pci_error_handlers/igb_pci_error_handlers.cocci
 delete mode 100644 patches/0043-ndo_set_vf_rate/INFO
 delete mode 100644 patches/0043-ndo_set_vf_rate/set_vf_rate.cocci
 delete mode 100644 patches/0049-no-pfmemalloc/no-pfmemalloc.cocci
 delete mode 100644 patches/0051-no-wakeup_path/ssb.patch
 delete mode 100644 patches/0052-deactivate-ptp-pin/INFO
 delete mode 100644 patches/0053-possible_net_t.patch
 delete mode 100644 patches/0054-struct-proto_ops-sig.cocci
 delete mode 100644 patches/0055-name_assign_type/brcmfmac.patch
 delete mode 100644 patches/0055-netdev-tstats.cocci
 delete mode 100644 patches/0056-ndo_features_check/INFO
 delete mode 100644 patches/0056-ndo_features_check/features_check.cocci
 delete mode 100644 patches/0058-ptp_getsettime64/INFO
 delete mode 100644 patches/0058-ptp_getsettime64/ptp_getsettime64.cocci
 delete mode 100644 patches/0059-skb_xmit_more/INFO
 delete mode 100644 patches/0059-uuid-in-mei/INFO
 delete mode 100644 patches/0060-trace_field_struct/INFO
 delete mode 100644 patches/0060-trace_field_struct/mt7601u.patch
 delete mode 100644 patches/0061-termios_rwsem/INFO
 delete mode 100644 patches/0062-iff-no-queue.cocci
 delete mode 100644 patches/0065-ndisc_send_na-argument.cocci
 delete mode 100644 patches/0069-iwlwifi-pd-string-fix.patch
 delete mode 100644 patches/0069-remove-of_irq/bcma.patch
 delete mode 100644 patches/0070-mac80211-fils.patch
 delete mode 100644 patches/0071-skb-head_frag/wireless.patch
 delete mode 100644 patches/0074-skb-wifi-acked.cocci
 delete mode 100644 patches/0076-reset-notify.cocci
 delete mode 100644 patches/0085-iwlwifi-pci-device-removal.patch
 delete mode 100644 patches/devcoredump.patch

-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
