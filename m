MIME-Version: 1.0
In-Reply-To: <5092BF58.1040703@hauke-m.de>
References: <5092BF58.1040703@hauke-m.de>
Date: Sun, 4 Nov 2012 09:45:13 -0800
Message-ID: <CAB=NE6V=jDwg71Cgv4+N3EAWLGAC5UzRw2cg9if7tF+YDLuvDA@mail.gmail.com>
Subject: Re: Donwload locations and wiki structure
From: "Luis R. Rodriguez" <mcgrof@gmail.com>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Thu, Nov 1, 2012 at 11:28 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> Hi Luis,
>
> When I visit the backport wiki [0], I am missing the word download.
> The section name "compat-drivers releases" should better be named:
> "compat-drivers releases downloads". ;-)
>
> The change from compat-wireless to compat-drivers was more a rename than
> a very big change, why don't you link the old stable releases on the
> release page, I think most of the stable page should be integrated into
> the new release page?

Ah, well this is where things get a bit tricky. Part of folding into
kernel.org brings a new set of release best practices. This includes
signing each tarball and of course a well trusted key to be used for
releases.

> As automatically uploading to https://www.kernel.org does not work, it
> is not a suitable place to store the daily snapshots of compat-drivers,
> they are better localed at the other positions and the two releases at
> kernel.org should be removed.

I am open to point to non-signed releases but I do see benefit on the
signed releases. This does however mean that these have to be uploaded
manually but I see no issue with hosting the signed daily releases
when we get to them.

> Putting all the snapshots into one directory on the download server gets
> messy with the daily releases, the old structure with /year/month/
> folders was better. The cmake reports should go into an own subdirectory
> as most of the users are not interested in them. A symlink to the latest
> release in the root folder would be nice.

The ckmake thing was a pain in the ass to be generating so for now
I've considered simply ignoring this and ensuring we on the backend do
them prior to releases or tagging. Thoughts?

> I just want to hear you opinion on this and would try to solve some of
> these things by myself.

I'm in agreement with you except that I see value into the signing
process on kernel.org releases and at the same time the as you point
out the rename was more a small change but at the same time lets not
forget the philosophical change on the project to embrace subsystems
other than networking mainly due to Ozan's work.

As for a release page, I have been working on a shiny release page for
kernel.org and am trying to mimic the same behaviour kernel releases
mainly to make the release page adaptable to both. That is, perhaps
one release page generator can be used for the other. This of course
can only be evaluated once I can release that script that generates a
shiny release page... and for that I am still awaiting approval from
some legal team... as silly as it sounds.

  Luis
