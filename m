Return-path: <backports-owner@vger.kernel.org>
Received: from mailout01.c03.mtsvc.net ([72.47.247.113]:50955 "EHLO
	mailout01.c03.mtsvc.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752198AbaHSOoS (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 19 Aug 2014 10:44:18 -0400
From: Jacob Siverskog <jacob@teenageengineering.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org,
	Jacob Siverskog <jacob@teenageengineering.com>
Subject: [PATCH] backports: always use absolute path to output directory, less probability of pycocci failure.
Date: Tue, 19 Aug 2014 16:26:12 +0200
Message-Id: <1408458372-17508-1-git-send-email-jacob@teenageengineering.com> (sfid-20140819_164420_597616_51B14F1F)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

While running gentree.py I got error messages such as 'Failed to
process SmPL patch
collateral-evolutions/generic/0001-group-attr/0001-group_attr_class.cocci',
due to incorrect path handling. This patch always makes gentree always
call pycocci with the absolute path to the output directory.

Signed-off-by: Jacob Siverskog <jacob@teenageengineering.com>
---
 gentree.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gentree.py b/gentree.py
index 5fe6996..9b4db98 100755
--- a/gentree.py
+++ b/gentree.py
@@ -725,7 +725,7 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
         extra_spatch_args = []
         if args.profile_cocci:
             cmd.append('--profile-cocci')
-        cmd.append(args.outdir)
+        cmd.append(os.path.abspath(args.outdir))
         print_name = cocci_file[prefix_len:]
         if args.verbose:
             logwrite("Applying SmPL patch %s" % print_name)
-- 
1.8.3.2

