Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5FB12C47A
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570616; cv=none; b=WIFa/L7jUj+YP4RSFjP9GQCKf+msxJ48nbryixrT5M5u587lMiB0QBI5QYEhip4En8l02GMWt5k4nO93h7GOb5dE0xDghIHKppoa0dM/BZjaUFPaMcDP23GSoc35EVR/xHNt4WJCEGGcySGmJ1DM6qwwYoIAiU9qkBd7Ed4sSz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570616; c=relaxed/simple;
	bh=hnIv8k7AGSMrRO0Lkc9hX0SBCEdV+wob1YQfq4HIM4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNLgBAO76ztGVeCi+T/5r75sHjTbz+M48/bIV3ZJdHSYPu5zFSHhIe8shUCWw5KjPcWJeIQfObE4ryAjttQqh/mr7ERQXgnMtacvmfl5MYFxvDh6qy+GA6KF4BWZvukP50e10RCXGrBTHxtho6I2qXgqx+ow79tIw3y+KK7tvUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=R3mHWN8z; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="R3mHWN8z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ZeuvC6wIFo8nkNse/4fxCqWveHds8KWLJUsSSlSlaFQ=;
	t=1716570615; x=1717780215; b=R3mHWN8z6ig5EUIVFJLiqSQml3iE8OPSQgSFOymghvduvDJ
	hZquOEfUcYwtUqoPiwtCfHrrn51btnlwHjRu/eGfHSUYiYvsm40qGY0Wx/MUA9GiM3T/KA/hlM2ns
	L3KEb7JAwTqHZU2AziW6Juie9sBTHM5ezaurazTf1+PWS7K8rJp1BDxrvtzN/92F4LDOWbJw33tiP
	MkvhCUH4NXSl57VKdDz0mEUueVV8eYfXfyopxjFyKXSLcZUtGEilY54RGr5YlO8Jv3rA+U1zOg6hz
	nKMpnHqFBGnYIS1JjjtTZkX4oK7aunmzVY9C9upxq7gQjJFvagh6ZWMORTyrMu/Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQm-00000008Xuw-39TT;
	Fri, 24 May 2024 19:10:13 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 60/74] backport: update pv trace fixes patch
Date: Fri, 24 May 2024 19:08:12 +0200
Message-ID: <20240524190907.2a42037697dd.Iad456095473d72f9fa005814c81b0b45be8e49a5@changeid>
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

From: Luca Coelho <luciano.coelho@intel.com>

One argument was removed from a trace, so the old patch was not
applying anymore.  Update it.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 ...ivers_net_wireless_iwlwifi_iwl-debug.patch | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 patches/0018-pv-trace-fixes/drivers_net_wireless_iwlwifi_iwl-debug.patch

diff --git a/patches/0018-pv-trace-fixes/drivers_net_wireless_iwlwifi_iwl-debug.patch b/patches/0018-pv-trace-fixes/drivers_net_wireless_iwlwifi_iwl-debug.patch
new file mode 100644
index 000000000000..870aa41f7745
--- /dev/null
+++ b/patches/0018-pv-trace-fixes/drivers_net_wireless_iwlwifi_iwl-debug.patch
@@ -0,0 +1,64 @@
+--- a/drivers/net/wireless/intel/iwlwifi/iwl-debug.c
++++ b/drivers/net/wireless/intel/iwlwifi/iwl-debug.c
+@@ -69,13 +69,16 @@ void __iwl_ ##fn(struct device *dev, const char *fmt, ...)	\
+ 	struct va_format vaf = {				\
+ 		.fmt = fmt,					\
+ 	};							\
+-	va_list args;						\
++	va_list args1, args2;					\
+ 								\
+-	va_start(args, fmt);					\
+-	vaf.va = &args;						\
++	va_start(args1, fmt);					\
++	va_copy(args2, args1);					\
++	vaf.va = &args2;					\
+ 	dev_ ##fn(dev, "%pV", &vaf);				\
++	va_end(args2);						\
++	vaf.va = &args1;					\
+ 	trace_iwlwifi_ ##fn(&vaf);				\
+-	va_end(args);						\
++	va_end(args1);						\
+ }
+ 
+ __iwl_fn(warn)
+@@ -94,13 +97,18 @@ void __iwl_err(struct device *dev, bool rfkill_prefix, bool trace_only,
+ 	va_list args;
+ 
+ 	va_start(args, fmt);
+-	vaf.va = &args;
+ 	if (!trace_only) {
++		va_list args2;
++
++		va_copy(args2, args);
++		vaf.va = &args2;
+ 		if (rfkill_prefix)
+ 			dev_err(dev, "(RFKILL) %pV", &vaf);
+ 		else
+ 			dev_err(dev, "%pV", &vaf);
++		va_end(args2);
+ 	}
++	vaf.va = &args;
+ 	trace_iwlwifi_err(&vaf);
+ 	va_end(args);
+ }
+@@ -117,12 +125,18 @@ void __iwl_dbg(struct device *dev,
+ 	va_list args;
+ 
+ 	va_start(args, fmt);
+-	vaf.va = &args;
+ #ifdef CONFIG_IWLWIFI_DEBUG
+ 	if (iwl_have_debug_level(level) &&
+-	    (!limit || net_ratelimit()))
++	    (!limit || net_ratelimit())) {
++		va_list args2;
++
++		va_copy(args2, args);
++		vaf.va = &args2;
+ 		dev_printk(KERN_DEBUG, dev, "%s %pV", function, &vaf);
++		va_end(args2);
++	}
+ #endif
++	vaf.va = &args;
+ 	trace_iwlwifi_dbg(level, function, &vaf);
+ 	va_end(args);
+ }
-- 
2.45.1

