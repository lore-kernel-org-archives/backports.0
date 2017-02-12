Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:48362 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751218AbdBLTLv (ORCPT <rfc822;backports@vger.kernel.org>);
        Sun, 12 Feb 2017 14:11:51 -0500
Message-ID: <1486926706.5142.1.camel@sipsolutions.net> (sfid-20170212_201153_150545_81A1A14B)
Subject: Re: [RFC] backports: always use new version compare macros
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>,
        backports@vger.kernel.org
Date: Sun, 12 Feb 2017 20:11:46 +0100
In-Reply-To: <3babafe1-f754-bfe0-06fd-94e69137520a@broadcom.com> (sfid-20170211_224517_636776_965EDC33)
References: <20170207220716.7538-1-johannes@sipsolutions.net>
         <1486505323.18071.2.camel@sipsolutions.net>
         <3babafe1-f754-bfe0-06fd-94e69137520a@broadcom.com>
         (sfid-20170211_224517_636776_965EDC33)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sat, 2017-02-11 at 22:45 +0100, Arend Van Spriel wrote:
> 
> On 7-2-2017 23:08, Johannes Berg wrote:
> > It's some churn, but I think worthwhile - any objections?
> 
> I find comparison operators more clear, but it is probably just a
> matter of getting used to it. What makes it worthwile? As you already
> did the churn I do not have any objections. Just curious.

So to be honest, I actually pushed the change more or less by accident,
I'm happy to back it out again.

My reasoning was something along these lines: First, I find it awkward
to always type the long form when we always have the same patterns.
Especially with the IN_RANGE() part, which I haven't even fully
converted I think. So that's my immediate motivation for adding it, but
as the de-facto maintainer now I'd also want people to really be able
to figure out which pattern they should use, regardless of whether
they're looking at old or new bits, so unifying it (towards the new one
because I'm a lazy bastard) seemed like a good idea.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
