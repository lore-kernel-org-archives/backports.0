Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505B8C433F5
	for <backports@archiver.kernel.org>; Mon, 11 Apr 2022 07:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238272AbiDKIAs (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 11 Apr 2022 04:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbiDKIAs (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 11 Apr 2022 04:00:48 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8929B186C2
        for <backports@vger.kernel.org>; Mon, 11 Apr 2022 00:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=X84sIoigx8ax1a+eTZCopxk5iPwSMyVCyUuicGAkZ+A=;
        t=1649663914; x=1650873514; b=HWXzDaKo3fjbbQsYJ180UQguZwrvVyrIdZGiGwtKkoFVQKt
        pSH1TDhvHfKQn9HPpWhJOMI8DdCXxnqc272lHpF1fZByEyvq5B5wXTv9SL9wRm1wadENS+HqHmsli
        VM9TOBD6e+DmdcD/tX7SoITF7FWAifQSACKXqKAGOKYadKL6BdNzNWas2bh0yQ4EqIFgSXM+rvSpM
        LRl9vFPZHRT6cDAsi/ihY3fgALzFZcPkorUWXNnePKQQBIvF69jAkx1zWICJewCM437wrSSCsruy1
        trGPTYC5UXPNy6ISI+TE3T0QCvdNkRoHmCbuK/v5iodaAGRwaIKA0kT8a6r2frYA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ndowR-008BQc-Tp;
        Mon, 11 Apr 2022 09:58:32 +0200
Message-ID: <d7f450afc9877b06cba8f5e6b4083b34f0733ef5.camel@sipsolutions.net>
Subject: Re: [PATCHv2] backports: Update hwsim defconfig
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>,
        backports@vger.kernel.org
Date:   Mon, 11 Apr 2022 09:58:31 +0200
In-Reply-To: <20220411073931.19198-1-Mathy.Vanhoef@kuleuven.be>
References: <20220411073931.19198-1-Mathy.Vanhoef@kuleuven.be>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Mon, 2022-04-11 at 15:39 +0800, Mathy Vanhoef wrote:
> In the current hwsim config no rate control algorithm is enabled. This
> means that, when using defconfig-hwsim, the mac80211_hwsim fails to load
> with the following error:
> 
> 	[  132.155183] ieee80211 phy0: Failed to select rate control algorithm
> 	[  132.155196] ieee80211 phy0: Failed to initialize rate control algorithm
> 
> Fix this by enabling rate control algorithms in the provided hwsim
> config.

Makes sense, thanks.

> Experiments were also less reliable when WEXT was enabled. So this patch
> also disables WEXT when using defconfig-hwsim to make the default more
> reliable for users.
> 

Huh? How so? Maybe some other tool was present on the system that was
using wext, and disabling wext made that tool no longer detect the
wireless or so? I cannot see how else it would be "less reliable" with
wext enabled, if you don't really use it.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
