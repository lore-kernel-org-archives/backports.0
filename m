Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:57916 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbaDEMl2 (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 5 Apr 2014 08:41:28 -0400
Received: by mail-pb0-f44.google.com with SMTP id rp16so4650578pbb.17
        for <backports@vger.kernel.org>; Sat, 05 Apr 2014 05:41:28 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 04/27] backports: backport MPLS support
Date: Sat,  5 Apr 2014 05:40:38 -0700
Message-Id: <1396701662-15165-5-git-send-email-mcgrof@do-not-panic.com> (sfid-20140405_144130_373622_4F16E4DE)
In-Reply-To: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
References: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This simply the files that define the structures and
defines used to decode MPLS on the skb. For an example
usage see 960d97f95. The headers were added first via
f3baa393ff.

commit f3baa393ffc9a7aefc0bf767729382085e81f606
Author: Simon Wunderlich <sw@simonwunderlich.de>
Date:   Mon Mar 3 17:23:11 2014 +0100

    UAPI: add MPLS label stack definition

    Labels for the Multiprotocol Label Switching are defined in RFC 3032
    which was superseded by RFC 5462. Add the definition to UAPI and a stub
    header for include/linux.

    Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
    Signed-off-by: Mathias Kretschmer <mathias.kretschmer@fokus.fraunhofer.de>
    Signed-off-by: David S. Miller <davem@davemloft.net>

commit 960d97f9518ef6fb8ff87450d6b0c88ce5df9532
Author: Simon Wunderlich <sw@simonwunderlich.de>
Date:   Mon Mar 3 17:23:12 2014 +0100

    cfg80211: add MPLS and 802.21 classification

    MPLS labels may contain traffic control information, which should be
    evaluated and used by the wireless subsystem if present.

    Also check for IEEE 802.21 which is always network control traffic.

    Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
    Signed-off-by: Mathias Kretschmer <mathias.kretschmer@fokus.fraunhofer.de>
    Acked-by: Johannes Berg <johannes@sipsolutions.net>
    Signed-off-by: David S. Miller <davem@davemloft.net>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 copy-list | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/copy-list b/copy-list
index bde95a1..bec17a5 100644
--- a/copy-list
+++ b/copy-list
@@ -191,3 +191,9 @@ include/linux/spi/at86rf230.h
 net/ieee802154/
 net/mac802154/
 drivers/net/ieee802154/
+
+# MPLS labels, checked on skb->protocol on the
+# respective 802 family, only ethernet seems to use
+# this right now, see 960d97f95
+include/linux/mpls.h
+include/uapi/linux/mpls.h
-- 
1.8.5.3

