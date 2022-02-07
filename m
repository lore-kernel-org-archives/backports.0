Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6EAC43219
	for <backports@archiver.kernel.org>; Mon,  7 Feb 2022 12:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379754AbiBGMsL (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 7 Feb 2022 07:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386424AbiBGLeg (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 7 Feb 2022 06:34:36 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDE2C043181
        for <backports@vger.kernel.org>; Mon,  7 Feb 2022 03:34:36 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id AA8A03202B08;
        Mon,  7 Feb 2022 06:34:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 07 Feb 2022 06:34:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=wQHq4INW6ODXPFsx1XJEP46yhG8iod
        y+wOEDkm7Yx7I=; b=1YmFvnttW2Awz1sZDdu6psFJHPXSQZnGjCySd9s8o7wLUx
        oZwkz/i99HxIxV5v1rKbaBkw1hzV5gc+bAZlSxs4uWIkjeEoclMVhATn5c0qm7ii
        8WrYi7YgtsEPxofqdjPawpk3dUy5N1smZuLhBsKmCg2kM6+EB0rF59wKdUbiu03h
        4xDtYtASv/kijTysHKwO3G6AZhJVsn49hM9FB/C+tWvqUO4bT5Xqdwm/sRQ1u4Ff
        g80pn6rBNS8lZ7QTcZ484izuMl4KuViOLOTLhh7t8ekde1W6CeuhGbIun3mgN6rn
        AOUXzrsDYo30wXwAKbGeJFIwLypHWuiZLMLpy+zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=wQHq4I
        NW6ODXPFsx1XJEP46yhG8iody+wOEDkm7Yx7I=; b=WO0NmmGPfIv7I1YQRm3yqH
        ILhj9MLLafjNy9tGpZ7a1bn9PzeaUvCdimWV00VUyzE1UA0laKj74zzBQ1dFsMkt
        DFl3elIlRMkYubI3p/S+Tguttk7FspsovsB+SyARJ84Z/mnU8hDD3KyAnchJccuK
        kiWUt6Kd+9vxpAI755xVBRJAtodu/iiWFUXEqKpjS0DSJ6VUinqoMiJFo2Nd6xGa
        BhwsQ9TmGtFTWau24jvV2lBQdJzvz9oGiasf66YTP4G14hHfZMbyyKi1Lm86bWpA
        jFlMwtYTMc8CMjeB0CkcisraJU46XsChLJhXACCidVSRmy0ekt6pQSXxSyqJIUTg
        ==
X-ME-Sender: <xms:ywMBYo_X8SCHfM1w8B2MJ9YWsI1ErS9RNyrEkKh2m4ua4cE6z8w7BQ>
    <xme:ywMBYgtebVBTvAe4o2sykRi4kyPVxqK3T8OlAIzWA6p0Ip6yQdSucU_0kWK-dmzvC
    VDDu2JPPOwtFEYptF8>
X-ME-Received: <xmr:ywMBYuBEk7QHo9-Gh28MG1Yvlt0VusQlwgoUDhi1s3-aIvufNsTfCA4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheehgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeeihffgteelkeelffduke
    dtheevudejvdegkeekjeefhffhhfetudetgfdtffeunecuvehluhhsthgvrhfuihiivgep
    udenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgoh
    grthdrtghomh
X-ME-Proxy: <xmx:ywMBYof_-DW_0iN8xFMLVmlAjfOjGmQudFHp_19LOXgn0obW_08YBQ>
    <xmx:ywMBYtPaT4_UV26Um8P4GDc7hjMlHiNqwDrZY9uiW8MrU4Mkj9dfvQ>
    <xmx:ywMBYilaBPk9unKO-8ytGcYCLaY8yIXLl8sy12rX40sEiL5SJWk5jw>
    <xmx:ywMBYmZPfnwi-l68YC9NmwdOkC78W9neM6QtKClJtld67PZA7St4_g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Feb 2022 06:34:34 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     hauke@hauke-m.de, mcgrof@kernel.org
Cc:     backports@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 6/7] dependencies: Limit ATH11K to 5.2+
Date:   Mon,  7 Feb 2022 11:33:37 +0000
Message-Id: <20220207113338.214748-7-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220207113338.214748-1-jiaxun.yang@flygoat.com>
References: <20220207113338.214748-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

As it's runtime dependency QRTR requires 5.2+.

Suggested-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 dependencies | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dependencies b/dependencies
index 5de1bbe1..5bb9c563 100644
--- a/dependencies
+++ b/dependencies
@@ -43,3 +43,6 @@ MHI_BUS 4.19
 
 # sock_gettstamp()
 QRTR 5.2
+
+# QRTR
+ATH11K 5.2
-- 
2.35.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
