Return-path: <backports-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46611 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752634AbaJaTfg (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 31 Oct 2014 15:35:36 -0400
Date: Fri, 31 Oct 2014 20:35:34 +0100
From: "Luis R. Rodriguez" <mcgrof@suse.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	backports@vger.kernel.org, linux-kernel@vger.kernel.org,
	yann.morin.1998@free.fr, mmarek@suse.cz, sassmann@kpanic.de
Subject: Re: [RFC v2 2/4] backports: replace BACKPORT_PWD with BACKPORT_DIR
Message-ID: <20141031193534.GB12953@wotan.suse.de> (sfid-20141031_203538_000786_02AF6B0E)
References: <1414570902-5675-1-git-send-email-mcgrof@do-not-panic.com> <1414570902-5675-3-git-send-email-mcgrof@do-not-panic.com> <1414741319.3014.4.camel@jlt4.sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1414741319.3014.4.camel@jlt4.sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, Oct 31, 2014 at 08:41:59AM +0100, Johannes Berg wrote:
> On Wed, 2014-10-29 at 01:21 -0700, Luis R. Rodriguez wrote:
> > From: "Luis R. Rodriguez" <mcgrof@suse.com>
> > 
> > This will also be used for built-in kernel integration, by
> > using this we can share more code with the built-in kernel
> > approach.
> 
> I see no issues with this, looks like a straight rename.

I'll add your Reviewed-by at least.

  Luis
