Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:58422 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751602AbdIJWKs (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 10 Sep 2017 18:10:48 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/8] header: add __get_dynamic_array_len
Date: Mon, 11 Sep 2017 00:10:17 +0200
Message-Id: <20170910221020.13067-6-hauke@hauke-m.de> (sfid-20170911_001050_897693_76A98389)
In-Reply-To: <20170910221020.13067-1-hauke@hauke-m.de>
References: <20170910221020.13067-1-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This was added in kernel 3.16 in commit beba4bb096201 ("tracing: Add
__get_dynamic_array_len() macro for trace events")

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/trace/ftrace.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/backport/backport-include/trace/ftrace.h b/backport/backport-include/trace/ftrace.h
index 5fda0ce5..2daedd55 100644
--- a/backport/backport-include/trace/ftrace.h
+++ b/backport/backport-include/trace/ftrace.h
@@ -6,4 +6,8 @@
 		ftrace_print_array_seq(p, array, count, el_size);	\
 	})
 
+#undef __get_dynamic_array_len
+#define __get_dynamic_array_len(field)	\
+		((__entry->__data_loc_##field >> 16) & 0xffff)
+
 #include_next <trace/ftrace.h>
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
