Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3FD12EBD5
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570633; cv=none; b=krLWVyrhiw0dUaUKQdBWC+REwNWjqJdJmIspBEiCkSpiiF1KqtHfpytCEWTAZ7LhUtilQmvlMCGtsP9LGi8Ktyikf23OETyE/uUe5DSW+P7cTeRnnRpm/R+/1+ZIFoVRKFuv4IvvUVVFPf4exYi+4iPiEtaFf6J01bFnteVMH3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570633; c=relaxed/simple;
	bh=8kdmxQrwj/ZJvr0y536kyNAHWnLXtk7hnV8Sw6mJA5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCwhmbNTn4btsoRc2nyiSQpKMcj+nsHvaYyTkVCaJAVit1/SgX/TxDEmyDQ4qepfKHOdWiWNsyyXnKCU89bWTdhYS2fFaQ5DL+/C9ie44rHrRnwfeUWixZ84UnzdHf8Gzed2UDSlT9jKhrD+Qcp1Chi2uKejHOGwFwPbw1Rsjwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=vPCEyItJ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vPCEyItJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Nj8CyGqxRvLN9eXVsxNQJEJS2ycPoKmJNp3OFdC07Qg=;
	t=1716570632; x=1717780232; b=vPCEyItJkTP/3KJBOqDA3BvyuEHmsnNX8soA6Eex+cgwOra
	eD/0ncPq9JPxigt6RfaDkl74swp2eB/YWyx+FN8qDs9OzvTniKvFeqUW7qwva+YjVWV8s258EClRh
	Op30HHobI58FfCIw2HnlcCvJjK06su7mWVL7kcBGt4ofYguGxdVCTu5DeJKEg3SlJBD2itGuQ6OMm
	2025yXRUZChkk5b3mWyQ3nOcikHMaxXwJF1JrqsZvs72AWV3G9+uKxZo8oweU0mQEK2gRdJ9+jjAq
	HDQndvBxPTo4dh/y+KPvpZFCzDeaS7u4TO1fTBrvxr12CzyFzuTynEtY10CRbKIA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYR4-00000008Xuw-1ot4;
	Fri, 24 May 2024 19:10:30 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 74/74] copy-list: minimal updates
Date: Fri, 24 May 2024 19:08:26 +0200
Message-ID: <20240524190908.e47720d3b00e.I38c2d2390eb0ad24c675ec42c58051f86d279548@changeid>
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

These are needed, but it still won't really work,
since patches don't apply.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 copy-list | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/copy-list b/copy-list
index 027e9c883b48..ce879409df45 100644
--- a/copy-list
+++ b/copy-list
@@ -14,10 +14,6 @@ COPYING
 LICENSES/
 Documentation/process/license-rules.rst
 MAINTAINERS
-include/linux/unaligned/
-include/linux/hashtable.h
-include/linux/fixp-arith.h
-include/linux/crc32poly.h
 
 # This just defines some macros, simply take it
 include/linux/bitfield.h
@@ -26,7 +22,7 @@ include/linux/overflow.h
 include/linux/units.h
 
 # crypto_memneq
-lib/memneq.c -> compat/memneq.c
+lib/crypto/memneq.c -> compat/memneq.c
 
 # 802.11
 drivers/net/wireless/Kconfig
@@ -82,6 +78,7 @@ crypto/asymmetric_keys/pkcs7_verify.c -> compat/verification/pkcs7_verify.c
 crypto/asymmetric_keys/x509_cert_parser.c -> compat/verification/x509_cert_parser.c
 crypto/asymmetric_keys/x509_parser.h -> compat/verification/x509_parser.h
 crypto/asymmetric_keys/x509_public_key.c -> compat/verification/x509_public_key.c
+crypto/asymmetric_keys/x509_loader.c -> compat/verification/x509_loader.c
 
 net/Makefile
 net/Kconfig
-- 
2.45.1

