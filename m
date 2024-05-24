Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509BE12EBC9
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570587; cv=none; b=SfGFK7XimQQ16pualVfMoNJnU6HrnGaMZBLFaGCDXaJBksfq5xxjMCKn7ihx+QebsJzU3LBnYUHj0ev3Dl041KW267Zo2yOwwQYWUiBm8feUhnw/X68gG1+rgoGxtnvVFK/tjMbcKtSDpDyEc93HeQ0eWNKRonO+iGmdAFFLTcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570587; c=relaxed/simple;
	bh=KsfYmOs9CW+e9iV/c3KUfIqzKIR00+UOaRH9rJOJGH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kYMeFpGfYv6WP9w6xcbsrCKMHpkTMhwYU+a4Ph/B5ZMDW3fmkHtpFrdrIn5djmbC4Xkm46meCITFWD13bQnmOwi45eYjXpXu7OV9UTjh3KmdFaKuN6f7hWv2pmEDP4YCquoDZBE3rTu89LM3kLGTXHXayW6VTCtm5iE03b1Kr5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ZPDRSq/P; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ZPDRSq/P"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=yjeX1oBoWECJfMBuNkBSCO4f8kJ+me7VSNS26Sq0NgI=;
	t=1716570586; x=1717780186; b=ZPDRSq/PVLGULgCdIhKeOaur3nuRvcKwcEDkPBipPS773+t
	yfjvbVDxKX4xaZPEodXqMn/qWCI+flOdNW4KWUoFRnh+CIWDqGkHOI1g6YELFiT+WdsEXp4y/86Tn
	SJavJpu7zwzdD19rXtIevDOytlM5xXi3BbmJeUMtX8d5lOr7/nbheUTEVo7oe0rDsdHPh7sDGvG5J
	qIDmyCz+lmjgZd9VXww6JgjtV4IZp58SjJRQPfY2XC2gsf3xcwvkRYkUICjkSBcrHhO/OKyQgEAC+
	zxW9fb/S9vNn6FnMKpXHhMZRvp8pFZwsfbZscl4teByccSibTQPHosTze4IFyKfw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQJ-00000008Xuw-3Ywu;
	Fri, 24 May 2024 19:09:44 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 36/74] backports: support strscpy_pad in older kernels
Date: Fri, 24 May 2024 19:07:48 +0200
Message-ID: <20240524190907.1dee9821fe79.I57f107eb082c9a5d4ba9377bbf6c777013d7e24a@changeid>
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

This was added in kernel v5.2. Add support for it in older kernels.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/string.h |  5 +++++
 backport/compat/backport-5.2.c           | 14 ++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/backport/backport-include/linux/string.h b/backport/backport-include/linux/string.h
index ce4c99e34e0d..f6e6cdcf08b8 100644
--- a/backport/backport-include/linux/string.h
+++ b/backport/backport-include/linux/string.h
@@ -23,4 +23,9 @@
 })
 #endif
 
+#if LINUX_VERSION_IS_LESS(5,2,0)
+#define strscpy_pad LINUX_BACKPORT(strscpy_pad)
+ssize_t strscpy_pad(char *dest, const char *src, size_t count);
+#endif
+
 #endif /* __BACKPORT_LINUX_STRING_H */
diff --git a/backport/compat/backport-5.2.c b/backport/compat/backport-5.2.c
index 5624d5fa08e5..581bb9cfe7fd 100644
--- a/backport/compat/backport-5.2.c
+++ b/backport/compat/backport-5.2.c
@@ -479,3 +479,17 @@ int __nla_parse(struct nlattr **tb, int maxtype,
 				    extack, tb);
 }
 EXPORT_SYMBOL(__nla_parse);
+
+ssize_t strscpy_pad(char *dest, const char *src, size_t count)
+{
+	ssize_t written;
+
+	written = strscpy(dest, src, count);
+	if (written < 0 || written == count - 1)
+		return written;
+
+	memset(dest + written + 1, 0, count - written - 1);
+
+	return written;
+}
+EXPORT_SYMBOL(strscpy_pad);
-- 
2.45.1

