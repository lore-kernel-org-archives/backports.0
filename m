Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5007712EBD5
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570586; cv=none; b=uWnExFy7QgYJhF7VX6YitJBvwt1lKNnOv8p22tyvgNtI8t5WgoutTjVRz+NyPFlkjAEsRq8ovXGHbr5wsfeU25/ug+yyMCGffBSp7uWjEk//xNKA60C7TGlEr0qwjaO0HZAdnTjNxykOexVxp8TKKKL5h7NGOGV5vnWRMxkb0YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570586; c=relaxed/simple;
	bh=x77x66TJi1mCoc6H1GoNKnimaWJ0ihXpfyXqt6SI22g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BlJqFrM559WEohFGDSORttsrFHzS3TN889uvMpfJWMa0nH0VDj8ApqeALUNLDWTZSqLqv5DEIW6RzJa5wXrouDbvE7vLH0SYwIHacdQVYyMBWd4432JphCP5mmZEOE1+QSF864Z4KVTSiau55KBYWiFxLHu7EnSpZ4Q6NtDB6XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=IYSTqdK6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="IYSTqdK6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=plvSw+E4ZXRs5KxbigFkpdbrlaEW61Sw2Ltn9dfhhUM=;
	t=1716570585; x=1717780185; b=IYSTqdK6wlEr+HXl8bImEutbti/kNV/9KjHK1b3JkbRnMlk
	PTpcsb1aJgAH7Fqyc0I+0QzVnje78ke0CvvWYPaQLTAfKAPtLYea2ZX+PtS5mt24TTaw75ZMMhPnG
	3i1atzrDPDAz6+5bU+Wg8DTiJ/KyGi7NNUAQDusti+EgqkUbYc4Qa7GiKsnOnDn9W0/htZwTwRRkI
	SWQRzI4k/ywYitCUYtmr3qKhwPTnlbPTFa/NPQ3x10s4XgvkSpfvBBCVSUdTsgRNYyJBbpb4fMH5F
	mOKfW7YQFX+Jdzx5tA75790gCMHXv5/VJn+G3sCJlaDAzQUv8/YkxdcRrgnDHJDg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQI-00000008Xuw-3k1z;
	Fri, 24 May 2024 19:09:43 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 35/74] backports: add memset_after/memset_startat
Date: Fri, 24 May 2024 19:07:47 +0200
Message-ID: <20240524190907.b03442e67598.I22eae0fdc7b78cf10a7dee6fe477fbf0c9a5e807@changeid>
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
 backport/backport-include/linux/string.h | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 backport/backport-include/linux/string.h

diff --git a/backport/backport-include/linux/string.h b/backport/backport-include/linux/string.h
new file mode 100644
index 000000000000..ce4c99e34e0d
--- /dev/null
+++ b/backport/backport-include/linux/string.h
@@ -0,0 +1,26 @@
+#ifndef __BACKPORT_LINUX_STRING_H
+#define __BACKPORT_LINUX_STRING_H
+#include_next <linux/string.h>
+#include <linux/version.h>
+
+#ifndef memset_after
+#define memset_after(obj, v, member)					\
+({									\
+	u8 *__ptr = (u8 *)(obj);					\
+	typeof(v) __val = (v);						\
+	memset(__ptr + offsetofend(typeof(*(obj)), member), __val,	\
+	       sizeof(*(obj)) - offsetofend(typeof(*(obj)), member));	\
+})
+#endif
+
+#ifndef memset_startat
+#define memset_startat(obj, v, member)					\
+({									\
+	u8 *__ptr = (u8 *)(obj);					\
+	typeof(v) __val = (v);						\
+	memset(__ptr + offsetof(typeof(*(obj)), member), __val,		\
+	       sizeof(*(obj)) - offsetof(typeof(*(obj)), member));	\
+})
+#endif
+
+#endif /* __BACKPORT_LINUX_STRING_H */
-- 
2.45.1

