Return-Path: <SRS0=vUcr=CQ=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA9CC43461
	for <backports@archiver.kernel.org>; Mon,  7 Sep 2020 17:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 503D22080A
	for <backports@archiver.kernel.org>; Mon,  7 Sep 2020 17:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731126AbgIGRGm (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730700AbgIGRGl (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 7 Sep 2020 13:06:41 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE28C061573
        for <backports@vger.kernel.org>; Mon,  7 Sep 2020 10:06:40 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kFKbH-000DA4-4q; Mon, 07 Sep 2020 19:06:39 +0200
Message-ID: <b08abbca99fa57bf582b3ff2512d9057efbc2034.camel@sipsolutions.net>
Subject: Re: Enabling WEXT_CORE
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Etienne Cordonnier <cordonnier.etienne@gmail.com>,
        backports@vger.kernel.org
Date:   Mon, 07 Sep 2020 19:06:36 +0200
In-Reply-To: <CAJFWPWZRyVuzPy5_vR=2jJRPzG0pXA2hEhpL-sBDmHFLr43Fdw@mail.gmail.com> (sfid-20200907_184703_153601_F3FCD893)
References: <CAJFWPWZRyVuzPy5_vR=2jJRPzG0pXA2hEhpL-sBDmHFLr43Fdw@mail.gmail.com>
         (sfid-20200907_184703_153601_F3FCD893)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Mon, 2020-09-07 at 18:35 +0200, Etienne Cordonnier wrote:
> Hello,
> I am using linux-backports in "integration mode" and managed to
> backport wireless drivers from 5.4 to 4.9 (I needed to fix a few
> Kconfig files, since integration mode does not work 100% out of the
> box, but other than that everything seems to work).
> 
> One issue I have is that the file
> "patches/0004-disable-wext-kconfig.patch" is removing the option
> WEXT_CORE in backports/net/wireless/Kconfig, meaning that there is no
> config BACKPORT_WEXT_CORE defined. However the config
> BACKPORT_CFG80211_WEXT depends on WEXT_CORE, so I cannot enable
> BACKPORT_CFG80211_WEXT and support for the old iwconfig interface (the
> iw tool works fine, though). Is it a known limitation, or am I missing
> something?

It's a known and more or less intentional limitation - there's no good
way to do this because some wext bits need to be built into the kernel
specifically for cfg80211.

Just stop using wext.

johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
