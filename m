Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:51201 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753633Ab3H0TXv (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 27 Aug 2013 15:23:51 -0400
Received: by mail-pb0-f42.google.com with SMTP id un15so5276404pbc.1
        for <backports@vger.kernel.org>; Tue, 27 Aug 2013 12:23:50 -0700 (PDT)
Date: Tue, 27 Aug 2013 12:33:12 -0700
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org
Subject: Re: kernel version management
Message-ID: <20130827193310.GI7485@garbanzo.do-not-panic.com> (sfid-20130827_212353_744068_44D0F866)
References: <1377630791.20012.12.camel@jlt4.sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1377630791.20012.12.camel@jlt4.sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, Aug 27, 2013 at 09:13:11PM +0200, Johannes Berg wrote:
> Hi,
> 
> So ... I guess I succeeded in killing off 2.6.24 support, but I think we
> should talk about when we drop which version?
> 
> http://en.wikipedia.org/wiki/Linux_kernel#Maintenance has a handy list
> of which version was supported until when, telling us that the oldest
> kernel still supported now is 2.6.32.
> 
> What do people think? What kernels do you use? How old is "really far
> too old to worry about"?

I'm ready to accept killing anything not listed as supported on kernel.org.
That should help with speed and also pushing folks to ensure their
ecosystem is upgraded appropriately.

  Luis
