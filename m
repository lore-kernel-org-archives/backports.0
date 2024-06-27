Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCBC1A38F5
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532143; cv=none; b=TIJjS5HRcv9R6ff6+BU5NGbvHwSbMVHptVI10EiI23rCaCsp7t6zhM33aFxmTioXW18ltc/X043frEFBp2qhWtaZU1/5UH2ySPZDSK9QAwft/4bwqE9iZ5TsiGZyR/+innhJG6oIHmK0FD84mZ8EK+/W6qq6e+isZTb0QVQuwdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532143; c=relaxed/simple;
	bh=UHbYPHVt4vkF/X8dLLDZrVX84cI30ZKMxLfxxKdZYAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sO773uDRODyo9Uv0M8KBlE6fsxl4C2JbIAPKd+AO77UnSS4MGgeEbs0vrtA2u6rXxF9WgqU+CgsIV82s9iA3KeGMO6akor3fXBriThN5Ca8r51WHMB4DpZQNskA7XcIolb7WVClVGIQ2BeFdt2lsvzLek2zDnvsgmAxVUlOXpUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=MsSaEnJR; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="MsSaEnJR"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4W9Fdk4Fryz9spN;
	Fri, 28 Jun 2024 01:48:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N+2o1Ny7djyY3vzd7VtC/ByW9KHhEk6tU9L6GL2BPwY=;
	b=MsSaEnJR9qQ7Vk4eVPjgoAGHddMFkwpx1ksWKMFbvbJBTrKWLcGFBpodhaFO1N583QCAj0
	59934uFv4Rw3cHFBFH5v+PRu8IgYyrXMpcpUHhy1miZ60SFaW9UoUbiWBq69VLdRCgUko8
	OrImMWAPDiEJ+X3kIfRMVFziQFNdrqnHSSQSvItSWUkqQB+jMYqshgsIkfVS/KnidpvlIL
	pYbX6xtEPb6k/0vN4Zx/ND4bcm4/xt01wYfyDiT2JO2eWgEpbWzULnxP9S/4BCA2DFun//
	4YOzXQY4vc4tNSZIbcSxqygTURjJ0dGShihV1x++7HXrwf4SAFGQhL0azkv17Q==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 72/75] github: Use kernel 6.1 in github action
Date: Fri, 28 Jun 2024 01:47:58 +0200
Message-ID: <20240627234808.1253337-73-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W9Fdk4Fryz9spN

Generate backports from kernel 6.1 stable branch and run compile tests
with kernel up to version 6.1 in the github actions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .github/workflows/create.yml | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/create.yml b/.github/workflows/create.yml
index 36e6c930..c9fdf6a2 100644
--- a/.github/workflows/create.yml
+++ b/.github/workflows/create.yml
@@ -19,11 +19,11 @@ jobs:
         with:
           path: backports
 
-      - name: Checkout kernel 5.15
+      - name: Checkout kernel 6.1
         uses: actions/checkout@v4
         with:
           repository: gregkh/linux
-          ref: refs/heads/linux-5.15.y
+          ref: refs/heads/linux-6.1.y
           path: linux
 
       - name: Generate backports tar
@@ -77,7 +77,13 @@ jobs:
            "5.12",
            "5.13",
            "5.14",
-           "5.15"]
+           "5.15",
+           "5.16",
+           "5.17",
+           "5.18",
+           "5.19",
+           "6.0",
+           "6.1"]
         config: [
            allyesconfig,
            defconfig-wifi]
-- 
2.45.2

