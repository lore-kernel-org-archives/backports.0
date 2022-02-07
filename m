Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F865C433F5
	for <backports@archiver.kernel.org>; Mon,  7 Feb 2022 12:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237728AbiBGMsD (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 7 Feb 2022 07:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386441AbiBGLej (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 7 Feb 2022 06:34:39 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F86C043189
        for <backports@vger.kernel.org>; Mon,  7 Feb 2022 03:34:38 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id DF8D632027A7;
        Mon,  7 Feb 2022 06:34:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 07 Feb 2022 06:34:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=gJFDttsg6PwCMwcFuyciI7AGWQUwzu
        2HuP/zOpmnjQg=; b=2KByavI5FxUiRdqa9Az7sjYFRWOYJZ31GcMaMMY5GvQAgA
        fAoeoYA39csKYcpR1vOkS0365LGBLryxJYswRx7t2iib53lysxKVrKISgnGCulWz
        WNeNlX3yNvcItFt3KKZ5sHgKJvA+gf5yfMujVuUKnsQj53LbzR3WHykdRPLphn8N
        HQCtkzsXD0inFXsZGOGkSQ7sE+JjUuaUKdyzj1Wv4hbL88uxPzFWZ68AeJehOxBo
        n+bSjbfzKsaJyLRPVnYl2z3C5JtVAhrSxGYPYwBd6Es+zKmfooTj3eEvOuRb5+iK
        9XvCPn3GKRyOlq0QRyZakYHoxM9M+LZBuOkCO9Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=gJFDtt
        sg6PwCMwcFuyciI7AGWQUwzu2HuP/zOpmnjQg=; b=Jn1ItUhNf2eeMY+UD6EHmp
        utWeLlhEq7KRb+2bPl+nJFroeidUXDMihulExEwztn0AXe/4GqRwf19EwJ6CXWR6
        hjdAUSazMyUJ24DffSUcDZZSrqdZgMhCh1q4Evz0LIhd7qbA1GH9sVLFXtVCNAGw
        BHn1yEWLymWFAjEepbyQSzGuH8VZmIibSLFHDXlATR+CjOpXLsuzF0qzeEV1For9
        IrC++f+7NE90IA1xTEvU95uMFaMHEbeTcfM0YSTPfGHoMUcg/eLVlEv2s4jl3KzL
        Sqdu3Tmn4U6w91wbbc18SEXgzIcWKZEl3sJpDErrMBKay15Z5t2TMbLfvGTBfixw
        ==
X-ME-Sender: <xms:zQMBYu38MGWyKg5vBAkqY8oHporjXw_TfU8Cxi-_p0lj6yd1ZMDxEQ>
    <xme:zQMBYhG7ihHkZ5H5_pOR2F0d6_owkWXDSuHCa2cu6fbdod4Pd3lCrmOfodDVs18Yl
    6pAt3gDlEYcRzl30qk>
X-ME-Received: <xmr:zQMBYm5EL0XN_OwPvgCUyOorXQ-Foke0V-J53VyZhwP3UcGFZ138E3U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheehgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeeihffgteelkeelffduke
    dtheevudejvdegkeekjeefhffhhfetudetgfdtffeunecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgoh
    grthdrtghomh
X-ME-Proxy: <xmx:zQMBYv1i5qrWuMHcT-mw1jPmXB43kDBNWm3jSFJaUSlgrvXvQS3QkA>
    <xmx:zQMBYhE4h6Sb9gHwxmFal6Pu68xOBGeVOJbdI0PxR6EAMJengbEjgQ>
    <xmx:zQMBYo_BhHi-gQLAQgTRuwE2ulVMqIH_nhiS7IOoaLeLoTeHw0axFQ>
    <xmx:zQMBYmTWgJf_19Qy5H5OehzDEKgPJJkoNZdJP2gsV7r7eumrLS0Mrw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Feb 2022 06:34:36 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     hauke@hauke-m.de, mcgrof@kernel.org
Cc:     backports@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 7/7] defconfigs: Refresh for ath11k
Date:   Mon,  7 Feb 2022 11:33:38 +0000
Message-Id: <20220207113338.214748-8-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220207113338.214748-1-jiaxun.yang@flygoat.com>
References: <20220207113338.214748-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Add defconfig for ath11k, also add ath11k runtime dependencies to
wifi defconfig.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 backport/defconfigs/ath11k | 14 ++++++++++++++
 backport/defconfigs/wifi   |  3 +++
 2 files changed, 17 insertions(+)
 create mode 100644 backport/defconfigs/ath11k

diff --git a/backport/defconfigs/ath11k b/backport/defconfigs/ath11k
new file mode 100644
index 00000000..9ca4b310
--- /dev/null
+++ b/backport/defconfigs/ath11k
@@ -0,0 +1,14 @@
+CPTCFG_MHI_BUS=m
+CPTCFG_QRTR=m
+CPTCFG_QRTR_MHI=m
+CPTCFG_CFG80211=m
+CPTCFG_CFG80211_WEXT=y
+CPTCFG_MAC80211=m
+CPTCFG_MAC80211_LEDS=y
+CPTCFG_MAC80211_MESH=y
+CPTCFG_WLAN=y
+CPTCFG_WLAN_VENDOR_ATH=y
+CPTCFG_ATH11K_PCI=m
+CPTCFG_ATH11K=m
+CPTCFG_ATH11K_DEBUG=y
+CPTCFG_ATH11K_DEBUGFS=y
diff --git a/backport/defconfigs/wifi b/backport/defconfigs/wifi
index 936203d9..774b0823 100644
--- a/backport/defconfigs/wifi
+++ b/backport/defconfigs/wifi
@@ -58,6 +58,7 @@ CPTCFG_MAC80211_HWSIM=m
 CPTCFG_MAC80211_LEDS=y
 CPTCFG_MAC80211=m
 CPTCFG_MAC80211_MESH=y
+CPTCFG_MHI_BUS=m
 CPTCFG_MT7601U=m
 CPTCFG_MT7603E=m
 CPTCFG_MT7615E=m
@@ -86,6 +87,8 @@ CPTCFG_PCMCIA_ATMEL=m
 CPTCFG_PCMCIA_HERMES=m
 CPTCFG_PCMCIA_SPECTRUM=m
 CPTCFG_PLX_HERMES=m
+CPTCFG_QRTR=m
+CPTCFG_QRTR_MHI=m
 CPTCFG_QTNFMAC_PCIE=m
 CPTCFG_R8188EU=m
 CPTCFG_RSI_91X=m
-- 
2.35.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
