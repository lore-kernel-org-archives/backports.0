Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33641 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692AbaEAX1J (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 1 May 2014 19:27:09 -0400
Received: by mail-pa0-f49.google.com with SMTP id kq14so4406923pab.8
        for <backports@vger.kernel.org>; Thu, 01 May 2014 16:27:09 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: [PATCH 2/8] backports: add backports-update-manager binary requirements
Date: Thu,  1 May 2014 16:26:45 -0700
Message-Id: <1398986811-25649-3-git-send-email-mcgrof@do-not-panic.com> (sfid-20140502_012711_507918_756D81CE)
In-Reply-To: <1398986811-25649-1-git-send-email-mcgrof@do-not-panic.com>
References: <1398986811-25649-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 devel/backports-update-manager | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/devel/backports-update-manager b/devel/backports-update-manager
index 8d2cd08..fc146c6 100755
--- a/devel/backports-update-manager
+++ b/devel/backports-update-manager
@@ -8,6 +8,7 @@ source_dir = os.path.abspath(os.path.dirname(__file__))
 sys.path.append(source_dir + '/../')
 from lib import bpar as ar
 from lib import bpgit as git
+from lib import bpreqs as reqs
 
 KPATH="http://kernel.ubuntu.com/~kernel-ppa/mainline/"
 BACKPORTS_KSRC_DIR="ksrc-backports"
@@ -562,6 +563,14 @@ def bk_tar_members(members):
             yield tarinfo
 
 def _main():
+    req = reqs.Req()
+    req.require_hint('ar', 'binutils')
+    req.require('make')
+    req.require('gcc')
+    req.require('git')
+    if not req.reqs_match():
+        sys.exit(1)
+
     parser = argparse.ArgumentParser(description='Linux kernel backports update manager')
     parser.add_argument('--force', const=True, default=False, action="store_const",
                         help='Force run without sanity or careful user checks')
-- 
1.9.1

