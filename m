Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C40184133
	for <backports@vger.kernel.org>; Wed, 10 Apr 2024 22:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712788115; cv=none; b=h4eALlxYqfCBfxUpo04yp4VH1eGcriOmr6FeiGxLU8kBrDuV7UuzyIXtsPQ/qIIhnGIkHLIn3gYQnYEFGr1GkYEeGVxGQgLfjHYLpgU26MeK1IurnJA0EE7YJCSstVglFtumOf7F5vOMFEmC9MAV/kS4wTYfyNCrKumwA4M8M/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712788115; c=relaxed/simple;
	bh=dKPw6nFYVczxYKDu18bKHPRt3yi2wOLIPm7ah7kvfHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CjXZDpKVXm071aIHa2pbXQA94aVzuM7QI28lUJHLozsDfiHL490sAg8EkfHa66Y35kpRGkVityhJY2st7hJZnsYEDFXWynVn+ZJM4d9ZHp6x1T8/wwBzwj1WvHU+y6Xm8CeIatZszFVjUz/Fs898yQGFEWHrqEp+LTahI1IXs6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=ZY9Max1b; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="ZY9Max1b"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4VFHMS5SSSz9sW5;
	Thu, 11 Apr 2024 00:20:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1712787620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNQNivS0ll1nEXX2vh+EE4/BT4YWrDgvVCdSc+zjwS8=;
	b=ZY9Max1b1vSD06EZSlWTDdHXwVTScnWKXrf93dCOudVVbi5jGGWcelIxUhRO86VdDESQbd
	AAnALn03EdUOmjrFYFB0epSUWj7C+8GJXXVEGq8fpFr9WZ2o6+1X45hHujJ54ZgnE1VW8Y
	kk8HeuRzW9C6QowxZ6aec36yLaS0RkSXW/HmZdPVW5ulN/JyUc9PmGUm1WkNvlJpdPoP+h
	U+XquGMziadS+9sDk22hYcENq9uQoImbOIbOHB4GtiUW1xyeT/+O0dmmP7I4rsObyvSkxu
	uB3PRfED1FTqlupSfrB5vzSSqbQBu5D70TCprpuzhJSxTBjEv+05uWLr11iDeQ==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/6] backports: Remove BPAUTO_REFCOUNT
Date: Thu, 11 Apr 2024 00:20:01 +0200
Message-ID: <20240410222010.1171249-3-hauke@hauke-m.de>
In-Reply-To: <20240410222010.1171249-1-hauke@hauke-m.de>
References: <20240410222010.1171249-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

refcount is only needed for kernel < 4.11 which is not supported any
more.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/compat/Kconfig | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index f7266780..637c5610 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -79,13 +79,6 @@ config BPAUTO_USERSEL_BUILD_ALL
 config BPAUTO_WANT_DEV_COREDUMP
 	bool
 
-config BPAUTO_REFCOUNT
-	bool
-	default y
-	depends on KERNEL_4_11
-	#h-file linux/refcount.h
-	#c-file lib/refcount.c
-
 config BPAUTO_SYSTEM_DATA_VERIFICATION
 	bool
 
-- 
2.44.0

