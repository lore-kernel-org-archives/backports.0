Return-path: <backports-owner@vger.kernel.org>
Received: from tmemail.tme-inc.com ([64.40.243.198]:3821 "EHLO tme-inc.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757042AbaDKOfG convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 11 Apr 2014 10:35:06 -0400
From: "Harrison Lee" <harrisonl@tme-inc.com>
To: <backports@vger.kernel.org>
References: <CAB=NE6VvyBKzEg=ErZzQMktY8eLytQ21JCPrOQbxvZ9m-nqHkw@mail.gmail.com> <53451077.2030102@openwrt.org> <CAB=NE6UUN4vQd3SpsvO5tcgaYq3YXQeE0KtZGki7p7OnR=J4RA@mail.gmail.com> <20140409191225.GA10560@kroah.com> <CAB=NE6VqY8yXoYuE0o01vq86imY8EtqLdkPa4bGMvR3bTaj5KQ@mail.gmail.com> <20140409202224.GA12953@kroah.com> <CAB=NE6XY5++p7hJQpQdwrFNUcGbUsKpC+oJiZQciXNduo+8j8A@mail.gmail.com> <20140409210613.GA14392@kroah.com> <s5heh15pr18.wl%tiwai@suse.de> <CAB=NE6VeNTFeGxKXpYunkU-W=JPLMpOnrehttvsqB+yXkdz5fg@mail.gmail.com>
In-Reply-To: <CAB=NE6VeNTFeGxKXpYunkU-W=JPLMpOnrehttvsqB+yXkdz5fg@mail.gmail.com>
Subject: RE: Bumping required kernels to 3.0 for Linux backports ?
Date: Fri, 11 Apr 2014 10:22:04 -0400
Message-ID: <006d01cf5591$694ee230$3beca690$@com> (sfid-20140411_163512_679399_4C6B284E)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Compat-wireless drivers have been very useful to users like us, who have to work with embedded linux system based on old kernel. For example, we work on a arm based system with 2.6.28 kernel, and could use ath9k drivers thanks to compat-wireless-3.6.8-1. The company who provided the SDK, a big name company, does not have any plan to upgrade the kernel, so we are stuck with it due to all the customized drivers for the chip.

But the situation seems to be changing. Compat-drivers does not support 2.6.28 any more for ath9k. It only supports from 2.6.30 according to "dependencies" list.

I've just joined the mailing list to learn how to backport wwan drivers. And the first message I see is about dumping supports for older kernels...

Would there be any alternatives for old kernel users, then?

Harrison

> 
> That's two stakeholders for 3.0 -- but nothing is voiced for anything
> older than that. Today I will rip the older kernels into oblivion.
> Thanks for all the feedback!
> 
>  Luis
 

__________ Information from ESET NOD32 Antivirus, version of virus signature database 9666 (20140411) __________

The message was checked by ESET NOD32 Antivirus.

http://www.eset.com
 


