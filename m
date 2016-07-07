Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:45751 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750697AbcGGEOv (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 7 Jul 2016 00:14:51 -0400
Message-ID: <1467864885.2593.0.camel@sipsolutions.net> (sfid-20160707_061453_131423_08D050DB)
Subject: Re: [PATCH v3 01/21] backports: move legacy and SmPL patch
 application into helper
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	backports@vger.kernel.org, linux-kernel@vger.kernel.org,
	yann.morin.1998@free.fr, mmarek@suse.cz, sassmann@kpanic.de
Date: Thu, 07 Jul 2016 06:14:45 +0200
In-Reply-To: <20160707001028.GD31219@wotan.suse.de> (sfid-20160707_042345_790409_0734785D)
References: <1415693712-23743-1-git-send-email-mcgrof@do-not-panic.com>
 <1415693712-23743-2-git-send-email-mcgrof@do-not-panic.com>
 <1467624783.29577.1.camel@sipsolutions.net>
	 <20160707001028.GD31219@wotan.suse.de>
	 (sfid-20160707_042345_790409_0734785D)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 2016-07-07 at 02:10 +0200, Luis R. Rodriguez wrote:
> On Mon, Jul 04, 2016 at 11:33:03AM +0200, Johannes Berg wrote:
> > On Tue, 2014-11-11 at 00:14 -0800, Luis R. Rodriguez wrote:
> > > From: "Luis R. Rodriguez" <mcgrof@suse.com>
> > > 
> > > This allows us to extend how backports uses patches for
> > > different types of applications. This will later be used
> > > for kernel integration support, for example.
> > > 
> > > This should have no functional change.
> > 
> > Obviously this patch was applied a long time ago,
> 
> Geesh yes over 2 year ago.

:)

> > but you lied - it has a functional change:
> > 
> > > +        if process.returncode != 0:
> > > +            if not args.verbose:
> > > +                logwrite("Failed to apply changes from %s" %
> > > print_name)
> > > +                for line in output:
> > > +                    logwrite('> %s' % line)
> > > +            raise Exception('Patch failed')
> > 
> > vs.
> > 
> > > -        if process.returncode != 0:
> > > -            if not args.verbose:
> > > -                logwrite("Failed to apply changes from %s" %
> > > print_name)
> > > -                for line in output:
> > > -                    logwrite('> %s' % line)
> > > -            return 2
> > 
> > This had a major impact on the devel/git-tracker.py tool.
> 
> Sorry about that, is there an easy fix for it? Is there a test
> we can do to avoid further regressions against the tracker ?
> 

Luca has a fix.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
