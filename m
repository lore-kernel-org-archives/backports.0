Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:46493 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932837AbcFCS5u (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 3 Jun 2016 14:57:50 -0400
Message-ID: <1464980268.2224.8.camel@sipsolutions.net> (sfid-20160603_205800_609363_10F7561D)
Subject: Re: [PATCH] backports: update devcoredump patch
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
	backports@vger.kernel.org
Date: Fri, 03 Jun 2016 20:57:48 +0200
In-Reply-To: <5751D2C9.6080301@broadcom.com> (sfid-20160603_205612_829911_57B49525)
References: <1464702541-20621-1-git-send-email-johannes@sipsolutions.net>
	 <1464703413.3076.31.camel@sipsolutions.net>
	 <67751df1-34ee-6e9f-3dd5-7b9a8400f25e@broadcom.com>
	 <1464979700.2224.7.camel@sipsolutions.net> <5751D2C9.6080301@broadcom.com>
	 (sfid-20160603_205612_829911_57B49525)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


> I guess I could take your patch as I only need it to build but have
> to remove -Werror option for that. My nightly testing does not invoke
> the devcoredump explicitly. It will when our 802.11 psm hangs.
> 

Well, then you don't really need to do anything - the only problem
would be with drivers that need the new method (none yet); the compiler
warning about the prototype mismatch is actually harmless (a function
that used to take a "const void *" now gets a "void *")

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
