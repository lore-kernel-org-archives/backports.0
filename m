Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:53842 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751562AbcGDJdI (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 4 Jul 2016 05:33:08 -0400
Message-ID: <1467624783.29577.1.camel@sipsolutions.net> (sfid-20160704_113312_018147_CA9B8A9F)
Subject: Re: [PATCH v3 01/21] backports: move legacy and SmPL patch
 application into helper
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	backports@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yann.morin.1998@free.fr,
	mmarek@suse.cz, sassmann@kpanic.de,
	"Luis R. Rodriguez" <mcgrof@suse.com>
Date: Mon, 04 Jul 2016 11:33:03 +0200
In-Reply-To: <1415693712-23743-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20141111_092101_147387_47EB0676)
References: <1415693712-23743-1-git-send-email-mcgrof@do-not-panic.com>
	 <1415693712-23743-2-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20141111_092101_147387_47EB0676)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2014-11-11 at 00:14 -0800, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
> 
> This allows us to extend how backports uses patches for
> different types of applications. This will later be used
> for kernel integration support, for example.
> 
> This should have no functional change.

Obviously this patch was applied a long time ago, but you lied - it has
a functional change:

> +        if process.returncode != 0:
> +            if not args.verbose:
> +                logwrite("Failed to apply changes from %s" %
> print_name)
> +                for line in output:
> +                    logwrite('> %s' % line)
> +            raise Exception('Patch failed')

vs.

> -        if process.returncode != 0:
> -            if not args.verbose:
> -                logwrite("Failed to apply changes from %s" %
> print_name)
> -                for line in output:
> -                    logwrite('> %s' % line)
> -            return 2

This had a major impact on the devel/git-tracker.py tool.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
