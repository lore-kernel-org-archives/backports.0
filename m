Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842E5376EB
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570599; cv=none; b=j6tsNYJh5mtZUELEeIP91rI+bgzdaU34a3EqHXxRTbUkekwO030k66mgR3HXPBOQCt6RBuQFe9nP5jeHGo+fIabW94yPjxM54/JEh+X1o0jTY5834jznlERwOI2Erdnk5J4fF3XCP2a47ZpdtK/ZT/LeuLNW0hIarTAkovw0juk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570599; c=relaxed/simple;
	bh=w4y1rGezzL7GZmSt/I5k67cOzQQtjQnA31gVGNDTHOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dv5J4/qhH2aaJDP5pFK6UDsN2qxvpeVNEcHgb6s4aXaGO9waY7u59UHZHBC9paFssD4Ef7zORFXS5kOB+Z4R7agYT7pWXshw4vFZ2JQYSV9so8wZpMe5qEBdBatElENRBewKlC+UbYk52ou5E7Zppcd5XM8eimYlUKlyvb0DODE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Bk0aJaPf; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Bk0aJaPf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=XB2cjudwaVJyWuv8TI5SFCK10AtKjr3niFVIwgzb8bo=;
	t=1716570598; x=1717780198; b=Bk0aJaPfXTIoBw7Nvr9oMTzwNNYeIIC3glCM/iOCacktSUI
	O9rsl3hRptbAf61msRSMFs4dwXqqvOMHBeV7SXpRUGNaFIcSYuBwcVoMDJMkU75biWIoVZz1qs7xb
	/bywWsQ0ph5rMW15/yY9FXDQmjFA930NPC1cB4O/aWFsYG43h/Hg0heUAd+33UVfPgnhaq4lSBZo8
	A/5PdeAJATUP1mA0Vl2/WBxKuJSpA41GhyGf2X5gB1GvPUyQEWHwNd6x67Av7CR6he7Y35N8FMqmk
	/bG7+rQuODIPdANm/yn+v8yJ/ZLXgxuA3PzTHE7WPsHjQw5tZCAYpg8fodSaKhxw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQW-00000008Xuw-0kLu;
	Fri, 24 May 2024 19:09:56 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 44/74] backports: add virtio_reset_device
Date: Fri, 24 May 2024 19:07:56 +0200
Message-ID: <20240524190907.c51e0f2751bd.I3dd09cc0b68e7a93e003ef10216ec310d74e80de@changeid>
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

We need this for hwsim.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/virtio.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 backport/backport-include/linux/virtio.h

diff --git a/backport/backport-include/linux/virtio.h b/backport/backport-include/linux/virtio.h
new file mode 100644
index 000000000000..98c844918251
--- /dev/null
+++ b/backport/backport-include/linux/virtio.h
@@ -0,0 +1,13 @@
+#ifndef __BACKPORT_LINUX_VIRTIO_H
+#define __BACKPORT_LINUX_VIRTIO_H
+#include_next <linux/virtio.h>
+
+#if LINUX_VERSION_IS_LESS(5,17,0)
+#include <linux/virtio_config.h>
+static inline void virtio_reset_device(struct virtio_device *dev)
+{
+	dev->config->reset(dev);
+}
+#endif
+
+#endif /* __BACKPORT_LINUX_VIRTIO_H */
-- 
2.45.1

