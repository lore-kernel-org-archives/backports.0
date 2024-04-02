Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54491E531
	for <backports@vger.kernel.org>; Tue,  2 Apr 2024 23:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712100123; cv=none; b=s2w4YKeRy13Vg/kKGxqgpcneQMmlvXwO0K60cNGIN0Gy4E/Lfux92TtlosCxZgnuV0PWIb2kZnAgqGNOehwLXEbeREWLYBPFoqhTWL9L6Ca1ZHk7BZJP6wbHOdCQVrR4Mp6NZrLtNW5Lzumlh9n3JGVW55lA/HclgUcclmOepS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712100123; c=relaxed/simple;
	bh=eM18CpfM6iysUIPGgpT3PaL504OMFu/L9x7H1BFw4YY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m3mXQi1vIyMgEyUWGa4n8VJqimkX6OfRjbzMXdF8Vc7VGYOg6yPQ3ihsxllebAK8dmw3BPvvZwyFXMY077LBzwzp52XkSG8RAHhAV4QSGe5L+1yjQ2j/cq6BID7sT7yto2nNUvqRcEGXbYWj3ryVDLD9p5QPwGQ4N0fPfSWgWU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=YI50IEIO; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="YI50IEIO"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4V8P680J2hz9sqh;
	Wed,  3 Apr 2024 01:21:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1712100112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=do1SBW6I+1gunWZpDAV8OUDpPanFpjBIT9hMsRuhnvE=;
	b=YI50IEIOzP2BDOBlP2bGep0K2ipolfGhJMSMa3HRmGD0MKMu7w8ESLoQPJLj3JCCpdgJhe
	y+O6Wu7qeM4pznOqiOu+qNxPSlhGUbPg0b0Q4WKnQE17g+ZatzoVMjrvo7LG+LpWsASeu1
	X7UvVZrzhkOJanAuIwtT/gtYwQTRcWvNNcxcLBKRd4SwZF8TJ1aVYw6rMLZHUiRXKn7vyT
	SWBPwGYxuKlCjiwYTNS8EsPq22qqXs2AV7tUCDa3kpT1AV3aJiQKOWIRY7+EHGLry7DgH/
	NuMLKp+x/q8iWDGVXMzgiQ+uJvSBdSHGQvAahkRWuT8qX5bcZFa6eaoH3xjThg==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] CI: Add libpython3.12 to dev container
Date: Wed,  3 Apr 2024 01:21:46 +0200
Message-ID: <20240402232146.2766703-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The coccinelle python extension needs libpython3.12, otherwise it fails.

Fixes: 5b3a658d91d7 ("CI: Use Ubuntu 24.04 as dev container base")
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .devcontainer/Dockerfile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.devcontainer/Dockerfile b/.devcontainer/Dockerfile
index cdf5d124..dee0c724 100644
--- a/.devcontainer/Dockerfile
+++ b/.devcontainer/Dockerfile
@@ -1,7 +1,7 @@
 FROM ubuntu:24.04
 
 RUN apt update && \
-	apt install -y git coccinelle build-essential python3 python3-zstandard python-is-python3 flex bison libelf1 libelf-dev && \
+	apt install -y git coccinelle build-essential python3 python3-zstandard libpython3.12 python-is-python3 flex bison libelf1 libelf-dev && \
 	rm -rf /var/lib/apt/lists/*
 
 RUN git clone https://github.com/hauke/backports.git
-- 
2.44.0

