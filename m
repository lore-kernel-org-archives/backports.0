Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 03/24] compat-drivers: do not treat a warning as error
Date: Tue, 26 Feb 2013 21:37:55 +0100
Message-Id: <1361911096-29117-4-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1361911096-29117-1-git-send-email-hauke@hauke-m.de>
References: <1361911096-29117-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

Older kernel version show more warnings like -Werror=unused-but-set-variable
and with this option they are treated as an error.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .../collateral-evolutions/network/68-do-not-add-Werror.patch   |    8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 patches/collateral-evolutions/network/68-do-not-add-Werror.patch

diff --git a/patches/collateral-evolutions/network/68-do-not-add-Werror.patch b/patches/collateral-evolutions/network/68-do-not-add-Werror.patch
new file mode 100644
index 0000000..066df6e
--- /dev/null
+++ b/patches/collateral-evolutions/network/68-do-not-add-Werror.patch
@@ -0,0 +1,8 @@
+--- a/drivers/net/wireless/ath/wil6210/Makefile
++++ b/drivers/net/wireless/ath/wil6210/Makefile
+@@ -9,5 +9,4 @@ wil6210-objs += wmi.o
+ wil6210-objs += interrupt.o
+ wil6210-objs += txrx.o
+ 
+-subdir-ccflags-y += -Werror
+ subdir-ccflags-y += -D__CHECK_ENDIAN__
-- 
1.7.10.4
