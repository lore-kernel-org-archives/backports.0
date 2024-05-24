Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F924376EB
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570608; cv=none; b=fcjVi8X5LXrBun7qNwYOemXHTzMk6K8hVHhfphgcZ+FvKDvDNBdFzMOt4vg2iydrkkIwJNFEWpeUXlxmNl2jT7qMg6aFSVBX6wS7lgSZf4w8bTRfxI3yovADhjsv05bytT3qQs3yQe1G61e6nXhoPF5XqztIQgnxveK+KLq5Sng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570608; c=relaxed/simple;
	bh=OW3iAN9wb5d8ilu7NOmjNcyQWPZk0n9TlcMIY1lmq7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mqvuAFad6MIt/G3FK3OuvDSLZE7cJOqwVqjIP1JBa+bQC+W48K7gt6idPtA2PpAGp7MloR5Nw1/nqGX5jBz+GEulx4gPKnqQPX8h95Ukg/uDKjNgcpZoj8ck+0UbYYE7yWttVPGqasSo1sny+gkDbG5ab1UbyfFYNulVpgMxWLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=fjwqwg24; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="fjwqwg24"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=fMhc6rpUDT+fcU2vOL/fNNcfE5GCSBivhQgJnE+BqjU=;
	t=1716570607; x=1717780207; b=fjwqwg24XEUTkRFva9oUn74bGRTKQTB9WdRPllTO5+MHBkj
	YUEyIYB8rSWq85CQ49jAJCAI15M2E2AJS2Gz9czHt9G07RWhTPvm8PldlFBqq6iqTH1y3n8senFa7
	QhDRKqkPB38QyUvBNqcN3O1KgtlTy8MTAaCLFWFcnKKoUReAWXLWMG0vVraYSk+XCMuw6eiBgodnV
	v0Fnuk/sxUziw4kWD8PgyWPdO5p7DDScGb1qSoOEkLJj3IfIZnFu0w2KiSx+TaIESemCMDNYY43sH
	I4izhgeTD15WHYbsnPRRP/uhnd6dfIELbBUCUjqeK3OSiZ6ABGJXilWeQ+80lqsg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQf-00000008Xuw-0Kg7;
	Fri, 24 May 2024 19:10:05 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 52/74] dependencies: limit IWLWIFI KUNIT 6.3+
Date: Fri, 24 May 2024 19:08:04 +0200
Message-ID: <20240524190907.0891b535df6c.If5049905d5f73c7b0af9b6c5cbedb5f96afc0ab6@changeid>
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

As before KUnit APIs doesn't exist

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 dependencies | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/dependencies b/dependencies
index 1377b1b6f9a5..43286ed18e11 100644
--- a/dependencies
+++ b/dependencies
@@ -34,3 +34,5 @@ QCOM_QMI_HELPERS 4.16
 
 # QRTR
 ATH11K 5.2
+
+IWLWIFI_KUNIT_TESTS 6.3
-- 
2.45.1

