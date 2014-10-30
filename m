Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:47156 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759470AbaJ3TuA (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 30 Oct 2014 15:50:00 -0400
Message-ID: <1414698595.1823.9.camel@jlt4.sipsolutions.net> (sfid-20141030_205005_438044_6CF53457)
Subject: Re: [PATCH] backports: fix mconf compilation on Ubuntu
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Thu, 30 Oct 2014 20:49:55 +0100
In-Reply-To: <CAB=NE6XuLCtFMtEYvaFHV2okFhJEXbWH3Y0LuJ43g+w5SZWSsg@mail.gmail.com> (sfid-20141030_173627_657531_6E4113C7)
References: <1414568971-13987-1-git-send-email-emmanuel.grumbach@intel.com>
	 <CAB=NE6WiR0SnfQxr36wPFnA=xbbJR8-sGFS_kexrAoyt45qvug@mail.gmail.com>
	 <0BA3FCBA62E2DC44AF3030971E174FB31B55A15A@hasmsx107.ger.corp.intel.com>
	 <1414680732.1823.8.camel@jlt4.sipsolutions.net>
	 <CAB=NE6XuLCtFMtEYvaFHV2okFhJEXbWH3Y0LuJ43g+w5SZWSsg@mail.gmail.com>
	 (sfid-20141030_173627_657531_6E4113C7)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 2014-10-30 at 09:36 -0700, Luis R. Rodriguez wrote:
> On Thu, Oct 30, 2014 at 7:52 AM, Johannes Berg
> <johannes@sipsolutions.net> wrote:
> > On Thu, 2014-10-30 at 14:36 +0000, Grumbach, Emmanuel wrote:
> >
> >> +GCC_VERSION=$(shell gcc --version | head -1 | awk '{print $4}')
> >> +ifeq ($(GCC_VERSION), 4.8.2)
> >
> > Luis, I can't really figure out why you think the *compiler* version
> > matters? Maybe the linker version, but ...?
> 
> You're right, and that's provided by libc. Well any other ideas?

The only difference I can really find is that somehow we don't use the
CFLAGS correctly from check-lxdialog.sh?

johannes

