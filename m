Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DAF1103
	for <backports@vger.kernel.org>; Fri, 28 Jun 2024 10:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719570867; cv=none; b=QFtSBi5mZKGfamd/+orlTW7iSm21rlWsV/VV55nHkdc760FU90hp/g0qOHh9YpJXdANnkDYUZk0T14TKLZJ7eMj7XLwFHve0HghaMpLnTWSSQFWQUO3NcO4PTgPhU8HqX1tRzYZjrDF6daxECQ5Yjln8+jNb84YRXBp+veUVZBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719570867; c=relaxed/simple;
	bh=DWRRb8t3Z0tmRfLBPyFBLvE3FtV6m/Z4NZWcPPo7h48=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k4NxoXe0zR3A4K2ROZO+wRm5nmlXtwxHh9rlvP5CxrzSXNBrkk57eWTMrG6YxtJvxZIZ+b/2wzTC6Tf4LvpLZrIfSIYky4VVRAt1orMOj5pIvvPBCpStPu6OdnWGfqcmZE07xB1Ae3Iq/IVkcdprBMDQu6qAM8K4vakHUZ8mUWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=FmwIfX58; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="FmwIfX58"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DWRRb8t3Z0tmRfLBPyFBLvE3FtV6m/Z4NZWcPPo7h48=;
	t=1719570865; x=1720780465; b=FmwIfX58qB4kADGlFQyaMCXdyKAHnoAynKmahngGO5vTKuH
	jEDRDCXVh/r/6Z4blYyhrMZw+6+bMqLCybvkExHK/p9tvMqTvVCbFAyyvqvXpLabcCnGS2ph37U5f
	kH7RVCIjSOw8q1Ze7XKXRJPGegz8L4E5t6LewIr3TgoY3Uy55juyuLb7+BIxCIbivRB9LuDaFDery
	BKrxpOx5BLX5lScuPG2aN/InBgPRy8HZC7n5BHZlBSCKUHlQqVLVeLsCgQR1YNW7Kif6e/WKWVlxk
	E5ICKVEfY4ArSWdg5NL7XqFTDbu7ePJ8hzI/gnXT890Q7iY11RzgD3TK+nutfc8g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sN8vt-00000009nOB-38Q7;
	Fri, 28 Jun 2024 12:34:22 +0200
Message-ID: <dfba94b755d73f6342a70f8a1a25e56f2ebb0316.camel@sipsolutions.net>
Subject: Re: [PATCH 10/75] backports: bpgit: handle copied files properly in
 status()
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Cc: Luciano Coelho <luciano.coelho@intel.com>
Date: Fri, 28 Jun 2024 12:34:20 +0200
In-Reply-To: <20240627234808.1253337-11-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
	 <20240627234808.1253337-11-hauke@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-06-28 at 01:46 +0200, Hauke Mehrtens wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>=20
> 'C' as the setatus also has two files, so need to continue

correcting myself, I guess - 'status'
>=20
> Reviewed-on: https://git-ger-8.devtools.intel.com/gerrit/135974

Also here.

johannes
