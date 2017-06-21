Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:51106 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752210AbdFUVw3 (ORCPT <rfc822;backports@vger.kernel.org>);
        Wed, 21 Jun 2017 17:52:29 -0400
Message-ID: <1498081947.9688.3.camel@sipsolutions.net> (sfid-20170621_235240_214295_91C4B77F)
Subject: Re: [PATCH V2] backport: handle change in netdevice destructor usage
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: backports@vger.kernel.org
Date: Wed, 21 Jun 2017 23:52:27 +0200
In-Reply-To: <2ed2b0d7-7e5a-48b3-e8b1-d52ac644293d@broadcom.com> (sfid-20170621_235026_565185_8410340A)
References: <1498078699-27809-1-git-send-email-arend.vanspriel@broadcom.com>
         <1498079928.9688.2.camel@sipsolutions.net>
         <2ed2b0d7-7e5a-48b3-e8b1-d52ac644293d@broadcom.com>
         (sfid-20170621_235026_565185_8410340A)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2017-06-21 at 23:50 +0200, Arend van Spriel wrote:
> 
> > > ++#if LINUX_VERSION_IS_LESS(4,13,0)
> > > ++static void E(struct net_device *ndev)

> So I will send a V3 fixing the macro in netdevice.h, but I don't
> think we need the maybe_unused attribute.

Ummm, yeah, I totally missed the #if above :)

Maybe it's time to get some sleep...

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
