Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35956 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752126AbdGVHwQ (ORCPT
        <rfc822;backports@vger.kernel.org>); Sat, 22 Jul 2017 03:52:16 -0400
Received: by mail-wm0-f42.google.com with SMTP id w191so22771727wmw.1
        for <backports@vger.kernel.org>; Sat, 22 Jul 2017 00:52:16 -0700 (PDT)
Subject: Re: [PATCH] backport: add some new kv[mz]alloc function
To: Luca Coelho <luca@coelho.fi>,
        AceLan Kao <acelan.kao@canonical.com>, hauke@hauke-m.de,
        mcgrof@kernel.org, backports@vger.kernel.org
References: <1500620116-20476-1-git-send-email-acelan.kao@canonical.com>
 <1500643281.20057.0.camel@coelho.fi>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <2ad34c26-a8d2-fd9c-4d3c-77a3c6ec0d46@broadcom.com> (sfid-20170722_095218_765330_F3A9A704)
Date: Sat, 22 Jul 2017 09:52:13 +0200
MIME-Version: 1.0
In-Reply-To: <1500643281.20057.0.camel@coelho.fi>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 21-07-17 15:21, Luca Coelho wrote:
> On Fri, 2017-07-21 at 14:55 +0800, AceLan Kao wrote:
>> add some new kv[mz]alloc functions which introduced after v4.12
>> by this commit
>>
>> commit a7c3e901a46ff54c016d040847eda598a9e3e653
>> Author: Michal Hocko <mhocko@suse.com>
>> Date:   Mon May 8 15:57:09 2017 -0700
>>
>>     mm: introduce kv[mz]alloc helpers
>>
>> Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
>> ---
> 
> I don't see any backported code using any of these yet... Why do you
> need it?

AceLan is trying to reinstate BT subsystem/drivers in backports so it
may be needed for that. If that is true I think this patch should go in
that "BT reinstatement" patch series.

Regards,
Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
