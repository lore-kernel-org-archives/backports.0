Return-Path: <SRS0=boiZ=DF=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4D8C2D0A8
	for <backports@archiver.kernel.org>; Mon, 28 Sep 2020 06:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE3B42311C
	for <backports@archiver.kernel.org>; Mon, 28 Sep 2020 06:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="Cu0ge5HM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgI1GzH (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 28 Sep 2020 02:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgI1GzH (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 28 Sep 2020 02:55:07 -0400
X-Greylist: delayed 1391 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Sep 2020 23:55:07 PDT
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45418C0613CE
        for <backports@vger.kernel.org>; Sun, 27 Sep 2020 23:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OsDRUDGKHHvrgYTdYah2TDO7W109kfMRefb19vx4Ccs=; b=Cu0ge5HMNlYKu6gCFz2VaQp47s
        Gg/9+3ggpP4l8P1TFB6hoLxPM5bCq4rqOti5WjkMBKGsE/u+tNS8b7cq9WhYhe6vNHDCwlSmY4BYi
        8r3R2S8jhM3wPVh1m9fZIomLxD9Ejts+G1oo2iP7f2tReKt/4VgiRlkQol5lmZe0KIFs=;
Received: from p4ff134da.dip0.t-ipconnect.de ([79.241.52.218] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kMmhV-0000KT-OZ; Mon, 28 Sep 2020 08:31:53 +0200
Subject: Re: [PATCH v2 2/2] backports: add skb_list_del_init
To:     Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
References: <20200814142958.7773-1-nbd@nbd.name>
 <20200814142958.7773-2-nbd@nbd.name>
 <8e1d9f3d-4128-4030-97fd-3e541bb9c7e6@hauke-m.de>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <e7a00f96-41e4-6513-5962-b80fbfa37613@nbd.name>
Date:   Mon, 28 Sep 2020 08:31:52 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <8e1d9f3d-4128-4030-97fd-3e541bb9c7e6@hauke-m.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org


On 2020-08-31 20:46, Hauke Mehrtens wrote:
> On 8/14/20 4:29 PM, Felix Fietkau wrote:
>> It is needed for mac80211
>> 
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> ---
>>  backport/backport-include/linux/skbuff.h | 6 ++++++
>>  1 file changed, 6 insertions(+)
>> 
>> diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
>> index 3ed990d0d2ef..7b825630d391 100644
>> --- a/backport/backport-include/linux/skbuff.h
>> +++ b/backport/backport-include/linux/skbuff.h
>> @@ -384,6 +384,12 @@ static inline void skb_mark_not_on_list(struct sk_buff *skb)
>>  {
>>  	skb->next = NULL;
>>  }
>> +
>> +static inline void skb_list_del_init(struct sk_buff *skb)
>> +{
>> +	__list_del_entry(&skb->list);
>> +	skb_mark_not_on_list(skb);
>> +}
>>  #endif /* 4.19.10 <= x < 4.20 */
>>  #endif
>>  
>> 
> 
> Hi Felix,
> 
> These two backports are not working.
> 
> The list member was only added in kernel 4.19 to the sk_buff structure,
> see here:
> https://git.kernel.org/linus/d4546c2509b1e9cd082e3682dcec98472e37ee5a
I guess it was working for me on 4.14 because the list member was
backported in 4.14.71.
So it works for kernels with that backport, and I guess other versions
which don't have that will need a more intrusive backport that patches
mac80211 anyway.

- Felix
--
To unsubscribe from this list: send the line "unsubscribe backports" in
