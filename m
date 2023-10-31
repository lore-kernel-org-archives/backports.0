Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BD518C10
	for <backports@vger.kernel.org>; Tue, 31 Oct 2023 21:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailfence.com header.i=brianwitte@mailfence.com header.b="QVzTX4pm"
Received: from mailout-l3b-97.contactoffice.com (mailout-l3b-97.contactoffice.com [212.3.242.97])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF097E4
	for <backports@vger.kernel.org>; Tue, 31 Oct 2023 14:04:42 -0700 (PDT)
Received: from fidget.co-bxl (fidget.co-bxl [10.2.0.33])
	by mailout-l3b-97.contactoffice.com (Postfix) with ESMTP id 976364DB;
	Tue, 31 Oct 2023 22:04:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1698786280;
	s=20210208-e7xh; d=mailfence.com; i=brianwitte@mailfence.com;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
	l=1303; bh=WpaRZr0nNgtrrF8Bf1L/f6frSTL3sqJfq5BTxiaNfrA=;
	b=QVzTX4pmOhFOywBs+Qp2ecMZYlvSKmUJ1HTNNmrxh33kNg601Xnavu+JY1Wli0uR
	ML5MH8YB0ywKjGRjgrnXgvz1f+znQ3DwsgYM+sBylxhVHj8OEtCbgO/Ey7+pAN6GRYi
	uEMkOiu71RS85YDUh0bm3vFnUv/8KtaUcY0hWMt3D7GGBOJRdjXoQqSPT6SqXuO8X4f
	MHAw+nW0xgM2x6XgbXPG5/+QCG+5uRj7gwvB+QpjrpNQ6FPlNBKkItcHX5b93xxdGBV
	dG7QF2/+61MSM0OLN6mIGa+ArmoXL/1G6CixhOxNWOMEJKOlcqgNoWrpss8tMd8NkvV
	fICHRM5XBg==
Date: Tue, 31 Oct 2023 22:04:39 +0100 (CET)
From: Brian Witte <brianwitte@mailfence.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: backports@vger.kernel.org, hauke@hauke-m.de,
	Johannes Berg <johannes@sipsolutions.net>,
	Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <2130762733.458314.1698786279143@fidget.co-bxl>
In-Reply-To: <ZUFXTmAHpw2EcRH7@bombadil.infradead.org>
References: <831d1de6-5d02-43b9-b907-70d9f1a03cab@mailfence.com> <435c43bae693e72004c39ff90a901bc911ab1e6d.camel@sipsolutions.net> <029db1c1-2ac8-430e-915b-beb7c3741de2@lwfinger.net> <0b543e2e6aa3f2473d7ed8e406b74b69e1804143.camel@sipsolutions.net> <1a600228-6975-4798-b2df-89d99007337e@mailfence.com> <18fb6b9a0e1d2a7cc08eaa34979067e7094bb2a1.camel@sipsolutions.net> <b67264b6-41f8-4415-ab8a-fbdbac21748e@mailfence.com> <44560748.117980.1698769443983@ichabod.co-bxl> <ZUFXTmAHpw2EcRH7@bombadil.infradead.org>
Subject: Re: rtw88, rtw89 -- options for bringing a couple rtw standalone
 GitHub repos into backports.git
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: ContactOffice Mail
X-ContactOffice-Account: com:441463380


> From: Luis Chamberlain <mcgrof@kernel.org>
> Date: Oct 31, 2023, 2:36:46 PM
>
> If you decide to give kdevops a shot to allow folks to test wifi
> devices easily
> I'm happy to give any tips / advice. PCIe passthrough is supported through

Luis,

Yes, the plan is still kdevops for this.

At Linux Plumbers Conference, my main goals are:
1. Learn about kernel testing, debugging, and net/wireless.
2. Meet and get advice, tips from backports/wireless/kdevops folks.

I wanted to have kdevops set up in time for LPC so could I talk shop
better with other kdevops users, but figuring out how to get Larry's
most popular GitHub backport repos up-to-date took priority and I
stalled on the kdevops setup.

Right now I have a basic scripted QEMU setup that is a pain.

Good news is now that we have our ducks in a row with the gameplan for
using backports, I can jump back fully into testing workflow and
automation so we can start bumping up the release package versions that
work with rtw88/rtw89 to a more current stable. Larry thinks sticking to
stable will be better for the GitHub repos going forward with backports
instead of wireless-next like we were for the manual backports.

I will reach out on the kdevops channels as I go through it.

Thanks,

Brian Witte
