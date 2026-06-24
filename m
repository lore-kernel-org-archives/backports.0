Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D952EEE9E
	for <backports@vger.kernel.org>; Wed, 24 Jun 2026 07:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782286836; cv=none; b=JbwzJpMnAeaAxg3TsLARFL30g/NHjsTIkm6/gjs0pmWXuQL9pJwLp62cLkazObclZjtza3bjbxL4wCoswy/o9Azzz+8zIHxiy/ueIJBBJAIc+rmY7W6Hl2exlqNy382UoYsyCRpO8p0OoqHTPSGpFd8ZZhe9LlgELcdrG8vFX38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782286836; c=relaxed/simple;
	bh=vXpwq2DnoaHCcBX5iAnSg72uiYm8ohVnWDIhYQ35n7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uBjrav/EAmD5+eQnxziXEGBekjVDHnHlkF+rFA9umlYHFnow1sDO661K1NKXGmLsZc7FfFXYjxET7tyHlTCJVj54zYQlYyiYN9pQGsJ23tMl4QN3bGDYYwaAocI8GdPYdzNeIP1gvxXm6TD0eGi3OvRM/6cj58ngAbRfldH60DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NRYL9/GW; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NRYL9/GW"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782286833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EL4ACSpMzWY6izLQo7zXVQByPcKyMrFtD4QCZQzCvQ4=;
	b=NRYL9/GWDNTUi1eFvjjbY3OjjNoSoyNxiHoNk5y+Y4TZ9G7Eh7d79KV8E1cc23zYUYJAla
	CbfEqNtAtq1gYOhXtr2+IysIS5tRaabCpClOB4sTN8EkOQ8r0fhoFUGuxviRhMYt86Ppjr
	cK8XxWu/n92ne6/4UAihCKonI92TbLI=
From: Yi Cong <cong.yi@linux.dev>
To: hauke@hauke-m.de,
	backports@vger.kernel.org
Cc: Yi Cong <yicong@kylinos.cn>
Subject: [PATCH 17/20] headers: add __counted_by macro for kernels < 6.6
Date: Wed, 24 Jun 2026 15:38:41 +0800
Message-ID: <20260624073844.2097504-18-cong.yi@linux.dev>
In-Reply-To: <20260624073844.2097504-1-cong.yi@linux.dev>
References: <20260624073844.2097504-1-cong.yi@linux.dev>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Yi Cong <yicong@kylinos.cn>

__counted_by() was introduced in v6.6 as a compiler attribute for
flexible array member bounds checking. Add a definition that expands
to the attribute when supported by the compiler, or to nothing
otherwise.

Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 backport/backport-include/linux/compiler_attributes.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/backport/backport-include/linux/compiler_attributes.h b/backport/backport-include/linux/compiler_attributes.h
index 31ddc163..b39b66b5 100644
--- a/backport/backport-include/linux/compiler_attributes.h
+++ b/backport/backport-include/linux/compiler_attributes.h
@@ -31,4 +31,12 @@
 #endif
 #endif /* fallthrough */
 
+#ifndef __counted_by
+#if __has_attribute(__counted_by__)
+# define __counted_by(member)		__attribute__((__counted_by__(member)))
+#else
+# define __counted_by(member)
+#endif
+#endif /* __counted_by */
+
 #endif /* _BACKPORTS_LINUX_COMPILER_ATTRIBUTES_H */
-- 
2.43.0

