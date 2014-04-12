Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:47935 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755055AbaDLBfA (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 11 Apr 2014 21:35:00 -0400
Received: by mail-pb0-f54.google.com with SMTP id ma3so6031363pbc.41
        for <backports@vger.kernel.org>; Fri, 11 Apr 2014 18:35:00 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 04/10] backports: drop display output class support
Date: Fri, 11 Apr 2014 18:34:29 -0700
Message-Id: <1397266475-14442-5-git-send-email-mcgrof@do-not-panic.com> (sfid-20140412_033502_094280_EA661E01)
In-Reply-To: <1397266475-14442-1-git-send-email-mcgrof@do-not-panic.com>
References: <1397266475-14442-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Jean nuked display output class support so we won't
be needing the respective headers for compilation on
backports now. This is as seen on next-20140409.

commit f167a64e9d67ebd03d304e369c12011cf2bffaf5
Author: Jean Delvare <jdelvare@suse.de>
Date:   Mon Mar 17 15:49:10 2014 +0100

    video / output: Drop display output class support

    It was only ever used by the ACPI video driver, and that only use case
    vanished over 3 years ago (see commit 677bd810, "ACPI video: remove
    output switching control".) So this is dead code and I guess we can
    remove it now.

    Signed-off-by: Jean Delvare <jdelvare@suse.de>
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 copy-list | 1 -
 1 file changed, 1 deletion(-)

diff --git a/copy-list b/copy-list
index 76ce1c3..2794c0c 100644
--- a/copy-list
+++ b/copy-list
@@ -163,7 +163,6 @@ drivers/regulator/
 include/media/
 
 include/linux/videodev2.h
-include/linux/video_output.h
 
 include/uapi/linux/media.h
 include/uapi/linux/dvb/
-- 
1.9.1

