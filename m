MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <1363790495.31336.51.camel@deadeye.wl.decadent.org.uk>
References: <20130317144603.GA4850@stt008.linux.site>
	<1363532310.3937.266.camel@deadeye.wl.decadent.org.uk>
	<20130317152428.GA4940@stt008.linux.site>
	<1363544257.3937.278.camel@deadeye.wl.decadent.org.uk>
	<1363556604.3937.285.camel@deadeye.wl.decadent.org.uk>
	<CAB=NE6UPgjOXi7wWBmA5XVHY8MMcf6KwqSWxWViM6kiJYpV0tA@mail.gmail.com>
	<1363790495.31336.51.camel@deadeye.wl.decadent.org.uk>
Date: Wed, 20 Mar 2013 08:50:15 -0700
Message-ID: <CAB=NE6UZ+RvFHyzUhSwzATnkd9gAGa0EKDQD+U9vxVM8FSvLrA@mail.gmail.com>
Subject: Re: Bug#703142: compatibility with alx ?
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: backports@vger.kernel.org, 703142@bugs.debian.org,
	=?UTF-8?B?Q2FtYWxlw7Nu?= <noelamac@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Wed, Mar 20, 2013 at 7:41 AM, Ben Hutchings <ben@decadent.org.uk> wrote:
> On Wed, 2013-03-20 at 02:07 -0700, Luis R. Rodriguez wrote:
>> On Sun, Mar 17, 2013 at 2:43 PM, Ben Hutchings <ben@decadent.org.uk> wro=
te:
>> > [Re-sending to the correct list address.]
>> >
>> > On Sun, 2013-03-17 at 16:24 +0100, Camale=C3=B3n wrote:
>> >> El 2013-03-17 a las 14:58 +0000, Ben Hutchings escribi=C3=B3:
>> >>
>> >> > On Sun, 2013-03-17 at 15:46 +0100, Camale=C3=B3n wrote:
>> >>
>> >> (...)
>> >>
>> >> > > Using Debian's stock network driver is not an option for me (full=
 report
>> >> > > available here=C2=B2) so I have to try with the latests drivers b=
ut now that
>> >> > > "compat-drivers" are compiled the generated modules cannot be loa=
ded.
>> >> > >
>> >> > > Is there any by-pass for this?
>> >> > >
>> >> > > =C2=B9http://marc.info/?t=3D136351034300002&r=3D1&w=3D2
>> >> > > =C2=B2http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D664767
>> >> >
>> >> > Talk to the compat-drivers developers.
>> >>
>> >> To be sincere, I don't think that's a user's role.
>> >>
>> >> I don't know what's going on with these drivers but if they are not
>> >> supported by Debian at all it would be better for all of us (plain
>> >> users and developers) to simply say it so to avoid wasting time and
>> >> resources.
>> >
>> > I would like to support them, in fact more than that I would like to
>> > integrate them into official packages.  But there is no way we can
>> > support an OOT module that defines symbols that we might need to add f=
or
>> > our own backports.  As it is 'compat' will ironically cause
>> > incompatibility with Debian's own kernel upgrades.
>> >
>> > Compat developers: please add a prefix (not 'compat', that one's alrea=
dy
>> > taken!)
>>
>> We have been using compat_ for a while now to prefix a lot of our
>> symbols without clashes for the 32-64 compat stuff, but sure -- we can
>> use something else to help with any theoretical issues. Surprised
>> Debian of all distributions would frankly have been affected given
>> RHEL / SUSE didn't, but its OK, lets deal with it.
>
> The conflict that just showed up in Debian involved the 'i2c_bit_algo'
> symbol which had no symbol prefix in 'compat'.  We updated the in-tree
> DRM drivers from 3.4.32 and started exporting the symbol from
> i2c-algo-bit itself.
>
> I hadn't noticed that you already used the 'compat_' prefix for some
> exported symbols and I'm not aware of any current conflict with the
> 32-bit compatibility layer, but it seems plausible that it could happen
> in future.

Sure, let me know what you think of the proposed posted changes.

  Luis
