MIME-Version: 1.0
Sender: mcgrof@gmail.com
Date: Thu, 1 Nov 2012 20:09:15 -0700
Message-ID: <CAB=NE6Xv5Lag0J2U3CHK9huzMQLyJEZmdrcqWWomn48w=xUnag@mail.gmail.com>
Subject: Expressing linux-next collateral evolutions in formal grammar
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Julia Lawall <julia.lawall@lip6.fr>,
	Konstantin Ryabitsev <mricon@kernel.org>, "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

I think by now quite a few amount of folks understand that SmPL can be
used to express collateral evolutions for Linux kernel development.
Obviously some collateral evolutions are not expressed this way though
but Julia and her team have been working on research that would enable
for one to infer such SmPL grammar by analyzing deltas. There is a few
software tools now that start to do this and I think that to help with
reviewing changes it would help us in the community to spread more
education on SmPL grammar and to allow us to become more efficient at
reviewing changes. For a while now Julia has been working on getting
some form of SmPL grammar from linux-next git tag updates, from one
tag to the next. I toyed with Julia the idea recently of perhaps this
being useful to others and if we could point a link to these from lwn
or any other place. My hope would be that collateral evolutions then
would then be easily reviewable folks, in case one did not want to
read a full diff between the tags.

Technically one next tag from the other though are not a linear
evolutions though, so a proper evolution expression for a release
would be from mainline to that day's tag, however being able to
visualize a grammar on the evolutions would still be nice if possible
-- and I think it is. Wanted to review with you all the idea of
possibly linking to collateral evolutions in SmPL grammer from lwn, or
if perhaps kernel.org somewhere.

The way I would envision this to be easier to manage is to break them
down by subsystem and the reviewer can then go and read the grammar
for their own subsystem of preference. The long term benefit of this
is that even if folks don't use SmPL for collateral evolutions we have
a possibility here of being able to backport a collateral evolution by
using the inverse of the SmPL grammar, if we can get to the point of
coming up with formal and proper grammar on each collateral evolution.

Thoughts?

  Luis
