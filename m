Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC60B12C47A
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570633; cv=none; b=Q0FDBnCLzjEnyS6i1QblqjGKLKozgcfikvijNjQ4jNX3wN/g11k/j1Ys53CphZ+O7Qqc9uHcFay4b7FcoPLIvyQHyrJruP6ij/RTJLIuOzI+nbQ/Kv3PDfN2eZFGj2Rv1ARX5H/KbIvuxcvb5uH9P3Zr5uMFwXHoBVotLTPOa5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570633; c=relaxed/simple;
	bh=hRsbh7pb2wbDOvMluLeAu/wDsx3RJ1Ehin6zJqiGQ2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hspF+2uwjyYGptwo/kj36Q7qSg7APxRCUz0sYCN+S30d6+nQv4fNA2Cy63kJd1aEaKh0QmfU1mOXsz+PdZo27trWAI2AHwUesvoXqTVEtD3/CqrU89saAg+mcEVltIFC+J57QUY2PAW1VJDGM+ZWx/bzvV/54Lut68jwckGkQpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=BOCZ+Dvs; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="BOCZ+Dvs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=PFNtIaM0XVjpvHWiOzH44GTnIhHehWcrhikw5vW+Xzw=;
	t=1716570632; x=1717780232; b=BOCZ+Dvsx24sZkzBlkdRokfVqZLD/YuQQIIxs8nC4zVNtK4
	7ZYRKunFn6G3czsOr8mexCFqDsDMK/dtl588svcslTvpmPw5fJ0WAglwUYAkU946Nl9EMYUgRa1IA
	CdbRZiPhh7+gXoN8148e5GlWLtFg7swfl9H7ZSlZRtrre3wz7lNsATN8lmrejz6Ejc93eYigBDcP0
	DFve7D/xvR2PbR+GdegWLCkpcCWZYG2fd4q/7f/V5RWD1f9Hi9jsTLSu2/QdgQEroVHJCp4UnTQS0
	8RYJYZFan1E8UCcy0J2y6J1g0FZpw+tZCyBqvP98RQAHsY69HaS3kiY6WqWb+MUA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYR3-00000008Xuw-1fxK;
	Fri, 24 May 2024 19:10:29 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 73/74] patches: add build system workaround for pre 5.17
Date: Fri, 24 May 2024 19:08:25 +0200
Message-ID: <20240524190908.b8ed0e43b711.I3fcefff149575b91306ca59617d6979dca20898b@changeid>
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
 patches/0111-wireless-build-unquote.patch | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 patches/0111-wireless-build-unquote.patch

diff --git a/patches/0111-wireless-build-unquote.patch b/patches/0111-wireless-build-unquote.patch
new file mode 100644
index 000000000000..ce4db030aa48
--- /dev/null
+++ b/patches/0111-wireless-build-unquote.patch
@@ -0,0 +1,17 @@
+This is needed because on earlier kernels the build system still quotes it.
+commit 129ab0d2d9f3 ("kbuild: do not quote string values in include/config/auto.conf")
+in 5.17 changed it.
+
+--- a/net/wireless/Makefile
++++ b/net/wireless/Makefile
+@@ -34,8 +34,8 @@ $(obj)/shipped-certs.c: $(sort $(wildcard $(src)/certs/*.hex))
+ 	  echo 'unsigned int shipped_regdb_certs_len = sizeof(shipped_regdb_certs);'; \
+ 	 ) > $@
+ 
+-$(obj)/extra-certs.c: $(CONFIG_CFG80211_EXTRA_REGDB_KEYDIR) \
+-		      $(sort $(wildcard $(CONFIG_CFG80211_EXTRA_REGDB_KEYDIR)/*.x509))
++$(obj)/extra-certs.c: $(CONFIG_CFG80211_EXTRA_REGDB_KEYDIR:"%"=%) \
++		      $(sort $(wildcard $(CONFIG_CFG80211_EXTRA_REGDB_KEYDIR:"%"=%)/*.x509))
+ 	@$(kecho) "  GEN     $@"
+ 	$(Q)(set -e; \
+ 	  allf=""; \
-- 
2.45.1

