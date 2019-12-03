Return-Path: <SRS0=KWFe=ZZ=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814EBC432C3
	for <backports@archiver.kernel.org>; Tue,  3 Dec 2019 15:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA57206EC
	for <backports@archiver.kernel.org>; Tue,  3 Dec 2019 15:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfLCPSa (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 3 Dec 2019 10:18:30 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:54772 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfLCPSa (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 3 Dec 2019 10:18:30 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ic9wZ-00FUc5-VU
        for backports@vger.kernel.org; Tue, 03 Dec 2019 16:18:28 +0100
Message-ID: <1bef9e95439caedef7dd2252b5414035e370f7b7.camel@sipsolutions.net>
Subject: Re: [PATCH] backports: speed up building with bash
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Date:   Tue, 03 Dec 2019 16:18:26 +0100
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

The real results are like this:

Completely clean build, after git clean -fdxq, but I have ccache primed
so all the stuff is build overhead - gcc is ccache and just returns
directly from the cache.

without the patch:
real	9m17.180s
user	24m38.063s
sys	0m32.138s


with the patch:
real	0m18.157s
user	0m24.553s
sys	0m13.342s


I'll let those results speak for themselves ...

johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
