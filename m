Return-Path: <SRS0=KWFe=ZZ=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDF7C432C0
	for <backports@archiver.kernel.org>; Tue,  3 Dec 2019 15:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC3E22073C
	for <backports@archiver.kernel.org>; Tue,  3 Dec 2019 15:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfLCPP5 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 3 Dec 2019 10:15:57 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:54758 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfLCPP5 (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 3 Dec 2019 10:15:57 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ic9u8-00FUIx-7k
        for backports@vger.kernel.org; Tue, 03 Dec 2019 16:15:56 +0100
Message-ID: <ccfcea76fdcea5d9d77da762b734dfe337c71532.camel@sipsolutions.net>
Subject: Re: [PATCH] backports: speed up building with bash
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Date:   Tue, 03 Dec 2019 16:15:54 +0100
In-Reply-To: <20191203150610.152231-1-johannes@sipsolutions.net> (sfid-20191203_160632_743093_BF954A9E)
References: <20191203150610.152231-1-johannes@sipsolutions.net>
         (sfid-20191203_160632_743093_BF954A9E)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Tue, 2019-12-03 at 16:06 +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> When building with /bin/sh -> bash, things are SUPER slow (at least
> for me), because bash takes a LOOONG time to look at the environment
> variables (and we typically have around 6k), adding ~300ms to each
> bash invocation for me.

I think this was under-estimating it a bit - it's more like 1.3 seconds?

Anyway ...

johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
