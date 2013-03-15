Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <ozancag@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAB=NE6VttXVjELS23HKPD8t6iL-MQm9ZMH8iZMqACVtuCQ6HLw@mail.gmail.com>
References: <1359916425-2377-1-git-send-email-ozancag@gmail.com>
	<510EB634.3080704@hauke-m.de>
	<CAFub=KQx6wCMUsQJAJXbiaUQ4-uUDepp0datbWuef-Gqst0xnA@mail.gmail.com>
	<511AB1B3.7090909@hauke-m.de>
	<CAFub=KTNR2ag=KB-MbdoHr-ROjs85kKaQTMYoLv6A4Bmpt-pnQ@mail.gmail.com>
	<CAB=NE6X6-0ELebcYt=72oGfgHa36SdyUDHeu1DQuZDxrjA5uJw@mail.gmail.com>
	<CAFub=KRfAsohiy3U9gAsjY=nfsPCreTboYhiZ=NcJqp+x07=5w@mail.gmail.com>
	<20130312203638.GJ32416@pogo>
	<CAB=NE6VttXVjELS23HKPD8t6iL-MQm9ZMH8iZMqACVtuCQ6HLw@mail.gmail.com>
Date: Fri, 15 Mar 2013 11:09:00 +0200
Message-ID: <CAFub=KQHvKak5K=Odeu-qeysJ3WR3t8spZHuwhB62jdM_KEKyQ@mail.gmail.com>
Subject: Re: [PATCH] compat-drivers: Add possibility to build every subsystem separately
From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org, mcgrof@kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

> But I think I get the issue you were pointing out though -- its not
> about the building you are concerned about separating, its about the
> admin work of fixing patches that might be broken for other subystems.
> You want the option to say you don't care about a subsystem at
> admin-update time. Is that right?

No not at all. Just for building. I just want to build DRM drivers for
example and it is not quiet easy to do this by hand. You have to
modify the makefile, etc.


--=20
Ozan =C3=87a=C4=9Flayan
Research Assistant
Galatasaray University - Computer Engineering Dept.
http://www.ozancaglayan.com
