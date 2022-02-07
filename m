Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F81C433F5
	for <backports@archiver.kernel.org>; Mon,  7 Feb 2022 12:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384241AbiBGMsS (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 7 Feb 2022 07:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386330AbiBGLeZ (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 7 Feb 2022 06:34:25 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F4FC0401C0
        for <backports@vger.kernel.org>; Mon,  7 Feb 2022 03:34:24 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 947FD3202B34;
        Mon,  7 Feb 2022 06:34:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 07 Feb 2022 06:34:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; bh=arWILtYzV0ratDep15PkkCNudAUl4j1xuUvEkQeZngA=; b=fqrhN
        v4DoZc3eaUwkFtl8ks0OLzydIZR569JweW0855VkbqllMjDtvDTVFzmSsiuAsv+K
        ApqEERjiNh1Yo94+TM92pXVqUoHJF4fSTq7/MyeTGnCrD5wMGz6Y9kUsB80S5Lbq
        oJ0ANl7Aj0G8joANXxU42mO3fu2bwnEwDH5EL2qcQLJyy/t1zySkJiW37r89Vpg5
        PU09eA7kzn+ZrPBF6MtkHUTAaJJUer+Q/pabJ5TRmt6Vh62s9aopmW33cFVFQcks
        DUriQuYR/Vbg+aNuh0oZMV0q+WCHAEq9/VwGizrnyOpbUlpf4jXXidHjW17v/Z9e
        1tLfl7Ufw3QgXKEZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=arWILtYzV0ratDep15PkkCNudAUl4
        j1xuUvEkQeZngA=; b=g5LTsaHLA+a5vB3maeYyxdz3zAxYku13zDU/Ea9wqMcNx
        1Q26c8ESUqdmINgAVGHTVdcmSpMcTHr1qE1TqlLP2gcSlACNO+JjUg8YPq0HLWxD
        L5DXuPfyKOgGcB5Ktk5lstwgFkbqZD5DPxU/2uH0aZTvbhrZjKygEqa7cLa/yp4o
        97W4QiJd++4oLk4MWLkAYqsqjDCQJqnc+hZk6ZbN+0Phw8Cg0aAsZSRSivDLlQ+T
        1Df6FfBsSwujgwkT3nMOZYVE9tkzO8P7qAN5EbJPjrMVyvT2L47JSoTBdMjdt3o3
        92uGB51lZt4NncA87ly94V9ViFee/QCb1HqSU9S+w==
X-ME-Sender: <xms:vgMBYijDJHat6xyFG33Q1sNxGszAwOURIzlbnc-NT2IcLMZAnWQU2w>
    <xme:vgMBYjAk0zXxeKuBf13huIX8I8i74wDXameHlnKHLCFQaPBsrXHRxLZnJdnyoI6L8
    -tdHrZ3pVBKOBAmZLs>
X-ME-Received: <xmr:vgMBYqHgCZG2Inyvpij4djkzpZ6ADfb5JqDLzVt6G7X5O8EcrQ6R2yM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheehgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhl
    hihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhephfejtdektdeuhedtieefteekve
    ffteejteefgeekveegffetvddugfeliefhtddunecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrth
    drtghomh
X-ME-Proxy: <xmx:vgMBYrS2VJhyIOsV_DE-RkUbkpn5PTXCHn3xtpKqtpahzECb9XfGkQ>
    <xmx:vgMBYvxGa7olTuLrgCMwOmpNbPWUr55cjZOmZYy_9XkYG1TaBmuxNQ>
    <xmx:vgMBYp49qjoApfPPNWTaQkLo_0VdtY_ZkHpa5fIImY8Yl1BgEGcZSg>
    <xmx:vwMBYq-3ISzEoa5WFTCTPHLWwjNlbm2iHbp1SnMN8RE_-8XHg3d-ug>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Feb 2022 06:34:21 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     hauke@hauke-m.de, mcgrof@kernel.org
Cc:     backports@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 0/6] backports: Backport some ath11k runtime dependencies
Date:   Mon,  7 Feb 2022 11:33:31 +0000
Message-Id: <20220207113338.214748-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Backport mhi bus driver and QRTR driver.
ath11k requires them aligned with latest version at runtime.

Thanks.

v2: Make ath11k depend on 5.2 (hauke)

Jiaxun Yang (7):
  headers: Add MHI stuff to mod_devicetable
  backports: Add mhi bus driver
  backports: backport {get,set}_user_ifreq
  headers: backport sk_error_report
  backports: Add QRTR driver
  dependencies: Limit ATH11K to 5.2+
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
 dependencies                                  |  9 ++++
 12 files changed, 113 insertions(+), 1 deletion(-)
 create mode 100644 backport/compat/backport-5.15.c
 create mode 100644 backport/defconfigs/ath11k

-- 
2.35.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
