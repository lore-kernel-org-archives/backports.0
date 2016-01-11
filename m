Return-path: <backports-owner@vger.kernel.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179]:35225 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758330AbcAKK51 (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 11 Jan 2016 05:57:27 -0500
Received: by mail-yk0-f179.google.com with SMTP id x67so427138691ykd.2
        for <backports@vger.kernel.org>; Mon, 11 Jan 2016 02:57:26 -0800 (PST)
MIME-Version: 1.0
From: Bartlomiej Grzeskowiak <bartlomiej.grzeskowiak@gmail.com>
Date: Mon, 11 Jan 2016 11:56:57 +0100
Message-ID: <CADaZW1GjSckRoxu7aiVC8tpYr8N6N7wKOf8_8EX3zO-xZmMAgg@mail.gmail.com> (sfid-20160111_115730_073624_C934D2FE)
Subject: WLAN drivers provided by Realtek do not work with backports (cfg80211
 module not compatible)
To: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

We use 8192cu and 8811AU provided by Realtek. Our kernel is 3.10.
We would like to add parallel support for ath10k_pci from backports.

However after inserting compat.ko, cfg80211.ko and mac80211.ko from
backports, 8192cu.ko and 8821au.ko terminate with following message:
[  512.188364] 8192cu: Unknown symbol wiphy_new (err 0)
[  512.188481] 8192cu: Unknown symbol cfg80211_send_disassoc (err 0)
[  512.188554] 8192cu: Unknown symbol cfg80211_send_rx_assoc (err 0)
[  512.188607] 8192cu: Unknown symbol cfg80211_inform_bss_frame (err 0)

Those interfaces are exported when I load cfg80211.ko compiled from kernel 3.10.
But I can not see them in cfg80211.ko provided by backports.

Do you know this problem ?
Is there any easy way to solve this issue ?

BR
Bartek
--
To unsubscribe from this list: send the line "unsubscribe backports" in
