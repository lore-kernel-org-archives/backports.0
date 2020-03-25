Return-Path: <SRS0=WOnz=5K=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C71C1975A
	for <backports@archiver.kernel.org>; Wed, 25 Mar 2020 07:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F0AB20714
	for <backports@archiver.kernel.org>; Wed, 25 Mar 2020 07:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgCYH7h (ORCPT <rfc822;backports@archiver.kernel.org>);
        Wed, 25 Mar 2020 03:59:37 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:41330 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgCYH7h (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 25 Mar 2020 03:59:37 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jH0wo-007d9y-NH; Wed, 25 Mar 2020 08:59:34 +0100
Message-ID: <5f338970bb8b2b98af420f08c02fb039e3d7de74.camel@sipsolutions.net>
Subject: Re: [PATCH 00/15] updates & improvements
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Date:   Wed, 25 Mar 2020 08:59:33 +0100
In-Reply-To: <6a46da0a-b03c-32d8-caaa-87b13b021d34@hauke-m.de>
References: <20200221085624.6213-1-johannes@sipsolutions.net>
         <6a46da0a-b03c-32d8-caaa-87b13b021d34@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Wed, 2020-03-25 at 00:11 +0100, Hauke Mehrtens wrote:
> On 2/21/20 9:56 AM, Johannes Berg wrote:
> > This is what we have now to make our driver (only) work on 5.5, and
> > because I got tired of waiting for the devel/git-tracker.py I threw
> > in a speed improvement for the gentree --git option, using git's
> > cat-file --batch API. We should use that for much more, and perhaps
> > implicitly in the git library, but getting the files was one of the
> > slower things, now it's barely noticable.
> > 
> > johannes
> 
> I left out the RedHat patch and applied the rest. I removed the type and
> ticket tag from some coimmit messages.

Thanks!

johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
