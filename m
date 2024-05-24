Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D6686AD6
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570626; cv=none; b=TZcO/ao6ZKtW1V2XL8Uv1qRK1+J1AAhGvRDSpMxbgXvofPl2qqP8OPeJRZHoopqVFspdCuIlTVfnbSWREFg3LOBwif9qoLysW3yv8cMyb8XCI48gjPab0EpTrjueCSOfO/fqaY65FEX1vwlEL0nRa3J+yMCINlXC7Bvp4GH3KrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570626; c=relaxed/simple;
	bh=O1CppV8ZKuYkaBuBE7elQCibNoKJfowNPR0I74mHc/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AIfEutwhpfREx/gZ8XmHGQ5QBxw61X/ieV3dfhkfHWxU43RE6WUyblW0h1oBIGQ3DhFCCx8oorGxwkmwXqq0kDLanC3HUV3tup7VZ/Sg7WsiFmPOEQglLlu/9yRayFITcEOOKVN+q2g4O282KX6zhf8EUNAyb19l3FVnXKHz6+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=YHRECgLV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="YHRECgLV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=W9nm41t5muWeuzQIifuM8sjx5QDLFEelwiauFMpmioA=;
	t=1716570625; x=1717780225; b=YHRECgLVhnELsfUX3yEvP0dWkUhS3Uz62tybr6OsaNvBkOJ
	tWOnWmSSpSxrChjRaqqvpdruhjd9Jx9cnqKYv0IHw9VQhThbKm73WjLLiaiq+0KslN9r2yIpUeV1W
	Wa4Akx3I9vO80vm6mFegUYaawPFmVOL70RhdU3Jp1/CUdlrQEyIdCz6VrvmTwUHPJvFA+YnZ/MCvO
	GTxbljtBJBvMhK8ItZO8bymoWz3xRZnnim+LKhoJjbXaxhn9OPYYOoVfVwhR1cpM45fK9F+mvJkpm
	iX6Y9t2AwwXcYSHVS0XSVvYBxmhcpIilrJXq8RTKM6fkm+YRpyU9m71eSo6qejJw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQw-00000008Xuw-2cuj;
	Fri, 24 May 2024 19:10:23 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 68/74] patches: adjust verify.patch to v6.5-rc7
Date: Fri, 24 May 2024 19:08:20 +0200
Message-ID: <20240524190907.1624959d1b73.I7b6f91abd199b394924149eacbad7120598ef7d6@changeid>
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

From: Gregory Greenman <gregory.greenman@intel.com>

Patch e5221fa6a355 ("KEYS: asymmetric: Move sm2 code into x509_public_key")
made some changes to inlude order in x509_public_key.c.
Adjust verify.patch.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 patches/verify.patch | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/patches/verify.patch b/patches/verify.patch
index 370fd5f72530..85318b3f26ea 100644
--- a/patches/verify.patch
+++ b/patches/verify.patch
@@ -11,14 +11,17 @@
  		if (ret == -ENOMEM)
 --- a/compat/verification/x509_public_key.c
 +++ b/compat/verification/x509_public_key.c
-@@ -9,11 +9,8 @@
+@@ -8,14 +8,11 @@
+ #define pr_fmt(fmt) "X.509: "fmt
+ #include <crypto/hash.h>
+ #include <crypto/sm2.h>
+-#include <keys/asymmetric-parser.h>
+-#include <keys/asymmetric-subtype.h>
+ #include <keys/system_keyring.h>
  #include <linux/module.h>
  #include <linux/kernel.h>
  #include <linux/slab.h>
--#include <keys/asymmetric-subtype.h>
--#include <keys/asymmetric-parser.h>
- #include <keys/system_keyring.h>
- #include <crypto/hash.h>
+ #include <linux/string.h>
 -#include "asymmetric_keys.h"
  #include "x509_parser.h"
  
-- 
2.45.1

