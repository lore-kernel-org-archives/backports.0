Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.62]:56486 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbeILPUL (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 12 Sep 2018 11:20:11 -0400
Message-ID: <1536747369.3678.11.camel@sipsolutions.net> (sfid-20180912_121622_761899_6A8F82E0)
Subject: Re: [Cocci] New release after 1.0.7?
From: Johannes Berg <johannes@sipsolutions.net>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Luciano Coelho <luciano.coelho@intel.com>, cocci@systeme.lip6.fr,
        backports@vger.kernel.org
Date: Wed, 12 Sep 2018 12:16:09 +0200
In-Reply-To: <alpine.DEB.2.20.1809121214160.31876@hadrien>
References: <32b52167e7dd5734ba4aa5f21aa1fddd257e6292.camel@intel.com>
          <alpine.DEB.2.20.1808141515280.3371@hadrien>
          (sfid-20180814_152007_774372_35ED45D6) <1536564277.3224.7.camel@sipsolutions.net>
         <alpine.DEB.2.20.1809121214160.31876@hadrien>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2018-09-12 at 12:14 +0200, Julia Lawall wrote:

> > I see now that the website advertises the 1.0.7 release, however
> > 
> >  * it's not tagged in git(hub) - all previous releases have a tag
> >  * commit c1522bde ("Release 1.0.7") is NOT what's released as 1.0.7 on
> >    the website
> >  * it *looks* like the actual 1.0.7 release was cut from a much newer
> >    git commit, likely with the fix?
> 
> There is now a tag for the official release of 1.0.7 in github.

Great, thanks!

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
