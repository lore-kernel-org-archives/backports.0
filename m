Return-Path: <SRS0=5ABL=X5=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C8EC4CED1
	for <backports@archiver.kernel.org>; Fri,  4 Oct 2019 08:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE6882070B
	for <backports@archiver.kernel.org>; Fri,  4 Oct 2019 08:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387535AbfJDI4A (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 4 Oct 2019 04:56:00 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:35544 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387525AbfJDI4A (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 4 Oct 2019 04:56:00 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iGJNW-0002tf-Ql; Fri, 04 Oct 2019 10:55:59 +0200
Message-ID: <c403b93ef2fcec5881934c6e6a58363eb24a31b1.camel@sipsolutions.net>
Subject: Re: [PATCH 09/11] backports: dependencies: make ATH9K OWL depend on
 kernel 3.14
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Date:   Fri, 04 Oct 2019 10:55:58 +0200
In-Reply-To: <20191003155642.14909-10-hauke@hauke-m.de>
References: <20191003155642.14909-1-hauke@hauke-m.de>
         <20191003155642.14909-10-hauke@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Thu, 2019-10-03 at 17:56 +0200, Hauke Mehrtens wrote:
> The ath9k owl driver uses pci_lock_rescan_remove() and
> pci_unlock_rescan_remove() which was added in kernel 3.14, only compile
> it on kernel >= 3.14.

This confuses me a bit - isn't pci_stop_and_remove_bus_device() the more
important part of the API?

johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
