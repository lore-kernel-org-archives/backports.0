MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <CAKprTDEEEdy++Bk5AY4Zfrtwsc9HOKGQ+uWR58PFCWU=v+PE1g@mail.gmail.com>
References: <CAKprTDHpf0PgisfJK9bJOYgYxLU5PRLNtbkg7V6Zj2s=gVVMCA@mail.gmail.com>
	<CAB=NE6Wbym4XksV=uKz9eZD0rZwmtS3ZfP-zbXg9TAc2+2+Z9g@mail.gmail.com>
	<CAKprTDEEEdy++Bk5AY4Zfrtwsc9HOKGQ+uWR58PFCWU=v+PE1g@mail.gmail.com>
Date: Wed, 27 Mar 2013 09:41:04 -0700
Message-ID: <CAB=NE6UtuxuTduYhDy5BcPap-rri+P1mcKYr2KEjAbuE2FU13g@mail.gmail.com>
Subject: Re: brcmsmac: Unknown symbol backport_cordic_calc_iq (err 0)
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
To: =?UTF-8?B?Q2FtYWxlw7Nu?= <noelamac@gmail.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Wed, Mar 27, 2013 at 8:28 AM, Camale=C3=B3n <noelamac@gmail.com> wrote:
> 2013/3/27 Luis R. Rodriguez <mcgrof@frijolero.org>:
>> On Tue, Mar 26, 2013 at 8:23 AM, Camale=C3=B3n <noelamac@gmail.com> wrot=
e:
>>> https://www.kernel.org/pub/linux/kernel/projects/backports/2013/03/22/c=
ompat-drivers-2013-03-22-u.tar.bz2
>>
>> Thanks for reporting this, this should now be fixed, please try today's =
release.
>
> Thanks Luis, this one prints no error when loading but it makes the
> system to completely freeze (hard reset required).
>
> How could I debug this?

Eek.

/var/log/messages

Does that show any poo from your last boot?

  Luis
