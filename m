Return-Path: <SRS0=Yj0x=ZL=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAD2C432C0
	for <backports@archiver.kernel.org>; Tue, 19 Nov 2019 19:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F7E6222A9
	for <backports@archiver.kernel.org>; Tue, 19 Nov 2019 19:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfKSTih (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Nov 2019 14:38:37 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:44522 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbfKSTih (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Nov 2019 14:38:37 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iX9Kd-0006IN-KB; Tue, 19 Nov 2019 20:38:35 +0100
Message-ID: <26dd2a9e3582668e8d708832d24ec5f5d331a520.camel@sipsolutions.net>
Subject: Re: [PATCH 3/3] backports: Add kvcalloc()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Date:   Tue, 19 Nov 2019 20:38:34 +0100
In-Reply-To: <3325f5fa-aa94-cf5b-cfdd-810495a390e0@hauke-m.de>
References: <20191116183623.8858-1-hauke@hauke-m.de>
         <20191116183623.8858-3-hauke@hauke-m.de>
         <7a07656e09b4d38dea46551258f6e78d36547c49.camel@sipsolutions.net>
         <3325f5fa-aa94-cf5b-cfdd-810495a390e0@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Tue, 2019-11-19 at 20:12 +0100, Hauke Mehrtens wrote:
> On 11/19/19 9:59 AM, Johannes Berg wrote:
> > On Sat, 2019-11-16 at 19:36 +0100, Hauke Mehrtens wrote:
> > > kvcalloc() was added in kernel commit 1c542f38ab8d ("mm: Introduce
> > > kvcalloc()") and is now used by the fq header filers.
> > 
> > Oops, I did the same some time ago but forgot to send it out.
> > 
> > > +{
> > > +	return kvmalloc_array(n, size, flags | __GFP_ZERO);
> > 
> > I did end up wondering though if __GFP_ZERO actually worked on all old
> > kernels?
> 
> __GFP_ZERO is at least defined on old kernel versions. I haven't seen an
> error when building against 3.14 for example and it is already used
> somewhere else in this file.

I know. I just have a vague recollection it didn't always work for any
kind of allocation. I guess I should go search tomorrow...

johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
