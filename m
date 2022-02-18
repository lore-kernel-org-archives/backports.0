Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204D4C433F5
	for <backports@archiver.kernel.org>; Fri, 18 Feb 2022 21:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237493AbiBRVZ6 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 18 Feb 2022 16:25:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239906AbiBRVZ5 (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 18 Feb 2022 16:25:57 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69754CD53
        for <backports@vger.kernel.org>; Fri, 18 Feb 2022 13:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=lkrc+yu28CKpOa4HZYB9eaNd2pN4ShLrKmZ1mGe14oc=;
        t=1645219539; x=1646429139; b=gdyLQoY+2QKPzdcjQfXcVMMK+WdIbIoNUZHuDdTekzKPo6S
        js+G/1Ch6DPAPXCHqLPOwtueGdk6uvfSAy4vNedS92amzxEJHft8byth80khth1wZiEp3WpICDFwc
        f20cPIGCyN4WcXC8iw72nm2EQQ301adB18/GRwx7YMS7qCBQHJNIgsp1V96IeasuWCk/HFbC3cTxc
        18Wtgz8HQT57YR406arQszDkiPjg+c/pQoZv/KcTpn61jd3C589grWokiT4yYAN10yc/4tOQrGxTo
        T/YLk7LVVOCzT23vdoxO2/fRNI+vdAgu9cPG0Up7FC7BGyEH2KxwQw9gW8DDAyKQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nLAky-002n3U-8U;
        Fri, 18 Feb 2022 22:25:36 +0100
Message-ID: <c6a849a834d6aaf4bf523ad1c0729cb76e44c449.camel@sipsolutions.net>
Subject: Re: [PATCH] backports: Update hwsim defconfig
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>,
        backports@vger.kernel.org
Date:   Fri, 18 Feb 2022 22:25:35 +0100
In-Reply-To: <20220218191038.42064-1-Mathy.Vanhoef@kuleuven.be>
References: <20220218191038.42064-1-Mathy.Vanhoef@kuleuven.be>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org


> Experiments were also less reliable when WEXT was enabled. So this patch
> also disables WEXT when using defconfig-hwsim to make the default more
> reliable for users.

No objection. I thought we actually just disabled it completely in
backports, but perhaps that's an Intel defconfig too.


> -CPTCFG_CFG80211_WEXT=y
> +CPTCFG_CFG80211_WEXT=n

But does that even work? I thought it had to be like this:

>  # CPTCFG_MAC80211_RC_PID is not set
> 

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
