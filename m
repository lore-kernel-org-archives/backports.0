Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:53427 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755306Ab3EQLAz (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 17 May 2013 07:00:55 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so706717pde.37
        for <backports@vger.kernel.org>; Fri, 17 May 2013 04:00:55 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 1/3] backports: address NFC LLCP code shift
Date: Fri, 17 May 2013 04:00:43 -0700
Message-Id: <1368788445-1641-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20130517_130056_980511_5CEC505F)
In-Reply-To: <1368788445-1641-1-git-send-email-mcgrof@do-not-panic.com>
References: <1368788445-1641-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Samuel folded code under net/nfc/llcp/ onto
the parent net/nfc/ directory with llcp_ prefixes
for the files. Address this change introduced
as of next-20130430.

commit 30cc4587659e1c9b1bfade8b2a757d91e04758ab
Author: Samuel Ortiz <sameo@linux.intel.com>
Date:   Fri Apr 26 11:49:40 2013 +0200

    NFC: Move LLCP code to the NFC top level diirectory

    And stop making it optional. LLCP is a fundamental part of the NFC
    specifications and making it optional does not make much sense.

    Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 copy-list |    1 -
 1 file changed, 1 deletion(-)

diff --git a/copy-list b/copy-list
index f2afa15..c7dcf39 100644
--- a/copy-list
+++ b/copy-list
@@ -129,7 +129,6 @@ drivers/gpu/drm/
 # NFC core
 net/nfc/
 net/nfc/hci/
-net/nfc/llcp/
 net/nfc/nci/
 include/net/nfc/
 include/uapi/linux/nfc.h
-- 
1.7.10.4

