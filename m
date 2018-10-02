Return-Path: <SRS0=zs2H=MO=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F89FC64EBA
	for <backports@archiver.kernel.org>; Tue,  2 Oct 2018 19:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E069206B2
	for <backports@archiver.kernel.org>; Tue,  2 Oct 2018 19:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E069206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=backports-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbeJCCJm (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:09:42 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:48274 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbeJCCJl (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 2 Oct 2018 22:09:41 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1g7QHj-0004eW-NZ; Tue, 02 Oct 2018 21:24:43 +0200
Message-ID: <1538508272.3126.51.camel@sipsolutions.net>
Subject: Re: [PATCH] backports: crypto_memneq has been backported to 3.12
 and 3.10
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Alban Bedel <alban.bedel@avionic-design.de>, hauke@hauke-m.de,
        mcgrof@kernel.org
Cc:     backports@vger.kernel.org
Date:   Tue, 02 Oct 2018 21:24:32 +0200
In-Reply-To: <20180910131448.23225-1-alban.bedel@avionic-design.de> (sfid-20180910_153135_699821_F2DF8D7C)
References: <20180910131448.23225-1-alban.bedel@avionic-design.de>
         (sfid-20180910_153135_699821_F2DF8D7C)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Mon, 2018-09-10 at 15:14 +0200, Alban Bedel wrote:
> crypto_memneq has been backported in 3.12.59 and 3.10.106, it
> shouldn't be built for these kernels.

FWIW, I just reverted this - if you actually build with this patch then
you get __crypto_memneq() twice - since we always build memneq.c.

Without the patch, it's renamed to backport___crypto_memneq() and
there's no problem.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
