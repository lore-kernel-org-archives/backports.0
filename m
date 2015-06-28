Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:48705 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752644AbbF1V7c (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 28 Jun 2015 17:59:32 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 06/14] header: add N_NCI
Date: Sun, 28 Jun 2015 23:59:12 +0200
Message-Id: <1435528760-19913-7-git-send-email-hauke@hauke-m.de> (sfid-20150628_235936_483471_60059F55)
In-Reply-To: <1435528760-19913-1-git-send-email-hauke@hauke-m.de>
References: <1435528760-19913-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

It should be save to just copy it.
This was added in this upstream commit:
commit 9961127d4bce6325e9a0b0fb105e0c85a6c62cb7
Author: Vincent Cuissard <cuissard@marvell.com>
Date:   Thu Jun 11 11:25:47 2015 +0200

    NFC: nci: add generic uart support

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/tty.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/backport-include/linux/tty.h b/backport/backport-include/linux/tty.h
index 3b8a0a2..7462ac3 100644
--- a/backport/backport-include/linux/tty.h
+++ b/backport/backport-include/linux/tty.h
@@ -29,4 +29,8 @@ extern void tty_port_tty_hangup(struct tty_port *port, bool check_clocal);
 extern int tty_set_termios(struct tty_struct *tty, struct ktermios *kt);
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
 
+#ifndef N_NCI
+#define N_NCI		25	/* NFC NCI UART */
+#endif
+
 #endif /* __BACKPORT_LINUX_TTY_H */
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
