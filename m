Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18041376EB
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570615; cv=none; b=OC/7CmSTTV3NbfgiPncHz59DJP2VaNeSx+FyCm/AhDou3LFa6AnG83qZu3AsOSIewuBI6eV/3dSZmNTAVWG1ztS8fHcaxyslUDug/69hXU22VjTfTcm/VhGr1rJo3jYcSJOGck6AKpEymFRXMk1a0cxBYj3HD/AVYb/J6rRidfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570615; c=relaxed/simple;
	bh=pGMdygXej2Kig3KKgsfYZrZcNjvM94SKsXazWo3bIrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGpkomeWSoR3j0qVgsv6CgiPNnrN58RI4FB/Sl18bOJ3jjW7fMS4vhZMaURxC2oPJbCvk+UyxYcpNIj2i1D8dCk0d5IGTGFS7ootIbnfx0je/GnfUSE0YVOq5GciwtvIFnvnWUHW1zGe8XLKqjdzs3ZrBiNyh9YnkQ6qzrSsQI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=i8uv7hA0; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="i8uv7hA0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=LUa3IUWtgGbCKZH1aXnM0KxPyTVzPfD4QGeGpotr/4Q=;
	t=1716570614; x=1717780214; b=i8uv7hA0DiB9s2gkdWhJufTdD81r23yCh9JkaVtTYJ7C73/
	XTppK1wvZde69J9N5eHE2gg8Dawj2RfJi1Lmi0PkKAAIlpJVsDeK/dGh3uE/wLXvYooLPrclo64Ez
	SUuy6AvPEYYVFl3fDBgRogc2FC1iVwUb2tCaFVzhJObtA8Gth3yktlijdnyPFHlZqiAIJfhvbJflR
	7lQrTu7Sm+WlSfWPh8fzl9OiIBU6hqDa9bbvXKPSP5xKqCCQ3Y+BUcewvXfRDhoGAY3lOwTJHVFCO
	wpUILJT3rvssIcd+X+WwvT0go8tRHKot91MMlpkS41gTxPDAWkkn6/NsqMDEwsVA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQl-00000008Xuw-2VMD;
	Fri, 24 May 2024 19:10:11 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 59/74] backports: bpgit: handle copied files properly in status()
Date: Fri, 24 May 2024 19:08:11 +0200
Message-ID: <20240524190907.9e6de8b13f7b.I0331054c4f3fad9d33b9e51228dabd6a28bbf8fb@changeid>
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

'C' as the setatus also has two files, so need to continue
as well to get the second file added to this line.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 lib/bpgit.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bpgit.py b/lib/bpgit.py
index c48640871982..ed3b236933d5 100644
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
2.45.1

