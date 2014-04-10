Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <loren@dropcam.com>
Return-Path: <loren@dropcam.com>
Content-Type: multipart/alternative; boundary="Apple-Mail=_4EA4CC97-F702-4C74-8D47-17C468DE3C4C"
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: Bumping required kernels to 3.0 for Linux backports ?
From: Loren Kirkby <loren@dropcam.com>
In-Reply-To: <5346CF27.3070406@broadcom.com>
Date: Thu, 10 Apr 2014 10:24:20 -0700
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
 arend@broadcom.com
Message-Id: <A487A165-E107-432E-90AF-4CD49956B086@dropcam.com>
References: <CAB=NE6VvyBKzEg=ErZzQMktY8eLytQ21JCPrOQbxvZ9m-nqHkw@mail.gmail.com> <53451077.2030102@openwrt.org> <CAB=NE6UUN4vQd3SpsvO5tcgaYq3YXQeE0KtZGki7p7OnR=J4RA@mail.gmail.com> <20140409191225.GA10560@kroah.com> <CAB=NE6VqY8yXoYuE0o01vq86imY8EtqLdkPa4bGMvR3bTaj5KQ@mail.gmail.com> <20140409202224.GA12953@kroah.com> <CAB=NE6XY5++p7hJQpQdwrFNUcGbUsKpC+oJiZQciXNduo+8j8A@mail.gmail.com> <20140409210613.GA14392@kroah.com> <s5heh15pr18.wl%tiwai@suse.de> <CAB=NE6VeNTFeGxKXpYunkU-W=JPLMpOnrehttvsqB+yXkdz5fg@mail.gmail.com> <5346CF27.3070406@broadcom.com>
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
List-ID: <backports@vger.kernel.org>


--Apple-Mail=_4EA4CC97-F702-4C74-8D47-17C468DE3C4C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

On Apr 10, 2014, at 10:04 AM, Arend van Spriel <arend@broadcom.com> =
wrote:

> On 04/10/14 18:59, Luis R. Rodriguez wrote:
>> On Thu, Apr 10, 2014 at 12:44 AM, Takashi Iwai<tiwai@suse.de>  wrote:
>>> At Wed, 9 Apr 2014 14:06:13 -0700,
>>> Greg Kroah-Hartman wrote:
>>>>=20
>>>> On Wed, Apr 09, 2014 at 01:52:29PM -0700, Luis R. Rodriguez wrote:
>>>>> On Wed, Apr 9, 2014 at 1:22 PM, Greg Kroah-Hartman
>>>>> <gregkh@linuxfoundation.org>  wrote:
>>>>>> On Wed, Apr 09, 2014 at 01:01:23PM -0700, Luis R. Rodriguez =
wrote:
>>>>>>> On Wed, Apr 9, 2014 at 12:12 PM, Greg Kroah-Hartman
>>>>>>> <gregkh@linuxfoundation.org>  wrote:
>>>>>>>> On Wed, Apr 09, 2014 at 11:28:55AM -0700, Luis R. Rodriguez =
wrote:
>>>>>>>>> On Wed, Apr 9, 2014 at 2:18 AM, Felix Fietkau<nbd@openwrt.org> =
 wrote:
>>>>>>>>>> The oldest kernel in OpenWrt that we're still supporting with =
updates of
>>>>>>>>>> the backports tree is 3.3, so raising the minimum requirement =
to 3.0 is
>>>>>>>>>> completely fine with me.
>>>>>>>>>=20
>>>>>>>>> OK note that 3.3 is not listed on kernel.org as supported. I'm =
fine in
>>>>>>>>> carrying the stuff for those for now but ultimately it'd also =
be nice
>>>>>>>>> if we didn't even have to test the kernels in between which =
are not
>>>>>>>>> listed. This does however raise the question of how often a =
kernel in
>>>>>>>>> between a list of supported kernels gets picked up to be =
supported
>>>>>>>>> eventually. Greg, Jiri, do you happen to know what the =
likelyhood of
>>>>>>>>> that can be?
>>>>>>>>=20
>>>>>>>> I don't know of anything ever getting picked up after I have =
said it
>>>>>>>> would not be supported anymore.
>>>>>>>=20
>>>>>>> Great! How soon after a release do you mention whether or not it =
will
>>>>>>> be supported? Like say, 3.14, which was just released.
>>>>>>=20
>>>>>> I only mention it around the time that it would normally go =
end-of-life.
>>>>>>=20
>>>>>> For example, if 3.13 were to be a release that was going to be =
"long
>>>>>> term", I would only say something around the normal time I would =
be no
>>>>>> longer supporting it.  Like in 2-3 weeks from now.
>>>>>>=20
>>>>>> So for 3.14, I'll not say anything about that until 3.16-rc1 is =
out,
>>>>>> give or take a week or two.
>>>>>>=20
>>>>>>> Also, as of late are you aware any distribution picking an =
unsupported
>>>>>>> kernel for their next choice of kernel?
>>>>>>=20
>>>>>> Sure, lots do, as they don't line up with my release cycles (I =
only pick
>>>>>> 1 long term kernel to maintain each year).  Look at the Ubuntu =
releases
>>>>>> for examples of that.  Also openSUSE and Fedora (although Fedora =
does
>>>>>> rev their kernel pretty regularly) don't usually line up.  The
>>>>>> "enterprise" distros are different, but even then, they don't =
always
>>>>>> line up either (which is why Jiri is maintaining 3.12...)
>>>>>>=20
>>>>>> Hope this helps,
>>>>>=20
>>>>> It does! Unless I don't hear any complaints then given that some
>>>>> distributions might choose a kernel in between and given also your
>>>>> great documented story behind the gains on trying to steer folks
>>>>> together on the 'ol 2.6.32 [0] and this now being faded, I'll be
>>>>> bumping backports to only support>=3D 3.0 soon, but we'll include =
all
>>>>> the series from 3.0 up to the latest. That should shrink compile /
>>>>> test time / support time on backports to 1/2.
>>>>=20
>>>> Why 3.0?  That's not supported by anyone anymore for "new =
hardware", I'd
>>>> move to 3.2 if you could, as that's the Debian stable release that =
will
>>>> be maintained for quite some time yet:
>>>>       https://www.kernel.org/category/releases.html
>>>=20
>>> Well, the support for "new hardware" is what backports project =
itself
>>> does, isn't it?
>>>=20
>>> Besides, SLES11 is still supported, so yes, including 3.0.x would be
>>> helpful.
>>=20
>> That's two stakeholders for 3.0 -- but nothing is voiced for anything
>> older than that. Today I will rip the older kernels into oblivion.
>> Thanks for all the feedback!
>=20
> Ok, I guess my voice was cracking when I mentioned 2.6.38 as being =
used over here. I am probably alone in that desert.
>=20
> Regards,
> Arend

You=92re not alone.  :)  We use 2.6.38 over here at Dropcam and use =
backports for the Bluetooth subsystem (and HCI UART driver). =20

Many thanks to everybody involved =97 b	ackports is a really amazing =
project.

Cheers,
Loren Kirkby
Dropcam


--Apple-Mail=_4EA4CC97-F702-4C74-8D47-17C468DE3C4C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=windows-1252

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dwindows-1252"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;">On Apr =
10, 2014, at 10:04 AM, Arend van Spriel &lt;<a =
href=3D"mailto:arend@broadcom.com">arend@broadcom.com</a>&gt; =
wrote:<br><div><br class=3D"Apple-interchange-newline"><blockquote =
type=3D"cite"><div style=3D"font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px;">On 04/10/14 18:59, Luis R. =
Rodriguez wrote:<br><blockquote type=3D"cite">On Thu, Apr 10, 2014 at =
12:44 AM, Takashi Iwai&lt;<a =
href=3D"mailto:tiwai@suse.de">tiwai@suse.de</a>&gt; =
&nbsp;wrote:<br><blockquote type=3D"cite">At Wed, 9 Apr 2014 14:06:13 =
-0700,<br>Greg Kroah-Hartman wrote:<br><blockquote type=3D"cite"><br>On =
Wed, Apr 09, 2014 at 01:52:29PM -0700, Luis R. Rodriguez =
wrote:<br><blockquote type=3D"cite">On Wed, Apr 9, 2014 at 1:22 PM, Greg =
Kroah-Hartman<br>&lt;<a =
href=3D"mailto:gregkh@linuxfoundation.org">gregkh@linuxfoundation.org</a>&=
gt; &nbsp;wrote:<br><blockquote type=3D"cite">On Wed, Apr 09, 2014 at =
01:01:23PM -0700, Luis R. Rodriguez wrote:<br><blockquote type=3D"cite">On=
 Wed, Apr 9, 2014 at 12:12 PM, Greg Kroah-Hartman<br>&lt;<a =
href=3D"mailto:gregkh@linuxfoundation.org">gregkh@linuxfoundation.org</a>&=
gt; &nbsp;wrote:<br><blockquote type=3D"cite">On Wed, Apr 09, 2014 at =
11:28:55AM -0700, Luis R. Rodriguez wrote:<br><blockquote type=3D"cite">On=
 Wed, Apr 9, 2014 at 2:18 AM, Felix Fietkau&lt;<a =
href=3D"mailto:nbd@openwrt.org">nbd@openwrt.org</a>&gt; =
&nbsp;wrote:<br><blockquote type=3D"cite">The oldest kernel in OpenWrt =
that we're still supporting with updates of<br>the backports tree is =
3.3, so raising the minimum requirement to 3.0 is<br>completely fine =
with me.<br></blockquote><br>OK note that 3.3 is not listed on <a =
href=3D"http://kernel.org">kernel.org</a> as supported. I'm fine =
in<br>carrying the stuff for those for now but ultimately it'd also be =
nice<br>if we didn't even have to test the kernels in between which are =
not<br>listed. This does however raise the question of how often a =
kernel in<br>between a list of supported kernels gets picked up to be =
supported<br>eventually. Greg, Jiri, do you happen to know what the =
likelyhood of<br>that can be?<br></blockquote><br>I don't know of =
anything ever getting picked up after I have said it<br>would not be =
supported anymore.<br></blockquote><br>Great! How soon after a release =
do you mention whether or not it will<br>be supported? Like say, 3.14, =
which was just released.<br></blockquote><br>I only mention it around =
the time that it would normally go end-of-life.<br><br>For example, if =
3.13 were to be a release that was going to be "long<br>term", I would =
only say something around the normal time I would be no<br>longer =
supporting it. &nbsp;Like in 2-3 weeks from now.<br><br>So for 3.14, =
I'll not say anything about that until 3.16-rc1 is out,<br>give or take =
a week or two.<br><br><blockquote type=3D"cite">Also, as of late are you =
aware any distribution picking an unsupported<br>kernel for their next =
choice of kernel?<br></blockquote><br>Sure, lots do, as they don't line =
up with my release cycles (I only pick<br>1 long term kernel to maintain =
each year). &nbsp;Look at the Ubuntu releases<br>for examples of that. =
&nbsp;Also openSUSE and Fedora (although Fedora does<br>rev their kernel =
pretty regularly) don't usually line up. &nbsp;The<br>"enterprise" =
distros are different, but even then, they don't always<br>line up =
either (which is why Jiri is maintaining 3.12...)<br><br>Hope this =
helps,<br></blockquote><br>It does! Unless I don't hear any complaints =
then given that some<br>distributions might choose a kernel in between =
and given also your<br>great documented story behind the gains on trying =
to steer folks<br>together on the 'ol 2.6.32 [0] and this now being =
faded, I'll be<br>bumping backports to only support&gt;=3D 3.0 soon, but =
we'll include all<br>the series from 3.0 up to the latest. That should =
shrink compile /<br>test time / support time on backports to =
1/2.<br></blockquote><br>Why 3.0? &nbsp;That's not supported by anyone =
anymore for "new hardware", I'd<br>move to 3.2 if you could, as that's =
the Debian stable release that will<br>be maintained for quite some time =
yet:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a =
href=3D"https://www.kernel.org/category/releases.html">https://www.kernel.=
org/category/releases.html</a><br></blockquote><br>Well, the support for =
"new hardware" is what backports project itself<br>does, isn't =
it?<br><br>Besides, SLES11 is still supported, so yes, including 3.0.x =
would be<br>helpful.<br></blockquote><br>That's two stakeholders for 3.0 =
-- but nothing is voiced for anything<br>older than that. Today I will =
rip the older kernels into oblivion.<br>Thanks for all the =
feedback!<br></blockquote><br>Ok, I guess my voice was cracking when I =
mentioned 2.6.38 as being used over here. I am probably alone in that =
desert.<br><br>Regards,<br>Arend<br></div></blockquote><br></div><div>You=92=
re not alone. &nbsp;:) &nbsp;We use 2.6.38 over here at Dropcam and use =
backports for the Bluetooth subsystem (and HCI UART driver). =
&nbsp;</div><div><br></div><div>Many thanks to everybody involved =97 =
b<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>ackports is a really amazing =
project.</div><div><br></div><div>Cheers,</div><div>Loren =
Kirkby</div><div>Dropcam</div><br></body></html>=

--Apple-Mail=_4EA4CC97-F702-4C74-8D47-17C468DE3C4C--
