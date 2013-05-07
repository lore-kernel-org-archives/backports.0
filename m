Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:54339 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758378Ab3EGNa0 (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 7 May 2013 09:30:26 -0400
Message-ID: <1367933418.8328.12.camel@jlt4.sipsolutions.net> (sfid-20130507_153028_595615_37AA6D83)
Subject: Re: [PATCH 2/3] lib/patch.py: add top header parsing support
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org, techtonik@gmail.com
Date: Tue, 07 May 2013 15:30:18 +0200
In-Reply-To: <1367895800-14305-3-git-send-email-mcgrof@do-not-panic.com> (sfid-20130507_050342_672363_59C332B2)
References: <1367895800-14305-1-git-send-email-mcgrof@do-not-panic.com>
	 <1367895800-14305-3-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20130507_050342_672363_59C332B2)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2013-05-06 at 20:03 -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
> 
> Add a top_header for cases where a patchset might have a
> full header that we may want users to keep around.

>      # list of Patch objects
>      self.items = []
> +    self.top_header = ""
>  
>      self.errors = 0    # fatal parsing errors
>      self.warnings = 0  # non-critical warnings
> @@ -303,6 +304,7 @@ class PatchSet(object):
>        if headscan:
>          while not fe.is_empty and not fe.line.startswith("--- "):
>              header.append(fe.line)
> +            self.top_header += fe.line
>              fe.next()

Looks fine to me, though I wonder if we could somehow get at that
"header" list? Anatoly?

johannes

