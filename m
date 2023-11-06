Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786F42DF7D
	for <backports@vger.kernel.org>; Mon,  6 Nov 2023 20:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="RcE7CUOG"
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DBD103
	for <backports@vger.kernel.org>; Mon,  6 Nov 2023 12:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=7ujFNVoNiXide019ftlBdkOF8s0gRQ9pOLSL5bQsCRU=;
	t=1699304337; x=1700513937; b=RcE7CUOGiIMsSeRZ+jcGuaM4+b7CNNq+iDd5iZNlK3aTI07
	rPKaKj1sfZ2hJ7VjAy1MEtkZMzyeKKSjME3vhiy9GXwTyu4z19IpVx9LwKqhCRVQQ6UZwRsyHHIWU
	mPprDMnXaFHacrwipVRhXasgYzTW0LsVjNyd//X/eFhjoOjPb6KB6zSJ2m6BGyldPe3TbaTZGC+FC
	uZh7JdF7Qcnutwixb6rVAY3dLSdGA0gii+lEavZm+Tt4bJPY/ZQcYpHzep3BAI+tGxW/oE5gw+6AT
	RfhQuS3CeWcSFE8XF0I1Vh2lJb4Gria8kX/PrIUWCa5r9+40SZbCi0NP+vpqLHsA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r06gL-0000000FtpF-1ii7;
	Mon, 06 Nov 2023 21:58:49 +0100
Message-ID: <d483eae0d92432e185dd5ddea575b4b58588de11.camel@sipsolutions.net>
Subject: Re: rtw88, rtw89 -- options for bringing a couple rtw standalone
 GitHub repos into backports.git
From: Johannes Berg <johannes@sipsolutions.net>
To: Brian Witte <brianwitte@mailfence.com>, backports@vger.kernel.org, 
	hauke@hauke-m.de, Larry Finger <Larry.Finger@lwfinger.net>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Date: Mon, 06 Nov 2023 21:58:48 +0100
In-Reply-To: <44560748.117980.1698769443983@ichabod.co-bxl>
References: <831d1de6-5d02-43b9-b907-70d9f1a03cab@mailfence.com>
	 <435c43bae693e72004c39ff90a901bc911ab1e6d.camel@sipsolutions.net>
	 <029db1c1-2ac8-430e-915b-beb7c3741de2@lwfinger.net>
	 <0b543e2e6aa3f2473d7ed8e406b74b69e1804143.camel@sipsolutions.net>
	 <1a600228-6975-4798-b2df-89d99007337e@mailfence.com>
	 <18fb6b9a0e1d2a7cc08eaa34979067e7094bb2a1.camel@sipsolutions.net>
	 <b67264b6-41f8-4415-ab8a-fbdbac21748e@mailfence.com>
	 <44560748.117980.1698769443983@ichabod.co-bxl>
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

Sorry for the delay - had a bit of a crazy week last week.

> I was able to get a new backports package built and running on my
> machine over the weekend.

Nice :)

> First, I did a `./gentree.py` on Hauke's v5.15.92 release

I didn't even know there was a backports release of the scripts itself
rather than just the output ... :)

> with it's
> corrresponding branch in stable with success and installed backports on
> my hardware running v5.10.0. The new driver code was loaded and worked
> as intended with a couple different usb dongles I have.

Great! So progress, I guess :)

> Second, as a test I built a package release for v5.16.20 because initial
> rtw89 commit appears here:
>=20
> =C2=A0=C2=A0$ pwd
> =C2=A0=C2=A0/home/bkz/linux-stable
>=20
> =C2=A0=C2=A0$ git symbolic-ref --short HEAD && git rev-parse --short HEAD
> =C2=A0=C2=A0master
> =C2=A0=C2=A0ffc253263a13
>=20
> =C2=A0=C2=A0$ git describe --contains e3ec7017f6a20d12ddd9fe23d345ebb7b8c=
104dd
> =C2=A0=C2=A0v5.16-rc1~159^2~121^2~39
>=20
> I was able to cut that release package that works for the rtw89 driver
> by adjust existing patch file diff hunks to apply properly and adding a
> new header that came in to net.

Right.

> What other testing do you recommend for a "new driver" besides testing
> "builds" as mentioned in docs [1] here in 'Adding new driver'?

Well if you have the devices, you could test them too, but ... if we
trust backports to more or less do the right thing, it should work :)

> It goes over supporting latest minor versions and says, "you should insta=
ll
> all supported kernel with the script in devel/get-compat-kernels and
> then run devel/ckmake to build backports against every kernel version."
>=20
> [1] https://backports.wiki.kernel.org/index.php/Documentation/backports/h=
acking
>=20
> I am working on test/automation for our new backports workflow so any
> insight you have would be helpful.

Ah, well, that's more to make sure backports itself (as in the
compatibility code it adds and the changes it makes) actually compiles
against all the different kernels.

You might want to check that, and ckmake and all is just a nicer way of
achieving that. But you might want to restrict yourself to kernels that
you see actually in (broad) use from your users?

> Honestly, we could probably use some key points from this thread to make
> some newbie friendly docs considering how confused I was at first, haha!
>=20
> I could probably draw a nice diagram based on your explanations.
>=20

I wouldn't mind (you) adding something to the wiki but I'm not even sure
I know how to use it :)

johannes
