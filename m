Return-Path: <SRS0=zs2H=MO=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0811AC64EB8
	for <backports@archiver.kernel.org>; Tue,  2 Oct 2018 19:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF34F206B2
	for <backports@archiver.kernel.org>; Tue,  2 Oct 2018 19:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF34F206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=backports-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbeJCCSl (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:18:41 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:48368 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbeJCCSl (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 2 Oct 2018 22:18:41 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1g7QQS-0004qu-2r
        for backports@vger.kernel.org; Tue, 02 Oct 2018 21:33:44 +0200
Message-ID: <1538508812.3126.53.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/6] backports: rename magic functions for netlink
 parsing
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Date:   Tue, 02 Oct 2018 21:33:32 +0200
In-Reply-To: <20181002193215.399-1-johannes@sipsolutions.net> (sfid-20181002_213235_248201_B908EB59)
References: <20181002193215.399-1-johannes@sipsolutions.net>
         (sfid-20181002_213235_248201_B908EB59)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

I've just tested this whole series on 3.11 (yes!) and 4.11, so I'm
confident it works and will apply it :-)

And yes, it does have a few fixes over the first version that came up
when testing on 3.11.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
