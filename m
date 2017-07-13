Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59622 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751017AbdGMR2Q (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 13 Jul 2017 13:28:16 -0400
Date: Thu, 13 Jul 2017 19:28:14 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: AceLan Kao <acelan.kao@canonical.com>,
        Johannes Berg <johannes.berg@intel.com>, hauke@hauke-m.de,
        mcgrof@kernel.org, backports@vger.kernel.org,
        Anthony Wong <anthony.wong@canonical.com>
Subject: Re: Adding the BT driver
Message-ID: <20170713172814.GB21846@wotan.suse.de> (sfid-20170713_192818_543895_BA9B89C2)
References: <CAFv23QnvFGj3b2GCV=v=mGk8JgGwZRe+W-+m9gxbtAsChySz=Q@mail.gmail.com>
 <59673BA0.20703@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <59673BA0.20703@broadcom.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, Jul 13, 2017 at 11:21:36AM +0200, Arend van Spriel wrote:
> On 7/13/2017 5:07 AM, AceLan Kao wrote:
> > Hi all,
> > 
> > I'm working on adding BT driver back to linux backport driver, and got
> > some questions.
> 
> I suppose it means you also want to maintain BT support in backports
> project?

Which has me thinking perhaps the policy we need is a MAINTAINERS.backport file
or something?

> > 1. Do we still do building the backport driver against all the
> > supported kernels? I didn't see those reports in git log recently, so
> > I'm wondering while backporting BT driver, can I skip some old
> > kernels' support.
> 
> Well. You could limit the earliest kernel by adding a dependency in the
> dependencies file.
> 
> > 2. Is there a script that can help me to build the backport driver
> > against certain kernels?
> 
> Not really. You just run make from the backports package and provide
> KLIB_BUILD=... on the command line referring to the target kernel headers.

There is documentation:

https://backports.wiki.kernel.org/index.php/Documentation/backports/hacking#Adding_new_driver

I updated it recently as I demo'd adding yet-another new subsystem (not
upstream, nor patches posted).

  Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
