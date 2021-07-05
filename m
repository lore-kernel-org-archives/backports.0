Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06204C07E99
	for <backports@archiver.kernel.org>; Mon,  5 Jul 2021 19:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D78B16141C
	for <backports@archiver.kernel.org>; Mon,  5 Jul 2021 19:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhGETUI (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 5 Jul 2021 15:20:08 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:55344 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229743AbhGETUI (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 5 Jul 2021 15:20:08 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.120])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id D6E1B1A0063;
        Mon,  5 Jul 2021 19:17:29 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 95C6A340069;
        Mon,  5 Jul 2021 19:17:29 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 2CD9513C2B3;
        Mon,  5 Jul 2021 12:17:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 2CD9513C2B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1625512649;
        bh=4n4mQ5+nBrK3/c6JROWd6Y53+g+uhu03l8WZStvBHf8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=L8aPWgyzeXuqIBWwHR/D0/UMCofPwLWmx0Au8nXNW1qXy267o+cldrdGF7tbtAEqZ
         xU0WithIrZGP9Mm5N++Mfi9UxMhBuWtHC3kAPyNkeOJVEyFTVCueDe2r/o41iJcFpK
         bmeXuf9uRenHTU5mJosX8c41nhleb9zk9qAotlzY=
Subject: Re: backports spatch question
To:     Johannes Berg <johannes@sipsolutions.net>,
        Hauke Mehrtens <hauke@hauke-m.de>
Cc:     backports@vger.kernel.org
References: <e26b0d55-8662-ecf7-6630-ac23a99374b5@candelatech.com>
 <84336f24b55f6ef407511235a90af4b24a8488ce.camel@sipsolutions.net>
 <cdc5aeac-e618-5b67-15fe-0a4fc5ef6e21@candelatech.com>
 <6260cc7d2771a5d67e04736a036ae23c8441c57d.camel@sipsolutions.net>
 <31776ce8-7014-b3ed-41bf-121e8ce5001c@candelatech.com>
 <244749b289fcaca6826670471890420d4b51b6ed.camel@sipsolutions.net>
 <a5e843c9-bed8-a381-4e67-dac3a1a207ed@candelatech.com>
 <05c73f83ce63bc1e15c40836fce56dcdb7eb9a8b.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <f00e3ea0-97e4-4f47-b8d1-fd667668754b@candelatech.com>
Date:   Mon, 5 Jul 2021 12:17:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <05c73f83ce63bc1e15c40836fce56dcdb7eb9a8b.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-MDID: 1625512650-aSTT-XzsA-oC
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On 7/5/21 12:14 PM, Johannes Berg wrote:
> On Mon, 2021-07-05 at 12:10 -0700, Ben Greear wrote:
>> On 7/5/21 10:55 AM, Johannes Berg wrote:
>>> On Mon, 2021-07-05 at 10:47 -0700, Ben Greear wrote:
>>>> On 7/1/21 2:51 PM, Johannes Berg wrote:
>>>>> On Thu, 2021-07-01 at 14:40 -0700, Ben Greear wrote:
>>>>>>
>>>>>> [greearb@v-f34-64 backports]$ spatch --version
>>>>>> spatch version 1.0.8-gf4ba8df-dirty compiled with OCaml version 4.11.1
>>>>>
>>>>>
>>>>> I just realized I never even tried on my system recently, I'm still on
>>>>> F33 and have
>>>>>
>>>>> spatch version 1.0.8-gc1dbb4f-dirty compiled with OCaml version 4.11.1
>>>>>
>>>>> Could you try some other version? Backports says it needs "at least"
>>>>> 1.0.7 but perhaps only exactly that works?
>>>>>
>>>>> johannes
>>>>>
>>>>
>>>> I hacked through this by removing the offending spatches.  Seems to have worked OK
>>>> since the kernels I am using are relatively recent.
>>>>
>>>> I spent a while getting the mac80211 patches from owrt tweaked or otherwise
>>>> resolved so that it would patch against my backports tree.
>>>>
>>>> But now I'm having trouble with rfkill and not sure best way forward.  Is backports
>>>> supposed to take care of this somehow, or do I need to go hacking in openwrt?
>>>
>>> You need this bit in backport-include/linux/rfkill.h, not sure why it's
>>> not there yet:
>>>
>>> #if LINUX_VERSION_IS_LESS(5,11,0)
>>>
>>> /* This should come from uapi/linux/rfkill.h, but it was much easier
>>>    * to do it this way.
>>>    */
>>> enum rfkill_hard_block_reasons {
>>>           RFKILL_HARD_BLOCK_SIGNAL        = 1 << 0,
>>>           RFKILL_HARD_BLOCK_NOT_OWNER     = 1 << 1,
>>> };
>>>
>>> static inline bool rfkill_set_hw_state_reason(struct rfkill *rfkill,
>>>                                                 bool blocked, unsigned
>>> long reason)
>>> {
>>>           return rfkill_set_hw_state(rfkill, blocked);
>>> }
>>>
>>> #endif /* 5.11 */
>>>
>>>
>>> johannes
>>>
>>
>> I added that patch to the bottom of the file, just above the final #endif
> 
> Well I guess it needs to be at the beginning in the first existing ifdef
> block.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/backport-iwlwifi.git/tree/backport-include/linux/rfkill.h
> 
> johannes
> 

Did you test it?  Because that should be logically identical to what I tried if I read this file properly:

[greearb@v-f34-64 backports]$ git show
commit d3480ef5f9024dfe712700832473c90c577d8ca5 (HEAD -> master)
Author: Ben Greear <greearb@candelatech.com>
Date:   Mon Jul 5 11:12:14 2021 -0700

     Fix rfkill for earlier than 5.11 kernels

     From Johannes Berg <johannes@sipsolutions.net>

     Signed-off-by: Ben Greear <greearb@candelatech.com>

diff --git a/backport/backport-include/linux/rfkill.h b/backport/backport-include/linux/rfkill.h
index 99015af7..c4aa2bd2 100644
--- a/backport/backport-include/linux/rfkill.h
+++ b/backport/backport-include/linux/rfkill.h
@@ -164,4 +164,23 @@ static inline bool backport_rfkill_blocked(struct rfkill *rfkill)
  #define rfkill_blocked backport_rfkill_blocked
  #endif

+#if LINUX_VERSION_IS_LESS(5,11,0)
+
+/* This should come from uapi/linux/rfkill.h, but it was much easier
+ * to do it this way.
+ */
+enum rfkill_hard_block_reasons {
+        RFKILL_HARD_BLOCK_SIGNAL        = 1 << 0,
+        RFKILL_HARD_BLOCK_NOT_OWNER     = 1 << 1,
+};
+
+static inline bool rfkill_set_hw_state_reason(struct rfkill *rfkill,
+                                              bool blocked, unsigned
+long reason)
+{
+        return rfkill_set_hw_state(rfkill, blocked);
+}
+
+#endif /* 5.11 */
+
  #endif


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

--
To unsubscribe from this list: send the line "unsubscribe backports" in
