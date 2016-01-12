Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:48671 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933737AbcALIgn (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 12 Jan 2016 03:36:43 -0500
Message-ID: <1452587801.3473.1.camel@sipsolutions.net> (sfid-20160112_093645_338535_3A15C5C0)
Subject: Re: WLAN drivers provided by Realtek do not work with backports
 (cfg80211 module not compatible)
From: Johannes Berg <johannes@sipsolutions.net>
To: Bartlomiej Grzeskowiak <bartlomiej.grzeskowiak@gmail.com>,
	backports@vger.kernel.org
Date: Tue, 12 Jan 2016 09:36:41 +0100
In-Reply-To: <CADaZW1GjSckRoxu7aiVC8tpYr8N6N7wKOf8_8EX3zO-xZmMAgg@mail.gmail.com> (sfid-20160111_115730_073624_C934D2FE)
References: <CADaZW1GjSckRoxu7aiVC8tpYr8N6N7wKOf8_8EX3zO-xZmMAgg@mail.gmail.com>
	 (sfid-20160111_115730_073624_C934D2FE)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2016-01-11 at 11:56 +0100, Bartlomiej Grzeskowiak wrote:
> We use 8192cu and 8811AU provided by Realtek. Our kernel is 3.10.
> We would like to add parallel support for ath10k_pci from backports.
> 
> However after inserting compat.ko, cfg80211.ko and mac80211.ko from
> backports, 8192cu.ko and 8821au.ko terminate with following message:
> [  512.188364] 8192cu: Unknown symbol wiphy_new (err 0)
> [  512.188481] 8192cu: Unknown symbol cfg80211_send_disassoc (err 0)
> [  512.188554] 8192cu: Unknown symbol cfg80211_send_rx_assoc (err 0)
> [  512.188607] 8192cu: Unknown symbol cfg80211_inform_bss_frame (err
> 0)
> 
> Those interfaces are exported when I load cfg80211.ko compiled from
> kernel 3.10.
> But I can not see them in cfg80211.ko provided by backports.
> 

You have to load the cfg80211.ko from backports.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
