Return-path: <backports-owner@vger.kernel.org>
Received: from mxz.fh-kl.de ([143.93.17.66]:52487 "EHLO mxz.fh-kl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754353Ab3HOMlL (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 15 Aug 2013 08:41:11 -0400
Message-ID: <520CCC61.4010405@fh-kl.de> (sfid-20130815_144112_638083_DFCA1630)
Date: Thu, 15 Aug 2013 14:41:05 +0200
From: Patrick Ziegler <patrick.ziegler@fh-kl.de>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: <backports@vger.kernel.org>
Subject: [PATCH v3 10/10] backports: add defconfig for wwan device drivers
References: <cover.1376569949.git.patrick.ziegler@fh-kl.de>
In-Reply-To: <cover.1376569949.git.patrick.ziegler@fh-kl.de>
Content-Type: text/plain; charset="ISO-8859-15"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Signed-off-by: Patrick Ziegler <patrick.ziegler@fh-kl.de>
---
 backport/defconfigs/wwan | 6 ++++++
 1 file changed, 6 insertions(+)
 create mode 100644 backport/defconfigs/wwan

diff --git a/backport/defconfigs/wwan b/backport/defconfigs/wwan
new file mode 100644
index 0000000..5b4d2e7
--- /dev/null
+++ b/backport/defconfigs/wwan
@@ -0,0 +1,6 @@
+CPTCFG_USB_USBNET=m
+CPTCFG_USB_NET_CDC_NCM=m
+CPTCFG_USB_NET_CDC_MBIM=m
+CPTCFG_USB_NET_QMI_WWAN=m
+CPTCFG_USB_SIERRA_NET=m
+CPTCFG_USB_WDM=m
-- 
1.8.1.2


-- 
Dipl.-Inf. (FH) Patrick Ziegler

University Of Applied Sciences
Kaiserslautern

Amerikastrasse 1
D-66482 Zweibruecken
Germany

Phone:  +49 631 3724 5526
Mail:   patrick.ziegler@fh-kl.de
PGP KeyID 0xB4796B8C

http://www.fh-kl.de
http://www.fh-kl.de/fachbereiche/imst/iuk-knowhow.html
