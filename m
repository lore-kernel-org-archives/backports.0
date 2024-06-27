Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C311A38D7
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532144; cv=none; b=CifrM6cHLZFnglmlid24jc5BhhBjyoJQm3t99u6xqiLl9qCFgLuDrjvDe6wFuJgLpvtNBVXGCveH8/fHMUcrWmMN2Pg5Y/iU5P/OCPxhVoSXGhw+gXZ4fvDV3cvyr4B2xJbYAwccwvPmkepbGvmQjfEYYFQLQAJLzDq7dcmMOGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532144; c=relaxed/simple;
	bh=xWSPPy0H2ESZEmu+Mix71JTlRez/enhhXgvYJDfrRIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPloGP2+3+p7QCdxUtA8jw2D9uIxbdYVdlfWVtAoLI8EqH8j2JSiCCzhB/EPyWfyjE6Kr3tJauzXKByHTV1wiBof7bjQ/qSuZKSz9McwIhKNRbu+zcoxQrWbujKP4N4Zw7yG9kJjtDLObUpcItn6TFQKCgUSVRKyOyr+D8d+UNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=Su8KkFOE; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="Su8KkFOE"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4W9Fdl25Z7z9t1B;
	Fri, 28 Jun 2024 01:48:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RMoznUXMnRM+jxX0nP+hu+kB5bLec8zkS9BlFEM2EXI=;
	b=Su8KkFOE8dch17UteG+GHydv8yI23K5GeigV6DUBQJ4THlfXy9DP+HJ1wzbcQ8QB2FcPLV
	r9kHdn3BEt/9O6kGS7z0HSjy9nTVVk0qldy7wbTRxBbGBCqzSH8Pq6bPZSvYbrwBtyLtRS
	rA1kiFAvLck39DYpSiHhUHvhUWrTB7l6JpMn3OaJMxYkihPxG/GDySC2x3VrwOijOlgX/X
	N9oLmhCL0SyIsD6hQXQvPq5lPEWLg/Pjvr6qvGphs/dSuF8+OYCGOf4W8aPytICfmB/Q59
	6Uu0eyMtC5B1Bavbb3ywzh45kT7aceCnMCTRBoTgZhquuTCAkBACAGevW87x9Q==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 75/75] CI: Add gcc-12 to devcontainer
Date: Fri, 28 Jun 2024 01:48:01 +0200
Message-ID: <20240627234808.1253337-76-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W9Fdl25Z7z9t1B

GCC 12 is needed to compile kernel modules for the mainline kernel
binaries 6.0 and 6.1 provided by Ubuntu. Add this extra compiler.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .devcontainer/Dockerfile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.devcontainer/Dockerfile b/.devcontainer/Dockerfile
index dee0c724..4a847e12 100644
--- a/.devcontainer/Dockerfile
+++ b/.devcontainer/Dockerfile
@@ -1,7 +1,7 @@
 FROM ubuntu:24.04
 
 RUN apt update && \
-	apt install -y git coccinelle build-essential python3 python3-zstandard libpython3.12 python-is-python3 flex bison libelf1 libelf-dev && \
+	apt install -y git coccinelle build-essential python3 python3-zstandard libpython3.12 python-is-python3 flex bison libelf1 libelf-dev gcc-12 && \
 	rm -rf /var/lib/apt/lists/*
 
 RUN git clone https://github.com/hauke/backports.git
-- 
2.45.2

