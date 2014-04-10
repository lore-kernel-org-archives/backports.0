Return-Path: <ssugrim@winlab.rutgers.edu>
MIME-Version: 1.0
In-Reply-To: <CAB=NE6VnNNfRDO488S65Cjo1JfdonZ7tF6pmqQFE=5y0WhMLwg@mail.gmail.com>
References: <CAE5JcOWEv65JjjhV0LyvTSBPYKrEyZem_+Wy07Cz4qaLP7218A@mail.gmail.com>
	<CAB=NE6VnNNfRDO488S65Cjo1JfdonZ7tF6pmqQFE=5y0WhMLwg@mail.gmail.com>
Date: Thu, 10 Apr 2014 13:44:31 -0400
Message-ID: <CAE5JcOUYyWY2j7GYtNRSa9AQHL_0QXQ=WOkO++SnhjDCDtq_hA@mail.gmail.com>
Subject: Re: Back ports question
From: Shridatt Sugrim <ssugrim@winlab.rutgers.edu>
To: "Luis R. Rodriguez" <mcgrof@gmail.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: multipart/alternative; boundary=047d7b5d5b0a02e9be04f6b3c51a
List-ID: <backports@vger.kernel.org>

--047d7b5d5b0a02e9be04f6b3c51a
Content-Type: text/plain; charset=ISO-8859-1

Ok, I see what I'm supposed to do. I'll re-clone to get a fresh copy (just
neater).

Thanks Luis!

-James


On Wed, Apr 9, 2014 at 7:38 PM, Luis R. Rodriguez <mcgrof@gmail.com> wrote:

> Cc'ing backports.
>
> On Wed, Apr 9, 2014 at 4:11 PM, Shridatt Sugrim
> <ssugrim@winlab.rutgers.edu> wrote:
> > Hey Luis, I was trying to build a back ported version of iwlwifi for
> 3.2.0
> > kernel. But I'm kinda lost as to how I get this to work. Do you still
> work
> > on this / have  pointer on how to build against a running kernel?
>
> Yeap, still chugging on backports. The best reference is the wiki:
>
> https://backports.wiki.kernel.org
>
> Have you tried that by any chance?
>
> Be sure to use this repo:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/backports/backports.git
>
> I just pushed out two tags I forgot to peg based on the new updates
> form yesterday so if you have a fresh tree just git fetch --tags.
>
> > Basically here is my problem: The older nodes use a non-pae kernel, but
> some
> > of the newer wifi cards require the new iwlwifi driver. I'm trying to
> build
> > the iwlwifi module against my current running kernel 3.2.0-60-generic. To
> > that end I cloned the linux backports and hopped to the linux-3.2.y
> branch.
> > But from here I don't know where to go.  Can I just slice out the iwlwifi
> > directory  and graft it onto my existing source tree?
>
> Sure, but a few notes. The branch on backports for linux-3.2.y is for
> the respective linux-stable.git tree and its own linux-3.2.y branch.
> If you want the latest you have the option of either using Linus' tree
> and hopping on v3.14 (later Greg will have started a linux-3.14.y
> branch on linux-stable.git) and using the backports linux-3.14.y
> branch. If you want the very latest and greatest you can just stick to
> the master branch of backports, and do git describe. That will tell
> you the respective linux-next tag that you should use so
> backports-20140320 tag right now means that you should have a
> linux-next that is caught up to next-20140320. If you hop onto the
> backports linux-3.14.y branch it is designed for the linux-stable.git
> tree and if Greg hasn't pushed updates to it for v3.14 yet you can
> just use Linus' tree and 'git reset --hard v3.14' to force it to
> rewind to v3.14.
>
> Since its a pain to expect folks to juggle tons of trees well (Linus'
> tree, linux-stable.git, linux-next.git) and also the ksrc-backports
> directory which we use to carry all the stable kernels headers we
> support in case you want to test compile something accross all kernels
> with ckmake, we provide a python script that does all the tree
> management / synchs for you. On a clean system as a regular user in
> your home directory you can just run:
>
> devel/backports-update-manager
>
> That'll do all the synching for you. In the next linux-next iteration
> I hope to nuke a whole bunch of old kernels and get us to only require
> supporting up to 3.2. so you'll need to run this then if you're a
> developer and wish to also nuke all the old junk.
>
> Another option is for you to wait for a release to be kicked out on
> the release page:
>
>
>   Luis
>



-- 
Shridatt Sugrim
Winlab
Rutgers, The State University of New Jersey
Technology Centre of New Jersey
671 Route 1 South
North Brunswick, NJ 08902-3390
732-932-6857 - Phone    732-932-6882 - Fax

--047d7b5d5b0a02e9be04f6b3c51a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Ok, I see what I&#39;m supposed to do. I&#39;ll re-clone t=
o get a fresh copy (just neater). =A0<div><br></div><div>Thanks Luis!</div>=
<div><br></div><div>-James</div></div><div class=3D"gmail_extra"><br><br><d=
iv class=3D"gmail_quote">
On Wed, Apr 9, 2014 at 7:38 PM, Luis R. Rodriguez <span dir=3D"ltr">&lt;<a =
href=3D"mailto:mcgrof@gmail.com" target=3D"_blank">mcgrof@gmail.com</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">
Cc&#39;ing backports.<br>
<br>
On Wed, Apr 9, 2014 at 4:11 PM, Shridatt Sugrim<br>
&lt;<a href=3D"mailto:ssugrim@winlab.rutgers.edu">ssugrim@winlab.rutgers.ed=
u</a>&gt; wrote:<br>
&gt; Hey Luis, I was trying to build a back ported version of iwlwifi for 3=
.2.0<br>
&gt; kernel. But I&#39;m kinda lost as to how I get this to work. Do you st=
ill work<br>
&gt; on this / have =A0pointer on how to build against a running kernel?<br=
>
<br>
Yeap, still chugging on backports. The best reference is the wiki:<br>
<br>
<a href=3D"https://backports.wiki.kernel.org" target=3D"_blank">https://bac=
kports.wiki.kernel.org</a><br>
<br>
Have you tried that by any chance?<br>
<br>
Be sure to use this repo:<br>
<br>
git://<a href=3D"http://git.kernel.org/pub/scm/linux/kernel/git/backports/b=
ackports.git" target=3D"_blank">git.kernel.org/pub/scm/linux/kernel/git/bac=
kports/backports.git</a><br>
<br>
I just pushed out two tags I forgot to peg based on the new updates<br>
form yesterday so if you have a fresh tree just git fetch --tags.<br>
<br>
&gt; Basically here is my problem: The older nodes use a non-pae kernel, bu=
t some<br>
&gt; of the newer wifi cards require the new iwlwifi driver. I&#39;m trying=
 to build<br>
&gt; the iwlwifi module against my current running kernel 3.2.0-60-generic.=
 To<br>
&gt; that end I cloned the linux backports and hopped to the linux-3.2.y br=
anch.<br>
&gt; But from here I don&#39;t know where to go. =A0Can I just slice out th=
e iwlwifi<br>
&gt; directory =A0and graft it onto my existing source tree?<br>
<br>
Sure, but a few notes. The branch on backports for linux-3.2.y is for<br>
the respective linux-stable.git tree and its own linux-3.2.y branch.<br>
If you want the latest you have the option of either using Linus&#39; tree<=
br>
and hopping on v3.14 (later Greg will have started a linux-3.14.y<br>
branch on linux-stable.git) and using the backports linux-3.14.y<br>
branch. If you want the very latest and greatest you can just stick to<br>
the master branch of backports, and do git describe. That will tell<br>
you the respective linux-next tag that you should use so<br>
backports-20140320 tag right now means that you should have a<br>
linux-next that is caught up to next-20140320. If you hop onto the<br>
backports linux-3.14.y branch it is designed for the linux-stable.git<br>
tree and if Greg hasn&#39;t pushed updates to it for v3.14 yet you can<br>
just use Linus&#39; tree and &#39;git reset --hard v3.14&#39; to force it t=
o<br>
rewind to v3.14.<br>
<br>
Since its a pain to expect folks to juggle tons of trees well (Linus&#39;<b=
r>
tree, linux-stable.git, linux-next.git) and also the ksrc-backports<br>
directory which we use to carry all the stable kernels headers we<br>
support in case you want to test compile something accross all kernels<br>
with ckmake, we provide a python script that does all the tree<br>
management / synchs for you. On a clean system as a regular user in<br>
your home directory you can just run:<br>
<br>
devel/backports-update-manager<br>
<br>
That&#39;ll do all the synching for you. In the next linux-next iteration<b=
r>
I hope to nuke a whole bunch of old kernels and get us to only require<br>
supporting up to 3.2. so you&#39;ll need to run this then if you&#39;re a<b=
r>
developer and wish to also nuke all the old junk.<br>
<br>
Another option is for you to wait for a release to be kicked out on<br>
the release page:<br>
<br>
<br>
=A0 Luis<br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div dir=3D"=
ltr"><div><span style=3D"color:rgb(0,0,0);font-family:Arial,Helvetica,sans-=
serif;font-size:11px;text-align:-webkit-center">Shridatt Sugrim</span></div=
>
<div><span style=3D"color:rgb(0,0,0);font-family:Arial,Helvetica,sans-serif=
;font-size:11px;text-align:-webkit-center">Winlab</span></div><span style=
=3D"color:rgb(0,0,0);font-family:Arial,Helvetica,sans-serif;font-size:11px;=
text-align:-webkit-center">Rutgers, The State University of New Jersey</spa=
n><br style=3D"color:rgb(0,0,0);font-family:Arial,Helvetica,sans-serif;font=
-size:11px;text-align:-webkit-center">
<span style=3D"color:rgb(0,0,0);font-family:Arial,Helvetica,sans-serif;font=
-size:11px;text-align:-webkit-center">Technology Centre of New Jersey</span=
><br style=3D"color:rgb(0,0,0);font-family:Arial,Helvetica,sans-serif;font-=
size:11px;text-align:-webkit-center">
<span style=3D"color:rgb(0,0,0);font-family:Arial,Helvetica,sans-serif;font=
-size:11px;text-align:-webkit-center">671 Route 1 South</span><br style=3D"=
color:rgb(0,0,0);font-family:Arial,Helvetica,sans-serif;font-size:11px;text=
-align:-webkit-center">
<span style=3D"color:rgb(0,0,0);font-family:Arial,Helvetica,sans-serif;font=
-size:11px;text-align:-webkit-center">North Brunswick, NJ 08902-3390</span>=
<br style=3D"color:rgb(0,0,0);font-family:Arial,Helvetica,sans-serif;font-s=
ize:11px;text-align:-webkit-center">
<span style=3D"color:rgb(0,0,0);font-family:Arial,Helvetica,sans-serif;font=
-size:11px;text-align:-webkit-center">732-932-6857 - Phone=A0=A0=A0 732-932=
-6882 -=A0Fax</span><br></div>
</div>

--047d7b5d5b0a02e9be04f6b3c51a--
