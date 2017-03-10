Return-path: <backports-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33105 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933993AbdCJJtp (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 10 Mar 2017 04:49:45 -0500
Received: by mail-qk0-f176.google.com with SMTP id y76so159632898qkb.0
        for <backports@vger.kernel.org>; Fri, 10 Mar 2017 01:49:44 -0800 (PST)
Subject: Re: [PATCH 1/4] patches: update crypto-ccm.patch for v4.11-rc1
To: Johannes Berg <johannes@sipsolutions.net>
References: <1489064253-3652-1-git-send-email-arend.vanspriel@broadcom.com>
 <1489064253-3652-2-git-send-email-arend.vanspriel@broadcom.com>
 <1489127672.3038.0.camel@sipsolutions.net>
Cc: backports@vger.kernel.org
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <b5a13b6c-6ed7-7682-2043-1dcc8ddfec79@broadcom.com> (sfid-20170310_104950_747981_B0AD041B)
Date: Fri, 10 Mar 2017 10:49:39 +0100
MIME-Version: 1.0
In-Reply-To: <1489127672.3038.0.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



On 10-3-2017 7:34, Johannes Berg wrote:
> On Thu, 2017-03-09 at 12:57 +0000, Arend van Spriel wrote:
>> Since v4.11-rc1 the patch file for crypto/ccm.c, which is
>> incorporated
>> in the compat module, no longer applies. Update the patch file to fix
>> the issue.
> 
> I think I want to get rid of this ccm thing entirely, any objections?
> As I remember, it doesn't actually work properly anyway.

No objection here. Does the same apply to skcipher stuff?

> I suspect that if we really can't do anything else, we'd have to
> provide a backport for all of crypto/, but I don't want to go there and
> would rather mandate that all the crypto things are enabled in the base
> kernel.

But that can only work when crypto api in base kernel and backport
kernel are the same, right?

Regards,
Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
