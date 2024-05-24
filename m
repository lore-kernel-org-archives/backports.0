Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8517612F37F
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570564; cv=none; b=IUViUKyluMwriYWEPKIJGlMeqkah2TOzfx4p7KR3j93V6keKuyVaoeKsr2ltWlYDC18cBMrI0v/1m6Oz5uO1yB2T+ogZu0VAH4FiLLhGLh4Mg7OLp//DwQPhH6D94v8p8utsQ+rsJBmqlT+IvELDSykijTBmR6TrRJA2La+t4qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570564; c=relaxed/simple;
	bh=NXCIinXtGe278Y0K8+qrRgrPglnt+6X5NV6hOBQdtPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ITvDUk5rcK7dgNVri1iiGX/Ks9SPm4xbJTX/2cr1MOitEmr6LBri1mSANJXsdpBCJK2wfG9hAW0aXZec09EVeLLXU6R2aBCiTmJNJODf7DnBd9p0wyPq+Jofs38R9+nUutcjoxtOaYD922i7tQFjjH2a/L9MW4tACn+pBsFJx6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=S8v0VDgf; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="S8v0VDgf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=hfKOzKfTB3zBCEERMBizDuVQmAkNUvhWPfHcAJr9JMM=;
	t=1716570561; x=1717780161; b=S8v0VDgfKFtxOnOLM6ilXHGU3hx8CDQJFyfhASztjOa9L0X
	R4qeIBT2mqK0Bn4NsY3RFOVVEwAhJMnvzv3HmkNGLCKbx3s/4kVh+dIZBcZC/TmqCzgwmM1ifNpIE
	mN7BXLc8Lc+aHtZsz31VXVivBElQf5FSPDIZfcB75ECbobH3N3vYBALvGDqytPmtB2M312xrryboH
	fzzjHBM3ukz9VVMZxfTvQPpgVszRrB8Xb6seFnSQQuDPvQUt8m/IWWJbTeDigXiAg1pEO/Bf1XMXk
	PrpF3GfjncbXenYn5WUm8dEAdWxetj/Zu8gg4MrSnLsQVnTeyhK0uZUdxFKmeAGw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYPp-00000008Xuw-0McH;
	Fri, 24 May 2024 19:09:13 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/74] backport: add v6.* to the Makefile
Date: Fri, 24 May 2024 19:07:15 +0200
Message-ID: <20240524190906.06afae49e6a1.I108ec4756919a9e7c73f3fbab9029a46be9c76f1@changeid>
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

Update Makefile to handle 6.* kernel versions

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/backport/Makefile b/backport/Makefile
index 37cd2c05ab38..2844270e82a6 100644
--- a/backport/Makefile
+++ b/backport/Makefile
@@ -92,6 +92,7 @@ mrproper:
 		kvers="$$kvers $$(seq 0 19 | sed 's/^/3./')"				;\
 		kvers="$$kvers $$(seq 0 20 | sed 's/^/4./')"				;\
 		kvers="$$kvers $$(seq 0 99 | sed 's/^/5./')"				;\
+		kvers="$$kvers $$(seq 0 99 | sed 's/^/6./')"				;\
 		print=0									;\
 		for v in $$kvers ; do							\
 			if [ "$$print" = "1" ] ; then					\
-- 
2.45.1

