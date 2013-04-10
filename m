Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:59074 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765136Ab3DJRK5 (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 10 Apr 2013 13:10:57 -0400
Received: by mail-lb0-f178.google.com with SMTP id q13so756804lbi.23
        for <backports@vger.kernel.org>; Wed, 10 Apr 2013 10:10:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1365599899.8388.17.camel@jlt4.sipsolutions.net>
References: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
 <1365593728-5720-6-git-send-email-mcgrof@do-not-panic.com> <1365599899.8388.17.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Wed, 10 Apr 2013 10:10:35 -0700
Message-ID: <CAB=NE6UOzkA8NaCbmSmmnXUe3oYwHYx73hfcumnb8o0Sj=mLsQ@mail.gmail.com> (sfid-20130410_191102_038174_F2666087)
Subject: Re: [PATCH 05/18] compat: backport GPIOF_OPEN_DRAIN definition
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, Apr 10, 2013 at 6:18 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Wed, 2013-04-10 at 04:35 -0700, Luis R. Rodriguez wrote:
>> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
>>
>> This functionality will just be ignored, later we'll
>> just port the full gpiolib.
>
> That seems a bit dangerous? If the driver expects to be able to set the
> pin this way, do we really want to stop it?

Yes, thanks I forgot to drop this. Thanks for the review.

  Luis
