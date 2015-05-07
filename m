Return-path: <backports-owner@vger.kernel.org>
Received: from app1b.xlhost.de ([84.200.252.162]:51479 "EHLO app1b.xlhost.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752241AbbEGLP4 (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 7 May 2015 07:15:56 -0400
Message-ID: <554B4966.5090808@kpanic.de> (sfid-20150507_131558_070018_C564096D)
Date: Thu, 07 May 2015 13:15:50 +0200
From: Stefan Assmann <sassmann@kpanic.de>
MIME-Version: 1.0
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
CC: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: problem with enabling config options
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

I'm looking into enabling more wired network drivers and ran into the
issue that I could not enable CONFIG_E1000 for example. The problem
seems to be that because CONFIG_E100 is disabled you cannot enable
anything CONFIG_E100*. It looks like a bug in gentree.py, but my python
foo didn't suffice to get it sorted out. Problem should be located
somewhere around line 1060 where the CONFIG variable regex stuff
happens.

Luis, could you have a look?
Thanks!

  Stefan
