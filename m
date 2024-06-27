Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BB61A2FD6
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532138; cv=none; b=QIuZ7dxQM+bTfYBH9vtmvkX89oauCDhpe/cH+tCa54zB83ooTCJkuiNrIJhqdu/H3kVrxBLDalyz9MC8JtwqW5uWrNNzYxxSjYQvYS5XFPT8xaW2z/MGxYBCIYnPqlGp5ougIICyzVDCi/ke10PsdiNK2LUA+9OT9p4791qjbLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532138; c=relaxed/simple;
	bh=rDA1ZLcTgXANcEnCZR+IdqZT6TLddg6VQ7c4YGRY4fM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J0iDuEn5Nvw7vVJBuhc0PbFvteFqd/nIDL6oFReTSb+zPGOxHl8WiVN0dQq0FekUPUEj342gjCT8i4ayucnJfnw2vUfRJaq7gQeAGLkYVF00bcR4KYRhLtLxtw8rCMKusrB9IkumwnPppp3CLSZYQVA40ygLK4dbW10tq3sL4oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=pbbCY9DK; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="pbbCY9DK"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4W9Fdd1sLmz9sW2;
	Fri, 28 Jun 2024 01:48:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oiJ2U4J5Pvi1CIZFDhxMe/rPm3iagjYQjKSDpGNEjmY=;
	b=pbbCY9DK1m7Qf/4Knax2oAPXruI3LuBY686rX+N3LcNhuDgajLRl09iRoRxS4QQ80B/dtk
	+eJyoJZPcVWK4xiHQ7q2wDS9itRWjUc/olqbXQKlkg08hbd/Hr9MZMPDtPdKZPQnAFoSGR
	Nlqh5aswDvCRzTZxoi+qYqGgCx7oJtb+R60jUGJ8wBEGf7/m/Sh/CD4uWFI0UCGvOSnr0D
	/1YtmbnLWyZcwVIO2OOL9dYVnyJVyhIp4hEbSLuNfYvGhdprEe+x5dc+s4JkFR4DnHvKDn
	CkOBAF4Z+LhEKFn4Y0H232Iek5lyj1psIpo1z8yHNJVs4NRgaASCKqq7JPfjNg==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 50/75] backports: Use compile using GNU11
Date: Fri, 28 Jun 2024 01:47:36 +0200
Message-ID: <20240627234808.1253337-51-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The upstream kernel switched to GNU11 between kernel 5.15 and 6.1. The
code makes use of some extensions now, use GNU11 too.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/Makefile.kernel | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/backport/Makefile.kernel b/backport/Makefile.kernel
index a936eb3b..155e1ff2 100644
--- a/backport/Makefile.kernel
+++ b/backport/Makefile.kernel
@@ -32,6 +32,8 @@ endif
 
 subdir-ccflags-y := $(call cc-option, -fno-pie) $(call cc-option, -no-pie)
 
+subdir-ccflags-y += -std=gnu11
+
 obj-y += compat/
 
 obj-$(CPTCFG_CFG80211) += net/wireless/
-- 
2.45.2

