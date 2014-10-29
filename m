Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:59119 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755636AbaJ2IXx (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 29 Oct 2014 04:23:53 -0400
Received: by mail-la0-f54.google.com with SMTP id gm9so2077432lab.27
        for <backports@vger.kernel.org>; Wed, 29 Oct 2014 01:23:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1414569744.1827.0.camel@jlt4.sipsolutions.net>
References: <0BA3FCBA62E2DC44AF3030971E174FB31B55873E@hasmsx107.ger.corp.intel.com>
 <CAB=NE6XBgHMNyLLS3wwYUh70sugbY0+YrKoBckk5O-tXF68t4Q@mail.gmail.com>
 <0BA3FCBA62E2DC44AF3030971E174FB31B5587F6@hasmsx107.ger.corp.intel.com>
 <CAB=NE6Wh=yhFnxbsTwKun2t8SCbatHYGNYb95sk5ro9qdVGn3A@mail.gmail.com> <1414569744.1827.0.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Wed, 29 Oct 2014 01:23:31 -0700
Message-ID: <CAB=NE6UTD9YqpbR3Cu0bmSf0iKyjgfUUGKFkCD49nMU12dfLig@mail.gmail.com> (sfid-20141029_092400_633178_444A4706)
Subject: Re: failure to build backports on ubuntu
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, Oct 29, 2014 at 1:02 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Tue, 2014-10-28 at 13:21 -0700, Luis R. Rodriguez wrote:
>
>> The kernel solution to this uses an internal kernel variables to
>> prefix flags for the linker,
>
> Can't we just figure out how the kernel derives that variable and do the
> same?

I had and it relies on an internal practice on flags, I don't recall
the details but I remember determining we'd have to do a major hack of
our own.

> After all, the kernel doesn't do magic ... not more than we do in
> backports anyway :)

I actually think this is a linker bug... but too lazy to prove it
other than my commit log on it.

  Luis
