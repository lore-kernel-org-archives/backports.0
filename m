Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:29841 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757186Ab2HNTBd (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 14 Aug 2012 15:01:33 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q7EJ1WsA016468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <backports@vger.kernel.org>; Tue, 14 Aug 2012 15:01:32 -0400
Received: from quad.redhat.com (vpn-10-121.rdu.redhat.com [10.11.10.121])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q7EJ0h1d003968
	for <backports@vger.kernel.org>; Tue, 14 Aug 2012 15:01:32 -0400
From: Andy Gospodarek <andy@greyhouse.net>
To: backports@vger.kernel.org
Subject: [PATCH 5/5] compat: fixup firmware defines on RHEL6
Date: Tue, 14 Aug 2012 14:59:49 -0400
Message-Id: <1344970789-13047-6-git-send-email-andy@greyhouse.net>
In-Reply-To: <1344970789-13047-1-git-send-email-andy@greyhouse.net>
References: <1344970789-13047-1-git-send-email-andy@greyhouse.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Commit 182630e0f686a569aaf9b34781b08f27dc0ab1bb changed the way the
firmware code was handled to create new definitions based on config
options, not based on whether or not CONFIG_COMPAT_FIRMWARE_CLASS
was set.  Both need to be included to make this work properly in
environments like RHEL6 that do not need CONFIG_COMPAT_FIRMWARE_CLASS to
be set, but have CONFIG_FW_LOADER or CONFIG_FW_LOADER_MODULE set.  

Signed-off-by: Andy Gospodarek <andy@greyhouse.net>
---
 include/linux/compat-2.6.33.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/compat-2.6.33.h b/include/linux/compat-2.6.33.h
index 381146d..60caab0 100644
--- a/include/linux/compat-2.6.33.h
+++ b/include/linux/compat-2.6.33.h
@@ -15,6 +15,7 @@
 #include <linux/firmware.h>
 #include <linux/input.h>
 
+#if defined(CONFIG_COMPAT_FIRMWARE_CLASS)
 #if defined(CONFIG_FW_LOADER) || defined(CONFIG_FW_LOADER_MODULE)
 #define release_firmware compat_release_firmware
 #define request_firmware compat_request_firmware
@@ -49,6 +50,7 @@ static inline void compat_release_firmware(const struct firmware *fw)
 {
 }
 #endif
+#endif
 
 /* mask KEY_RFKILL as RHEL6 backports this */
 #if !defined(KEY_RFKILL)
-- 
1.7.1

