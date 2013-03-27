Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <noelamac@gmail.com>
Return-Path: <noelamac@gmail.com>
Date: Wed, 27 Mar 2013 18:57:11 +0100
From: =?utf-8?B?Q2FtYWxlw7Nu?= <noelamac@gmail.com>
To: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: brcmsmac: Unknown symbol backport_cordic_calc_iq (err 0)
Message-ID: <20130327175711.GA8794@stt008.linux.site>
References: <CAKprTDHpf0PgisfJK9bJOYgYxLU5PRLNtbkg7V6Zj2s=gVVMCA@mail.gmail.com> <CAB=NE6Wbym4XksV=uKz9eZD0rZwmtS3ZfP-zbXg9TAc2+2+Z9g@mail.gmail.com> <CAKprTDEEEdy++Bk5AY4Zfrtwsc9HOKGQ+uWR58PFCWU=v+PE1g@mail.gmail.com> <CAB=NE6UtuxuTduYhDy5BcPap-rri+P1mcKYr2KEjAbuE2FU13g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAB=NE6UtuxuTduYhDy5BcPap-rri+P1mcKYr2KEjAbuE2FU13g@mail.gmail.com>
List-ID: <backports@vger.kernel.org>

El 2013-03-27 a las 09:41 -0700, Luis R. Rodriguez escribió:

> On Wed, Mar 27, 2013 at 8:28 AM, Camaleón <noelamac@gmail.com> wrote:
> > 2013/3/27 Luis R. Rodriguez <mcgrof@frijolero.org>:
> >> On Tue, Mar 26, 2013 at 8:23 AM, Camaleón <noelamac@gmail.com> wrote:
> >>> https://www.kernel.org/pub/linux/kernel/projects/backports/2013/03/22/compat-drivers-2013-03-22-u.tar.bz2
> >>
> >> Thanks for reporting this, this should now be fixed, please try today's release.
> >
> > Thanks Luis, this one prints no error when loading but it makes the
> > system to completely freeze (hard reset required).
> >
> > How could I debug this?
> 
> Eek.
> 
> /var/log/messages
> 
> Does that show any poo from your last boot?

Sadly no, nothing was logged immediately after the freeze and the next 
boot log (neither from "/var/log/messages" nor "/var/log/syslog") ;-(

Greetings,

-- 
Camaleón 
