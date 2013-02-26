Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 23/24] compat-drivers: do not use __sock_create()
Date: Tue, 26 Feb 2013 21:38:15 +0100
Message-Id: <1361911096-29117-24-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361911096-29117-1-git-send-email-hauke@hauke-m.de>
References: <1361911096-29117-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

__sock_create() is not available on kernel version < 2.6.37.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../network/69-wowlan-no-socket.patch                     |   13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/69-wowlan-no-socket.patch

diff --git a/patches/collateral-evolutions/network/69-wowlan-no-socket.patch b/patches/collateral-evolutions/network/69-wowlan-no-socket.patch
new file mode 100644
index 0000000..27d8f6a
--- /dev/null
+++ b/patches/collateral-evolutions/network/69-wowlan-no-socket.patch
@@ -0,0 +1,13 @@
+__sock_create() is not available on kernel version < 2.6.37.
+
+--- a/net/wireless/nl80211.c
++++ b/net/wireless/nl80211.c
+@@ -7388,7 +7388,7 @@ static int nl80211_parse_wowlan_tcp(stru
+ 		port = nla_get_u16(tb[NL80211_WOWLAN_TCP_SRC_PORT]);
+ 	else
+ 		port = 0;
+-#ifdef CONFIG_INET
++#if defined(CONFIG_INET) && (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
+ 	/* allocate a socket and port for it and use it */
+ 	err = __sock_create(wiphy_net(&rdev->wiphy), PF_INET, SOCK_STREAM,
+ 			    IPPROTO_TCP, &cfg->sock, 1);
-- 
1.7.10.4
