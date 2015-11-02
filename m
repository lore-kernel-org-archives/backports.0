Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:50751 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751394AbbKBMgt (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 2 Nov 2015 07:36:49 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.86)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ZtELw-0003mx-5a
	for backports@vger.kernel.org; Mon, 02 Nov 2015 13:36:48 +0100
Message-ID: <1446467807.3205.21.camel@sipsolutions.net> (sfid-20151102_133651_365368_CEFE6092)
Subject: CONFIG_WLAN getting disabled - copy-list usage
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Date: Mon, 02 Nov 2015 13:36:47 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

FYI, if anyone's using backports with a copy-list file that restricts
the wifi drivers to their own, and is working against a recent tree
that includes the drivers/net/wireless/realtek/ move, then CONFIG_WLAN
will end up getting disabled.

To fix that for now modify your copy-list to include
drivers/net/wireless/realtek/Makefile (and that file only).

Once Kconfig changes go in and the Makefile statement

obj-$(CONFIG_WLAN) += realtek/

changes to

obj-$(CONFIG_WLAN_REALTEK) += realtek/

(or similar) this issue will go away.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
