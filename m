Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEE0C2D0E4
	for <backports@archiver.kernel.org>; Sun, 15 Nov 2020 14:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1A88222B8
	for <backports@archiver.kernel.org>; Sun, 15 Nov 2020 14:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="XEvhbRui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbgKOOMs (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 15 Nov 2020 09:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbgKOOMs (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 15 Nov 2020 09:12:48 -0500
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B90C0613D1
        for <backports@vger.kernel.org>; Sun, 15 Nov 2020 06:12:47 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4CYvL62V8KzQlRC;
        Sun, 15 Nov 2020 15:12:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1605449564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yRnBzdTQnREr/9nUH7iZGljeu0jIhUEjU0ptUW2ugZE=;
        b=XEvhbRuiA86YkTWHxN0zwj29Mvpf3mjI6wQyYev2bLLzNxNuDixmeusZymeYw1Uo6qHjnD
        WVPEOtGGV01KaUTF1n7m4HL0Q0R77LwuT4bGzOn8DoPz3kmFWkegP91iMQT3TIUr8WMcBE
        D/iJr80BZd+dkFpTs+9teNqV9zl8XzXkNgwOMSknE1PnzEk13SQ+RGdwtD5yKuKvedVLsf
        czZU684sKkeLEyaazSWC3lXUW3fdes50I4lE3autyKe1xk0uv7bAiWUulDzlpKDqIOw5RH
        xTJTzXSq4shFY2Tt0DfVOcsXFwWG59R2sTHDF4jvzlSQr/B1mBgdqx8T1hssrw==
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id oocFrbt2l2dj; Sun, 15 Nov 2020 15:12:42 +0100 (CET)
Subject: Re: [PATCH 1/2] backports: add sched_set_fifo_low
To:     Felix Fietkau <nbd@nbd.name>, backports@vger.kernel.org
References: <20201112103546.74014-1-nbd@nbd.name>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <e55cfa6d-8bea-5f38-73f5-03b1f1f027db@hauke-m.de>
Date:   Sun, 15 Nov 2020 15:12:41 +0100
MIME-Version: 1.0
In-Reply-To: <20201112103546.74014-1-nbd@nbd.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -6.83 / 15.00 / 15.00
X-Rspamd-Queue-Id: 1323B16FE
X-Rspamd-UID: 499027
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On 11/12/20 11:35 AM, Felix Fietkau wrote:
> It is needed for mt76
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>   backport/backport-include/linux/sched.h | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>   create mode 100644 backport/backport-include/linux/sched.h
> 
> diff --git a/backport/backport-include/linux/sched.h b/backport/backport-include/linux/sched.h
> new file mode 100644
> index 000000000000..be77a8d771ab
> --- /dev/null
> +++ b/backport/backport-include/linux/sched.h
> @@ -0,0 +1,19 @@
> +#ifndef __BACKPORT_LINUX_SCHED_H
> +#define __BACKPORT_LINUX_SCHED_H
> +
> +#include_next <linux/sched.h>
> +#include <linux/version.h>
> +
> +#if LINUX_VERSION_IS_LESS(5,9,0)
> +#include <uapi/linux/sched/types.h>
> +
> +static inline void sched_set_fifo_low(struct task_struct *p)
> +{
> +	struct sched_param sparam = {.sched_priority = 1};
> +
> +	sched_setscheduler(p, SCHED_FIFO, &sparam);

Hi Felix,

The upstream kernel uses this in sched_set_fifo_low():
    WARN_ON_ONCE(sched_setscheduler_nocheck(p, SCHED_FIFO, &sp) != 0);
See:
https://elixir.bootlin.com/linux/v5.10-rc3/source/kernel/sched/core.c#L5570

Did you change this intentionally?

Hauke
--
To unsubscribe from this list: send the line "unsubscribe backports" in
