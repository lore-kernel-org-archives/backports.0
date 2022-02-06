Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0254FC433F5
	for <backports@archiver.kernel.org>; Sun,  6 Feb 2022 22:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238398AbiBFW13 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 6 Feb 2022 17:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241442AbiBFW12 (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 6 Feb 2022 17:27:28 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2CAC061348
        for <backports@vger.kernel.org>; Sun,  6 Feb 2022 14:27:27 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id A7CC83200D78;
        Sun,  6 Feb 2022 17:27:26 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 06 Feb 2022 17:27:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=QbBztW1BMIWXgmpM3Lg+Qmk+pywiOu
        FOEucjpChalLs=; b=xMwAyvZKOwEfdmy2vH6V7S197ruEIy/FUgSJFC/2uqUckg
        hm1OkecZRXFiSjNV+x/hDcwlgtXBJq7/6H3cjdpM5b3zhMv92ZjKp2zPTxrkz/nV
        dVGAGP9GGCp+Qh/+ulhs36LWOXDXpI1JvlA5Ze3Bi4owQ7+Ap+gbhGuZXeuj9ONV
        xecbr/0QDPGbHR7jP0wizxx5/dev60pD5G3ern3yv51LYqZAsoNYzWF4hwcxvRmA
        i23bPF0UzLk2sAIGJ2BPqVAz3QHNB3iFs1yPWuBh5pZT/rsOuwzZY8tXc9D45bbh
        fWrB3xNomc7Ef1uhTcx3J8glwvNSzRXtkKopiTBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=QbBztW
        1BMIWXgmpM3Lg+Qmk+pywiOuFOEucjpChalLs=; b=VLgWHbyZUqq1MQTdzLd77m
        UXZskFZIRLsFgF0gEpB9t4uaPcF0WYyi7Ypjnx3k0LDTyMfBoTFemJpArw6BFGSJ
        33BhBcxeWCdbABhWQGvb0bpKPLSYx9xmgDfcU99TOGL3+V8iZ3scjgLmcXPQUyZ0
        CKR8VAvmAogL5ybf5bKjy6+uBTjSaaHYED9Dh6kkZPVWe0RlGQ9fepVPP2EVMYlX
        ucz+mMe0aUiO0/oskVe+hmUc6ND46Z113AXpJxsl3L6wVuTGtSz5txQtOcLSchum
        xtP7crg8VsWb0+EcAU713e+gCl3lHYu1VGBNaPt9x0oHqX0A8zhn41vC2ILDpX1Q
        ==
X-ME-Sender: <xms:TksAYhFds5p7FIE3_5rRW9mswgSe30dGPSOFfG86hA9XND7NErtylg>
    <xme:TksAYmUCntVeAna-UPx73_3hVQ7M-u4hEq74V_UvdMQ5RuNANrGOfGaIMAnQ8rON4
    UV0kWj6jPRq6MD69pY>
X-ME-Received: <xmr:TksAYjIb6qyevrk8JgA8niU6TBvOAkrZTDRiCNlr83mCtRUjRGmYEXE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheefgdduiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeejiefhgfetleekleffud
    ektdehvedujedvgeekkeejfefhhffhtedutefgtdffueenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihgh
    horghtrdgtohhm
X-ME-Proxy: <xmx:TksAYnHsF6f_UHc6nPYFdPk_jUF_PdQY3MUp_bX84u5ps1x2LyHCIw>
    <xmx:TksAYnX2DNYeUBdmhdaG3kDfhJ4nrSLAOWpXtcUD5bo1Cr7QPbz0yw>
    <xmx:TksAYiOqtPNRFaaAESxHASM7CMb4UclYts4SdjO8fjBDFGLjlhZljg>
    <xmx:TksAYkh9cquuK4aNaBtEdTa9ntDK--p0KQq-Kx3YSBj31V6lypMLww>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Feb 2022 17:27:25 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     hauke@hauke-m.de, mcgrof@kernel.org
Cc:     backports@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 4/6] headers: backport sk_error_report
Date:   Sun,  6 Feb 2022 22:26:54 +0000
Message-Id: <20220206222656.210655-5-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220206222656.210655-1-jiaxun.yang@flygoat.com>
References: <20220206222656.210655-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

It is required by QRTR.
Backproted from 5.14 and dropped trace_event part as the event
doesn't exist in earlier versions and it won't have functional
impact.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 backport/backport-include/net/sock.h | 8 ++++++++
 backport/compat/backport-genetlink.c | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/backport/backport-include/net/sock.h b/backport/backport-include/net/sock.h
index d99ef794..06a76aec 100644
--- a/backport/backport-include/net/sock.h
+++ b/backport/backport-include/net/sock.h
@@ -32,4 +32,12 @@ static inline void sk_pacing_shift_update(struct sock *sk, int val)
 }
 #endif /* < 4.16 */
 
+#if LINUX_VERSION_IS_LESS(5,14,0)
+static inline void backport_sk_error_report(struct sock *sk)
+{
+	sk->sk_error_report(sk);
+}
+#define sk_error_report LINUX_BACKPORT(sk_error_report)
+#endif /* <= 5.14 */
+
 #endif /* __BACKPORT_NET_SOCK_H */
diff --git a/backport/compat/backport-genetlink.c b/backport/compat/backport-genetlink.c
index 89cdd9c0..6ba31b6e 100644
--- a/backport/compat/backport-genetlink.c
+++ b/backport/compat/backport-genetlink.c
@@ -86,7 +86,7 @@ static void extack_netlink_ack(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	skb = nlmsg_new(payload + tlvlen, GFP_KERNEL);
 	if (!skb) {
 		NETLINK_CB(in_skb).sk->sk_err = ENOBUFS;
-		NETLINK_CB(in_skb).sk->sk_error_report(NETLINK_CB(in_skb).sk);
+		sk_error_report(NETLINK_CB(in_skb).sk);
 		return;
 	}
 
-- 
2.35.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
