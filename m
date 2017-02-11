Return-path: <backports-owner@vger.kernel.org>
Received: from mail-qt0-f179.google.com ([209.85.216.179]:32876 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750940AbdBKVpR (ORCPT
        <rfc822;backports@vger.kernel.org>); Sat, 11 Feb 2017 16:45:17 -0500
Received: by mail-qt0-f179.google.com with SMTP id v23so60844642qtb.0
        for <backports@vger.kernel.org>; Sat, 11 Feb 2017 13:45:17 -0800 (PST)
Subject: Re: [RFC] backports: always use new version compare macros
To: Johannes Berg <johannes@sipsolutions.net>,
        backports@vger.kernel.org
References: <20170207220716.7538-1-johannes@sipsolutions.net>
 <1486505323.18071.2.camel@sipsolutions.net>
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <3babafe1-f754-bfe0-06fd-94e69137520a@broadcom.com> (sfid-20170211_224522_079060_18C1C789)
Date: Sat, 11 Feb 2017 22:45:13 +0100
MIME-Version: 1.0
In-Reply-To: <1486505323.18071.2.camel@sipsolutions.net>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



On 7-2-2017 23:08, Johannes Berg wrote:
> It's some churn, but I think worthwhile - any objections?

I find comparison operators more clear, but it is probably just a matter
of getting used to it. What makes it worthwile? As you already did the
churn I do not have any objections. Just curious.

Regards,
Arend

> johannes
> --
> To unsubscribe from this list: send the line "unsubscribe backports" in
> 
--
To unsubscribe from this list: send the line "unsubscribe backports" in
