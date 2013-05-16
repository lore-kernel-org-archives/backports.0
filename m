Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:57710 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224Ab3EPLYj (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 16 May 2013 07:24:39 -0400
Message-ID: <1368703470.8387.3.camel@jlt4.sipsolutions.net> (sfid-20130516_132444_154921_D46968EA)
Subject: Re: [PATCH 0/3] backports: take up up to next-20130426
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Thu, 16 May 2013 13:24:30 +0200
In-Reply-To: <CAB=NE6UrCSYztvoe0HP8fBANki0C4huePhAxxpSb6eV8KnCo6w@mail.gmail.com> (sfid-20130516_074504_402840_FA5DBB8F)
References: <1368440675-23190-1-git-send-email-mcgrof@do-not-panic.com>
	 <1368603799.8359.5.camel@jlt4.sipsolutions.net>
	 <CAB=NE6UiZPP02y126Qxc5c7q1wFer0_9cZLFP_QCQo_Z6uGJmQ@mail.gmail.com>
	 <CAB=NE6Ut5CdpistLecYnbzK-t+Rymw-Gzhj=DdhYEcm8DGPBYw@mail.gmail.com>
	 <CAB=NE6UrCSYztvoe0HP8fBANki0C4huePhAxxpSb6eV8KnCo6w@mail.gmail.com>
	 (sfid-20130516_074504_402840_FA5DBB8F)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2013-05-15 at 22:44 -0700, Luis R. Rodriguez wrote:

> >> while nouveau fails and uses the later.
> >
> > Actually I see now drivers that use either work so this seems to be
> > nouveau specific.
> 
> This seems to be because of the new changes that stuffed nouveau files
> into separate directories:
> 
> drivers/gpu/drm/nouveau/core/
> drivers/gpu/drm/nouveau/dispnv04/
> 
> I've tried this but no luck.
> 
> --- a/drivers/gpu/drm/nouveau/Makefile
> +++ b/drivers/gpu/drm/nouveau/Makefile
> @@ -3,9 +3,9 @@
>  # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
> 
>  ccflags-y := -Iinclude/drm

Isn't this part actually the issue?

Are you adding an override ttm_bo_driver.h file? Maybe include_next
doesn't work right with this -Iinclude/drm?

johannes

