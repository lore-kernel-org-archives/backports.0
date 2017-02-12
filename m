Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:35916 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750910AbdBLT3t (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 12 Feb 2017 14:29:49 -0500
Received: by mail-wr0-f174.google.com with SMTP id k90so137963141wrc.3
        for <backports@vger.kernel.org>; Sun, 12 Feb 2017 11:29:48 -0800 (PST)
Subject: Re: [RFC] backports: always use new version compare macros
To: Johannes Berg <johannes@sipsolutions.net>,
        backports@vger.kernel.org
References: <20170207220716.7538-1-johannes@sipsolutions.net>
 <1486505323.18071.2.camel@sipsolutions.net>
 <3babafe1-f754-bfe0-06fd-94e69137520a@broadcom.com>
 <1486926706.5142.1.camel@sipsolutions.net>
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <87146aa0-81b9-d5e9-0700-701fb36c6d61@broadcom.com> (sfid-20170212_202951_225471_BD7145CC)
Date: Sun, 12 Feb 2017 20:29:46 +0100
MIME-Version: 1.0
In-Reply-To: <1486926706.5142.1.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 12-2-2017 20:11, Johannes Berg wrote:
> On Sat, 2017-02-11 at 22:45 +0100, Arend Van Spriel wrote:
>>
>> On 7-2-2017 23:08, Johannes Berg wrote:
>>> It's some churn, but I think worthwhile - any objections?
>>
>> I find comparison operators more clear, but it is probably just a
>> matter of getting used to it. What makes it worthwile? As you already
>> did the churn I do not have any objections. Just curious.
> 
> So to be honest, I actually pushed the change more or less by accident,
> I'm happy to back it out again.

I suspect the churn was not in pushing the change :-p I am fine with it.
> My reasoning was something along these lines: First, I find it awkward
> to always type the long form when we always have the same patterns.
> Especially with the IN_RANGE() part, which I haven't even fully
> converted I think. So that's my immediate motivation for adding it, but
> as the de-facto maintainer now I'd also want people to really be able
> to figure out which pattern they should use, regardless of whether
> they're looking at old or new bits, so unifying it (towards the new one
> because I'm a lazy bastard) seemed like a good idea.

Agree that a mix of old and new macros is not what we want. I am lazy
too so thanks.

Regards,
Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
