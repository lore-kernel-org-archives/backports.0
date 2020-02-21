Return-Path: <SRS0=6Pme=4J=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB6AC35644
	for <backports@archiver.kernel.org>; Fri, 21 Feb 2020 08:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ADF92071E
	for <backports@archiver.kernel.org>; Fri, 21 Feb 2020 08:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730752AbgBUI4e (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:56:34 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:54702 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730355AbgBUI4e (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 21 Feb 2020 03:56:34 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j546p-00EncU-IY; Fri, 21 Feb 2020 09:56:31 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 02/15] backports: update x509.asn1.[ch]
Date:   Fri, 21 Feb 2020 09:56:11 +0100
Message-Id: <20200221095437.fcc31f62d6cf.I268b63a7ca56b448e4a0ae8e2f4293561342648d@changeid>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200221085624.6213-1-johannes@sipsolutions.net>
References: <20200221085624.6213-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

In v5.2, x509_cert_parser.c implemented a new function,
x509_note_params().  So we need the new generated asn1 files.  Update
these files from the ones generated with v5.2

type=maint
ticket=jira:WIFI-25529

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/compat/verification/x509.asn1.c | 105 ++++++++++++-----------
 backport/compat/verification/x509.asn1.h |   1 +
 2 files changed, 55 insertions(+), 51 deletions(-)

diff --git a/backport/compat/verification/x509.asn1.c b/backport/compat/verification/x509.asn1.c
index 316c10e3267f..e68864b6a1f5 100644
--- a/backport/compat/verification/x509.asn1.c
+++ b/backport/compat/verification/x509.asn1.c
@@ -13,13 +13,14 @@ enum x509_actions {
 	ACT_x509_note_issuer = 3,
 	ACT_x509_note_not_after = 4,
 	ACT_x509_note_not_before = 5,
-	ACT_x509_note_pkey_algo = 6,
-	ACT_x509_note_serial = 7,
-	ACT_x509_note_signature = 8,
-	ACT_x509_note_subject = 9,
-	ACT_x509_note_tbs_certificate = 10,
-	ACT_x509_process_extension = 11,
-	NR__x509_actions = 12
+	ACT_x509_note_params = 6,
+	ACT_x509_note_pkey_algo = 7,
+	ACT_x509_note_serial = 8,
+	ACT_x509_note_signature = 9,
+	ACT_x509_note_subject = 10,
+	ACT_x509_note_tbs_certificate = 11,
+	ACT_x509_process_extension = 12,
+	NR__x509_actions = 13
 };
 
 static const asn1_action_t x509_action_table[NR__x509_actions] = {
@@ -29,12 +30,13 @@ static const asn1_action_t x509_action_table[NR__x509_actions] = {
 	[   3] = x509_note_issuer,
 	[   4] = x509_note_not_after,
 	[   5] = x509_note_not_before,
-	[   6] = x509_note_pkey_algo,
-	[   7] = x509_note_serial,
-	[   8] = x509_note_signature,
-	[   9] = x509_note_subject,
-	[  10] = x509_note_tbs_certificate,
-	[  11] = x509_process_extension,
+	[   6] = x509_note_params,
+	[   7] = x509_note_pkey_algo,
+	[   8] = x509_note_serial,
+	[   9] = x509_note_signature,
+	[  10] = x509_note_subject,
+	[  11] = x509_note_tbs_certificate,
+	[  12] = x509_process_extension,
 };
 
 static const unsigned char x509_machine[] = {
@@ -61,7 +63,7 @@ static const unsigned char x509_machine[] = {
 	// Name
 	[  16] =   ASN1_OP_MATCH_JUMP,
 	[  17] =   _tag(UNIV, CONS, SEQ),
-	[  18] =   _jump_target(80),		// --> Name
+	[  18] =   _jump_target(81),		// --> Name
 	[  19] =   ASN1_OP_ACT,
 	[  20] =   _action(ACT_x509_note_issuer),
 	// Validity
@@ -87,7 +89,7 @@ static const unsigned char x509_machine[] = {
 	// Name
 	[  38] =   ASN1_OP_MATCH_JUMP,
 	[  39] =   _tag(UNIV, CONS, SEQ),
-	[  40] =   _jump_target(80),		// --> Name
+	[  40] =   _jump_target(81),		// --> Name
 	[  41] =   ASN1_OP_ACT,
 	[  42] =   _action(ACT_x509_note_subject),
 	// SubjectPublicKeyInfo
@@ -109,7 +111,7 @@ static const unsigned char x509_machine[] = {
 	[  55] =   _tagn(CONT, PRIM,  2),
 	[  56] =   ASN1_OP_MATCH_JUMP_OR_SKIP,		// extensions
 	[  57] =   _tagn(CONT, CONS,  3),
-	[  58] =   _jump_target(95),
+	[  58] =   _jump_target(96),
 	[  59] =  ASN1_OP_END_SEQ,
 	[  60] =  ASN1_OP_ACT,
 	[  61] =  _action(ACT_x509_note_tbs_certificate),
@@ -132,47 +134,48 @@ static const unsigned char x509_machine[] = {
 	[  74] =  ASN1_OP_MATCH_ACT,		// algorithm
 	[  75] =  _tag(UNIV, PRIM, OID),
 	[  76] =  _action(ACT_x509_note_OID),
-	[  77] =  ASN1_OP_MATCH_ANY_OR_SKIP,		// parameters
-	[  78] = ASN1_OP_END_SEQ,
-	[  79] = ASN1_OP_RETURN,
+	[  77] =  ASN1_OP_MATCH_ANY_ACT_OR_SKIP,		// parameters
+	[  78] =  _action(ACT_x509_note_params),
+	[  79] = ASN1_OP_END_SEQ,
+	[  80] = ASN1_OP_RETURN,
 
 	// RelativeDistinguishedName
-	[  80] =  ASN1_OP_MATCH,
-	[  81] =  _tag(UNIV, CONS, SET),
+	[  81] =  ASN1_OP_MATCH,
+	[  82] =  _tag(UNIV, CONS, SET),
 	// AttributeValueAssertion
-	[  82] =   ASN1_OP_MATCH,
-	[  83] =   _tag(UNIV, CONS, SEQ),
-	[  84] =    ASN1_OP_MATCH_ACT,		// attributeType
-	[  85] =    _tag(UNIV, PRIM, OID),
-	[  86] =    _action(ACT_x509_note_OID),
-	[  87] =    ASN1_OP_MATCH_ANY_ACT,		// attributeValue
-	[  88] =    _action(ACT_x509_extract_name_segment),
-	[  89] =   ASN1_OP_END_SEQ,
-	[  90] =  ASN1_OP_END_SET_OF,
-	[  91] =  _jump_target(82),
-	[  92] = ASN1_OP_END_SEQ_OF,
-	[  93] = _jump_target(80),
-	[  94] = ASN1_OP_RETURN,
+	[  83] =   ASN1_OP_MATCH,
+	[  84] =   _tag(UNIV, CONS, SEQ),
+	[  85] =    ASN1_OP_MATCH_ACT,		// attributeType
+	[  86] =    _tag(UNIV, PRIM, OID),
+	[  87] =    _action(ACT_x509_note_OID),
+	[  88] =    ASN1_OP_MATCH_ANY_ACT,		// attributeValue
+	[  89] =    _action(ACT_x509_extract_name_segment),
+	[  90] =   ASN1_OP_END_SEQ,
+	[  91] =  ASN1_OP_END_SET_OF,
+	[  92] =  _jump_target(83),
+	[  93] = ASN1_OP_END_SEQ_OF,
+	[  94] = _jump_target(81),
+	[  95] = ASN1_OP_RETURN,
 
 	// Extensions
-	[  95] =  ASN1_OP_MATCH,
-	[  96] =  _tag(UNIV, CONS, SEQ),
+	[  96] =  ASN1_OP_MATCH,
+	[  97] =  _tag(UNIV, CONS, SEQ),
 	// Extension
-	[  97] =   ASN1_OP_MATCH,
-	[  98] =   _tag(UNIV, CONS, SEQ),
-	[  99] =    ASN1_OP_MATCH_ACT,		// extnid
-	[ 100] =    _tag(UNIV, PRIM, OID),
-	[ 101] =    _action(ACT_x509_note_OID),
-	[ 102] =    ASN1_OP_MATCH_OR_SKIP,		// critical
-	[ 103] =    _tag(UNIV, PRIM, BOOL),
-	[ 104] =    ASN1_OP_MATCH_ACT,		// extnValue
-	[ 105] =    _tag(UNIV, PRIM, OTS),
-	[ 106] =    _action(ACT_x509_process_extension),
-	[ 107] =   ASN1_OP_END_SEQ,
-	[ 108] =  ASN1_OP_END_SEQ_OF,
-	[ 109] =  _jump_target(97),
-	[ 110] = ASN1_OP_END_SEQ,
-	[ 111] = ASN1_OP_RETURN,
+	[  98] =   ASN1_OP_MATCH,
+	[  99] =   _tag(UNIV, CONS, SEQ),
+	[ 100] =    ASN1_OP_MATCH_ACT,		// extnid
+	[ 101] =    _tag(UNIV, PRIM, OID),
+	[ 102] =    _action(ACT_x509_note_OID),
+	[ 103] =    ASN1_OP_MATCH_OR_SKIP,		// critical
+	[ 104] =    _tag(UNIV, PRIM, BOOL),
+	[ 105] =    ASN1_OP_MATCH_ACT,		// extnValue
+	[ 106] =    _tag(UNIV, PRIM, OTS),
+	[ 107] =    _action(ACT_x509_process_extension),
+	[ 108] =   ASN1_OP_END_SEQ,
+	[ 109] =  ASN1_OP_END_SEQ_OF,
+	[ 110] =  _jump_target(98),
+	[ 111] = ASN1_OP_END_SEQ,
+	[ 112] = ASN1_OP_RETURN,
 };
 
 const struct asn1_decoder x509_decoder = {
diff --git a/backport/compat/verification/x509.asn1.h b/backport/compat/verification/x509.asn1.h
index 4f32a25d6660..77ec6085ae75 100644
--- a/backport/compat/verification/x509.asn1.h
+++ b/backport/compat/verification/x509.asn1.h
@@ -13,6 +13,7 @@ extern int x509_note_OID(void *, size_t, unsigned char, const void *, size_t);
 extern int x509_note_issuer(void *, size_t, unsigned char, const void *, size_t);
 extern int x509_note_not_after(void *, size_t, unsigned char, const void *, size_t);
 extern int x509_note_not_before(void *, size_t, unsigned char, const void *, size_t);
+extern int x509_note_params(void *, size_t, unsigned char, const void *, size_t);
 extern int x509_note_pkey_algo(void *, size_t, unsigned char, const void *, size_t);
 extern int x509_note_serial(void *, size_t, unsigned char, const void *, size_t);
 extern int x509_note_signature(void *, size_t, unsigned char, const void *, size_t);
-- 
2.24.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
