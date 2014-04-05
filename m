Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:52084 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528AbaDEMmh (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 5 Apr 2014 08:42:37 -0400
Received: by mail-pd0-f181.google.com with SMTP id p10so4454351pdj.26
        for <backports@vger.kernel.org>; Sat, 05 Apr 2014 05:42:37 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Alexander Smirnov <alex.bluesman.smirnov@gmail.com>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-zigbee-devel@lists.sourceforge.net
Subject: [PATCH 18/27] backports: add include/net/6lowpan.h to copy-list
Date: Sat,  5 Apr 2014 05:40:52 -0700
Message-Id: <1396701662-15165-19-git-send-email-mcgrof@do-not-panic.com> (sfid-20140405_144449_403955_3A090270)
In-Reply-To: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
References: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

We backport both the bluetooth and ieee802154 subsystems
and commit cefc8c8a7c moved the 6lowpan it out under from
net/ieee802154/6lowpan.h to include/net/6lowpan.h as bluetooth
now uses it. Since we backport both subsystems just copy the
header over.

commit cefc8c8a7c9e4867c45407f7f9a44fe80c5ea58a
Author: Alexander Aring <alex.aring@gmail.com>
Date:   Wed Mar 5 14:29:05 2014 +0100

    6lowpan: move 6lowpan header to include/net

    This header is used by bluetooth and ieee802154 branch. This patch
    move this header to the include/net directory to avoid a use of a
    relative path in include.

    Signed-off-by: Alexander Aring <alex.aring@gmail.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

Cc: Alexander Aring <alex.aring@gmail.com>
Cc: Alexander Smirnov <alex.bluesman.smirnov@gmail.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linux-zigbee-devel@lists.sourceforge.net
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 copy-list | 1 +
 1 file changed, 1 insertion(+)

diff --git a/copy-list b/copy-list
index bec17a5..ceb80ba 100644
--- a/copy-list
+++ b/copy-list
@@ -180,6 +180,7 @@ drivers/media/
 include/linux/platform_data/vsp1.h
 include/linux/platform_data/camera-rcar.h
 
+include/net/6lowpan.h
 include/net/nl802154.h
 include/net/mac802154.h
 include/net/ieee802154.h
-- 
1.8.5.3

