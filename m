Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.62]:51060 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbeIXCcX (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 23 Sep 2018 22:32:23 -0400
Message-ID: <1537734805.1707.17.camel@sipsolutions.net> (sfid-20180923_223339_220259_2012B89D)
Subject: Re: [PATCH 06/10] dependencies: make hostap and atmel depend on
 kernel >= 4.18
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org, john@phrozen.org
Date: Sun, 23 Sep 2018 22:33:25 +0200
In-Reply-To: <78f873b0-6053-731a-dfab-37186d262005@hauke-m.de>
References: <20180923174535.16198-1-hauke@hauke-m.de>
         <20180923174535.16198-7-hauke@hauke-m.de>
         <1537733820.1707.10.camel@sipsolutions.net>
         <78f873b0-6053-731a-dfab-37186d262005@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, 2018-09-23 at 22:23 +0200, Hauke Mehrtens wrote:
> On 09/23/2018 10:17 PM, Johannes Berg wrote:
> > On Sun, 2018-09-23 at 19:45 +0200, Hauke Mehrtens wrote:
> > > The hostap and atmel wireless driver now make use of the
> > > proc_create_single_data() function which can not easily be backported.
> > > As these drivers are not used too often just deactivate them on older
> > > kernel versions for now.
> > 
> > It should be pretty easy to backport based on proc_create_data(), which
> > has been around since 2.6.26?
> > 
> > johannes
> 
> One of the upstream commits is this:
> https://git.kernel.org/linus/d51269592c327fcfe8ec80fd169a84f8dc0de73b

Sure.

> The problem is that these function also get some data so we would have
> to provide the data and the show function pointer and store it
> somewhere. Most of the proc structures are also private so we can not
> easily abuse some unused member.

But proc_create_data() does pass the data to store, and PDE_DATA() to
get it back has been there also forever?

Ah, but yes, you'd also have to store the show pointer, and thus
probably allocate memory for the data, and then you even have to leak it
because you can't hook into the freeing thereof.

> The affected drivers are anyway not used much any more.

True.

I suppose if somebody really needed the drivers they'd be better off
reverting the patch linked above.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
