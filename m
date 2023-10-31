Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5398722309
	for <backports@vger.kernel.org>; Tue, 31 Oct 2023 19:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c96GQoN2"
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25735A3
	for <backports@vger.kernel.org>; Tue, 31 Oct 2023 12:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MtyIg8uZ0VRf0Ftif12EgqCEsJKgBo5BnBLXzto1+tU=; b=c96GQoN2R3rsuLI4KoRE1a95Dz
	fUesz9oxzRCop3/lCfoSY/+mtYjBkxLy2hoQQD3/z3d3P8HtJv/GYM0kLe5y+/do3+F3YKeFGiVBf
	R3seEgvevljQ+2whDj8jpR+0s4YnhVEDEo8qmAHiqnmAtuH6EGce5g35EYiTYf9LzcteLQSzwj302
	akZ6U7JnL0XA0gR/RwFT7NTnBXrsGrBy5Nn2NoZcdz13SfRCIrApxO4bl0LMlnDuw74B9o5QNUZch
	jtniSBo9L3hf5FjUMpvsrccMyyk3cwDO0nh538DSdGPy+8lZksxi7N/N/UIjBDXriIJk+gfMcZGhb
	15bnlyXg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qxuXe-0062LJ-2G;
	Tue, 31 Oct 2023 19:36:46 +0000
Date: Tue, 31 Oct 2023 12:36:46 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Brian Witte <brianwitte@mailfence.com>
Cc: backports@vger.kernel.org, hauke@hauke-m.de,
	Johannes Berg <johannes@sipsolutions.net>,
	Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: rtw88, rtw89 -- options for bringing a couple rtw standalone
 GitHub repos into backports.git
Message-ID: <ZUFXTmAHpw2EcRH7@bombadil.infradead.org>
References: <831d1de6-5d02-43b9-b907-70d9f1a03cab@mailfence.com>
 <435c43bae693e72004c39ff90a901bc911ab1e6d.camel@sipsolutions.net>
 <029db1c1-2ac8-430e-915b-beb7c3741de2@lwfinger.net>
 <0b543e2e6aa3f2473d7ed8e406b74b69e1804143.camel@sipsolutions.net>
 <1a600228-6975-4798-b2df-89d99007337e@mailfence.com>
 <18fb6b9a0e1d2a7cc08eaa34979067e7094bb2a1.camel@sipsolutions.net>
 <b67264b6-41f8-4415-ab8a-fbdbac21748e@mailfence.com>
 <44560748.117980.1698769443983@ichabod.co-bxl>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44560748.117980.1698769443983@ichabod.co-bxl>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Tue, Oct 31, 2023 at 05:24:04PM +0100, Brian Witte wrote:
> What other testing do you recommend for a "new driver" besides testing
> "builds" as mentioned in docs [1] here in 'Adding new driver'?

Whatever this ends up being:

> I am working on test/automation for our new backports workflow so any
> insight you have would be helpful.

If you decide to give kdevops a shot to allow folks to test wifi devices easily
I'm happy to give any tips / advice. PCIe passthrough is supported through
'make dynconfig' so you could end up using that so to not crash a host. We're
using that to test new block devices with new filesystem developments.
The only issue we've run into when doing this is when a PCI device resets
the sysfs file changes on the host so PCI passthrough stops, working
around this manually is documented here:

https://lore.kernel.org/all/ZQIRh+fpU1sR8BTN@bombadil.infradead.org/T/#u

How we fix this upstream for pcie passthrough remains unclear yet. For
wifi devices I am not sure what sort of things triggers full PCI device
resets, perhaps firmware crashes?

  Luis
