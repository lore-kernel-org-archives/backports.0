Return-path: <backports-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:37148 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756345AbbE2RgP (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 29 May 2015 13:36:15 -0400
Date: Fri, 29 May 2015 13:36:09 -0400
From: Theodore Ts'o <tytso@mit.edu>
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: "Enrico Weigelt, metux IT consult" <weigelt@melag.de>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: Uses of Linux backports in the industry
Message-ID: <20150529173609.GF18540@thunk.org> (sfid-20150529_193629_438206_A9232E8A)
References: <CAB=NE6UUTmMMB0La3OFe+hXpaZzdAwTs0QKBsTLSyrsSMFxJRg@mail.gmail.com>
 <55687D72.3070904@melag.de>
 <CAFLxGvz1-2sm74dmWZ4QpyC4TSubP4OHj=6Z8aVhvjqA2+WkZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAFLxGvz1-2sm74dmWZ4QpyC4TSubP4OHj=6Z8aVhvjqA2+WkZw@mail.gmail.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, May 29, 2015 at 05:01:00PM +0200, Richard Weinberger wrote:
> On Fri, May 29, 2015 at 4:53 PM, Enrico Weigelt, metux IT consult
> <weigelt@melag.de> wrote:
> > Am 29.05.2015 um 04:54 schrieb Luis R. Rodriguez:
> > Actually, I really wonder why folks are sticking to ancient kernels on
> > newer hardware.
> 
> Enterprise distribution kernels. Or "special" kernels like PREEMPT_RT.
> Sometimes the vendor BSP is that horrid that a customer cannot afford
> to forward port it
> but wants recent stuff. So you need to backport...

Yep.  The technique I used for the backporting ext4 encryption into
the 3.10 android-common git tree in AOSP was to drop in the 3.18
versions of fs/ext4 and fs/jbd2 into the 3.10 tree (along with the
associaed include files in include/linux and include/trace/events, of
course), and then fix things up until they built correctly (using
cherry-picks and in some cases, reverting some changes in the 3.18
version of fs/ext4).  After I was sure the transplant of the 3.18
version of ext4 had "taken" correctly, with no test regressions, only
then did I cherry-pick all of the ext4 encryption changes on top of
3.10.

The backport of ext4 encryption to the 3.18 version of android-common
should be much easier.  :-)   Unfortunately, I also have to do a
backport to the 3.14 android-common branch as well.   <sigh>

Yes, it's ugly, but there still are some SOC and drivers that aren't
available on newer kernels.  Basically, the handset vendors need to
lean a lot harder on the SOC and other peripheral (cell radios, GPS,
etc., etc.).  :-(

    	  	     	   	   	      - Ted
