Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE16A12C47A
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570620; cv=none; b=PkomCK2ygiDzlHT+3czLOtg0nruPnC5y06lnK5WOjc1LOQFwVRqAUFheZwiPb8iOsIZSonK/eMi28BU0rEyLx2zINNd+IQBk+q+B6DTc0Xtqtxz69CHeTWEKfOEt8TCVH+euCrb2DFa06eLP96rrHHTlwFN0V0U6QYf5kwLNTqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570620; c=relaxed/simple;
	bh=a3EcHnjaYTjlametxJXYng9sDpQG4/FxkMcueJTqb8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VnwMCeYC8oZXo0IZDg1SA8w0p0iS3Ft6P8zjrHHL1pCl8HGPAbhAKJFoxwRjqmtVaEwYdW0pNOE9MF85XftrNHx2jbVugbdOyI5/olpIgZv2BaxjQ0MnNxOuTg3xTNSkXio2RoWZ+qnbuzQLSH5sJlJ9O2s8vtxmqj2jkLQEOSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=O8+h2UEx; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="O8+h2UEx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=axNx95e70acUJdskieHh/6daSMg3DNv4y3k95yPP7hM=;
	t=1716570618; x=1717780218; b=O8+h2UEx/qhOV4tGpMaf4m5/LOHxKbwZoHTHS8ejhDEhr6t
	CyKYgB4piZ22rnRg8yldxQXoP1q5RikLyOtTkdN1ktgboHJrdU95P4nAca+itNWtLw3LhGio5YZGh
	30OVxqN60Q+en3HbKYJcGZfWXrIrzxAwxN4OsCTvSAp8PBzw4h5kbr4cY02LOpjRCtx3nRL2QPKwr
	YhktY2uGzZNoqONLFsGJTYkZequ8dcZikbBWT2jmlcb6ZuvKO90vFI/vAn8htixjbMVP2qceR0oQs
	yhRDjA8Wro5lDvJFuev4gfSY77M1iaCsatZPiV15JESam/IlrJSIXGI9xo0Iwrew==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQq-00000008Xuw-26UC;
	Fri, 24 May 2024 19:10:16 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 64/74] backports: update mac80211-status.patch to v6.0-rc1
Date: Fri, 24 May 2024 19:08:16 +0200
Message-ID: <20240524190907.6745cb611740.Ibfa4e1ca7cb70dcc4c687b543e379b40343de1ef@changeid>
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

Update for some changes in struct ieee80211_tx_status.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 patches/0097-skb-list/mac80211-status.patch | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/patches/0097-skb-list/mac80211-status.patch b/patches/0097-skb-list/mac80211-status.patch
index 04d1a6af9457..7edff7f7ede4 100644
--- a/patches/0097-skb-list/mac80211-status.patch
+++ b/patches/0097-skb-list/mac80211-status.patch
@@ -5,12 +5,14 @@ support bulk free") makes use of the list attribute in the skb, but this
 is not available in kernel < 4.19, use the sk_buff_head instead on these
 kernel versions.
 
+diff --git a/include/net/mac80211.h b/include/net/mac80211.h
+index 47642b020706..1abda970a6e6 100644
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
@@ -19,9 +21,11 @@ kernel versions.
  };
  
  /**
+diff --git a/net/mac80211/status.c b/net/mac80211/status.c
+index e69272139437..549d50aac4b0 100644
 --- a/net/mac80211/status.c
 +++ b/net/mac80211/status.c
-@@ -1060,7 +1060,11 @@ static void __ieee80211_tx_status(struct
+@@ -1075,7 +1075,11 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
  	 */
  	if (!local->monitors && (!send_to_cooked || !local->cooked_mntrs)) {
  		if (status->free_list)
@@ -33,7 +37,7 @@ kernel versions.
  		else
  			dev_kfree_skb(skb);
  		return;
-@@ -1210,7 +1214,11 @@ free:
+@@ -1228,7 +1232,11 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
  
  	ieee80211_report_used_skb(local, skb, false);
  	if (status->free_list)
-- 
2.45.1

