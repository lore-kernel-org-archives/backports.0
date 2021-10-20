Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7603C433F5
	for <backports@archiver.kernel.org>; Wed, 20 Oct 2021 18:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B74A60FF2
	for <backports@archiver.kernel.org>; Wed, 20 Oct 2021 18:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhJTS3m (ORCPT <rfc822;backports@archiver.kernel.org>);
        Wed, 20 Oct 2021 14:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbhJTS3l (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 20 Oct 2021 14:29:41 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC33C06161C
        for <backports@vger.kernel.org>; Wed, 20 Oct 2021 11:27:27 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4HZJxT3HkszQjgH;
        Wed, 20 Oct 2021 20:27:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634754443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i3G1sg7LhaZQ06Smjzq7+l2S3KL9A5ssuKMll535OKw=;
        b=Lco6OmOHngE/lUJ7Cj6RlWg1Okb+Ygdy5ldsdxkWMcmiUnQj67HSrPcMQXZ7450UR2PMgQ
        7iTmf4GjvNvo+7wh/3s87rRxmD8mXW1Wyb4M70VxShWnnjytALoX2S1EK8H14TsZ8uso8q
        6EyCPG39R+c+pIE6IvhnloxAFX4eFwqaRcGcIES4dh3b2a3+6+Vmko2J94KCN4LQg4ysk0
        Rl7uU/QJorTsVkVY7LQ7FkkWWDxu4/5wzdmFP/Vwj7/+TqrHzqWB0pVMePnmlkAjqM3JUg
        kUWJIewRJUQcB4AAlj9P4A3rRVdKXztYy8qdEU2MqEGDa/At7K8My4tp5FkA6A==
Subject: Re: [PATCH 00/47] backports: Update to kernel 5.15-rc6
To:     Janusz Dziedzic <janusz.dziedzic@gmail.com>
Cc:     backports@vger.kernel.org, Robert Marko <robert.marko@sartura.hr>
References: <20211019214320.2035704-1-hauke@hauke-m.de>
 <CAFED-jmVY-cWa3FQW2FMj89wvyazxuEzsNtCe5V_v9BvDWj71Q@mail.gmail.com>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <4bd68122-7db6-7860-7ac4-9bac9508e866@hauke-m.de>
Date:   Wed, 20 Oct 2021 20:27:21 +0200
MIME-Version: 1.0
In-Reply-To: <CAFED-jmVY-cWa3FQW2FMj89wvyazxuEzsNtCe5V_v9BvDWj71Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2CAC9188F
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On 10/20/21 2:22 PM, Janusz Dziedzic wrote:
> wt., 19 paź 2021 o 23:44 Hauke Mehrtens <hauke@hauke-m.de> napisał(a):
>>
>> This updates backports to kernel 5.15-rc6.
>>
>> This is done in multiple steps, I plan to make a release based on the
>> latest stable version for each major kernel version between 5.10 and
>> 5.15-rc6. This was compile tested against kernel 4.4 till 5.10 and
>> runtime tested in AP mode with ath9k. We want to use this in OpenWrt and
>> are testing this in OpenWrt now.
>>
>> These patches are also available here:
>> https://github.com/hauke/backports/tree/devel-5.15-2
>>
> Thanks!
> 
> Could you also share openwrt branch that using this backports.
> I already have ath9k/10k/11k (PCI) cards could check.
> 
> BR
> Janusz

Hi,

I have a feature branch with the patches here:
https://git.openwrt.org/?p=openwrt/staging/hauke.git;a=shortlog;h=refs/heads/mac80211-5.15

There are still some problems with ath11k, Robert Marko is working on 
that. ath11k needs some more changes in other frameworks.

Hauke
--
To unsubscribe from this list: send the line "unsubscribe backports" in
