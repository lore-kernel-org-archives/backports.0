Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:59668 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887AbaAPWBe (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 16 Jan 2014 17:01:34 -0500
Received: by mail-pb0-f52.google.com with SMTP id jt11so1160977pbb.25
        for <backports@vger.kernel.org>; Thu, 16 Jan 2014 14:01:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1367933208.8328.11.camel@jlt4.sipsolutions.net>
References: <1367895800-14305-1-git-send-email-mcgrof@do-not-panic.com>
 <1367895800-14305-2-git-send-email-mcgrof@do-not-panic.com> <1367933208.8328.11.camel@jlt4.sipsolutions.net>
From: anatoly techtonik <techtonik@gmail.com>
Date: Fri, 17 Jan 2014 01:01:14 +0300
Message-ID: <CAPkN8xJjvBFQJHaEu_yUsHaeDybws02NcfegdyXq_+RN-XssOQ@mail.gmail.com> (sfid-20140116_230136_773106_965C5263)
Subject: Re: [PATCH 1/3] backports: update patch Python library
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Resending as a plain text to calm down mailer-daemon.

On Tue, May 7, 2013 at 4:26 PM, Johannes Berg <johannes@sipsolutions.net> wrote:
>
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

Sorry for a long delay. I finally lost my job, so now I can have some continuous
time piece to concentrate on python-patch.

>
> We assume that all patches need one level stripped, but if a patch is a
> git patch (as indicated by having the "diff" and/or (?) "index" lines),
> then the patch library will already strip a level. That basically
> assumes that users use "-p0" on 'plain' patches, which isn't the case,
> we always use -p1.
>
> IOW, this will break dropping git patches (e.g. git
> diff/show/format-patch) into the patches directory.

patch.py is smart enough to strip only a/ and b/ prefixes, and do this
automatically when it is needed.

How do you use patch.py?
Why do you have to use -p1?

> Anatoly, would you be interested in maybe having an option to disable
> this stripping? If yes, I can do that, otherwise I'm just going to edit
> it out of our copy of your library again :-)

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
