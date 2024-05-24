Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C333612C47A
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570618; cv=none; b=rlQLkpKWJzoLUl9YpwHas9UL0kb/PAPNhYdXTMiNUKtc0XBJ7tN5ZBuvMsxqpyb5ZmE3PPD1gt2vhPPC8Dud5YR8CIr9D4jpwjt5IabRLMplKYljTspEKjhD+EV2ocbvgDhwEUlb8dt5wP9XuaEvHOgD1UPY5W9o8adb74nKlhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570618; c=relaxed/simple;
	bh=MalQ4ztxdDjvtGhSd95byt99ldMxgJse8pf97tRKVhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pH15z928T0aSAiPl9ylSIMNE6Xgp9WqtN4PkNg9ec0/OiJU4FIl4SlvYjXHqcBeKsIpkaY9O69xqkFZN8KSPF0FQPH4vVchNiW/+3s1F6jPHxBa3YyOOeZcWAk3bSoPbD+aslB2vdk/EYKvhy2kGwuhQBtLNwl93plqqgmGlldE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=H+71q4lb; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="H+71q4lb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=x9tBYo31cMiQTEgoVxaV3LaPEtLHNp9dvGSL0pIPYNU=;
	t=1716570616; x=1717780216; b=H+71q4lbeIVY2DZwkXSXXooqV74wUXxM0BFU+E35p8raKLS
	7+kI4oagISRn0M+UrJ5RJd0TmXXZLC8ExPX54FxWP6P51wqEAoUdTu2K63F2ukyvjW+FhKzHd8Fo1
	p8k2rSta23zBIkzafmSNA6P/7iCknTZ4SruYMjJE9GAUfUGOCzFdiqFavhx9yZvtG7suOcmZuK0PF
	wokHAhRm0eFX5yT3xRpE3271Hx8G47Rx3KQOtuBtGQrNcr0j+LqMOVbs6UhDZ8v4me8tb6ays5de8
	jPN4nhYyiPvil3tdDlILf1AMePCDBrs0PhyxqQt7HC/Ve12iyWw1VjrcFwmSvaoQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQo-00000008Xuw-2Eb3;
	Fri, 24 May 2024 19:10:14 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 62/74] patches: fix wireless.patch
Date: Fri, 24 May 2024 19:08:14 +0200
Message-ID: <20240524190907.e9041a963b3a.I5f73b4c554ca85dc817dc46a57f5d6ef09a3b562@changeid>
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

Due to new includes, the context in the patch wasn't correct,
so the patch xouldn't apply. Fix it

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 patches/0013-fix-makefile-includes/wireless.patch | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/patches/0013-fix-makefile-includes/wireless.patch b/patches/0013-fix-makefile-includes/wireless.patch
index 91bddf547b52..73fd53628f65 100644
--- a/patches/0013-fix-makefile-includes/wireless.patch
+++ b/patches/0013-fix-makefile-includes/wireless.patch
@@ -7,6 +7,6 @@ linux/module.h include needed for 4.11 till 5.5
  #include <linux/moduleparam.h>
  #include <linux/firmware.h>
 +#include <linux/module.h>
+ #include <linux/units.h>
+ 
  #include <net/cfg80211.h>
- #include "core.h"
- #include "reg.h"
-- 
2.45.1

