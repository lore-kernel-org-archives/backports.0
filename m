MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <CAKprTDHpf0PgisfJK9bJOYgYxLU5PRLNtbkg7V6Zj2s=gVVMCA@mail.gmail.com>
References: <CAKprTDHpf0PgisfJK9bJOYgYxLU5PRLNtbkg7V6Zj2s=gVVMCA@mail.gmail.com>
Date: Tue, 26 Mar 2013 18:46:21 -0700
Message-ID: <CAB=NE6Wbym4XksV=uKz9eZD0rZwmtS3ZfP-zbXg9TAc2+2+Z9g@mail.gmail.com>
Subject: Re: brcmsmac: Unknown symbol backport_cordic_calc_iq (err 0)
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
To: =?UTF-8?B?Q2FtYWxlw7Nu?= <noelamac@gmail.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Tue, Mar 26, 2013 at 8:23 AM, Camale=C3=B3n <noelamac@gmail.com> wrote:
> Hello,
>
> After compiling and installing the latest compat-drivers=C4=85, when
> issuing "modprobe brcmsmac" I get this error in dmesg:
>
> brcmsmac: Unknown symbol backport_cordic_calc_iq (err 0)
>
> What can I be missing? Now running a self-compiled kernel:
>
> root@stt300:/home/hpc03/Escritorio/compat-drivers-2013-03-22-u# uname -r
> 3.9.0-rc2
>
> https://www.kernel.org/pub/linux/kernel/projects/backports/2013/03/22/com=
pat-drivers-2013-03-22-u.tar.bz2

Thanks for reporting this, this should now be fixed, please try today's rel=
ease.

  Luis
