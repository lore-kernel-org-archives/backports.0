Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:64889 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934814AbaJ3VZV (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 30 Oct 2014 17:25:21 -0400
Received: by mail-la0-f51.google.com with SMTP id q1so5180962lam.10
        for <backports@vger.kernel.org>; Thu, 30 Oct 2014 14:25:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1414699706.1823.10.camel@jlt4.sipsolutions.net>
References: <1414568971-13987-1-git-send-email-emmanuel.grumbach@intel.com>
 <CAB=NE6WiR0SnfQxr36wPFnA=xbbJR8-sGFS_kexrAoyt45qvug@mail.gmail.com>
 <0BA3FCBA62E2DC44AF3030971E174FB31B55A15A@hasmsx107.ger.corp.intel.com>
 <1414680732.1823.8.camel@jlt4.sipsolutions.net> <CAB=NE6XuLCtFMtEYvaFHV2okFhJEXbWH3Y0LuJ43g+w5SZWSsg@mail.gmail.com>
 <1414698595.1823.9.camel@jlt4.sipsolutions.net> <1414699706.1823.10.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Thu, 30 Oct 2014 14:24:59 -0700
Message-ID: <CAB=NE6Uz0ASc4VM=+pdHdLhM3_8OzZjOc08bBevtcG_r2hWc5Q@mail.gmail.com> (sfid-20141030_222523_718133_F9B0193E)
Subject: Re: [PATCH] backports: fix mconf compilation on Ubuntu
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, Oct 30, 2014 at 1:08 PM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Thu, 2014-10-30 at 20:49 +0100, Johannes Berg wrote:
>> On Thu, 2014-10-30 at 09:36 -0700, Luis R. Rodriguez wrote:
>> > On Thu, Oct 30, 2014 at 7:52 AM, Johannes Berg
>> > <johannes@sipsolutions.net> wrote:
>> > > On Thu, 2014-10-30 at 14:36 +0000, Grumbach, Emmanuel wrote:
>> > >
>> > >> +GCC_VERSION=$(shell gcc --version | head -1 | awk '{print $4}')
>> > >> +ifeq ($(GCC_VERSION), 4.8.2)
>> > >
>> > > Luis, I can't really figure out why you think the *compiler* version
>> > > matters? Maybe the linker version, but ...?
>> >
>> > You're right, and that's provided by libc. Well any other ideas?
>>
>> The only difference I can really find is that somehow we don't use the
>> CFLAGS correctly from check-lxdialog.sh?
>
> Well, why don't we do it like the kernel does?
>
> http://p.sipsolutions.net/0e9267afce20addd.txt

IIRC my concern was over the usage of HOSTLOADLIBES_ stuff but you
seem to have worked around that, lets try this way then.

 Luis
