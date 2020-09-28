Return-Path: <SRS0=boiZ=DF=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00557C2D0A8
	for <backports@archiver.kernel.org>; Mon, 28 Sep 2020 07:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B81AB2076D
	for <backports@archiver.kernel.org>; Mon, 28 Sep 2020 07:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgI1HVA (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 28 Sep 2020 03:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgI1HVA (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 28 Sep 2020 03:21:00 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C4EC0613CE
        for <backports@vger.kernel.org>; Mon, 28 Sep 2020 00:20:59 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kMnSx-00CLxI-I6; Mon, 28 Sep 2020 09:20:55 +0200
Message-ID: <1923f0e6540d422d41f5817caeae412c49de973a.camel@sipsolutions.net>
Subject: Re: [PATCH v2 2/2] backports: add skb_list_del_init
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Felix Fietkau <nbd@nbd.name>, Hauke Mehrtens <hauke@hauke-m.de>,
        backports@vger.kernel.org
Cc:     luciano.coelho@intel.com
Date:   Mon, 28 Sep 2020 09:20:38 +0200
In-Reply-To: <e7a00f96-41e4-6513-5962-b80fbfa37613@nbd.name> (sfid-20200928_085509_032248_C1749EAB)
References: <20200814142958.7773-1-nbd@nbd.name>
         <20200814142958.7773-2-nbd@nbd.name>
         <8e1d9f3d-4128-4030-97fd-3e541bb9c7e6@hauke-m.de>
         <e7a00f96-41e4-6513-5962-b80fbfa37613@nbd.name>
         (sfid-20200928_085509_032248_C1749EAB)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Mon, 2020-09-28 at 08:31 +0200, Felix Fietkau wrote:
> 
> > The list member was only added in kernel 4.19 to the sk_buff structure,
> > see here:
> > https://git.kernel.org/linus/d4546c2509b1e9cd082e3682dcec98472e37ee5a
> I guess it was working for me on 4.14 because the list member was
> backported in 4.14.71.
> So it works for kernels with that backport, and I guess other versions
> which don't have that will need a more intrusive backport that patches
> mac80211 anyway.

I think Luca (+) just made some internally - we should push that out.

johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
