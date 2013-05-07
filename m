Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:54309 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758062Ab3EGN0w (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 7 May 2013 09:26:52 -0400
Message-ID: <1367933208.8328.11.camel@jlt4.sipsolutions.net> (sfid-20130507_152654_506498_F2CD567C)
Subject: Re: [PATCH 1/3] backports: update patch Python library
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org, techtonik@gmail.com
Date: Tue, 07 May 2013 15:26:48 +0200
In-Reply-To: <1367895800-14305-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20130507_050338_250529_5BE43B10)
References: <1367895800-14305-1-git-send-email-mcgrof@do-not-panic.com>
	 <1367895800-14305-2-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20130507_050338_250529_5BE43B10)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2013-05-06 at 20:03 -0700, Luis R. Rodriguez wrote:

> @@ -627,6 +629,20 @@ class PatchSet(object):
>          return None
>      """
>      for i,p in enumerate(self.items):
> +      if p.type in (HG, GIT):
> +        # TODO: figure out how to deal with /dev/null entries
> +        debug("stripping a/ and b/ prefixes")
> +        if p.source != '/dev/null':
> +          if not p.source.startswith("a/"):
> +            warning("invalid source filename")
> +          else:
> +            p.source = p.source[2:]
> +        if p.target != '/dev/null':
> +          if not p.target.startswith("b/"):
> +            warning("invalid target filename")
> +          else:
> +            p.target = p.target[2:]
> +

Unfortunately, adding this back is problematic.

We assume that all patches need one level stripped, but if a patch is a
git patch (as indicated by having the "diff" and/or (?) "index" lines),
then the patch library will already strip a level. That basically
assumes that users use "-p0" on 'plain' patches, which isn't the case,
we always use -p1.

IOW, this will break dropping git patches (e.g. git
diff/show/format-patch) into the patches directory.

Anatoly, would you be interested in maybe having an option to disable
this stripping? If yes, I can do that, otherwise I'm just going to edit
it out of our copy of your library again :-)

johannes

