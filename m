Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122E5168DC
	for <backports@vger.kernel.org>; Wed, 10 Apr 2024 22:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712787632; cv=none; b=YiErpc8dK8kk+r0jt91V8bqagOfWkkatHgwPruMDLsuSR/cfsL9PMxsGbcxiL1FMb6ZRW7687sPCFhPxaUzy2Iuq4sfw58flsXMbseDHZTWfIhxYH0mrX+wNtTneblIOAK/e+z0P85lwLPn74fg44GpM9Rlg87ff1NcRca08baA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712787632; c=relaxed/simple;
	bh=iJFvRyc5yatstp+30SWNMWAhLw/siPfQkIcdysNvwXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ett2UYtadwaNRC9ewlXGgRjt2zdTt5gJBCZcjQqpP/9Lh2NNbktGiLxkpOF8OouTODHCvLKrOYsMzZWIiQlEQrwoRor+9b9q1GUYBQg2yCJZd81JdxWdFB2sBYIvkbGCdrJBwZ4ApQkEpeNdWeVq9rF+Bh3s5VEMIC4789uekJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=nnytCnHe; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="nnytCnHe"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4VFHMS1C6Sz9t3X;
	Thu, 11 Apr 2024 00:20:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1712787620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=98FIDm6kcgvSRKhUmQXCvQtcnd4RXKNT4NyUN726Qm4=;
	b=nnytCnHe+0fNRBJNTb4cbgylh4ZV0l0fsddNphBd5fbmsBw2fqAuPq7qDBQw8fM5rRyw+/
	Jn73BQE4vddWEptkG3B6x6FfvBaZe/9rZM+3jhEXtSrByquRCdnO2NzvHFj8/PlkBaxhkO
	dAGAl7cMeZGLxRZrvjYg6CbjPrs8Y+Ch+qqDfNm1noTXpnp3N1zJgFHUHyy4wonqAwHiC+
	7nOWLTzbg+i3phyLyx9kiiDCTZJ4dz42vlZMBYOJJnrrK8cqhQl9SQVFoLzWW177NFJF+j
	e7PEw2cWVBQPSzterrRhDfD21vy8EmJHNa3sqdR+ksTtKl4cgBjEfLnxiLHXeQ==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/6] backports: Remove Old backports code
Date: Thu, 11 Apr 2024 00:19:59 +0200
Message-ID: <20240410222010.1171249-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4VFHMS1C6Sz9t3X

Remove some old backports code which is not needed any more.

Hauke Mehrtens (6):
  backports: Remove no-pointer-sign option
  backports: Remove BPAUTO_REFCOUNT
  backports: Remove verification backport
  backports: Remove compat/memneq.c
  backports: Remove mpls.h
  backports: Remove driver headers

 backport/Makefile.kernel                      |    3 -
 .../backport-include/keys/asymmetric-type.h   |   35 -
 .../backport-include/keys/system_keyring.h    |   10 -
 backport/backport-include/linux/key.h         |   66 -
 .../backport-include/linux/verification.h     |   29 -
 backport/compat/Kconfig                       |   33 -
 backport/compat/Makefile                      |   28 -
 backport/compat/verification/asn1parse.c      |  393 ---
 backport/compat/verification/bignum.c         | 2458 -----------------
 backport/compat/verification/key.c            |  172 --
 backport/compat/verification/mbedtls/asn1.h   |  342 ---
 backport/compat/verification/mbedtls/bignum.h |  760 -----
 backport/compat/verification/mbedtls/bn_mul.h |  887 ------
 backport/compat/verification/mbedtls/config.h |   15 -
 backport/compat/verification/mbedtls/md.h     |  354 ---
 .../compat/verification/mbedtls/md_internal.h |  116 -
 backport/compat/verification/mbedtls/oid.h    |  570 ----
 backport/compat/verification/mbedtls/pk.h     |  618 -----
 .../compat/verification/mbedtls/platform.h    |   12 -
 backport/compat/verification/mbedtls/rsa.h    |  672 -----
 backport/compat/verification/mbedtls/sha1.h   |  135 -
 backport/compat/verification/mbedtls/sha256.h |  140 -
 backport/compat/verification/md.c             |  471 ----
 backport/compat/verification/md_wrap.c        |  577 ----
 backport/compat/verification/oid.c            |  709 -----
 backport/compat/verification/pkcs7.asn1.c     |  355 ---
 backport/compat/verification/pkcs7.asn1.h     |   27 -
 backport/compat/verification/public_key.c     |  131 -
 backport/compat/verification/rsa.c            | 1872 -------------
 backport/compat/verification/rsapubkey.asn1.c |   38 -
 backport/compat/verification/rsapubkey.asn1.h |   15 -
 backport/compat/verification/sha256.c         |  458 ---
 backport/compat/verification/verify.c         |   65 -
 backport/compat/verification/x509.asn1.c      |  185 --
 backport/compat/verification/x509.asn1.h      |   23 -
 backport/compat/verification/x509_akid.asn1.c |  144 -
 backport/compat/verification/x509_akid.asn1.h |   15 -
 copy-list                                     |   27 -
 copy-list.hwsim                               |   27 -
 patches/verify.patch                          |  101 -
 40 files changed, 13088 deletions(-)
 delete mode 100644 backport/backport-include/keys/asymmetric-type.h
 delete mode 100644 backport/backport-include/keys/system_keyring.h
 delete mode 100644 backport/backport-include/linux/key.h
 delete mode 100644 backport/backport-include/linux/verification.h
 delete mode 100644 backport/compat/verification/asn1parse.c
 delete mode 100644 backport/compat/verification/bignum.c
 delete mode 100644 backport/compat/verification/key.c
 delete mode 100644 backport/compat/verification/mbedtls/asn1.h
 delete mode 100644 backport/compat/verification/mbedtls/bignum.h
 delete mode 100644 backport/compat/verification/mbedtls/bn_mul.h
 delete mode 100644 backport/compat/verification/mbedtls/config.h
 delete mode 100644 backport/compat/verification/mbedtls/md.h
 delete mode 100644 backport/compat/verification/mbedtls/md_internal.h
 delete mode 100644 backport/compat/verification/mbedtls/oid.h
 delete mode 100644 backport/compat/verification/mbedtls/pk.h
 delete mode 100644 backport/compat/verification/mbedtls/platform.h
 delete mode 100644 backport/compat/verification/mbedtls/rsa.h
 delete mode 100644 backport/compat/verification/mbedtls/sha1.h
 delete mode 100644 backport/compat/verification/mbedtls/sha256.h
 delete mode 100644 backport/compat/verification/md.c
 delete mode 100644 backport/compat/verification/md_wrap.c
 delete mode 100644 backport/compat/verification/oid.c
 delete mode 100644 backport/compat/verification/pkcs7.asn1.c
 delete mode 100644 backport/compat/verification/pkcs7.asn1.h
 delete mode 100644 backport/compat/verification/public_key.c
 delete mode 100644 backport/compat/verification/rsa.c
 delete mode 100644 backport/compat/verification/rsapubkey.asn1.c
 delete mode 100644 backport/compat/verification/rsapubkey.asn1.h
 delete mode 100644 backport/compat/verification/sha256.c
 delete mode 100644 backport/compat/verification/verify.c
 delete mode 100644 backport/compat/verification/x509.asn1.c
 delete mode 100644 backport/compat/verification/x509.asn1.h
 delete mode 100644 backport/compat/verification/x509_akid.asn1.c
 delete mode 100644 backport/compat/verification/x509_akid.asn1.h
 delete mode 100644 patches/verify.patch

-- 
2.44.0

