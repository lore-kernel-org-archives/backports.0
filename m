Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B14C433F5
	for <backports@archiver.kernel.org>; Sat, 11 Dec 2021 19:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbhLKTEU (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sat, 11 Dec 2021 14:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbhLKTEU (ORCPT
        <rfc822;backports@vger.kernel.org>); Sat, 11 Dec 2021 14:04:20 -0500
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6E1C061714
        for <backports@vger.kernel.org>; Sat, 11 Dec 2021 11:04:19 -0800 (PST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4JBHJ13hTHzQlRX;
        Sat, 11 Dec 2021 20:04:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1639249455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FySKQUCieIZa0NPAim3b/OAp8w6wDaNHtswTcBccTBk=;
        b=Wq2Qb4C0Su1nKxGUfXRP3DwJKdw2NPQxpRZr3oZUPlq263MSvzPR56mvkNAFl7KIrtP85O
        0kPu7z42KgnJezOeLk75Q6zEO/BmmPvA3aw37HETsI4J5+4dcEFJi65Sm35HP/moDRkW0q
        VJ/28x3kuRzLgmtjJOvFukuxBV7Z1lLJey47v8nO6Ql9Z3+TUfLIQ+8czLbqnq4t0VbS2k
        Mlu9P6OG6DxQTlltNyDE6o3qryMNolCHUtJZW4VRDD25fp3e3+aCdpjZS7oHPpmAN+cejX
        sLzutC6zpgq8FsX0zwGh/cP5aQHZtYX0phZnt3X9xrlnEGHuohKsyvKRju/j1g==
Subject: Re: [PATCH 1/1] backports: fix build on recent v4.14 kernels
To:     "Dembianny, Sven (GDE-EDSO)" <Sven.Dembianny@bshg.com>,
        "backports@vger.kernel.org" <backports@vger.kernel.org>
References: <20211209162516.25022-1-sven.dembianny@bshg.com>
 <20211209162516.25022-2-sven.dembianny@bshg.com>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <ef7ae359-e24c-13fa-6335-b969874887ed@hauke-m.de>
Date:   Sat, 11 Dec 2021 20:04:13 +0100
MIME-Version: 1.0
In-Reply-To: <20211209162516.25022-2-sven.dembianny@bshg.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On 12/9/21 5:25 PM, Dembianny, Sven (GDE-EDSO) wrote:
> From: "Dembianny, Sven" <sven.dembianny@bshg.com>
> 

Please add a Signed-off-by line to this patch.

> ---
>   backport/backport-include/linux/skbuff.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
> index 1fd25fcd..c5015e9d 100644
> --- a/backport/backport-include/linux/skbuff.h
> +++ b/backport/backport-include/linux/skbuff.h
> @@ -62,7 +62,8 @@ static inline struct sk_buff *__skb_peek(const struct sk_buff_head *list_)
>   	return list_->next;
>   }
>   
> -#if !LINUX_VERSION_IN_RANGE(4,19,10, 4,20,0)
> +#if !LINUX_VERSION_IN_RANGE(4,19,10, 4,20,0) && \
> +    !LINUX_VERSION_IN_RANGE(4,14,217, 4,15,0)
>   static inline void skb_mark_not_on_list(struct sk_buff *skb)
>   {
>   	skb->next = NULL;
> 

--
To unsubscribe from this list: send the line "unsubscribe backports" in
