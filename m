Return-Path: <SRS0=zs2H=MO=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1D2C64EB8
	for <backports@archiver.kernel.org>; Tue,  2 Oct 2018 19:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A43206B2
	for <backports@archiver.kernel.org>; Tue,  2 Oct 2018 19:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A43206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=backports-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeJCCR2 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:17:28 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:48348 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbeJCCR2 (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 2 Oct 2018 22:17:28 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1g7QPH-0004o0-5R; Tue, 02 Oct 2018 21:32:31 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 2/6] backports: fix genlmsg_nlhdr() backport
Date:   Tue,  2 Oct 2018 21:32:11 +0200
Message-Id: <20181002193215.399-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181002193215.399-1-johannes@sipsolutions.net>
References: <20181002193215.399-1-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Since 4.15 this no longer takes a family argument, so add that
to the backports instead of trying to work around the family
argument having changed type.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/net/genetlink.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/backport/backport-include/net/genetlink.h b/backport/backport-include/net/genetlink.h
index dfbacbf40723..d80d979ac423 100644
--- a/backport/backport-include/net/genetlink.h
+++ b/backport/backport-include/net/genetlink.h
@@ -60,6 +60,14 @@ static inline void *genl_info_userhdr(struct genl_info *info)
 #endif
 
 #if LINUX_VERSION_IS_LESS(4,15,0)
+#define genlmsg_nlhdr LINUX_BACKPORT(genlmsg_nlhdr)
+static inline struct nlmsghdr *genlmsg_nlhdr(void *user_hdr)
+{
+	return (struct nlmsghdr *)((char *)user_hdr -
+				   GENL_HDRLEN -
+				   NLMSG_HDRLEN);
+}
+
 #ifndef genl_dump_check_consistent
 static inline
 void backport_genl_dump_check_consistent(struct netlink_callback *cb,
@@ -153,8 +161,6 @@ extern void genl_notify(struct sk_buff *skb, struct net *net, u32 pid,
 		    (_fam)->mcgrps[_group].id, _info->nlhdr, _flags)
 #define genlmsg_put(_skb, _pid, _seq, _fam, _flags, _cmd)		\
 	genlmsg_put(_skb, _pid, _seq, &(_fam)->family, _flags, _cmd)
-#define genlmsg_nlhdr(_hdr, _fam)					\
-	genlmsg_nlhdr(_hdr, &(_fam)->family)
 
 #ifndef genlmsg_put_reply /* might already be there from _info override above */
 #define genlmsg_put_reply(_skb, _info, _fam, _flags, _cmd)		\
-- 
2.14.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
