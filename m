Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DACC433EF
	for <backports@archiver.kernel.org>; Tue,  8 Feb 2022 15:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379147AbiBHPDD (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 8 Feb 2022 10:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350967AbiBHPDC (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 8 Feb 2022 10:03:02 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02225C061576
        for <backports@vger.kernel.org>; Tue,  8 Feb 2022 07:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=UAsw9Mp2Jo3fr8ZwfCaaxEjfoKmoFaNw5ZA1PLtwbho=;
        t=1644332582; x=1645542182; b=jdVvZRM9zwpobYzzob3lXg5mGKWuH+hECq88devAfF16atq
        5h1ihibUgFgEQWBU06g+veFXoAnaW2fgwXERpw6pHPmebr0yd+WP3R5uM5UHn7GxRG1HkQqKdlnw2
        9zARJ9CtswKvrrJ0GqenmI3WZGSrWavVx+G8hs6Dkwj8l2YTx40H5cz5O/WpejKiqJiiBeQwA0uWc
        RQfcqb5a2k6043W4j6SqqysAmLx8WaH++ObF1W6d25MklNz3h8x593iagf3sGW+5RndGOekUmc43g
        zxPrRBzxlHIvQJeHLxlUtoqQFwpa0DwLoawrDwxMCrJUQ2GECU6Lgfmi8PGXfPZw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nHS19-00G4m5-7v;
        Tue, 08 Feb 2022 16:02:55 +0100
Message-ID: <c4e0b94283e55619822a2f5d45a91b5d33d3cfa1.camel@sipsolutions.net>
Subject: Re: Dealing with SUBLEVEL overflow in backports
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Date:   Tue, 08 Feb 2022 16:02:54 +0100
In-Reply-To: <1153d726-aed6-0b62-d0f1-6a1e2a878543@flygoat.com>
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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Tue, 2022-02-08 at 14:50 +0000, Jiaxun Yang wrote:
> 
> Ah I tried this approach but find that this may break other modules
> depending on our headers because the cflag won't come with be
> inherited by them.
> 

Hm. I thought about if that could happen, but decided not? We only
compile C files in backports, which other parts would break?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
