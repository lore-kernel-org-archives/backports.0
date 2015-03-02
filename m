Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:48849 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929AbbCBITZ (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 2 Mar 2015 03:19:25 -0500
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] git-tracker: ask for verbose messages from per-commit processing
Date: Mon,  2 Mar 2015 09:19:22 +0100
Message-Id: <1425284362-5250-1-git-send-email-johannes@sipsolutions.net> (sfid-20150302_091927_537712_7841987D)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

The messages are only printed if something fails anyway, so
better ask for verbose messages to be able to better identify
what failed.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 devel/git-tracker.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/devel/git-tracker.py b/devel/git-tracker.py
index 7a89ba051f6f..9ce6ce455f95 100755
--- a/devel/git-tracker.py
+++ b/devel/git-tracker.py
@@ -69,7 +69,7 @@ def handle_commit(args, msg, branch, treename, kernelobjdir, tmpdir, wgitdir, ba
         failure = gentree.process(kernelobjdir, open(args.copy_list, 'r'),
                                   bpid=bpid, git_revision=kernel_rev,
                                   base_name=tree, logwrite=logwrite,
-                                  git_tracked_version=True)
+                                  verbose=True, git_tracked_version=True)
 
         newline = '\n'
         if failure:
-- 
2.1.4

