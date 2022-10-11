Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B10BC433FE
	for <backports@archiver.kernel.org>; Tue, 11 Oct 2022 21:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiJKVFN (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiJKVFA (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 11 Oct 2022 17:05:00 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F96A222B5
        for <backports@vger.kernel.org>; Tue, 11 Oct 2022 14:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=kT5TIXie8nSZNU7V95ncfYqmYFnnIXEXOKjb1JlMsHo=;
        t=1665522295; x=1666731895; b=uf5NMbdqNdRArG3aMa3e2EBr7LyxNJuWOqeWuN0GfFPOPPi
        IxoNp3Vkfc7uDV4qnHSTtl9rIBy8OjV2XM2NApDdA69tFYPBzfCyf5vdPGMz62+DKD2gbQLwXsBtt
        dO4aF1S/mvtimFnB25KkeuyabaEdjWgDKVb3xHOwYAz6PQCt4iGNHQ9E/I7TFJ5VlVO31UpUpvviW
        yuTsoXW9Mse7r3tZRFakCC57733nL6L7ffogqu3wZC5e5Gl41Ja3mRJ3x4QGOMhWZ9WXuJ8gFjsbz
        pYnBeGUZJsHhwoGFkViqEA5yTdO9asNusG6fQAdEGHc+T7pDdREV+lHomFR5x2/w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oiMQj-0045LP-14;
        Tue, 11 Oct 2022 23:04:49 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     nbd@nbd.name, Johannes Berg <johannes.berg@intel.com>,
        Luciano Coelho <luciano.coelho@intel.com>
Subject: [PATCH 03/38] backports: bpgit: handle copied files properly in status()
Date:   Tue, 11 Oct 2022 23:04:11 +0200
Message-Id: <20221011230356.e477f575e241.I0331054c4f3fad9d33b9e51228dabd6a28bbf8fb@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011210446.144768-1-johannes@sipsolutions.net>
References: <20221011210446.144768-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

'C' as the setatus also has two files, so need to continue
as well to get the second file added to this line.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-on: https://git-ger-8.devtools.intel.com/gerrit/135974
Reviewed-by: Luciano Coelho <luciano.coelho@intel.com>
Tested-by: Luciano Coelho <luciano.coelho@intel.com>
---
 lib/bpgit.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bpgit.py b/lib/bpgit.py
index 9d35a3896ed9..77dab8bd2528 100644
--- a/lib/bpgit.py
+++ b/lib/bpgit.py
@@ -50,7 +50,7 @@ def status(tree=None):
     of the form
     ('XY', 'filename')
     or
-    ('XY', 'filename_to', 'filename_from')   [if X is 'R' for rename]
+    ('XY', 'filename_to', 'filename_from')   [if X is 'R' for rename or 'C' for copy]
     '''
     cmd = ['git', 'status', '--porcelain', '-z']
 
@@ -70,7 +70,7 @@ def status(tree=None):
             cur.append(i[:2])
             assert i[2] == ' '
             cur.append(i[3:])
-            if i[0] == 'R':
+            if i[0] in ['R', 'C']:
                 continue
         else:
             cur.append(i)
-- 
2.37.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
