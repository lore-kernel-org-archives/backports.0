Return-Path: <SRS0=qhDM=4M=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A87DC3567B
	for <backports@archiver.kernel.org>; Mon, 24 Feb 2020 08:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 631BA20661
	for <backports@archiver.kernel.org>; Mon, 24 Feb 2020 08:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgBXIkF (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 24 Feb 2020 03:40:05 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:56816 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbgBXIkF (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 24 Feb 2020 03:40:05 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j69HW-0065PM-ET; Mon, 24 Feb 2020 09:40:02 +0100
Message-ID: <6552ea0e50d017dbd29247aa0f046070ac2e3661.camel@sipsolutions.net>
Subject: Re: [PATCH 01/15] backports: handle RHEL 7.6 kernel
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Cc:     Luca Coelho <luciano.coelho@intel.com>
Date:   Mon, 24 Feb 2020 09:40:01 +0100
In-Reply-To: <98e5b161-1bde-e663-d08a-6f142ab40aed@hauke-m.de>
References: <20200221085624.6213-1-johannes@sipsolutions.net>
         <20200221095437.388a35c2cde6.Ic310f826e4d1e036eca65b4fa7d13d2da12620aa@changeid>
         <98e5b161-1bde-e663-d08a-6f142ab40aed@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Sun, 2020-02-23 at 23:24 +0100, Hauke Mehrtens wrote:
> On 2/21/20 9:56 AM, Johannes Berg wrote:
> > From: Luca Coelho <luciano.coelho@intel.com>
> > 
> > RHEL 7.6 uses kernel v3.10 with a lot of backports from newer
> > kernels.  This causes compilation to break in many places when the
> > backports project is used.  To solve the issue, check for RHEL release
> > code 7.6 where appropriate.  This doesn't take into consideration
> > lower versions of the kernel (i.e. < 7.6), because it's very difficult
> > to find the information about when each feature was backported.
> > 
> > type=maint
> > ticket=none

Good catch :)

Did you reply below anything else? I didn't read past the long quote ...

johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
