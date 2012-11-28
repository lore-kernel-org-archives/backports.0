Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/6] compat-drivers: add import to fix compile error
Date: Thu, 29 Nov 2012 00:07:48 +0100
Message-Id: <1354144069-28611-6-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1354144069-28611-1-git-send-email-hauke@hauke-m.de>
References: <1354144069-28611-1-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On kernel version <= 2.6.28, I saw the following compile error without
this patch:

/net/wireless/util.c: In function ‘cfg80211_get_p2p_attr’:
/net/wireless/util.c:1120:4: error: implicit declaration of function
‘get_unaligned_le16’ [-Werror=implicit-function-declaration]

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 patches/network/06-header-changes.patch |   10 ++++++++++
 patches/network/30-bridge-port.patch    |    2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/patches/network/06-header-changes.patch b/patches/network/06-header-changes.patch
index cd587cd..5da05c0 100644
--- a/patches/network/06-header-changes.patch
+++ b/patches/network/06-header-changes.patch
@@ -125,3 +125,13 @@ cases.
  
  #define USB_VERSION	"1.0"
  
+--- a/net/wireless/util.c
++++ b/net/wireless/util.c
+@@ -10,6 +10,7 @@
+ #include <net/cfg80211.h>
+ #include <net/ip.h>
+ #include <net/dsfield.h>
++#include <asm/unaligned.h>
+ #include "core.h"
+ #include "rdev-ops.h"
+ 
diff --git a/patches/network/30-bridge-port.patch b/patches/network/30-bridge-port.patch
index b4106b7..a426274 100644
--- a/patches/network/30-bridge-port.patch
+++ b/patches/network/30-bridge-port.patch
@@ -23,7 +23,7 @@ compat-drivers.
 
 --- a/net/wireless/util.c
 +++ b/net/wireless/util.c
-@@ -812,7 +812,7 @@ int cfg80211_change_iface(struct cfg8021
+@@ -813,7 +813,7 @@ int cfg80211_change_iface(struct cfg8021
  		return -EOPNOTSUPP;
  
  	/* if it's part of a bridge, reject changing type to station/ibss */
-- 
1.7.10.4
