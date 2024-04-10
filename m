Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C89190670
	for <backports@vger.kernel.org>; Wed, 10 Apr 2024 22:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712788114; cv=none; b=sAgyvdYjEso1stcaP/bpe3qS9ZBDB6fV0mDCjBMxv/VfsJDvCQbGuRfmI7fy1c+9A39Z/PndLcrCLcajY+E4yJdQ0kkJMqDflqGzXqava9GO7z+khKJfQMCD5FLwdEx/4JQzfhHydRJJbZgskgLh2fLFEX0hq6PwY2U2gGp0Mk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712788114; c=relaxed/simple;
	bh=Mk48qt7aFgR+ADo2wSGHZRqHmSLcF2xN6a3+RCL+lV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/688hSs3umHZKok3aEPt5kBAzMXuE4aTmsyXz9tsQ6VrF2fMfEDmn0wsQvucVnOZ+8XYFbLgL3rxtH+0ZQjBWc85e5uyqnxON4/CZ8kC1dM+WaUpx1RJSYnwacC6BHwJEc3jKQ141p4k6gIvSGeS3N3Ud1cls0w/1f7ftMqtPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=IepOXQcD; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="IepOXQcD"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4VFHMT2ztFz9tKg;
	Thu, 11 Apr 2024 00:20:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1712787621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5kTkl9amQMmWjJTNryYbD/Bszqltvp2QDrQhYWLesG0=;
	b=IepOXQcDmqnbLCHonjpyXAZd8v6cUCAL7hY2+7zp38MRnJjl++2Zbaj+L8LsDqskecIGCb
	nJHFc4pMxMIif4oWEdLOrW/zL8H6uu/EW3QCWuneM+nCK31P/JSejmwGehegIk+2yWU0WM
	AazNOmziK1HyuTsZJObb7VEPvILd5d6G6FmfVxrIlncRiYNRcxUmwdzXdDOpDnR5IrZSST
	vjGqoGiig8GwcnE18asGac7lE+nOQGju0pMDc8wwbEi8eVbVWyO4Iv4g8D76tu1RayCHuB
	Vok5opG1XBpdon/Jc96TzKN/Ld019d2EOwCKow63pw7yci0W24bejapjH+NhkQ==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/6] backports: Remove compat/memneq.c
Date: Thu, 11 Apr 2024 00:20:03 +0200
Message-ID: <20240410222010.1171249-5-hauke@hauke-m.de>
In-Reply-To: <20240410222010.1171249-1-hauke@hauke-m.de>
References: <20240410222010.1171249-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4VFHMT2ztFz9tKg

This was used in backports for kernel 3.13 which was removed long time
ago.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 copy-list       | 3 ---
 copy-list.hwsim | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/copy-list b/copy-list
index 30368c81..95a9b875 100644
--- a/copy-list
+++ b/copy-list
@@ -25,9 +25,6 @@ include/linux/average.h
 include/linux/overflow.h
 include/linux/units.h
 
-# crypto_memneq
-lib/memneq.c -> compat/memneq.c
-
 # 802.11
 drivers/net/wireless/Kconfig
 drivers/net/wireless/Makefile
diff --git a/copy-list.hwsim b/copy-list.hwsim
index b1b00bcc..cb013917 100644
--- a/copy-list.hwsim
+++ b/copy-list.hwsim
@@ -24,9 +24,6 @@ include/linux/bitfield.h
 include/linux/average.h
 include/linux/overflow.h
 
-# crypto_memneq
-lib/memneq.c -> compat/memneq.c
-
 # 802.11
 drivers/net/wireless/Kconfig
 drivers/net/wireless/Makefile
-- 
2.44.0

