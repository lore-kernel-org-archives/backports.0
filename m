Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C45C219495
	for <backports@vger.kernel.org>; Fri, 11 Oct 2024 14:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728656928; cv=none; b=HmjL/xxL45Mb07COa1Er8sKZ4xd/GfPBrXXkfA7qrc2p377G4ztaMeIdG9FfKh9s8bIIabBQPsMXkpnSxFo5vEBaHTYcj0peNYgRbMWVq6qZEJ5MfmxdO/EQL7If0avfkYSYn5dJgd4dYw/XgIm0slu1b/NMvHp8QAXDLadFQBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728656928; c=relaxed/simple;
	bh=jhk5QbosXS5Hmc3fNttKysGMhJ6GGnmTENqpa8ExkqE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bk9mPFo0PQn0T4N6YwvnHkktd/HWmbIImObdeaM00FdEN+C6W03ATAF5UIpHsIOX1hp2FPIbXdmgUl7NN+ssHnojEC7X9QM5CKOiccuZL9uQSXKFyMXLm8qbzYSf08sDIs06FFJwxGEj/WuEfRrDeVBMVorSu5ZJ10tojeGgXo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=SHvioBjj; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="SHvioBjj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=jhk5QbosXS5Hmc3fNttKysGMhJ6GGnmTENqpa8ExkqE=;
	t=1728656926; x=1729866526; b=SHvioBjjsJJ5wvS8vbq34vvfnigVzKm0E6gbq8wXCGlS02u
	PcaWPlmGGASTPcru+vhBObeD0vzl+4BbwBmmj1OV/JKcGXKbPVgz3bR1Cp5u05NiBwOCDS9VUYw4F
	711cxahrVkqgfaCw0phmWSEgQBdr/QDIeWVDNanRejOF+h7ZRF0584PWh1cLlscnNaIeE8U79Eukm
	Jl7cN3OhWsAhnBfzqszWdnl3ekeLCWcPhaACzACtElc7wyOMLpKMsJXtHT9sg+urr2b3mez3QUtXJ
	xTSlASmPnlF4E506TofjQaeoMFGBNx4xfnuCxCLnu1oLFZEOe6FGQ+iI6pkEl7CQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1szGdH-00000007FPQ-3q5b;
	Fri, 11 Oct 2024 16:28:44 +0200
Message-ID: <0193a79d1c2947187a77c77ece250c1a2ce9475b.camel@sipsolutions.net>
Subject: Re: Sunsetting backports.wiki.kernel.org
From: Johannes Berg <johannes@sipsolutions.net>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: backports@vger.kernel.org
Date: Fri, 11 Oct 2024 16:28:43 +0200
In-Reply-To: <20241011-radiant-precious-gaur-6e2a61@lemur>
References: <20241008-amethyst-kestrel-of-realization-bb7b26@lemur>
	 <fc1c1d078cc5026a829d9c9daa59f6732add8520.camel@sipsolutions.net>
	 <20241011-radiant-precious-gaur-6e2a61@lemur>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-10-11 at 10:15 -0400, Konstantin Ryabitsev wrote:
> On Fri, Oct 11, 2024 at 02:01:41PM GMT, Johannes Berg wrote:
> > > Please let me know how you would like to proceed. If I don't hear bac=
k from
> > > anyone in the next few days, I will configure the backports.docs.kern=
el.org
> > > with the current converted contents and redirect backports.wiki.kerne=
l.org
> > > there.
> >=20
> > Maybe for now it'd make sense to move the repo into the backports/ grou=
p
> > on kernel.org? Or are you trying keep everything together in
> > docs/docsko/?
>=20
> Yes, it has to stay under docs/docsko for the triggers to work properly.

OK, right.

> > It probably doesn't matter anyway, I'm just not sure how permissions
> > would work if it's in docs/docsko/, I guess you can still give the
> > backport group access? Who actually does have access to the repo now?
>=20
> I've granted access to that repository to the @backports group, so you sh=
ould
> now be able to push changes there.

Thanks.

> > Honestly, I have very little opinion on this - even the few changes tha=
t
> > backports is still seeing we're not taking much care of the wiki these
> > days. Maybe Hauke has any further thoughts.
>=20
> I'm perfectly happy to keep the source where it is. The only downside com=
pared
> to hosting it on readthedocs.io is that propagating changes takes much lo=
nger
> (10-15 minutes).

Let's just leave it then. Not that it was hard to do this all with
github for the wireless one, but I feel at this point, unless some
community re-forms here, it's mostly left as a historical artifact.

johannes
