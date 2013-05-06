Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:47578 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755971Ab3EFVyc (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 6 May 2013 17:54:32 -0400
Received: by mail-pb0-f41.google.com with SMTP id mc17so2230828pbc.14
        for <backports@vger.kernel.org>; Mon, 06 May 2013 14:54:32 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH v2 4/4] ckmake: make --check-exports default
Date: Mon,  6 May 2013 14:54:26 -0700
Message-Id: <1367877266-11028-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130506_235434_554324_8D75FEBA)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Remove --check-exports as an option and now just enable it by default.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 devel/ckmake |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/devel/ckmake b/devel/ckmake
index 0b738e5..61f9864 100755
--- a/devel/ckmake
+++ b/devel/ckmake
@@ -180,7 +180,7 @@ def process_kernel(num, kset, cmdline_args):
 
 		log_file.close()
 		status = p.returncode
-		if status == 0 and cmdline_args.check_exports:
+		if status == 0
 			warn = re.compile('^WARNING:.*undefined.*')
 			log_file = open(log_file_name, 'r')
 			for l in log_file:
@@ -413,8 +413,6 @@ if __name__ == "__main__":
 			    help='Build allyesconfig rather than only backport code.')
 	parser.add_argument('--defconfig', metavar='<name>', type=str,
 			    help='Build this defconfig rather than only backport code.')
-	parser.add_argument('--check-exports', const=True, default=False, action="store_const",
-			    help='Check for linker warnings indicating exported symbols are missing.')
 	args = parser.parse_args()
 
 	if not os.path.exists(modules):
-- 
1.7.10.4

