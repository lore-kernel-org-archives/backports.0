Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:59524 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752481AbdLASDA (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 1 Dec 2017 13:03:00 -0500
Message-ID: <1512151378.25588.20.camel@sipsolutions.net> (sfid-20171201_190302_115105_1E4CA93C)
Subject: Re: Parse error with genl-const.cocci
From: Johannes Berg <johannes@sipsolutions.net>
To: Remington Furman <remicles2@gmail.com>, backports@vger.kernel.org
Cc: cocci <cocci@systeme.lip6.fr>
Date: Fri, 01 Dec 2017 19:02:58 +0100
In-Reply-To: <5c6cb44c-9e19-8cf2-8946-a9c0e08c3974@gmail.com> (sfid-20171201_185732_488308_017133DA)
References: <925f98d2-047f-785f-4162-21b53a77cd62@gmail.com>
         <1512116859.25588.4.camel@sipsolutions.net>
         <5c6cb44c-9e19-8cf2-8946-a9c0e08c3974@gmail.com>
         (sfid-20171201_185732_488308_017133DA)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2017-12-01 at 09:57 -0800, Remington Furman wrote:
> 
> Ok, I've rebuilt with 1.0.4, and it applied genl-const.cocci just
> fine.  But, later on my CPU was held at 100% for 29 minutes:

Yeah, known issue. Give it more time - that particular patch is
*really* slow. Yes, more than 29 minutes, on my system as well.

What I can recommend is that you remove things from copy-list that you
don't care about, e.g. bluetooth drivers if you don't need them,
certain wifi drivers you don't need, etc. (before running gentree.py)

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
