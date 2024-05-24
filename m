Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646B912FF95
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570564; cv=none; b=pFUqXkVqZs7+KNV5oeIVcEoRFVnBT5eQ0KSgwiI6g3KQV8fcc8UropmVdCJXBdkk2s4wdUGAymrnbV+sMTFeInnfWlJ3038+S3JUpzkislrWOGIItx9pq908iCuaf9k4xJve/u9HfoTA8m0hoOIIWn083kH2kqJBARViSo9+kDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570564; c=relaxed/simple;
	bh=dbEJYggp+0FAfA5ODiQLegHw/BQ5ZrGvuYaqAh9qlYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jd3VPau5/24E09vh9ZtMdReS4yWB9/HLORfkqvLdMYg07SaFX2Y9F9XrhcL6HFVJ7FHHk/Ac60xvi5yVBzJ26eeo+zBRURLJZnZkLCjZx/q3YaQS/1LBxfUVKCgWOmjWtImO/Yt06pwlF3VPyK88WOSWA3oOmhD1TPloJcORBmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Xo09hHdR; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Xo09hHdR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=tnOJ/uUgRcUOq64CSYWpMGrZg0+/iQZZAjhHD2YywUw=;
	t=1716570563; x=1717780163; b=Xo09hHdRSkKulxk/E8IwlOZg3ZFuAKNxtojIuzcCBYv39hu
	bW2XmmDYwaztpoidUBCPpcMavjy8adRsUS3UQG3D0JVY/bsnoQv97P7YvgB2vI4WeLy+ylHm+rbQ/
	ljsqwnp665/s34i8THAeJdLFu5BVJgr6kgz2cNCz+u6U7RZSQLfAJm+4kPHLhOr8/a28hCi40hqn/
	2PDn3jjQgld94wpCu7txvpOQb4F+2G7gokQqg7ZPaQYOqGuiS5w9cuoD5nGymhQZPQhT7P/nXU5rE
	6zOeQwqcXdBh9JRZDOnT1vB8/P+xG5zUCku0vfwIixnBjPm8cm7oogpe+TEIn4wQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYPx-00000008Xuw-0ZOO;
	Fri, 24 May 2024 19:09:21 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 13/74] backports: add linux/efi.h
Date: Fri, 24 May 2024 19:07:25 +0200
Message-ID: <20240524190906.f219db8b3f92.Ib2c8a1b389e6a5b212332e9cda7b0adb369738a5@changeid>
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

We need efi_rt_services_supported() on older kernels now.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/efi.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 backport/backport-include/linux/efi.h

diff --git a/backport/backport-include/linux/efi.h b/backport/backport-include/linux/efi.h
new file mode 100644
index 000000000000..c2ac9dd97947
--- /dev/null
+++ b/backport/backport-include/linux/efi.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 Intel Corporation
+ */
+#ifndef __BACKPORT_LINUX_EFI_H
+#define __BACKPORT_LINUX_EFI_H
+#include_next <linux/efi.h>
+
+#ifndef EFI_RT_SUPPORTED_GET_VARIABLE
+#define efi_rt_services_supported(...) efi_enabled(EFI_RUNTIME_SERVICES)
+#endif
+
+#endif /* __BACKPORT_LINUX_EFI_H */
-- 
2.45.1

