Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:41452 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934275AbeEIJZd (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 9 May 2018 05:25:33 -0400
Message-ID: <1525857931.6910.8.camel@sipsolutions.net> (sfid-20180509_112535_637405_102AE973)
Subject: Re: Failed to backport from from Linux 4.4 drivers to Linux 3.10.108
From: Johannes Berg <johannes@sipsolutions.net>
To: Masashi Honma <masashi.honma@gmail.com>
Cc: backports@vger.kernel.org
Date: Wed, 09 May 2018 11:25:31 +0200
In-Reply-To: <ba98f466-b6c0-4498-0597-57174b4f7fe5@gmail.com> (sfid-20180509_112450_173826_3FD35E4F)
References: <149bc44e-f521-cf4a-397a-c8e42d00081b@gmail.com>
         <1525770549.14830.1.camel@sipsolutions.net>
         <a6942432-8895-fa56-5a37-a232b99c38fc@gmail.com>
         <1525770503.14830.2.camel@sipsolutions.net>
         <2e85d2c4-d89e-6ab0-2b8e-60ce683f477f@gmail.com>
         <b67c4791-f0da-0fe0-c787-85e9a7824bc6@gmail.com>
         <1525850665.6910.0.camel@sipsolutions.net>
         <1525852495.6910.2.camel@sipsolutions.net>
         <2f59e893-da45-f3e7-430b-1377518727bb@gmail.com>
         <1525853548.6910.3.camel@sipsolutions.net>
         <d54cd7c5-fb33-59dc-afd0-d48f36a7a06d@gmail.com>
         <1525856616.6910.7.camel@sipsolutions.net>
         <ba98f466-b6c0-4498-0597-57174b4f7fe5@gmail.com>
         (sfid-20180509_112450_173826_3FD35E4F)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2018-05-09 at 18:24 +0900, Masashi Honma wrote:
> On 2018/05/09 18:03, Johannes Berg wrote:
> > We could also cherry-pick my trivial patch to the older branches I
> > guess. That'd still be simpler?
> 
> Oh, you already have a plan.
> Then drop my plan.

Well, I wasn't really planning on doing it, but I could? :)

I guess it's easy enough though.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
