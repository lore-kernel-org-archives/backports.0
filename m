Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:50262 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751412AbaJaH3V (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 31 Oct 2014 03:29:21 -0400
Message-ID: <1414740556.3014.0.camel@jlt4.sipsolutions.net> (sfid-20141031_082923_559146_B872B1A5)
Subject: Re: [PATCH] backports: fix mconf compilation on Ubuntu
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Fri, 31 Oct 2014 08:29:16 +0100
In-Reply-To: <CAB=NE6Uz0ASc4VM=+pdHdLhM3_8OzZjOc08bBevtcG_r2hWc5Q@mail.gmail.com> (sfid-20141030_222521_395659_881F5EBE)
References: <1414568971-13987-1-git-send-email-emmanuel.grumbach@intel.com>
	 <CAB=NE6WiR0SnfQxr36wPFnA=xbbJR8-sGFS_kexrAoyt45qvug@mail.gmail.com>
	 <0BA3FCBA62E2DC44AF3030971E174FB31B55A15A@hasmsx107.ger.corp.intel.com>
	 <1414680732.1823.8.camel@jlt4.sipsolutions.net>
	 <CAB=NE6XuLCtFMtEYvaFHV2okFhJEXbWH3Y0LuJ43g+w5SZWSsg@mail.gmail.com>
	 <1414698595.1823.9.camel@jlt4.sipsolutions.net>
	 <1414699706.1823.10.camel@jlt4.sipsolutions.net>
	 <CAB=NE6Uz0ASc4VM=+pdHdLhM3_8OzZjOc08bBevtcG_r2hWc5Q@mail.gmail.com>
	 (sfid-20141030_222521_395659_881F5EBE)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 2014-10-30 at 14:24 -0700, Luis R. Rodriguez wrote:

> > http://p.sipsolutions.net/0e9267afce20addd.txt
> 
> IIRC my concern was over the usage of HOSTLOADLIBES_ stuff but you
> seem to have worked around that, lets try this way then.

Yeah but that's just appended to the CC command line in the kernel, if
you follow the various Makefiles. And HOSTLOADLIBES is empty for this
Makefile, so I cut down the maze of definitions to the change above.

johannes

