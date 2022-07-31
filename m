Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A1CC00140
	for <backports@archiver.kernel.org>; Sun, 31 Jul 2022 15:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236780AbiGaP41 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 31 Jul 2022 11:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiGaP40 (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 31 Jul 2022 11:56:26 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EFEF5A8
        for <backports@vger.kernel.org>; Sun, 31 Jul 2022 08:56:25 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Lwm866jKyz9sPp;
        Sun, 31 Jul 2022 17:56:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1659282982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bfbIOyjkmk9wNp9StZCr1d3Ykh8e2Sdi4NvPA4/JbME=;
        b=JMMAfyc1dQ0cMvc6RfSc+SIW6UxIzvsp7PC5V9BS+8nYN8SkmChrJkcvMyN5qoqJz7TE6E
        26s2oAI8obmZRyNKKxdqt9GgDVsnVdqAWNyuxxjl/9G/AqsJempu79wwYPnaRqAsfh/1dP
        oHMZDM3dvZhFOZSIys6FYWN82VeSykXC2Nf/E4uPRATw5Rq0bWXoYVrRzQZgVlwe9t1uyl
        N7hT1C1CT4fapbB2tdk7xSPYIVidQR0bNWSxZQft00vNXBRunlFCiSE/OnPETpHoz+gNRr
        PtyxmlOwVXo8FVp913ZNBwHJ8Y6ACfO0ChDLSgjYWWcjqmpp3NnqnbU2dRk2aA==
Message-ID: <fb8b69ab-6893-821e-c71a-25e3b32bd6c5@hauke-m.de>
Date:   Sun, 31 Jul 2022 17:56:22 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] backports: add QMI helpers
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, backports@vger.kernel.org
References: <20220530174700.1669944-1-robimarko@gmail.com>
From:   Hauke Mehrtens <hauke@hauke-m.de>
In-Reply-To: <20220530174700.1669944-1-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4Lwm866jKyz9sPp
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On 5/30/22 19:47, Robert Marko wrote:
> QMI helpers are used by ath11k for both AHB and PCI support.
> They are also not user selectable but rather are meant to be selected
> by ath11k, so backport them as well to avoid patching the kernel to
> provide these from OpenWrt for example.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>   backport/Kconfig.sources | 1 +
>   backport/Makefile.kernel | 1 +
>   copy-list                | 5 +++++
>   dependencies             | 2 ++
>   4 files changed, 9 insertions(+)
> 
Thank you for your patch I applied it to master.

Hauke

--
To unsubscribe from this list: send the line "unsubscribe backports" in
