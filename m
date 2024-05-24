Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BC812EBFA
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570611; cv=none; b=LRaywEyQJIA+OxK/xTjJ27UnJycB4jiRQIBRLXzico5invGoZlKisP8KTGdhOC5JtDNbPUUUwnzDB42L8ZKNLF3RhBy6Cn2C8AOQzgWxaZVDXPvEfupFihaUu4QPjSbRfp9dp9QKUDN/Uie2gEFIwu+C7JqFKoVmv3e6XYDJYsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570611; c=relaxed/simple;
	bh=toZ1z/BtLKqi5oNXn/Xv/a/0DrMWLpTu7uD1XNWSRTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqL9IdQl1MLJosnEh9aAkxwTV9YmXNQbwEDaOIJFU+P3QCSTZKflhvIUlVn7gho7RK0oghQcCrzBf8XjKF7Zj3yx5kabQg7yDLtjdw5nXt/AIqOB+W/yP9kmFhQT7Ve28OuJs0XLFwTpCwSlxgdaGdcC5SXhBDb+iV/QFALcgyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ij0D9IuG; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ij0D9IuG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9tV7Mizb3KPc6TPa6k6rgR85OxUdBZP73Ms38pc89UE=;
	t=1716570610; x=1717780210; b=ij0D9IuGB2ynJKRYGqqlnqwMBT7Vr8j1O9Ese9SL3Yk651b
	0OUFCXIc6cjgGI07Pd9GWvMvKqyDjYlvjA4N7aZbYYe4Aroh6lWYT5mY/OyqxVp79GjOCsY7rcdMx
	kX7seP13Jx7k6NT8fM4dFx4VRaxz9UqSBm87rYE9krRRMQUeLIQ4lVR3sBlobX6lB5lR7By7hQJJI
	IN6a3fNY7PZFei52BkCCgNu1RO8anHRxyzg45qQfi9THzwkOdlqDAycaoByV6NVZ6Gf4rr1s5UGQm
	5fylBZoFrve0BemdFNB3mC1Dooa+8u8sNsYILCtGDezo7Bd4asPNy0Ehk6ZEm7gg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQh-00000008Xuw-2PGI;
	Fri, 24 May 2024 19:10:07 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 55/74] backports: fix get_random_u32_below() version
Date: Fri, 24 May 2024 19:08:07 +0200
Message-ID: <20240524190907.c339801c1af2.I04c1d4108a0c85e5fd474af0fd1b3bc0f4127ba4@changeid>
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

This got backported to 6.1.4.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/random.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backport/backport-include/linux/random.h b/backport/backport-include/linux/random.h
index 89e9ce022505..f7a50dbc8dd6 100644
--- a/backport/backport-include/linux/random.h
+++ b/backport/backport-include/linux/random.h
@@ -10,7 +10,7 @@ static inline u16 get_random_u16(void)
 }
 #endif
 
-#if LINUX_VERSION_IS_LESS(6,2,0)
+#if LINUX_VERSION_IS_LESS(6,1,4)
 static inline u32 get_random_u32_below(u32 ceil)
 {
 	return prandom_u32_max(ceil);
-- 
2.45.1

