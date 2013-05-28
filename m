Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:51523 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758606Ab3E1WLO (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 28 May 2013 18:11:14 -0400
Received: by mail-wg0-f42.google.com with SMTP id n12so3561449wgh.1
        for <backports@vger.kernel.org>; Tue, 28 May 2013 15:11:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1369776874.8548.31.camel@jlt4.sipsolutions.net>
References: <1369773194-17379-1-git-send-email-johannes@sipsolutions.net>
 <51A51E0E.8010803@lwfinger.net> <1369776874.8548.31.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Date: Tue, 28 May 2013 15:10:53 -0700
Message-ID: <CAB=NE6W0BkpYQNq+jm1JXNmzN-AkOedGXqz+GJ9oe=-=EVL5VQ@mail.gmail.com> (sfid-20130529_001116_884651_A156DDD1)
Subject: Re: [PATCH] backports: catch make in backport template directory
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, May 28, 2013 at 2:34 PM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Tue, 2013-05-28 at 16:13 -0500, Larry Finger wrote:
>> On 05/28/2013 03:33 PM, Johannes Berg wrote:
>> > From: Johannes Berg <johannes.berg@intel.com>
>> >
>> > Catch running make in the backport template directory by
>> > checking for the .local-symbols file. If it isn't there
>> > then we're in the input/template directory rather than in
>> > an output tree, give the user a hint about it instead of
>> > keeling over.
>> >
>> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>> > ---
>> >   backport/Makefile | 12 ++++++++++++
>> >   1 file changed, 12 insertions(+)
>> >
>> > diff --git a/backport/Makefile b/backport/Makefile
>> > index 287b27d..f0c7586 100644
>> > --- a/backport/Makefile
>> > +++ b/backport/Makefile
>> > @@ -37,6 +37,18 @@ mrproper:
>> >     @rm -f backport-include/backport/autoconf.h
>> >
>> >   .DEFAULT:
>> > +   @set -e ; test -f .local-symbols || (                                           \
>> > +   echo "/--------------"                                                          ;\
>> > +   echo "| You shouldn't run make in the backports tree, but only in"              ;\
>> > +   echo "| the generated output. This here is only the skeleton code"              ;\
>> > +   echo "| copied into the output directory. To use the backport system"           ;\
>> > +   echo "| from scratch, go into the top-level directoroy and run"                 ;\
>>
>> =======================================================^ Typo here.
>
> Good catch, thanks. Luis, can you just fix that when you apply or do you
> want a resend?

I've fixed it prior to applying. Thanks, applied and pushed!

  Luis
