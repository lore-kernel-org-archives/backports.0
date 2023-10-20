Return-Path: <backports-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B99FCDB474
	for <backports@archiver.kernel.org>; Fri, 20 Oct 2023 07:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376359AbjJTHeq (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 20 Oct 2023 03:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376317AbjJTHep (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 20 Oct 2023 03:34:45 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D03291
        for <backports@vger.kernel.org>; Fri, 20 Oct 2023 00:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=H7lkyymJgDnjkbsI2v2K61OBYiYCqMz90V6qOMWOS/Y=;
        t=1697787282; x=1698996882; b=axkxnksQ3VNrBKPNRk0K02yGO/OAtig66VssCPLkA4YiyKL
        2uK92dzpQUBSuI1uPrV+tfRw8NAlVB1KnEOAwXVQcV49SZg8QLdoCTVQZbJQ1rgeL+1WUYLUodpra
        5M/Fo357P9a1aKERy3lkAycUYcTqxRCfWbNyvjrFXzsbkeZGuleQynhhzx3KLsDJKoqTHbarMRCsa
        arfhwFI06GFRc7+g0eC0aCK4KqlT/jfTFDIX0x3zkgZkXZ0Lbne4hTlgzb2TxiHs2dWZMe/F0zMk+
        thJ3loNFMld3LUQ6Wnk7jWA5xCr+GhvZwMqCEQ2SRHEQhiha3vZ+FioeV3T4zlrw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qtk1n-0000000EPh9-0BZ9;
        Fri, 20 Oct 2023 09:34:39 +0200
Message-ID: <435c43bae693e72004c39ff90a901bc911ab1e6d.camel@sipsolutions.net>
Subject: Re: rtw88, rtw89 -- options for bringing a couple rtw standalone
 GitHub repos into backports.git
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Brian Witte <brianwitte@mailfence.com>, hauke@hauke-m.de,
        backports@vger.kernel.org
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Luis Chamberlain <mcgrof@kernel.org>
Date:   Fri, 20 Oct 2023 09:34:37 +0200
In-Reply-To: <831d1de6-5d02-43b9-b907-70d9f1a03cab@mailfence.com>
References: <831d1de6-5d02-43b9-b907-70d9f1a03cab@mailfence.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Hi,

> I just wanted to reach out about these repos and the options and=20
> tradeoffs with porting them over to the backports.git project in a way=
=20
> that will benefit the larger community and our existing users.

Can you explain what you're trying to achieve by that?

And even, what is the reason to have these out-of-tree versions of the
drivers?

The backports project doesn't in itself work with out-of-tree drivers.
It _creates_ out-of-tree drivers, yes, but it takes the source of these
always from the latest upstream kernel.

So since I'm not sure what the github trees are even used for, let's say

 1) these are used to provide additional fixes or hardware support over
    what the upstream kernel already has

   -> this is something backports will not support, the source driver
      must be fully upstream

      (OK, strictly speaking, that's not true - you could patch the
       upstream driver before generating backports, but that seems
       painful)

 2) these are just used to provide newer drivers to users of
    older kernels

   -> this is exactly what backports pretty much already does


> I am able to begin the work on these drivers if we decide to try and=20
> merge them into backports.git,
>=20

They probably already ship in the current backports, since we generally
include all wifi drivers. However, it hasn't gotten a lot of attention
in the past few years other than our (Intel's) internal maintenance for
iwlwifi.

> but I need to understand a few things=20
> since my understanding is often the biggest limitation in all of this.

Sure :)

> On more than one occasion, I have gotten confused about how Linux=20
> backports does things so I want to make sure I am making the right=20
> assumptions about how it works with respect to commit history and a few=
=20
> other things for their respective drivers.
>=20
> My current understanding re: commit history is as follows:
>=20
> The main Linux backports project does not preserve the commit history of=
=20
> individual drivers as they exist in their original trees that they are=
=20
> taken from.

Correct.

> The main goal of the backports project is taking code from=20
> newer Linux kernel versions and adapting them so they can be compiled=20
> and run on older kernel versions.=C2=A0

Yes.

> This backporting process is automated=20
> by applying a series of patches to make the newer code compatible with=
=20
> the older kernel via automation defined in the backports.git repo=20
> through Makefile, Kconfig, dependent .c or .h files, etc. and of course=
=20
> the "semantic patch language" scripts of coccinelle.

Yes.

> Because the goal is to make new code work with old kernels, rather than=
=20
> to maintain a faithful, version-controlled history of that code, the=20
> commit history for individual drivers is not included in project's=20
> focus. The version control history in the backports.git repository=20
> serves to track changes to the backporting process itself, rather than=
=20
> to preserve the history of the backported code (I know that may be=20
> obvious, but I need to make sure I am not mistaken.)

Yes.

There _is_ a script (devel/git-tracker.py) that can "port" over history
from an upstream tree to a backport-generated git tree, but I'm not sure
I'd generally recommend using it. It's geared fairly specifically to our
internal development process which is actually that people work in such
a backport tree (we even publish a version of it [1]).


[1]
https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/backport-iwlwifi.gi=
t/

> In a nutshell, the Linux backports project is geared towards=20
> compatibility and functionality, not towards historical preservation of=
=20
> codebase evolution.

It's just not relevant - the historical preservation of the code base
happens in the upstream Linux kernel project.


> The second thing I want to make sure I understand is how users can get=
=20
> backports for a driver via the Linux backports project:
>=20
> A happy path would look like them pulling down a tar of backports for=20
> their kernel version from=20
> https://cdn.kernel.org/pub/linux/kernel/projects/backports/stable/ and=
=20
> then running something like:
>=20
> ```sh
> # as a user
> make defconfig-rtlwifi
> make -j4
> # as root
> make install
> # reboot and enjoy
> ```

Yes, pretty much. It'd require someone actually maintaining backports
more reliably and creating packages though :)

> If a feature they need is not in a stable version, they will then have=
=20
> to execute a small series of extra steps to compile their own backports=
=20
> release and then use that; whether it's against linux-next or some other=
=20
> tree. This is a documented and relatively well-traveled path in kernel=
=20
> developer terms, but is likely out of reach for many "regular" users.=C2=
=A0

Well you could do that, but the backports maintainer could, in theory,
also offer a snapshot version.

This stuff is also fairly well scripted, I don't think it's _that_ much
more effort than "make ..." stuff above? Though it does require more
tooling (like spatch) to be installed.

> I=20
> think it is fair to say that this would require them to be a closer to a=
=20
> "developer" or experienced Linux user or administrator. They also may=20
> not know about or be able to find the docs for doing so. A GitHub repo=
=20
> with their device driver name is often what they find first.

If it exists ;-)


I mean, if you wanted that, you _could_ generate such a repo with
different tags/branches/etc. even with individual upstream commits using
the git-tracker tool. But it can take a long time to run and it's often
difficult to get the backports to even work for all individual commits,
so you'd probably care more about specific snapshots like RCs etc.

> The last thing I want to make sure I have straight is the value of=20
> backports.git for wireless drivers generally because there seem to be man=
y:
>=20
> For maintainers/developers, backports.git offers a standardized,=20
> automated system that minimizes errors, streamlines many aspects of=20
> building, testing, and iterating, and allows for community-vetted (more=
=20
> eyes), secure code. This centralization frees maintainers to focus on=20
> other development priorities like fixing/reproducing bugs and landing=20
> patches upstream.

Well, I think that's overselling it a bit, given that it's been
languishing. We could also probably contribute more fixes than we
currently did, purely based on our internal version.

But yeah, it was _meant_ to basically make it easier to do backports, by
having everyone pitch in together ... did that happen? Not that much.


> For users, backports.git provides a stable way to access these new=20
> features and fixes. It also can be quite simple if you have the right=20
> kernel version, it lines up with the feature you need, or you have the=
=20
> requisite experience and can find then dive into more "developer-like"=
=20
> documentation.

I'm not sure it's really easy to use right now because there's no
regular maintenance.

> For the community, integrating the drivers into backports.git
>=20

I'm not sure I'd argue there's even a notion of "integrating the drivers
into backports.git". After all, backports.git doesn't contain drivers.
Though yeah, arguably having a driver actually work with backports takes
some work on the backports side, something you could call "integration".

> holds=20
> benefits for downstream projects like OpenWrt, which already rely on=20
> backports as a core design feature. Therefore OpenWrt and similar=20
> projects can more seamlessly and securely include them in their=20
> distributions, enhancing both device support and the end-user=20
> experience. In addition, the upstream drivers benefit due to increased=
=20
> visibility and accessibility, encouraging wider community engagement for=
=20
> testing, bug reporting, and code contributions.

:)

> This approach serves to unify efforts, improve security, and facilitate=
=20
> a solid, shared pipeline for maintainers, users, and the larger community=
.
>=20
> In conclusion, there are a few questions I am trying to answer for=20
> myself, but could use any feedback on.
>=20
> 1. How critical is the preservation of commit history for effective=20
> debugging and bisecting when issues arise in the backported drivers? We=
=20
> have the commit history in our GitHub repos, but they would not be=20
> present in drivers compiled from backports.git. Is there a way to have=
=20
> "the best of both worlds" or mitigate the effects of lacking that history=
?

Like I said above, you _could_ use git-tracker and create a new backport
for every (relevant) upstream commit, but then you end up fixing a lot
of intermittent backport issues:
Say some commit is introduced upstream that makes a patch in backports
no longer apply, but then let's say that commit is reverted pretty soon.
If you just follow the RCs, you might never notice. If you follow
individual commits, you'd have to adjust backports *twice* over it.

> 2. Are there methods to automate or simplify the process for users who=
=20
> need features not yet available in stable releases, to reduce the skill=
=20
> barrier?

It's not _that_ hard, basically just running "./gentree.py ..."?

Not sure what we could simplify there.


> 3. How can I help the backports project directly (rtw related or not)?

Depends how much work you want to put in? I think what'd help most right
now would be to actually have someone to do what Hauke used to do, which
was integrating patches from the list (and we'd probably have more of
them), and creating releases.

> 4. How can we best leverage the years of effort and modifications (#if=
=20
> #else #endif macros) made by Larry in these stand-alone repositories to=
=20
> inform the technical work of porting them to the shared backports framewo=
rk?

That's tricky, I don't think there's a good way to leverage that
directly. Also, backports tries to _minimize_ the ifdefs needed in
favour of providing spatches and API changes.

Also, looking at the rtw89 repo, I notice that it _only_ contains the
driver and attempts to make it compatible with all mac80211 versions,
which we had previously though of as basically a losing proposition, and
so backports ships the _entire_ wireless stack so that the coupling
between cfg80211/mac80211/driver is maintained.

As a result, I think the only way to use this would be for inspiration
when looking at something that backports didn't (yet) handle (well).

> 5. Given the popularity and visibility of the rtw88 and rtw89 GitHub=20
> repositories, as indicated by their star counts, issue activity, and=20
> search engine ranking, what strategies can we employ to maintain this=20
> level of user engagement and support if we transition to backports.git?=
=20
> Would mirroring the code and providing custom-tailored instructions in=
=20
> the READMEs serve dual purposes of user support and elevating the=20
> visibility of backports.git in the larger community? Is this a welcomed=
=20
> proposition?

Given that nobody really seems to have much time to spend on the
backports project ... I think that'd be up to you.

You could generate backports for all Linux RCs and commit them to those
repos for example, in ascending order? You could even try to use the
git-tracker.py to generate individual commits, but as I described that
has some caveats. Or even provide linux-next snapshots in a separate
branch?

As long as you don't think of "backport outputs a tarball", I think you
can see a lot of choices, although not all of them will preserve a
patch-by-patch history of the driver.

> I understand that many of these questions ultimately require hands-on=20
> work and investigation on my part. However, I believe now is an=20
> opportune time to engage the community in these discussions.
>=20
> I will be attending the Linux Plumbers Conference next month on behalf=
=20
> of Larry and myself and would like to use this as a start to further=20
> explore potential collaborations and conversations around these topics.

Maybe Luis will be there? I won't.

> Lastly, I want to thank the backports.git maintainers for providing an=
=20
> invaluable tool for the Linux community. Also, thank you Luis for=20
> getting me started on having these conversations.

:)

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
