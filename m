Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768DE36C9E5
	for <backports@vger.kernel.org>; Fri,  8 May 2026 07:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778223838; cv=none; b=hZWVKoEsR4F7tdEVxpbNnu/A3KlZ0ITggzde79+lI3RWFp3aW3pMs/c7C4KCBLrlK+kHnZPdBbMICmS16vI9CWgG1ni81ACpB05sYRRDyaau1+DqoZNGUvmiRU7VS14NW9gvtdxYO+zpgV2NoVj3YLlr/fsaqkHX6RH/XYxZp7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778223838; c=relaxed/simple;
	bh=+CkLXDM6M3q0s/RzH6qdR0stLN10Q5NLDPUOHENse88=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=agpAvS7euOYuPr8KQdFPeh+HvfY0Zfxm5zGP5XemS2rBO+44PISrtgou2HH8kWhmB56O907ml5RYS1FRbx3uTj05IXq/3vr10hJHG0pskfXEZ4HdwTkORsw+SgJaDirDS7nLJ57OxOF4yUcwh9URzdUslsbDKmvnjTxaRpApFgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GsTpxsZf; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GsTpxsZf"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778223832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OIg6wXNLYTlHnZRkRxpSI2meaRkhs5oNOEVUMbP4rQM=;
	b=GsTpxsZfDrM2uADHSKap4xWz5qKg2Xu/N35IG4jQrup7aH8rtes+PMKywh7o4+SYxE+9ta
	6C0TVb9j5gwQ7y6KROtaBNoXXZqNHR7wGz4itCU3TbAFGw1qT5BX4/2ETrtLxSpDj/sNrC
	xNKOezh+G0GB56JBuQYXXKwIUQ2AqcQ=
From: Yi Cong <cong.yi@linux.dev>
To: hauke@hauke-m.de,
	backports@vger.kernel.org
Cc: yicong@kylinos.cn
Subject: [PATCH] gentree: keep directory intact and ignore if missing
Date: Fri,  8 May 2026 15:02:59 +0800
Message-Id: <20260508070259.193255-1-cong.yi@linux.dev>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Yi Cong <yicong@kylinos.cn>

Previously, `shutil.rmtree` removed the target directory
itself, breaking active terminal sessions in target output
and then need to cd target directory again which add some
additional operations during the manual debug test.

Optimize it so that only the output directory is cleared,
rather than deleting the entire thing.

Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 gentree.py | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/gentree.py b/gentree.py
index d709b907..7940c145 100755
--- a/gentree.py
+++ b/gentree.py
@@ -119,13 +119,22 @@ def check_output_dir(d, clean):
     sanity check the output when generating a tree, so usually
     running with --clean isn't suggested.
     """
+    if not os.path.exists(d):
+        return
+
     if clean:
-        shutil.rmtree(d, ignore_errors=True)
-    try:
-        os.rmdir(d)
-    except OSError as e:
-        if e.errno != errno.ENOENT:
-            raise
+        for item in os.listdir(d):
+            item_path = os.path.join(d, item)
+            if os.path.isdir(item_path) and not os.path.islink(item_path):
+                shutil.rmtree(item_path)
+            else:
+                os.unlink(item_path)
+    else:
+        if os.listdir(d):
+            raise OSError(
+                "Output directory '{}' exists and is not empty. "
+                "Use --clean to overwrite.".format(d)
+            )
 
 
 def copytree(src, dst, symlinks=False, ignore=None):
-- 
2.25.1

