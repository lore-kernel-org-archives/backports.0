Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:43516 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751226AbbKAHry (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 1 Nov 2015 02:47:54 -0500
Message-ID: <1446364070.3205.0.camel@sipsolutions.net> (sfid-20151101_084759_302924_56846346)
Subject: Re: [PATCH v2] backports: add ktime_get_seconds()
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend@broadcom.com>, backports@vger.kernel.org
Date: Sun, 01 Nov 2015 08:47:50 +0100
In-Reply-To: <56353A97.9010909@broadcom.com>
References: <1445601179-3434-1-git-send-email-johannes@sipsolutions.net>
	 <56313B75.4000406@broadcom.com> <56353A97.9010909@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sat, 2015-10-31 at 23:03 +0100, Arend van Spriel wrote:
> On 10/28/2015 10:17 PM, Arend van Spriel wrote:
> > On 10/23/2015 01:52 PM, Johannes Berg wrote:
> > > From: Johannes Berg <johannes.berg@intel.com>
> > > 
> > > Since commit 84b00607aeb8 ("mac80211: use ktime_get_seconds")
> > > mac80211 uses ktime_get_seconds(). This patch provide a backport
> > > using ktime_get_ts() for it.
> > > 
> > > [commit message and time64_t taken from Arend's patch]
> > > 
> > > Signed-off-by: Arend van Spriel <arend@broadcom.com>
> > 
> > Looks good. Thanks.
> 
> Actually got feedback internally that ubuntu kernel 3.19.0-30-generic 
> 
> does not need this patch so should we extend this with 
> UTS_UBUNTU_RELEASE_ABI check?
> 

If they backported that, then yeah, probably something like that --
unless we can find some #define that came with the backport to check
on?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
