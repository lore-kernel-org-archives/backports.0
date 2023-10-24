Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A9B20B0B
	for <backports@vger.kernel.org>; Tue, 24 Oct 2023 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="MAzt42uW"
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA631BCC
	for <backports@vger.kernel.org>; Tue, 24 Oct 2023 02:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zRID4e4n7jyEcPgB7fNJx2eKAQSJNLR9Ib8ZfXFDQ+I=;
	t=1698139729; x=1699349329; b=MAzt42uWlIKCFHQYS2yxZZYXhH3oMtsA9E4nTa/1CPsNIas
	hAcSpWOrRCuZuQ1UkVIMoVopWD2QJ/7iupeCtv+xUYTBKL4hpGhmS82rbar1/j4VDuu+o+a2ag0Sk
	OGrpg7UrVo9kC+/dM587jdJWp83mRdHxgcVHlZrf9k/WnnUkr1jvSRt2Vc0ZmAY6rs5687CFs6CP0
	9M4rrAywUsAgo3NtlcjTcmn2VZCVaq8GQAOYC9f3JV5JHgjgzr/wx8ReX98PrEof0Ip5bb9Uke3It
	sSrv3Ly8zmcbZ+srHwSVoXH9ZwpGdQZCOKQIpOK/iyWUEAJUVlXWQircIx/ENdtQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qvDiP-00000001L3o-3Aq2;
	Tue, 24 Oct 2023 11:28:46 +0200
Message-ID: <0b543e2e6aa3f2473d7ed8e406b74b69e1804143.camel@sipsolutions.net>
Subject: Re: rtw88, rtw89 -- options for bringing a couple rtw standalone
 GitHub repos into backports.git
From: Johannes Berg <johannes@sipsolutions.net>
To: Larry Finger <Larry.Finger@lwfinger.net>, Brian Witte
	 <brianwitte@mailfence.com>, hauke@hauke-m.de, backports@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>
Date: Tue, 24 Oct 2023 11:28:44 +0200
In-Reply-To: <029db1c1-2ac8-430e-915b-beb7c3741de2@lwfinger.net>
References: <831d1de6-5d02-43b9-b907-70d9f1a03cab@mailfence.com>
	 <435c43bae693e72004c39ff90a901bc911ab1e6d.camel@sipsolutions.net>
	 <029db1c1-2ac8-430e-915b-beb7c3741de2@lwfinger.net>
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

Hi Larry,

Sorry for the delay.

> I created the rtw89 GitHub repo, and rtw88 (wifi 5) repo before that to b=
ackport=20
> the wireless-next version of the drivers into something that will build a=
nd run=20
> on kernels 5.4 or newer. With a 'git clone' and 'make', a novice user can=
 get=20
> working wifi.

Right. That's pretty much the same as Brian was saying :)

> Keep in mind that most of our users are not very sophisticated. They freq=
uently=20
> do not install the kernel headers even though the README tells them expli=
citly=20
> what the error means, and what they need to do for several of the popular=
=20
> distros. In addition, they struggle with the concept that out-of-kernel d=
rivers=20
> must be built for the running kernel. Most can handle 'git pull', 'make',=
 and=20
> sudo make (sign) install', but not anything more complicated.

:)

> As Brian said, I have done the maintenance by copying the patches from=
=20
> wireless-next into the GitHub repo, and handling the API changes in a man=
ual=20
> fashion with '#ifdef LINUX_VERSION_CODE  ...' blocks. This works for me, =
but=20
> unlike me, Brian is a programmer, and he wants to create a script wheneve=
r he=20
> sees anything repetitive.

Which is basically what backports already did.

> As it is unlikely that I will be doing this much longer,=C2=A0

And you've been doing it for basically forever, and probably get thanked
for it much less than you should, so: big thank you from me for making
all this more accessible to "regular" users, and for helping out with
wireless in what's probably about two decades now. Much appreciated!

> I support whatever he=20
> needs to make him comfortable. Although the kernels found in newer releas=
es of=20
> various distros will eventually support the drivers, Realtek is adding wi=
fi 7=20
> features to the drivers. Once they release the new hardware, it will be a=
 short=20
> time until it is part of new models of laptops.

Right.

> I do not see where backports has any part of the solution to this problem=
.=C2=A0

Why not? It solves the exact same problem, no?

> As I=20
> had difficulty in getting it configured the first time I used that projec=
t, I do=20
> not see that as part of the solution for rtw88/89, other than it could be=
 used=20
> to suggest solutions for the API changes.=C2=A0

Well that's looking at it from the view of the user of backports, but I
think Brian is suggesting that he could be the user of backports, and
then the "regular end user" is just consuming the _output_ of backports
that Brian has vetted, so it ends up being similarly "make && sudo make
install" (or so.)

> My experience allows me to look at the=20
> wireless-next and mainline kernels and determine what changes are needed.=
 I am=20
> not sure I could explain that well enough to teach Brian.

Right. Keep in mind also though that you're doing it differently from
what backports does - backports comes with cfg80211 and mac80211, so
it's easier to do than adjusting to older versions of mac80211.

> Finally, I applaud Brian's initiative toward this project and I am conten=
t in=20
> knowing that the code is in good hands.

:)

johannes
