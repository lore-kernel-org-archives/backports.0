Return-Path: <SRS0=VT+k=NS=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31ADAC0044C
	for <backports@archiver.kernel.org>; Wed,  7 Nov 2018 09:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E90A12081D
	for <backports@archiver.kernel.org>; Wed,  7 Nov 2018 09:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E90A12081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=backports-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbeKGTIl (ORCPT <rfc822;backports@archiver.kernel.org>);
        Wed, 7 Nov 2018 14:08:41 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:53306 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbeKGTIl (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 7 Nov 2018 14:08:41 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1gKKIl-0007gq-5E; Wed, 07 Nov 2018 10:39:07 +0100
Message-ID: <e47d4b4b88f3b0212e525ff26fcc93b7400072a7.camel@sipsolutions.net>
Subject: Re: [PATCH] backports: wrap pci_alloc_irq_vectors() in PCI defines
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>,
        "backports@vger.kernel.org" <backports@vger.kernel.org>
Cc:     Winnie Chang <Winnie.Chang@cypress.com>
Date:   Wed, 07 Nov 2018 10:39:05 +0100
In-Reply-To: <1541583418-196225-1-git-send-email-chi-hsien.lin@cypress.com> (sfid-20181107_103746_394708_739E53DB)
References: <1541583418-196225-1-git-send-email-chi-hsien.lin@cypress.com>
         (sfid-20181107_103746_394708_739E53DB)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Wed, 2018-11-07 at 09:37 +0000, Chi-Hsien Lin wrote:
> From: Winnie Chang <Winnie.Chang@cypress.com>
> 
> pci_alloc_irq_vectors() needs to be wrapped in CONFIG_PCI and
> CONFIG_PCI_MSI definition to avoid a function redefinition compiler
> error.

Applied, thanks!

johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
