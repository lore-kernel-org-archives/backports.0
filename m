Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193F712F368
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570574; cv=none; b=pIyEUpiIpNBrCRjcOXFx9atu3ojQ22VB0xH5D4x+4L8nZIlVSdk7Mq6JNInUKq/VN41SFMwNwiKNRoEjEj2KZYbN1BHlQnQmb3gNTXUEpOiekaxgMztOpo1LW258x38fRRg8tPctw0KzyHvzb9NYEi0P+e2zwHHsdCgti173aYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570574; c=relaxed/simple;
	bh=rNWpoa5Q5ViEs5Tdz21NnFKyUxp59gwmvE0HxjicurI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JGr0cTXqXAIsk9y2BMTf/8kvgMeC/rucN0bxOMwE8bIr5+jN6iw2JN2PXicKg7shFoqhhk0i4VpLBf9T1MSBzqEizPthzNpqRsB/t0LsMmwif6F78nyQjpCswbcjGY4MYplocTyLcW+dTHCWuGwXxOGJw0OYZOuYJ9y2eYAD9T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=HaJP6RoW; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="HaJP6RoW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=6FzVekPIgKbvdGCYmzeGOKMEDjXdX5X9uweJ49eaSLI=;
	t=1716570573; x=1717780173; b=HaJP6RoW+SLA04JrEE7tthzHMuOEqY8FKvrHRSs8Gm2fp57
	W9OI/Y3P2N911BhzxnND8hiJ+vR0Weu7HFw6D+R6HJaeaxK9G5UQcsqJGUS/2t4n3RbeGdubnOpbM
	nXWJuGGz8XWZ1nekFXwegUqNek2H+Luzx7q/+TFO3MVwgwODvAVlcHGh+H46OQ/AMS/vb0Tz8Vkbd
	nB3XkQDXb7GfCvyaqiHnQRwuiYMeZ5JEEe1GZwTCn4wNJBJIod0/iE0CGYGynHb1xROT8HC4Ns9Wl
	K+r89EhN68Aq7JccQPbsO8EpjH2ms4TOExtCCNZ67RMtIU9vSJGaochIWgAPOpng==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQ6-00000008Xuw-2ByA;
	Fri, 24 May 2024 19:09:31 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 23/74] backports: add DMI_OEM_STRING for older kernels
Date: Fri, 24 May 2024 19:07:35 +0200
Message-ID: <20240524190907.e82b195cfd2f.I56742f3d6a096fd6c246fdf341af68b0962bdb90@changeid>
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

From: Gregory Greenman <gregory.greenman@intel.com>

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/mod_devicetable.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/backport-include/linux/mod_devicetable.h b/backport/backport-include/linux/mod_devicetable.h
index fc9beedb2d8d..07d66a6ba6ae 100644
--- a/backport/backport-include/linux/mod_devicetable.h
+++ b/backport/backport-include/linux/mod_devicetable.h
@@ -29,4 +29,8 @@ struct mhi_device_id {
 };
 #endif
 
+#if LINUX_VERSION_IS_LESS(4,17,0)
+#define DMI_OEM_STRING (DMI_STRING_MAX + 1)
+#endif /* < 4.17.0 */
+
 #endif /* __BACKPORT_MOD_DEVICETABLE_H */
-- 
2.45.1

