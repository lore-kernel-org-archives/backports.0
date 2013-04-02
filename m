Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:33692 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755618Ab3DBKZY (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 2 Apr 2013 06:25:24 -0400
Received: by mail-la0-f44.google.com with SMTP id eb20so234562lab.17
        for <backports@vger.kernel.org>; Tue, 02 Apr 2013 03:25:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1364888940.8204.1.camel@jlt4.sipsolutions.net>
References: <1364865614-31844-1-git-send-email-mcgrof@do-not-panic.com> <1364888940.8204.1.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 2 Apr 2013 03:25:02 -0700
Message-ID: <CAB=NE6XuzPq+JOWRLH=VPZ+MvX0T37ZNeYB3bduTEivECoio9Q@mail.gmail.com> (sfid-20130402_122526_986237_93B91842)
Subject: Re: [PATCH] compat: backport kernel dma-buf implementation
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>, sumit.semwal@linaro.org,
	rob.clark@linaro.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, Apr 2, 2013 at 12:49 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
>
>> dma-buf was added via commit d15bd7ee on v3.3 but completed
>> in a more sound fassion in later kernels, you should preferably
>> be at v3.5 a least, so we take the latest dma-buf implementation
>> and port it for usage on kernels [3.0-3.4]. We take the
>> implementation as of next-20130328.
>
> I'm curious about that approach -- I noticed it a few times already,
> e.g. with CONFIG_AVERAGE, however...
>
> If you don't mangle symbols (you don't), then wouldn't this cause
> linking errors when you try to load compat.ko on say kernel 3.0?

Did you see the usage of LINUX_BACKPORT() on the header file? That
would rename the exported symbols, and the header we carry makes sure
the kernel's original is not used, that means that our DRM code would
use our backport_*() symbols instead. Not sure, perhaps I'm missing
something?

  Luis
