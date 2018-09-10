Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.62]:48802 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbeIJMR2 (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 10 Sep 2018 08:17:28 -0400
Message-ID: <1536564277.3224.7.camel@sipsolutions.net> (sfid-20180910_092452_298416_76B5FDB0)
Subject: Re: [Cocci] New release after 1.0.7?
From: Johannes Berg <johannes@sipsolutions.net>
To: Julia Lawall <julia.lawall@lip6.fr>,
        Luciano Coelho <luciano.coelho@intel.com>
Cc: cocci@systeme.lip6.fr, backports@vger.kernel.org
Date: Mon, 10 Sep 2018 09:24:37 +0200
In-Reply-To: <alpine.DEB.2.20.1808141515280.3371@hadrien> (sfid-20180814_152007_774372_35ED45D6)
References: <32b52167e7dd5734ba4aa5f21aa1fddd257e6292.camel@intel.com>
         <alpine.DEB.2.20.1808141515280.3371@hadrien>
         (sfid-20180814_152007_774372_35ED45D6)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Julia,

On Tue, 2018-08-14 at 15:19 +0200, Julia Lawall wrote:

> Sorry, I'm not sure where 1.0.7 came from. [...]

> I would indeed like to make a release now that the compiations issues are
> resolved and things seem more stable.

Were you able to clear this up?

I see now that the website advertises the 1.0.7 release, however

 * it's not tagged in git(hub) - all previous releases have a tag
 * commit c1522bde ("Release 1.0.7") is NOT what's released as 1.0.7 on
   the website
 * it *looks* like the actual 1.0.7 release was cut from a much newer
   git commit, likely with the fix?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
