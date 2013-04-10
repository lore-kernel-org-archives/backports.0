Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:32890 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934822Ab3DJUAP (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 10 Apr 2013 16:00:15 -0400
Message-ID: <1365624006.4235.42.camel@jlt4.sipsolutions.net> (sfid-20130410_220019_092094_5142A3F0)
Subject: Re: [PATCH 13/18] backports: add blacklist module support
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Wed, 10 Apr 2013 22:00:06 +0200
In-Reply-To: <CAB=NE6UEUcszkUMBtpwJQnWjAj5p15j_kf158697rSfVmwQM4A@mail.gmail.com> (sfid-20130410_215802_673573_F59A500A)
References: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
	 <1365593728-5720-14-git-send-email-mcgrof@do-not-panic.com>
	 <1365600903.4235.10.camel@jlt4.sipsolutions.net>
	 <CAB=NE6UEUcszkUMBtpwJQnWjAj5p15j_kf158697rSfVmwQM4A@mail.gmail.com>
	 (sfid-20130410_215802_673573_F59A500A)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2013-04-10 at 12:57 -0700, Luis R. Rodriguez wrote:

> > So you do mean "# new-driver old-driver", but then shouldn't the iwlwifi
> > lines be reversed?
> 
> You would know better, sorry I thought iwlagn replaces those, I'll swap.

Well it's a bit complicated and it changed a few times, but now there's
only iwlegacy and iwlwifi (with iwldvm/iwlmvm), so iwlagn no longer
exists. It did inbetween at some point, and I think iwlwifi even existed
before already, but that doesn't really matter since a new iwlwifi would
override an existing iwlwifi. So yeah I think they should be switched.

johannes

