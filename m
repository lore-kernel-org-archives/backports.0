Return-path: <backports-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:24554 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932273Ab3DHK0d (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 8 Apr 2013 06:26:33 -0400
From: Thierry Escande <thierry.escande@linux.intel.com>
To: backports@vger.kernel.org
Subject: [PATCH v3 1/8] backport sk_for_each_safe
Date: Mon,  8 Apr 2013 12:26:06 +0200
Message-Id: <1365416773-12836-2-git-send-email-thierry.escande@linux.intel.com> (sfid-20130408_122642_368363_895960FF)
Content-Type: text/plain; charset = "utf-8"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is needed for NFC core.

Signed-off-by: Thierry Escande <thierry.escande@linux.intel.com>
---
 backport/include/linux/compat-3.9.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/include/linux/compat-3.9.h b/backport/include/linux/compat-3.9.h
index 240a328..aed569c 100644
--- a/backport/include/linux/compat-3.9.h
+++ b/backport/include/linux/compat-3.9.h
@@ -186,6 +186,10 @@ static inline void idr_preload_end(void)
 #define sk_for_each(__sk, list) \
 	hlist_for_each_entry(__sk, list, sk_node)
 
+#undef sk_for_each_safe
+#define sk_for_each_safe(__sk, tmp, list) \
+	hlist_for_each_entry_safe(__sk, tmp, list, sk_node)
+
 #define tty_flip_buffer_push(port) tty_flip_buffer_push((port)->tty)
 #define tty_insert_flip_string(port, chars, size) tty_insert_flip_string((port)->tty, chars, size)
 
-- 
1.7.10.4

