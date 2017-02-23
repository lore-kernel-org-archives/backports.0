Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wr0-f176.google.com ([209.85.128.176]:35205 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751169AbdBWI2K (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 23 Feb 2017 03:28:10 -0500
Received: by mail-wr0-f176.google.com with SMTP id s27so17035350wrb.2
        for <backports@vger.kernel.org>; Thu, 23 Feb 2017 00:28:04 -0800 (PST)
Subject: Re: [PATCH] backports: add definitions S32_MAX and S32_MIN
To: Johannes Berg <johannes@sipsolutions.net>
References: <1487801925-22641-1-git-send-email-arend.vanspriel@broadcom.com>
 <1487836149.18380.0.camel@sipsolutions.net>
Cc: backports@vger.kernel.org
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <c5eb014a-b922-f825-0319-af46d4864ab4@broadcom.com> (sfid-20170223_092825_212349_1F062B81)
Date: Thu, 23 Feb 2017 09:27:55 +0100
MIME-Version: 1.0
In-Reply-To: <1487836149.18380.0.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 23-2-2017 8:49, Johannes Berg wrote:
> On Wed, 2017-02-22 at 22:18 +0000, Arend van Spriel wrote:
>> Since commit 20e32810bcf4 ("cfg80211: Accept multiple RSSI thresholds
>> for CQM") the backports need to have S32_MAX and S32_MIN which were
>> introduced in kernel.h since v3.14.
>>
> 
> Applied, thanks.
> 
> I really need to set up automation for this, to continuously monitor a
> few trees ...

I create a package nightly for our internal tree and wireless-testing
and build for couple of target kernels to run some wifi tests on target
systems. So I tend to hit issues pretty soon. Not covering all target
kernels though.

Gr. AvS
--
To unsubscribe from this list: send the line "unsubscribe backports" in
