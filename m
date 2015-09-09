Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:51138 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752868AbbIIMaP (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 9 Sep 2015 08:30:15 -0400
Message-ID: <1441801810.3316.6.camel@sipsolutions.net> (sfid-20150909_143017_999601_882724BF)
Subject: Re: backport devcoredump
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend@broadcom.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Wed, 09 Sep 2015 14:30:10 +0200
In-Reply-To: <55F02021.3060603@broadcom.com>
References: <55EFEEF2.2060205@broadcom.com>
	 <1441788585.3316.2.camel@sipsolutions.net> <55F02021.3060603@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2015-09-09 at 14:03 +0200, Arend van Spriel wrote:
> 
> > I guess I'll need to run that - are you using a special copy-list?
> 
> I do and maybe that is causing it. I attached it.
> 

Unlikely. However, I can't reproduce your issue - if I just add "select
WANT_DEV_COREDUMP" to your driver (brcmsmac) in my tree and compile
with that I do get it enabled.

Can you share your driver changes for it?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
