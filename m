Return-Path: <SRS0=7Ax0=OL=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9FEC65BB3
	for <backports@archiver.kernel.org>; Sun,  2 Dec 2018 11:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61022082F
	for <backports@archiver.kernel.org>; Sun,  2 Dec 2018 11:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D61022082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=backports-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbeLBLxA (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 2 Dec 2018 06:53:00 -0500
Received: from mx2.mailbox.org ([80.241.60.215]:41308 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbeLBLw7 (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 2 Dec 2018 06:52:59 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 2D102A115A;
        Sun,  2 Dec 2018 12:52:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id S8C8jtPXoJqL; Sun,  2 Dec 2018 12:52:55 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     johannes@sipsolutions.net
Cc:     backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 10/12] backports: Remove unused code from backport-public_key.h
Date:   Sun,  2 Dec 2018 12:52:24 +0100
Message-Id: <20181202115226.3594-11-hauke@hauke-m.de>
In-Reply-To: <20181202115226.3594-1-hauke@hauke-m.de>
References: <20181202115226.3594-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

These functions declared in backport-public_key.h are not implemented in
backports, and they were causing warnings because kernel_pkey_params was
not declared before.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/verify.patch | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/patches/verify.patch b/patches/verify.patch
index 791de881..d52b7ce4 100644
--- a/patches/verify.patch
+++ b/patches/verify.patch
@@ -62,3 +62,40 @@
  struct x509_certificate {
  	struct x509_certificate *next;
  	struct x509_certificate *signer;	/* Certificate that signed this one */
+--- a/include/crypto/backport-public_key.h
++++ b/include/crypto/backport-public_key.h
+@@ -50,34 +50,6 @@ extern void public_key_signature_free(st
+ 
+ extern struct asymmetric_key_subtype public_key_subtype;
+ 
+-struct key;
+-struct key_type;
+-union key_payload;
+-
+-extern int restrict_link_by_signature(struct key *dest_keyring,
+-				      const struct key_type *type,
+-				      const union key_payload *payload,
+-				      struct key *trust_keyring);
+-
+-extern int restrict_link_by_key_or_keyring(struct key *dest_keyring,
+-					   const struct key_type *type,
+-					   const union key_payload *payload,
+-					   struct key *trusted);
+-
+-extern int restrict_link_by_key_or_keyring_chain(struct key *trust_keyring,
+-						 const struct key_type *type,
+-						 const union key_payload *payload,
+-						 struct key *trusted);
+-
+-extern int query_asymmetric_key(const struct kernel_pkey_params *,
+-				struct kernel_pkey_query *);
+-
+-extern int encrypt_blob(struct kernel_pkey_params *, const void *, void *);
+-extern int decrypt_blob(struct kernel_pkey_params *, const void *, void *);
+-extern int create_signature(struct kernel_pkey_params *, const void *, void *);
+-extern int verify_signature(const struct key *,
+-			    const struct public_key_signature *);
+-
+ int public_key_verify_signature(const struct public_key *pkey,
+ 				const struct public_key_signature *sig);
+ 
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
