Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:35832 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751726AbdFNNZp (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 14 Jun 2017 09:25:45 -0400
Received: by mail-lf0-f48.google.com with SMTP id p189so504608lfe.2
        for <backports@vger.kernel.org>; Wed, 14 Jun 2017 06:25:44 -0700 (PDT)
Subject: Re: [PATCH] backport: handle change in netdevice destructor usage
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org
References: <1497258385-5116-1-git-send-email-arend.vanspriel@broadcom.com>
 <1497387587.6068.15.camel@sipsolutions.net>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5d265e01-bd12-801b-b604-ef7107e9373c@broadcom.com> (sfid-20170614_152547_253136_5B44950E)
Date: Wed, 14 Jun 2017 15:25:42 +0200
MIME-Version: 1.0
In-Reply-To: <1497387587.6068.15.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 13-06-17 22:59, Johannes Berg wrote:
> On Mon, 2017-06-12 at 10:06 +0100, Arend van Spriel wrote:
>> This patch deals with changes made in struct net_device by commit
>> cf124db566e6 ("net: Fix inconsistent teardown and release of private
>> netdev state."). This only looks for instances that need
>> free_netdev() call, ie. struct net_device::needs_free_netdev == true.
> 
> Come to think of it, isn't this missing the part where we now call
> priv_destructor when registering fails or something?

Ah. I should have studied the patch better to see what behavioral
changes the commit imposed. So are you still considering the patch
despite the likely backport of commit cf124db566e6. I can do my homework
better and resubmit if needed.

Regards,
Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
