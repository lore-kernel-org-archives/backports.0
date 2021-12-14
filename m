Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F093C433F5
	for <backports@archiver.kernel.org>; Tue, 14 Dec 2021 22:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbhLNW4q (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 14 Dec 2021 17:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbhLNW4q (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 14 Dec 2021 17:56:46 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35890C061574
        for <backports@vger.kernel.org>; Tue, 14 Dec 2021 14:56:46 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4JDDJq02gwzQlMt;
        Tue, 14 Dec 2021 23:56:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1639522600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pMJzEAVs2mqDryulcGmtsbZoHiEV4SbMVq80ZzkXo+Y=;
        b=QDyq6Le5zhn5Z0l4LLT6/wXWBTJ0T10F1UjzKqQGOCQ+GLGthnUc6ejJK5gsBklx13yJkq
        W10drdLh3wFZ6fzy233wpOftmgzmltKxdQbvChrgi93SQSpjNf2AcxDk+hWIBl1X5ob5X/
        UTpDA+LKt6nMvnMNrqvYJTnH0/95cc72mhXRazdq5BrBWn/yF36wy55viVH6ghs34KAzv3
        Sbp9NQTZiZOM38W9OxaaGdVyQCqp1oJUbiGE1OV/MXGNww3MdvFH2FDMcKxC3gVq3qHSoD
        CAYOCUvfSbmgeKOwjeJ0avs0FqVevXvRMuWE+DN6o7LiSzXsxEaVV8W549RJdg==
Subject: Re: [PATCH 1/1] backports: fix build on recent v4.14 kernels
To:     "Dembianny, Sven (GDE-EDSO)" <Sven.Dembianny@bshg.com>
References: <20211213103700.14935-1-sven.dembianny@bshg.com>
Cc:     "backports@vger.kernel.org" <backports@vger.kernel.org>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <8dfa9ef0-4617-18f4-a91f-1d0dfe6a985e@hauke-m.de>
Date:   Tue, 14 Dec 2021 23:56:38 +0100
MIME-Version: 1.0
In-Reply-To: <20211213103700.14935-1-sven.dembianny@bshg.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On 12/13/21 11:37 AM, Dembianny, Sven (GDE-EDSO) wrote:
> Signed-off-by: Sven Dembianny <sven.dembianny@bshg.com>
> ---

Thank you for your patch, I added it to master and the 5.10 branch.

Hauke
--
To unsubscribe from this list: send the line "unsubscribe backports" in
