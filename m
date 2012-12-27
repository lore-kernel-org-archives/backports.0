Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/2] compat: fix compiler warning in nla_get_s64()
Date: Thu, 27 Dec 2012 18:19:40 +0100
Message-Id: <1356628781-31637-1-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

This fixes the following warning:

compat/include/linux/compat-3.7.h: In function ‘nla_get_s64’:
compat/include/linux/compat-3.7.h:191:2: warning: passing argument 2 of ‘nla_memcpy’ discards ‘const’ qualifier from pointer target type [enabled by default]
In file included from include/net/genetlink.h:5:0,
                 from compat/include/linux/compat-2.6.32.h:12,
                 from compat/include/linux/compat-2.6.29.h:13,
                 from compat/include/linux/compat-2.6.h:50,
                 from <command-line>:0:

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 include/linux/compat-3.7.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/compat-3.7.h b/include/linux/compat-3.7.h
index bac76a3..6b1d2cf 100644
--- a/include/linux/compat-3.7.h
+++ b/include/linux/compat-3.7.h
@@ -184,7 +184,11 @@ static inline s8 nla_get_s8(const struct nlattr *nla)
  * nla_get_s64 - return payload of s64 attribute
  * @nla: s64 netlink attribute
  */
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,29))
 static inline s64 nla_get_s64(const struct nlattr *nla)
+#else
+static inline s64 nla_get_s64(struct nlattr *nla)
+#endif
 {
 	s64 tmp;
 
-- 
1.7.10.4
