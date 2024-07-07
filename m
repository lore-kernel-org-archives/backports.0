Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882F76026A
	for <backports@vger.kernel.org>; Sun,  7 Jul 2024 22:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720393027; cv=none; b=oKv9h6JU+ZsPFRQHibRUoQJvocBBZM0gmbXr6+vszvF2qSVugqw0i0/r/JltkjseeiJrEGDoYx/P+sdDJuCDKDcGdkjBmIFe17JmTWm64rhBySg0Fu8pC9dWehKNPNeIjOwadnn64ZRqmU6YpVbvjyznbZ0H5cDv9vseWHaq/oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720393027; c=relaxed/simple;
	bh=K0fZXpHUN3UWj8WKPMspY1/X27K6esrVaNSa8d5ybQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AuAjarIPQvpSx3gbXJGjImwRWoRa/ZtBbTjdgmI9UG7vrmpIYzfxOwJ+hpUVHkq/1P0HDhiYHISy/L61eQ/9eRbe668pjXDSeKDjmzuTMInYYn+yadL0t1rgfi3k441rNSQQE/HRDCv+2bGoMVoOXKkNoT0zbbFkGH7vhZUCdG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=s5lmiVcW; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="s5lmiVcW"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WHN1864nrz9shP;
	Mon,  8 Jul 2024 00:57:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1720393020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EhYvqH8vdm4dS1rFfnWgXZ2lmyapyzU/TAIuSR3zrzk=;
	b=s5lmiVcWlpQf+76SOA32vtsWiNV76Gl/t3vPHRXttec+0ymAggqPq5cV91xtKMQ/PqIgqG
	duw41XC4/swOKGXZKty+IfY90ThZqxEt7pRj08UbrhdYbur7SwZlVZfogstwZTv2GQIAQu
	gestWIrasc+WmC/l5bEhd1yWDNsrQh9v8D9ZbjONJtj3RVh3UOk2/eLJPVUuJbwtTOYbpZ
	kU06V8DlzigtlJZr453kuX8MGGd++jILr/mriMXVjRIun6izl4tByd22fAtnzExn/K/RML
	lgmBYUITraAwLBddVf8/vogkfU/Fpj/V4kN4q9xRynicmgBGQ6UwM/OnfdrJiA==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/8] headers: Add BCMA_CC_SROM_CONTROL_OTP_PRESENT
Date: Mon,  8 Jul 2024 00:56:42 +0200
Message-ID: <20240707225646.1924882-4-hauke@hauke-m.de>
In-Reply-To: <20240707225646.1924882-1-hauke@hauke-m.de>
References: <20240707225646.1924882-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The brcmfmac driver needs the BCMA_CC_SROM_CONTROL_OTP_PRESENT constant.
Previously this was provided by full headers of the bcma subsystem we
shipped. Add this extension manually because we removed the full bcma
now.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../linux/bcma/bcma_driver_chipcommon.h               | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 backport/backport-include/linux/bcma/bcma_driver_chipcommon.h

diff --git a/backport/backport-include/linux/bcma/bcma_driver_chipcommon.h b/backport/backport-include/linux/bcma/bcma_driver_chipcommon.h
new file mode 100644
index 00000000..5a53b8b1
--- /dev/null
+++ b/backport/backport-include/linux/bcma/bcma_driver_chipcommon.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef BACKPORT_BCMA_DRIVER_CC_H_
+#define BACKPORT_BCMA_DRIVER_CC_H_
+
+#include_next <linux/bcma/bcma_driver_chipcommon.h>
+
+#ifndef BCMA_CC_SROM_CONTROL_OTP_PRESENT
+#define  BCMA_CC_SROM_CONTROL_OTP_PRESENT	0x00000020
+#endif /* BCMA_CC_SROM_CONTROL_OTP_PRESENT */
+
+#endif /* BACKPORT_BCMA_DRIVER_CC_H_ */
-- 
2.45.2

