Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/5] compat: do not undef flush_scheduled_work
Date: Thu, 28 Mar 2013 20:18:25 +0100
Message-Id: <1364498307-11855-3-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1364498307-11855-1-git-send-email-hauke@hauke-m.de>
References: <1364498307-11855-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

This caused flush_scheduled_work instead of
backport_flush_scheduled_work being exported.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 compat/compat-2.6.36.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/compat/compat-2.6.36.c b/compat/compat-2.6.36.c
index 3479af4..9295895 100644
--- a/compat/compat-2.6.36.c
+++ b/compat/compat-2.6.36.c
@@ -133,7 +133,6 @@ int schedule_delayed_work_on(int cpu,
 }
 EXPORT_SYMBOL_GPL(schedule_delayed_work_on);
 
-#undef flush_scheduled_work
 void flush_scheduled_work(void)
 {
 	/*
-- 
1.7.10.4
