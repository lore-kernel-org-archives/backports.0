Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:37980 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757167AbbE2RwJ (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 29 May 2015 13:52:09 -0400
MIME-Version: 1.0
In-Reply-To: <20150529173609.GF18540@thunk.org>
References: <CAB=NE6UUTmMMB0La3OFe+hXpaZzdAwTs0QKBsTLSyrsSMFxJRg@mail.gmail.com>
 <55687D72.3070904@melag.de> <CAFLxGvz1-2sm74dmWZ4QpyC4TSubP4OHj=6Z8aVhvjqA2+WkZw@mail.gmail.com>
 <20150529173609.GF18540@thunk.org>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Fri, 29 May 2015 10:51:48 -0700
Message-ID: <CAB=NE6VX_Op5O7Xu5xZcqwWsCCfHO-VauuJyGguV5b5EJC05Cw@mail.gmail.com> (sfid-20150529_195214_147583_FDCB95BA)
Subject: Re: Uses of Linux backports in the industry
To: "Theodore Ts'o" <tytso@mit.edu>,
	Richard Weinberger <richard.weinberger@gmail.com>,
	"Enrico Weigelt, metux IT consult" <weigelt@melag.de>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Julia Lawall <julia.lawall@lip6.fr>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, May 29, 2015 at 10:36 AM, Theodore Ts'o <tytso@mit.edu> wrote:
> On Fri, May 29, 2015 at 05:01:00PM +0200, Richard Weinberger wrote:
>> On Fri, May 29, 2015 at 4:53 PM, Enrico Weigelt, metux IT consult
>> <weigelt@melag.de> wrote:
>> > Am 29.05.2015 um 04:54 schrieb Luis R. Rodriguez:

Just to clarify the original goal was to hear how folks use the Linux
backports project out there in the industry for purposes of the paper
being edited, hearing how folks might do their own backports is
certainly useful but I am also in hopes they might consider using
Linux backports for future work to help, well automatically backport
Linux.

>> > Actually, I really wonder why folks are sticking to ancient kernels on
>> > newer hardware.
>>
>> Enterprise distribution kernels. Or "special" kernels like PREEMPT_RT.
>> Sometimes the vendor BSP is that horrid that a customer cannot afford
>> to forward port it
>> but wants recent stuff. So you need to backport...
>
> Yep.  The technique I used for the backporting ext4 encryption into
> the 3.10 android-common git tree in AOSP was to drop in the 3.18
> versions of fs/ext4 and fs/jbd2 into the 3.10 tree (along with the
> associaed include files in include/linux and include/trace/events, of
> course), and then fix things up until they built correctly (using
> cherry-picks and in some cases, reverting some changes in the 3.18
> version of fs/ext4).  After I was sure the transplant of the 3.18
> version of ext4 had "taken" correctly, with no test regressions, only
> then did I cherry-pick all of the ext4 encryption changes on top of
> 3.10.

FWIW, if the Linux backports project started carrying ext4 into it,
you'd likely have less work to do and we'd enable use of ext4 to be
used on the range of supported kernels.

> The backport of ext4 encryption to the 3.18 version of android-common
> should be much easier.  :-)   Unfortunately, I also have to do a
> backport to the 3.14 android-common branch as well.   <sigh>
>
> Yes, it's ugly, but there still are some SOC and drivers that aren't
> available on newer kernels.  Basically, the handset vendors need to
> lean a lot harder on the SOC and other peripheral (cell radios, GPS,
> etc., etc.).  :-(

Yeah we dealt with a lot of those dependencies when backporting the
regulator subsystem for Media drivers, it was hard but hey we did
quite a bit of the work. Now that we have in-kernel integration
support the options on what to backport should be easier [1].

[1] https://backports.wiki.kernel.org/index.php/Documentation/integration

 Luis
