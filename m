Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8492212F379
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570562; cv=none; b=fmJl8rm4mMsP7X8pPFmqZel9koc0OrWuo8a2IY0ZdKhOykmE7ji9Rw0bnOEwSRrIs/L353VXuE+drkl2jirGVLURdqL47ZNozydlsmt6H9nz06zBlF9HpOXZgcJs/BqGR+46AxgkwnaX6Qj5XDrdhCKFEOf8io2Hoiv3LZ5b9ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570562; c=relaxed/simple;
	bh=BwztDbwh+O3zEVRPdoVnfOf8curPHYjSox416k9RgSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ApHdWVwSGp+B32MY4QwyObcGgukYKATBB4s4tDAB4G5rgzcsy1+Znm6xYAveMJJDtZeWqKFVRiDC9F1gjp4cNxivaPSU6DWRXgAJ2Jcan2OvzVOnaPvghCTATPguVLUSTLtBDBf8moy+slJsIKL+a9hVbOY7Lyn0KavZYv++IBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QORFET0N; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QORFET0N"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=2K7OapDKaiIER93a/8MX23Wdb+3DoMB5ePwNdrDpeDk=;
	t=1716570561; x=1717780161; b=QORFET0N7nQBEUWYuoUA4W54m/vu4RGWXrj1BXz81J6U5Xq
	We2MpPWcVGreLeiZn2A2L4R9qINhbxNTtkMk8wbd4AhzErnQsRZ3kilGZ1G/Bt1zEUpBzQNcKHqex
	G7CNCsSu3XqGs8jBybZPxuuzZE4wSzf5KEYr/KpcHooies0PW4EobVMRIi9FIfYuULcFBwtgxujnY
	r9HBpkz2EIbQtBnE5TtHZzmJ01mXYqsMKk7n8GY3D0Tv+VywnEuWbH/Moe5fLsF3WqfwS9PgnaSBj
	LE+ik2y9FQFpYBcIsljcduejnInjplwQ3BXpNrqPG9gGXImTDETxbYyBVyxbdy+A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYPp-00000008Xuw-2w8x;
	Fri, 24 May 2024 19:09:13 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 04/74] backports: move to -std=gnu11
Date: Fri, 24 May 2024 19:07:16 +0200
Message-ID: <20240524190906.f775c3da7b8d.Idec21530cec4c44875ff13eeee07565ab328dc1a@changeid>
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

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

The upstream kernel moved and we want to take some patches
that take advantage of that, so also move backports.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/Makefile.kernel | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/Makefile.kernel b/backport/Makefile.kernel
index 11ce4177f2f7..5735421dad8c 100644
--- a/backport/Makefile.kernel
+++ b/backport/Makefile.kernel
@@ -35,6 +35,10 @@ ifeq ($(CPTCFG_KERNEL_4_3),y)
 subdir-ccflags-y += -Wno-pointer-sign
 endif
 
+# upstream moved, move the driver for a few constructions such as
+# variable declarations in for loops
+subdir-ccflags-y += -std=gnu11
+
 obj-y += compat/
 
 obj-$(CPTCFG_CFG80211) += net/wireless/
-- 
2.45.1

