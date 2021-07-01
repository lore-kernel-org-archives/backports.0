Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3324C11F67
	for <backports@archiver.kernel.org>; Thu,  1 Jul 2021 21:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89B9B61410
	for <backports@archiver.kernel.org>; Thu,  1 Jul 2021 21:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhGAVmm (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 1 Jul 2021 17:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhGAVml (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 1 Jul 2021 17:42:41 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF07CC061762
        for <backports@vger.kernel.org>; Thu,  1 Jul 2021 14:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=3/rPGWRUjrdP9PbFVrib/gH+GC9ASI6+m+4uiBZbTT8=;
        t=1625175610; x=1626385210; b=sLJ8KaWfS+Cdw9Tlkd/BHSeW5WtlzA6c16G8Re7J5DTcGEr
        SMDlYm0PHGX8nZ5NEcRXV27NBIYh6QtxfBOnz/Z+GjsHRBJKe3mGrbRqCybyWIceeYMgqcdTqAC2U
        zjtZ6tOFytpXdH3ws5EsEXRrzZh8byjm7Rze2L/5mo8mBFNy3SpfZ81KdFkCTP6GPYCd+fnm+mqAD
        Nb+DfQnMKUFNmohwOX26xlXlI8uARk/irrpL9ArEVuWUbJ8bX8yej3EoLbvKNEv7+DKX/8JxhwERv
        yC9LKK2S46C7BA01GjsYkjTgi10azLiSsX5fMo4hpGSMfmow9dO9wzu46tSTMB4w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lz4Pj-00EOsb-Lb; Thu, 01 Jul 2021 23:40:03 +0200
Message-ID: <84336f24b55f6ef407511235a90af4b24a8488ce.camel@sipsolutions.net>
Subject: Re: backports spatch question
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        Hauke Mehrtens <hauke@hauke-m.de>
Cc:     backports@vger.kernel.org
Date:   Thu, 01 Jul 2021 23:40:02 +0200
In-Reply-To: <e26b0d55-8662-ecf7-6630-ac23a99374b5@candelatech.com>
References: <e26b0d55-8662-ecf7-6630-ac23a99374b5@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Thu, 2021-07-01 at 14:39 -0700, Ben Greear wrote:
> Hello,
> 
> I'm trying to get backports to work against my 5.13 kernel.  I'm executing
> this attempt on a Fedora-34 system, freshly updated.
> 
> I am stuck on an spatch thing:
> 
> [greearb@v-f34-64 backports]$ mkdir /tmp/x
> [greearb@v-f34-64 backports]$ spatch --sp-file patches/0049-no-pfmemalloc/no-pfmemalloc.cocci --dir /tmp/x
> init_defs_builtins: /usr/lib64/coccinelle/standard.h
> minus: parse error:
>    File "patches/0049-no-pfmemalloc/no-pfmemalloc.cocci", line 7, column 4, charpos = 90
>    around = 'page_is_pfmemalloc',
>    whole content =  || page_is_pfmemalloc(page)
> 
> 
> [greearb@v-f34-64 backports]$ cat patches/0049-no-pfmemalloc/no-pfmemalloc.cocci
> @r1@
> struct page *page;
> expression E1;
> @@
>   return E1
> +#if LINUX_VERSION_IS_GEQ(3,6,0)
>   || page_is_pfmemalloc(page)
> +#endif /* if LINUX_VERSION_IS_GEQ(3,6,0) */
>   ;
> 
> 
> Any idea how to fix this?

What's your spatch version on that system?

johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
