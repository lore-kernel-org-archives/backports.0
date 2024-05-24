Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6433B293
	for <backports@vger.kernel.org>; Fri, 24 May 2024 18:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716574281; cv=none; b=YHTl0GfwoduwDJkyOj/JsU810ngx21n6AdZMGlsbEvf27cZbBOVcMLaoXAS1qq7UFL8lodDYeZK0x6b8J6ybtvXd7TNEZgdyKc8B1jnFYbIQ8FJolJemtBcenks6FU5y0SjmnfilIi4aRsX5m/DmZCfhKdKcrC+ZI495o7Fz6/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716574281; c=relaxed/simple;
	bh=HReAuXjsKBkm/DTPVIsfuIMU33zcz/FQH96Z8S97Jh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bngjbitr3qCMUitbD+cTE0bZrRNfLunNgd3+6kFWQshNE7dLps2GCL7d6JIU4oIFeT5D9SgMQ3aBC4QDWXXCVdA4eXLCPVOQjxbM/Kus6Cp0JNDNqqd23FhGw4EFAtioCBKQ8p6MX6PSdIsJR3bxCX47TxZRC7gES7xRApklQP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=L3eJ6gsV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="L3eJ6gsV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=46Xw+6MAscuRp6cqc5Gj4lIALhS5GftQ2RGvLUPe544=;
	t=1716574280; x=1717783880; b=L3eJ6gsVBDzMb3P+2rISltv/pxS3EVPHIjQe2EGeiHwBD+R
	nqH0yVOjJoMC3YO4xI1OgBDmKhvQVzDqLVnpLhZRCgNbxEgw7vK846QkRfkJAli/avz3+aFvd63ZD
	+26TFVe2OZ6oeG4Q8xPYxU8of79n1kjjTbdbSt21a4vVbeD1YUZoQOn4PIHG3lS5qNQ6QoaVjTo48
	qvCaBnkqR/2O9QUXrF6ZXkJ9goJuey46Rrzt3vhvBCrq9yKJglUW7Xv1ME9NeJ3vMSTfAh1HgOzXO
	PC2Fioz3V2d7Qz2gB+gGXalWO5K92QzdBLH19gV+6yXGwxDXtmx3uIDvZLnBqYew==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAZNt-00000008bYt-3MYl;
	Fri, 24 May 2024 20:11:17 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/3] patches: fix rtw88/rtw89 include patches
Date: Fri, 24 May 2024 20:11:13 +0200
Message-ID: <20240524201112.17eead9a6574.I272714479000f00f2bb83929a29a4690483be157@changeid>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524201112.bfc1a1eeddfa.I6ae09dfd2061693745358ecdac5f703f96b07e00@changeid>
References: <20240524201112.bfc1a1eeddfa.I6ae09dfd2061693745358ecdac5f703f96b07e00@changeid>
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
 .../0013-fix-makefile-includes/rtw88.patch    |  6 +-
 .../0013-fix-makefile-includes/rtw89.patch    | 72 +++++++++++++++++++
 2 files changed, 75 insertions(+), 3 deletions(-)
 create mode 100644 patches/0013-fix-makefile-includes/rtw89.patch

diff --git a/patches/0013-fix-makefile-includes/rtw88.patch b/patches/0013-fix-makefile-includes/rtw88.patch
index 41dea13e103f..d9e87b9d1eb6 100644
--- a/patches/0013-fix-makefile-includes/rtw88.patch
+++ b/patches/0013-fix-makefile-includes/rtw88.patch
@@ -3,9 +3,9 @@ linux/module.h include needed for kernel 3.18
 --- a/drivers/net/wireless/realtek/rtw88/main.c
 +++ b/drivers/net/wireless/realtek/rtw88/main.c
 @@ -17,6 +17,7 @@
- #include "tx.h"
- #include "debug.h"
  #include "bf.h"
+ #include "sar.h"
+ #include "sdio.h"
 +#include <linux/module.h>
  
  bool rtw_disable_lps_deep_mode;
@@ -13,9 +13,9 @@ linux/module.h include needed for kernel 3.18
 --- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
 +++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
 @@ -14,6 +14,7 @@
- #include "reg.h"
  #include "debug.h"
  #include "bf.h"
+ #include "regd.h"
 +#include <linux/module.h>
  
  static const s8 lna_gain_table_0[8] = {22, 8, -6, -22, -31, -40, -46, -52};
diff --git a/patches/0013-fix-makefile-includes/rtw89.patch b/patches/0013-fix-makefile-includes/rtw89.patch
new file mode 100644
index 000000000000..2e99d4770781
--- /dev/null
+++ b/patches/0013-fix-makefile-includes/rtw89.patch
@@ -0,0 +1,72 @@
+diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
+index 0d010548f7d9..4974aed78f91 100644
+--- a/drivers/net/wireless/realtek/rtw89/debug.c
++++ b/drivers/net/wireless/realtek/rtw89/debug.c
+@@ -3,6 +3,7 @@
+  */
+ 
+ #include <linux/vmalloc.h>
++#include <linux/module.h>
+ 
+ #include "coex.h"
+ #include "debug.h"
+diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
+index 19001130ad94..51c3fab1408d 100644
+--- a/drivers/net/wireless/realtek/rtw89/pci.c
++++ b/drivers/net/wireless/realtek/rtw89/pci.c
+@@ -3,6 +3,7 @@
+  */
+ 
+ #include <linux/pci.h>
++#include <linux/module.h>
+ 
+ #include "mac.h"
+ #include "pci.h"
+diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+index 51d3e61eaa1d..09d2d2859d14 100644
+--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
++++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+@@ -2,6 +2,7 @@
+ /* Copyright(c) 2022-2023  Realtek Corporation
+  */
+ 
++#include <linux/module.h>
+ #include "coex.h"
+ #include "efuse.h"
+ #include "fw.h"
+diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+index 2deadec715cf..be2fac9ad72d 100644
+--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
++++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+@@ -2,6 +2,7 @@
+ /* Copyright(c) 2019-2020  Realtek Corporation
+  */
+ 
++#include <linux/module.h>
+ #include "coex.h"
+ #include "fw.h"
+ #include "mac.h"
+diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+index d025c4135e1c..856223579b29 100644
+--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
++++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+@@ -2,6 +2,7 @@
+ /* Copyright(c) 2019-2022  Realtek Corporation
+  */
+ 
++#include <linux/module.h>
+ #include "coex.h"
+ #include "fw.h"
+ #include "mac.h"
+diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+index 17e6164855fa..c225d3c00d19 100644
+--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
++++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+@@ -2,6 +2,7 @@
+ /* Copyright(c) 2019-2022  Realtek Corporation
+  */
+ 
++#include <linux/module.h>
+ #include "chan.h"
+ #include "coex.h"
+ #include "debug.h"
-- 
2.45.1

