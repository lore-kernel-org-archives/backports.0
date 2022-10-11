Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141E5C4321E
	for <backports@archiver.kernel.org>; Tue, 11 Oct 2022 21:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJKVFM (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiJKVFA (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 11 Oct 2022 17:05:00 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB643240AA
        for <backports@vger.kernel.org>; Tue, 11 Oct 2022 14:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Pra0M2GZvkjUVoyuaWFXoJIsZwMr0W3mLGKQijSV4Ko=;
        t=1665522295; x=1666731895; b=M+MjYWBspMgd/DefCaph12Gt8sAPCptln4h3Csq7TQEPQb7
        TN9OfR8qW+ODrYR7Z7j/0vggcWjvfy6/5SnClyjJzqCSTtslLoYC1pCI4c9/YcpScvIxjiuJvh1uK
        5bdzZxIZAfKXecjfkcYTjI1/qugVgzDAdh3Veip6Pvcz/YGhD+6PaRSsCFBOEmEG/w/pwnrtHulVB
        GlI97IF/+zXKqvONZet+2B2w2lTjNY3gpXEarmRDmFMpdMUbIAaiZb7h96hdVMcsullvc0+9eKa6t
        ASrBXqc9LBcrXeH0a9T2xIweELT3ImqV9uAV6toIDMRuFtwDEtUT+EFlYlzoyBZA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oiMQn-0045LP-2Z;
        Tue, 11 Oct 2022 23:04:53 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     nbd@nbd.name, Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 18/38] backports: update x509.asn1.[ch]
Date:   Tue, 11 Oct 2022 23:04:26 +0200
Message-Id: <20221011230356.c821b5ac8818.I6785155fcf6c1b377312eb2fdabae3b422cc17ca@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011210446.144768-1-johannes@sipsolutions.net>
References: <20221011210446.144768-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

In v5.18-rc1 a few functions were renamed:
x509_note_pkey_algo() => x509_note_sig_algo()
algo_oid => sig_algo

Adjust for this change.

type=maint
ticket=none

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 backport/compat/verification/x509.asn1.c | 10 +++++-----
 backport/compat/verification/x509.asn1.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/backport/compat/verification/x509.asn1.c b/backport/compat/verification/x509.asn1.c
index e68864b6a1f5..590154e21da2 100644
--- a/backport/compat/verification/x509.asn1.c
+++ b/backport/compat/verification/x509.asn1.c
@@ -14,8 +14,8 @@ enum x509_actions {
 	ACT_x509_note_not_after = 4,
 	ACT_x509_note_not_before = 5,
 	ACT_x509_note_params = 6,
-	ACT_x509_note_pkey_algo = 7,
-	ACT_x509_note_serial = 8,
+	ACT_x509_note_serial = 7,
+	ACT_x509_note_sig_algo = 8,
 	ACT_x509_note_signature = 9,
 	ACT_x509_note_subject = 10,
 	ACT_x509_note_tbs_certificate = 11,
@@ -31,8 +31,8 @@ static const asn1_action_t x509_action_table[NR__x509_actions] = {
 	[   4] = x509_note_not_after,
 	[   5] = x509_note_not_before,
 	[   6] = x509_note_params,
-	[   7] = x509_note_pkey_algo,
-	[   8] = x509_note_serial,
+	[   7] = x509_note_serial,
+	[   8] = x509_note_sig_algo,
 	[   9] = x509_note_signature,
 	[  10] = x509_note_subject,
 	[  11] = x509_note_tbs_certificate,
@@ -59,7 +59,7 @@ static const unsigned char x509_machine[] = {
 	[  12] =   _tag(UNIV, CONS, SEQ),
 	[  13] =   _jump_target(74),		// --> AlgorithmIdentifier
 	[  14] =   ASN1_OP_ACT,
-	[  15] =   _action(ACT_x509_note_pkey_algo),
+	[  15] =   _action(ACT_x509_note_sig_algo),
 	// Name
 	[  16] =   ASN1_OP_MATCH_JUMP,
 	[  17] =   _tag(UNIV, CONS, SEQ),
diff --git a/backport/compat/verification/x509.asn1.h b/backport/compat/verification/x509.asn1.h
index 77ec6085ae75..10648630ade4 100644
--- a/backport/compat/verification/x509.asn1.h
+++ b/backport/compat/verification/x509.asn1.h
@@ -14,8 +14,8 @@ extern int x509_note_issuer(void *, size_t, unsigned char, const void *, size_t)
 extern int x509_note_not_after(void *, size_t, unsigned char, const void *, size_t);
 extern int x509_note_not_before(void *, size_t, unsigned char, const void *, size_t);
 extern int x509_note_params(void *, size_t, unsigned char, const void *, size_t);
-extern int x509_note_pkey_algo(void *, size_t, unsigned char, const void *, size_t);
 extern int x509_note_serial(void *, size_t, unsigned char, const void *, size_t);
+extern int x509_note_sig_algo(void *, size_t, unsigned char, const void *, size_t);
 extern int x509_note_signature(void *, size_t, unsigned char, const void *, size_t);
 extern int x509_note_subject(void *, size_t, unsigned char, const void *, size_t);
 extern int x509_note_tbs_certificate(void *, size_t, unsigned char, const void *, size_t);
-- 
2.37.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
