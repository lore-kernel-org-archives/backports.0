Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:38206 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758003Ab3LFS0I (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 6 Dec 2013 13:26:08 -0500
Received: by mail-wg0-f50.google.com with SMTP id a1so1015087wgh.17
        for <backports@vger.kernel.org>; Fri, 06 Dec 2013 10:26:07 -0800 (PST)
Date: Fri, 6 Dec 2013 19:26:01 +0100
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: Re: [PATCH v3] backports: add support for prandom_bytes
Message-ID: <20131206182601.GC8196@cerro.do-not-panic.com> (sfid-20131206_192615_471346_E4205926)
References: <1386079852-8248-1-git-send-email-johannes@sipsolutions.net>
 <20131206161531.GB8196@cerro.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131206161531.GB8196@cerro.do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, Dec 06, 2013 at 05:15:31PM +0100, Luis R. Rodriguez wrote:
> On Tue, Dec 03, 2013 at 03:10:52PM +0100, Johannes Berg wrote:
> > +EXPORT_SYMBOL_GPL(prandom_bytes_state);
> 
> Where is prandom_bytes_state defined? Did you mean prandom_bytes ?
> This breaks compilation right now.

I'll fix this upon merge, modifying this without _state fixed things.

  Luis
