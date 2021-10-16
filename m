Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9572AC433EF
	for <backports@archiver.kernel.org>; Sat, 16 Oct 2021 12:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FFB560F56
	for <backports@archiver.kernel.org>; Sat, 16 Oct 2021 12:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237354AbhJPMI6 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sat, 16 Oct 2021 08:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236141AbhJPMI5 (ORCPT
        <rfc822;backports@vger.kernel.org>); Sat, 16 Oct 2021 08:08:57 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2D3C061570
        for <backports@vger.kernel.org>; Sat, 16 Oct 2021 05:06:49 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4HWhh74cHwzQkB3;
        Sat, 16 Oct 2021 14:06:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1634386005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7w8V/FMgvvkVQP1rCsW4917VHrchMxSrnI7vfzOceqA=;
        b=MK+YhJw59/kqnf++jlH5R8gYZWZ2W9dhedmr+r5XegSuYQH7bLIqLP/EpvSXVC2PRCwsEA
        cn+2/8HJOwk2gFp4wdHeI8yK5Y7JAqlPltObXg2SsbB7raIDsZSz6W2wgWF4aWjf8KZaQ3
        znBFxx1AmUPokRXnj7K02n1WriEWukuPW/He0/hnYP2218cyFo5R37sx7W5Wjcdxj2oFsl
        KuNQcgCtxOyqAeUQmHbzYUqCDkNAXOEYHnIy+Ecra8PgC4QlQtNqkMcIUVlHxMbSLWiHyK
        4g9xGF62/ek+n3ivb7v8zygEJPcZ0vHseM+9VdzeT9rVr+if6pbXCJ086+PJbg==
Subject: Re: [PATCH] backports: add rb_tree_cached
To:     Johannes Berg <johannes@sipsolutions.net>,
        backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
References: <20210715180046.6635727a182b.Id747625a81c1c87ae14145eff93436b94a122980@changeid>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <72a11f8f-66d4-4410-854d-1988f97b3d49@hauke-m.de>
Date:   Sat, 16 Oct 2021 14:06:42 +0200
MIME-Version: 1.0
In-Reply-To: <20210715180046.6635727a182b.Id747625a81c1c87ae14145eff93436b94a122980@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 879C2268
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On 7/15/21 6:00 PM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> We just map them to the normal rb_tree, losing the efficiency
> gain in this case.
> 
> ticket=none
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

I had a look at this too and the cached optimization seams to be 
completely in the header file now, initially the in kernel rb lib code 
was changed too.

Sine this commit we should be able to fully backport this easily:
https://git.kernel.org/linus/9f973cb38088e0cf42e0bae97ff140813e623f13

Hauke

> ---
>   backport/backport-include/linux/rbtree.h | 25 ++++++++++++++++++++++++
>   patches/0104-rb-tree-cached.cocci        |  5 +++++
>   2 files changed, 30 insertions(+)
>   create mode 100644 backport/backport-include/linux/rbtree.h
>   create mode 100644 patches/0104-rb-tree-cached.cocci
> 
> diff --git a/backport/backport-include/linux/rbtree.h b/backport/backport-include/linux/rbtree.h
> new file mode 100644
> index 000000000000..feccff36e7dd
> --- /dev/null
> +++ b/backport/backport-include/linux/rbtree.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2021 Intel Corporation
> + */
> +#ifndef __BACKPORT_RBTREE_H
> +#define __BACKPORT_RBTREE_H
> +#include_next <linux/rbtree.h>
> +
> +#if LINUX_VERSION_IS_LESS(4,14,0)
> +#define rb_root_cached rb_root
> +#define rb_first_cached rb_first
> +static inline void rb_insert_color_cached(struct rb_node *node,
> +					  struct rb_root_cached *root,
> +					  bool leftmost)
> +{
> +	rb_insert_color(node, root);
> +}
> +#define rb_erase_cached rb_erase
> +#define RB_ROOT_CACHED RB_ROOT
> +#define rb_root_node(root) (root)->rb_node
> +#else
> +#define rb_root_node(root) (root)->rb_root.rb_node
> +#endif
> +
> +#endif /* __BACKPORT_RBTREE_H */
> diff --git a/patches/0104-rb-tree-cached.cocci b/patches/0104-rb-tree-cached.cocci
> new file mode 100644
> index 000000000000..a8388c847a5a
> --- /dev/null
> +++ b/patches/0104-rb-tree-cached.cocci
> @@ -0,0 +1,5 @@
> +@@
> +struct rb_root_cached *root;
> +@@
> +-root->rb_root.rb_node
> ++rb_root_node(root)
> 

--
To unsubscribe from this list: send the line "unsubscribe backports" in
