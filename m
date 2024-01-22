Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046683A8F9
	for <backports@vger.kernel.org>; Mon, 22 Jan 2024 21:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705959421; cv=none; b=AqR67LxqsgNbdprg01PRNU2WQaBWUQ0Zq/yN6FJoBFYP8Bb63y14Yu2cwFokYjQZ6HaLt2fKi8R3P4bWyJsm2ntRQvfvCdpJ2WpzgBYyx0lDN/zpxB2b4Akwc6kvKAf7FUMn24cJ6cYzKuTMa5X+sOepaJKeRsIt22Y5Ozwg+eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705959421; c=relaxed/simple;
	bh=xDTBzNAvXQaQB8AfDbIE5GAueM6dM7sMNKrulZNWIv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lyJ6YmFnGMmGYQTgOlhYGcyVqMtNq7XLzwVWFlepvJ0Okb8aUuyEEGchmXhUurBuxqwpB0Ybb7cFNaGvlNN6ncTtZbCjX07LfP3W3skIQaVvQqHzxHXAToOZDDDpIGsaoTe7AUZEMltTMsDWOzwfvxack3bdeVnn91cscCmtSac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=ZZbUouvm; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="ZZbUouvm"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TJk7r3pDvz9slt;
	Mon, 22 Jan 2024 22:36:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1705959416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PNjplWz/ByCQuIPAwBL/Lg+iw4o1qrAmLD85TvHBjnA=;
	b=ZZbUouvmoUqCYXHpiAvkzdpGj0YhvKvg/Ci77dGFc8TF584UxZAZz8OE/3hgK7cT4tlxrQ
	zcnY0TDhvQsJO3aKTDj21Sg7VUtOaAIv7lw9aOOZ563zNUGgfuAW/y2hJrbgFQ2AFH79oq
	RuEc4MVtXkpCp/nFWJPjJvYkreB2OKM3qcbysAU1Vdt1X2sKMAJe8IRiP6YIUmlZv2PMSw
	dwC4nRTWHCbNlOODVtoBlSabbi0TZiPexPhZCSGjhFn/Kw68oG8ImzEFiHVbsnX4Zj3PJs
	MYkHdTFiic0KQPRan4o22E4Cbmp0SGE8mTxuliD425VCi0gM5pJejyebrt4/jQ==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/2] backports-update-manager: Add option to not update git trees
Date: Mon, 22 Jan 2024 22:36:48 +0100
Message-ID: <20240122213649.149703-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the '--no-git-update which will deactivate updating the git trees.
This can be used in the github actions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 devel/backports-update-manager | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/devel/backports-update-manager b/devel/backports-update-manager
index 9177be76..815a0421 100755
--- a/devel/backports-update-manager
+++ b/devel/backports-update-manager
@@ -629,6 +629,8 @@ def _main():
     parser.add_argument('--reference', metavar='<path-to-git-obj-dir>', type=str,
                         default=None,
                         help='Override what argument to use to git clone --reference')
+    parser.add_argument('--no-git-update', const=True, default=False, action="store_const",
+                        help='Don\'t update git trees')
     args = parser.parse_args()
 
     bk_updater = backport_kernel_updater(yes=args.yes or args.force,
@@ -649,7 +651,8 @@ def _main():
     bk_updater.remove_stale_kernel_dirs()
     bk_updater.get_backport_pkgs()
     bk_updater.extract_backport_pkgs()
-    bk_updater.update_git_trees()
+    if not args.no_git_update:
+        bk_updater.update_git_trees()
 
     return 0
 
-- 
2.43.0

