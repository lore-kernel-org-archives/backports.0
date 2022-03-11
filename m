Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA72C433EF
	for <backports@archiver.kernel.org>; Fri, 11 Mar 2022 20:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239663AbiCKUBa (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 11 Mar 2022 15:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238731AbiCKUB3 (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 11 Mar 2022 15:01:29 -0500
X-Greylist: delayed 602 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Mar 2022 12:00:24 PST
Received: from smtp-out.xnet.cz (smtp-out.xnet.cz [178.217.244.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB92A1BFDCB
        for <backports@vger.kernel.org>; Fri, 11 Mar 2022 12:00:24 -0800 (PST)
Received: from meh.true.cz (meh.true.cz [108.61.167.218])
        (Authenticated sender: petr@true.cz)
        by smtp-out.xnet.cz (Postfix) with ESMTPSA id 7877818FE0;
        Fri, 11 Mar 2022 20:50:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=true.cz; s=xnet;
        t=1647028220; bh=8f8C49Rq2cMIbT6+3HR0O4FEBROuqbWzVLaHiI0YzJE=;
        h=From:To:Cc:Subject:Date;
        b=Lg/Q7MZRKs+M6ToF2iqke2fc9xdVv/6VqeMXGQF9CVQYrxj5hrCOqA5AofQWm8shb
         FaDBbTE46IbDWDntwLpAHrO/WizdZje2aMSaX+zBTM9LaCNV7EV3Tuh2rJz6e52su5
         k1aeHrcEetvPgdt7seXj889TvIjGODpM2ThlEajM=
Received: by meh.true.cz (OpenSMTPD) with ESMTP id 485a96a4;
        Fri, 11 Mar 2022 20:49:55 +0100 (CET)
From:   =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>
To:     hauke@hauke-m.de, mcgrof@kernel.org
Cc:     backports@vger.kernel.org, Oskari Rauta <oskari.rauta@gmail.com>,
        =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>
Subject: [PATCH backports] headers: fix lockdep_assert_not_held()
Date:   Fri, 11 Mar 2022 20:48:00 +0100
Message-Id: <20220311194800.452-1-ynezz@true.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

LOCK_STATE_HELD define was omitted during backport of
lockdep_assert_not_held() which leads to build failures of kernels with
CONFIG_LOCKDEP=y:

 backports-5.15.8-1/backport-include/linux/lockdep.h:16:47: error: 'LOCK_STATE_HELD' undeclared (first use in this function)

Fix it by adding missing LOCK_STATE_HELD define.

References: https://github.com/openwrt/openwrt/pull/9373
Fixes: af58b27b1b1a ("headers: Add lockdep_assert_not_held()")
Reported-by: Oskari Rauta <oskari.rauta@gmail.com>
Signed-off-by: Petr Štetiar <ynezz@true.cz>
---
 backport/backport-include/linux/lockdep.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/backport/backport-include/linux/lockdep.h b/backport/backport-include/linux/lockdep.h
index ed5ea67894e4..842e24b7ff8f 100644
--- a/backport/backport-include/linux/lockdep.h
+++ b/backport/backport-include/linux/lockdep.h
@@ -11,6 +11,9 @@ struct lockdep_map { };
 
 #ifndef lockdep_assert_not_held
 #ifdef CONFIG_LOCKDEP
+#ifndef LOCK_STATE_HELD
+#define LOCK_STATE_HELD		1
+#endif /* LOCK_STATE_HELD */
 #define lockdep_assert_not_held(l)	do {				\
 		WARN_ON(debug_locks &&					\
 			lockdep_is_held(l) == LOCK_STATE_HELD);		\
--
To unsubscribe from this list: send the line "unsubscribe backports" in
