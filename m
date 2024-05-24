Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC9612EBC9
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570561; cv=none; b=dJlZbqTzcn5eIIBjgjzQ9MoHk6taG44zJisp+0L3dwLRAdQwtduyiK/DY6yQts/c/brq/M95/avlRLH/4mgr59bCw6nfw7EOEDfxS5pf08a7Q9rFfeEK2C9uHITI8MmWjl0gGV9f2IU42NFMlIVF+OCnP2ygTTRabmPemJns8S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570561; c=relaxed/simple;
	bh=vv4qGe1UAumkQ4wSch6uTTp9AdEUJtju2263fhtTp04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Quv5+NMsyeSDpqubW82wyWw3r8MKM/u2MzF3SMPyt265LHdVa6ZVaapTrh9dq4El0Q/iZAvshAI/WCIijXWJin0/12onBrtqJ0mziWSDmq2VtlPKH7oflOgVSUeEuVJ16HG8BShkAolnyCTc49K7KhG18MJOGz6ir4hcrbohcSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=DE659tlB; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="DE659tlB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=3htqzQPxW34FWM5oSonEr1H66qNQHMWv4eyRm4JFb8g=;
	t=1716570559; x=1717780159; b=DE659tlBqTS13oK9ZM5SAyIH+ORiPnVHvf/N7myXtcjXBov
	D+NYAnNOoqEeeYrK7LcIVV4v5i6TWlIahMNTmtLrEyKQkOeRKx89MqZU42Uhdo7vouKSMengx2MIX
	9zuOJ+zizR/xZWoz4ZO9SIBs/SRcb2XnniR2u4jROSpiy6QFZ6cWFvVjeO63NRk7l+C/gWORXsPHb
	E1xB96cJ9/xJTee03OdumVcKuuXi5j7dC9tgPoPmzuKJ5ZBGgh+SuBpMAbvfFCyUrf9eJIJr936SI
	BIW/uee6bYzH9BIpFMiE8qWeEC7RbdaEtsarjQX22B4Gs84FRel4SKqduKsOE3Nw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYPn-00000008Xuw-2fH5;
	Fri, 24 May 2024 19:09:11 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 01/74] gentree: fix python quoting errors
Date: Fri, 24 May 2024 19:07:13 +0200
Message-ID: <20240524190906.d575052d1a9d.I8d3a02f96f06f8e5e7f2852f56f008045f5ea72d@changeid>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524170906.54680-76-johannes@sipsolutions.net>
References: <20240524170906.54680-76-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 gentree.py | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/gentree.py b/gentree.py
index 05bb91b39291..a80b0a8def29 100755
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
2.45.1

