Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30E712EBFA
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570562; cv=none; b=FIfSKwA1N8TAaj2ILqjj8Lftjj98Ve+h6v9NVgpjaewUX5bjsN763V/+OiX6Cd338qVnX6RdEPVsVXz6/Ii6qSNTkv27fWat3+qH/2dW8FIQ75f+ziHH695RFWnBmMpcwpcw1uE7eBSSNlntGB3YhB0ZZBNXbsE7UOf7QZjUGMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570562; c=relaxed/simple;
	bh=xe8aXH8Q9GOswjxbXIEt1zRZkApRo78XjEnuzNT9tZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KlgBXaQ8+vqecOEcPoLSucX7GRKKNWTFWJrh8CAAGfhOM9fxG4VxOeNQVaEnSi27qQ8LFkSWftYtcug9VLpjEpXq719cVFEY6ykT78DW6G29ritRL8QNP/f2xxVM16WmjMw4NqPUnaqhoQ+y72V04vbX0rcponXcYTpVbri4SoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=nzu686FD; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="nzu686FD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=p5QvOtzigV01fB/UiL5YWT4Deg0v2qfm6tS+X3vdKAY=;
	t=1716570560; x=1717780160; b=nzu686FD3sQbk+A8ums8I7ArLzFgeiZ90gCHWhWL6oCjJWD
	uo0p3wAq4roKBF3T1R4gOltSYjv+mZBmZ6pcCwFwkv1I/2TX1WWAkNEDCV8AVCsnjOaOyjp+ZZ6Xg
	/ptefpbrw0jF1HTSjr0PzcggYXw/+ILp7rbmEOE1MUUuLvzXmdEN03t39wpiI+olh8NfKtnDhIKvn
	XCqmyebWbi//SMB3Mtb6zRYOc3AEQV6u/UGXvA4aQVnTG0nCeIDNPXxSDeAxz/gYDtkwHRblgBWl8
	o1L9WMlF8HJoMfOyiUt3cY+2J22kMUifh+bj/W/oeqO9LTNhAP84i7tDYQsSbROg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYPt-00000008Xuw-3L5S;
	Fri, 24 May 2024 19:09:18 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 09/74] backports: add linux/acpi_amd_wbrf.h
Date: Fri, 24 May 2024 19:07:21 +0200
Message-ID: <20240524190906.949a500a035d.Ib2f48d784990a93132d04cfc5112e8a7c5cefc1f@changeid>
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

Starting from v6.8 some files include linux/acpi_amd_wbrf.h
Add this include, acpi_amd_wbrf.h was added in v6.8 by
58e82a62669d ("platform/x86/amd: Add support for AMD ACPI based Wifi
band RFI mitigation feature")

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../backport-include/linux/acpi_amd_wbrf.h    | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 backport/backport-include/linux/acpi_amd_wbrf.h

diff --git a/backport/backport-include/linux/acpi_amd_wbrf.h b/backport/backport-include/linux/acpi_amd_wbrf.h
new file mode 100644
index 000000000000..6946058e05cb
--- /dev/null
+++ b/backport/backport-include/linux/acpi_amd_wbrf.h
@@ -0,0 +1,38 @@
+#ifndef __BP_ACPI_AMD_WBRF_H
+#define __BP_ACPI_AMD_WBRF_H
+#include <linux/version.h>
+
+#if LINUX_VERSION_IS_GEQ(6,8,0)
+#include_next <linux/acpi_amd_wbrf.h>
+#else
+
+#include <linux/types.h>
+#include <linux/device.h>
+
+#define MAX_NUM_OF_WBRF_RANGES	11
+#define WBRF_RECORD_ADD		0x0
+#define WBRF_RECORD_REMOVE	0x1
+
+struct freq_band_range {
+	u64		start;
+	u64		end;
+};
+
+struct wbrf_ranges_in_out {
+	u64			num_of_ranges;
+	struct freq_band_range	band_list[MAX_NUM_OF_WBRF_RANGES];
+};
+
+static inline
+bool acpi_amd_wbrf_supported_producer(struct device *dev)
+{
+	return false;
+}
+static inline
+int acpi_amd_wbrf_add_remove(struct device *dev, uint8_t action, struct wbrf_ranges_in_out *in)
+{
+	return -ENODEV;
+}
+#endif
+
+#endif /* __BP_ACPI_AMD_WBRF_H */
-- 
2.45.1

