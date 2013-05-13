Return-path: <dh.herrmann@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAB=NE6V0CywQoS0Xn5Xc2-biWeU34HGr7k9F2g+7+0wMZNCNFg@mail.gmail.com>
References: <1368232023-23817-1-git-send-email-mcgrof@do-not-panic.com>
	<1368232023-23817-12-git-send-email-mcgrof@do-not-panic.com>
	<CANq1E4Re_uJQqvqEpWzRbVxsxVz3MBvZUqzM3ONFiJ+mXy4rNA@mail.gmail.com>
	<CAB=NE6XrKUSDQbjdeht=Aip-E1=oqPd4D=JmMdEdrJSNXLGukg@mail.gmail.com>
	<CANq1E4RXkYU=PNd-acNT-cp1ARQPR6-2Rq-a8eJGseSbRLCLxg@mail.gmail.com>
	<CAB=NE6WyvXSUS2PUNFktBVUn4u0rcVwXGQ1sYDbL34d8iU2RYw@mail.gmail.com>
	<CAB=NE6V0CywQoS0Xn5Xc2-biWeU34HGr7k9F2g+7+0wMZNCNFg@mail.gmail.com>
Date: Mon, 13 May 2013 06:35:15 +0200
Message-ID: <CANq1E4ReXt0QMRFKZSNDKpCXv2YZMmS+n+NOc=NR8NMfuWS4OA@mail.gmail.com> (sfid-20130513_063518_608152_7877DAE5)
Subject: Re: [PATCH 11/12] backports: backport new bluetooth hidp session-management
From: David Herrmann <dh.herrmann@gmail.com>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>,
	David Herrmann <dh.herrmann@gmail.com>
Content-Type: multipart/alternative; boundary=089e013c71540b51ac04dc920b2b
List-ID: <backports@vger.kernel.org>

--089e013c71540b51ac04dc920b2b
Content-Type: text/plain; charset=ISO-8859-1

Hi

On May 13, 2013 4:36 AM, "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
wrote:
>
> On Sun, May 12, 2013 at 6:30 PM, Luis R. Rodriguez
> <mcgrof@do-not-panic.com> wrote:
> >
> > No worries we have a crazy build box for the backports project that
> > lets us test compile these releases across 26 kernels (2.6.24-3.9) in
> > about 30 minutes using our script ckmake, all in RAM, so I just
> > integrated your changes and in 30 minutes we'll know if anything
> > broke, and I can provide the log then.
>
> $ time ckmake --allyesconfig
>
> 1   2.6.24              [  OK  ]
> 2   2.6.25              [  OK  ]
> 3   2.6.26              [  OK  ]
> 4   2.6.27              [  OK  ]
> 5   2.6.28              [  OK  ]
> 6   2.6.29              [  OK  ]
> 7   2.6.30              [  OK  ]
> 8   2.6.31              [  OK  ]
> 9   2.6.32              [  OK  ]
> 10  2.6.33              [  OK  ]
> 11  2.6.34              [  OK  ]
> 12  2.6.35              [  OK  ]
> 13  2.6.36              [  OK  ]
> 14  2.6.37              [  OK  ]
> 15  2.6.38              [  OK  ]
> 16  2.6.39              [  OK  ]
> 17  3.0.76              [  OK  ]
> 18  3.1.10              [  OK  ]
> 19  3.2.44              [  OK  ]
> 20  3.3.8               [  OK  ]
> 21  3.4.43              [  OK  ]
> 22  3.5.7               [  OK  ]
> 23  3.6.11              [  OK  ]
> 24  3.7.10              [  OK  ]
> 25  3.8.11              [  OK  ]
> 26  3.9.0               [  OK  ]
>
> real    30m53.311s
> user    817m3.260s
> sys     127m37.555s

Perfect, thanks!

> >> The net/bluetooth/hidp/core.c file is attached. It is from the tarball
> >> you created above (2013-04-26). I fixed some other small issues.
> >
> > Nice, can you provide me a Signed-off-by tag ? With it I'd just amend
> > it to my commit provided everything compiles fine.
>
> Just need a Signed-off-by from you and we're good, thanks so much.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>

Thanks!
David

--089e013c71540b51ac04dc920b2b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Hi</p>
<p dir=3D"ltr">On May 13, 2013 4:36 AM, &quot;Luis R. Rodriguez&quot; &lt;<=
a href=3D"mailto:mcgrof@do-not-panic.com">mcgrof@do-not-panic.com</a>&gt; w=
rote:<br>
&gt;<br>
&gt; On Sun, May 12, 2013 at 6:30 PM, Luis R. Rodriguez<br>
&gt; &lt;<a href=3D"mailto:mcgrof@do-not-panic.com">mcgrof@do-not-panic.com=
</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; No worries we have a crazy build box for the backports project th=
at<br>
&gt; &gt; lets us test compile these releases across 26 kernels (2.6.24-3.9=
) in<br>
&gt; &gt; about 30 minutes using our script ckmake, all in RAM, so I just<b=
r>
&gt; &gt; integrated your changes and in 30 minutes we&#39;ll know if anyth=
ing<br>
&gt; &gt; broke, and I can provide the log then.<br>
&gt;<br>
&gt; $ time ckmake --allyesconfig<br>
&gt;<br>
&gt; 1 =A0 2.6.24 =A0 =A0 =A0 =A0 =A0 =A0 =A0[ =A0OK =A0]<br>
&gt; 2 =A0 2.6.25 =A0 =A0 =A0 =A0 =A0 =A0 =A0[ =A0OK =A0]<br>
&gt; 3 =A0 2.6.26 =A0 =A0 =A0 =A0 =A0 =A0 =A0[ =A0OK =A0]<br>
&gt; 4 =A0 2.6.27 =A0 =A0 =A0 =A0 =A0 =A0 =A0[ =A0OK =A0]<br>
&gt; 5 =A0 2.6.28 =A0 =A0 =A0 =A0 =A0 =A0 =A0[ =A0OK =A0]<br>
&gt; 6 =A0 2.6.29 =A0 =A0 =A0 =A0 =A0 =A0 =A0[ =A0OK =A0]<br>
&gt; 7 =A0 2.6.30 =A0 =A0 =A0 =A0 =A0 =A0 =A0[ =A0OK =A0]<br>
&gt; 8 =A0 2.6.31 =A0 =A0 =A0 =A0 =A0 =A0 =A0[ =A0OK =A0]<br>
&gt; 9 =A0 2.6.32 =A0 =A0 =A0 =A0 =A0 =A0 =A0[ =A0OK =A0]<br>
&gt; 10 =A02.6.33 =A0 =A0 =A0 =A0 =A0 =A0 =A0[ =A0OK =A0]<br>
&gt; 11 =A02.6.34 =A0 =A0 =A0 =A0 =A0 =A0 =A0[ =A0OK =A0]<br>
&gt; 12 =A02.6.35 =A0 =A0 =A0 =A0 =A0 =A0 =A0[ =A0OK =A0]<br>
&gt; 13 =A02.6.36 =A0 =A0 =A0 =A0 =A0 =A0 =A0[ =A0OK =A0]<br>
&gt; 14 =A02.6.37 =A0 =A0 =A0 =A0 =A0 =A0 =A0[ =A0OK =A0]<br>
&gt; 15 =A02.6.38 =A0 =A0 =A0 =A0 =A0 =A0 =A0[ =A0OK =A0]<br>
&gt; 16 =A02.6.39 =A0 =A0 =A0 =A0 =A0 =A0 =A0[ =A0OK =A0]<br>
&gt; 17 =A03.0.76 =A0 =A0 =A0 =A0 =A0 =A0 =A0[ =A0OK =A0]<br>
&gt; 18 =A03.1.10 =A0 =A0 =A0 =A0 =A0 =A0 =A0[ =A0OK =A0]<br>
&gt; 19 =A03.2.44 =A0 =A0 =A0 =A0 =A0 =A0 =A0[ =A0OK =A0]<br>
&gt; 20 =A03.3.8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [ =A0OK =A0]<br>
&gt; 21 =A03.4.43 =A0 =A0 =A0 =A0 =A0 =A0 =A0[ =A0OK =A0]<br>
&gt; 22 =A03.5.7 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [ =A0OK =A0]<br>
&gt; 23 =A03.6.11 =A0 =A0 =A0 =A0 =A0 =A0 =A0[ =A0OK =A0]<br>
&gt; 24 =A03.7.10 =A0 =A0 =A0 =A0 =A0 =A0 =A0[ =A0OK =A0]<br>
&gt; 25 =A03.8.11 =A0 =A0 =A0 =A0 =A0 =A0 =A0[ =A0OK =A0]<br>
&gt; 26 =A03.9.0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [ =A0OK =A0]<br>
&gt;<br>
&gt; real =A0 =A030m53.311s<br>
&gt; user =A0 =A0817m3.260s<br>
&gt; sys =A0 =A0 127m37.555s</p>
<p dir=3D"ltr">Perfect, thanks!</p>
<p dir=3D"ltr">&gt; &gt;&gt; The net/bluetooth/hidp/core.c file is attached=
. It is from the tarball<br>
&gt; &gt;&gt; you created above (2013-04-26). I fixed some other small issu=
es.<br>
&gt; &gt;<br>
&gt; &gt; Nice, can you provide me a Signed-off-by tag ? With it I&#39;d ju=
st amend<br>
&gt; &gt; it to my commit provided everything compiles fine.<br>
&gt;<br>
&gt; Just need a Signed-off-by from you and we&#39;re good, thanks so much.=
</p>
<p dir=3D"ltr">Signed-off-by: David Herrmann &lt;<a href=3D"mailto:dh.herrm=
ann@gmail.com">dh.herrmann@gmail.com</a>&gt;</p>
<p dir=3D"ltr">Thanks!<br>
David</p>

--089e013c71540b51ac04dc920b2b--
