Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3283B293
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716572917; cv=none; b=ERum75VhsQktGVoFV+/ZYhPFtOltBO9WbZWc8gJqLxstdQkLqdVfnX30N2OVXv5FRI9EgCyqdf/KFUyGafa5PXzg2fIkwsmB76b0hJmt/iKaTrdW3HfVrzUplHbz3mCrqmmZB5AZwoIddKEhdOlZoEAtyXhD1DSetAznAksJR3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716572917; c=relaxed/simple;
	bh=so91zDPWB+I4RVCrXRJTUr5Gwaxlrb02MfUoFCEZZOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SUmxgeuiOPy1KrG1XDMTEN6S57OqVW6lBWWV2lIJzB0TZRRupNm9XowI2iP94iQ3K3bjGwaWMi3Wns30VD1H7FOkj3++b6WnYLEZYTuEJaz7GzqxVXr40NyUz0bNrrfgA8d1hp/OmbZ11PJrg6jz1vrHspRnX2p/Ying4kSVfmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VYhMuKeQ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VYhMuKeQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Ndw4ZldrqeaMP2lQb/YkFj/Fc3fIj/nurumUNwjjd/k=;
	t=1716572915; x=1717782515; b=VYhMuKeQ0s06i8YkYx1dqgvIujNoJlspyUblE2DNT5yfGfm
	YNzUa0s/N4ZnUu6HdaRacyRyYwNfHjV/4AB2PFcsdAKqkPaOS0JcB4OHOwTHtpQ8oNRDQyaebDNvI
	v6Z3/Mpk7O3MrgpZa8LaSGnSBolyX9b2mIYFrODdwKzwi1BNsVhdmw/9OhAAsXpVQCbAU243lbQDa
	DGerTR2TNAzUjKfMmXtkGJsh8b7xngMACOpZZAMdJPHIDFgPD4ijm+NvDINiri3mfe5whgrMMajeh
	wg98cj1uVnEsy8v9NoWg568bmYuIquLq+OmjX4BIkd7GqpqWklhuDAOXREiH0WBQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAZ1s-00000008alk-3Oio;
	Fri, 24 May 2024 19:48:33 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/3] backports: add napi_is_scheduled()
Date: Fri, 24 May 2024 19:48:18 +0200
Message-ID: <20240524194829.b59bcf51bf91.I27d58940522266d55eaf288bebd0981e393bfc7f@changeid>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524194829.f11312298857.I2921f495b9feefbfe464ffd71c7350c66be119a8@changeid>
References: <20240524194829.f11312298857.I2921f495b9feefbfe464ffd71c7350c66be119a8@changeid>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/netdevice.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index f720b7537f4b..7f72c3a8eb98 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -204,6 +204,12 @@ static inline bool LINUX_BACKPORT(napi_schedule)(struct napi_struct *n)
 	return false;
 }
 #define napi_schedule LINUX_BACKPORT(napi_schedule)
+
+#define napi_is_scheduled LINUX_BACKPORT(napi_is_scheduled)
+static inline bool napi_is_scheduled(struct napi_struct *n)
+{
+	return test_bit(NAPI_STATE_SCHED, &n->state);
+}
 #endif /* < 6.7.0 */
 
 #endif /* __BACKPORT_NETDEVICE_H */
-- 
2.45.1

