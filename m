Return-Path: <SRS0=KWFe=ZZ=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AEDC432C0
	for <backports@archiver.kernel.org>; Tue,  3 Dec 2019 16:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 559CD20675
	for <backports@archiver.kernel.org>; Tue,  3 Dec 2019 16:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfLCQ2I (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 3 Dec 2019 11:28:08 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:55600 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfLCQ2I (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 3 Dec 2019 11:28:08 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1icB1y-00FdZD-PS
        for backports@vger.kernel.org; Tue, 03 Dec 2019 17:28:06 +0100
Message-ID: <3b26ecccf84f1cff683d6bff67f21063bc50682f.camel@sipsolutions.net>
Subject: Re: [PATCH v2] backports: significantly speed up build
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Date:   Tue, 03 Dec 2019 17:28:05 +0100
In-Reply-To: <20191203161540.174109-1-johannes@sipsolutions.net> (sfid-20191203_171551_146590_1C537702)
References: <20191203161540.174109-1-johannes@sipsolutions.net>
         (sfid-20191203_171551_146590_1C537702)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Tue, 2019-12-03 at 17:15 +0100, Johannes Berg wrote:
> 
> If --eval is not supported, keep doing what we did before.

It's a bit disconcerting that we have systems that run make 3.81 or
older, but apparently that's what happened?! That was released over 9
years ago, and --eval was added to the code base 10 years ago ...

johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
