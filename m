Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D6012E1E4
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716571079; cv=none; b=Fsk2XKSxyvKhPbbSHWvXZF5pCuELm/HTxCqFSezvnv+AN53u1NUqGabTBWApRGhv9O02u0TLcZwRVi3mjdE5eZC9rowYyfaIGrAVoMg7dm2XDJRQRWc8Ui8gQFIeJehB0O8OmnwsOfA9aWHnulETply4l4FrAnUonu9wXMHXJuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716571079; c=relaxed/simple;
	bh=ULgpn7+PWdTOz81Uxje2INS0yLUY+ENTdJE3H4bqYYM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ru/rwCiV0VMn8hua2p7zHislWZh28PgsbLwYtHiEcfVg+PbizD+VAZ+Iwp3ASnoC/zAZ314sX7L2KEZokIlTpWaFq2kbdLYmiFO3jW0uaVmV2YiSZoqb6fvL2WbgyQLRt2Q84rZnig7AwElAosuywEWxeXnP1uDTrzhRTRBKNpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=pFWAE60V; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="pFWAE60V"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ULgpn7+PWdTOz81Uxje2INS0yLUY+ENTdJE3H4bqYYM=;
	t=1716571077; x=1717780677; b=pFWAE60V7FwHfZtjjBdw976uYcpWsl32xW4nmjUw2UdW6tP
	udxHsDvWB3KlcnT3dKBaS1pnLYzZzmDT4ApaN+RUnW5T4ULuvcwEQ26dhe04rrHl7U3QFP76modWm
	84F5vai0lo2cnv5J9Me1jrVNSP2HhvDkWtfdDiNZxGevGnXqszHkMyFKrdxbQgtTXSSkY2avOaXvq
	rD4oQe5e9zfpBx/ephdJHosXFEgpACvM4P+Km+z3FV/B3Ex7xu9VJIOrCyFQ5HAJMhGZYZuyKgEpv
	svHvqUCk5A3ZvNIrzIebGqo+3zm/vgrDgR3ARi/uektdC1hnhH2egmzSRAF7iowg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYYE-00000008Yuf-43sg
	for backports@vger.kernel.org;
	Fri, 24 May 2024 19:17:55 +0200
Message-ID: <126e53f867d51de9d06752c027ca45399a39e35d.camel@sipsolutions.net>
Subject: Re: [PATCH 00/74] backport updates from Intel
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Date: Fri, 24 May 2024 19:17:54 +0200
In-Reply-To: <20240524170906.54680-76-johannes@sipsolutions.net>
References: <20240524170906.54680-76-johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-05-24 at 19:07 +0200, Johannes Berg wrote:
> So ... I talked to Brian today, and realized that we've been
> sort of maintaining backports to some extent, but not really.
>=20
> This is what we have in our tree that's not upstream, and
> rebased onto upstream (commit c96f36d5214).
>=20
> With the copy-list restricted to the iwlwifi driver and hwsim
> it even works,

Well, I should've said, with 6.9 kernel.

johannes
