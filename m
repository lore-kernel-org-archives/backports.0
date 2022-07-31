Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F46C00140
	for <backports@archiver.kernel.org>; Sun, 31 Jul 2022 15:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237438AbiGaP4V (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 31 Jul 2022 11:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiGaP4T (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 31 Jul 2022 11:56:19 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3540A460
        for <backports@vger.kernel.org>; Sun, 31 Jul 2022 08:56:17 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Lwm7v6HBCz9sPp;
        Sun, 31 Jul 2022 17:56:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1659282971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QpEAhkrtzRX6h8yCbo7Nm/GOQ2OPNKhxAgM9AJPxOlw=;
        b=zbe1mQIOb/ky/Iy9Rf1/PaXfsVPpiVCUh6mDhz//4Z7sDg709ugTAqz49a30+Y/PvD1PZY
        1r25kUdPhE7sxOTSXCAUlRXJ69C02K9AtBqRHgWYWWil8e1KVId3pdmRnimPBrARw2vQP/
        qOoDqt8XvNSw+Cb72gJr1loNuRkctF3Cw2DY/ojd/MFdJk+/j/dZG6JL362kzUhxZKQxBK
        mwIRXUyGeDHe4cKQnbRVszFKXJc87taLYRNflOTOdGNkRERaGqSdjzRb+ijX0l+FlRpY2z
        LauGw4EDFLS2Hrr7Bi9CoMbg6W8Ng9AKsHspTyD2co2s4e/oD55cT9EDVe40Rw==
Message-ID: <87fd5fab-99e4-bf4e-6110-c0a9b2de8ed8@hauke-m.de>
Date:   Sun, 31 Jul 2022 17:56:10 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] headers: backport IBT / CFI support
Content-Language: en-US
To:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
        backports@vger.kernel.org
References: <20220711161130.529294-1-dimitri.ledkov@canonical.com>
From:   Hauke Mehrtens <hauke@hauke-m.de>
In-Reply-To: <20220711161130.529294-1-dimitri.ledkov@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4Lwm7v6HBCz9sPp
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On 7/11/22 18:11, Dimitri John Ledkov wrote:
> Kernels that support IBT on x86 require module_init/exit() functions
> to have cfi protection included. Backport __CFI_ADDRESSABLE changes
> from upstream linux/module.h into backports version of module.h
> header.
> 
> This results in backported modules correctly pick up CFI protection
> only when building against IBT enabled kernels.
> 
> Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>

Thank you for your patch I applied it to master.

Hauke
--
To unsubscribe from this list: send the line "unsubscribe backports" in
