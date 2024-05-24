Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B77612EBD4
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570577; cv=none; b=h3w/SuYnSERQJcg5a66l3lCHiWtyyhoqRFsV8i9DJT7Dv3vA6JJlxU+SG9Y1zsbwL/WFzacbVwhAa+h9dcz56Tu2AUFgGqispSDLTvKcs7dFlnd4uNjePW5ZKPPeyLnSTKqpaOhc6B/O7d0rXm744UO3cxsMKUoF/PysfI5py0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570577; c=relaxed/simple;
	bh=qPk+41qETnIeg+w5Mq+sxv5OdNH6DTlPYAl/XRzTL4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ladMXSduvXc2cmxCXcvh1QrTK+xCKDi/eBtWsSgomPV5kas3FbwNyl8yW7ZIJqUNCzVwNu+Dmgo8Nre06GjRCFqO8gFaRCQVMwjfUIAdKzOkNYu1l/SuN3FNIU5Fv0PkRApXIYC1mLu2SAM/uz3fEiRyT1dTRPjhetaKUp+cWMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=eKEkKMA6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="eKEkKMA6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=NkrGxR4RNTYscWg8VbXL2HnuFhqWmSgHviSMJNlk6V0=;
	t=1716570576; x=1717780176; b=eKEkKMA6xHv6eyUWTtcPu/MFZoo/v14BWuPqD8AY6zOEev7
	/VTqjNTnKpVIwt6lJugs+UwYjV9AGYDrKLxtp6MMmTQ1pXoTDNiHlPsKuPTTMAjsAUQgPlTQyCRhZ
	7l95X6hLii5aG8+Ea0/IT4ZchqBIsHaBFoU0X5Qkpiz93D5AAkCR0zCQPGIGw1Vzwb4yK8rClp09z
	z9b/VjvwFVrW6XF6aa8llx5oyLDY9q/3kWT2E75+JRYTDtLCBMRTQO4CiRtP1UcKbaEYyDCHqtZvB
	92p+TEt0z3lT6NXv+9qtrs9amugvfuZtJkW4Rso9ICcS0l1hXHf4gZ9ztGLy6vzw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQA-00000008Xuw-1UA3;
	Fri, 24 May 2024 19:09:34 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 27/74] backport: add get_random_u32_inclusive()
Date: Fri, 24 May 2024 19:07:39 +0200
Message-ID: <20240524190907.9b29c2303625.I3466484d655a8d5dbf9208a3f64ea5a926dd844e@changeid>
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

For get_random_u32_inclusive() we need get_random_u32_below(),
implement it with prandom_u32_max() as it used to be in iwlwifi.

Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/random.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 backport/backport-include/linux/random.h

diff --git a/backport/backport-include/linux/random.h b/backport/backport-include/linux/random.h
new file mode 100644
index 000000000000..0a247321785a
--- /dev/null
+++ b/backport/backport-include/linux/random.h
@@ -0,0 +1,21 @@
+#ifndef __BACKPORT_RANDOM_H
+#define __BACKPORT_RANDOM_H
+#include_next <linux/random.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_IS_LESS(6,2,0)
+static inline u32 get_random_u32_below(u32 ceil)
+{
+	return prandom_u32_max(ceil);
+}
+
+static inline u32 get_random_u32_inclusive(u32 floor, u32 ceil)
+{
+	BUILD_BUG_ON_MSG(__builtin_constant_p(floor) && __builtin_constant_p(ceil) &&
+			 (floor > ceil || ceil - floor == U32_MAX),
+			 "get_random_u32_inclusive() must take floor <= ceil");
+	return floor + get_random_u32_below(ceil - floor + 1);
+}
+#endif
+
+#endif /* __BACKPORT_RANDOM_H */
-- 
2.45.1

