Return-path: <backports-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:44693 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751120AbdJBSb0 (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 2 Oct 2017 14:31:26 -0400
Subject: Re: [PATCH] header: fix compile error on PowerPC (PPC_85xx)
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org
References: <20171001193823.22685-1-hauke@hauke-m.de>
 <1506947972.25586.14.camel@sipsolutions.net>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <a47cbe26-26fb-cfb6-f7cd-17d77153ea66@hauke-m.de> (sfid-20171002_203128_535902_C54B2E48)
Date: Mon, 2 Oct 2017 20:31:21 +0200
MIME-Version: 1.0
In-Reply-To: <1506947972.25586.14.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 10/02/2017 02:39 PM, Johannes Berg wrote:
> On Sun, 2017-10-01 at 21:38 +0200, Hauke Mehrtens wrote:
>> Including linux/interrupt.h in linux/hrtimer.h causes this error
>> message
>> on PowerPC builds on x86, ARM and MIPS it works:
> 
> I think I also saw this on x86 on older kernel versions, and couldn't
> really figure out what was causing it...

I haven't fully understood this issue, but the LEDE build bot found it
on multiple PowerPC based systems. With this patch applied it is
compiling on all targets.

I ran the build test script on the compat server and it was fine with
this patch applied for all kernel versions that worked before.

>> The backport of the hrtimer_start() functions needs the
>> linux/interrupt.h because some parts are defined there. Fix this by
>> moving the hrtimer_start() backport to the linux/interrupt.h backport
>> header file.
> 
> Does hrtimre.h always include interrupt.h, so that we get it in when
> somebody includes just hrtimer.h?

I do not know, it is not included directly.

Hauke
--
To unsubscribe from this list: send the line "unsubscribe backports" in
