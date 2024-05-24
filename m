Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19C912EBF0
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570563; cv=none; b=Pya0SE/I5KzQX7K7EprjD/Y8D6PmxIID13mxyJtzcnMNl5C+u+yeejRnLJVukZobWpA2m00saiytGLTBrQMIaJ57d7eTtQ7dnjsKIOOybHSryTH9jDqu+nlOx5A3lE8/OT6hDFVK9iAuxIV0BPmXs330ygq8gCQKYYj8lQkGvqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570563; c=relaxed/simple;
	bh=qLxD8fVQSuvXUhHJYx/lEhXwPE/juutz4yzYzik5ceQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iV0W3QQasDbuVI08QP8+tqs4WaLxDXGY2WuQKpqgNIqm/tAL4VNJRREyavo66IAxZ1VcrigxF1Y01wEjkL9ISJzKaVD5TZ1f3ltjPsQg+gFBecqPjr98Vk/g4jju3EXW0q+NNj92bRBPQqxoBk6GtemyOYu+oFh3NvUjxpbT5Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=n/Rt5Me8; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="n/Rt5Me8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=rD5+0bRFyf2DYLcbRes6xcAAwJ/2UanL9uymiw7vKII=;
	t=1716570560; x=1717780160; b=n/Rt5Me8uYWakY7SzXf2LNQd+Sxbe5kcFpkiri9D4WXFtkP
	GK1SpGzibETNzRg2hTdGGXklk6aJnhNeEBG8+NhOUpaWVoQ33UDEoCRRaX/alRbrmi6nnnzllS7Tt
	vxSjB7vqDio5+oKIFqpEg3HLTs0CVE63tTmzkrSUGiqeaCshFQwTpzpTopXOPw1i849TeG3aQ9Tp/
	CSvtrTBVOo/L/DnpiR4NQOy7D7AHZX7i7rRR6LShcISqGhinLeWrY7oOs1HxU7747d1uv/q/Dsnxp
	KQfs4eTrG06LBP/Z/CelmuR8BBgzSuFegs5yArsuPN1fl5EMoAS8/FXiJyAC3NGQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYPo-00000008Xuw-1gEn;
	Fri, 24 May 2024 19:09:12 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 02/74] backports: build: allow kernel versions >= 6
Date: Fri, 24 May 2024 19:07:14 +0200
Message-ID: <20240524190906.d438f86506ea.Ic331b52f9678fd6b0a95dbe83267fc8b5ca0a733@changeid>
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
 backport/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backport/Makefile b/backport/Makefile
index 77c2670d637e..37cd2c05ab38 100644
--- a/backport/Makefile
+++ b/backport/Makefile
@@ -85,7 +85,7 @@ mrproper:
 			done								\
 		) > Kconfig.kernel							;\
 		kver=$$($(MAKE) --no-print-directory -C $(KLIB_BUILD) M=$(BACKPORT_DIR)	\
-			kernelversion |	sed 's/^\(\([3-5]\|2\.6\)\.[0-9]\+\).*/\1/;t;d');\
+			kernelversion |	sed 's/^\(\([3-9]\|2\.6\)\.[0-9]\+\).*/\1/;t;d');\
 		test "$$kver" != "" || echo "Kernel version parse failed!"		;\
 		test "$$kver" != ""							;\
 		kvers="$$(seq 14 39 | sed 's/^/2.6./')"					;\
-- 
2.45.1

