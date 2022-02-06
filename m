Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC68AC433F5
	for <backports@archiver.kernel.org>; Sun,  6 Feb 2022 22:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbiBFWa6 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 6 Feb 2022 17:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiBFWa5 (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 6 Feb 2022 17:30:57 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A189C061348
        for <backports@vger.kernel.org>; Sun,  6 Feb 2022 14:30:57 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 723363200911;
        Sun,  6 Feb 2022 17:25:31 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 06 Feb 2022 17:25:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; bh=pl3YmsOn8e3AUl9vkh/kA6WOxeb6wbmEYsIFkz8MUb4=; b=EPCvR
        dyHVKotwI3J0MtIqe4L3ImCSPgrjVL5VQhrd9eiVQBS642bJ+zqjml7pNtkBaQ01
        H+ztZSxyD9uj0WDB7Vh+QFe/MTp5WC3QVSLs8pejgj1lNsge3qYdMbH8CwgrOg+z
        3BQhMb/shiloCV693ZjV1D0Hkuy4R9DVK1qbe2WWrUAxSkcXbgK3xVYcsx2LEGBU
        yeBfjI5xR69JKHjAAH7BSrB+h6E0ZHJ6vsyINgshoAwdoXd3WIlEf6miZyUnGuMo
        VP/5kW9XmpiYa2EwkxM/8OdXJswLO8i0mh/2o0ZpcGbjPf7rmxY5qoka3VljtI4x
        cjen3pDCDmWzvnIxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=pl3YmsOn8e3AUl9vkh/kA6WOxeb6w
        bmEYsIFkz8MUb4=; b=gP44eDxdyF0HEkaMok7wGihagfLkKWo9EdWR8Snp/jvNn
        CEiVfh7Ssu/GxS+JhnEG6n8MkY1cbKEH80zTAGOEY54eJLo25qjWpe828igo3Gs6
        Ke6NXlrhITW9s0oxeblKWS1knk6TfPz/2hyomn5h18dgySs0Onja6reztGvCMiuL
        hmffp0rLvycp7kSmzaCH4pFziTvoAY0HmiwNq2Gps9iorCmc72tHVhVmcDd4r+ef
        eczTK7L+8HC/9aQkPzcs9QhblHVPKngnMZKFKifgkcBEqbiZan5YF6oCL6wbrNdR
        SOT45acdqOd26TfmmB4QsN89FvY+EETeKrAzfAcbg==
X-ME-Sender: <xms:2koAYh_UiCGPbEFOkni7N1hA0Xht3POEO6GHGUoGHRa_RRm-3Fq4uQ>
    <xme:2koAYltHYOwo7wDpV1ZR0tkQwOTZT_ORlFpvUjQ7N0Es5RV_FLRk8XwBH6knFhXi9
    pnULc0wiMCkw6yF1jY>
X-ME-Received: <xmr:2koAYvB7Xs51WUIuSTR6hdrqpCsm2npU1hpSimPHtFjJmPPseStYHrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheefgdduieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehf
    lhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpefhjedtkedtueehtdeifeetke
    evffetjeetfeegkeevgefftedvudfgleeihfdtudenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorg
    htrdgtohhm
X-ME-Proxy: <xmx:2koAYlfRt2fLix5X2LhMxm50h7ErAmYoG-34PQaLdkRSc8Cub0ZamQ>
    <xmx:2koAYmMQ0PmIjpFilmYKIBG0UDiKgXv1yey8OIDdmIRgh7IwXUHTNQ>
    <xmx:2koAYnmIesLPCYa50vFIFOCV1aHrnTN7GOzCAHU9RZSbCU2RVJ7P2w>
    <xmx:20oAYvamGQa73qTQ58ACJbXWIEBe52B1a_UbORSTB3UMyqaXdyus_Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Feb 2022 17:25:29 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     hauke@hauke-m.de, mcgrof@kernel.org
Cc:     backports@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/6] backports: Backport some ath11k runtime dependencies
Date:   Sun,  6 Feb 2022 22:24:59 +0000
Message-Id: <20220206222505.210326-1-jiaxun.yang@flygoat.com>
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
