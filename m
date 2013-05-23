Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:62297 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754087Ab3EWAnm (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 22 May 2013 20:43:42 -0400
Received: by mail-lb0-f176.google.com with SMTP id x10so2738163lbi.21
        for <backports@vger.kernel.org>; Wed, 22 May 2013 17:43:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1369224397.8207.8.camel@jlt4.sipsolutions.net>
References: <1369222478-30577-1-git-send-email-mcgrof@do-not-panic.com>
 <1369222478-30577-9-git-send-email-mcgrof@do-not-panic.com> <1369224397.8207.8.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Wed, 22 May 2013 17:43:20 -0700
Message-ID: <CAB=NE6Vd19quD99OmwPRq9prfR7uANmGg3i_qQLR7iRjDMY1Uw@mail.gmail.com> (sfid-20130523_024344_065738_FB2F736B)
Subject: Re: [PATCH 8/9] lib/bpkup.py: add or own kernel uploader helper lib
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, May 22, 2013 at 5:06 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Wed, 2013-05-22 at 04:34 -0700, Luis R. Rodriguez wrote:
>
>> +def put(tar_bz2=None, signed_tar=None, path=None):
>> +    cmd = ['kup', 'put', tar_bz2, signed_tar, path]
>
> Without even looking, the =None here can't be right since if you don't
> pass any of these args, it'll just get completely confused and probably
> crash trying to pass None as an argument? Seems you should just require
> all these args.

Sure, will make these changes, thanks.

  Luis
