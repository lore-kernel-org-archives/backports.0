Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7436FC4167E
	for <backports@archiver.kernel.org>; Fri, 13 May 2022 16:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382327AbiEMQGV (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 13 May 2022 12:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382326AbiEMQGV (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 13 May 2022 12:06:21 -0400
Received: from web.adapt-ip.com (mail.adapt-ip.com [107.194.246.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90554FD20
        for <backports@vger.kernel.org>; Fri, 13 May 2022 09:06:20 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 3374D6E3A81;
        Fri, 13 May 2022 16:06:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id P_7-0dCZrhva; Fri, 13 May 2022 16:06:17 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (c-73-162-155-239.hsd1.ca.comcast.net [73.162.155.239])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id C0AFE6E3A83;
        Fri, 13 May 2022 16:05:29 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     backports <backports@vger.kernel.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v2 11/15] kconfig: fix select conversion for BPAUTO_ symbols in integration mode
Date:   Fri, 13 May 2022 09:05:19 -0700
Message-Id: <20220513160523.2944694-12-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220513160523.2944694-1-thomas@adapt-ip.com>
References: <20220513160523.2944694-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

In integration mode, the bpid.project_prefix is nonzero
and needs to be prepended to the expected symbol to get a
match.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 lib/kconfig.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/kconfig.py b/lib/kconfig.py
index a77f8a54eea7..0b5f8ebc1726 100644
--- a/lib/kconfig.py
+++ b/lib/kconfig.py
@@ -228,9 +228,10 @@ class ConfigTree(object):
             out = ''
             for l in open(os.path.join(self.bpid.target_dir, nf), 'r'):
                 m = sel_line.match(l)
+                bpauto_prefix = self.bpid.project_prefix + 'BPAUTO_'
                 if m and not m.group('sym') in syms:
-                    if 'BPAUTO_' + m.group('sym') in syms:
-                        out += m.group('spc') + "select BPAUTO_" + m.group('sym') + '\n'
+                    if bpauto_prefix + m.group('sym') in syms:
+                        out += m.group('spc') + "select " + bpauto_prefix + m.group('sym') + '\n'
                     else:
                         out += m.group('spc') + "depends on " + m.group('sym') + '\n'
                 else:
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
