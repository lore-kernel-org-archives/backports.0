Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5881A38FA
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532137; cv=none; b=rb+okXCxBJo+KVlXGyqEPBHQzb90wPxBQ47NajDZ0tEWCgWaH0Ecl1qbV4J8V0ScdS84CJXtvEUzcLNWDygmchFNmoyXLghF+ZVVfP4KuXg/oBhK9baqasrH8lAW2jX6Uiz6I40kP33ui5YwYYsmSCUUN1BEKE+0bQSAMbVfIfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532137; c=relaxed/simple;
	bh=pM1/MmQG9WWW0LXFr2SNKhrj4QcPbztUS9MZBlz5QJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hzB09KHOjtm3iQ/8qUBxKNXVZlJuHlbo/swlAx/jCJ6R7l68DsuTI2A7WPEmDsNrWgtOx6Vk4qotmqh6lutgu3UGVuFW8dOtpFEp0kVXLqH6Dy90cgFGe/w/k59JVOKspkaYNBVj7teBnkuyrQzbZQ1dD9RFOD9mUPX+n76cWfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=o85847sn; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="o85847sn"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4W9Fdc0bp8z9spX;
	Fri, 28 Jun 2024 01:48:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=scD5PT/Mv0L6EdMItSGLxxsBttFe0H69Dzi0azZuAqA=;
	b=o85847snrGo4r6FCc9jaUx0pmNHMrNca6UWiMvZRmVQgYAyo57VjZnZUqHY7rhgUSGv9gH
	r2HBJHeeJIOw4C7MDPskCyK2DnfaOJxiPAoEFFR/3lTUWM8Nymw26Ex5YlEOgYxn+AffB8
	NZ1x8FfXF+EenYugaplYwLEP7X0Ah67CBZYHsjT+MYxKLcdL1ovsGQNNYIMXwFKlOfkzJb
	lPm4u8JZ1WfM/fr+0wFMt2J2vBugaDxyZSefzT4TA3hISlHgSzfjOoNiDVeDQ29EbrDCc7
	wuykiSNlbMY8/a2cqdM16Afp5QK64y2np1vEJe4ba7PZXM21Mp1k2r2oN95q4A==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 45/75] header: Add linux/platform_data/brcmnand.h
Date: Fri, 28 Jun 2024 01:47:31 +0200
Message-ID: <20240627234808.1253337-46-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The linux/platform_data/brcmnand.h file is used by bcma. The defined
structure is only used on some MIPS SoCs which activate CONFIG_config
BCMA_NFLASH.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/platform_data/brcmnand.h | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 backport/backport-include/linux/platform_data/brcmnand.h

diff --git a/backport/backport-include/linux/platform_data/brcmnand.h b/backport/backport-include/linux/platform_data/brcmnand.h
new file mode 100644
index 00000000..9b83d80b
--- /dev/null
+++ b/backport/backport-include/linux/platform_data/brcmnand.h
@@ -0,0 +1,9 @@
+#ifndef __BACKPORT_BRCMNAND_PLAT_DATA_H
+#define __BACKPORT_BRCMNAND_PLAT_DATA_H
+#include <linux/version.h>
+
+#if LINUX_VERSION_IS_GEQ(5,18,0)
+#include_next <linux/platform_data/brcmnand.h>
+#endif /* >= 5.18.0 */
+
+#endif /* __BACKPORT_BRCMNAND_PLAT_DATA_H */
-- 
2.45.2

