Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDD7C388F9
	for <backports@archiver.kernel.org>; Wed, 11 Nov 2020 07:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE67E2065C
	for <backports@archiver.kernel.org>; Wed, 11 Nov 2020 07:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbgKKHnc (ORCPT <rfc822;backports@archiver.kernel.org>);
        Wed, 11 Nov 2020 02:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgKKHnc (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 11 Nov 2020 02:43:32 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCB1C0613D1
        for <backports@vger.kernel.org>; Tue, 10 Nov 2020 23:43:32 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kckmq-005R0t-6P; Wed, 11 Nov 2020 08:43:24 +0100
Message-ID: <187383b66a4dca05cc9cc58564672381ced3d0de.camel@sipsolutions.net>
Subject: Re: [PATCH v2 2/2] backports: add skb_list_del_init
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hauke Mehrtens <hauke@hauke-m.de>,
        "Coelho, Luciano" <luciano.coelho@intel.com>,
        "nbd@nbd.name" <nbd@nbd.name>,
        "backports@vger.kernel.org" <backports@vger.kernel.org>
Date:   Wed, 11 Nov 2020 08:43:16 +0100
In-Reply-To: <fa8b5247-f06f-0f2f-1f73-cd84bd50c475@hauke-m.de>
References: <20200814142958.7773-1-nbd@nbd.name>
         <20200814142958.7773-2-nbd@nbd.name>
         <8e1d9f3d-4128-4030-97fd-3e541bb9c7e6@hauke-m.de>
         <e7a00f96-41e4-6513-5962-b80fbfa37613@nbd.name>
         <1923f0e6540d422d41f5817caeae412c49de973a.camel@sipsolutions.net>
         <761d13bdc1b162ed574c6b3c3bb9b6635ad696f7.camel@intel.com>
         <fa8b5247-f06f-0f2f-1f73-cd84bd50c475@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Wed, 2020-11-11 at 00:24 +0100, Hauke Mehrtens wrote:
> 
> With kernel 5.10 I see some changes in netlink again. Do you already 
> have some patches for that?

Not yet. It's likely going to be rather tricky, though in nl80211 we
don't have multiple policies, so we could just basically revert commit
66a9b9287d24 ("genetlink: move to smaller ops wherever possible").

johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
