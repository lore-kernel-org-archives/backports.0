Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailfence.com header.i=brianwitte@mailfence.com header.b="cuFofkPD"
Received: from mailout-l3b-97.contactoffice.com (mailout-l3b-97.contactoffice.com [212.3.242.97])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1228FA4
	for <backports@vger.kernel.org>; Fri, 24 Nov 2023 09:38:11 -0800 (PST)
Received: from ichabod.co-bxl (ichabod.co-bxl [10.2.0.36])
	by mailout-l3b-97.contactoffice.com (Postfix) with ESMTP id 2B3E62D;
	Fri, 24 Nov 2023 18:38:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1700847489;
	s=20210208-e7xh; d=mailfence.com; i=brianwitte@mailfence.com;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
	l=1388; bh=2AZLKkYRvfOyyNzZCLZEfoKstA/FD9G+eN3rONxUSp4=;
	b=cuFofkPDKHFDjsa+Nr3QizKpA0Fy+soT+rBTMnW28ZoJ3ovneUZNPEF3ZY88HShP
	6iTcYRFAwPs4ZyJbMfeLEpoAY8wk8hlWKNvyZo+B8NZFMC+qgotYUSIiBuumy+0j05Q
	e1D4DTK+rOjf5Oi/AcQH+zGJu77pOSPYH8drV9sXZwL7hTTn3FyR4nJap5TTqtaVeNs
	4W9gD4yhX8iuezeYSrsrviaeFMSRYedONpTUUs0pMeqzbX7QpNc30fYgx3kqXfWQ9Ty
	ccVg+svgb3J5tSplxBo2wmH+o/ZOcvHNA4n57I9zeN6hm3annrMT1IXdcidvv2/poC0
	+xNl8Fytdw==
Date: Fri, 24 Nov 2023 18:38:07 +0100 (CET)
From: Brian Witte <brianwitte@mailfence.com>
To: backports@vger.kernel.org, Cristian Cimpianu <cristi@trego.co.il>,
	Larry Finger <Larry.Finger@lwfinger.net>
Cc: eyal@trego.co.il
Message-ID: <447949051.552711.1700847486717@ichabod.co-bxl>
In-Reply-To: <e6e3719a-9ca1-4a24-b898-38eec2c1da62@lwfinger.net>
References: <31498106.Y1g1iz2YYI@cristie14.c-scale.ro> <e6e3719a-9ca1-4a24-b898-38eec2c1da62@lwfinger.net>
Subject: Re: backports for wifi-7 and kernel 6.5
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: ContactOffice Mail
X-ContactOffice-Account: com:441463380


> ----------------------------------------
> From: Larry Finger <Larry.Finger@lwfinger.net>
> Date: Nov 24, 2023, 7:34:16 AM
> 
> Christian,
> 
> I do not know the details, but Brian Witte (Cc'd here) recently informed me that 
> Felix Flietkau has a backports tree for kernel 6.5.
> 
> Larry
> 
> 

Cristian,

I was asking questions on #backports IRC channel since I also am trying to get a
more up-to-date backports release. I had started patching from 5.15 and was
making some progress, but it was going slower than I'd like and then Hauke
shared this tree with me:

https://github.com/nbd168/backports

It appears to be on 6.5, I have only pulled the code at this point and haven't
fully tested it since we had a holiday here in US and I have been traveling and
with family.

Felix is maintaining that tree for OpenWrt from what I have been told.
You can see various 6.x backports tarballs here if you search "backports":

https://mirror2.openwrt.org/sources/

I am going to be digging into this for Realtek backports repos that Larry and I
work on. It seems like there is some renewed interest in backports these
days, haha.

Let me know if I can help in any way as I am working on similar problems.

I will report back if any issues come while working with Felix's tree. I am very
grateful it was shared with me to say the least...

Brian Witte
