Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36312 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755826AbeEIHVV (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 9 May 2018 03:21:21 -0400
Received: by mail-pf0-f180.google.com with SMTP id w129so19765707pfd.3
        for <backports@vger.kernel.org>; Wed, 09 May 2018 00:21:21 -0700 (PDT)
Subject: Re: Failed to backport from from Linux 4.4 drivers to Linux 3.10.108
From: Masashi Honma <masashi.honma@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org
References: <149bc44e-f521-cf4a-397a-c8e42d00081b@gmail.com>
 <1525770549.14830.1.camel@sipsolutions.net>
 <a6942432-8895-fa56-5a37-a232b99c38fc@gmail.com>
 <1525770503.14830.2.camel@sipsolutions.net>
 <2e85d2c4-d89e-6ab0-2b8e-60ce683f477f@gmail.com>
Message-ID: <b67c4791-f0da-0fe0-c787-85e9a7824bc6@gmail.com> (sfid-20180509_092123_585725_9505A5FC)
Date: Wed, 9 May 2018 16:21:17 +0900
MIME-Version: 1.0
In-Reply-To: <2e85d2c4-d89e-6ab0-2b8e-60ce683f477f@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 2018/05/09 06:42, Masashi Honma wrote:> It looks regression of 
latest(1.0.6+) coccinelle.
> This works with coccinelle 1.0.4.

I asked about this to coccinelle.

https://github.com/coccinelle/coccinelle/issues/135

julia says this notation is deprecated from 1.0.6.

@@
attribute __genl_const;
@@

from 1.0.6, "name" field is required.

@@
attribute name __genl_const;
@@

The coccinelle made a backward incompatible change...

Regards,
Masashi Honma.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
