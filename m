Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:47124 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755216AbaKOBVm (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 14 Nov 2014 20:21:42 -0500
Received: by mail-lb0-f182.google.com with SMTP id f15so14756713lbj.41
        for <backports@vger.kernel.org>; Fri, 14 Nov 2014 17:21:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1414740556.3014.0.camel@jlt4.sipsolutions.net>
References: <1414568971-13987-1-git-send-email-emmanuel.grumbach@intel.com>
 <CAB=NE6WiR0SnfQxr36wPFnA=xbbJR8-sGFS_kexrAoyt45qvug@mail.gmail.com>
 <0BA3FCBA62E2DC44AF3030971E174FB31B55A15A@hasmsx107.ger.corp.intel.com>
 <1414680732.1823.8.camel@jlt4.sipsolutions.net> <CAB=NE6XuLCtFMtEYvaFHV2okFhJEXbWH3Y0LuJ43g+w5SZWSsg@mail.gmail.com>
 <1414698595.1823.9.camel@jlt4.sipsolutions.net> <1414699706.1823.10.camel@jlt4.sipsolutions.net>
 <CAB=NE6Uz0ASc4VM=+pdHdLhM3_8OzZjOc08bBevtcG_r2hWc5Q@mail.gmail.com> <1414740556.3014.0.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Fri, 14 Nov 2014 17:21:20 -0800
Message-ID: <CAB=NE6X+1FQvjb2jKb6hXG23AxyXxmecedpUVJCijMBCvDC_VA@mail.gmail.com> (sfid-20141115_022144_813117_502B6800)
Subject: Re: [PATCH] backports: fix mconf compilation on Ubuntu
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, Oct 31, 2014 at 12:29 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Thu, 2014-10-30 at 14:24 -0700, Luis R. Rodriguez wrote:
>
>> > http://p.sipsolutions.net/0e9267afce20addd.txt
>>
>> IIRC my concern was over the usage of HOSTLOADLIBES_ stuff but you
>> seem to have worked around that, lets try this way then.
>
> Yeah but that's just appended to the CC command line in the kernel, if
> you follow the various Makefiles. And HOSTLOADLIBES is empty for this
> Makefile, so I cut down the maze of definitions to the change above.

Mended and pushed.

 Luis
