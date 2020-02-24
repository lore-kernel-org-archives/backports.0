Return-Path: <SRS0=qhDM=4M=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C699CC3567B
	for <backports@archiver.kernel.org>; Mon, 24 Feb 2020 08:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A509320661
	for <backports@archiver.kernel.org>; Mon, 24 Feb 2020 08:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgBXIjb (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 24 Feb 2020 03:39:31 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:56796 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbgBXIjb (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 24 Feb 2020 03:39:31 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j69Gy-0065J8-Js; Mon, 24 Feb 2020 09:39:28 +0100
Message-ID: <7d27a4380b3f2c1d1c1ada940dae6240ea1c5720.camel@sipsolutions.net>
Subject: Re: [PATCH 02/15] backports: update x509.asn1.[ch]
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Cc:     Luca Coelho <luciano.coelho@intel.com>
Date:   Mon, 24 Feb 2020 09:39:27 +0100
In-Reply-To: <55f3752b-b334-a2af-75f3-4dc90cae9a4e@hauke-m.de>
References: <20200221085624.6213-1-johannes@sipsolutions.net>
         <20200221095437.fcc31f62d6cf.I268b63a7ca56b448e4a0ae8e2f4293561342648d@changeid>
         <55f3752b-b334-a2af-75f3-4dc90cae9a4e@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org


> Should we generate these files automatically?

I think it needs this asn1parser infrastructure from the kernel

> Sine this commit flex and bison are anyway needed for building:
> https://git.kernel.org/pub/scm/linux/kernel/git/backports/backports.git/commit/?id=4ec72687181df4b786152747c008a688c9b9b9de

Not "just" flex/bison (which, btw, is giving me a lot of trouble on
Fedora 31 because 'yacc' is not bison...

> Why did you use kernel 5.2 and nothing more recent?

Old patch from Luca lingering in our tree.

johannes


--
To unsubscribe from this list: send the line "unsubscribe backports" in
