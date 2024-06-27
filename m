Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B3C1A2FD5
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532135; cv=none; b=QgwdJhoxwyxJYUDwWQD3J6/jD77KxrRiApa4PVljOv2nv0IAA3YbXsQv+Kdjtumy7iHiMALWVSzyvmxURQ06cnzekyB8TIQntbNy5X/Y7CD6rCeRGoieLWmedTFaJ6qDMLIyFk4MlvLjFSBy/IBgycW9zN3G3i/Pg8px42hL3aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532135; c=relaxed/simple;
	bh=+4eQDQsuVfrXjBMJdDJQmYTS0/EdDurh3Yy0qMfzZJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pqr/npOvnQHCeHtiCTtZ4+49IlIn4msvPq8KH2b9UEV7RxuQOLhii10zx4nfzHVFGon5vJtDOQXo9fGn8g+Y2Ax+WG2whUh53tA4D8gf4FIjQoMX3Dg/lG2BqlTUOy+5It1TpBop0dxsNWp7mZpXP8VoK2LbBhA+SEyii/2cpps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=bxCX2idc; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="bxCX2idc"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W9FdQ1MwCz9spY;
	Fri, 28 Jun 2024 01:48:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hYuY6CfavjSTmNlMuCyzDWWTcUKFlL/RxzEKdpJtE4k=;
	b=bxCX2idc+DM+nzZAMVsvXHmkzvUnzD9Gb+MXNsXjtyamtSpPvf2MPTcFLKEJQsY3XwY4VJ
	CKqjHeNJ+pwt1uRen8aRDR3rn5VrgaHYU22su+KCAJb1vx4EeYa0ILhbJVPH7VOjaDXK/S
	Zb5Qlev7Y6ig4fDnG3GOQquIy9EBcDICW+K40epJjG439vMo37JRbQmdNJb22M/+5B18j4
	3w6ru1IRqGlUo6ByVf4snBUIjL2vEN/zCmbakO01pnUTaZALUkGPgXYbkNU5RKfZ/F/T27
	Tb+OTPhJQHn0Abif7ITPChMUWqnWzYtmLQn6/OWA54nZZxkXAuKPfzQG+8UMZg==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Luciano Coelho <luciano.coelho@intel.com>
Subject: [PATCH 10/75] backports: bpgit: handle copied files properly in status()
Date: Fri, 28 Jun 2024 01:46:56 +0200
Message-ID: <20240627234808.1253337-11-hauke@hauke-m.de>
In-Reply-To: <20240627234808.1253337-1-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W9FdQ1MwCz9spY

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
index c4864087..ed3b2369 100644
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
2.45.2

