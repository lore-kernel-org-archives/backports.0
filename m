Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:52671 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751496AbaKDKO5 (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 4 Nov 2014 05:14:57 -0500
Message-ID: <1415096092.2064.13.camel@sipsolutions.net> (sfid-20141104_111500_070635_2132780A)
Subject: Re: [PATCH v1 10/11] backports: prefix c-file / h-file auto
 backport with BPAUTO
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org, linux-kernel@vger.kernel.org,
	yann.morin.1998@free.fr, mmarek@suse.cz, sassmann@kpanic.de,
	"Luis R. Rodriguez" <mcgrof@suse.com>
Date: Tue, 04 Nov 2014 11:14:52 +0100
In-Reply-To: <1415090582-14129-11-git-send-email-mcgrof@do-not-panic.com> (sfid-20141104_094716_255472_7B15EC6D)
References: <1415090582-14129-1-git-send-email-mcgrof@do-not-panic.com>
	 <1415090582-14129-11-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20141104_094716_255472_7B15EC6D)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2014-11-04 at 00:43 -0800, Luis R. Rodriguez wrote:

> -            mf.write('compat-$(%s%s) += %s\n' % (bp_prefix, sym, ' '.join(o_files)))
> +            if bp_prefix not in sym:
> +                mf.write('compat-$(%s%s) += %s\n' % (bp_prefix, sym, ' '.join(o_files)))
> +            else:
> +                mf.write('compat-$(%s) += %s\n' % (sym, ' '.join(o_files)))

I don't think these changes are correct, the bp_prefix is needed anyway,
and there's no way it could already be. Looks like this comes from a
previous attempt where you misunderstood and thought
CONFIG_BACKPORT_BACKPORT_... was actually wrong, when in fact it is
correct (and would now be CONFIG_BACKPORT_BPAUTO_...)

johannes

