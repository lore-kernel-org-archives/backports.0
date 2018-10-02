Return-Path: <SRS0=zs2H=MO=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F101C43143
	for <backports@archiver.kernel.org>; Tue,  2 Oct 2018 18:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D592082A
	for <backports@archiver.kernel.org>; Tue,  2 Oct 2018 18:39:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35D592082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=backports-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbeJCBXq (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 2 Oct 2018 21:23:46 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:47894 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbeJCBXq (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 2 Oct 2018 21:23:46 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1g7PZU-00041T-Tx
        for backports@vger.kernel.org; Tue, 02 Oct 2018 20:39:01 +0200
Message-ID: <1538505530.3126.49.camel@sipsolutions.net>
Subject: Re: [PATCH 6/6] backports: genetlink: update completely
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Date:   Tue, 02 Oct 2018 20:38:50 +0200
In-Reply-To: <20181002175107.16336-6-johannes@sipsolutions.net> (sfid-20181002_195130_622184_25ABC8B0)
References: <20181002175107.16336-1-johannes@sipsolutions.net>
         <20181002175107.16336-6-johannes@sipsolutions.net>
         (sfid-20181002_195130_622184_25ABC8B0)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Tue, 2018-10-02 at 19:51 +0200, Johannes Berg wrote:
> 
> +static int backport_pre_doit(__genl_const struct genl_ops *ops,
> +			     struct sk_buff *skb,
> +			     struct genl_info *info)
> +{
> +	const struct genl_family *family = find_family_real_ops(&ops);
> +	int err;
> +#if LINUX_VERSION_IS_LESS(4,12,0)
> +	struct netlink_ext_ack *extack = kzalloc(sizeof(*extack), GFP_KERNEL);
> +
> +	__bp_genl_info_userhdr_set(info, extack);
> +
> +	if (!extack) {
> +		__bp_genl_info_userhdr_set(info, ERR_PTR(-ENOMEM));
> +		return -ENOMEM;
> +	}
> +
> +	extack->__bp_doit = ops->doit;
> +#else
> +	struct netlink_ext_ack *extack = info->extack;
> +#endif
> +
> +	err = nlmsg_validate(info->nlhdr, GENL_HDRLEN + family->hdrsize,
> +			     family->maxattr, ops->policy, extack);
> +	if (err)
> +		return err;
> +
> +	err = family->pre_doit(ops, skb, info);
> +
> +#if LINUX_VERSION_IS_LESS(4,12,0)
> +	if (err) {
> +		__bp_genl_info_userhdr_set(info, ERR_PTR(err));
> +		kfree(extack);
> +	}
> +#endif

This is wrong, it doesn't free the extack on errors.

We could also immediately send the ACK out, I think, and include the
error there.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
