Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE17C43217
	for <backports@archiver.kernel.org>; Wed, 24 Nov 2021 06:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbhKXGDn (ORCPT <rfc822;backports@archiver.kernel.org>);
        Wed, 24 Nov 2021 01:03:43 -0500
Received: from mail.adapt-ip.com ([107.194.246.123]:56652 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbhKXGDm (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 24 Nov 2021 01:03:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 207F4744D70;
        Wed, 24 Nov 2021 05:55:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id fjsxB4hlXQXP; Wed, 24 Nov 2021 05:55:12 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (c-67-180-239-163.hsd1.ca.comcast.net [67.180.239.163])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 7B937744D6E;
        Wed, 24 Nov 2021 05:55:07 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     backports <backports@vger.kernel.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Luis Rodriguez <mcgrof@kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH 4/7] gentree: do not prefix Kernel.local symbols
Date:   Tue, 23 Nov 2021 21:55:02 -0800
Message-Id: <20211124055505.1267128-5-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211124055505.1267128-1-thomas@adapt-ip.com>
References: <20211124055505.1267128-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

In package mode the prefix is empty, so the ignore list
does not matter. In integration mode there is a nonzero
prefix, so add Kconfig.local to the ignore list like
elsewhere in gentree.py.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 gentree.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gentree.py b/gentree.py
index 0576e14d6fe5..9699ce0128d0 100755
--- a/gentree.py
+++ b/gentree.py
@@ -235,7 +235,7 @@ def add_automatic_backports(args):
     export = re.compile(r'^EXPORT_SYMBOL(_GPL)?\((?P<sym>[^\)]*)\)')
     bpi = kconfig.get_backport_info(os.path.join(args.bpid.target_dir, 'compat', 'Kconfig'))
     configtree = kconfig.ConfigTree(os.path.join(args.bpid.target_dir, 'Kconfig'), args.bpid)
-    ignore=['Kconfig.kernel', 'Kconfig.versions']
+    ignore=['Kconfig.kernel', 'Kconfig.versions', 'Kconfig.local']
     configtree.verify_sources(ignore=ignore)
     git_debug_snapshot(args, "verify sources for automatic backports")
     all_selects = configtree.all_selects()
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
