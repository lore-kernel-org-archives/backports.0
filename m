Return-Path: <SRS0=Yj0x=ZL=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399CBC43215
	for <backports@archiver.kernel.org>; Tue, 19 Nov 2019 09:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AEF321739
	for <backports@archiver.kernel.org>; Tue, 19 Nov 2019 09:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725306AbfKSJAY (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Nov 2019 04:00:24 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:34944 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfKSJAY (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Nov 2019 04:00:24 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iWzN1-0007Cd-1p; Tue, 19 Nov 2019 10:00:23 +0100
Message-ID: <254b908a51b4275428529d432e3514e0cdc967db.camel@sipsolutions.net>
Subject: Re: [PATCH 2/3] backports: Adapt to changes to
 skb_get_hash_perturb()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Date:   Tue, 19 Nov 2019 10:00:22 +0100
In-Reply-To: <20191116183623.8858-2-hauke@hauke-m.de> (sfid-20191116_194151_198224_71659ADD)
References: <20191116183623.8858-1-hauke@hauke-m.de>
         <20191116183623.8858-2-hauke@hauke-m.de>
         (sfid-20191116_194151_198224_71659ADD)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Sat, 2019-11-16 at 19:36 +0100, Hauke Mehrtens wrote:
> The skb_get_hash_perturb() function now takes a siphash_key_t instead of
> an u32. This was changed in commit 55667441c84f ("net/flow_dissector:
> switch to siphash"). Use the correct type in the fq header file
> depending on the kernel version.


Thanks, I was trying to figure this out recently but hadn't gotten that
far...

johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
