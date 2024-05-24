Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2C212FF99
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570565; cv=none; b=FGq0FFfsVnH75QiUd2Y8EaaMWaKPkXnyiU4Z9+B3NkoLs7Vi1D7Q3BzmKcg3NtCKNBPUgGJGXjIfh0HwaliD2LHCrPE/wkyqlgkh1j7yUQ/k2KALSR2Ic9g4OjCNmfmFeudOfOeiBq7oEefwoCopewPp6g4586khE018WqovMW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570565; c=relaxed/simple;
	bh=ehVi5JeyWJ2MfX20TowfjYIbJrnP0fqPMwG2SzpoUtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k8V/CSs1d29cYUR+29V/9E+SginsOcjZ0INgVVAhhRl4QfWsGJqhZtMAh+I38z6l0WaSPaowNyRF0e/koBUZMJ7L2nQOliUENYMG8VMajA06Uwk359i9GfmPcl7PL31/lo1HiUyENQyPg21AfnRnAQly6zxDMFyvB6kKgXfkxGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=xLWJlTiz; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xLWJlTiz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=GBlOymK+FeUdBpnMV1u4rGy98CNdgkxOk3nTIFGENOA=;
	t=1716570564; x=1717780164; b=xLWJlTizN+FXWJScbPXsjFZSDOczJohbS8oalu/GgpBKNlV
	KcbhKB9Fp6YPFHDNwi2sTyNSqfw5ZvcaiGh714dOpliJTxE7XnJjrY4ZbeH2kvQCggSWtcRY16Dkq
	aUkmUlBv2hT9MUUELpICSwwwzxizpeY0qG5ZWTfxtXXDC8oOgqij5j7YwOr4ezCnBLG6pX9COBaN/
	wf2n9ZKBPNemtx1c3kvRMv7oZAZEE+R4yORBWeAzq8RNn2z4r9Wfp8obmdIQj8M4Pc+cWdmRo32GP
	e4O35Ez4lsPmUS1l1+G+/PZpCXnCpfUyExt4TDrJhlLPdEy7lfdDq3zOJFDdlGGw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYPx-00000008Xuw-4BL1;
	Fri, 24 May 2024 19:09:22 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 14/74] backports: add eth_hw_addr_set()
Date: Fri, 24 May 2024 19:07:26 +0200
Message-ID: <20240524190906.74a3fa97e08f.I04584880e09adbe7318583f88d24358005f95ccf@changeid>
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
 backport/backport-include/linux/etherdevice.h | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 backport/backport-include/linux/etherdevice.h

diff --git a/backport/backport-include/linux/etherdevice.h b/backport/backport-include/linux/etherdevice.h
new file mode 100644
index 000000000000..c11b86d55801
--- /dev/null
+++ b/backport/backport-include/linux/etherdevice.h
@@ -0,0 +1,20 @@
+#ifndef _BACKPORT_LINUX_ETHERDEVICE_H
+#define _BACKPORT_LINUX_ETHERDEVICE_H
+#include_next <linux/etherdevice.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_IS_LESS(5,15,0)
+/**
+ * eth_hw_addr_set - Assign Ethernet address to a net_device
+ * @dev: pointer to net_device structure
+ * @addr: address to assign
+ *
+ * Assign given address to the net_device, addr_assign_type is not changed.
+ */
+static inline void eth_hw_addr_set(struct net_device *dev, const u8 *addr)
+{
+	ether_addr_copy(dev->dev_addr, addr);
+}
+#endif /* LINUX_VERSION_IS_LESS(5,15,0) */
+
+#endif /* _BACKPORT_LINUX_ETHERDEVICE_H */
-- 
2.45.1

