Return-Path: <SRS0=9sdh=2N=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3472FC2D0C0
	for <backports@archiver.kernel.org>; Mon, 23 Dec 2019 19:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13433206B7
	for <backports@archiver.kernel.org>; Mon, 23 Dec 2019 19:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfLWTRA (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 23 Dec 2019 14:17:00 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:48140 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfLWTRA (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 23 Dec 2019 14:17:00 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ijTCM-008oaD-MX; Mon, 23 Dec 2019 20:16:58 +0100
Message-ID: <44e109a2685099f7382c38fed293e4dc42129c15.camel@sipsolutions.net>
Subject: Re: [PATCH v2] backports: significantly speed up build
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     backports@vger.kernel.org
Date:   Mon, 23 Dec 2019 20:16:57 +0100
In-Reply-To: <03a681ac-6394-2c33-aec4-a8b69f84fcdc@hauke-m.de>
References: <20191203161540.174109-1-johannes@sipsolutions.net>
         <3b26ecccf84f1cff683d6bff67f21063bc50682f.camel@sipsolutions.net>
         <03a681ac-6394-2c33-aec4-a8b69f84fcdc@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Mon, 2019-12-23 at 19:51 +0100, Hauke Mehrtens wrote:
> On 12/3/19 5:28 PM, Johannes Berg wrote:
> > On Tue, 2019-12-03 at 17:15 +0100, Johannes Berg wrote:
> > > If --eval is not supported, keep doing what we did before.
> > 
> > It's a bit disconcerting that we have systems that run make 3.81 or
> > older, but apparently that's what happened?! That was released over 9
> > years ago, and --eval was added to the code base 10 years ago ...
> > 
> > johannes

> This looks good, but I am not an bash expert.

Neither am I! I just noticed the speed problem :-)

Really though, this change isn't much related to bash, right? It just
passes the variables to the sub-make in a different way.

> Even RedHat 7.7 uses make 3.82, so I do not care about older versions
> any more.

Cool. We had some older ones around in our infrastructure ... working to
get rid of them :)

johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
