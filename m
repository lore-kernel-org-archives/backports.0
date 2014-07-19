Return-path: <backports-owner@vger.kernel.org>
Received: from test.hauke-m.de ([5.39.93.123]:51383 "EHLO test.hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932118AbaGSQTG (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 19 Jul 2014 12:19:06 -0400
Message-ID: <53CA9A77.6060409@hauke-m.de> (sfid-20140719_181908_184925_D0B406D6)
Date: Sat, 19 Jul 2014 18:19:03 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: Removal of regulator framework
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Maintaining the regulator drivers in backports costs some time and I do
not need them. Is anybody using the regulator drivers from backports? I
would like to remove them.

Hauke
