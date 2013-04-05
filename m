Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:11865 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161039Ab3DECEs (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 4 Apr 2013 22:04:48 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r3524mnY032721
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <backports@vger.kernel.org>; Thu, 4 Apr 2013 22:04:48 -0400
Received: from localhost.localdomain.com (vpn-55-210.rdu2.redhat.com [10.10.55.210])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id r3524mcP013017
	for <backports@vger.kernel.org>; Thu, 4 Apr 2013 22:04:48 -0400
From: Andy Gospodarek <andy@greyhouse.net>
To: backports@vger.kernel.org
Subject: [PATCH 1/2] fixup error when LINUX_BACKPORT macro was added
Date: Thu,  4 Apr 2013 22:04:46 -0400
Message-Id: <1365127487-30058-1-git-send-email-andy@greyhouse.net> (sfid-20130405_040453_347853_1770EEEC)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Commit a05e783cb8853210628bd1f2bd82d17dd004c9d1 did not properly
backport the symbols for:

schedule_delayed_work
schedule_delayed_work_on

as it left the 'compat' string there when adding the LINUX_BACKPORT
symbol.  This resulted in these two not getting redefined and kernels
with these backported resulted in duplicate symbols when trying to load
compat.ko.

Signed-off-by: Andy Gospodarek <andy@greyhouse.net>
---
 include/linux/compat-2.6.36.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/compat-2.6.36.h b/include/linux/compat-2.6.36.h
index d90b84f..b760a62 100644
--- a/include/linux/compat-2.6.36.h
+++ b/include/linux/compat-2.6.36.h
@@ -168,10 +168,10 @@ void backport_system_workqueue_destroy(void);
 int schedule_work(struct work_struct *work);
 #define schedule_work_on LINUX_BACKPORT(schedule_work_on)
 int schedule_work_on(int cpu, struct work_struct *work);
-#define compat_schedule_delayed_work LINUX_BACKPORT(compat_schedule_delayed_work)
+#define schedule_delayed_work LINUX_BACKPORT(schedule_delayed_work)
 int schedule_delayed_work(struct delayed_work *dwork,
 			  unsigned long delay);
-#define compat_schedule_delayed_work_on LINUX_BACKPORT(compat_schedule_delayed_work_on)
+#define schedule_delayed_work_on LINUX_BACKPORT(schedule_delayed_work_on)
 int schedule_delayed_work_on(int cpu,
 			     struct delayed_work *dwork,
 			     unsigned long delay);
-- 
1.8.1.4

