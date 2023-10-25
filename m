Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0743118B08
	for <backports@vger.kernel.org>; Wed, 25 Oct 2023 14:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jb7G7wi0"
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D87A3
	for <backports@vger.kernel.org>; Wed, 25 Oct 2023 07:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Ul6m2M+iljvvHIJfOWlf0If8iojuGJHECBEjiS+vrA0=;
	t=1698243584; x=1699453184; b=jb7G7wi0EAzf579ObP3RunZJk05IXg8QoOg4hkQidrWoGO4
	IpWehnMtLtlHhRrE2ZqmSEVJUV77TBbYkw99CTKa5sTmXIUBWha9polBJWwqXAZ5VtHGr6JHusu3U
	2XOHGK4UfisQrXMd8/G0wJhf1a7i+7KqT+RxiDA1oY4V0yVIBEbbee+/Ru2u9/yHh46gQgl7VJS10
	+8D4Ep7/0emv0s8M5Bb9oBRcZuVeEFPnuoer4zKMPlPu0k3MSEwhCBYOqJfBLgnyOnGjK+QScExd1
	MRr7U5Wz3uLrKB5UR/KqChqL+WlU+Aa73H3idjgWE7OFphrIhl4ZaeRHV1OpW8Zg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qvejW-00000002a23-1qgN;
	Wed, 25 Oct 2023 16:19:42 +0200
Message-ID: <d89dfa543eb14ec82394386fd9b21c16c2da3814.camel@sipsolutions.net>
Subject: Re: rtw88, rtw89 -- options for bringing a couple rtw standalone
 GitHub repos into backports.git
From: Johannes Berg <johannes@sipsolutions.net>
To: Brian Witte <brianwitte@mailfence.com>, Larry Finger
	 <Larry.Finger@lwfinger.net>, hauke@hauke-m.de, backports@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>
Date: Wed, 25 Oct 2023 16:19:41 +0200
In-Reply-To: <18fb6b9a0e1d2a7cc08eaa34979067e7094bb2a1.camel@sipsolutions.net>
References: <831d1de6-5d02-43b9-b907-70d9f1a03cab@mailfence.com>
	 <435c43bae693e72004c39ff90a901bc911ab1e6d.camel@sipsolutions.net>
	 <029db1c1-2ac8-430e-915b-beb7c3741de2@lwfinger.net>
	 <0b543e2e6aa3f2473d7ed8e406b74b69e1804143.camel@sipsolutions.net>
	 <1a600228-6975-4798-b2df-89d99007337e@mailfence.com>
	 <18fb6b9a0e1d2a7cc08eaa34979067e7094bb2a1.camel@sipsolutions.net>
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

>=20
> > After that, our Makefile and/or scripts it coordinates will have to=20
> > detect the user version, then cd into that package, and install it=20
> > properly.=C2=A0
> >=20
>=20
> No, you should just give them the output of backports (gentree.py)
> directly, it does all this.
>=20

Well I phrased this badly - it doesn't of course "cd into that package"
etc, it's just a single package. However, it handles being compatible
with pretty much any kernel version.

johannes
