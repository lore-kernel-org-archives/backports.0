Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:49684 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181Ab3DHUvq (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 8 Apr 2013 16:51:46 -0400
Received: by mail-la0-f50.google.com with SMTP id el20so1260835lab.23
        for <backports@vger.kernel.org>; Mon, 08 Apr 2013 13:51:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1365450036.25475.21.camel@jlt4.sipsolutions.net>
References: <1365416773-12836-9-git-send-email-thierry.escande@linux.intel.com>
 <CAB=NE6WWA4r+FyqR484ZJJm_usrCRDOjzMut-6JawNXJXUNmvw@mail.gmail.com>
 <1365449679.25475.18.camel@jlt4.sipsolutions.net> <CAB=NE6X6+M2-eUeqTv-PAJDQ_VaLwUv3n94J1YTR+4CK7YYdaw@mail.gmail.com>
 <1365450036.25475.21.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Date: Mon, 8 Apr 2013 13:51:25 -0700
Message-ID: <CAB=NE6XzZvJcGb4xLZN7QKrCiYDMN0JN=uU8VR5yGUkyWS9uTw@mail.gmail.com> (sfid-20130408_225149_844077_D315C252)
Subject: Re: [PATCH v3 8/8] build: add NFC defconfig file
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Thierry Escande <thierry.escande@linux.intel.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, Apr 8, 2013 at 12:40 PM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Mon, 2013-04-08 at 12:37 -0700, Luis R. Rodriguez wrote:
>
>> >> > +CPTCFG_NFC=m
> [...]
>> >> Johannes, do we want to be disabling the other subsystems in these ?
>> >
>> > Well anything not listed will have the default values, so that should be
>> > OK, right? Most things should be default off.
>>
>> OK so the default would be -- "if you have it on your kernel then
>> we'll enable at build time", is that right? I wasn't clear on this,
>> that's all.
>
> No, because of the prefix rename (CONFIG_ -> CPTCFG_) the kernel's
> configuration has no influence on our configuration at all.
>
> So the default is just whatever the default is in the Kconfig files,
> which is essentially everything else turned off.

Odd, when I tried to do media with similar defconfig I got wireless
building :( but its great this was the goal, I'll try again.

  Luis
