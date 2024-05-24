Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B0286AD6
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570629; cv=none; b=i3U79tgaSAQAdBwxgB95c6i7ljuNt6JYvHJ/ZZx71djIPnCiS2e3BH3EuMH36Lc2RqDWVxSBwV0sPV0vBOr9hJwzZAn785BD/b8joOkGct0cmw5tES8fLUOkZYrqjtbLUHdKVXHc7JdHW4kt3fdA76i7BcOJk+EI2DepnY7p5iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570629; c=relaxed/simple;
	bh=EUaswkyLqyYHD9gMj3C+b48zVAirDz8QFpQVK8NUs34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDxSu8ZJ6LDzC4F/yvCqXt1s6CbQlx9R1a6rpO9laoCG2XOrinkBPQhoIvHVbxmeL2eJOynYXKRxKe/rBgUlMVvgc7bjC9QDb5EeE5hiXRKDRLa8ii/uZk0TzeRizgmL9AU/b9VHTASkd0+f02FidpIijb6tKd2WKhQAbXz3kws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=WUR92BUL; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="WUR92BUL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=RPTbkZLm/TKnNkCjDByGa2ORx8d1nlqQiIxNyUu2j4E=;
	t=1716570628; x=1717780228; b=WUR92BULfDZlMCk19fcCxjRHkGX08AkVmbgSjyU6psUFGti
	SMR4uMg2pcbowA7Q7EZxfXw6wX0yxRKk0lHDUqL4X1OEODADc43qUpoE1+d4yEO0EylAQQgy3mlfv
	LLx0idVY5XTAePOkQOwVUJwm7zZx7thQe82uoN5Aw0h+k3JNC9NGZSPZgvBSK5f4iHvtKLydD3juF
	G2gDfgP+iD424htc7KkOzTqvf4EQ+ZLb5sB/577VW4hnVMStST7ANBk/dL5VgqIKLAgySm/b4vlkU
	Y7K/qxICNgBv4wGRO8vnJT+qh3tVXylfTXXc0j9bYfDclcxAzwXs3DGFuSjHfVGA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQz-00000008Xuw-16HI;
	Fri, 24 May 2024 19:10:25 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 70/74] gentree: print spatch stdout/stderr on errors
Date: Fri, 24 May 2024 19:08:22 +0200
Message-ID: <20240524190907.f5deeb33877f.I9b2f222b424bf47ec9778f8b5cfc1cf2e57cdca5@changeid>
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
 gentree.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gentree.py b/gentree.py
index a80b0a8def29..03bff1a815c6 100755
--- a/gentree.py
+++ b/gentree.py
@@ -608,6 +608,7 @@ def apply_patches(args, desc, source_dir, patch_src, target_dir, logwrite=lambda
         sprocess.wait()
         if sprocess.returncode != 0:
             logwrite("Failed to process SmPL patch %s with %i" % (print_name, sprocess.returncode))
+            logwrite(output)
             return 2
         output = output.split('\n')
         if output[-1] == '':
-- 
2.45.1

