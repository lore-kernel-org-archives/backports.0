Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:60501 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237Ab3FOXhp (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 15 Jun 2013 19:37:45 -0400
Received: by mail-la0-f44.google.com with SMTP id er20so1475555lab.3
        for <backports@vger.kernel.org>; Sat, 15 Jun 2013 16:37:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAB=NE6V0so0NDQs1z2SCes9G6_jg0gKtM3Yjq6yyjzQ8gdRVOg@mail.gmail.com>
References: <CAJqaZwyhCxQRqEQ8wKjD96u0avs3Qjjda2u_oxTb3y-Vj7ie8g@mail.gmail.com>
	<CAB=NE6V0so0NDQs1z2SCes9G6_jg0gKtM3Yjq6yyjzQ8gdRVOg@mail.gmail.com>
Date: Sat, 15 Jun 2013 16:37:43 -0700
Message-ID: <CAJqaZwz41Gcu681+3RAcZ0Or7ySXd+R9ZDOsVRS0h2k+CQbJ1Q@mail.gmail.com> (sfid-20130616_013750_634234_1B06579B)
Subject: Re: [PATCH] backports: re-introduce make uninstall
From: ASIC Felix <ic.felix@gmail.com>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: do-not <mcgrof@kernel.org>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Thanks for the feedback!

> This is used twice now in two scripts as such perhaps best to stuff
> this as a helper in a new file of script helpers,
> scripts/mod_helpers.sh and then both this file and
> scripts/compress_modules.sh would just:
>
> source ./mod_helpers.sh

Will do.

>> +if test "$(mod_filename mac80211)" = "mac80211.ko.gz" ; then
>> +    compr=".ko"
>
> I think what was meant is compr=".gz"

Right.

>> +for driver in $(find -type f -name *.ko); do
>
> and here perhaps you forgot to apply the extension, and perhaps best
> to just peg the path in the find from the start, otherwise we end up
> removing other kernel's updates as well:

I may be missing something. IMO the correct list of modules to
uninstall is the compiled *.ko in the unpacked tarball, and these are
never compressed. The delete location is $KLIB/updates where make
install copied them to. If applied compression was on $KLIB/updates as
well.

Felix
