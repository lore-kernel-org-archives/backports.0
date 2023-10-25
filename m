Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B07F26E34
	for <backports@vger.kernel.org>; Wed, 25 Oct 2023 12:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailfence.com header.i=brianwitte@mailfence.com header.b="WiHu3nht"
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com [212.3.242.68])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCF690
	for <backports@vger.kernel.org>; Wed, 25 Oct 2023 05:57:36 -0700 (PDT)
Received: from smtpauth2.co-bxl (smtpauth2.co-bxl [10.2.0.24])
	by wilbur.contactoffice.com (Postfix) with ESMTP id A4F5B11B6;
	Wed, 25 Oct 2023 14:57:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1698238654;
	s=20210208-e7xh; d=mailfence.com; i=brianwitte@mailfence.com;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	l=2673; bh=b62xyy08JZ3pnhtL6UkaSwUqxcFoTzO6efWb62IlxxA=;
	b=WiHu3nhtQr2/dQ3yxZm0uFN8Ktx+qXq8PF9lCV8jTIJndkYu7Jt74n1NzO4Pk6X3
	rQ+s3J6NTqkZqt1JYT1fIzt2tgEy4xuoXVBw6lUHQnq9KkelBPvO4+U3KEm8LyMmeOe
	tir6HpKnNpRjPkudyMW83fOsFYAtLG3p6Nj5WMTcFoToeCKhgmvAVV7ygU/qrJHYEqP
	EMFQ5fLyIFWTdWo6sXT6eUy/wSezZpmgtYz5OHlXMm+O6YYJ2Rm7xyhBdwUOcs42ZJl
	c5C77Zq8MPzY5rAiFHhWlS7h4anfGHDo0n7f9WkQIOkL3SG1Z7BZExEju+Lc59KgEn2
	iSDgdXX8Uw==
Received: by smtp.mailfence.com with ESMTPSA ; Wed, 25 Oct 2023 14:57:31 +0200 (CEST)
Message-ID: <1a600228-6975-4798-b2df-89d99007337e@mailfence.com>
Date: Wed, 25 Oct 2023 07:56:42 -0500
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: rtw88, rtw89 -- options for bringing a couple rtw standalone
 GitHub repos into backports.git
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
 Larry Finger <Larry.Finger@lwfinger.net>, hauke@hauke-m.de,
 backports@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>
References: <831d1de6-5d02-43b9-b907-70d9f1a03cab@mailfence.com>
 <435c43bae693e72004c39ff90a901bc911ab1e6d.camel@sipsolutions.net>
 <029db1c1-2ac8-430e-915b-beb7c3741de2@lwfinger.net>
 <0b543e2e6aa3f2473d7ed8e406b74b69e1804143.camel@sipsolutions.net>
From: Brian Witte <brianwitte@mailfence.com>
In-Reply-To: <0b543e2e6aa3f2473d7ed8e406b74b69e1804143.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ContactOffice-Account: com:441463380


Johannes,
> Right. Keep in mind also though that you're doing it differently from
> what backports does - backports comes with cfg80211 and mac80211, so
> it's easier to do than adjusting to older versions of mac80211.
I spoke to Larry off list and considering the cfg80211 and mac80211 
situation with older kernels further, he wants me to try and get a 
simple backports setup validated so that people can still
`make` and `make install`. He is focused on a few other important tasks 
and will probably get back with us here later, I just wanted to start 
running downhill with this ASAP so I slid in here.

I am going to first try a variation of the approach you suggested where 
I generate backports for Linux versions in the repo in ascending order 
then have our Makefile detect user's version and install accordingly.

Again, my understanding is often the bottleneck so I want to first say 
what I intend to do and then ask a question:

1. I want to use wireless-next as the upstream kernel source for 
building the backports, I would need to build all backports via the 
"package release" workflow [1] in order to provide users with a package 
that they can use without needing the upstream source on their machine, 
effectively giving them "a patch file" for compatibility for driver 
specific modifications and the up-to-date 80211 stack. I would then only 
need to decide which git tags for older kernels to use for the versions 
we want to support, create the packages, then include those in the 
repository.

[1] https://backports.wiki.kernel.org/index.php/Documentation/packaging

2. I am trying to figure this out currently, but am not entirely sure 
how granular the built package versions have to be in order to work with 
a users kernel version. How do I decide the coverage of an individual 
package per major-minor version or other variations? You mentioned RCs 
earlier. For this first PoC, I want to make sure users can get the 
driver working for any version they are running going back to 5.4.

After that, our Makefile and/or scripts it coordinates will have to 
detect the user version, then cd into that package, and install it 
properly. I am suspending any upstream commit history shenanigans for a 
later point as making sure the driver is performant and in-line with the 
up-to-date wireless stack. Being able to use those features and have a 
consistent API across the components is much more of a priority, at the 
moment.

Thank you for you help and patience with all of this. You have helped 
make this process an enjoyable thing to dive into and I am excited to 
start hacking on backports.

Thanks,
Brian Witte
