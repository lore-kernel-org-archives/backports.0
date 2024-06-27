Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE461A38D2
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532135; cv=none; b=Iz0ZMuxTJ9K/bw8da5wLGi1mrIcc46Lc5bvMsYXZ3yR3Emm39frNIcSNvIk3QapYuMhwoKqi4Iz3FuElo78WRg/IFhiBF9mVFpkI87vQsm9shGouCaTFutHYujY7M3nZNdn1RYsDsfo6ZZ/5d0NmZjZslA6Fwff4WBNRcPxNhbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532135; c=relaxed/simple;
	bh=3MHwvrAKZE+V2bnycOa8WLtk4kBO1dY32STwFcU/E5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4Ngre0tv/t9kC3Qwc7m/N+/2T0en2nl3etkAyKoW7OpgSnlWWQHvHoiPQFr90IPp7ZxEeQ5sBOygc0pfQFZCd0SENW5LbRruZPHGR/hTdzCEA18Wq7boN6D/TZYM9Y0X3tILCbW9Lh6GUviazJKW1t/pgMyXqO7ZeCfhpEpBBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=AAmc42oz; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="AAmc42oz"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4W9FdW2450z9sqj;
	Fri, 28 Jun 2024 01:48:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SeYbLzXD/yyF3ijjbFT158TcAMBlNzoPFcBs/HBkV6Y=;
	b=AAmc42ozNwAkUQg664SeBwT761dUP64xjFCbVsl7x5H6vkWLAkNIPHD0gcnmg8Hb004Bij
	tQo0gFEip5uGFRnN+HhOxno3DiyPta5AeQJDcKOtykYfM5rkVLaQJl6uI18GWp0R+xyUqO
	CPrU5Qxd7GksuffH8TnwhChNxXPKBR81XzNcA7kP+4ATxtkxObrEGC7sHGuuXHz+ENZqpr
	vtruuel00HelCmo58CcEl6K/24vhlgxDVlCg4S2vE4mDwVN7cZZ3+muG4922HSrI6NE+Ge
	lQsSi24PaLMLhheqndHw0isImf4t8vMV8v4ZTPr2BY+zRHzFKUxBuDHaS7YtUQ==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 28/75] backports: add netlink length validation for 13
Date: Fri, 28 Jun 2024 01:47:14 +0200
Message-ID: <20240627234808.1253337-29-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This is needed for EHT.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/net/netlink.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/backport/backport-include/net/netlink.h b/backport/backport-include/net/netlink.h
index 61c266d5..782c063b 100644
--- a/backport/backport-include/net/netlink.h
+++ b/backport/backport-include/net/netlink.h
@@ -361,6 +361,7 @@ int nla_validate_min_len_##n(const struct nlattr *attr,			\
 }
 
 MIN_LEN_VALIDATION(2)
+MIN_LEN_VALIDATION(13)
 MIN_LEN_VALIDATION(16)
 MIN_LEN_VALIDATION(42)
 
-- 
2.45.2

