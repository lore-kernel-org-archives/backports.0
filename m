Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:51491 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751886AbbIINy7 (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 9 Sep 2015 09:54:59 -0400
Message-ID: <1441806891.3316.9.camel@sipsolutions.net> (sfid-20150909_155501_640545_A6DE599F)
Subject: Re: backport devcoredump
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend@broadcom.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Wed, 09 Sep 2015 15:54:51 +0200
In-Reply-To: <55F03612.6040809@broadcom.com>
References: <55EFEEF2.2060205@broadcom.com>
		 <1441788585.3316.2.camel@sipsolutions.net> <55F02021.3060603@broadcom.com>
	 <1441801810.3316.6.camel@sipsolutions.net> <55F02882.5080207@broadcom.com>
	 <55F03612.6040809@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


> I guess the WANT_DEV_COREDUMP must be in the source tree to generate 
> drivers-base-devcoredump.c etc. I used backports generated tree using 
> my copy-list so not driver selects WANT_DEV_COREDUMP, because I 
> applied the brcmfmac devcoredump patch on the backports generated 
> tree.
> 

Yes, I think you're right - I changed that at some point because I
explicitly didn't want all the unused requirements to be pulled in.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
