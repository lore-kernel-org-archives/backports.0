Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:44313 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934566Ab3FSVzl (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 19 Jun 2013 17:55:41 -0400
Received: by mail-lb0-f169.google.com with SMTP id d10so5208993lbj.14
        for <backports@vger.kernel.org>; Wed, 19 Jun 2013 14:55:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJqaZwz41Gcu681+3RAcZ0Or7ySXd+R9ZDOsVRS0h2k+CQbJ1Q@mail.gmail.com>
References: <CAJqaZwyhCxQRqEQ8wKjD96u0avs3Qjjda2u_oxTb3y-Vj7ie8g@mail.gmail.com>
 <CAB=NE6V0so0NDQs1z2SCes9G6_jg0gKtM3Yjq6yyjzQ8gdRVOg@mail.gmail.com> <CAJqaZwz41Gcu681+3RAcZ0Or7ySXd+R9ZDOsVRS0h2k+CQbJ1Q@mail.gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Wed, 19 Jun 2013 14:55:19 -0700
Message-ID: <CAB=NE6WLdXzWDn+iu9WVcJdLNoef55XDWMGLpjRVCLksaw3uWA@mail.gmail.com> (sfid-20130619_235543_101628_2D1BEE60)
Subject: Re: [PATCH] backports: re-introduce make uninstall
To: ASIC Felix <ic.felix@gmail.com>
Cc: do-not <mcgrof@kernel.org>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sat, Jun 15, 2013 at 4:37 PM, ASIC Felix <ic.felix@gmail.com> wrote:
>>> +for driver in $(find -type f -name *.ko); do
>>
>> and here perhaps you forgot to apply the extension, and perhaps best
>> to just peg the path in the find from the start, otherwise we end up
>> removing other kernel's updates as well:
>
> I may be missing something. IMO the correct list of modules to
> uninstall is the compiled *.ko in the unpacked tarball,

Correct.

> and these are never compressed.

They are upon make install for distros that use compression.

> The delete location is $KLIB/updates where make
> install copied them to. If applied compression was on $KLIB/updates as
> well.

Right, so the modules would be compressed if on on $KLIB/updates. Keep
in mind "updates" can be changed to something else, and hence the
usage of a variable for it.

  Luis
