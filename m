Return-path: <backports-owner@vger.kernel.org>
Received: from mail.pindomains.com ([173.248.156.94]:56716 "EHLO
	mail.pindomains.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372Ab3JVKKT (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 22 Oct 2013 06:10:19 -0400
Message-ID: <20131022153944.39996wk0j99z6mo8@192.168.50.55> (sfid-20131022_121021_831936_956974B7)
Date: Tue, 22 Oct 2013 15:39:44 +0530
From: "ravikant patel" <ravikant.patel@matrixcomsec.com>
To: backports@vger.kernel.org
Cc: "Ronak Shah" <ronak.shah@matrixcomsec.com>
Subject: RTS/CTS Threshold not work|Backports
MIME-Version: 1.0
Content-Type: text/plain;
	charset=;
	DelSp="Yes";
	format="flowed"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi All,

We use hostapd2.0 deamon and Backports driver(ath9k),usually when RTS/CTS
threshold parameter set in hostapd.conf file in that case if client  
send packets bigger
thenRTS threshold value RTS/CTS will be triggered.

But in our case when client sends  packet bigger then RTS
Threshold no RTS/CTS packet was seen means it  will not work.

My question :
Does the RTS/CTS depends on hostapd daemon or backports driver?

Regards,
Ravikant Patel



