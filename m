Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7A5C4332F
	for <backports@archiver.kernel.org>; Fri, 13 May 2022 16:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381696AbiEMQGJ (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 13 May 2022 12:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382315AbiEMQGI (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 13 May 2022 12:06:08 -0400
Received: from web.adapt-ip.com (mail.adapt-ip.com [107.194.246.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A24E087
        for <backports@vger.kernel.org>; Fri, 13 May 2022 09:06:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id CFE416E3A78;
        Fri, 13 May 2022 16:06:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id 6IaAPl1UraK0; Fri, 13 May 2022 16:06:02 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (c-73-162-155-239.hsd1.ca.comcast.net [73.162.155.239])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 38E3F6E3A71;
        Fri, 13 May 2022 16:05:27 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     backports <backports@vger.kernel.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v2 05/15] backport: define BACKPORT_DIR for Kconfig.integrate
Date:   Fri, 13 May 2022 09:05:13 -0700
Message-Id: <20220513160523.2944694-6-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220513160523.2944694-1-thomas@adapt-ip.com>
References: <20220513160523.2944694-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

define BACKPORT_DIR in the integration Kconfig so we
don't have to supply it in an environment variable
(where it can probably only ever be "backports/"
anyway).

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 backport/Kconfig.integrate | 1 +
 1 file changed, 1 insertion(+)

diff --git a/backport/Kconfig.integrate b/backport/Kconfig.integrate
index d98c371cd438..6c85cdc27568 100644
--- a/backport/Kconfig.integrate
+++ b/backport/Kconfig.integrate
@@ -1,3 +1,4 @@
+BACKPORT_DIR:=%%BACKPORT_DIR%%
 config BACKPORT_INTEGRATE
 	bool
 	def_bool y
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
