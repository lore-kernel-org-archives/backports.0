Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:57298 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190Ab3EHJBG (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 8 May 2013 05:01:06 -0400
Message-ID: <1368003661.8279.17.camel@jlt4.sipsolutions.net> (sfid-20130508_110110_240907_537A1DB8)
Subject: Re: [PATCH] backports: adjust snd_portid patch for nl80211 update
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Wed, 08 May 2013 11:01:01 +0200
In-Reply-To: <CAB=NE6UiDwf4ojR=XaVF+QqttKxKnNHcLJ9otF2ud3kdkdoddQ@mail.gmail.com> (sfid-20130508_105931_361002_4FDA569A)
References: <1367997031-11574-1-git-send-email-johannes@sipsolutions.net>
	 <1367997056.8279.10.camel@jlt4.sipsolutions.net>
	 <CAB=NE6UiDwf4ojR=XaVF+QqttKxKnNHcLJ9otF2ud3kdkdoddQ@mail.gmail.com>
	 (sfid-20130508_105931_361002_4FDA569A)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2013-05-08 at 01:59 -0700, Luis R. Rodriguez wrote:


> So that's next-20130428 but since that doesn't exist we want to easily
> branch out into a linux-3.10.y branch by having at least:
> 
>   * next-20130426
>   * next-20130426
>   * next-20130429
> 
> Given that johill has likely time warped us to next-20130423 perhaps
> its also good to have next-20130424. That would be the full set prior
> to the merge window for v3.10 (or whatever $linux_deity wants to call
> it).

I haven't really, I just needed this particular patch for iwlwifi from
wireless-testing.

johannes

