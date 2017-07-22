Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:39806 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755095AbdGVL32 (ORCPT
        <rfc822;backports@vger.kernel.org>); Sat, 22 Jul 2017 07:29:28 -0400
Date: Sat, 22 Jul 2017 14:29:15 +0300
In-Reply-To: <2ad34c26-a8d2-fd9c-4d3c-77a3c6ec0d46@broadcom.com>
References: <1500620116-20476-1-git-send-email-acelan.kao@canonical.com> <1500643281.20057.0.camel@coelho.fi> <2ad34c26-a8d2-fd9c-4d3c-77a3c6ec0d46@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
        AceLan Kao <acelan.kao@canonical.com>, hauke@hauke-m.de,
        mcgrof@kernel.org, backports@vger.kernel.org
From: Luca Coelho <luca@coelho.fi>
Message-ID: <C01EE046-1B86-499B-9D64-2219AEC94552@coelho.fi> (sfid-20170722_132930_800792_32609BB9)
Subject: Re: [PATCH] backport: add some new kv[mz]alloc function
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



On July 22, 2017 10:52:13 AM GMT+03:00, Arend van Spriel <arend.vanspriel@broadcom.com> wrote:
>On 21-07-17 15:21, Luca Coelho wrote:
>> On Fri, 2017-07-21 at 14:55 +0800, AceLan Kao wrote:
>>> add some new kv[mz]alloc functions which introduced after v4.12
>>> by this commit
>>>
>>> commit a7c3e901a46ff54c016d040847eda598a9e3e653
>>> Author: Michal Hocko <mhocko@suse.com>
>>> Date:   Mon May 8 15:57:09 2017 -0700
>>>
>>>     mm: introduce kv[mz]alloc helpers
>>>
>>> Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
>>> ---
>> 
>> I don't see any backported code using any of these yet... Why do you
>> need it?
>
>AceLan is trying to reinstate BT subsystem/drivers in backports so it
>may be needed for that. If that is true I think this patch should go in
>that "BT reinstatement" patch series.


Yeah, but I even checked BT stuff and didn't find any occurrences...

-- 
Luca.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
