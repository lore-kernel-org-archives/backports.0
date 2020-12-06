Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,T_TVD_MIME_EPI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C662C4361B
	for <backports@archiver.kernel.org>; Sun,  6 Dec 2020 15:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13CAC2256F
	for <backports@archiver.kernel.org>; Sun,  6 Dec 2020 15:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgLFP6n (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 6 Dec 2020 10:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgLFP6n (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 6 Dec 2020 10:58:43 -0500
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196ECC0613D0
        for <backports@vger.kernel.org>; Sun,  6 Dec 2020 07:58:03 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Cprgn6pXXzQky8;
        Sun,  6 Dec 2020 16:57:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1607270276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZUL/AEGHig29qhGGBslLXUz+kDRt21Th8uj4955GhFA=;
        b=TDY3uPmqyRP8xXBh3S4U4K00VjvXpdZXZe3Q7OgIDY3Ov3L66ZQGXr6rK9lm2zZDaVbc5f
        Vs+TJNiHqcH8hWvKR0V4Ls2+WbqG61PclxcOcq1riNeGLcP4ueNrb/fcJjB6wqrt3WHmj7
        brw/0RE2MRgyGujr0j0WmjxRsqSQEJDDghLnfB7oipUkHoleqg+0PT2dR6QeK5I7gl/ea/
        /rMXHVIdLzljb1iJs7bNfVCkVcQZC245V1dVYjUHMBEqcvXW+Q9Qw/6upR7mAtU4sN6YJK
        e+08FSd8ye1EZeA0IdrDCIdKJ+PT7oQtKthen4MRe2cILNI6NtHNeyqCtvchCQ==
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id HotOkHNzSl4A; Sun,  6 Dec 2020 16:57:54 +0100 (CET)
Subject: Re: [PATCH 00/30] backports: Update to match kernel 5.10-rc6
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net
References: <20201201220415.30582-1-hauke@hauke-m.de>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <4dda6863-127e-ddfa-27db-9b5ee2534200@hauke-m.de>
Date:   Sun, 6 Dec 2020 16:57:41 +0100
MIME-Version: 1.0
In-Reply-To: <20201201220415.30582-1-hauke@hauke-m.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AU5juxXqS1epjgrc6VX6E302EMdGBbqaN"
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -6.04 / 15.00 / 15.00
X-Rspamd-Queue-Id: F2C471723
X-Rspamd-UID: dd252e
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AU5juxXqS1epjgrc6VX6E302EMdGBbqaN
Content-Type: multipart/mixed; boundary="UCOFq4NlvLWPPCNAyFQ6hC4stqo4ffe5d";
 protected-headers="v1"
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: johannes@sipsolutions.net
Message-ID: <4dda6863-127e-ddfa-27db-9b5ee2534200@hauke-m.de>
Subject: Re: [PATCH 00/30] backports: Update to match kernel 5.10-rc6
References: <20201201220415.30582-1-hauke@hauke-m.de>
In-Reply-To: <20201201220415.30582-1-hauke@hauke-m.de>

--UCOFq4NlvLWPPCNAyFQ6hC4stqo4ffe5d
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12/1/20 11:03 PM, Hauke Mehrtens wrote:
> This adds many changes to make backports compatible with kernel 5.10-rc=
6.
>=20
> I plan to create also releaes based on 5.8.18 and 5.9.11, I will take
> the commit directly before the refresh for the next kernel version.
>=20
> Felix Fietkau (2):
>    backports: add sched_set_fifo_low
>    backports: add tasklet_setup, from_tasklet
>=20
> Hauke Mehrtens (27):
>    backports: Adapt to changes in Ubuntu mainline URLs
>    gentree.py: Remoace space between -I and $(src)
>    backports: Extend NOSTDINC_FLAGS
>    patches: Refresh on kernel 5.8.18
>    backprots: make patches apply on 5.9.11
>    header: add module_sdio_driver
>    header: Rename kfree_sensitive(x) to kzfree(x)
>    header: dummy implementation for thermal_zone_device_enable
>    header: Add __skb_put_zero()
>    dependency: add MT7663S
>    backports: add gpiochip_request_own_desc()
>    backports: Add microchip wilc1000 driver
>    backports: Make rx_list handling work on older kernel versions
>    patches: Add missing linux/kthread.h include
>    patches: Add include to rtw88
>    patches: handle netdev_walk_all_lower_dev()
>    patches: Remove unneeded 0018-pv-trace-fixes patch
>    patches: Refresh on kernel 5.10-rc6
>    patches: Avoid using NLA_POLICY_RANGE(NLA_BINARY, ...)
>    patches: Deactivate hikey9xx staging driver
>    patches: Revert usage of small_ops
>    headers: Add DEFINE_SEQ_ATTRIBUTE
>    backports: Add netif_rx_any_context()
>    backports: Add dev_fetch_sw_netstats()
>    backports: Make ieee80211_tx_status handling work on older kernel
>      versions
>    backports: Add sysfs_emit()
>    backports: Remove crypto/akcipher.h
>=20
> Shay Bar (1):
>    backports: Add time64_to_tm and ipv6_mc_check_mld
>=20
>   backport/Makefile.kernel                      |   4 +-
>   backport/backport-include/linux/gpio/driver.h |  12 ++
>   backport/backport-include/linux/interrupt.h   |  17 +++
>   .../backport-include/linux/mmc/sdio_func.h    |  14 +++
>   backport/backport-include/linux/netdevice.h   |  21 ++++
>   backport/backport-include/linux/sched.h       |  20 +++
>   backport/backport-include/linux/seq_file.h    |  21 ++++
>   backport/backport-include/linux/skbuff.h      |   8 ++
>   backport/backport-include/linux/slab.h        |   4 +
>   backport/backport-include/linux/sysfs.h       |  14 +++
>   backport/backport-include/linux/thermal.h     |  10 ++
>   backport/backport-include/linux/time.h        |   8 ++
>   backport/backport-include/net/addrconf.h      |  15 +++
>   backport/backport-include/net/netlink.h       |   6 +
>   backport/compat/Makefile                      |   2 +
>   backport/compat/backport-5.10.c               |  81 ++++++++++++
>   backport/compat/backport-5.3.c                |  74 +++++++++++
>   copy-list                                     |   1 +
>   dependencies                                  |   1 +
>   devel/backports-update-manager                |  44 ++++---
>   gentree.py                                    |   2 +-
>   ...2-disable-dump-adjust-on-old-kernels.patch |   4 +-
>   .../include_net_cfg80211.patch                |   2 +-
>   .../net_wireless_core.patch                   |   2 +-
>   .../net_wireless_core.patch                   |  26 ++--
>   patches/0013-fix-makefile-includes/mt76.patch |  32 +++++
>   .../0013-fix-makefile-includes/rtw88.patch    |  12 ++
>   .../0013-fix-makefile-includes/wilc1000.patch |  34 ++++++
>   .../net_wireless_nl80211.patch                |   2 +-
>   patches/0018-pv-trace-fixes/INFO              |   7 --
>   ...ivers_net_wireless_iwlwifi_iwl-debug.patch |  65 ----------
>   .../net_mac80211_trace.patch                  |  79 ------------
>   patches/0024-led-blink-api/mac80211.patch     |   2 +-
>   patches/0025-usb-sg/usbnet.patch              |  14 +--
>   patches/0028-select_queue/mac80211.patch      |   4 +-
>   patches/0028-select_queue/mwifiex.patch       |   2 +-
>   patches/0053-possible_net_t.patch             |   2 +-
>   patches/0055-name_assign_type/brcmfmac.patch  |   2 +-
>   patches/0071-skb-head_frag/wireless.patch     |   2 +-
>   patches/0075-ndo-stats-64/usbnet.patch        |   6 +-
>   patches/0077-genl-ro-after-init/hwsim.patch   |   2 +-
>   patches/0077-genl-ro-after-init/nl80211.patch |   2 +-
>   patches/0079-netdev-destructor/brcmfmac.patch |   4 +-
>   patches/0084-disable-some-staging-dirs.patch  |   6 +
>   patches/0085-iwlwifi-pci-device-removal.patch |   4 +-
>   patches/0091-fq-no-siphash_key_t/fq.patch     |  36 ------
>   patches/0094-ndo-tx-timeout/prism54.patch     |   2 +-
>   patches/0094-ndo-tx-timeout/usbnet.patch      |   2 +-
>   patches/0095-spi-delay/wilc1000.patch         |  47 +++++++
>   patches/0097-skb-list/mac80211-rx.patch       | 115 +++++++++++++++++=
+
>   patches/0097-skb-list/mac80211-status.patch   |  47 +++++++
>   patches/0098-netdev_nested_priv/qtnfmac.patch |  43 +++++++
>   patches/0099-netlink-range/mac80211.patch     |  57 +++++++++
>   patches/0100-revert-small_ops/mac80211.patch  |  25 ++++
>   .../mac80211_hwsim.patch                      |  28 +++++
>   patches/verify.patch                          |  14 ++-
>   56 files changed, 861 insertions(+), 251 deletions(-)
>   create mode 100644 backport/backport-include/linux/sched.h
>   create mode 100644 backport/compat/backport-5.10.c
>   create mode 100644 backport/compat/backport-5.3.c
>   create mode 100644 patches/0013-fix-makefile-includes/wilc1000.patch
>   delete mode 100644 patches/0018-pv-trace-fixes/INFO
>   delete mode 100644 patches/0018-pv-trace-fixes/drivers_net_wireless_i=
wlwifi_iwl-debug.patch
>   delete mode 100644 patches/0018-pv-trace-fixes/net_mac80211_trace.pat=
ch
>   delete mode 100644 patches/0091-fq-no-siphash_key_t/fq.patch
>   create mode 100644 patches/0095-spi-delay/wilc1000.patch
>   create mode 100644 patches/0097-skb-list/mac80211-rx.patch
>   create mode 100644 patches/0097-skb-list/mac80211-status.patch
>   create mode 100644 patches/0098-netdev_nested_priv/qtnfmac.patch
>   create mode 100644 patches/0099-netlink-range/mac80211.patch
>   create mode 100644 patches/0100-revert-small_ops/mac80211.patch
>   create mode 100644 patches/0100-revert-small_ops/mac80211_hwsim.patch=

>=20

I applied all the patches.

Hauke


--UCOFq4NlvLWPPCNAyFQ6hC4stqo4ffe5d--

--AU5juxXqS1epjgrc6VX6E302EMdGBbqaN
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAl/M/3YACgkQ8bdnhZyy
68fwMQf/U3PdUgITH5PltfxPkMkvFmk3iLF46JjcKJmPZ0qvKOcmxaXDekbJO2WE
t1mp338ctoD1DR6FrxzZAHJXGRI0ZwoqdMMrQI+br83i6sbcwy8k3UMWgVuM4tQn
bLZkFnimtXKrMhEQ/erizwNp6eSNGAFBVX0F92OHA4bz7lPxVFOIY5cfGK4weKfX
SxmsAKHEFCotTOKwgxXaewNx1qz8+xkvzB5Yvw1KiJxe8o3sDSBUrPdXu/32mi/s
vnEPnmKOuAZ/lBOW3lwpoaedfM0w9e8m2gNiKnHdt7BsZNNqASHmeV1Lx/9m1pBu
p2THhW5nMCDWuF/meJg/xQNbsOZARg==
=ww6K
-----END PGP SIGNATURE-----

--AU5juxXqS1epjgrc6VX6E302EMdGBbqaN--
--
To unsubscribe from this list: send the line "unsubscribe backports" in
