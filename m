Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:38686 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751921AbdBGEUg (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 6 Feb 2017 23:20:36 -0500
Message-ID: <1486441223.3070.2.camel@coelho.fi> (sfid-20170207_052038_630627_F9EA93C9)
From: Luca Coelho <luca@coelho.fi>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        backports@vger.kernel.org
Date: Tue, 07 Feb 2017 06:20:23 +0200
In-Reply-To: <04ef169d-49b1-98e0-1db6-7c4e7e9b5c9f@broadcom.com>
References: <1486399064.5430.7.camel@sipsolutions.net>
         <04ef169d-49b1-98e0-1db6-7c4e7e9b5c9f@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: deprecating more kernel versions
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2017-02-06 at 23:45 +0100, Arend Van Spriel wrote:
> On 6-2-2017 17:37, Johannes Berg wrote:
> > What kernel versions do you still need?
> > 
> > For example, 3.0 is getting really quite old, the oldest long-term
> > stable is 3.2.x now.
> 
> We currently backport internal tree and wireless-testing nightly to 3.10
> and 3.11 kernels.

I think capping at 3.10 is reasonable.  Internally, we have been
supporting 3.8+, but we got permission to support only 3.12 and above.

Last time we nuked support for older kernels [1], we were supporting
only 15 kernel versions (3.0 through 3.14).  Now we are at 30 (3.0
through 4.10 -- sort of).  If we make the cut at 3.10 we are at 20,
which is still a lot more conservative than our last "nuke".

[1] https://git.kernel.org/cgit/linux/kernel/git/backports/backports.git/commit/?id=be4a0f9ad7e17670d7a30c9e94d5dd918425f90a

--
Cheers,
Luca.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
