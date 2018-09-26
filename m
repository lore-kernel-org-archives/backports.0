Return-path: <backports-owner@vger.kernel.org>
Received: from mail-eopbgr710126.outbound.protection.outlook.com ([40.107.71.126]:63153
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726497AbeIZQ03 (ORCPT <rfc822;backports@vger.kernel.org>);
        Wed, 26 Sep 2018 12:26:29 -0400
Reply-To: chi-hsien.lin@cypress.com
Subject: Re: [PATCH v2] backports: add strreplace()
To: Johannes Berg <johannes@sipsolutions.net>,
        "backports@vger.kernel.org" <backports@vger.kernel.org>
Cc: Winnie Chang <Winnie.Chang@cypress.com>
References: <1537354267-42104-1-git-send-email-chi-hsien.lin@cypress.com>
 <1537773565.1707.21.camel@sipsolutions.net>
From: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Message-ID: <31ec4cff-7be6-3b45-d163-93901ab8f00e@cypress.com> (sfid-20180926_121418_613904_184D5482)
Date: Wed, 26 Sep 2018 18:13:53 +0800
MIME-Version: 1.0
In-Reply-To: <1537773565.1707.21.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



On 09/24/2018 3:19, Johannes Berg wrote:
> On Wed, 2018-09-19 at 10:51 +0000, Chi-Hsien Lin wrote:
>> From: Winnie Chang <Winnie.Chang@cypress.com>
>>
>> wireless-drivers-next.git commit cb18e2e9ec71 (brcmfmac: fix wrong
>> strnchr usage) used strreplace(), which is not available in kernel prior
>> to v4.2. Before this commit proprgates to linux-stable.git, add
>> strreplace() to avoid gentree failure.
> 
> Something's fishy with your email - there's no whitespace in it at all??
> 
> Anyway, since it was only a few lines I've fixed it up, but please check
> what the reason was before/when you send a new patch.

Thanks for catching this. It's identified to be caused by our SMTP 
server which does extra processing to external mails. I will work with 
our IT to fix it and make sure it doesn't happen in our future patch 
submissions.

Regards,
Chi-hsien Lin
--
To unsubscribe from this list: send the line "unsubscribe backports" in
