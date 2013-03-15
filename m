MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <20130312203638.GJ32416@pogo>
References: <1359916425-2377-1-git-send-email-ozancag@gmail.com>
	<510EB634.3080704@hauke-m.de>
	<CAFub=KQx6wCMUsQJAJXbiaUQ4-uUDepp0datbWuef-Gqst0xnA@mail.gmail.com>
	<511AB1B3.7090909@hauke-m.de>
	<CAFub=KTNR2ag=KB-MbdoHr-ROjs85kKaQTMYoLv6A4Bmpt-pnQ@mail.gmail.com>
	<CAB=NE6X6-0ELebcYt=72oGfgHa36SdyUDHeu1DQuZDxrjA5uJw@mail.gmail.com>
	<CAFub=KRfAsohiy3U9gAsjY=nfsPCreTboYhiZ=NcJqp+x07=5w@mail.gmail.com>
	<20130312203638.GJ32416@pogo>
Date: Fri, 15 Mar 2013 01:48:51 -0700
Message-ID: <CAB=NE6VttXVjELS23HKPD8t6iL-MQm9ZMH8iZMqACVtuCQ6HLw@mail.gmail.com>
Subject: Re: [PATCH] compat-drivers: Add possibility to build every subsystem separately
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org,
	mcgrof@kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Tue, Mar 12, 2013 at 1:36 PM, Luis R. Rodriguez
<rodrigue@qca.qualcomm.com> wrote:
> On Tue, Mar 12, 2013 at 02:12:15PM +0200, Ozan =C3=87a=C4=9Flayan wrote:
>> > I read this thread when I got back from the mountains and agreed with
>> > Hauke's recommendation.
>> >
>> >   Luis
>>
>> Can you clarify what does $BT, BT=3DTrue achieve? It looks like it was
>> some kind of switch to enable/disable BT but I can't be sure.
>
> Yeah that's legacy junk, nuke it at your liking.
>
>> On the other part, Hauke first suggested a different thing and then anot=
her
>> way.
>
> I think the concern was to not build everything on the stock
> vanilla release.
>
>> Should we enable all by default and --disable the unwanted ones or
>> should we disable and print a usage by default and add --enable
>> switches to enable subsystems?
>
> How about something very simple:
>
>   * Enable all by default
>
>   * Use Kconfig to allow us to select 4 subsystems:
>     - Ethernet
>     - WiFi
>     - Bluetooth
>     - DRM
>
> This way we'd keep the logic easy for an initial implementation
> to support Kconfig (scripts/kconfig/mconf.c) and then build on
> top of it to expand specifics.

But I think I get the issue you were pointing out though -- its not
about the building you are concerned about separating, its about the
admin work of fixing patches that might be broken for other subystems.
You want the option to say you don't care about a subsystem at
admin-update time. Is that right?

  Luis
