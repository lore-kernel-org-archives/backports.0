Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wr0-f170.google.com ([209.85.128.170]:33072 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751108AbdFUVxm (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 21 Jun 2017 17:53:42 -0400
Received: by mail-wr0-f170.google.com with SMTP id r103so152734787wrb.0
        for <backports@vger.kernel.org>; Wed, 21 Jun 2017 14:53:41 -0700 (PDT)
Subject: Re: [PATCH V2] backport: handle change in netdevice destructor usage
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org
References: <1498078699-27809-1-git-send-email-arend.vanspriel@broadcom.com>
 <1498079928.9688.2.camel@sipsolutions.net>
 <2ed2b0d7-7e5a-48b3-e8b1-d52ac644293d@broadcom.com>
 <1498081947.9688.3.camel@sipsolutions.net>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <079f345f-dd48-809e-d431-51c6d7bfc1ae@broadcom.com> (sfid-20170621_235344_270276_DD40637D)
Date: Wed, 21 Jun 2017 23:53:38 +0200
MIME-Version: 1.0
In-Reply-To: <1498081947.9688.3.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 21-06-17 23:52, Johannes Berg wrote:
> On Wed, 2017-06-21 at 23:50 +0200, Arend van Spriel wrote:
>>
>>>> ++#if LINUX_VERSION_IS_LESS(4,13,0)
>>>> ++static void E(struct net_device *ndev)
> 
>> So I will send a V3 fixing the macro in netdevice.h, but I don't
>> think we need the maybe_unused attribute.
> 
> Ummm, yeah, I totally missed the #if above :)
> 
> Maybe it's time to get some sleep...

Dito. That V3 will have to wait until tomorrow.

Gr. AvS
--
To unsubscribe from this list: send the line "unsubscribe backports" in
