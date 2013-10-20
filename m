Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:42636 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897Ab3JTNjI (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 20 Oct 2013 09:39:08 -0400
Received: by mail-ie0-f178.google.com with SMTP id to1so12575374ieb.23
        for <backports@vger.kernel.org>; Sun, 20 Oct 2013 06:39:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1382120027.14393.20.camel@jlt4.sipsolutions.net>
References: <1382110139-23344-1-git-send-email-johannes@sipsolutions.net>
	<5261585F.8020000@hauke-m.de>
	<1382115154.14393.18.camel@jlt4.sipsolutions.net>
	<1382120027.14393.20.camel@jlt4.sipsolutions.net>
Date: Sun, 20 Oct 2013 15:39:07 +0200
Message-ID: <CAB3XZEdzDyanG-3vkbDqyc-pthCPfaBpBL5XH_39qkBUPR9OKQ@mail.gmail.com> (sfid-20131020_153911_377974_C58B94F2)
Subject: Re: [RFC] backports: replace netlink portid by semantic patch
From: Eliad Peller <eliad@wizery.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, Oct 18, 2013 at 9:13 PM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Fri, 2013-10-18 at 18:52 +0200, Johannes Berg wrote:
>> On Fri, 2013-10-18 at 17:48 +0200, Hauke Mehrtens wrote:
>> > How fast would it be when one more semantic patch would be added would
>> > it increase in the same way? I am wondering if this is a constant
>> > increase or does it depend on the number of patches.
>>
>> I believe it's # of patches because the slowest part seems to be
>> searching all files for matches.
>
> FWIW, I still think it's worth it, especially the nl80211 patch breaks
> all the time ...
>
maybe limit it to specific files/dirs?

Eliad.
