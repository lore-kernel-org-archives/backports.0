Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:44377 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032298AbbKFIQP (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 6 Nov 2015 03:16:15 -0500
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] gentree: fix Makefile symbol disabling
Date: Fri,  6 Nov 2015 09:16:10 +0100
Message-Id: <1446797770-32354-1-git-send-email-johannes@sipsolutions.net> (sfid-20151106_091617_823502_44C4BA59)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Currently, a Makefile line like this:

    obj-$(CONFIG_IPW2100) += ipw2x00/

will get mangled into

    #obj-$(CONFIG_IPW2100+= ipw2x00/

when disabled by the gentree script. Fix the regular
expression to contain the entire match as the first
group, so it gets all preserved when replaced later
by "#\1" using expression.sub().

This then makes it come out as

    #obj-$(CONFIG_IPW2100) += ipw2x00/

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 gentree.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gentree.py b/gentree.py
index 636ea609ba57..772095fcf580 100755
--- a/gentree.py
+++ b/gentree.py
@@ -1057,7 +1057,7 @@ def process(kerneldir, copy_list_file, git_revision=None,
     # groups -- 50 seemed safer and is still fast)
     regexes = []
     for some_symbols in [disable_makefile[i:i + 50] for i in range(0, len(disable_makefile), 50)]:
-        r = '^([^#].*((' + bpid.full_prefix_resafe + '|CONFIG_)(' + '|'.join([s for s in some_symbols]) + ')))\W'
+        r = '^(([^#].*((' + bpid.full_prefix_resafe + '|CONFIG_)(' + '|'.join([s for s in some_symbols]) + ')))\W)'
         regexes.append(re.compile(r, re.MULTILINE))
     for f in maketree.get_makefiles():
         data = open(f, 'r').read()
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
