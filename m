Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47242 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932235AbcGGALa (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 6 Jul 2016 20:11:30 -0400
Date: Thu, 7 Jul 2016 02:10:28 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	backports@vger.kernel.org, linux-kernel@vger.kernel.org,
	yann.morin.1998@free.fr, mmarek@suse.cz, sassmann@kpanic.de
Subject: Re: [PATCH v3 01/21] backports: move legacy and SmPL patch
 application into helper
Message-ID: <20160707001028.GD31219@wotan.suse.de> (sfid-20160707_021209_454226_3B62B8E6)
References: <1415693712-23743-1-git-send-email-mcgrof@do-not-panic.com>
 <1415693712-23743-2-git-send-email-mcgrof@do-not-panic.com>
 <1467624783.29577.1.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1467624783.29577.1.camel@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, Jul 04, 2016 at 11:33:03AM +0200, Johannes Berg wrote:
> On Tue, 2014-11-11 at 00:14 -0800, Luis R. Rodriguez wrote:
> > From: "Luis R. Rodriguez" <mcgrof@suse.com>
> > 
> > This allows us to extend how backports uses patches for
> > different types of applications. This will later be used
> > for kernel integration support, for example.
> > 
> > This should have no functional change.
> 
> Obviously this patch was applied a long time ago,

Geesh yes over 2 year ago.

> but you lied - it has a functional change:
> 
> > +        if process.returncode != 0:
> > +            if not args.verbose:
> > +                logwrite("Failed to apply changes from %s" %
> > print_name)
> > +                for line in output:
> > +                    logwrite('> %s' % line)
> > +            raise Exception('Patch failed')
> 
> vs.
> 
> > -        if process.returncode != 0:
> > -            if not args.verbose:
> > -                logwrite("Failed to apply changes from %s" %
> > print_name)
> > -                for line in output:
> > -                    logwrite('> %s' % line)
> > -            return 2
> 
> This had a major impact on the devel/git-tracker.py tool.

Sorry about that, is there an easy fix for it? Is there a test
we can do to avoid further regressions against the tracker ?

  Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
