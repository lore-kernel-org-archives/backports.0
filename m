Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:41198 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934439AbeEIJDj (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 9 May 2018 05:03:39 -0400
Message-ID: <1525856616.6910.7.camel@sipsolutions.net> (sfid-20180509_110341_146524_5C557783)
Subject: Re: Failed to backport from from Linux 4.4 drivers to Linux 3.10.108
From: Johannes Berg <johannes@sipsolutions.net>
To: Masashi Honma <masashi.honma@gmail.com>
Cc: backports@vger.kernel.org
Date: Wed, 09 May 2018 11:03:36 +0200
In-Reply-To: <d54cd7c5-fb33-59dc-afd0-d48f36a7a06d@gmail.com> (sfid-20180509_105147_898906_A1672B89)
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
         (sfid-20180509_105147_898906_A1672B89)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2018-05-09 at 17:51 +0900, Masashi Honma wrote:
> On 2018/05/09 17:12, Johannes Berg wrote:
> > Though of course this doesn't apply to the older branches :)
> 
> How about setting upper limitation to the older branches by attached patch ?

We could also cherry-pick my trivial patch to the older branches I
guess. That'd still be simpler?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
