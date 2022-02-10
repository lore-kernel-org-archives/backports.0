Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EB8C433F5
	for <backports@archiver.kernel.org>; Thu, 10 Feb 2022 08:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237105AbiBJIRd (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 10 Feb 2022 03:17:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbiBJIRc (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 10 Feb 2022 03:17:32 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517F310B0
        for <backports@vger.kernel.org>; Thu, 10 Feb 2022 00:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=RhffmKske5nfGKhTl8laZX6H4leLWGDVRxx3CA4xWT4=;
        t=1644481051; x=1645690651; b=ZOf8QkRJH9py7j6ilHzUtGiNfZ4RzkYe3rRe3Ya70jCPdt3
        tK2RnHKG/pQsJiGEZwkMMvJVDR/NRFkWFwMAgoqAJpMdpZooWEhR5xLPCLUmXcbw7hkByYOGgHWaZ
        DEeaEmRE4Kj352Nlz99p8Ks9RdJKwhQz7dKJQtiIIfQyF+KL8930kvGZpmjY8LtHUL3w88wgad9ml
        l6qdrdfI2rb7JOrArzqrt4OE1cuol2v7dXMCMPPMb/LbZHkZmAbxfxOC37SWfd+czYiO3Hp4yKGu/
        DvXZfgKFx7Bk0wppsecHvE7NipEWOohK7JBEm1G5lWOUkfb+bwca45OIpTR+Q1WQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nI4dp-00Gxb3-Ki;
        Thu, 10 Feb 2022 09:17:25 +0100
Message-ID: <7c1fd2554ae907eded15dd247bbda5bc5c28cbe7.camel@sipsolutions.net>
Subject: Re: Dealing with SUBLEVEL overflow in backports
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hauke Mehrtens <hauke@hauke-m.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        backports@vger.kernel.org
Date:   Thu, 10 Feb 2022 09:17:24 +0100
In-Reply-To: <789b2e40-c0f2-c078-907d-ceeacc8c2da9@hauke-m.de>
References: <1796985a-4524-f6f8-2f67-acb2e985e87f@flygoat.com>
         <545f9eb36509c21b3217804b43da4dcdbaf623b1.camel@sipsolutions.net>
         <b372254d9c4cc7156eabfb5dd722d02541a31ea1.camel@sipsolutions.net>
         <cf1d0098-f871-4086-18fd-ffbc8e90da66@flygoat.com>
         <bb0ae37aa770e016463706d557fec1c5205bc6a9.camel@sipsolutions.net>
         <5a58d473-a0a1-b213-c71d-963e6b180593@flygoat.com>
         <d29fa260e1e9d43dc3fa2f5b9683a5b336451ad8.camel@sipsolutions.net>
         <b16e61de-9258-7f32-7c2c-d59565f5fd05@flygoat.com>
         <f234795fbc9ba700982d5182f3cb71d5a0408c17.camel@sipsolutions.net>
         <9886de4b-7e5c-ee34-6e2c-83efb358d1ac@hauke-m.de>
         <1ac779ab0dfebdaa1ce7e5b6e900d49164e4afa9.camel@sipsolutions.net>
         <1153d726-aed6-0b62-d0f1-6a1e2a878543@flygoat.com>
         <c4e0b94283e55619822a2f5d45a91b5d33d3cfa1.camel@sipsolutions.net>
         <a3f573f1-7f61-b38d-813a-53d4af59f322@flygoat.com>
         <789b2e40-c0f2-c078-907d-ceeacc8c2da9@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Thu, 2022-02-10 at 00:44 +0100, Hauke Mehrtens wrote:
> 
> What build problem do you get when you include "#include <linux/bug.h>" 
> here on kernel 4.9.299?
> 

I haven't tried, but per the explanation, you get issues if you tried to
include bug.h in the first place, since then you get

bug.h
-> includes build_bug.h (since the patch)
-> uses build_bug.h from backports
-> includes bug.h (does nothing, double include)

and you're then missing the defines from build_bug.h.

> Can we somehow work around this problem by 
> detection the kernel version in a different way based on a different define?
> 

I don't think so. However, I don't yet see why passing the version on
the command line doesn't work, since we only ever need to care about
files we compile?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
