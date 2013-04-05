Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:42008 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250Ab3DEJoc (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 5 Apr 2013 05:44:32 -0400
Message-ID: <1365155062.8515.0.camel@jlt4.sipsolutions.net> (sfid-20130405_114436_122683_A7BDA4EE)
Subject: Re: [PATCH 2/2] more symbol fixup needed for latest RHEL6.3 kernels
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Cc: Andy Gospodarek <andy@greyhouse.net>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Fri, 05 Apr 2013 11:44:22 +0200
In-Reply-To: <CAB=NE6W=jxCkbUoLOMEV-G+H=tcgMFeP0GBzmowB+O019KFUpQ@mail.gmail.com> (sfid-20130405_044628_682862_FAA5DE26)
References: <1365127487-30058-1-git-send-email-andy@greyhouse.net>
	 <1365127487-30058-2-git-send-email-andy@greyhouse.net>
	 <CAB=NE6W=jxCkbUoLOMEV-G+H=tcgMFeP0GBzmowB+O019KFUpQ@mail.gmail.com>
	 (sfid-20130405_044628_682862_FAA5DE26)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 2013-04-04 at 19:46 -0700, Luis R. Rodriguez wrote:
> On Thu, Apr 4, 2013 at 7:04 PM, Andy Gospodarek <andy@greyhouse.net> wrote:
> > These changes will allow compat.ko to load properly on the latest released
> > RHEL6.3 errata kernels.
> >
> > Reported here: https://bugzilla.kernel.org/show_bug.cgi?id=55971
> >
> > Signed-off-by: Andy Gospodarek <andy@greyhouse.net>
> 
> Thanks! Can you port these over to Johannes' backports tree ? I've
> frozen development on compat / compat-drivers as we transition over. I
> will be sure to merge fixes for stable releases that were already
> depending on compat / compat-drivers, these however seem to be
> development window fixes.

It's ok, I just had to fix up the paths a bit and then the patches
applied just fine.

johannes

