Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:58160 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933805Ab3E1Vek (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 28 May 2013 17:34:40 -0400
Message-ID: <1369776874.8548.31.camel@jlt4.sipsolutions.net> (sfid-20130528_233447_054806_A943B270)
Subject: Re: [PATCH] backports: catch make in backport template directory
From: Johannes Berg <johannes@sipsolutions.net>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: backports@vger.kernel.org
Date: Tue, 28 May 2013 23:34:34 +0200
In-Reply-To: <51A51E0E.8010803@lwfinger.net> (sfid-20130528_231354_988207_BF6CF854)
References: <1369773194-17379-1-git-send-email-johannes@sipsolutions.net>
	 <51A51E0E.8010803@lwfinger.net> (sfid-20130528_231354_988207_BF6CF854)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2013-05-28 at 16:13 -0500, Larry Finger wrote:
> On 05/28/2013 03:33 PM, Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> >
> > Catch running make in the backport template directory by
> > checking for the .local-symbols file. If it isn't there
> > then we're in the input/template directory rather than in
> > an output tree, give the user a hint about it instead of
> > keeling over.
> >
> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> > ---
> >   backport/Makefile | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> >
> > diff --git a/backport/Makefile b/backport/Makefile
> > index 287b27d..f0c7586 100644
> > --- a/backport/Makefile
> > +++ b/backport/Makefile
> > @@ -37,6 +37,18 @@ mrproper:
> >   	@rm -f backport-include/backport/autoconf.h
> >
> >   .DEFAULT:
> > +	@set -e ; test -f .local-symbols || (						\
> > +	echo "/--------------"								;\
> > +	echo "| You shouldn't run make in the backports tree, but only in"		;\
> > +	echo "| the generated output. This here is only the skeleton code"		;\
> > +	echo "| copied into the output directory. To use the backport system"		;\
> > +	echo "| from scratch, go into the top-level directoroy and run"			;\
> 
> =======================================================^ Typo here.

Good catch, thanks. Luis, can you just fix that when you apply or do you
want a resend?

johannes

