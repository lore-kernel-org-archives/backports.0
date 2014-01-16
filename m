Return-path: <techtonik@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1367933208.8328.11.camel@jlt4.sipsolutions.net>
References: <1367895800-14305-1-git-send-email-mcgrof@do-not-panic.com>
 <1367895800-14305-2-git-send-email-mcgrof@do-not-panic.com> <1367933208.8328.11.camel@jlt4.sipsolutions.net>
From: anatoly techtonik <techtonik@gmail.com>
Date: Fri, 17 Jan 2014 00:58:37 +0300
Message-ID: <CAPkN8x+WFFud0KDuP3qsWxt+HkjSF=OM7Dyi124F3-9ja3GCkg@mail.gmail.com> (sfid-20140116_225900_144929_88FC3F8A)
Subject: Re: [PATCH 1/3] backports: update patch Python library
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, backports@vger.kernel.org
Content-Type: multipart/alternative; boundary=001a11343f943d509204f01d8887
List-ID: <backports@vger.kernel.org>

--001a11343f943d509204f01d8887
Content-Type: text/plain; charset=UTF-8

On Tue, May 7, 2013 at 4:26 PM, Johannes Berg <johannes@sipsolutions.net>wrote:

> On Mon, 2013-05-06 at 20:03 -0700, Luis R. Rodriguez wrote:
>
> > @@ -627,6 +629,20 @@ class PatchSet(object):
> >          return None
> >      """
> >      for i,p in enumerate(self.items):
> > +      if p.type in (HG, GIT):
> > +        # TODO: figure out how to deal with /dev/null entries
> > +        debug("stripping a/ and b/ prefixes")
> > +        if p.source != '/dev/null':
> > +          if not p.source.startswith("a/"):
> > +            warning("invalid source filename")
> > +          else:
> > +            p.source = p.source[2:]
> > +        if p.target != '/dev/null':
> > +          if not p.target.startswith("b/"):
> > +            warning("invalid target filename")
> > +          else:
> > +            p.target = p.target[2:]
> > +
>
> Unfortunately, adding this back is problematic.
>

Sorry for a long delay. I finally lost my job, so now I can have some
continuous
time piece to concentrate on python-patch.


> We assume that all patches need one level stripped, but if a patch is a
> git patch (as indicated by having the "diff" and/or (?) "index" lines),
> then the patch library will already strip a level. That basically
> assumes that users use "-p0" on 'plain' patches, which isn't the case,
> we always use -p1.
>
> IOW, this will break dropping git patches (e.g. git
> diff/show/format-patch) into the patches directory.
>

patch.py is smart enough to strip only a/ and b/ prefixes, and do this
automatically when it is needed.

How do you use patch.py?
Why do you have to use -p1?

Anatoly, would you be interested in maybe having an option to disable
> this stripping? If yes, I can do that, otherwise I'm just going to edit
> it out of our copy of your library again :-)
>

Thanks to Google Code editor with no HG or GIT watermark I now also
implemented a/ and b/ stripping logic in apply function - see here:
http://code.google.com/p/python-patch/source/browse/trunk/patch.py?spec=svn229&r=229#746
It will be in first 1.14.x release.

Patch.source and .target are always filenames by design regardless of
patch type (that's not true for Google Code patches, but am reluctant to
make quirks mode parser as a workaround for their bugs). Preserving
names as original means that users have to care about patch type and
strip those prefixes themselves for HG and GIT, which is usability fail.
There is no data loss in current implementation. If you need prefixes,
it is possible to restore them by patch type.
-- 
anatoly t.

--001a11343f943d509204f01d8887
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Tue, May 7, 2013 at 4:26 PM, Johannes Berg <span dir=3D=
"ltr">&lt;<a href=3D"mailto:johannes@sipsolutions.net" target=3D"_blank">jo=
hannes@sipsolutions.net</a>&gt;</span> wrote:<br><div class=3D"gmail_extra"=
><div class=3D"gmail_quote">

<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><div class=3D"im">On Mon,=
 2013-05-06 at 20:03 -0700, Luis R. Rodriguez wrote:<br>
<br>
&gt; @@ -627,6 +629,20 @@ class PatchSet(object):<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return None<br>
&gt; =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
&gt; =C2=A0 =C2=A0 =C2=A0for i,p in enumerate(self.items):<br>
&gt; + =C2=A0 =C2=A0 =C2=A0if p.type in (HG, GIT):<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0# TODO: figure out how to deal with /dev/=
null entries<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0debug(&quot;stripping a/ and b/ prefixes&=
quot;)<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0if p.source !=3D &#39;/dev/null&#39;:<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not p.source.startswith(&quot;a=
/&quot;):<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0warning(&quot;invalid sourc=
e filename&quot;)<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p.source =3D p.source[2:]<b=
r>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0if p.target !=3D &#39;/dev/null&#39;:<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not p.target.startswith(&quot;b=
/&quot;):<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0warning(&quot;invalid targe=
t filename&quot;)<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p.target =3D p.target[2:]<b=
r>
&gt; +<br>
<br>
</div>Unfortunately, adding this back is problematic.<br></blockquote><div>=
<br><div class=3D"gmail_quote">Sorry for a long delay. I finally lost my jo=
b, so now I can have some continuous<br>time piece to concentrate on python=
-patch.<br clear=3D"all">

</div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
We assume that all patches need one level stripped, but if a patch is a<br>
git patch (as indicated by having the &quot;diff&quot; and/or (?) &quot;ind=
ex&quot; lines),<br>
then the patch library will already strip a level. That basically<br>
assumes that users use &quot;-p0&quot; on &#39;plain&#39; patches, which is=
n&#39;t the case,<br>
we always use -p1.<br>
<br>
IOW, this will break dropping git patches (e.g. git<br>
diff/show/format-patch) into the patches directory.<br></blockquote><div><b=
r></div><div>patch.py is smart enough to strip only a/ and b/ prefixes, and=
 do this<br>automatically when it is needed.<br><br>How do you use patch.py=
?<br>

Why do you have to use -p1? <br><br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
Anatoly, would you be interested in maybe having an option to disable<br>
this stripping? If yes, I can do that, otherwise I&#39;m just going to edit=
<br>
it out of our copy of your library again :-)<br></blockquote><div><br>Thank=
s to Google Code editor with no HG or GIT watermark I now also<br>implement=
ed a/ and b/ stripping logic in apply function - see here:<br><a href=3D"ht=
tp://code.google.com/p/python-patch/source/browse/trunk/patch.py?spec=3Dsvn=
229&amp;r=3D229#746">http://code.google.com/p/python-patch/source/browse/tr=
unk/patch.py?spec=3Dsvn229&amp;r=3D229#746</a><br>

</div><div>It will be in first 1.14.x release.<br></div><div><br>Patch.sour=
ce and .target are always filenames by design regardless of<br>patch type (=
that&#39;s not true for Google Code patches, but am reluctant to<br>make qu=
irks mode  parser as a workaround for their bugs). Preserving<br>

</div><div>names as original means that users have to care about patch type=
 and<br></div><div>strip those prefixes themselves for HG and GIT, which is=
 usability fail.<br></div><div>There is no data loss in current implementat=
ion. If you need prefixes,<br>

</div><div>it is possible to restore them by patch type.<br></div></div>-- =
<br><div class=3D"gmail_quote"><div>anatoly t.</div>
</div></div></div>

--001a11343f943d509204f01d8887--
