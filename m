Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:36198 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751923AbcBFTMI (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 6 Feb 2016 14:12:08 -0500
Message-ID: <1454785925.2166.1.camel@sipsolutions.net> (sfid-20160206_201209_891954_64064551)
Subject: Re: backports build issue with 4.5-rc2
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend@broadcom.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Sat, 06 Feb 2016 20:12:05 +0100
In-Reply-To: <1454785873.2166.0.camel@sipsolutions.net> (sfid-20160206_201119_371384_48FFBE90)
References: <56B477EB.1010308@broadcom.com>
	 (sfid-20160205_113050_784576_5F9729C3) <1454785873.2166.0.camel@sipsolutions.net>
	 (sfid-20160206_201119_371384_48FFBE90)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sat, 2016-02-06 at 20:11 +0100, Johannes Berg wrote:
> On Fri, 2016-02-05 at 11:22 +0100, Arend van Spriel wrote:
> > I created a 4.5-rc2 package and am getting build error against
> > 3.11 
> > kernel for cfg80211 and mac80211. Does anyone has patch for this
> > already?
> > 
> 
> Yes, I sent it on Dec 17th to this list :)
> 

Ah, but only the BIT_ULL(), not the wireless_nlevent_flush(). The
latter cannot be backported, you just have to declare an inline that
does nothing.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
