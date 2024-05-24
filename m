Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEC412C47A
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570625; cv=none; b=Wtl7Y5uFByos1uIJpRBXH2ZShJcHenkUQlRhdJX929qjJu+Ll3mJW1ggWg/F6vYLMoFCEApXgH1zZvlyr4Xo+FkyZ7//+TbCj0JxpjdlDSVI97SBTgF4rGI6bVh8RB/icKnyi4uHAYxQef7p1YHC+ENlNvUz0aRXVmRT0SqTGzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570625; c=relaxed/simple;
	bh=AWCV0erSnlqpa5+vQbRhqn2H3AUsYDJQWNEH6y0uiQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uOWzZBG5+QTE888WIjdN9TlAXAHdaDLj5rr4BZVGFNqe08LJiwMWUPXE9mmYV+8GjFVlszBOvQ9tz7/xl0CuSzWW+s/ofEF8JIZjrkuyCQljSXf3q0tBFm45r1DbMDrO9vSXaYkeL3NMNk4HDAk++U1FVP4T3wZrcndwgMueoRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=s1c9eZhY; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="s1c9eZhY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=mjSQCEe+NnZdrSV7Yxblqc9SUYfGRDoO4H/mr7HiZ88=;
	t=1716570624; x=1717780224; b=s1c9eZhYGWB4fUw+ZzSWMPN5E7htfG6BTyJHnAD/awp3REa
	+2Jwy6ifM5yC1V7M4d/2NmlW6P+Yy9ovS4a2Qy1UiAKmD/jZnpKjamzenExeY+uU+hS4FP1k33ptO
	+f8h5bg1Q4o2spr+8B1741MNoe6hE4wVAZNj9zfTolKBWGVEXn0eNz/0DznLQCzzvxD8SfOk4TqVr
	6qHxtSFa5M2d6sR917AYiF3OgRTTGEGxepKeO1HFnTH6gib8zioK37mnEOz9UCqJ19F+QJ5ya2dWb
	ZhAwHuYiBsCHEd9on4+ce0F1hms9or6aBz0omFu2hj2K84hoH0m5DyYGl2PV87MQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQt-00000008Xuw-1heW;
	Fri, 24 May 2024 19:10:19 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 67/74] backports: adjust timer functions
Date: Fri, 24 May 2024 19:08:19 +0200
Message-ID: <20240524190907.255814c64761.Ief3d26a0ae877775fcb4e01a107439581918ec84@changeid>
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

Partially adjust to commit
292a089d78d3 ("treewide: Convert del_timer*() to timer_shutdown*()")

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 patches/0110-timers.patch | 48 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 patches/0110-timers.patch

diff --git a/patches/0110-timers.patch b/patches/0110-timers.patch
new file mode 100644
index 000000000000..70f98e5bdf00
--- /dev/null
+++ b/patches/0110-timers.patch
@@ -0,0 +1,48 @@
+diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+index 48e7376a5fea..0781dd07a377 100644
+--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
++++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+@@ -371,7 +371,11 @@ void iwl_dbg_tlv_del_timers(struct iwl_trans *trans)
+ 	struct iwl_dbg_tlv_timer_node *node, *tmp;
+ 
+ 	list_for_each_entry_safe(node, tmp, timer_list, list) {
++#if LINUX_VERSION_IS_GEQ(6,2,1)
+ 		timer_shutdown_sync(&node->timer);
++#else
++		del_timer_sync(&node->timer);
++#endif
+ 		list_del(&node->list);
+ 		kfree(node);
+ 	}
+diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+index 69634fb82a9b..00125b8143a8 100644
+--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
++++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+@@ -2835,7 +2835,11 @@ int iwl_mvm_sta_rx_agg(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
+ 
+ 		/* synchronize all rx queues so we can safely delete */
+ 		iwl_mvm_free_reorder(mvm, baid_data);
++#if LINUX_VERSION_IS_GEQ(6,2,1)
+ 		timer_shutdown_sync(&baid_data->session_timer);
++#else
++		del_timer_sync(&baid_data->session_timer);
++#endif
+ 		RCU_INIT_POINTER(mvm->baid_map[baid], NULL);
+ 		kfree_rcu(baid_data, rcu_head);
+ 		IWL_DEBUG_HT(mvm, "BAID %d is free\n", baid);
+diff --git a/net/mac80211/mesh_pathtbl.c b/net/mac80211/mesh_pathtbl.c
+index 3b81e6df3f34..29c0dbd1b6c2 100644
+--- a/net/mac80211/mesh_pathtbl.c
++++ b/net/mac80211/mesh_pathtbl.c
+@@ -512,7 +512,11 @@ static void mesh_path_free_rcu(struct mesh_table *tbl,
+ 	mpath->flags |= MESH_PATH_RESOLVING | MESH_PATH_DELETED;
+ 	mesh_gate_del(tbl, mpath);
+ 	spin_unlock_bh(&mpath->state_lock);
++#if LINUX_VERSION_IS_GEQ(6,2,1)
+ 	timer_shutdown_sync(&mpath->timer);
++#else
++	del_timer_sync(&mpath->timer);
++#endif
+ 	atomic_dec(&sdata->u.mesh.mpaths);
+ 	atomic_dec(&tbl->entries);
+ 	mesh_path_flush_pending(mpath);
-- 
2.45.1

