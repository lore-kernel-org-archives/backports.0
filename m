Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:50974 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727029AbeITRLy (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 20 Sep 2018 13:11:54 -0400
From: Luca Coelho <luca@coelho.fi>
To: backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>
Date: Thu, 20 Sep 2018 14:28:33 +0300
Message-Id: <20180920112842.27198-6-luca@coelho.fi> (sfid-20180920_132854_736515_CA1AACB0)
In-Reply-To: <20180920112842.27198-1-luca@coelho.fi>
References: <20180920112842.27198-1-luca@coelho.fi>
Subject: [PATCH 05/14] backport: convert tree section names to ascii
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

For some reason, sometimes when the git logs contain non-ascii
characters, we get some conversion errors.  This only happens if one
of the strings we use is explicitly unicode, otherwise everything is
fine.  The only string we use that is of unicode type is the tree
names that comes from the configuration sections.  To avoid issues,
convert the strings we get from the config file into ascii before
using it.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 devel/git-tracker.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/devel/git-tracker.py b/devel/git-tracker.py
index 1789ad975154..d51f59ba6507 100755
--- a/devel/git-tracker.py
+++ b/devel/git-tracker.py
@@ -190,6 +190,8 @@ if __name__ == '__main__':
         backport_rev = git.rev_parse(tree=source_dir)
 
         for tree in trees:
+            # make sure tree is ascii to prevent conversion problems
+            tree = str(tree)
             input = config.get(tree, 'input')
             output = config.get(tree, 'output')
             defconfig = None
-- 
2.18.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
