Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:55831 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752996Ab3H0PuH (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 27 Aug 2013 11:50:07 -0400
Message-ID: <1377618602.20012.10.camel@jlt4.sipsolutions.net> (sfid-20130827_175008_853745_9D7482F0)
Subject: Re: [RFC] remove support for kernel 2.6.24
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Tue, 27 Aug 2013 17:50:02 +0200
In-Reply-To: <CAB=NE6VBhHkfFPd-kBKfscy2P=EVQ7jNevYQ5nVU2y_aFsCP-Q@mail.gmail.com> (sfid-20130827_174912_167400_D3372A9F)
References: <1377258238-3880-1-git-send-email-johannes@sipsolutions.net>
	 <CAB=NE6VBhHkfFPd-kBKfscy2P=EVQ7jNevYQ5nVU2y_aFsCP-Q@mail.gmail.com>
	 (sfid-20130827_174912_167400_D3372A9F)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2013-08-27 at 08:48 -0700, Luis R. Rodriguez wrote:
> On Fri, Aug 23, 2013 at 4:43 AM, Johannes Berg
> <johannes@sipsolutions.net> wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> >
> > By requiring 2.6.25 we can get rid of quite a lot of backport work.
> > 2.6.25 was released more than five years ago (April 2011) and wasn't
> > a long-term kernel either, so there's little point in supporting it
> > now.
> >
> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> 
> I'm fine with this, please feel free to send as patch form unless you
> want me to just accept it as is, I'd test compile it before
> integration into the public tree.

I think it's ok, the [rfc] was more for the fact of removing it rather
than the contents.

johannes

