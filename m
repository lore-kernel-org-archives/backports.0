Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87B01A2549
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532131; cv=none; b=EdqlUb+Yi7oesfVhJekJ4bojCWwf/pT1FniK8hj74QmEdCacz4oR+/FBZGOjuHhb0zqGwVrFmpPGguBWbaFDYJbua4ACtLYdR8SLwpk7f7XgMPvNy4ZWIqRuEluuZFkVtOoepgpJ63QpSqf01347qUR59UfQ/u5nlN/UtqXtzwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532131; c=relaxed/simple;
	bh=sxRHMcDS1sWMBNcffwFLKimTIKyuNr69uBHiq9oi5WE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cILykO9ETQjJM+mb71R0WfACHiVOs3B2KkCVQNInpNCLHEaAl3OvQGCRfDk8VjpaHnA3b9Zf03BILb5Ege+XmVD/FonQgMeqJMp+nKwQwuwqL+pA130jTa2gKsFZn9xxy0zC7yOA+ZHbIYSh+IA2cF/SkjD9WA4+z8zP32qjmlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=nbAxcOax; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="nbAxcOax"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4W9FdN6Yjcz9sTV;
	Fri, 28 Jun 2024 01:48:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8zzG8m5Add8JmYZNo6QcYfgorNg571rDEBPZhXgNGu0=;
	b=nbAxcOax8G/du3sBLCsm8EW2j63EQiQvfuytXdBEfsT7lnfyd1A2HBC3DW46l8pkS6dRj+
	LaNc+Q0aoLE5m2mDddBG/vE9b3W6PKXSPbmHwy2iUKC7AMu3NeduR2oo+IlmNgNGloV9XX
	d4FwFo0ojiDUsSglOZ6iuSxgRIwdUnUR++0kWIPefZ8t1nZ2rx/Sko+HFljRul2kWvEyod
	meEjypKraSrl3M7NSmql9UxNYMm4qyiB67OLvEDaAKyVDquXwIEKwZiSlw44Hs/mFvFpLb
	GX9WwYVyqxKICnqpSQr+sbOpbmT3kHp9kTautu5LomUzrf8dbvd/uUC5pDTc+w==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 07/75] gentree: fix python quoting errors
Date: Fri, 28 Jun 2024 01:46:53 +0200
Message-ID: <20240627234808.1253337-8-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W9FdN6Yjcz9sTV

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 gentree.py | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/gentree.py b/gentree.py
index 05bb91b3..a80b0a8d 100755
--- a/gentree.py
+++ b/gentree.py
@@ -325,18 +325,18 @@ def get_rel_spec_stable(rel):
     """
     if ("rc" in rel):
         m = re.match(r"(?P<VERSION>\d+)\.+" \
-                     "(?P<PATCHLEVEL>\d+)[.]*" \
-                     "(?P<SUBLEVEL>\d*)" \
-                     "[-rc]+(?P<RC_VERSION>\d+)\-+" \
-                     "(?P<RELMOD_UPDATE>\d+)[-]*" \
-                     "(?P<RELMOD_TYPE>[usnpc]*)", \
+                     r"(?P<PATCHLEVEL>\d+)[.]*" \
+                     r"(?P<SUBLEVEL>\d*)" \
+                     r"[-rc]+(?P<RC_VERSION>\d+)\-+" \
+                     r"(?P<RELMOD_UPDATE>\d+)[-]*" \
+                     r"(?P<RELMOD_TYPE>[usnpc]*)", \
                      rel)
     else:
         m = re.match(r"(?P<VERSION>\d+)\.+" \
-                     "(?P<PATCHLEVEL>\d+)[.]*" \
-                     "(?P<SUBLEVEL>\d*)\-+" \
-                     "(?P<RELMOD_UPDATE>\d+)[-]*" \
-                     "(?P<RELMOD_TYPE>[usnpc]*)", \
+                     r"(?P<PATCHLEVEL>\d+)[.]*" \
+                     r"(?P<SUBLEVEL>\d*)\-+" \
+                     r"(?P<RELMOD_UPDATE>\d+)[-]*" \
+                     r"(?P<RELMOD_TYPE>[usnpc]*)", \
                      rel)
     if (not m):
         return m
@@ -347,8 +347,8 @@ def get_rel_spec_next(rel):
     Returns release specs for a linux-next backports based release.
     """
     m = re.match(r"(?P<DATE_VERSION>\d+)[-]*" \
-                 "(?P<RELMOD_UPDATE>\d*)[-]*" \
-                 "(?P<RELMOD_TYPE>[usnpc]*)", \
+                 r"(?P<RELMOD_UPDATE>\d*)[-]*" \
+                 r"(?P<RELMOD_TYPE>[usnpc]*)", \
                  rel)
     if (not m):
         return m
@@ -1099,7 +1099,7 @@ def process(kerneldir, copy_list_file, git_revision=None,
     # groups -- 50 seemed safer and is still fast)
     regexes = []
     for some_symbols in [disable_makefile[i:i + 50] for i in range(0, len(disable_makefile), 50)]:
-        r = '^(([^#].*((' + bpid.full_prefix_resafe + '|CONFIG_)(' + '|'.join([s for s in some_symbols]) + ')))\W)'
+        r = '^(([^#].*((' + bpid.full_prefix_resafe + '|CONFIG_)(' + '|'.join([s for s in some_symbols]) + r')))\W)'
         regexes.append(re.compile(r, re.MULTILINE))
     for f in maketree.get_makefiles():
         data = open(f, 'r').read()
-- 
2.45.2

