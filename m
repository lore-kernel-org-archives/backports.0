Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <noelamac@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAB=NE6Wbym4XksV=uKz9eZD0rZwmtS3ZfP-zbXg9TAc2+2+Z9g@mail.gmail.com>
References: <CAKprTDHpf0PgisfJK9bJOYgYxLU5PRLNtbkg7V6Zj2s=gVVMCA@mail.gmail.com>
	<CAB=NE6Wbym4XksV=uKz9eZD0rZwmtS3ZfP-zbXg9TAc2+2+Z9g@mail.gmail.com>
Date: Wed, 27 Mar 2013 16:28:52 +0100
Message-ID: <CAKprTDEEEdy++Bk5AY4Zfrtwsc9HOKGQ+uWR58PFCWU=v+PE1g@mail.gmail.com>
Subject: Re: brcmsmac: Unknown symbol backport_cordic_calc_iq (err 0)
From: =?ISO-8859-1?Q?Camale=F3n?= <noelamac@gmail.com>
To: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

2013/3/27 Luis R. Rodriguez <mcgrof@frijolero.org>:
> On Tue, Mar 26, 2013 at 8:23 AM, Camale=C3=B3n <noelamac@gmail.com> wrote=
:
>> Hello,
>>
>> After compiling and installing the latest compat-drivers=C4=85, when
>> issuing "modprobe brcmsmac" I get this error in dmesg:
>>
>> brcmsmac: Unknown symbol backport_cordic_calc_iq (err 0)
>>
>> What can I be missing? Now running a self-compiled kernel:
>>
>> root@stt300:/home/hpc03/Escritorio/compat-drivers-2013-03-22-u# uname -r
>> 3.9.0-rc2
>>
>> https://www.kernel.org/pub/linux/kernel/projects/backports/2013/03/22/co=
mpat-drivers-2013-03-22-u.tar.bz2
>
> Thanks for reporting this, this should now be fixed, please try today's r=
elease.

Thanks Luis, this one prints no error when loading but it makes the
system to completely freeze (hard reset required).

How could I debug this?

Greetings,

--=20
Camale=C3=B3n
