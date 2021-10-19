Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C449C433FE
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 039FE61052
	for <backports@archiver.kernel.org>; Tue, 19 Oct 2021 21:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhJSVp7 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbhJSVpz (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Oct 2021 17:45:55 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101C1C061749
        for <backports@vger.kernel.org>; Tue, 19 Oct 2021 14:43:41 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4HYnLL6qSwzQkBc;
        Tue, 19 Oct 2021 23:43:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634679817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=o4dyW7sIKFT3ocosBOgSVdLJqOWl5FLEjxaoXt/X17s=;
        b=yaLy4Yf0BtJFeMReXUT/9sx3c7C8jzqjxovroJMJ5d6JFAG6OJRjXvRT4XhrWRDhF4p7IL
        ztthieT0EMpV0pDR3hvo+LcjhtlR5R7T/fs9TOn2aZHXVnz9GUhz47o2uAIArjYraLIHeW
        ANaVPsZtptWS2f3z8PEE2g3uV8QaIyVfiEtnh+DQYuPWvm1furvyz+GTLJ4z+FL+zefzwD
        fokHKCDuPHtQ7tdOr72vXbxLBlsAFvqjDvVDghx2U5V8LXhU6XvsCs0BTULbR9krkxYy8o
        ASjw6nj8fEe4lwdSgiPJhc4E1kkTa0Kt99NnaNJYIdM+mnp8aA6U9v4S+fhl3g==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/47] backports: Update to kernel 5.15-rc6
Date:   Tue, 19 Oct 2021 23:42:33 +0200
Message-Id: <20211019214320.2035704-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EF4021318
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This updates backports to kernel 5.15-rc6.

This is done in multiple steps, I plan to make a release based on the 
latest stable version for each major kernel version between 5.10 and 
5.15-rc6. This was compile tested against kernel 4.4 till 5.10 and 
runtime tested in AP mode with ath9k. We want to use this in OpenWrt and 
are testing this in OpenWrt now.

These patches are also available here:
https://github.com/hauke/backports/tree/devel-5.15-2


Hauke Mehrtens (47):
  patches: Refresh on kernel 5.11.22
  backports: Add dev_get_tstats64() and bp_dev_get_tstats64()
  backports: Add empty implementation for skb_get_kcov_handle()
  backports: Add linux/math.h
  backports: Add dev_sw_netstats_rx_add() and dev_sw_netstats_tx_add()
  headers: Add linux/kcov.h
  patches: Do not use rx_list in mt76 on older kernel versions.
  dependencies: Build mt7915 only on kernel >= 4.6
  patches: Remove const from struct rchan_callbacks
  patches: Refresh patches on top of kernel 5.12.19
  patches: include linux/modules.h in mt76/mt76_connac_mcu.c
  patches: Do not use rx_list in mt76/mt7921 driver on older kernel
    versions.
  patches: Do not use rx_list in mt7601u driver on older kernel
    versions.
  dependencies: Build mt7921 only on kernel >= 4.6
  dependencies: Build NL80211_TESTMODE only on kernel >= 4.18
  headers: Add DECLARE_STATIC_KEY_FALSE
  headers: Add ETH_P_MAP
  patches: Refresh on top of kernel 5.13.19
  headers: Add tasklet_disable_in_atomic()
  headers: Add lockdep_assert_not_held()
  headers: Adapt signature of of_get_mac_address()
  headers: Add rfkill_set_hw_state_reason()
  patches: Remove usage of threaded NAPI from mt76
  headers: Adapt signature of thermal_zone_device_update()
  headers: Add time_after32()
  patches: Refresh on top of kernel 5.14.13
  headers: Add FW_ACTION_NOUEVENT and FW_ACTION_UEVENT
  headers: Add linux/wwan.h file
  headers: Add DEVICE_ATTR_ADMIN_RW
  headers: Add get_unaligned_be24
  headers: Add rbtree cached
  headers: Adapt signature of hrtimer_forward_now()
  dependencies: Build RTL8723BS only on kernel >= 5.4
  backports: Remove rtl8188eu driver
  backports: Remove prism54 driver
  patches: Refresh on top of kernel 5.15-rc6
  backports: Remove old CISCO airo driver
  backports: Remove intersil hostap driver
  patches: Adapt signature of bus_type->remove callback
  patches: Adapt signature of ethtool_ops->set_coalesce callback
  patches: Do not set mhi_controller->reg_len on older kernel versions
  backports: Update wifi defconfig
  backports: Add new r8188eu driver
  headers: Add new include/linux/bits.h
  headers: Add function devm_clk_get_optional()
  patches: Remove usage of DMI_PRODUCT_SKU
  headers: Check for NULL in dev_put() and dev_hold()

 backport/backport-include/asm/unaligned.h     |  17 ++
 backport/backport-include/linux/bits.h        |  14 ++
 backport/backport-include/linux/clk.h         |  20 +++
 backport/backport-include/linux/device.h      |  10 ++
 backport/backport-include/linux/firmware.h    |   8 +
 backport/backport-include/linux/if_ether.h    |   6 +
 backport/backport-include/linux/interrupt.h   |  32 ++++
 backport/backport-include/linux/jump_label.h  |  10 ++
 backport/backport-include/linux/kcov.h        |  16 ++
 backport/backport-include/linux/lockdep.h     |  11 ++
 backport/backport-include/linux/math.h        |  12 ++
 backport/backport-include/linux/netdevice.h   |  54 +++++++
 backport/backport-include/linux/of_net.h      |  14 +-
 backport/backport-include/linux/rbtree.h      |  59 +++++++
 backport/backport-include/linux/rfkill.h      |  24 +++
 backport/backport-include/linux/sched.h       |   5 +
 backport/backport-include/linux/skbuff.h      |   8 +
 backport/backport-include/linux/sysfs.h       |   9 ++
 backport/backport-include/linux/thermal.h     |  23 +++
 backport/backport-include/linux/time.h        |  17 ++
 backport/backport-include/linux/wwan.h        |  35 ++++
 backport/compat/Makefile                      |   3 +
 backport/compat/backport-4.11.c               |  12 ++
 backport/compat/backport-5.11.c               |  19 +++
 backport/compat/backport-5.13.c               |  30 ++++
 backport/defconfigs/wifi                      |  26 +--
 copy-list                                     |   8 +-
 dependencies                                  |  10 ++
 .../include_net_cfg80211.patch                |   4 +-
 .../net_wireless_core.patch                   |   2 +-
 .../net_wireless_core.patch                   |   4 +-
 .../0013-fix-makefile-includes/cfg80211.patch |  16 +-
 patches/0013-fix-makefile-includes/mt76.patch |  10 ++
 .../0013-fix-makefile-includes/r8188eu.patch  |  12 ++
 .../0013-fix-makefile-includes/rtw88.patch    |  10 +-
 .../0013-fix-makefile-includes/wilc1000.patch |   4 +-
 patches/0028-select_queue/mac80211.patch      |   4 +-
 patches/0028-select_queue/mwifiex.patch       |   2 +-
 .../{rtl8188eu.patch => r8188eu.patch}        |  17 +-
 patches/0028-select_queue/rtl8723bs.patch     |   2 +-
 patches/0075-ndo-stats-64/usbnet.patch        |  24 ---
 patches/0077-genl-ro-after-init/hwsim.patch   |   2 +-
 patches/0077-genl-ro-after-init/nl80211.patch |   2 +-
 patches/0079-netdev-destructor/brcmfmac.patch |   6 +-
 patches/0084-disable-some-staging-dirs.patch  |   8 +-
 patches/0089-unknown-dmi/mwifiex.patch        |  22 +++
 patches/0092-listified-rx/iwlwifi.patch       |  19 ---
 patches/0094-ndo-tx-timeout/prism54.patch     |  23 ---
 patches/0094-ndo-tx-timeout/usbnet.patch      |   2 +-
 patches/0095-spi-delay/wilc1000.patch         |   6 +-
 patches/0097-skb-list/mac80211-rx.patch       |  28 +++-
 patches/0097-skb-list/mac80211-status.patch   |   6 +-
 patches/0097-skb-list/mt76.patch              | 150 ++++++++++++++++++
 patches/0097-skb-list/mt7601u.patch           |  30 ++++
 patches/0098-netdev_nested_priv/qtnfmac.patch |   6 +-
 patches/0099-netlink-range/mac80211.patch     |  13 +-
 patches/0100-revert-small_ops/mac80211.patch  |   8 +-
 .../mac80211_hwsim.patch                      |   4 +-
 patches/0101-net_device-threaded/mt76.patch   |  41 +++++
 patches/0102-remove-callback.patch            |  63 ++++++++
 patches/0103-ethtool-coalesce.patch           |  36 +++++
 patches/0104-mhi-reg-len.patch                |  12 ++
 ...05-remove-const-from-rchan_callbacks.patch |  42 +++++
 patches/verify.patch                          |  14 +-
 64 files changed, 1002 insertions(+), 164 deletions(-)
 create mode 100644 backport/backport-include/asm/unaligned.h
 create mode 100644 backport/backport-include/linux/bits.h
 create mode 100644 backport/backport-include/linux/clk.h
 create mode 100644 backport/backport-include/linux/device.h
 create mode 100644 backport/backport-include/linux/jump_label.h
 create mode 100644 backport/backport-include/linux/kcov.h
 create mode 100644 backport/backport-include/linux/math.h
 create mode 100644 backport/backport-include/linux/rbtree.h
 create mode 100644 backport/backport-include/linux/rfkill.h
 create mode 100644 backport/backport-include/linux/wwan.h
 create mode 100644 backport/compat/backport-4.11.c
 create mode 100644 backport/compat/backport-5.11.c
 create mode 100644 backport/compat/backport-5.13.c
 create mode 100644 patches/0013-fix-makefile-includes/r8188eu.patch
 rename patches/0028-select_queue/{rtl8188eu.patch => r8188eu.patch} (56%)
 delete mode 100644 patches/0075-ndo-stats-64/usbnet.patch
 create mode 100644 patches/0089-unknown-dmi/mwifiex.patch
 delete mode 100644 patches/0092-listified-rx/iwlwifi.patch
 delete mode 100644 patches/0094-ndo-tx-timeout/prism54.patch
 create mode 100644 patches/0097-skb-list/mt76.patch
 create mode 100644 patches/0097-skb-list/mt7601u.patch
 create mode 100644 patches/0101-net_device-threaded/mt76.patch
 create mode 100644 patches/0102-remove-callback.patch
 create mode 100644 patches/0103-ethtool-coalesce.patch
 create mode 100644 patches/0104-mhi-reg-len.patch
 create mode 100644 patches/0105-remove-const-from-rchan_callbacks.patch

-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
