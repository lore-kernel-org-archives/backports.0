Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:57814 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753578Ab3E1TmL (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 28 May 2013 15:42:11 -0400
Message-ID: <1369770120.8548.19.camel@jlt4.sipsolutions.net> (sfid-20130528_214213_789304_CD025ED4)
Subject: Re: [PATCH v3 8/8] gentree.py: add kernel upload support
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Tue, 28 May 2013 21:42:00 +0200
In-Reply-To: <CAB=NE6WG7mYYgWb=Xsx8qc14BwAEdfR6s7bspCegTWg8moi6WQ@mail.gmail.com> (sfid-20130528_213457_867075_E7EB33B8)
References: <1369278956-17550-1-git-send-email-mcgrof@do-not-panic.com>
	 <1369278956-17550-9-git-send-email-mcgrof@do-not-panic.com>
	 <1369325176.12002.31.camel@jlt4.sipsolutions.net>
	 <CAB=NE6WG7mYYgWb=Xsx8qc14BwAEdfR6s7bspCegTWg8moi6WQ@mail.gmail.com>
	 (sfid-20130528_213457_867075_E7EB33B8)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2013-05-28 at 12:34 -0700, Luis R. Rodriguez wrote:

> OK so I figured it'd be good to lay out a defined pattern for
> releases. Based on previous releases and practices this is defined on
> the documentation of upload_release(). Given that in this iteration
> --git-revision is not used *and* that older releases had -snpc
> possible tags and that these additional postfix arguments were never
> used as part of the signed digital tag on the tree for releases this
> routine:
> 
> 1) verifies that rules on upload_release() are followed
> 2) throws back the expected git tag on the backports tree
> 3) throws back the list of directories that need to be created, given
> kup does not support mkdir -p, and given that the directory path
> varies if its a stable release also determine if its a stable release
> or not

Huh, ok ... whatever ;-)

> > Also, what's with the dict? Why
> > not just return a tuple:
> >         return (is_stable, rel_tag, paths)
> 
> Just what I have been used to, is tuple preferred in the Python world
> in these cases where you have to return multiple data?

It seems to mostly be, unless the keys are in some way dynamic. I'll bet
you can find somebody with another opinion though ;-)

> >> +    parent = os.path.dirname(args.outdir)
> >> +    release = os.path.basename(args.outdir)
> >> +    tar_name = parent + '/' + release + ".tar"
> >> +    bzip2_name = tar_name + ".bz2"
> >> +
> >> +    create_tar_and_bz2(tar_name, args.outdir)
> >
> > I'd recommend creating it in a temporary directory.
> 
> Under what parent directory?
> 
> > In fact, I'd
> > recommend making args.outdir optional in this case (which needs some
> > refactoring) and making _it_ a subdir in a temp directory too?
> 
> Sure, but what parent directory to use then?

Well I have this pattern a few times in git-tracker, just create and
nuke a temp dir, that's totally easy here:

from lib import tempdir # shipped in the backport sources

with tempdir.tempdir() as my_tempdir:
   os.chdir(my_tempdir)

or whatever. It'll be nuked after the with block finishes.

> > That may just be me, but maybe you should be consistent and put more
> > things on one line (or reformat the other lines?)
> 
> I'm more of a fan of the later given that then patches address
> argument per argument. Will send a patch for that, or address this
> after.

makes sense.

> >> @@ -309,10 +490,48 @@ def process(kerneldir, outdir, copy_list_file, git_revision=None,
> >>              self.gitdebug = gitdebug
> >>              self.verbose = verbose
> >>              self.extra_driver = extra_driver
> >> +            self.kup = kup
> >> +            self.kup_test = kup_test
> >> +    def git_paranoia(tree=None, logwrite=lambda x:None):
> >
> > This is a really strange place to define a function?
> 
> It didn't seem to make sense to share this globally on the file. Is
> this not good practice?

*shrug*
It seems weird to me, but then I mostly live in a C world :)

> >>      # start processing ...
> >> +    if (args.kup or args.kup_test):
> >> +        git_paranoia(source_dir, logwrite)
> >
> > This part might not be handled by my git-revision suggestion, but then
> > maybe it'd be better to actually point the scripting to a
> 
> It seems you left off writing what you wanted to on this part of the
> thread. I would assume you were alluding to the idea that perhaps its
> good to point the script to a backports git tag to use to check out as
> well ?

Heh. Yeah, I guess I'm slowly losing it ...

Yes, I think I meant that.

> >> +        rel_describe = git.describe(rev=None, tree=source_dir, extra_args=['--dirty'])
> >> +        release = os.path.basename(args.outdir)
> >
> > Taking the file path for a release description seems like a strange
> > thing to do? Maybe you should pass it on the command line?
> 
> Indeed, this is just trying to reuse the args.outdir 

Well I'm not sure I'd use the outdir, that also seems a bit odd.
Actually the thing is, you don't actually _want_ an outdir. In this
case, where you're directly uploading, you don't care about the interim
result at all, you only care about the tarball & it being uploaded. You
could completely work in a temp dir.

That makes me think that maybe this all should be a wrapper script kinda
like git-tracker? A separate tool that just calls into this after doing
all the paranoia stuff?

Although then I'd still recommend using (the equivalent of)
--git-revision to avoid all the paranoia stuff and potential races with
it.

johannes


