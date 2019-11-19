Return-Path: <SRS0=Yj0x=ZL=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03E7C432C3
	for <backports@archiver.kernel.org>; Tue, 19 Nov 2019 08:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDB95206B6
	for <backports@archiver.kernel.org>; Tue, 19 Nov 2019 08:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbfKSI7d (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Nov 2019 03:59:33 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:34900 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfKSI7d (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Nov 2019 03:59:33 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iWzMB-00079n-Tb; Tue, 19 Nov 2019 09:59:32 +0100
Message-ID: <7a07656e09b4d38dea46551258f6e78d36547c49.camel@sipsolutions.net>
Subject: Re: [PATCH 3/3] backports: Add kvcalloc()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Date:   Tue, 19 Nov 2019 09:59:30 +0100
In-Reply-To: <20191116183623.8858-3-hauke@hauke-m.de> (sfid-20191116_194343_428871_6B46718C)
References: <20191116183623.8858-1-hauke@hauke-m.de>
         <20191116183623.8858-3-hauke@hauke-m.de>
         (sfid-20191116_194343_428871_6B46718C)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Sat, 2019-11-16 at 19:36 +0100, Hauke Mehrtens wrote:
> kvcalloc() was added in kernel commit 1c542f38ab8d ("mm: Introduce
> kvcalloc()") and is now used by the fq header filers.

Oops, I did the same some time ago but forgot to send it out.

> +{
> +	return kvmalloc_array(n, size, flags | __GFP_ZERO);

I did end up wondering though if __GFP_ZERO actually worked on all old
kernels?

johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
