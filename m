Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053F515351C
	for <backports@vger.kernel.org>; Fri, 28 Jun 2024 10:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719570824; cv=none; b=OXMq5EPSwc4cz96Hg84EFS7AKiu0xNXeTYBN8WiHCPVvQ3IvsYwsRB53YWGm4Ft2ipvPl5//r+80+pWl9zqwtUUP1wRaCWXSbXptc6rgd/VKMje4etbYB0RKqz665pq0zZW/ObxfiSvj2EUnGH+BnMtSD2f31aiTHC4zvNX3Npk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719570824; c=relaxed/simple;
	bh=VeJjkKVEtxPinIXVUlnunzMsnYbFJ/vPjJhV3JBp8io=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L7QL3hiE/idjuGY61pWg8DzSXFjzmrk9qxelViDpqIg49sB3tHqFsgu5iAUQYcdHJauyecX/b1+nAOYrcPo5Xjm+yEsXSFRdfEsZjQ2wgsdQVnT+2mw7RvjKQBTG+Zxxp3w4uErnfanK41yA3sVX3Bx9WW+PPEi83xZ+71AgMqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=CgihWfJt; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="CgihWfJt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=iyQakUaxAviNHBYR1hDw/3HXMV0VGCcBqmkUtUG5WNw=;
	t=1719570822; x=1720780422; b=CgihWfJt/NCtpUPMlvHBhOcKHqj+wEE9Rs5gWisQGEa0782
	3pS3FD7oYEoRfBiPAkv+nIGZlLq+5m2nYdyH/CjBba/HRoCLWJSFurmOr4xj16Crwt+mF4/joLidl
	MDLF84Cn9fgOvSjOjeuKaToPtiuBJMZDEeETOvrPE5+ZNbNH5k6awSovF17s6Bokxp+l0qFKbLvkx
	tvSNn2DmbjkxSCT7xbo5A58g6lrZ1rJGWTjB3wPnbWQEAJKx8g5zEFsy5xaejRxwOA1G87ho6STN1
	FokTLypK3ZhspUN7BuXmIehadUr2qwX27VT2so8c7xTLo+M6l3IoMN+r24S2WPnQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sN8vC-00000009nFp-0b90;
	Fri, 28 Jun 2024 12:33:38 +0200
Message-ID: <978b9c7378a52d4ca90586295ddd75887475aa3c.camel@sipsolutions.net>
Subject: Re: [PATCH 09/75] backport: implement NLA_POLICY_RANGE for
 NLA_BINARY
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Cc: Luca Coelho <luciano.coelho@intel.com>
Date: Fri, 28 Jun 2024 12:33:37 +0200
In-Reply-To: <20240627234808.1253337-10-hauke@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
	 <20240627234808.1253337-10-hauke@hauke-m.de>
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
> From: Luca Coelho <luciano.coelho@intel.com>
>=20
> The range checks for NLA_BINARY are supported since v5.10.  Unwrap the
> macros and introduce a new function to test type.
>=20
> type=3Dmaint
> ticket=3Djira:WIFI-85592
...
> Reviewed-on: https://git-ger-8.devtools.intel.com/gerrit/135576

Sorry, looks like I forgot to remove our internal stuff here. Maybe
remove it.

(that URL doesn't even exist internally any more!)

johannes

