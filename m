Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E84BC433E0
	for <backports@archiver.kernel.org>; Wed, 24 Feb 2021 15:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 485AA64EFA
	for <backports@archiver.kernel.org>; Wed, 24 Feb 2021 15:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbhBXPoa (ORCPT <rfc822;backports@archiver.kernel.org>);
        Wed, 24 Feb 2021 10:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbhBXOfx (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 24 Feb 2021 09:35:53 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDD3C061786
        for <backports@vger.kernel.org>; Wed, 24 Feb 2021 06:32:10 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lEvCy-007ygp-3x; Wed, 24 Feb 2021 15:32:08 +0100
Message-ID: <0dfe67b7019ec7971244d5e2813f9b6c1a558524.camel@sipsolutions.net>
Subject: Re: backports Kconfig processing
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     backports@vger.kernel.org
Date:   Wed, 24 Feb 2021 15:32:06 +0100
In-Reply-To: <a3926220-cc2c-5feb-0017-bf8793184cea@broadcom.com>
References: <a3926220-cc2c-5feb-0017-bf8793184cea@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Hi Arend,

> I was made aware that the select line in brcm80211 Kconfig is not 
> working in backports:
> 
> select WANT_DEV_COREDUMP if BRCMFMAC
> 
> Is this something that can be fixed in backports?

I guess it can be, but what do you mean by "not working"?

It should be rewritten to

select BPAUTO_WANT_DEV_COREDUMP if BRCMFMAC

but quite possibly the parser doesn't understand the " if BRCMFMAC" part
there.

johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
