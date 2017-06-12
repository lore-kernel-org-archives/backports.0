Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:34684 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751976AbdFLJPa (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 12 Jun 2017 05:15:30 -0400
Received: by mail-wr0-f175.google.com with SMTP id g76so88657220wrd.1
        for <backports@vger.kernel.org>; Mon, 12 Jun 2017 02:15:30 -0700 (PDT)
Subject: Re: [PATCH] backport: handle change in netdevice destructor usage
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org
References: <1497258385-5116-1-git-send-email-arend.vanspriel@broadcom.com>
 <1497258670.18110.1.camel@sipsolutions.net>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <f5b49f6d-7a18-ddec-9d51-6a3194168fa2@broadcom.com> (sfid-20170612_111532_596161_B27804D8)
Date: Mon, 12 Jun 2017 11:15:27 +0200
MIME-Version: 1.0
In-Reply-To: <1497258670.18110.1.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 6/12/2017 11:11 AM, Johannes Berg wrote:
> On Mon, 2017-06-12 at 10:06 +0100, Arend van Spriel wrote:
>> This patch deals with changes made in struct net_device by commit
>> cf124db566e6 ("net: Fix inconsistent teardown and release of private
>> netdev state."). This only looks for instances that need
>> free_netdev() call, ie. struct net_device::needs_free_netdev == true.
> 
> I think we may need to worry about more kernel versions than just 4.12
> here, since this stuff is getting backported, and then it would cause
> double-frees.
> 
> I'm also considering simply removing the priv_destructor entirely from
> mac80211, but I guess this would still apply to other drivers.

For current backports the only other driver is brcmfmac. So you don't 
need it in mac80211? Does that mean you move stuff to .ndo_uninit()?

Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
