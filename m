Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:40596 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933466AbdCJJwj (ORCPT <rfc822;backports@vger.kernel.org>);
        Fri, 10 Mar 2017 04:52:39 -0500
Message-ID: <1489139555.3038.4.camel@sipsolutions.net> (sfid-20170310_105246_522208_929684C2)
Subject: Re: [PATCH 1/4] patches: update crypto-ccm.patch for v4.11-rc1
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: backports@vger.kernel.org
Date: Fri, 10 Mar 2017 10:52:35 +0100
In-Reply-To: <b5a13b6c-6ed7-7682-2043-1dcc8ddfec79@broadcom.com> (sfid-20170310_104945_709577_B870A5E9)
References: <1489064253-3652-1-git-send-email-arend.vanspriel@broadcom.com>
         <1489064253-3652-2-git-send-email-arend.vanspriel@broadcom.com>
         <1489127672.3038.0.camel@sipsolutions.net>
         <b5a13b6c-6ed7-7682-2043-1dcc8ddfec79@broadcom.com>
         (sfid-20170310_104945_709577_B870A5E9)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2017-03-10 at 10:49 +0100, Arend Van Spriel wrote:
> 
> On 10-3-2017 7:34, Johannes Berg wrote:
> > On Thu, 2017-03-09 at 12:57 +0000, Arend van Spriel wrote:
> > > Since v4.11-rc1 the patch file for crypto/ccm.c, which is
> > > incorporated
> > > in the compat module, no longer applies. Update the patch file to
> > > fix
> > > the issue.
> > 
> > I think I want to get rid of this ccm thing entirely, any
> > objections?
> > As I remember, it doesn't actually work properly anyway.
> 
> No objection here. Does the same apply to skcipher stuff?

I think so, but not sure.

> > I suspect that if we really can't do anything else, we'd have to
> > provide a backport for all of crypto/, but I don't want to go there
> > and
> > would rather mandate that all the crypto things are enabled in the
> > base
> > kernel.
> 
> But that can only work when crypto api in base kernel and backport
> kernel are the same, right?

No, I meant adding all of crypto/ to copy-list and making sure *that*
works across kernels ...

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
