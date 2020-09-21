Return-Path: <SRS0=wwGC=C6=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8CDC4346E
	for <backports@archiver.kernel.org>; Mon, 21 Sep 2020 19:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 852E420757
	for <backports@archiver.kernel.org>; Mon, 21 Sep 2020 19:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgIUTZg (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 21 Sep 2020 15:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbgIUTZf (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 21 Sep 2020 15:25:35 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7E5C061755
        for <backports@vger.kernel.org>; Mon, 21 Sep 2020 12:25:35 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kKRRA-008OT5-6V; Mon, 21 Sep 2020 21:25:20 +0200
Message-ID: <f3b8ef76decf5b3204463f8a2267ba456562f691.camel@sipsolutions.net>
Subject: Re: [PATCH 0/3] [backport] nvme: Consolidate chunk_sectors settings
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Revanth Rajashekar <revanth.rajashekar@intel.com>,
        linux-nvme@lists.infradead.org, hch@lst.de
Cc:     kbusch@kernel.org, damien.lemoal@wdc.com, backports@vger.kernel.org
Date:   Mon, 21 Sep 2020 21:25:08 +0200
In-Reply-To: <20200921184728.11291-1-revanth.rajashekar@intel.com> (sfid-20200921_204456_447027_687C7A95)
References: <20200921184728.11291-1-revanth.rajashekar@intel.com>
         (sfid-20200921_204456_447027_687C7A95)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Mon, 2020-09-21 at 12:47 -0600, Revanth Rajashekar wrote:
> Backport commit 38adf94e166e3cb4eb89683458ca578051e8218d and it's
> dependencies to linux-stable 5.4.y.
> 

backports@vger.kernel.org isn't for backporting kernel patches...

I guess you want to CC stable if they need to pick up any of this, or
perhaps something else, but almost certainly not backports@.

johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
