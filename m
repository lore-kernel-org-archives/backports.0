Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.62]:50844 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbeISOUt (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 19 Sep 2018 10:20:49 -0400
Message-ID: <1537346626.10305.2.camel@sipsolutions.net> (sfid-20180919_104359_581485_98A9FA53)
Subject: Re: 0079-netdev-destructor.cocci very slow
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>,
        "backports@vger.kernel.org" <backports@vger.kernel.org>
Cc: cocci@systeme.lip6.fr
Date: Wed, 19 Sep 2018 10:43:46 +0200
In-Reply-To: <c823a257-4a1e-f3d0-d5a4-4face3c0c85a@hauke-m.de>
References: <afcbee1b-be9f-bbd2-a72e-1a89a24b4f3d@hauke-m.de>
         <1537262543.2957.19.camel@sipsolutions.net>
         <c823a257-4a1e-f3d0-d5a4-4face3c0c85a@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2018-09-18 at 23:52 +0200, Hauke Mehrtens wrote:

> > spatch should already try that internally, but perhaps with some extra
> > knowledge we can do a better job ...

> Yes we talked about this topic some months ago in IRC.
> If there is really no better solution, then I will grep in all files for
> needs_free_netdev and priv_destructor and only apply this to the files
> which are matching. This list should be pretty short.

Right. No objection to that. Perhaps we should have some sort of special
comment header for our spatches that the script can consume?

Something like

// restrict-files: grep -qE 'needs_free_netdev|priv_destructor'

and we'd run that on all files? Or perhaps the API should be more a la
"grep -lE" so we can run it on many files and get a list of matching
files out?

> It looks like coccinelle already does such a grep when I remove the <--
> --> from the patch, because this is about 100 times faster.

Good point, not sure why it doesn't do that with the <... ...>?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
