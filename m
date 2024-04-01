Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEFB56450
	for <backports@vger.kernel.org>; Mon,  1 Apr 2024 21:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712008576; cv=none; b=Y7gftB1YScfaUmGhvxk8uweVhOxllrUCBih3d8pWvy7ehQuzpX/Kg66Y9lgSqcLfbH89jeL3agTWCpvb1FREW2fwInM2A1A1MKLEkNJm+vXUa/OSu7lBQXslZzMKwl1TvaKt/rVlFjAURLaxZpO7kr3aN0fvxa+FJ1g1tPs80jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712008576; c=relaxed/simple;
	bh=yIHYz9LdNF/aEAN2LlHZmLdo6E0pDkeVZhVC6Xojas4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGboVZ7s04OG1Dg/pzW3UXsx5kD9cwZTFAoMv6vrjwRGJbM03cN5e6pluz07sMq2OnYbxsFa2G7ZGq5dzP2zbuIMiJIyKGXXptsyxeWK034QJNDCXN80iYQuJi/x9gZ9/dRFmdcqvJO0kTmiEA7k5aiDRDUZWTU+tZ1TD05ppUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=p1gB3PfB; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="p1gB3PfB"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4V7lFd3Sp0z9sm6;
	Mon,  1 Apr 2024 23:56:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1712008565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I9r9SO0RnWN25+Dj4rWnqUmZszmZlWuaUlbI2qAsKzo=;
	b=p1gB3PfBIBqnP0Qgpr8EA4pxwG8eY0gAnM8pkfOiXLcyU4Zy5dLQM7G+ZnrI4pxWC4RyUR
	ntsMjolhlDmu+U8M8lmwl90YP684/tsr7IL12VcIfpriIejY/Uw8Hte8fnsTJ1fXNHSFuy
	j/sTNifAV4YyjkUU7ajATUMA1dKjELxqZ7Hafu0X07SwAWqigXhPhfQZUgrfkKvFNrStvb
	DVqwWNxoDHQgktm62NeVf/sQrOO48EnC9viIw5uQyumDWKUYgbPkZhn7g4pY0nJYwRRUY0
	djCnqqqS29fjjBD0DDO2bIEATUWyR8cRk3IYBDveAVv6rqCcmyTvPxuJPNi45Q==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/4] CI: Use Ubuntu 24.04 as dev container base
Date: Mon,  1 Apr 2024 23:55:35 +0200
Message-ID: <20240401215535.2432969-4-hauke@hauke-m.de>
In-Reply-To: <20240401215535.2432969-1-hauke@hauke-m.de>
References: <20240401215535.2432969-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4V7lFd3Sp0z9sm6

Use Ubuntu 24.04 as the base for the dev container. The Ubuntu PPA
kernel in version 5.19 or higher are not compiling with Ubuntu 22.04
any more. They need GCC version 12 or higher.

This removes the pip installation and uses zstandard from the Ubuntu
package repository instead.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .devcontainer/Dockerfile | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/.devcontainer/Dockerfile b/.devcontainer/Dockerfile
index f758c9cb..cdf5d124 100644
--- a/.devcontainer/Dockerfile
+++ b/.devcontainer/Dockerfile
@@ -1,11 +1,9 @@
-FROM ubuntu:22.04
+FROM ubuntu:24.04
 
 RUN apt update && \
-	apt install -y git coccinelle build-essential python3 python3-pip python-is-python3 flex bison libelf1 libelf-dev && \
+	apt install -y git coccinelle build-essential python3 python3-zstandard python-is-python3 flex bison libelf1 libelf-dev && \
 	rm -rf /var/lib/apt/lists/*
 
-RUN pip install pyzstd zstandard
-
 RUN git clone https://github.com/hauke/backports.git
 
 RUN /backports/devel/backports-update-manager --yes --no-git-update && \
-- 
2.44.0

