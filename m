Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <noelamac@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20130327175711.GA8794@stt008.linux.site>
References: <CAKprTDHpf0PgisfJK9bJOYgYxLU5PRLNtbkg7V6Zj2s=gVVMCA@mail.gmail.com>
	<CAB=NE6Wbym4XksV=uKz9eZD0rZwmtS3ZfP-zbXg9TAc2+2+Z9g@mail.gmail.com>
	<CAKprTDEEEdy++Bk5AY4Zfrtwsc9HOKGQ+uWR58PFCWU=v+PE1g@mail.gmail.com>
	<CAB=NE6UtuxuTduYhDy5BcPap-rri+P1mcKYr2KEjAbuE2FU13g@mail.gmail.com>
	<20130327175711.GA8794@stt008.linux.site>
Date: Thu, 28 Mar 2013 10:02:24 +0100
Message-ID: <CAKprTDFspW4B2tk9EZPBBXy3C6gL_NJsjwj-bUeYj1rN3j6sYg@mail.gmail.com>
Subject: Re: brcmsmac: Unknown symbol backport_cordic_calc_iq (err 0)
From: =?ISO-8859-1?Q?Camale=F3n?= <noelamac@gmail.com>
To: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <backports@vger.kernel.org>

2013/3/27 Camale=F3n <noelamac@gmail.com>:
> El 2013-03-27 a las 09:41 -0700, Luis R. Rodriguez escribi=F3:
>
>> On Wed, Mar 27, 2013 at 8:28 AM, Camale=F3n <noelamac@gmail.com> wrote:
>> > 2013/3/27 Luis R. Rodriguez <mcgrof@frijolero.org>:
>> >> On Tue, Mar 26, 2013 at 8:23 AM, Camale=F3n <noelamac@gmail.com> wrot=
e:
>> >>> https://www.kernel.org/pub/linux/kernel/projects/backports/2013/03/2=
2/compat-drivers-2013-03-22-u.tar.bz2
>> >>
>> >> Thanks for reporting this, this should now be fixed, please try today=
's release.
>> >
>> > Thanks Luis, this one prints no error when loading but it makes the
>> > system to completely freeze (hard reset required).
>> >
>> > How could I debug this?
>>
>> Eek.
>>
>> /var/log/messages
>>
>> Does that show any poo from your last boot?
>
> Sadly no, nothing was logged immediately after the freeze and the next
> boot log (neither from "/var/log/messages" nor "/var/log/syslog") ;-(

I tried this: switched off the button for wifi+bt (this is a netbook),
then manually loaded these modules in this order (mac80211, bcma,
compat, brcmutil, cfg80211 and cordic). At this point the system is
fine, no freezes and dmesg shows normal messages.

Now, as soon as I proceed to load "brcmsmac" I get a long and
uninterruptible "beeeeep", system hard-freezes (no mouse nor caps lock
led reaction) and only restart is possible.

Any clue?

Greetings,

--=20
Camale=F3n
