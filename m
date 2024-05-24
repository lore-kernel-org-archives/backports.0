Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E9912F387
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570563; cv=none; b=vFBo/2eapCTH6LipDb1FHNWBOBbPZT6mknqsNdgwfUj6PL7jHeDWotEIevweDWcp8hbZ4q1ebYm5Ne/1q6y8UoKNYCrKRhBd48wyOcqQGIefSycvskeIKROCg34HVd/PGos3You9LkJ1B3u4fT+a/AHyGPHTuT1HDm/cfrVk3n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570563; c=relaxed/simple;
	bh=jtzmKNsqyzKzpRHv37EYebEi1RaIP3fZTkIgkF817tE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bFYwUVhsFd4DqJpQia33xwYDEHHWpSAdS+LjW2xUHp1gTThTSfOPCmOVVc33FZx/u6WghLdxP74q+2eldBe7zW9vi3zpftC/nQfcDL5GuUa4UfUdw+Gjr9ckXrQ/jbZlF2tfp2JEItMQZ3jfDGqp2GaWh6rngDg4X4tfY4lEhaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VEZMsvvV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VEZMsvvV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=67sY4M2ZTRVE9wRsf4wzp5ro8A0Bj/1eToMr62s5BkY=;
	t=1716570561; x=1717780161; b=VEZMsvvV1MNpxjVq9IAumOHSM9aLyOYjsPm8icA4mF9bsIq
	bkSTB2PRfs0EiwPI08mqRI0hFunS/rvU5LpaaMsw73BbUOAqoXpheNS7N3tlwyCZwHUWXHFFlsnWQ
	v3S7DtFS5v1b7cQMyY3LechAtaDqdaEphUta06+bYwj6WV3m2BTivGVNA9GS3lrOZhqk0NOXructY
	4/AsT4ZAF2sRNvEWTSlwmX+T2xSCE/hfsP//+/Ywivrb5pl6EIvCeLxaWZk75lWr3yFYmhKj15aPu
	dD7VX1KebbAwFsMbq69xY6+vOn2sjJMKsFcD59UQV9nj6+6eV7LewFhEdPymyhvg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYPv-00000008Xuw-0bMZ;
	Fri, 24 May 2024 19:09:19 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/74] backports: Add __counted_by attribute
Date: Fri, 24 May 2024 19:07:22 +0200
Message-ID: <20240524190906.03404f605970.I5f3ab2eb202242a2ccac0053fab1fb7d96c35829@changeid>
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

This adds __counted_by attribute from
c8248faf3ca2 ("Compiler Attributes: counted_by: Adjust name and identifier expansion")

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../backport-include/linux/compiler_attributes.h    | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/backport/backport-include/linux/compiler_attributes.h b/backport/backport-include/linux/compiler_attributes.h
index 31ddc163e09a..6a0ffca2e102 100644
--- a/backport/backport-include/linux/compiler_attributes.h
+++ b/backport/backport-include/linux/compiler_attributes.h
@@ -31,4 +31,17 @@
 #endif
 #endif /* fallthrough */
 
+/*
+ * Optional: only supported since gcc >= 14
+ * Optional: only supported since clang >= 18
+ *
+ *   gcc: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108896
+ * clang: https://reviews.llvm.org/D148381
+ */
+#if __has_attribute(__counted_by__)
+# define __counted_by(member)		__attribute__((__counted_by__(member)))
+#else
+# define __counted_by(member)
+#endif
+
 #endif /* _BACKPORTS_LINUX_COMPILER_ATTRIBUTES_H */
-- 
2.45.1

