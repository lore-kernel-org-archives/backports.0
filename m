Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB59C433FE
	for <backports@archiver.kernel.org>; Wed, 12 Oct 2022 08:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiJLIgK (ORCPT <rfc822;backports@archiver.kernel.org>);
        Wed, 12 Oct 2022 04:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJLIgJ (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 12 Oct 2022 04:36:09 -0400
X-Greylist: delayed 1009 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Oct 2022 01:36:07 PDT
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8BFB40C1
        for <backports@vger.kernel.org>; Wed, 12 Oct 2022 01:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FAUiT8Wtj9EBi3l7im1ABpyV7xyI97uQV7TjEQ7mU/8=; b=c0S4EL2bpoVRNEmXqhutIjId1W
        2YxuLS4yoJg9Nk4jXbIDo653Cpf42rCeXaJo6rCGWtS3g1XKVGau+bfB527mK3zESmXcs3sInbjA9
        iBsP+oII8laDHdE8ZEANDzlRUf8l8U7INM+8bcAIiyIcU0ZXmTc0djC1AMRKNpqtPTBc=;
Received: from p200300daa7301d00510a235bff22d42e.dip0.t-ipconnect.de ([2003:da:a730:1d00:510a:235b:ff22:d42e] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1oiWx8-00CAHd-QU; Wed, 12 Oct 2022 10:18:58 +0200
Message-ID: <59047a24-e419-a750-afae-213f2d8aac0d@nbd.name>
Date:   Wed, 12 Oct 2022 10:18:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: [PATCH 11/38] backports: stub structs but remove
 ndo_fill_forward_path
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        backports@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
References: <20221011210446.144768-1-johannes@sipsolutions.net>
 <20221011230356.fc6d493894a6.I59271805ee60501a03c50f5ec05240393f1fb4be@changeid>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <20221011230356.fc6d493894a6.I59271805ee60501a03c50f5ec05240393f1fb4be@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On 11.10.22 23:04, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   backport/backport-include/linux/netdevice.h | 55 +++++++++++++++++++++
>   patches/0107-net-forward-path.cocci         | 19 +++++++
>   2 files changed, 74 insertions(+)
>   create mode 100644 patches/0107-net-forward-path.cocci
> 

> diff --git a/patches/0107-net-forward-path.cocci b/patches/0107-net-forward-path.cocci
> new file mode 100644
> index 000000000000..f612239404a6
> --- /dev/null
> +++ b/patches/0107-net-forward-path.cocci
> @@ -0,0 +1,19 @@
> +@ops@
> +identifier ops, fn;
> +@@
> +const struct net_device_ops ops = {
> ++#if LINUX_VERSION_IS_GEQ(5,13,0)
> +  .ndo_fill_forward_path = fn,
> ++#endif
> +  ...
> +};
> +
> +@@
> +identifier ops.fn;
> +@@
> ++#if LINUX_VERSION_IS_GEQ(5,13,0)
> +int fn(...)
> +{
> +...
> +}
> ++#endif /* LINUX_VERSION_IS_GEQ(5,13,0) */
How about using #ifdef NET_DEVICE_PATH_STACK_MAX here as well?

- Felix
--
To unsubscribe from this list: send the line "unsubscribe backports" in
