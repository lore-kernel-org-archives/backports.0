Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A1E1A38DC
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532136; cv=none; b=gvV0d4BVBkMqHFOYTi0pWBtmdRxuldxg2JA+IFIrVY2w3IXcWQxbeh+Xi0/OIVS9xHq3ooDlmJmHs65IFc0gzr0CTa3hBYt9idhpYP/o/Cpj+OH5S36Y35JA/0YifpkOEe04X/aC6dYpCjexFzMZx1hp+tNz99n62O9N3ZQ5/GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532136; c=relaxed/simple;
	bh=B4qDEsGfevXf94uhMTZfXb8XvfSuGA4xB3xVacKHtu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nG8rX4yp7rMk2hwWnLyb69Pi/nB6M90MfS9j2RuIHB2CK9upy7o56iJs2sgjwTAmkVVYjAP8xRBc4hCcneNTd3mHO53jYi6J9LkMsfu+d22mNvdTVmK9/cMpyimFwpaxQrx0zXIAnWgPdKmaiOj7kuS+u5StUf41w461pB1HpqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=Gm2W/D/o; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="Gm2W/D/o"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4W9FdS61cWz9sW5;
	Fri, 28 Jun 2024 01:48:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MJ64ftm0h2DgPYxwQPNMYTIttg8mR0oaMxbkLYYDYMg=;
	b=Gm2W/D/o3PcSsF2bbmLI3Cc1tCm1XPExDLrFnhPTEh1+E1UvChZ9n6hoVfWsg1G0jNV6oE
	SoCJ5CkYCqC/3n90RnG8gBlrImFfRwAuDkw1KluvK97UVGyV93IjRXDZOFVPnWXA8UVWUt
	WmqjVR6WEYHVQpxWaE3XphXXqT8XNHIamcIob3Za2luGg3T6gEtXBIkNYKVDnkfdYEM6dg
	T+OU0ThG3C5x28RM8ZPCTGQpiAWf5ulVAgVFQhqZWn7hzMOVAnSmldyMERQiXtjEuhsQvF
	RZaIZj2qsZpIJkGOu9KYiDsUv5jO0Ji9RnFqCqbjD4Iaht3uYlSSr3PfobY1Yg==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 18/75] backports: update mac80211-status.patch to v6.0-rc1
Date: Fri, 28 Jun 2024 01:47:04 +0200
Message-ID: <20240627234808.1253337-19-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gregory Greenman <gregory.greenman@intel.com>

Update for some changes in struct ieee80211_tx_status.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 patches/0097-skb-list/mac80211-status.patch | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/patches/0097-skb-list/mac80211-status.patch b/patches/0097-skb-list/mac80211-status.patch
index 04d1a6af..1e8b0cb5 100644
--- a/patches/0097-skb-list/mac80211-status.patch
+++ b/patches/0097-skb-list/mac80211-status.patch
@@ -7,10 +7,10 @@ kernel versions.
 
 --- a/include/net/mac80211.h
 +++ b/include/net/mac80211.h
-@@ -1137,7 +1137,11 @@ struct ieee80211_tx_status {
- 	struct ieee80211_tx_info *info;
- 	struct sk_buff *skb;
- 	struct rate_info *rate;
+@@ -1178,7 +1178,11 @@ struct ieee80211_tx_status {
+ 	struct ieee80211_rate_status *rates;
+ 	u8 n_rates;
+ 
 +#if LINUX_VERSION_IS_GEQ(4,19,0)
  	struct list_head *free_list;
 +#else
@@ -21,7 +21,7 @@ kernel versions.
  /**
 --- a/net/mac80211/status.c
 +++ b/net/mac80211/status.c
-@@ -1060,7 +1060,11 @@ static void __ieee80211_tx_status(struct
+@@ -1075,7 +1075,11 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
  	 */
  	if (!local->monitors && (!send_to_cooked || !local->cooked_mntrs)) {
  		if (status->free_list)
@@ -33,7 +33,7 @@ kernel versions.
  		else
  			dev_kfree_skb(skb);
  		return;
-@@ -1210,7 +1214,11 @@ free:
+@@ -1228,7 +1232,11 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
  
  	ieee80211_report_used_skb(local, skb, false);
  	if (status->free_list)
-- 
2.45.2

