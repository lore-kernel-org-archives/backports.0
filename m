Return-path: <backports-owner@vger.kernel.org>
Received: from mailhost.actiasodielec.fr ([89.91.64.97]:59841 "EHLO
	mailhost.actiasodielec.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044AbaE1PpD convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 28 May 2014 11:45:03 -0400
Received: (from uucp@localhost)
	by mailhost.actiasodielec.fr id s4SFcoXL022491
	for <backports@vger.kernel.org>; Wed, 28 May 2014 17:38:50 +0200
From: Vu Hai NGUYEN <vh.nguyen@actiasodielec.fr>
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Wed, 28 May 2014 17:35:29 +0200
Subject: backports: define of NL80211_FEATURE_SK_TX_STATUS in
  /backport-include/linux/nl80211.h
Message-ID: <EE97821C81277E459BEA5C6384C6F241012F109978F5@srvexch01.SODIELEC.local> (sfid-20140528_174506_251452_BCA4D86F)
References: <1401113736-13562-1-git-send-email-emmanuel.grumbach@intel.com>
In-Reply-To: <1401113736-13562-1-git-send-email-emmanuel.grumbach@intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

I'm using backport to compile driver ath10k. I used hostapd to set up AP mode and my interface wlan0 always set up an interface mon.wlan0 with wlan0.
This makes my AP refuse the connection with a station when my AP use a channel that employs DFS; because the monitor interface didn't respond the probe request from the station. 

I looked in the driver_nl80211.c and found that use_monitor relied on "poll_command_supported" and "data_tx_status". I printed these 2 parameters and saw that data_tx_status=0, it depends on NL80211_FEATURE_SK_TX_STATUS and this parameter was affected to the flags of wiphy->features, defined in /net/mac80211/main.c.I find this parameter was set = 0 in /backport-include/linux/nl80211.h
That's why montior mode was forced to used with AP mode. I set that parameter = 1 and no more monitor interface in AP mode, my AP works withDFS  now.
My question is why did this parameter is set to 0? It may be used for some purpose?
Thanks, 

NGUYEN Vu Hai
Acita-Sodielec
Route de Mayres - B.P. 9
12100 St GEORGES DE LUZENCON
FRANCE


