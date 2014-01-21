Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:35843 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754360AbaAUKY7 (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 21 Jan 2014 05:24:59 -0500
Message-ID: <1390299893.6199.20.camel@jlt4.sipsolutions.net> (sfid-20140121_112513_196708_E4050D73)
Subject: Re: [PATCH 1/3] backports: update patch Python library
From: Johannes Berg <johannes@sipsolutions.net>
To: anatoly techtonik <techtonik@gmail.com>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	backports@vger.kernel.org
Date: Tue, 21 Jan 2014 11:24:53 +0100
In-Reply-To: <CAPkN8xLXbxbus9itoxBm97aF_EwbwN1YBk=E1R9xBvX31xUSvQ@mail.gmail.com> (sfid-20140121_105618_119434_96DE16BE)
References: <1367895800-14305-1-git-send-email-mcgrof@do-not-panic.com>
	 <1367895800-14305-2-git-send-email-mcgrof@do-not-panic.com>
	 <1367933208.8328.11.camel@jlt4.sipsolutions.net>
	 <CAPkN8xJjvBFQJHaEu_yUsHaeDybws02NcfegdyXq_+RN-XssOQ@mail.gmail.com>
	 <1390215684.4335.17.camel@jlt4.sipsolutions.net>
	 <CAPkN8xLXbxbus9itoxBm97aF_EwbwN1YBk=E1R9xBvX31xUSvQ@mail.gmail.com>
	 (sfid-20140121_105618_119434_96DE16BE)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2014-01-21 at 12:55 +0300, anatoly techtonik wrote:

> >> patch.py is smart enough to strip only a/ and b/ prefixes, and do this
> >> automatically when it is needed.
> >
> > Well, yes, but it doesn't auto-detect other prefixes. So if I diff
> > something manually, then the prefixes aren't removed.
> 
> There are no other prefixes. Everything else are real directories that exist
> when you create the patch. Isn't it?

Well, it depends. You could make an "unmodified" copy of the code, and
put it into a directory

foo-project.orig/

and modify the copy in

foo-project/

and then diff there, and you'd end up with headers foo-project(.orig)/
and still have to use -p1 when applying the patch. That's the convent in
Linux, regardless of how you make those prefixes (manually like I just
described, or useless prefixes like git's a/ b/, or whatever)

> > As a result, I
> > must generate the patch using git if I want it to work right, or must go
> > against the -p1 convention when generating it manually. Both of those
> > are cumbersome and hard to remember.
> 
> Usually you need to rename old directory to something like:
> > myapp.old
> and then run 'diff -u3 myapp.old myapp'
> 
> No prefixes are added, and patch.py is smart enough to detect that
> there is no myapp.old and apply patch to the myapp/ directory
> (well, actually you need to make sure that myapp.old does not exist
> for patch.py to find myapp/).

Yeah, but the normal convention would be for a patch to have
"myapp.old/" in it, but the person applying it would go into "myapp/"
and use patch -p1.

> > IOW, you're assuming that a 'real patch' has no prefix, and a 'git
> > patch' has useless a/ and b/ prefixes. But that relies on a certain
> > convention about a 'real patch' which isn't true in the Linux community.
> 
> Yes, I want to know about those prefixes in Linux community, because
> I developed this tool on Windows and test database doesn't have any
> samples.

See above, pretty much :)

> > We use it to apply patches within the backport project, those patches
> > are stored in the project and applied against upstream Linux code.
> 
> Yes. I've seen that. =)
> 
> https://code.google.com/p/python-patch/wiki/Adoptions

:-)

> I more interested in complete like session recorded session, like
> standing behind the shoulder and watching, so that I can think on how
> to make patch.py usage more natural, rather than trying to instruct
> people how to use. But that's ideal case. I think that an exemplary
> shell session where the annoyance benefits itself would suffice.

Ah. There's no exemplary shell session. We just use it in a script, so
the shell session looks like

./gentree.py --some-options bla bla bla

> I understood that you're using git. I don't know how it works, so I need
> some data..

Ok, sure. So there are two ways we use git.

One, to generate a patch, using some variant of "git diff
> /tmp/my.patch" or "git format-patch ...", both of which add a/ b/
prefixes.

The second use is to apply a patch received from the mailing list.

Note that only the first is really relevant for the backport project and
this discussion, because obviously the latter doesn't use patch.py.
*However*, we would like the backport project's workflow to be
compatible with the second use case for git.

> Do you use 'git apply'?
> Do you use 'git apply -p1` for git patches? (with a/ b/ prefixes)
> Do you use 'git apply -p1` for non-git diffs? (without a/ b/ prefixes)

So, as a Linux maintainer or contributor, the answer to these is yes and
no, we mostly use "git am" and not "git apply" to apply git patches and
non-git diffs.

However, due to how git works, non-git diffs are required to have *some*
prefixes, whether they're called a/ b/ or something else, since -p1 is
actually the default. I could specify -p0, but that wouldn't be
canonical, and I'm lazy. For example, if I have a git tree that contains
a file called net/mac80211/tx.c (real life example), and I try to apply
a patch that looks like

--- net/mac80211/tx.c
+++ net/mac80211/tx.c
...

then git am/git apply will say
error: mac80211/tx.c: No such file or directory

as it stripped one path component.

As a result, all patches that we throw around about Linux are
essentially required to have a "dead" first component (a/ b/ or whatever
else.)


Now, that's the second use case. The first use case in the backports
project doesn't use git am (it doesn't usually modify a git tree).
However, given the above conventions for the git use case, it also
requires that all input patches that are part of the backport project be
applied with the -p1 that is the implicit default in git. As a result,
patches in the backports project need some prefix.

Now this then is the cause of the problem - your current patch.py treats
git patches and manually created patches differently. We use patch.py to
check which files a given patch changes using this code:
   patched_file = '/'.join(p.items[0].source.split('/')[1:])

Now, you can see the [1:] in there, which is basically the equivalent of
'-p1'. If we do this to a manually created patch that has
--- linux.orig/net/mac80211/tx.c
+++ linux/net/mac80211/tx.c

it will result in the correct "net/mac80211/tx.c". However, if I do it
to a git patch, like

diff ...
index ...
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c

then the code above would result in just "mac80211/tx.c". I'd have to
special-case this in the python code, checking the patch item's type
before conditionally doing the [1:]. That is cumbersome and probably
also error-prone, since it'd break when you put in workarounds like you
just did for google code.

Therefore, I patched out the patch detection and automatic a/ b/
stripping. It'd be more maintainable if I was able to turn it off,
rather than patch it out, at patch object instantiation.

Now, there's another issue - we don't use patch.py to actually apply the
patch, but run 'patch -p1 < ...' instead. I'm not sure any more if there
was a good reason for this, maybe I just didn't trust patch.py enough at
the time, or maybe it's because the old code just ran patch -p1
unconditionally, I don't remember. We could possibly change this, but it
wouldn't affect the above problem because we first have to check whether
we should apply the patch at all, which is what we do with the check
above: the backports project is built to work if you only have a subset
of the files patched by patches actually present, which is why we need
to check which files a patch touches before trying to apply it.


> > Anyway, since the current version of patch.py does what we need, there's
> > little incentive for us to update/change things. If you consider a
> > 'canonical patch' to be -p0, we'll just keep our changed copy :)
> 
> I am interested to make patch.py user experience as easy as I can,
> and maintaining changed copy is not a really good ux for me. =) And
> I am also interested to investigate the nature of those prefixes that I
> don't know about.

I hope the above helped with that?

johannes

