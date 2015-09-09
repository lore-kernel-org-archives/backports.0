Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:50079 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751925AbbIIItr (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 9 Sep 2015 04:49:47 -0400
Message-ID: <1441788585.3316.2.camel@sipsolutions.net> (sfid-20150909_104951_032610_BBFBE43C)
Subject: Re: backport devcoredump
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend@broadcom.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Wed, 09 Sep 2015 10:49:45 +0200
In-Reply-To: <55EFEEF2.2060205@broadcom.com>
References: <55EFEEF2.2060205@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2015-09-09 at 10:33 +0200, Arend van Spriel wrote:
> Hi Johannes,
> 
> I noticed that devcoredump has been added to backports project 
> through 
> backport-adjustment patch. brcmfmac now select WANT_DEV_COREDUMP. 
> However, when I run gentree.py the devcoredump patch is not applied. 
> Also Kconfig of brcm80211 still shows WANT_DEV_COREDUMP.

That's strange.

I guess I'll need to run that - are you using a special copy-list?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
