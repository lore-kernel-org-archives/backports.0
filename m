Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DFB12C47A
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570614; cv=none; b=bCwJQcsTj/yefy59I2y+6ixgv5ryyl8vLlxRIDR9TFTDBjyQfMgdqWnYLg4av6hX08tMWbl9oW22ZM2L3kADP1bw5YELkP2CSkHknep7TCc5PMHh9CMIdEDRcuqW6wYk9+J5yHnlS7dUgolCCQcJvmLE8Cvw6nBalWkm2eSWuK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570614; c=relaxed/simple;
	bh=UN/f0fIsuNvOLyZ6Z+2YDXPzoQCNv5zgFXL8lBL5zEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AnSiSoSQafiHtrJQ4uXWKHdZMkboW3sCoRJRj3gqphn8kjhVGFirJ4Wth1g26Ax5JU2CDlxzM57DlinPJ6tXtEVjR+LL2MUVrh5idV6MutQ2UePC8uzzmBWUygLw2p8DnBhKTPbeBei1lkTZWcwoBFjex6ZfPrE71WPEMMFIx78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=rTy/2lrq; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="rTy/2lrq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=h88yLeRC3DtfWUgpIg/gKyj2W6ais/BgeODHPzyZdYU=;
	t=1716570613; x=1717780213; b=rTy/2lrqwxsGQmennbSbVrvxHbqnC5eXS65lKjKeu+tRFAm
	EfaKxDPh5omBLhWPLsMZlFTIXOyhKp+hKrdOOAhLZ8f9CJQFsvh7hflhb2Rc4hxd5QoufRfsSdhWV
	OBpxDsi6mrMcmAYDXSrnIqW2MKBvkTthu5XZcMkH8bM7BILCg/+TDZkKE65WLCoaCDztsdvII3pR5
	6tlXHrAtj6ZnlyePPt0mVWuYfZbH0Mcvyfj9c85CZejHAbo+aP0Qzcfr9tpVnVAYJy8YurJFBJTps
	GsZZ8TEyUpLnkFevuFSwuTdtmOX/TtTcfI6IV39Vgm9RZ4NnGzY4oXaXvZ1UwGKQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQk-00000008Xuw-2ydL;
	Fri, 24 May 2024 19:10:11 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 58/74] backports: update x509.asn1.[ch]
Date: Fri, 24 May 2024 19:08:10 +0200
Message-ID: <20240524190907.930613172730.I6785155fcf6c1b377312eb2fdabae3b422cc17ca@changeid>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524170906.54680-76-johannes@sipsolutions.net>
References: <20240524170906.54680-76-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gregory Greenman <gregory.greenman@intel.com>

In v5.18-rc1 a few functions were renamed:
x509_note_pkey_algo() => x509_note_sig_algo()
algo_oid => sig_algo

Adjust for this change.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
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
2.45.1

