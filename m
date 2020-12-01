Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3173AC8300F
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE81720709
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="V3rzHdcj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgLAWFO (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgLAWFN (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 1 Dec 2020 17:05:13 -0500
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9077EC0613D4
        for <backports@vger.kernel.org>; Tue,  1 Dec 2020 14:04:33 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Clx333HW7zQlL0;
        Tue,  1 Dec 2020 23:04:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1606860269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DAWRVuWcelmRNblIENiv6N4lLfUvzOXBl4sTy4hywKs=;
        b=V3rzHdcj1glX07atjmGG6a/LTJn/7q9QfpQ2s97zHm0JPL0UY4O7KlqWXXQHxjcn9rnKoc
        Xe2zmin7U9TblTMKqmL3K0R8cVxCPk4QT+Gj8N8YReTLOftUQ897MMVQiVduQ5KFKRLVwK
        yqfK/65CCsnKp9jZHqJAPFnj+zpUQjvZl7D/ZYD8hNm7t8pTf7SJ019wf4NIjyDkWlLn4M
        OEhINgfEW1ab4FYMH5FgU9lQQLqVgXgFnzv0d70o2lyhBKnZsoVql/AOOqe1EweUVdasbX
        wmQb+QPOdDyKRRDM6wUJRt7FoU2yjg+AjSlPwdDkvFshozJ9uWeNRGMMpySQ2w==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id 6zuBXjKhPCyD; Tue,  1 Dec 2020 23:04:28 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/30] backports: Update to match kernel 5.10-rc6
Date:   Tue,  1 Dec 2020 23:03:45 +0100
Message-Id: <20201201220415.30582-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.93 / 15.00 / 15.00
X-Rspamd-Queue-Id: 804C11831
X-Rspamd-UID: 9b2fe1
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This adds many changes to make backports compatible with kernel 5.10-rc6.

I plan to create also releaes based on 5.8.18 and 5.9.11, I will take 
the commit directly before the refresh for the next kernel version.

Felix Fietkau (2):
  backports: add sched_set_fifo_low
  backports: add tasklet_setup, from_tasklet

Hauke Mehrtens (27):
  backports: Adapt to changes in Ubuntu mainline URLs
  gentree.py: Remoace space between -I and $(src)
  backports: Extend NOSTDINC_FLAGS
  patches: Refresh on kernel 5.8.18
  backprots: make patches apply on 5.9.11
  header: add module_sdio_driver
  header: Rename kfree_sensitive(x) to kzfree(x)
  header: dummy implementation for thermal_zone_device_enable
  header: Add __skb_put_zero()
  dependency: add MT7663S
  backports: add gpiochip_request_own_desc()
  backports: Add microchip wilc1000 driver
  backports: Make rx_list handling work on older kernel versions
  patches: Add missing linux/kthread.h include
  patches: Add include to rtw88
  patches: handle netdev_walk_all_lower_dev()
  patches: Remove unneeded 0018-pv-trace-fixes patch
  patches: Refresh on kernel 5.10-rc6
  patches: Avoid using NLA_POLICY_RANGE(NLA_BINARY, ...)
  patches: Deactivate hikey9xx staging driver
  patches: Revert usage of small_ops
  headers: Add DEFINE_SEQ_ATTRIBUTE
  backports: Add netif_rx_any_context()
  backports: Add dev_fetch_sw_netstats()
  backports: Make ieee80211_tx_status handling work on older kernel
    versions
  backports: Add sysfs_emit()
  backports: Remove crypto/akcipher.h

Shay Bar (1):
  backports: Add time64_to_tm and ipv6_mc_check_mld

 backport/Makefile.kernel                      |   4 +-
 backport/backport-include/linux/gpio/driver.h |  12 ++
 backport/backport-include/linux/interrupt.h   |  17 +++
 .../backport-include/linux/mmc/sdio_func.h    |  14 +++
 backport/backport-include/linux/netdevice.h   |  21 ++++
 backport/backport-include/linux/sched.h       |  20 +++
 backport/backport-include/linux/seq_file.h    |  21 ++++
 backport/backport-include/linux/skbuff.h      |   8 ++
 backport/backport-include/linux/slab.h        |   4 +
 backport/backport-include/linux/sysfs.h       |  14 +++
 backport/backport-include/linux/thermal.h     |  10 ++
 backport/backport-include/linux/time.h        |   8 ++
 backport/backport-include/net/addrconf.h      |  15 +++
 backport/backport-include/net/netlink.h       |   6 +
 backport/compat/Makefile                      |   2 +
 backport/compat/backport-5.10.c               |  81 ++++++++++++
 backport/compat/backport-5.3.c                |  74 +++++++++++
 copy-list                                     |   1 +
 dependencies                                  |   1 +
 devel/backports-update-manager                |  44 ++++---
 gentree.py                                    |   2 +-
 ...2-disable-dump-adjust-on-old-kernels.patch |   4 +-
 .../include_net_cfg80211.patch                |   2 +-
 .../net_wireless_core.patch                   |   2 +-
 .../net_wireless_core.patch                   |  26 ++--
 patches/0013-fix-makefile-includes/mt76.patch |  32 +++++
 .../0013-fix-makefile-includes/rtw88.patch    |  12 ++
 .../0013-fix-makefile-includes/wilc1000.patch |  34 ++++++
 .../net_wireless_nl80211.patch                |   2 +-
 patches/0018-pv-trace-fixes/INFO              |   7 --
 ...ivers_net_wireless_iwlwifi_iwl-debug.patch |  65 ----------
 .../net_mac80211_trace.patch                  |  79 ------------
 patches/0024-led-blink-api/mac80211.patch     |   2 +-
 patches/0025-usb-sg/usbnet.patch              |  14 +--
 patches/0028-select_queue/mac80211.patch      |   4 +-
 patches/0028-select_queue/mwifiex.patch       |   2 +-
 patches/0053-possible_net_t.patch             |   2 +-
 patches/0055-name_assign_type/brcmfmac.patch  |   2 +-
 patches/0071-skb-head_frag/wireless.patch     |   2 +-
 patches/0075-ndo-stats-64/usbnet.patch        |   6 +-
 patches/0077-genl-ro-after-init/hwsim.patch   |   2 +-
 patches/0077-genl-ro-after-init/nl80211.patch |   2 +-
 patches/0079-netdev-destructor/brcmfmac.patch |   4 +-
 patches/0084-disable-some-staging-dirs.patch  |   6 +
 patches/0085-iwlwifi-pci-device-removal.patch |   4 +-
 patches/0091-fq-no-siphash_key_t/fq.patch     |  36 ------
 patches/0094-ndo-tx-timeout/prism54.patch     |   2 +-
 patches/0094-ndo-tx-timeout/usbnet.patch      |   2 +-
 patches/0095-spi-delay/wilc1000.patch         |  47 +++++++
 patches/0097-skb-list/mac80211-rx.patch       | 115 ++++++++++++++++++
 patches/0097-skb-list/mac80211-status.patch   |  47 +++++++
 patches/0098-netdev_nested_priv/qtnfmac.patch |  43 +++++++
 patches/0099-netlink-range/mac80211.patch     |  57 +++++++++
 patches/0100-revert-small_ops/mac80211.patch  |  25 ++++
 .../mac80211_hwsim.patch                      |  28 +++++
 patches/verify.patch                          |  14 ++-
 56 files changed, 861 insertions(+), 251 deletions(-)
 create mode 100644 backport/backport-include/linux/sched.h
 create mode 100644 backport/compat/backport-5.10.c
 create mode 100644 backport/compat/backport-5.3.c
 create mode 100644 patches/0013-fix-makefile-includes/wilc1000.patch
 delete mode 100644 patches/0018-pv-trace-fixes/INFO
 delete mode 100644 patches/0018-pv-trace-fixes/drivers_net_wireless_iwlwifi_iwl-debug.patch
 delete mode 100644 patches/0018-pv-trace-fixes/net_mac80211_trace.patch
 delete mode 100644 patches/0091-fq-no-siphash_key_t/fq.patch
 create mode 100644 patches/0095-spi-delay/wilc1000.patch
 create mode 100644 patches/0097-skb-list/mac80211-rx.patch
 create mode 100644 patches/0097-skb-list/mac80211-status.patch
 create mode 100644 patches/0098-netdev_nested_priv/qtnfmac.patch
 create mode 100644 patches/0099-netlink-range/mac80211.patch
 create mode 100644 patches/0100-revert-small_ops/mac80211.patch
 create mode 100644 patches/0100-revert-small_ops/mac80211_hwsim.patch

-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
