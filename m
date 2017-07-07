Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:36780 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751659AbdGGJjU (ORCPT <rfc822;backports@vger.kernel.org>);
        Fri, 7 Jul 2017 05:39:20 -0400
Message-ID: <1499420358.4790.3.camel@sipsolutions.net> (sfid-20170707_113923_008599_4AD6D907)
Subject: Re: Kernel specific branches question
From: Johannes Berg <johannes@sipsolutions.net>
To: Dan Kephart <Dan.Kephart@lairdtech.com>,
        "backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Fri, 07 Jul 2017 11:39:18 +0200
In-Reply-To: <DM5PR02MB3226F1449C47813CBB5BC198E9D60@DM5PR02MB3226.namprd02.prod.outlook.com>
References: <921F8F57-F9B2-431F-828D-C2D86292ED94@lairdtech.com>
         (sfid-20170627_220738_057277_8F491788),<1498636073.12531.5.camel@sipsolutions.net>
         <DM5PR02MB3226F1449C47813CBB5BC198E9D60@DM5PR02MB3226.namprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi Dan,

> > However, this is pretty different from how most other people seem
> > to work?
> > Since kernel releases are sort of ephemeral, and drivers are
> > continually developed along with the kernel, we typically see usage
> > more of "latest backport + latest kernel" to get to "latest driver
> > for use on any kernel".
> 
> I think only wireless module vendors would have our use case.  Just
> to elaborate a bit more.  We sell several system on modules
> with 802.11 and bluetooth combo modules. We also sell the wireless
> combo modules separately in a variety of form factors for
> integrating into other systems. We jump the kernels on those SOMs to
> the latest LTS kernel when released.  We do all our wireless module
> bring up, debugging, baseline, and QA testing of those wireless
> modules using LTS kernels using our SOMs.  To support software
> releases for those wireless only modules we use backports on those
> SOMs kernel to release a driver that builds for many different
> kernels and rely on the QA testing that pertains to the wireless
> module on the SOM.  This backports tarball is released with
> the firmware and the wpa_supplicant that was used during this
> QA process.  If a specific major release works well for the customer,
> they may stay on this release and only want a bug fix or two.  
> We continually move forward with new releases but maintain those
> older releases for customers if required.

Well, I work for Intel, so we're a wireless (module) vendor too :-)

But yeah - we do things differently - we don't even really support the
upstream LTS releases or kernels per se, for product work we *only*
support our backports-based "core release" tree, which is also where we
do all of our development. This branches off from wherever we're at
wrt. upstream and/or our driver development, and then we stabilize
that. It's always (intended to be) stable enough so that this
stabilization doesn't take all that much time.

Anyway, I see what you're doing, and it seems like a reasonable thing
to do.

> > Additionally, backports for a fixed kernel version like 4.9 really
> > should be pretty stable, so once you have it, it shouldn't really
> > need to change? So it seems to me like a tag on master would be
> > sufficient.
> 
> I agree this really is all we would need.

We'd still have to get to a point where we can churn those out - I
think automation could help here, to maintain the "linus" branch of the
backports tree we can "gentree" it every night or so, send a warning if
that breaks, or run ckmake to make sure it still builds against all the
other trees.
This would be the generic "make sure it applies/builds" part.

In addition, everyone else who has skin in the game could contribute a
cron job that every night does the same steps, but also runs some tests
when  If this gets tagged in the repo or so everyone could even easily
pull it down and run some tests on it for their specific driver/etc.

> > Now, we're not actually doing a good job of following any of
> > upstream,
> > linux-next or wireless-testing with backports right now - we should
> > probably pick one of those, or multiple of those, and create
> > branches
> > in the backports.git for each one of those, rather than having a
> > "master" branch.
> 
> My preference would be linux-next, but it would be interesting to
> have both.

My priority order would be somewhere along the lines of

 * Linus's tree
 * linux-next
 * wireless-testing

though most users probably actually want exactly the other way around
;-) But this is what helps us most for our development.

Once we have the setup, we can probably deal with having three branches
- linux-next would have to get the fixes first, then they'd percolate
to wireless-testing, and eventually to the "linus" branch.


I already have a task ticket for me to look at all of this when I
return, but I'm happy if you want to do anything along these lines in
the meantime. I don't think it should be very difficult.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
