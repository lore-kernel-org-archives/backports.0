Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B0AC433F5
	for <backports@archiver.kernel.org>; Sun,  6 Feb 2022 22:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240585AbiBFW1U (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 6 Feb 2022 17:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238398AbiBFW1U (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 6 Feb 2022 17:27:20 -0500
X-Greylist: delayed 105 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 14:27:19 PST
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96BFC06173B
        for <backports@vger.kernel.org>; Sun,  6 Feb 2022 14:27:19 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id DC7A832009F3;
        Sun,  6 Feb 2022 17:27:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 06 Feb 2022 17:27:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; bh=pl3YmsOn8e3AUl9vkh/kA6WOxeb6wbmEYsIFkz8MUb4=; b=K6CNf
        U02JDO01c7EsFFU4Hv/FNnNpFnzjbZOMACWdCzl6rALGPbFhND1fwQgNcF5RZwoF
        ci7PFplmBP3VI+pnP1FKFsOO4iE5+LoatYJMGkLr2sEHz1xuPDgnfGucl+IDEbwx
        5CU2g2EvBNuKAVvn82nObXbsDQgbmRnjZH5DcgF1tpX5iMhb+dstcG210EGzh2eT
        kDzWIxhC5IBLvA+38C56dXkDdN5q33FML2g9a+Cz8AMF3TT36RdV+L2J1siq5mG0
        eWhnsFCft2Az5/icxwT3Q2TZAF5XetusKQyubwQyZZwWNSMtthaIvlN93yb+8GLO
        FVI0jUURuUe+PgiIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=pl3YmsOn8e3AUl9vkh/kA6WOxeb6w
        bmEYsIFkz8MUb4=; b=nneXEWosW81KhS1jR6NK6HOA9NrJGAZfVeScD6m2ZjcPO
        5stfcERU6xfSuHIkVvme/pAtfEeSd0FV4nkHr5FaVkawm+YYZh7ni3L6irkW+ZWT
        mSbuAOTkOOLfUGdDzxNLO3yNJa/7/9nGGYDOl03IQfT5t0d+3r5aeiJgVpNmkO2N
        NFlalsSj3YZL6x8QBJkRjFJDprTnPYqk0DcSUcx3lEQyjrgCMxuVZPCpU3Nst2Bc
        9UAd4mDd7rHhkqPmgi6tIm/ySA3+/0Vsq0QWjvFpa77uxPdJwWeTezfqCDUvrZQ2
        uSmE8u6xYdXX61sUqcGM8PzsWXmnGgtgJSIG6lcJw==
X-ME-Sender: <xms:RksAYqLd5nOUGQiaIkHJlsOIvWwPNqGBE1jkxyHVPvJA1-_6PQO-6A>
    <xme:RksAYiIGutmUZ1AUnyzFQQq0fdOVaUX918pwMIy24158qCfqhg0wZGNgXh8vG_SWJ
    4LSemMpeOmnN0e4khE>
X-ME-Received: <xmr:RksAYquAb_BxXXCDpnOLTKDi1UiZXyXF91QZbyHyEGX3fJYSF8T2PFI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheefgdduiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehf
    lhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpefhjedtkedtueehtdeifeetke
    evffetjeetfeegkeevgefftedvudfgleeihfdtudenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorg
    htrdgtohhm
X-ME-Proxy: <xmx:RksAYvbWmrnj3fZgYpWtfVG7261QEPJIq65BV0Oc8TmODAbtiaBiyA>
    <xmx:RksAYhZPGt_5vHvVslLs7X8ksVXK75GEm6JI708T_mrtwZ5SHFi8Cw>
    <xmx:RksAYrAMcB5GVb-qbkmTS4HPqbhaei5b8K3T6rFcAdIdr-i80Uwztg>
    <xmx:RksAYgnpe-4XcpEB3V0a22Cq2d3y8jZI5FTqz1Oz4Jsix4xsNTwdCw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Feb 2022 17:27:17 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     hauke@hauke-m.de, mcgrof@kernel.org
Cc:     backports@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/6] backports: Backport some ath11k runtime dependencies
Date:   Sun,  6 Feb 2022 22:26:50 +0000
Message-Id: <20220206222656.210655-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Backport mhi bus driver and QRTR driver.
ath11k requires them aligned with latest version at runtime.

Jiaxun Yang (6):
  headers: Add MHI stuff to mod_devicetable
  backports: Add mhi bus driver
  backports: backport {get,set}_user_ifreq
  headers: backport sk_error_report
  backports: Add QRTR driver
  defconfigs: Refresh for ath11k

 backport/Kconfig.sources                      |  2 +
 backport/Makefile.kernel                      |  2 +
 .../backport-include/linux/mod_devicetable.h  | 15 ++++++
 backport/backport-include/linux/netdevice.h   |  5 ++
 backport/backport-include/net/sock.h          |  8 ++++
 backport/compat/Makefile                      |  1 +
 backport/compat/backport-5.15.c               | 47 +++++++++++++++++++
 backport/compat/backport-genetlink.c          |  2 +-
 backport/defconfigs/ath11k                    | 14 ++++++
 backport/defconfigs/wifi                      |  3 ++
 copy-list                                     |  6 +++
 dependencies                                  |  6 +++
 12 files changed, 110 insertions(+), 1 deletion(-)
 create mode 100644 backport/compat/backport-5.15.c
 create mode 100644 backport/defconfigs/ath11k

-- 
2.35.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
