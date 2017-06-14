Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:41454 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751664AbdFNUWh (ORCPT <rfc822;backports@vger.kernel.org>);
        Wed, 14 Jun 2017 16:22:37 -0400
Message-ID: <1497471755.9377.10.camel@sipsolutions.net> (sfid-20170614_222238_707344_89CA6B15)
Subject: Re: [PATCH] backport: handle change in netdevice destructor usage
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: backports@vger.kernel.org
Date: Wed, 14 Jun 2017 22:22:35 +0200
In-Reply-To: <079165f7-cccb-8712-7090-a9b9ed929dba@broadcom.com> (sfid-20170614_192839_655699_9738BE1E)
References: <1497258385-5116-1-git-send-email-arend.vanspriel@broadcom.com>
         <1497387587.6068.15.camel@sipsolutions.net>
         <5d265e01-bd12-801b-b604-ef7107e9373c@broadcom.com>
         <1497446815.9377.0.camel@sipsolutions.net>
         <079165f7-cccb-8712-7090-a9b9ed929dba@broadcom.com>
         (sfid-20170614_192839_655699_9738BE1E)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2017-06-14 at 19:28 +0200, Arend van Spriel wrote:
> 
> All ieee80211_if_free() does is freeing the tstats and it deals with
> null pointers. So for mac80211 this is ok but not generically. Not
> sure how to tackle this in a semantic patch.

I think the problem only applies to the register_netdev[ice]() error
path directly, no? That is, you should be able to restrict it to that
having just failed?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
