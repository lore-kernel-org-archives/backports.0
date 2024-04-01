Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B105454FA3
	for <backports@vger.kernel.org>; Mon,  1 Apr 2024 21:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712008575; cv=none; b=tJWlQ8cxJTKL8iIY7mbVe5AeOsObRvVOhAgbiGDQWW1Rx5uZIl+fyOloM7ryK7BUUb9kRtn7U1VzI61AlOO99xD/k/MSd0B7YGdEyNkMGMADJrhUYz8HtwGxT7bDT8nsTBjzE6VVjwqoufLfLM52pIH1DlXbCwwUdSBzO7DM/8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712008575; c=relaxed/simple;
	bh=Yis5nfSDV/54SfiwbP3vrfyIX3dwfmKOjdZoWoBFniA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjRqpSNOQsx4ZwpL9rF0S5wVuPA4kkT6PFXvh8L2RjKabd4PHgWosOjVwV0TlxXU+6VHq43XAEIkDFZDAPyROq5DuuTP8dWaAKg8ux/6lL4esfxSR7VwyxHIhcHP3RZ/fyowN3y2r3fbQPyGpLcjjsv+eVkl3ykEpOzaHva0mKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=AKHNmGpf; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="AKHNmGpf"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4V7lFc1yqXz9slj;
	Mon,  1 Apr 2024 23:56:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1712008564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XUr9p/F49VOWqeQsiItOWInuw71A+QhuFTo766T1mpI=;
	b=AKHNmGpf6kcZxu5oWbP+WAMtSci+rDQHhasUj5jDIY4Gxl5DhB9vet5XwKxh9YwfXHcXfP
	5wDhAml63Vk/3zRwMfxiBL6V5TPzUM37mQq3vgMYHJWD0RXOybTSNUXK/Jrc6smLJkrubh
	8s53ZOx/SaLa148f3p9VjdBc8R05Isj11/eRdS5pFkqHl9is6M0hKtYvexr2cbWGHRk/MG
	WTrHM6s47cDh/0NTNIfmj4kDtoPJn61KPlIOuiZr67AM8xxliUqAqov9EFw9RaZgKiMTX+
	Dbegz76Vd473JHBX35AB/eSiOrXCWz8xYze+k+NEqNg6iRZOkB1KbClk+rRjBQ==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/4] backports-update-manager: Install only kernel 4.0 and higher
Date: Mon,  1 Apr 2024 23:55:33 +0200
Message-ID: <20240401215535.2432969-2-hauke@hauke-m.de>
In-Reply-To: <20240401215535.2432969-1-hauke@hauke-m.de>
References: <20240401215535.2432969-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernel 3.x are not supported any more, install only more recent kernel
versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 devel/backports-update-manager | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/devel/backports-update-manager b/devel/backports-update-manager
index 815a0421..c2900b64 100755
--- a/devel/backports-update-manager
+++ b/devel/backports-update-manager
@@ -79,7 +79,7 @@ class backport_kernel_updater:
         builds = re.findall(b'href="([-v.0-9a-z]*)/"', html)
         builds = [b.decode('ascii') for b in builds]
         # remove some special kernels
-        builds = [b for b in builds if re.match('v[3-9]', b)]
+        builds = [b for b in builds if re.match('v[4-9]', b)]
         builds = [b for b in builds if not '-rc' in b and not '-unstable' in b and not '-ckt' in b]
         last = {}
         for b in builds:
-- 
2.44.0

