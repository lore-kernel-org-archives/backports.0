Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F94E84A30
	for <backports@vger.kernel.org>; Mon,  1 Jul 2024 09:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719824578; cv=none; b=ZT++EuDDt708ONHqfj2leyooqeDed7X9J9ShaH6CAwKt4PiL2BEF1LyvPlZ/MgxrfeyP3mZy9fV1nyww4xrizvcp7MNjgLOaA/mvx3LQDaY2mUM00QTMJach9tRvx2ch/gyAkNLBq4Cb9TFWrv6HYdhRJ3sog5Zij0lJBxHK/Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719824578; c=relaxed/simple;
	bh=TWNCq2yLOVXQ8s87DOyNU+ttuSv41sorqZ4Au2RTA2A=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BlHMvu1sMWyCEE/h4qzrZBy96T9PLmFrxJiExpxtfmyDclggkDcoWS2mTRbrDN/KsHZCUJCf/T8iRb7yKC0PaKrVRcfjxX+8A/rS8l8yYIO7+CpGYNc6dpvCYn9+yr4LEtnDpqPYg0dd0uSOAZM9SyTaAnatS96gimcbyg5QIjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=fxbBXV7h; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="fxbBXV7h"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=TWNCq2yLOVXQ8s87DOyNU+ttuSv41sorqZ4Au2RTA2A=;
	t=1719824545; x=1721034145; b=fxbBXV7hqs/jo4DHGDc/S0rq/33vss7nzUTjenUQJHGELnh
	Q0X/B5cmQuKgudUr1G4d9YrctYcGwBfQEdTjDRNyJIS3waeRG0XccOtj/5lmViRUSMGY9gHPg7vZf
	0AVP2jkyf6OS4IUk2otmZR5PUAWdeFqZB6E5/354RyTC+JEUo61XAYlOWeVz8gS1iZ4ZtFFxIyr+z
	HYpgQVQArweyIsS71I0XWn8tftS1d7C2B8HnP/fiO1OgB6DeAcEujx0Z8W8URY6ojOpqw+OESdpni
	U3Wye2TFrquicalteKu9zm1j6+E1D8PuOcZsurDA/093ybHJtaDj9yWKHaXUqi6Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sOCvM-00000001sIF-0ICf;
	Mon, 01 Jul 2024 11:02:12 +0200
Message-ID: <a0be51788700e05703b0279ade68eab45036a3f0.camel@sipsolutions.net>
Subject: Re: [PATCH 54/75] patch: bcma: Fill of_node instead of fwnode on
 older kernel
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Date: Mon, 01 Jul 2024 11:02:10 +0200
In-Reply-To: <89463d54-f66d-4bfc-9308-e1765e1dc91a@hauke-m.de>
References: <20240627234808.1253337-1-hauke@hauke-m.de>
	 <20240627234808.1253337-55-hauke@hauke-m.de>
	 <2b1f167aa1a4f75f464cf5083d06dcbc719b0af1.camel@sipsolutions.net>
	 <89463d54-f66d-4bfc-9308-e1765e1dc91a@hauke-m.de>
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

On Sun, 2024-06-30 at 22:57 +0200, Hauke Mehrtens wrote:
>=20
> > seems this should've been fairlyh simple with spatch?
>=20
> I have only seen this problem once and will go with the normal patch.

Sure.

> Maybe we can remove bcma and ssb completely from backports and just use=
=20
> the in kernel version in the future. There is not much activity on bcma=
=20
> and ssb any more and the interface to the wifi drivers is pretty stable.

Yeah that's a good point, pretty much nothing going on there, I found
pretty much only this:

commit 985324a16efb ("bcma: add HP Stream Notebook")
commit 80bc5ae9733c ("bcma: support SPROM rev 11")

johannes
