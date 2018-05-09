Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pl0-f45.google.com ([209.85.160.45]:33350 "EHLO
        mail-pl0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756118AbeEIIH2 (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 9 May 2018 04:07:28 -0400
Received: by mail-pl0-f45.google.com with SMTP id n10-v6so740948plp.0
        for <backports@vger.kernel.org>; Wed, 09 May 2018 01:07:28 -0700 (PDT)
Subject: Re: Failed to backport from from Linux 4.4 drivers to Linux 3.10.108
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org
References: <149bc44e-f521-cf4a-397a-c8e42d00081b@gmail.com>
 <1525770549.14830.1.camel@sipsolutions.net>
 <a6942432-8895-fa56-5a37-a232b99c38fc@gmail.com>
 <1525770503.14830.2.camel@sipsolutions.net>
 <2e85d2c4-d89e-6ab0-2b8e-60ce683f477f@gmail.com>
 <b67c4791-f0da-0fe0-c787-85e9a7824bc6@gmail.com>
 <1525850665.6910.0.camel@sipsolutions.net>
 <1525852495.6910.2.camel@sipsolutions.net>
From: Masashi Honma <masashi.honma@gmail.com>
Message-ID: <2f59e893-da45-f3e7-430b-1377518727bb@gmail.com> (sfid-20180509_100732_103302_0A687EDC)
Date: Wed, 9 May 2018 17:07:24 +0900
MIME-Version: 1.0
In-Reply-To: <1525852495.6910.2.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 2018/05/09 16:54, Johannes Berg wrote:
> Actually, since 1.0.6 has hit the distros, I'll just solve it by
> requiring 1.0.6 and changing the spatch.

Great !

--
To unsubscribe from this list: send the line "unsubscribe backports" in
