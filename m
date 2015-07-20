Return-path: <mcgrof@gmail.com>
MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <alpine.DEB.2.02.1507181901020.2059@localhost6.localdomain6>
References: <1437195911-28821-1-git-send-email-mcgrof@do-not-panic.com>
	<alpine.DEB.2.02.1507181901020.2059@localhost6.localdomain6>
Date: Mon, 20 Jul 2015 07:45:36 -0700
Message-ID: <CAB=NE6VEpGSU2tY4H+QjuL82ku-Lz80sXN509q9_DgpbLnPEUQ@mail.gmail.com> (sfid-20150720_164539_483958_B606EFD7)
Subject: Re: [Cocci] [PATCH v2 0/4] pycocci: index opts, SmPL patch proof support
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: cocci@systeme.lip6.fr, backports@vger.kernel.org,
	johannes@sipsolutions.net
Content-Type: multipart/alternative; boundary=089e0149bbb042a87e051b4f97ef
List-ID: <backports@vger.kernel.org>

--089e0149bbb042a87e051b4f97ef
Content-Type: text/plain; charset=UTF-8

On Jul 18, 2015 10:01 AM, "Julia Lawall" <julia.lawall@lip6.fr> wrote:
>
> On Fri, 17 Jul 2015, Luis R. Rodriguez wrote:
>
> > From: "Luis R. Rodriguez" <mcgrof@suse.com>
> >
> > This v2 changes the way we do git tree inference by using
> > git rev-parse. While at it, I decided to mesh in SmPL  <--> patch
> > equivalence proof support. This is a generalized solution, I
> > originally had written for the backports project, we now give
> > this instead a proper home and purpose under pycocci.
> >
> > If there are no issues I'll merge this soon, in hopes it will
> > make it for the coccinelle 1.0.2 release.
> >
> > Luis R. Rodriguez (4):
> >   pycocci: add requirements class
> >   pycocci: add git class
> >   pycocci: figure out if to enable --jobs, --use-gitgrep or
> >     --use-glimpse
>
> Do you need patches 2 and 3?

Do you mean I should squash them together, or something else ?

  Luis
> julia
>
> >   pycocci: add Coccinelle SmPL patch proof support
> >
> >  tools/pycocci | 475
++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 462 insertions(+), 13 deletions(-)
> >
> > --
> > 2.3.2.209.gd67f9d5.dirty
> >
> > _______________________________________________
> > Cocci mailing list
> > Cocci@systeme.lip6.fr
> > https://systeme.lip6.fr/mailman/listinfo/cocci
> >

--089e0149bbb042a87e051b4f97ef
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On Jul 18, 2015 10:01 AM, &quot;Julia Lawall&quot; &lt;<a href=3D"mailto:ju=
lia.lawall@lip6.fr">julia.lawall@lip6.fr</a>&gt; wrote:<br>
&gt;<br>
&gt; On Fri, 17 Jul 2015, Luis R. Rodriguez wrote:<br>
&gt;<br>
&gt; &gt; From: &quot;Luis R. Rodriguez&quot; &lt;<a href=3D"mailto:mcgrof@=
suse.com">mcgrof@suse.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; This v2 changes the way we do git tree inference by using<br>
&gt; &gt; git rev-parse. While at it, I decided to mesh in SmPL=C2=A0 &lt;-=
-&gt; patch<br>
&gt; &gt; equivalence proof support. This is a generalized solution, I<br>
&gt; &gt; originally had written for the backports project, we now give<br>
&gt; &gt; this instead a proper home and purpose under pycocci.<br>
&gt; &gt;<br>
&gt; &gt; If there are no issues I&#39;ll merge this soon, in hopes it will=
<br>
&gt; &gt; make it for the coccinelle 1.0.2 release.<br>
&gt; &gt;<br>
&gt; &gt; Luis R. Rodriguez (4):<br>
&gt; &gt;=C2=A0 =C2=A0pycocci: add requirements class<br>
&gt; &gt;=C2=A0 =C2=A0pycocci: add git class<br>
&gt; &gt;=C2=A0 =C2=A0pycocci: figure out if to enable --jobs, --use-gitgre=
p or<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0--use-glimpse<br>
&gt;<br>
&gt; Do you need patches 2 and 3?</p>
<p dir=3D"ltr">Do you mean I should squash them together, or something else=
 ?</p>
<p dir=3D"ltr">=C2=A0 Luis<br>
&gt; julia<br>
&gt;<br>
&gt; &gt;=C2=A0 =C2=A0pycocci: add Coccinelle SmPL patch proof support<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 tools/pycocci | 475 +++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++--<br>
&gt; &gt;=C2=A0 1 file changed, 462 insertions(+), 13 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; --<br>
&gt; &gt; 2.3.2.209.gd67f9d5.dirty<br>
&gt; &gt;<br>
&gt; &gt; _______________________________________________<br>
&gt; &gt; Cocci mailing list<br>
&gt; &gt; <a href=3D"mailto:Cocci@systeme.lip6.fr">Cocci@systeme.lip6.fr</a=
><br>
&gt; &gt; <a href=3D"https://systeme.lip6.fr/mailman/listinfo/cocci">https:=
//systeme.lip6.fr/mailman/listinfo/cocci</a><br>
&gt; &gt;<br>
</p>

--089e0149bbb042a87e051b4f97ef--
