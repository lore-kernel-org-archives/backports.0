Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33DBC433FE
	for <backports@archiver.kernel.org>; Mon, 11 Apr 2022 22:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238931AbiDKWCw (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 11 Apr 2022 18:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344427AbiDKWC2 (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 11 Apr 2022 18:02:28 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C89BC5
        for <backports@vger.kernel.org>; Mon, 11 Apr 2022 15:00:09 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4KcjT35Gfgz9sXS;
        Tue, 12 Apr 2022 00:00:07 +0200 (CEST)
Message-ID: <87c73e18-7cf9-b6d0-57db-b50bcfbdf460@hauke-m.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1649714405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1VXAuNjQVTha6oqLoJRLP9f37mxABxlocvLpd0nIKDo=;
        b=dGZfLOQ71K/W9jXpA1oKn67hXu4J0odquBI9Vmw45XXspCt6jK3oWEme125MQ/V9y0d7OR
        8VJIQYwPbplRPv6KDmWBYyMDf6796dDNsLUwSrQGKZpD1Qsq7QP4kxjouxyfG9UGyTj7m2
        q/DwGSPt17L0+SN/5V/R6FpnGFx2r/wjzB+VgoBfpv9czX8PQNGljpkHpr34MTQGdB59IJ
        EydnX03L63PA8yTwybG+q7UvGy3eGjOp0hoqVQHc/Cj8wiHCSsN+UuixjpHc4o/xij8uEO
        zCjMNLpfL0XgFDQx0fH263rgZ+G+KrB7xpGkF2RFv0Fc+O2SndP9wqNI5Olb+w==
Date:   Tue, 12 Apr 2022 00:00:03 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] patches: Add missing definition for
 NL80211_FILS_DISCOVERY_ATTR_TMPL
Content-Language: en-US
To:     Aloka Dixit <quic_alokad@quicinc.com>
Cc:     backports@vger.kernel.org
References: <20220322182148.27727-1-quic_alokad@quicinc.com>
From:   Hauke Mehrtens <hauke@hauke-m.de>
In-Reply-To: <20220322182148.27727-1-quic_alokad@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On 3/22/22 19:21, Aloka Dixit wrote:
> Add definition for the attribute NL80211_FILS_DISCOVERY_ATTR_TMPL
> which is missing for kernels older than 5.10.0.
> 
> Fixes: 51258137c228 ("patches: Avoid using NLA_POLICY_RANGE(...)")
> Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>

Thank you for your patch, I applied it to master.

Hauke
--
To unsubscribe from this list: send the line "unsubscribe backports" in
