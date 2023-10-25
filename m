Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC4B28E20
	for <backports@vger.kernel.org>; Wed, 25 Oct 2023 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="scwdgDJQ"
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA25132
	for <backports@vger.kernel.org>; Wed, 25 Oct 2023 07:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=mx/IihhtukdMKNyJ3K4p/btbimj/jN2XyLFu3knW9zg=;
	t=1698243541; x=1699453141; b=scwdgDJQcX+QF3EhsXuYrP0ZcvcinShY3nOiYYfsgULMPG9
	c9b8AGzg8v+MhwlHwnRgJ+GqOLeZiNdJPRWG8Nx6T1XIdZ1K+3Sfl+C7t7pM8sIgT5BxzsqOy723v
	Qy8D5jq2F669rY68viCSHhRvcTjfSo2fo+e2mmgBrkCl0EAoi0nMCx/CqoDgBzksTyPwmaJPrL5Yv
	8HsaO/5TNBfJGN0nXQTJ2JUHKEZfhPtPpwe4tHl/YnupZ+0AlOGGQxlMQtVAvmYdCRHTBGFjnvL8u
	ExQUm00o4eE3tqRp/YGuI+tFL0wV8RPutzsyWmrvDHTwTsKO1t4QIUkhRiIH7zVg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qvein-00000002a0h-33Ka;
	Wed, 25 Oct 2023 16:18:57 +0200
Message-ID: <18fb6b9a0e1d2a7cc08eaa34979067e7094bb2a1.camel@sipsolutions.net>
Subject: Re: rtw88, rtw89 -- options for bringing a couple rtw standalone
 GitHub repos into backports.git
From: Johannes Berg <johannes@sipsolutions.net>
To: Brian Witte <brianwitte@mailfence.com>, Larry Finger
	 <Larry.Finger@lwfinger.net>, hauke@hauke-m.de, backports@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>
Date: Wed, 25 Oct 2023 16:18:56 +0200
In-Reply-To: <1a600228-6975-4798-b2df-89d99007337e@mailfence.com>
References: <831d1de6-5d02-43b9-b907-70d9f1a03cab@mailfence.com>
	 <435c43bae693e72004c39ff90a901bc911ab1e6d.camel@sipsolutions.net>
	 <029db1c1-2ac8-430e-915b-beb7c3741de2@lwfinger.net>
	 <0b543e2e6aa3f2473d7ed8e406b74b69e1804143.camel@sipsolutions.net>
	 <1a600228-6975-4798-b2df-89d99007337e@mailfence.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi Brian,

> I spoke to Larry off list and considering the cfg80211 and mac80211=20
> situation with older kernels further, he wants me to try and get a=20
> simple backports setup validated so that people can still
> `make` and `make install`.=C2=A0
>=20

Sure. That should pretty much, after all, we do it many times every day
with iwlwifi with our internal tree :) But yeah, getting it generated
might take a bit of work.

> He is focused on a few other important tasks=20
> and will probably get back with us here later, I just wanted to start=20
> running downhill with this ASAP so I slid in here.

:)

> I am going to first try a variation of the approach you suggested where=
=20
> I generate backports for Linux versions in the repo in ascending order=
=20
> then have our Makefile detect user's version and install accordingly.

Wait, no, what? You don't need to detect the user's version or anything.

If you generate a single backports from say v6.6-rc6 today, users should
be able to run it on any kernel as far back as 4.something.

The only time you need _multiple_ backports is if you don't want to
stick to v6.6-rc6 (per example), but want to have v6.6-rc7 this week and
v6.6 release next week.

> Again, my understanding is often the bottleneck so I want to first say=
=20
> what I intend to do and then ask a question:
>=20
> 1. I want to use wireless-next as the upstream kernel source for=20
> building the backports, I would need to build all backports via the=20
> "package release" workflow [1]

Not sure I'd say that - the workflow page [1] is written with
instructions for your *users*, not for *you* as the one providing the
packages.

>  in order to provide users with a package=20
> that they can use without needing the upstream source on their machine,=
=20
> effectively giving them "a patch file" for compatibility for driver=20
> specific modifications and the up-to-date 80211 stack. I would then only=
=20
> need to decide which git tags for older kernels to use for the versions=
=20
> we want to support, create the packages, then include those in the=20
> repository.

Yes.

> [1] https://backports.wiki.kernel.org/index.php/Documentation/packaging

(just to keep the link)

> 2. I am trying to figure this out currently, but am not entirely sure=20
> how granular the built package versions have to be in order to work with=
=20
> a users kernel version. How do I decide the coverage of an individual=20
> package per major-minor version or other variations? You mentioned RCs=
=20
> earlier. For this first PoC, I want to make sure users can get the=20
> driver working for any version they are running going back to 5.4.

No no, misunderstanding here I think. You don't need anything granular
at all, *all* your users should be able to use a *single* current
backports-based package.

The granularity question only comes in when you say have a user who
reports that something doesn't work. Now what, how do you get them to
e.g. bisect? Right now you have a git tree they can normally bisect in.

Now, if you
 - release backports tarballs for them to use, or
 - commit the output of backports into a git tree for them to use

*then* you get into the granularity question, which ends up being a
trade-off between what's effectively bisectability (you don't really
need to care about the history, after all, it's preserved upstream), and
effort on your end to generate (and test) them all.

> After that, our Makefile and/or scripts it coordinates will have to=20
> detect the user version, then cd into that package, and install it=20
> properly.=C2=A0
>=20

No, you should just give them the output of backports (gentree.py)
directly, it does all this.

> I am suspending any upstream commit history shenanigans for a=20
> later point as making sure the driver is performant and in-line with the=
=20
> up-to-date wireless stack.

OK, so then you just need to release a single tarball effectively.
Whether as a git branch or a literal tarball is pretty much irrelevant.

> Being able to use those features and have a=20
> consistent API across the components is much more of a priority, at the=
=20
> moment.
>=20
> Thank you for you help and patience with all of this. You have helped=20
> make this process an enjoyable thing to dive into and I am excited to=20
> start hacking on backports.
>=20

:)

johannes
