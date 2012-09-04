MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <CAGj=iG-wTJGOi+WFJ8fXyeVh=S5335zjdDniyTPfvmi=nXSKqA@mail.gmail.com>
References: <CAGj=iG9meBuxqz=UsYwYW5pHbCXgsAp2eHi04ZK0LTLHHPu+=w@mail.gmail.com>
	<CAGj=iG-wdYJe4CZBCJ=VfPxUA1NiOQi_356dSYsNZQ4v6fxkeg@mail.gmail.com>
	<CAGj=iG_FzEsiU-25ckfiC8sbzq1rq-mPnexgRBqki+Q0+d82ew@mail.gmail.com>
	<CAGj=iG-wTJGOi+WFJ8fXyeVh=S5335zjdDniyTPfvmi=nXSKqA@mail.gmail.com>
Date: Tue, 4 Sep 2012 16:41:57 -0700
Message-ID: <CAB=NE6XGd+0-WEEV-Erk5O7ih3GmebicDOmL7o=qaPYipYhq=A@mail.gmail.com>
Subject: Re: Compiling only one driver
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: =?UTF-8?Q?Felipe_L=C3=B3pez?= <lopez.rottweiler@gmail.com>
Cc: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Tue, Sep 4, 2012 at 3:52 AM, Felipe L=C3=B3pez <lopez.rottweiler@gmail.c=
om> wrote:
> I am sorry. I forgot to be more specific about my impressions: is it
> enough to just comment all the drivers in the file "driver-select"
> apart from the one I am using (ath9k) and edit the makefile that it
> points to (ATH9K_MAKEFILE=3D"drivers/net/wireless/ath/ath9k/Makefile")
> with the cross-compiler that I am going to use?

./scripts/driver-select ath9k_htc

and then with your compiler / etc:

https://backports.wiki.kernel.org/index.php/Documentation/compat-drivers#Bu=
ilding_for_external_kernels

  Luis
