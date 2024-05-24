Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5DB376EB
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570605; cv=none; b=UVT1BSONcDc54OuL4F9hf/mpyv3uTRgzzxjMJRu/WJ0xAoOHzuKnLRXgMWDhDWUgG96KJBJ/uzbkuQV3uKVxsdF3ODPP7NJ0oAShWtqkbilMNp+UcZynCe/xvgFHog9NcGwMarGjpPBZpUT3Am3X0zSfgdqnD+kfK3zWlXBVj0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570605; c=relaxed/simple;
	bh=WLBwGoOdIzwet5Fxh3wSJ3ansCcoyq89Kwdooa+rcGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tq8gzp7DRv2O2EnZV/tFdfTEgpUNpbeT4eZv2575k/ZLY4LfDm2sNR7sq/pXQlrkZN/tmZvnd2ak1sejwKjxySJkDx0IQmcnpu5e9kYYsX+BUBwn+CZYRSeLbWVGT3I4LKlvEJpPxG6SOYJ1I+zw17DwgNdRsNUpoD1X3AX4nuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ZRWWZ9nM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ZRWWZ9nM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=MyC4/fdcNERU60iWG1YjsVcSFeO+6GOGNz6Jf8q0Ihk=;
	t=1716570603; x=1717780203; b=ZRWWZ9nM4D0MpOTEEka9W1k2NoamZMUdJwUOZhVHsqvoH1j
	0tYZjTjAuPgw/31bERZj/CxBU562agn7G5VNa4pCkppflSfFccZr1/wzew8rMuaZ+VZ6jgYYawFR6
	dUHU5twRob8e+AJuzp+XAidhxUCQT/zmVwqzjt+US2ir97U50Xi/d6rYFpuRLURaZOH7GaLSgmxJJ
	tZ9XUlvn5hMgEvVpQDNKHSR8pSda9tFuiC7auPxzqFj4P2GX47YRcdr27RCn2BZbYtjAz/lcfwMvp
	c4b336d8ThZdWc6nUYV45fyxTPJEXiyHsVIdsCZ8XtXyJFR9s8Oho5c4r7aErTJQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQb-00000008Xuw-2BYv;
	Fri, 24 May 2024 19:10:01 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 48/74] backports: add NLA_POLICY_MIN_LEN()
Date: Fri, 24 May 2024 19:08:00 +0200
Message-ID: <20240524190907.6a342d68b754.I7e4b8c603be22ac6eee54cbc7b229d3b630f8498@changeid>
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

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/net/netlink.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/backport/backport-include/net/netlink.h b/backport/backport-include/net/netlink.h
index 7192153b860c..61c266d58196 100644
--- a/backport/backport-include/net/netlink.h
+++ b/backport/backport-include/net/netlink.h
@@ -264,6 +264,8 @@ nla_validate_nested_deprecated(const struct nlattr *start, int maxtype,
 	return __nla_validate_nested(start, maxtype, policy,
 				     NL_VALIDATE_LIBERAL, extack);
 }
+
+#define NLA_POLICY_MIN_LEN(_len)	{ .type = NLA_MIN_LEN, .len = _len }
 #endif /* < 5.2 */
 
 #if LINUX_VERSION_IS_LESS(5,6,0)
-- 
2.45.1

