MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <CAKprTDFspW4B2tk9EZPBBXy3C6gL_NJsjwj-bUeYj1rN3j6sYg@mail.gmail.com>
References: <CAKprTDHpf0PgisfJK9bJOYgYxLU5PRLNtbkg7V6Zj2s=gVVMCA@mail.gmail.com>
	<CAB=NE6Wbym4XksV=uKz9eZD0rZwmtS3ZfP-zbXg9TAc2+2+Z9g@mail.gmail.com>
	<CAKprTDEEEdy++Bk5AY4Zfrtwsc9HOKGQ+uWR58PFCWU=v+PE1g@mail.gmail.com>
	<CAB=NE6UtuxuTduYhDy5BcPap-rri+P1mcKYr2KEjAbuE2FU13g@mail.gmail.com>
	<20130327175711.GA8794@stt008.linux.site>
	<CAKprTDFspW4B2tk9EZPBBXy3C6gL_NJsjwj-bUeYj1rN3j6sYg@mail.gmail.com>
Date: Thu, 28 Mar 2013 02:15:10 -0700
Message-ID: <CAB=NE6W6Ey8iU1vs=XfA7Or0wF=Qh6Gu8zF-DxMatgk-V+wdkQ@mail.gmail.com>
Subject: Re: brcmsmac: Unknown symbol backport_cordic_calc_iq (err 0)
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
To: =?UTF-8?B?Q2FtYWxlw7Nu?= <noelamac@gmail.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	linux-wireless <linux-wireless@vger.kernel.org>, Brett Rudley <brudley@broadcom.com>,
	Arend Van Spriel <arend@broadcom.com>, "Franky (Zhenhui) Lin" <frankyl@broadcom.com>, meuleman@broadcom.com,
	brcm80211-dev-list@broadcom.com
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Thu, Mar 28, 2013 at 2:02 AM, Camale=C3=B3n <noelamac@gmail.com> wrote:
> 2013/3/27 Camale=C3=B3n <noelamac@gmail.com>:
>> El 2013-03-27 a las 09:41 -0700, Luis R. Rodriguez escribi=C3=B3:
> I tried this: switched off the button for wifi+bt (this is a netbook),
> then manually loaded these modules in this order (mac80211, bcma,
> compat, brcmutil, cfg80211 and cordic). At this point the system is
> fine, no freezes and dmesg shows normal messages.

Great.

> Now, as soon as I proceed to load "brcmsmac" I get a long and
> uninterruptible "beeeeep", system hard-freezes (no mouse nor caps lock
> led reaction) and only restart is possible.
>
> Any clue?

You are on 3.9.0-rc2, so there is nothing for us to backport on these
linux-next based releases except the delta between v3.9 and what is
not yet on Linus' tree, in other worlds just the development delta for
the 802.11 subsystem. We have yet to require any backport work between
3.9 and what we assume will be 3.10. My bet is this is a real driver
bug, not backport bug.

Can you

git clone git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-t=
esting.git

and use your .config, and build and test that kernel ? If it fails to
boot / crash then you know its the driver.

Has brcmsmac ever worked for you?

  Luis
