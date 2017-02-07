Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:38694 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751690AbdBGEXE (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 6 Feb 2017 23:23:04 -0500
Message-ID: <1486441381.3070.4.camel@coelho.fi> (sfid-20170207_052306_399593_D866B9FC)
From: Luca Coelho <luca@coelho.fi>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: backports@vger.kernel.org
Date: Tue, 07 Feb 2017 06:23:01 +0200
In-Reply-To: <e39ada32-fc2e-21c1-5efb-f8e53a7459ac@broadcom.com>
References: <1485870404-28663-1-git-send-email-arend.vanspriel@broadcom.com>
         <def07450-4d61-7225-29f6-90eb952289d1@broadcom.com>
         <1486371134.26003.126.camel@coelho.fi>
         <e39ada32-fc2e-21c1-5efb-f8e53a7459ac@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] backports: adjustments: fix devcoredump patch for
 class_groups
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2017-02-06 at 23:30 +0100, Arend Van Spriel wrote:
> On 6-2-2017 9:52, Luca Coelho wrote:
> > On Thu, 2017-02-02 at 19:36 +0100, Arend Van Spriel wrote:
> > > This is actually not sufficient. Also need to add expansion of
> > > __ATTRIBUTE_GROUPS() macro. Did not hit this as it kicks in when
> > > backporting to 4.10+, which is not on my list yet ;-p
> > 
> > Thanks, Arend! I had something to "fix" this, but it was completely
> > b0rked for (at least) <= 3.14.  I'll try your patch now (at the moment I
> > don't care much about 4.10+ either).
> 
> Looks like Johannes submitted another option to check ;-)

Yeah, I've been working with Johannes on this (mostly as a guinea pig). 
It works with our iwlwifi driver's contents.

--
Cheers,
Luca.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
