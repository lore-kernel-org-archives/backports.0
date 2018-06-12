Return-path: <backports-owner@vger.kernel.org>
Received: from mail-by2nam01on0123.outbound.protection.outlook.com ([104.47.34.123]:19382
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934105AbeFLBud (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 11 Jun 2018 21:50:33 -0400
Reply-To: chi-hsien.lin@cypress.com
Subject: Re: [PATCH] Updating id field in backports genl family
To: Johannes Berg <johannes@sipsolutions.net>,
        Wan-Hua Chang <winnie.chang@cypress.com>,
        backports@vger.kernel.org,
        Aaron Komisar <aaron.komisar@tandemg.com>
References: <20180611102947.GA188023@aremote01.aus.cypress.com>
 <1528719907.10346.0.camel@sipsolutions.net>
From: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Message-ID: <6bbc4985-0a18-80f5-2a52-6bc04f27af3a@cypress.com> (sfid-20180612_035035_995994_427256D4)
Date: Tue, 12 Jun 2018 09:50:15 +0800
MIME-Version: 1.0
In-Reply-To: <1528719907.10346.0.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



On 06/11/2018 8:25, Johannes Berg wrote:
> On Mon, 2018-06-11 at 05:29 -0500, Wan-Hua Chang wrote:
>> Hi,
>>
>> I see the patch causes compiling error becasue family->family is not
>> found when LINUX_VERSION >= 3.13
>>
>> backports/backport/backport-include/genetlink.h
>> struct backport_genl_fmaily is only defined when LINUX_VERSION < 3.13
>>
>>
>> And in backports/backport/compat/backport-3.13.c line 127
>>
>> family->id = family->family.id
>>
>> it looks like this line has done what the patch want to do. Is the
>> comprehension correct?
> 
> I guess we have to put an ifdef around this ...
> 
> Aaron?

Hi Aaron,

As Wan-Hua mentioned, it looks like backport-3.13.c line 127 syncs back 
the id for backport_genl_family structure for kernel < 3.13 already.

Could you please share more details about the failure you saw without 
this change? What's the kernel version you used?


Regards,
Chi-hsien Lin

> 
> johannes
> .
> 
--
To unsubscribe from this list: send the line "unsubscribe backports" in
