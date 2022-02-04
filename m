Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FA0C433F5
	for <backports@archiver.kernel.org>; Fri,  4 Feb 2022 21:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbiBDVnn (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 4 Feb 2022 16:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244532AbiBDVnl (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 4 Feb 2022 16:43:41 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C33C061714
        for <backports@vger.kernel.org>; Fri,  4 Feb 2022 13:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XfjntnNw/W7f3DGTmmjKdGxEVS7EKuLuu7VSxgT07Cs=; b=Vxi0kBZV0PKOWqW0Z2DBcr+piS
        nKT4F+2j3mL3Zx/t7ISoCFujRzH6wbhJcp/piRpoxIBBeJm8KTlXoRMbRoHRRhoCSI4xBDEI/lcfi
        9IEj77lFwtoGEtnMlPvGfO3ryuCVf4jXjTX8P8J6rJy5l/uqqhFZFQYph/Mz5mhH+aqrxjZYsyalZ
        jzgeF9iTNKozjsMPKiFRgErJ/dFMFbte6X45NTr1i2yrQxEmnQGQZjY3+5kmXjGfRDJJIYSFzJlt9
        /Ew/sAK6f8g1I+BaD8sqllrcqmmg9hcZdUivufcx2HWX01HGSOR+bZaFx1/98j6nJa02rxAFtJxFI
        /BoSKjfA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG6Mm-005UIn-4E; Fri, 04 Feb 2022 21:43:40 +0000
Date:   Fri, 4 Feb 2022 13:43:40 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hauke@hauke-m.de, backports@vger.kernel.org
Cc:     thomas@adapt-ip.com, johannes@sipsolutions.net
Subject: Re: [PATCH 4/4] Makefile.subtrees: document how to update kconfig
Message-ID: <Yf2eDDZ/5fUDPcIM@bombadil.infradead.org>
References: <20220204214131.1306843-1-mcgrof@kernel.org>
 <20220204214131.1306843-5-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204214131.1306843-5-mcgrof@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Fri, Feb 04, 2022 at 01:41:31PM -0800, Luis Chamberlain wrote:
> Now that kconfig is a git sub tree document what we need to do
> to update version of config. We use squash here so we don't
> carry the kconfig tree update logs in our commit log.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  Makefile.subtrees | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>  create mode 100644 Makefile.subtrees
> 
> diff --git a/Makefile.subtrees b/Makefile.subtrees
> new file mode 100644
> index 00000000..49bb13b3
> --- /dev/null
> +++ b/Makefile.subtrees
> @@ -0,0 +1,10 @@
> +# If you need to use a git subtree, please add it here.
> +add-kconfig-remote:
> +	git remote add kconfig https://github.com/mcgrof/kconfig.git
> +
> +add-kconfig:
> +	git subtree add --prefix=backport/kconf --squash kconfig master
> +
> +refresh-kconfig:
> +	git fetch kconfig
> +	git subtree pull --prefix=backport/kconf --squash kconfig master
> -- 
> 2.34.1
> 

To be clear:

a new maintainer later wishes to update kconfig, all they have to do is:

make -f Makefile.subtrees add-kconfig-remote
make -f Makefile.subtrees refresh-kconfig

After doing this once all you have to do is:

make -f Makefile.subtrees refresh-kconfig

  Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
