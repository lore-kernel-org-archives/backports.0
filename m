Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5901A38FA
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532141; cv=none; b=NWVBepTxqEaRlAuQY6BpQXBb0W+7g7Bf+CfY9kU9WYCf1x9UF7JjjRk1fsjgTE+Q1IrXUpkrw5kk0UBICnF3hEUVsRhcDuHUtYCYSGB2H6hBRO//nw09qB4d4eVAKVzzHYTnq1qjxQXiOFZLt5XYPwpW4Z1osS7WbCTSCLzgqJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532141; c=relaxed/simple;
	bh=yBNgw5powj2h+4/USzITBJbUn68ilX9VHlYLSAHF/N4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vul2qxRKwkubyg4V1mHMc0+oFAgvgH4zQ3njn0leQlv8fwg6lQpiSsSPUgxhucrnsqixr/FDVN5besDNALKAMIEJPnmqGmbT+Fu3zKtPkJkWb+Uk+LdEe6o6buhQ+Brsb8NgBc9uEGVrwmB9QSNVrTZYmB7nHTIz+WdNZvOd420=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=fb2FO1g8; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="fb2FO1g8"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4W9Fdh4Mybz9stN;
	Fri, 28 Jun 2024 01:48:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rTjsoruO3fsh7wSYH5oWJNvR1tVPHQNo2KpnIXtkSOI=;
	b=fb2FO1g8G4BOMa88XuuV4xtYOnpGDxGCCSCMMIK8K61TmqlATIfyruDDBTl+boX0Ly3uJa
	PIPOSgno6wRD93oNRr78pq7tloHMWdmGc9qQDL/4OYKCNA9Vpm4PKFZ5r03YOmcxyKH9de
	ktm62sYO2B1QZdlLUqdR4AoTtde0tHayeWh/uW9unvSc+rsv7ym1aIb7VpSVYtBFyGl9uC
	uw0yr4r17P6xvU33GFqLm2MEuBTmz40x4s1Yln7RSMkxG48/NzEu72Gu+659076AHEe/Pv
	OqZp+5+pEbifwKWZWggvgUiV+nRR3v1Of7oJnrlV82fFdkKlr+yvrMbRtpYGFA==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 64/75] header: Add module.h include to firmware.h
Date: Fri, 28 Jun 2024 01:47:50 +0200
Message-ID: <20240627234808.1253337-65-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W9Fdh4Mybz9stN

Many drivers do not include linux/module.h directly, but use definitions
from it. They include the firmware.h

In later kernel versions this additional include is already done by the
kernel.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/firmware.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/backport-include/linux/firmware.h b/backport/backport-include/linux/firmware.h
index 9bfe6e9d..36d0702a 100644
--- a/backport/backport-include/linux/firmware.h
+++ b/backport/backport-include/linux/firmware.h
@@ -2,6 +2,10 @@
 #define __BACKPORT_LINUX_FIRMWARE_H
 #include_next <linux/firmware.h>
 
+#if LINUX_VERSION_IS_LESS(5,6,0)
+#include <linux/module.h>
+#endif
+
 #if LINUX_VERSION_IS_LESS(4,18,0)
 #define firmware_request_nowarn(fw, name, device) request_firmware(fw, name, device)
 #endif
-- 
2.45.2

