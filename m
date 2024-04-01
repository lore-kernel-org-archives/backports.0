Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19F955E6A
	for <backports@vger.kernel.org>; Mon,  1 Apr 2024 21:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712008574; cv=none; b=UWfgrArecxR2ky3/fJ9M5p0jcvucHU3ZS3gQYHK/T1V5QqkerpWSNjcPkygXXxBb7XJybEdUlKP2ASOyQq7zmH6yzQaiEDS6paZRu1vR25PaB287xcmBAq+1NysDIYof7SwRnPIneZJdmOkJ1tfAfowin6zVLTDylhCbFsbbcoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712008574; c=relaxed/simple;
	bh=fqw+SwBCUmAk0nPprvYuKMvLth0HSTzkgf4TIlXi+nI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=li1vsUBEyUX7X9Iv4wnYxOTsOH5V0HTMQ0fi7e687yLKz6nUI0oAzIFfX8MJQxNmm16WyMrBggs+7CicMnhnUfNW9m8n4i9lABDDcn6Y5ASk+iPNsG3pcdr361119lQEFArdtbobsnFUGjtsZbzpBrdNUyX/lI7oOCoaS1Z/eRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=lQ9WL3C6; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="lQ9WL3C6"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4V7lFb5dDBz9sTJ;
	Mon,  1 Apr 2024 23:56:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1712008563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cbqZ5SmQt+J/6ZMcg4lWCI82FFXVuTZiKEF2WPPTG3A=;
	b=lQ9WL3C6EqmVfc/sOrD1DgT7ax28lBPbt8rufGCKx5Ux9kJ+MgIvUljL9AV4T4neJnqpyG
	21D2oWMy1If+TtqvbhpHJiKbvxxnWGBPYd97EMwu9q6sVYQ+iQkysT3a6x1aIYxLPfxNIq
	nnzSWhiahdcb6RiIDfwnAIO3ZQQwA3ViL6Oin2Qj+ASxEITRD04llvkloKelOz5KuDFT1G
	wU9HSRJuU+yM1cxXIXDS1S0qtWQ8bZc+4nM/07vHhApTFFqRrYVJTGV5r8N5Uuh7EzHFAQ
	q9PMsVgDbpwvW+3HmnDAQAAu0jGMfnipNkQI4zpHGVjXTSSEuUPH3lM1rZjXwg==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/4] CI: Add libelf-dev to dev container
Date: Mon,  1 Apr 2024 23:55:32 +0200
Message-ID: <20240401215535.2432969-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4V7lFb5dDBz9sTJ

Some older kernel versions like 4.16 need libelf-dev, otherwise they
show this warning message:
Makefile:982: "Cannot use CONFIG_STACK_VALIDATION=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel"

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .devcontainer/Dockerfile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.devcontainer/Dockerfile b/.devcontainer/Dockerfile
index 5c387891..3894196e 100644
--- a/.devcontainer/Dockerfile
+++ b/.devcontainer/Dockerfile
@@ -1,7 +1,7 @@
 FROM ubuntu:22.04
 
 RUN apt update && \
-	apt install -y git coccinelle build-essential python3 python3-pip python-is-python3 flex bison libelf1 && \
+	apt install -y git coccinelle build-essential python3 python3-pip python-is-python3 flex bison libelf1 libelf-dev && \
 	rm -rf /var/lib/apt/lists/*
 
 RUN pip install pyzstd
-- 
2.44.0

