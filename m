Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:39758 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729566AbeHPKC5 (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 16 Aug 2018 06:02:57 -0400
Message-ID: <1534403122.3547.51.camel@sipsolutions.net> (sfid-20180816_090636_198317_F24298EE)
Subject: Re: [Cocci] New release after 1.0.7?
From: Johannes Berg <johannes@sipsolutions.net>
To: Luciano Coelho <luciano.coelho@intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>
Cc: cocci@systeme.lip6.fr, backports@vger.kernel.org
Date: Thu, 16 Aug 2018 09:05:22 +0200
In-Reply-To: <72ebc0aac08fd1e82dfb09cc12a2c8321f302d49.camel@intel.com> (sfid-20180814_163933_723729_9E8F6797)
References: <32b52167e7dd5734ba4aa5f21aa1fddd257e6292.camel@intel.com>
         <alpine.DEB.2.20.1808141515280.3371@hadrien>
         <deb8e4df52ce0baddcae77458a8a7246814b8804.camel@intel.com>
         <alpine.DEB.2.20.1808141541470.3371@hadrien>
         <72ebc0aac08fd1e82dfb09cc12a2c8321f302d49.camel@intel.com>
         (sfid-20180814_163933_723729_9E8F6797)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2018-08-14 at 17:39 +0300, Luciano Coelho wrote:
> 
> Yes, this looks right! So it seems to be working with 1.0.8. :P

There is no 1.0.8 though.

Julia, can you clear up the confusion with 1.0.7 and perhaps make a
1.0.8 release? Right now, there's only a very old (1.0.4 I think)
release that can do this at all, but it isn't compatible with the
current syntax. We'd like to have a release that has this ability so we
can check for the (minimum) version.

Thanks,
johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
