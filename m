Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D79912EBD5
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570563; cv=none; b=DnqG8ZSz8JInUGm3nXSXaOkVFSGgQjDdni5qvBQel6O35wx56oUlgPW3f2aja0+jayMgQ2F5U07NCAxfbR8S5Ro2SrFx733HXFOV2KwI4OG1dWtxq2TM2HG8otMn86lAp7jFSUkZG+xvnhICyKVIREl6sS+l+Up4TA3wSuIP2NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570563; c=relaxed/simple;
	bh=JzhiZIH6lJIma2Z0xYMT2/Dk3fQwq0dlMOTCplY3GsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjpUjPAu/uO/K2jkAqmnRNFTZfIDUstOhZKyKEQuLnxugOQPeUvn5O8QGhSKoPF5EZZuKk50RddSqypN+GnATRLn9a1QaxTE08RNNx3fe+gvVJSP7RdAHlpgbXWu6K0Y9LuqB22VGKuMnAlnGi7TNkirKM4hei1ouse2iAZ6Rw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=pb0jdNrJ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="pb0jdNrJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=+mcXsJyx2eRCtTxaK6kuvnU54ia7gPJ/p07HCb11OTc=;
	t=1716570562; x=1717780162; b=pb0jdNrJxmlzjCOBeLUDDC9Dwsl3Xl6g6lWxzJYs2VP7BaB
	MAibN5BVqiduyw5576E/y9pJI1KeVSM2iSk+vrV+DL2YM85I3Dl82aYR4jZajy1CoyEOc0KRWbCvQ
	4xTcwSgJqAA8SKzRbB8qaEUJdTdcDm3cgTujzhwja822Pp9EK2MvOkyM+hSBSA2A5uReFT3UM8UaH
	+02xEcDL4aVOhWlbSqLvVEAR2twXvUB7D/BVvNVOVQyVV0nCe+iqNrivF541CJAm/ToHWTUiPww2f
	Qd7QCX6o0fkHi10vYo640KSdU9wP76NEJrGF9wehPwhVN8WF0j9765AQlxEDOWJw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYPv-00000008Xuw-3LNR;
	Fri, 24 May 2024 19:09:19 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/74] backports: add stubs to handle debugfs cancellation API
Date: Fri, 24 May 2024 19:07:23 +0200
Message-ID: <20240524190906.076a30163546.I33e5bb5a3f12cbf87838ef867681a7ba51beaf46@changeid>
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

It is added in v6.7-rc4, add empty stubs.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/debugfs.h | 24 +++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/backport/backport-include/linux/debugfs.h b/backport/backport-include/linux/debugfs.h
index 6020c210f133..cb954ac392a9 100644
--- a/backport/backport-include/linux/debugfs.h
+++ b/backport/backport-include/linux/debugfs.h
@@ -23,4 +23,28 @@ static inline void debugfs_create_xul(const char *name, umode_t mode,
 }
 #endif
 
+#if LINUX_VERSION_IS_LESS(6,7,0)
+/**
+ * struct debugfs_cancellation - cancellation data
+ * @list: internal, for keeping track
+ * @cancel: callback to call
+ * @cancel_data: extra data for the callback to call
+ */
+struct debugfs_cancellation {
+	struct list_head list;
+	void (*cancel)(struct dentry *, void *);
+	void *cancel_data;
+};
+
+static inline void
+debugfs_enter_cancellation(struct file *file,
+			   struct debugfs_cancellation *cancellation)
+{}
+
+static inline void
+debugfs_leave_cancellation(struct file *file,
+			   struct debugfs_cancellation *cancellation)
+{}
+#endif /* < 6.7.0 */
+
 #endif /* __BACKPORT_DEBUGFS_H_ */
-- 
2.45.1

