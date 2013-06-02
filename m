Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35989 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755029Ab3FBXQP (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 2 Jun 2013 19:16:15 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so4799822pbb.5
        for <backports@vger.kernel.org>; Sun, 02 Jun 2013 16:16:15 -0700 (PDT)
From: Thomas Pedersen <thomas@cozybit.com>
To: backports@vger.kernel.org
Cc: Thomas Pedersen <thomas@cozybit.com>
Subject: [PATCH] backports: specify python2.7 for gentree.py
Date: Sun,  2 Jun 2013 16:12:13 -0700
Message-Id: <1370214733-29993-1-git-send-email-thomas@cozybit.com> (sfid-20130603_011619_699121_3245A68D)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Apparently gentree.py uses some python2.7 specific syntax. Fixes:

./gentree.py -h
  File "./gentree.py", line 72
    except OSError, e:
                  ^
SyntaxError: invalid syntax

On distros where /usr/bin/python points to python3.

Signed-off-by: Thomas Pedersen <thomas@cozybit.com>
---
 gentree.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gentree.py b/gentree.py
index fef2faf..e43f508 100755
--- a/gentree.py
+++ b/gentree.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python2.7
 #
 # Generate the output tree into a specified directory.
 #
-- 
1.8.3

