Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1510212E1EB
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570561; cv=none; b=kbIMpH5dP7bay04lA0n/D+pWvPAePksTB+G8qTYUhyBNk3HP1Sl6EFgPnc8sI0jhyRSnlEuMN7ys9yXZvUqO/yp9Nfyu93dQorsoPY1qRhSbUKyiydzNSTvl/39OOKXjIvic1LmySLrXZtZOpmuLzQ7x1/mLyLhsPSsLV4e0ML8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570561; c=relaxed/simple;
	bh=fldVOxqgbzWEEmxA85TJERHVblFPDwmiwo7trohOaPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gvhaPb1k9h5QMo8+/6Dsl6dB4iHUACZmx5F9gzafROaQ2rlinMQsreatGX8N6PBdAXD0tcc7iqtJLSUkexx8m/uvs68z7bnluXduNPCpHdN/I6SeN6j3UqMYQl1x/+0vVbh1R5qdYfTPxlKO9I2/r2kY3KJfKfmrbd6S6wkIzew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=obzg2tGv; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="obzg2tGv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=sa/GArDXrZlHIAA8b8HEzxvkavkYjWTBIWLLIwztPhk=;
	t=1716570559; x=1717780159; b=obzg2tGvK7bpLS9Nb+kSD8NRxfZGxeq6t5kQNLUmFkc2NqH
	ERcsWMtsohgvyGTPMDO/arnUubQqlMtk62SJULizDPGiT5KS24zr7YsAN4/wVlO5apSlzbyVHrXf8
	yaCZzHzUt4D4z4vFkxbkyd2WVj4wX693XQ08py4P/DgX5hQWVOWkS9q/HND8ZkfiNEsZNGnl+iDiX
	yUCqUndNU/VOYztPvJzV87Y8/h63NbvIZRLArRbohr2WoxQVmpmiHtTw9I6qHt/L1g3k8VE1e7LfS
	fayBkzztTmw7qjJ7nlNWnvXPIpXIi5yZR5Q303YIdfmXN7I+Zmkv1/jIPVe+96Og==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYPr-00000008Xuw-3ZdQ;
	Fri, 24 May 2024 19:09:16 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 06/74] backports: add id_2 argument to find_asymmetric_key()
Date: Fri, 24 May 2024 19:07:18 +0200
Message-ID: <20240524190906.599a472c0beb.I0bc338dbb6b1c91bdd54cf656ab41d09f05b8248@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/keys/asymmetric-type.h | 1 +
 backport/compat/verification/key.c               | 1 +
 2 files changed, 2 insertions(+)

diff --git a/backport/backport-include/keys/asymmetric-type.h b/backport/backport-include/keys/asymmetric-type.h
index 5744de9cee0f..35ddd4008c60 100644
--- a/backport/backport-include/keys/asymmetric-type.h
+++ b/backport/backport-include/keys/asymmetric-type.h
@@ -30,6 +30,7 @@ asymmetric_key_generate_id(const void *val_1, size_t len_1,
 extern struct key *find_asymmetric_key(struct key *keyring,
 				       const struct asymmetric_key_id *id_0,
 				       const struct asymmetric_key_id *id_1,
+				       const struct asymmetric_key_id *id_2,
 				       bool partial);
 #endif
 #endif /* __BP_ASYMMETRIC_TYPE_H */
diff --git a/backport/compat/verification/key.c b/backport/compat/verification/key.c
index 329f8b22e41f..f95aca4fca0e 100644
--- a/backport/compat/verification/key.c
+++ b/backport/compat/verification/key.c
@@ -129,6 +129,7 @@ EXPORT_SYMBOL_GPL(bp_key_create_or_update);
 struct key *find_asymmetric_key(struct key *keyring,
 				const struct asymmetric_key_id *id_0,
 				const struct asymmetric_key_id *id_1,
+				const struct asymmetric_key_id *id_2,
 				bool partial)
 {
 	struct key *key;
-- 
2.45.1

