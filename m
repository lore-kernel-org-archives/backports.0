Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:59116 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753920AbdFMU7y (ORCPT <rfc822;backports@vger.kernel.org>);
        Tue, 13 Jun 2017 16:59:54 -0400
Message-ID: <1497387587.6068.15.camel@sipsolutions.net> (sfid-20170613_230018_766279_40DAE2C6)
Subject: Re: [PATCH] backport: handle change in netdevice destructor usage
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: backports@vger.kernel.org
Date: Tue, 13 Jun 2017 22:59:47 +0200
In-Reply-To: <1497258385-5116-1-git-send-email-arend.vanspriel@broadcom.com> (sfid-20170612_110637_487182_292F64A6)
References: <1497258385-5116-1-git-send-email-arend.vanspriel@broadcom.com>
         (sfid-20170612_110637_487182_292F64A6)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2017-06-12 at 10:06 +0100, Arend van Spriel wrote:
> This patch deals with changes made in struct net_device by commit
> cf124db566e6 ("net: Fix inconsistent teardown and release of private
> netdev state."). This only looks for instances that need
> free_netdev() call, ie. struct net_device::needs_free_netdev == true.

Come to think of it, isn't this missing the part where we now call
priv_destructor when registering fails or something?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
