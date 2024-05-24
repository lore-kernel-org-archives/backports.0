Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C0E12F368
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570568; cv=none; b=fYc4nMj6NbTfEOvCYcPh53psXUmLkSA05FY0ksBIEq6tHnJomqME3CiOHLKtTTr/af5HVwyNbw9lz51kNW1d75apOZTeFIpf6XNCxjp0kSB9/MEBJy1u5zGZU9tz/LkK9/hwlNaOH5E3couYl10O5jCfL8jslp9BbxfQEXgglNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570568; c=relaxed/simple;
	bh=PwKz2WRzR+6df7xsHkMn9tNVoquzDadlGS3DhpIICgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=howr3C3CWbS+x0Eru1A7M2VMaq2N1DToBrlCXxzD5EIgyaeS+4S105lluCdOWTHqntiJQX4/jGZeqEToThMRb+CDvi/3nS6r24EVsKFdlFpk7xNqDud12qZNYC2w0tGyMgB8Zi7ecqb+R6oeud7+rZ3QKu8DY3B+zoW84UQlI3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=hACBZ00Q; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="hACBZ00Q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=kAWtnyvSyYeldFfzJvBfWo5dCk6/tDKhbbl3MK0hZy8=;
	t=1716570567; x=1717780167; b=hACBZ00QdVKSXTm+0eL0PTs95Z4rPENaIPX6I3268B3usG1
	fgb7ByBGkTrPUeJYgwmRGzqDMrz8376ERLGM+Z80jjLuoZkaFGG/jgIeC8K+zjjj5R92mCHhobQJh
	nJfxAEWzMTICQSZPdqwVE/xqWo6H9oUQMMvkvGNXSZBjdmDO75RmG5HmfUmf9z1/x4qmX5BUhREzI
	up46Jn7PBL7wrpPhO7SIWlKGKGUvN2EIqVFo9tZEEQ0YcSKa0mYGMoaifQR6UzovrmQSenjjG5kNz
	eR88R5VZIcm3lJwSB7KN3oF2hBACiXJMvCc2i3DD6dKppppT9jJQYtso3HbldwYQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQ1-00000008Xuw-0E58;
	Fri, 24 May 2024 19:09:25 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 17/74] backports: add kthread.h
Date: Fri, 24 May 2024 19:07:29 +0200
Message-ID: <20240524190907.045b440b4ad2.I0c3c1ed3d75dcd800d0a4ef41943a4db10ea5df4@changeid>
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

In 5.17, complete_and_exit() gets replaced by
kthread_complete_and_exit(), so support that API.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/kthread.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 backport/backport-include/linux/kthread.h

diff --git a/backport/backport-include/linux/kthread.h b/backport/backport-include/linux/kthread.h
new file mode 100644
index 000000000000..23a599e92b30
--- /dev/null
+++ b/backport/backport-include/linux/kthread.h
@@ -0,0 +1,13 @@
+#ifndef __BACKPORT_LINUX_KTHREAD_H
+#define __BACKPORT_LINUX_KTHREAD_H
+#include_next <linux/kthread.h>
+
+#if LINUX_VERSION_IS_LESS(5,17,0)
+static inline void __noreturn
+kthread_complete_and_exit(struct completion *c, long ret)
+{
+	complete_and_exit(c, ret);
+}
+#endif /* < 5.17 */
+
+#endif /* __BACKPORT_LINUX_KTHREAD_H */
-- 
2.45.1

