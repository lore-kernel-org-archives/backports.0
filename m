Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7529612EBC9
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570600; cv=none; b=ICaeZTrlqIVKkDu50sNzFv+LfvjmU8cCewGSsHBjhW6C48hCL9LKds7b274yiSxNHU56lDYWBuvZsrPaagT6vPOZ04JacrObHJCv3XHfaL4KRJai0Aq2hT3c7v5lFQ3fMLE3pYSVK2xRjBgxXZLQR4SxCXAle4368aJW3eARe1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570600; c=relaxed/simple;
	bh=9m+auf4oFx2U+5E3r7e+l2nJtfHmHZEJZFYToWEEi7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwAQxdC+nSoIsU4Aw/RDu8KK6/VxH8HvILiDaF0LElesA1e5FbCIuydyFg0ymxaMMpBtCeStYV0TGfB6TUgzfFONlYTYJKzeT8Zy9tfUGk1SZlEoFLlR2utlEzzAsOWbrU6a3NER8vxxBFrPt5atqNVOSzhcaj5r8CehtvCHc0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=oRgypaWa; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="oRgypaWa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=hB4tzG7+OdnIh2wmiU4xChAubMFyVQvx1cDuvJl0xvU=;
	t=1716570599; x=1717780199; b=oRgypaWaNT1+dsVqVqoYA1qFPreHFdCaR/PPPnhh+C6//Hg
	m8+JjJBkezvPjsZGGLhkbr9JOFDE9noqL6KK3yFYvDoYgVCL1MaNE51xXGmIDCvqWfHx5o2ctz3NN
	JXSNsY7tIriaW/6hro07B2pCFNG6FrS5T23p0+xP5312KnHBgd1k/rn/e4fkiKx9kdEue7l54D7Zs
	Sw19INsfq/j0+JyJZIL8O7uPb55FO/QbKO9QrviaPaAJKignUvwwRGRu50YnQq78vF+YNaUPJf41N
	QzXU4V7JhaOyXjlchtkZky8UMnMvZI09Nx2doFe9l7p7ZZeuG3zL5LzksgTzJcfA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQX-00000008Xuw-0ctC;
	Fri, 24 May 2024 19:09:57 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 45/74] backport: add gso.h
Date: Fri, 24 May 2024 19:07:57 +0200
Message-ID: <20240524190907.ed1b5fb658ac.I80bd589db6d0b9547dd434492f30b96c5439bcef@changeid>
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

In v6.5 gso declartions were moved into their own file.
The commit is d457a0e329b0 ("net: move gso declarations and functions to their own files")

Include the correct file depending on the kernel version.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/net/gso.h | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 backport/backport-include/net/gso.h

diff --git a/backport/backport-include/net/gso.h b/backport/backport-include/net/gso.h
new file mode 100644
index 000000000000..f9ad9fc888b2
--- /dev/null
+++ b/backport/backport-include/net/gso.h
@@ -0,0 +1,9 @@
+#ifndef __BACKPORT_GSO_H
+#define __BACKPORT_GSO_H
+
+#if LINUX_VERSION_IS_GEQ(6,5,0)
+#include_next <net/gso.h>
+#else
+#include <linux/netdevice.h>
+#endif /* < 6.5.0 */
+#endif /* __BACKPORT_GSO_H */
-- 
2.45.1

