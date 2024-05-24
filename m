Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02DC12EBD4
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570561; cv=none; b=mqfUp4lFSFg8+2wTqFqN+4aJi+0oEFbStdeRUV8hv1zGZi3DcYA6Tbab3ZP13wq0aQDjBo6Zhkw1W6q8a0TDMo1Um0tw1SOFORsIGJQp2yxIuei6QCp5+UF1ZoNiPLjGXURH9b3JUo0XVb8Axz/xgnUld6S5JaRWDVsffxVTDBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570561; c=relaxed/simple;
	bh=gMbHlvgl23e22QQqOYBY8k8JUDgW+tDCZUdhq6yoKpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQngk6DD05vnVDmq1fMKtUG09Ciac8EfFNpMQfQabYljYAhUYzxYK6Rts6QYvGunOo0uuFM0zYRpnRyH+Zi+64H7Ypo6/rFHjWJkZ661cJwulP9boVWnFgKbrzwtVKCyzGSpKDFa+J7qFOM0W8DwYLvwUoC9pum6LQRFUEy5Irk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=cwdBReli; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="cwdBReli"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=i8pdS6eQpLjPlkKCXHwzc6bHc6AP9CIqi5Aju+vkrwY=;
	t=1716570559; x=1717780159; b=cwdBRelilLBvMmNXRhFSzBnGD7LlzirZyv0yUlWa2lagSGR
	JDXywuj6CyLKHap9HgN4JEpvdPb+tSn0lEEUkIrlazNOSW9zXrjSZN21FwqfI7/LxajfR0q4lqgw2
	GUIGx5QLO1kDFyu1Re//KFiYz3yuKORQHE6BpWBu0ynZ41TiOFBOf09ZdTZRunB2r9T0IrFuVyL4Y
	Scw/8SYCgTxytmpfDwpdBxnIuDcu/7QdS7105S6bkaYWpbEA9JJND9OVGVZXqdeXNgMuxq/4mH8JV
	EWjDFY+x5to2mC4tR9hhTMp2mmbehMI6rDVcXZ727EWwIRhl9DvjHMCvVYYuutvg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYPt-00000008Xuw-0a97;
	Fri, 24 May 2024 19:09:17 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/74] backports: add kunit/visibility.h
Date: Fri, 24 May 2024 19:07:20 +0200
Message-ID: <20240524190906.048a9ecd29ec.Iacef906e369bb75e3c13557b3252f53e7442857f@changeid>
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

Starting from v6.7 some files include kunit/visibility.h
Add this include, since it was added only in v6.2 by
9c988fae6f6a ("kunit: add macro to allow conditionally exposing static symbols to tests")

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/kunit/visibility.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 backport/backport-include/kunit/visibility.h

diff --git a/backport/backport-include/kunit/visibility.h b/backport/backport-include/kunit/visibility.h
new file mode 100644
index 000000000000..a23992aa8920
--- /dev/null
+++ b/backport/backport-include/kunit/visibility.h
@@ -0,0 +1,12 @@
+#ifndef __BP_KUNIT_VISIBILITY_H
+#define __BP_KUNIT_VISIBILITY_H
+#include <linux/version.h>
+
+#if LINUX_VERSION_IS_LESS(6,2,0)
+#define VISIBLE_IF_KUNIT static
+#define EXPORT_SYMBOL_IF_KUNIT(symbol)
+#else
+#include_next <kunit/visibility.h>
+#endif
+
+#endif /* __BP_KUNIT_VISIBILITY_H */
-- 
2.45.1

