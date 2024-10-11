Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CF112C470
	for <backports@vger.kernel.org>; Fri, 11 Oct 2024 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728656138; cv=none; b=Ls5+5dYX62JhKMhL99fiUa1YLcDvVOVQ9VHKBsW1oKQB2Gvc45cPvdCP4EXgUFtXIZDgrxRk7wX2BbQqqA2mWZQMd7fVdBEkCvjHwZ6qHYCvEsYxPZOoZs2/cDnhz0VEmzF8sjZqg/Ey/zICpfWUAJGAXORcT0ZVR17e32SX4/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728656138; c=relaxed/simple;
	bh=aNP9wN63tjCz2HvIlA4rzJnaTkkFJIGr3H+ChQm384A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlDfjk0oqTG5toy/DJpTRY7gM9ilEHlcQRNP4WsxerY8rGp0VYY12O9spcIxjJCm7cAhfHcqLucGPQbj+vzCMfRM90IpB3tz8RhwtmApgljyTzbHbF5lIDuwE+YmVWmYV8K+/znzxMdqCAioC6v/PkbFcZJ7avPBE0c5Q8aHpLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OQz3HOih; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OQz3HOih"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850F3C4CEC3;
	Fri, 11 Oct 2024 14:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728656137;
	bh=aNP9wN63tjCz2HvIlA4rzJnaTkkFJIGr3H+ChQm384A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OQz3HOihg8/ZyzHrX/MR6sGL2fVgy/6U8I668GsEgnuRjFM0HQy3ZZkIf6l1mm00F
	 iJylmaWkT+iHZ9ZD/2BYdtU+ZEnFBZCWInBBMc9tvCGfmabeSgJZS6vP+ixwPwtSHE
	 +msFV2YqKfpm+cM3KfjBVqaweTSgMnYuQxj8255c=
Date: Fri, 11 Oct 2024 10:15:34 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org
Subject: Re: Sunsetting backports.wiki.kernel.org
Message-ID: <20241011-radiant-precious-gaur-6e2a61@lemur>
References: <20241008-amethyst-kestrel-of-realization-bb7b26@lemur>
 <fc1c1d078cc5026a829d9c9daa59f6732add8520.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fc1c1d078cc5026a829d9c9daa59f6732add8520.camel@sipsolutions.net>

On Fri, Oct 11, 2024 at 02:01:41PM GMT, Johannes Berg wrote:
> > Please let me know how you would like to proceed. If I don't hear back from
> > anyone in the next few days, I will configure the backports.docs.kernel.org
> > with the current converted contents and redirect backports.wiki.kernel.org
> > there.
> 
> Maybe for now it'd make sense to move the repo into the backports/ group
> on kernel.org? Or are you trying keep everything together in
> docs/docsko/?

Yes, it has to stay under docs/docsko for the triggers to work properly.

> It probably doesn't matter anyway, I'm just not sure how permissions
> would work if it's in docs/docsko/, I guess you can still give the
> backport group access? Who actually does have access to the repo now?

I've granted access to that repository to the @backports group, so you should
now be able to push changes there.

> Honestly, I have very little opinion on this - even the few changes that
> backports is still seeing we're not taking much care of the wiki these
> days. Maybe Hauke has any further thoughts.

I'm perfectly happy to keep the source where it is. The only downside compared
to hosting it on readthedocs.io is that propagating changes takes much longer
(10-15 minutes).

-K
