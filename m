Return-path: <backports-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:22085 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752468Ab3LHH2z convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 8 Dec 2013 02:28:55 -0500
From: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Johannes Berg <johannes@sipsolutions.net>
CC: "backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: RE: [PATCH v3] backports: add support for prandom_bytes
Date: Sun, 8 Dec 2013 07:28:51 +0000
Message-ID: <0BA3FCBA62E2DC44AF3030971E174FB303D19754@HASMSX103.ger.corp.intel.com> (sfid-20131208_082858_039193_139FE040)
References: <1386079852-8248-1-git-send-email-johannes@sipsolutions.net>
 <20131206161531.GB8196@cerro.do-not-panic.com>
 <20131206182601.GC8196@cerro.do-not-panic.com>
In-Reply-To: <20131206182601.GC8196@cerro.do-not-panic.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

> From: Luis R. Rodriguez [mailto:mcgrof@gmail.com] On Behalf Of Luis R.
> Rodriguez
> Sent: Friday, December 06, 2013 8:26 PM
> To: Johannes Berg
> Cc: backports@vger.kernel.org; Grumbach, Emmanuel
> Subject: Re: [PATCH v3] backports: add support for prandom_bytes
> 
> On Fri, Dec 06, 2013 at 05:15:31PM +0100, Luis R. Rodriguez wrote:
> > On Tue, Dec 03, 2013 at 03:10:52PM +0100, Johannes Berg wrote:
> > > +EXPORT_SYMBOL_GPL(prandom_bytes_state);
> >
> > Where is prandom_bytes_state defined? Did you mean prandom_bytes ?
> > This breaks compilation right now.
> 
> I'll fix this upon merge, modifying this without _state fixed things.
>

Well... the patch was suggested by Johannes, of course I fixed it before I applied it in our internal tree, and apparently, I should have told him that I had to fix it before asking him to send upstream...
Thanks Luis.

