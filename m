Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D15712EBD5
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570605; cv=none; b=QVvTnmwTTLpwjm8lyTd0Dj2NuRZD3DKOLewFfcZQ48wsmc5sQHf6j3LrRY1v0oJx5xX4YanW79vCXbTj5p2RFFKkEvqbyIWVOGKCphDtvsNoBbIi5gH4mKsZC8SUvs5w//mghRLlAuZu8U0MGMWtVVo9nGz4BHT/rMtS2QUFyx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570605; c=relaxed/simple;
	bh=p/AcCRwmbXnn+XfLNofz3xk1kZfQgLxIVhWfv0vBDpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ogKi+CJnM87ZekiZJTPRc7TXGJKyj2LM/UV8ClhF84GraSRL8VbXeS7/LySmfIvH4NNqCQQSyPGYOuvDYA0xaJ3To6yNOqNdSAmZqvQg7usqjk6/8Fwu0MTbEXVfRImhLeBAgP/kv/pdg0WircgOI5wKFPpcQpJXIxCDKK0B6JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=C3VIBAZd; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="C3VIBAZd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Yr/M8SmMqYdfCo9kKUKw7kZZEV3B3s7pii4ds6xskdE=;
	t=1716570604; x=1717780204; b=C3VIBAZdSlcZ4YKSnoUYQkgu9SIiQd0L730z6lczFYrK2Fw
	s0hgOvH99SQTyBS7+unhlSwjMlxTo8kI8kestZj1eVQP2uOo1EGTq4sQHkvqZJOxrfgLDTTAhEsxQ
	TQAclxNnxB0JQlO65IGi20LVUEOCdxwX26lqyXzhUDI+oPYcYzPlyg6XparTfjDIjsYf+LkpcNgTS
	bJLAUK1Q8ID9LpXI0TOBMj1woJ0fBai4Wf75wh8er5mqmbEvRH7WRYhyOW06NCRUheGaNQgvKEli0
	NjVcG9legaAV7xY6FQB8bCmx3svgkkgNRLA/c6pRuOollG0s14pwXRdhRD+QGFjQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQc-00000008Xuw-1ZWw;
	Fri, 24 May 2024 19:10:02 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 49/74] backports: add netlink length validation for 13
Date: Fri, 24 May 2024 19:08:01 +0200
Message-ID: <20240524190907.8d9f88bca281.Ie5f51a2a3b67734956f49ea9c1e1091f60400cdf@changeid>
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

This is needed for EHT.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/net/netlink.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/backport/backport-include/net/netlink.h b/backport/backport-include/net/netlink.h
index 61c266d58196..782c063b7a9f 100644
--- a/backport/backport-include/net/netlink.h
+++ b/backport/backport-include/net/netlink.h
@@ -361,6 +361,7 @@ int nla_validate_min_len_##n(const struct nlattr *attr,			\
 }
 
 MIN_LEN_VALIDATION(2)
+MIN_LEN_VALIDATION(13)
 MIN_LEN_VALIDATION(16)
 MIN_LEN_VALIDATION(42)
 
-- 
2.45.1

