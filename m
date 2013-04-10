Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:60615 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119Ab3DJROJ (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 10 Apr 2013 13:14:09 -0400
Received: by mail-lb0-f177.google.com with SMTP id r10so761909lbi.8
        for <backports@vger.kernel.org>; Wed, 10 Apr 2013 10:14:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1365600139.4235.4.camel@jlt4.sipsolutions.net>
References: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
 <1365593728-5720-7-git-send-email-mcgrof@do-not-panic.com> <1365600139.4235.4.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Wed, 10 Apr 2013 10:13:47 -0700
Message-ID: <CAB=NE6UpP-X1NCTNRnoSdv_bk3ioZdg5bO1zz0U0dqeWVxZdLw@mail.gmail.com> (sfid-20130410_191423_448632_0058185F)
Subject: Re: [PATCH 06/18] compat: backport ASYNC_DOMAIN_EXCLUSIVE()
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, Apr 10, 2013 at 6:22 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Wed, 2013-04-10 at 04:35 -0700, Luis R. Rodriguez wrote:
>> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
>>
>> For older kernels this is simply a matter of using
>> LIST_HEAD.
>
> Hmm, how is that useful if it will not have any effect?

The core of the handling is done in the internal asynch code and
that's kept hidden from the users of this -- so far.

  Luis
