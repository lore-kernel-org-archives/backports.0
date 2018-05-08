Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34741 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932460AbeEHVmz (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 8 May 2018 17:42:55 -0400
Received: by mail-pg0-f48.google.com with SMTP id g20-v6so15044019pgv.1
        for <backports@vger.kernel.org>; Tue, 08 May 2018 14:42:54 -0700 (PDT)
Subject: Re: Failed to backport from from Linux 4.4 drivers to Linux 3.10.108
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org
References: <149bc44e-f521-cf4a-397a-c8e42d00081b@gmail.com>
 <1525770549.14830.1.camel@sipsolutions.net>
 <a6942432-8895-fa56-5a37-a232b99c38fc@gmail.com>
 <1525770503.14830.2.camel@sipsolutions.net>
From: Masashi Honma <masashi.honma@gmail.com>
Message-ID: <2e85d2c4-d89e-6ab0-2b8e-60ce683f477f@gmail.com> (sfid-20180508_234301_900338_CDBBEDA0)
Date: Wed, 9 May 2018 06:42:50 +0900
MIME-Version: 1.0
In-Reply-To: <1525770503.14830.2.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 2018/05/08 18:08, Johannes Berg wrote:
> Yeah, thought so. You actually need to change the syntax here a bit, I
> don't remember but you can search the mailing list here for the details.
> Look for "Parse error with genl-const.cocci".

Thank you.

It looks regression of latest(1.0.6+) coccinelle.
This works with coccinelle 1.0.4.

Regards,
Masashi Honma.

--
To unsubscribe from this list: send the line "unsubscribe backports" in
