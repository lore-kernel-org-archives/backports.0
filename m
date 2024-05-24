Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184B812F368
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570572; cv=none; b=PNnMZ3/EaaXonw1bZzlRccoBM2GbaRkHzefHTEAt72TVKf4/geFgjYoghTAL22GeMhVUhjs6zbosZvVrU+L/e6OT9vnyGG+lmuvavpsX4KzRKKOVVIDCwOqrGWskpCiXVP05/YCdIX42zZv5sAQmEZYUnCGNdda4dvvt1ZuAvzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570572; c=relaxed/simple;
	bh=vQZD2Fsd7Hijy+zm/ifZ6emQeSpEi5NzWIl+MDVMMf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozHjuNU6pSU9g4VibPOzDDItR0CKe76IWNVzvgHXgKXKNjRHKPk5/KZkqIk5Zrn69atOinNb3bqAq6nNanB/k+o4WENe9QbCY9d4yZYKOCV4duRCYAezYnhSvxeljyNrQ6a6CkD/yTsvTELFq3Q1rxVWyfcIAMzvv7wLofor37U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=JIM2zYf+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="JIM2zYf+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=+O2DA3tQNMKX3Q3XGakLYKrh3dMC+0MKbN6TxQHgdRU=;
	t=1716570571; x=1717780171; b=JIM2zYf+CpqyXwyyalmVx91ddhpDkvkV0ImftfBwsdr13vb
	RMN6XM536i9f/E5DaM+l2aT5u3M8D05bbSa8mFBNDT3I2qQVdUhXgdcPPHefYN1Bzb4VXEOT0Tbme
	PNR3xuIqYKlltW19eF80aRd4EsKxUrw0YHOGuE1ny0dmUQsHwgoM1YU3bgeMbTdB5g+mn5q+I17IY
	Ik+JAaCBm1mkkVkl7y8rIh0S+o1fCePui+JL42ZIp3WS1SPTJ34kXzTUMeAuM5OwMPJNNL9tbedBW
	pkvo8ZLlJOqWAkO77TfaRkb1/g9G6RUaj6TJgW5uByjFcvhCVgd2pPLaRdCcEIVw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQ4-00000008Xuw-38Ra;
	Fri, 24 May 2024 19:09:28 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 21/74] backports: add minmax.h
Date: Fri, 24 May 2024 19:07:33 +0200
Message-ID: <20240524190907.a03ccc68063b.Ieb3178a725c066c7153ba92596b1bb42f4162a38@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

This is needed for kernels <5.10.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/minmax.h | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 backport/backport-include/linux/minmax.h

diff --git a/backport/backport-include/linux/minmax.h b/backport/backport-include/linux/minmax.h
new file mode 100644
index 000000000000..032bf3dfbbcc
--- /dev/null
+++ b/backport/backport-include/linux/minmax.h
@@ -0,0 +1,8 @@
+#ifndef __BACKPORT_MINMAX_H
+#define __BACKPORT_MINMAX_H
+#if LINUX_VERSION_IS_LESS(5,10,0)
+#include <linux/kernel.h>
+#else
+#include_next <linux/minmax.h>
+#endif
+#endif /* __BACKPORT_MINMAX_H */
-- 
2.45.1

