Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:57948 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755546Ab3E1URn (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 28 May 2013 16:17:43 -0400
Message-ID: <1369772251.8548.25.camel@jlt4.sipsolutions.net> (sfid-20130528_221745_321672_AE5BE91D)
Subject: Re: [PATCH 6/9] lib/bpgit.py: add support for git paranoia
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Tue, 28 May 2013 22:17:31 +0200
In-Reply-To: <CAB=NE6VY=BAxfs9MCXxc8=fabt0bBbmcTwr7rovRG42ZUvEATA@mail.gmail.com> (sfid-20130528_220232_801968_6B5C331B)
References: <1369222478-30577-1-git-send-email-mcgrof@do-not-panic.com>
	 <1369222478-30577-7-git-send-email-mcgrof@do-not-panic.com>
	 <1369224306.8207.7.camel@jlt4.sipsolutions.net>
	 <CAB=NE6WxO3tUjuK4gzxPSg+sukHB=ApxLr8F++Y+F2887=DW=Q@mail.gmail.com>
	 <1369322755.12002.21.camel@jlt4.sipsolutions.net>
	 <CAB=NE6UwkAunmKGLutnHsUjSYXv34zQ2n1eVUc3jTsE=9vWejg@mail.gmail.com>
	 <CAB=NE6VY=BAxfs9MCXxc8=fabt0bBbmcTwr7rovRG42ZUvEATA@mail.gmail.com>
	 (sfid-20130528_220232_801968_6B5C331B)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2013-05-28 at 13:02 -0700, Luis R. Rodriguez wrote:
> On Thu, May 23, 2013 at 2:02 PM, Luis R. Rodriguez
> <mcgrof@do-not-panic.com> wrote:
> > I see what you're saying now and I actually did consider it, the
> > reason I didn't use --git-revision is speed. Git reset --hard tag, and
> > then copying the code directly is a lot faster. The race issues you
> > point out though are worth reconsidering this though.
> 
> I've given this some thought and I find that the theoretical race
> conditions also applies even if you use --git-revision on the output
> path.

Well, to be honest, you have to trust the system anyway, otherwise it
can mess up completely. So I guess the race is pretty much unimportant.
It was just an additional thing to consider, more in case you start this
as a long-running process and then (accidentally) work with the
linux-next tree in another way.

However I'd argue that since the git object database would typically be
corrupted by changes impacting --git-revision usage, it's still a lot
safer than using checkouts.

> A true paranoid release model would then have a target output
> directory only the parent process and children could modify / update
> but given it seems we have considerations for non ext[34] filesystems
> (recent kconfig patch) its unclear we could resolve this for the truly
> paranoid. The speed considerations I raised then (10 seconds as of
> next-20130523 with python-git installed) could be discarded in favor
> of consistency of just using --git-revision for a release model
> provided we also address the RELMOD_UPDATE and RELMOD_TYPE
> specification for both daily and stable releases, defined on the
> upload_release() documentation. Right now we infer RELMOD_UPDATE based
> on the output directory but inferring RELMOD_TYPE from the same target
> output directory would be sloppy IMO so tackling these two with
> --git-revision would need to be addressed.

Well like I said before, I think you should probably just write a
separate script (possibly as a devel/ script) that you'd do something
like

./devel/gen-and-kup.py /path/to/linux-next/ next-20130528

and then it would internally create a temporary directory (with tempdir
thing) and run something like
./gentree.py --git-revision next-20130528 /path/to/linux-next/ /tmp/tmpdir/<relname>/

(obviously not calling the script but rather the function like
git-tracker does)

and then work in /tmp/tmpdir/ to create the tarball etc. That way, you
don't have temporary stuff lying around after the generation, and get
rid of many of the changes you're making here since you wouldn't need
the paranoia stuff.

johannes

