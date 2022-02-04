Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B481C433EF
	for <backports@archiver.kernel.org>; Fri,  4 Feb 2022 21:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244940AbiBDVnh (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 4 Feb 2022 16:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245676AbiBDVnY (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 4 Feb 2022 16:43:24 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B723C06173D
        for <backports@vger.kernel.org>; Fri,  4 Feb 2022 13:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=IDVw2KeEHfRCEDxpabOR2AmG8h74tvWB28ilLQFB0Bw=;
        t=1644011003; x=1645220603; b=jCxMVoDIwnMxh/95aEidfX73owi4UdmsSRRs/0esnnrtyXF
        DhdsXj+sBd2HZcAsRsiidTEBugFFvzp2sQzSx4gw52Ot/diMXGrTdcDOMXmtE4f5VnLRtCOshh5Ex
        zreFH+NTG83/2dERO7pzKsL4ytmGwIhvvzx6zg4DiLea6tipkClLYwbqQQeJ0q1y6SXfaUTyL1vJz
        ziNfFh61sEmC2vtoJNgjgE1hm0tfXla0z9IfugQZTHAfFiWE2WZY959erYyANJZOQsD/2t0bBGAwx
        vtEp4pQe/Ma1eKeQIHUoHjAO3VAK4batuj3YyNZGl6q4l/Tz9vdLefCC3ieDXb4w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nG6MN-00EdNr-LM;
        Fri, 04 Feb 2022 22:43:16 +0100
Message-ID: <33b187cc471610599be0662e6d2050d3b26c98a2.camel@sipsolutions.net>
Subject: Re: [PATCH 4/4] Makefile.subtrees: document how to update kconfig
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Luis Chamberlain <mcgrof@kernel.org>, hauke@hauke-m.de,
        backports@vger.kernel.org
Cc:     thomas@adapt-ip.com
Date:   Fri, 04 Feb 2022 22:43:14 +0100
In-Reply-To: <20220204214131.1306843-5-mcgrof@kernel.org>
References: <20220204214131.1306843-1-mcgrof@kernel.org>
         <20220204214131.1306843-5-mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Fri, 2022-02-04 at 13:41 -0800, Luis Chamberlain wrote:
> 
> +add-kconfig-remote:
> +	git remote add kconfig https://github.com/mcgrof/kconfig.git
> 

Does this really make sense?

We could do what we do for a lot of other code, and just copy it from
the kernel while generating the backport. Why depend on another project?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
