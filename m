Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC61376EB
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570613; cv=none; b=MShjyzllbQCYsUrw7ItXv4v/KvSanuHP4asoIeqdR3njF3u5uzfTld7cxHkzeraspCKUK4cxR3MpGnlbHe7J9rFq6wssNfxJ7qmwCVpXW9ko6SRd2K06+UJiqR4/KPQgb6AoASXZV7UWZYAJsijkmwk8jqQ46C/O0r9u3JjYuts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570613; c=relaxed/simple;
	bh=hT25Sd6xY2QNKFCfKZHSINhSdiN+OONsYVIj1JGzVlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWfyrj0pfJkUXJhumHAlZwDlaGiJHDQRlrf/r80tGwvHfCDDjFHWN4Ko/lr3VhxT0cee/RQtCv5d2sQdWvAYF1GQnUvbTO+aH5vt/C/qcxG7AdNifOxRRq/xyd6G9qp1DBBX9vIuEeHj3bkky1lqGDkbA8VxO1lTyLlRHg55aHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=D/1NHRn7; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="D/1NHRn7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=F4GJFwnTGZZCfq3zL0scBXnrH90MLCdkrDpJcM+C/bQ=;
	t=1716570612; x=1717780212; b=D/1NHRn71mQ1mhy0wtkEsbgjiHo41bwGcgIRgxAeKt/z58G
	CLgwrTfubBhYgkCp7tpDIvE0iypNaQSOFzJLVf8t6oOg4+haKLlqQ/V3rCngY4/Dip42Z82qBfxM2
	wInQJ20qHdnh6NyfPUjppQE1bR1DIIMyT7sy1GQTtVq4YRHv2lkzaPX8am4ocEA+IgFzVFKpDJozp
	MGO1zmMjVZmbX9fDDtiIDzSe96PsTPGSd/rb1AVOzicyVQDLhQ2/wyKzOlCSYtyoaEjpZV1u/GY8T
	GFYHKKZSTCOj3+5HgMGgjwCHEIwiKbgKXloiuUnQ3Ykw/tv0aTaCCV3SVptIS/jg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQj-00000008Xuw-2DRN;
	Fri, 24 May 2024 19:10:10 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 57/74] backport: don't call thermal_zone_device_register for 6.0+
Date: Fri, 24 May 2024 19:08:09 +0200
Message-ID: <20240524190907.6300b3433e5a.I8f204514c641d4a58039ec6aa00029c5eca9e13e@changeid>
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

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

the backport version ofthermal_zone_device_register_with_trips calls
thermal_zone_device_register, but this was removed in 6.6, and
thermal_zone_device_register_with_trips does exist in 6.0+,
just has one more argument. So for kernels of version 6.0+, the
backported version can call it with 0 as the extra argument.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/compat/backport-6.9.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/backport/compat/backport-6.9.c b/backport/compat/backport-6.9.c
index 6ae485da3975..5a370756b75e 100644
--- a/backport/compat/backport-6.9.c
+++ b/backport/compat/backport-6.9.c
@@ -12,8 +12,21 @@ thermal_zone_device_register_with_trips(const char *type,
 					struct thermal_zone_params *tzp, int passive_delay,
 					int polling_delay)
 {
+#if LINUX_VERSION_IS_LESS(6,0,0)
 	return thermal_zone_device_register(type, num_trips, 0, devdata, ops, tzp,
 					    passive_delay, polling_delay);
+#else
+#undef thermal_trip
+#undef thermal_zone_device_register_with_trips
+	return thermal_zone_device_register_with_trips(type,
+						       (struct thermal_trip *)(void *) trips,
+						       num_trips,
+						       0, devdata,
+						       ops, tzp, passive_delay,
+						       polling_delay);
+#define thermal_trip backport_thermal_trip
+#define thermal_zone_device_register_with_trips LINUX_BACKPORT(thermal_zone_device_register_with_trips)
+#endif /* < 6,6,0 */
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_register_with_trips);
 #endif /* CONFIG_THERMAL */
-- 
2.45.1

