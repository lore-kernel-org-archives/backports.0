Return-Path: <SRS0=+jjK=6E=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E5DC54FCC
	for <backports@archiver.kernel.org>; Mon, 20 Apr 2020 22:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD5C520857
	for <backports@archiver.kernel.org>; Mon, 20 Apr 2020 22:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgDTWQa (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:16:30 -0400
Received: from mout-p-103.mailbox.org ([80.241.56.161]:34542 "EHLO
        mout-p-103.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgDTWQa (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 20 Apr 2020 18:16:30 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 495gyh2ht6zKmTw;
        Tue, 21 Apr 2020 00:16:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id v-l_MWJADxUD; Tue, 21 Apr 2020 00:16:25 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/9] backports: Update to version 5.7-rc2
Date:   Tue, 21 Apr 2020 00:16:06 +0200
Message-Id: <20200420221615.14734-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7BB2F1738
X-Rspamd-Score: -4.71 / 15.00 / 15.00
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This adds the missing changes to make backports work with kernel 5.7-rc2

Hauke Mehrtens (9):
  backports: Refresh patches on kernel 5.7-rc2
  backports: pm_qos: Add cpu_latency_qos_* functions
  backports: genetlink: Add genlmsg_parse()
  backports: rculist: Add additional parameter to
    list_for_each_entry_rcu()
  backports: Add include/uapi/linux/virtio_ids.h
  backports: virtio_config: Add virtio_find_vqs()
  backports: patches: avoid struct spi_delay usage
  backports: patches: Avoid struct ethtool_ops.supported_coalesce_params
  backports: netdevice: Add netif_is_bridge_port()

 backport/backport-include/linux/netdevice.h   |  8 +++++
 backport/backport-include/linux/pm_qos.h      | 29 +++++++++++++++++
 backport/backport-include/linux/rculist.h     | 22 +++++++++++++
 .../backport-include/linux/virtio_config.h    | 31 +++++++++++++++++++
 backport/backport-include/net/genetlink.h     | 13 +++++++-
 copy-list                                     |  1 +
 ...2-disable-dump-adjust-on-old-kernels.patch |  4 +--
 .../include_net_cfg80211.patch                |  4 +--
 .../net_wireless_core.patch                   |  2 +-
 .../net_wireless_nl80211.patch                |  2 +-
 patches/0024-led-blink-api/mac80211.patch     |  2 +-
 patches/0028-select_queue/mac80211.patch      |  4 +--
 patches/0053-possible_net_t.patch             |  2 +-
 patches/0069-iwlwifi-pd-string-fix.patch      |  2 +-
 patches/0070-mac80211-fils.patch              |  4 +--
 patches/0071-skb-head_frag/wireless.patch     |  2 +-
 patches/0077-genl-ro-after-init/hwsim.patch   |  2 +-
 patches/0077-genl-ro-after-init/nl80211.patch |  2 +-
 patches/0079-netdev-destructor/brcmfmac.patch |  2 +-
 patches/0095-spi-delay/libertas.patch         | 17 ++++++++++
 ...96-ethtool-supported_coalesce_params.cocci |  9 ++++++
 21 files changed, 146 insertions(+), 18 deletions(-)
 create mode 100644 backport/backport-include/linux/virtio_config.h
 create mode 100644 patches/0095-spi-delay/libertas.patch
 create mode 100644 patches/0096-ethtool-supported_coalesce_params.cocci

-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
