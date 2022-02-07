Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61766C433FE
	for <backports@archiver.kernel.org>; Mon,  7 Feb 2022 12:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344192AbiBGMsB (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 7 Feb 2022 07:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386393AbiBGLed (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 7 Feb 2022 06:34:33 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE90C043181
        for <backports@vger.kernel.org>; Mon,  7 Feb 2022 03:34:32 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 901813202B3D;
        Mon,  7 Feb 2022 06:34:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 07 Feb 2022 06:34:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=QbBztW1BMIWXgmpM3Lg+Qmk+pywiOu
        FOEucjpChalLs=; b=xzYlQrGzlFYskcSlZr0kp5jHN5A4CMki3dNbOG0i+EJFlT
        MQjD4QpB3jcD0KVR/I2LggeJ0jpDFraqNgesAtjNRro+351uYecknfTlyzCciaIk
        5pvBdnYF/5XFFgHZKTCnE55xBIKnhxESq2Etg4VjcQNnge0fKCHuhnKQpMjnM16K
        9OIwNvIb49fJzDlea3+TBduLQDPDpr+E5i8O9aIpvtT8EHnxpJSF12QdfcOnfsE2
        85E8GguEp5GuGk8aTGRj8veiGO6ibVtCFwjO3JesJr7IQZKvgNhP/RHEOZA7y5Iw
        +JJPMQSW2lWMvO782vY0qbipgrsS/+a2JdU8p5cQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=QbBztW
        1BMIWXgmpM3Lg+Qmk+pywiOuFOEucjpChalLs=; b=nB1I2Pbj7eLxbey1wy4X4I
        PrlX8oh45hI3nHl+gUTW4QmTG+FA/UFPauoTQg93RUARp7wSrUy+18XahqLajqWs
        HFFuuYtEYprEZ/FW0jldAvwPw4t4PmoR5BZSfjmnv850HbV87OxLk025rcnWOI/c
        2nbxWBdiWbMzLpavS8Nk2M+0mb5/RBuUPZ+H/A2ygJkihT8l1O1Ql6wBeUz+yZQf
        HiwBjCzHJQP5/Go6G5l1kVayoJujcEl1kPO8xx3VlmpC74RA/pj2yA6sSOsk8LTx
        fU7j3RkcQCmK9D3HkwoLcXgSj8SRh/kxrlz8muBa3Q0AzZS19yrRktRS5VmzPTEA
        ==
X-ME-Sender: <xms:xwMBYhEbsWdr9o_QeHTaeggKGfuKRHVY5DsnhAds8KSLrUEsZuKiYg>
    <xme:xwMBYmXoWz64nwJ7igXxuItJMeasiqVtD7rcH1GVQueoOFvpX1jlSqHjsRq9D_H13
    xPCpz9COEjjSbP37dQ>
X-ME-Received: <xmr:xwMBYjIJaeqZJXBo0jqqLJSDTy7B1kVlabnfh7j2GAWqTI8sHnn9ttI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheehgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeeihffgteelkeelffduke
    dtheevudejvdegkeekjeefhffhhfetudetgfdtffeunecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgoh
    grthdrtghomh
X-ME-Proxy: <xmx:xwMBYnFC90fEkziPmgMlnEVQvifV1IaK9gRmbeag2_Z14uI4DsWCoQ>
    <xmx:xwMBYnWUaETj_odY4IGQiN_QTjSbIuzoBBz_bArJyyYlCE1n-gwzaA>
    <xmx:xwMBYiPwqugJMOS0EaMePLDviq8kN5uhVRZhDtQVuPT4E-qPeh_xUQ>
    <xmx:xwMBYkjbY6JKgEnfibPnc6jKh43UGxVvnR4OmO6dTlcES_5lazHWtg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Feb 2022 06:34:30 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     hauke@hauke-m.de, mcgrof@kernel.org
Cc:     backports@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 4/7] headers: backport sk_error_report
Date:   Mon,  7 Feb 2022 11:33:35 +0000
Message-Id: <20220207113338.214748-5-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220207113338.214748-1-jiaxun.yang@flygoat.com>
References: <20220207113338.214748-1-jiaxun.yang@flygoat.com>
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
