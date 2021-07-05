Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AA0C07E99
	for <backports@archiver.kernel.org>; Mon,  5 Jul 2021 20:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6B6A61978
	for <backports@archiver.kernel.org>; Mon,  5 Jul 2021 20:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhGEUc7 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 5 Jul 2021 16:32:59 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:46562 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229873AbhGEUc6 (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 5 Jul 2021 16:32:58 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.64.75])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 4CA9520066;
        Mon,  5 Jul 2021 20:30:20 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 15BFC8006D;
        Mon,  5 Jul 2021 20:30:19 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 47C7713C2B1;
        Mon,  5 Jul 2021 13:30:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 47C7713C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1625517019;
        bh=IM/Pw6d4UFmXDuQEcPWbU0Y/IwAWJTIC5Jr5PjTUZLw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=p6uQSzrjAWBJAtMhSyb7NsD29awD3NuAI4duvDiSoEF9G2gHIObLr+Nqxizzcu/0d
         b7TjGfPoyGis1vFe2Vx0hhLPJX/QumWjZhHZjaWPoFyctGHcbbPYowy8rshtxNokW5
         YBtCrDBwWngfz6GEec5bhyFka9nBMMR37GobtzwM=
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
 <f00e3ea0-97e4-4f47-b8d1-fd667668754b@candelatech.com>
 <33deca8741a231072f2a835ccf7a93eac1430e9d.camel@sipsolutions.net>
 <d772161b-673c-cb57-ca18-ce994fd1b28e@candelatech.com>
 <9ace0ebe7417d5ade9f5f1df02e46ad982c11c5e.camel@sipsolutions.net>
 <5cb833b8-4c9d-7628-fd1d-d95f12c3962c@candelatech.com>
 <40985f693651f6712aad27f1033c48d99dc5298c.camel@sipsolutions.net>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <94421dca-f1b7-1f89-27d1-a981845b5a63@candelatech.com>
Date:   Mon, 5 Jul 2021 13:30:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <40985f693651f6712aad27f1033c48d99dc5298c.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1625517020-CFsu-h08Jpuv
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

So next problem is kcov stuff.  This is just FYI, I'll just revert this
patch since I don't need it.

[greearb@ben-dt4 linux-5.13.dev.y]$ git show 261e411bb283d
commit 261e411bb283d348a6a977cccb5db393594e7695
Author: Aleksandr Nogikh <nogikh@google.com>
Date:   Thu Oct 29 17:36:20 2020 +0000

     mac80211: add KCOV remote annotations to incoming frame processing

     Add KCOV remote annotations to ieee80211_iface_work() and
     ieee80211_rx_list(). This will enable coverage-guided fuzzing of
     mac80211 code that processes incoming 802.11 frames.

     Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
     Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
     Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 1be775979132..56a1bcea2c1c 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1356,6 +1356,7 @@ static void ieee80211_iface_work(struct work_struct *work)
         while ((skb = skb_dequeue(&sdata->skb_queue))) {
                 struct ieee80211_mgmt *mgmt = (void *)skb->data;

+               kcov_remote_start_common(skb_get_kcov_handle(skb));
.....

Thanks,
Ben
-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

--
To unsubscribe from this list: send the line "unsubscribe backports" in
