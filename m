Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2E0C433F5
	for <backports@archiver.kernel.org>; Thu, 12 May 2022 22:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353938AbiELWbU (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 12 May 2022 18:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349298AbiELWbT (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 12 May 2022 18:31:19 -0400
X-Greylist: delayed 316 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 12 May 2022 15:31:18 PDT
Received: from web.adapt-ip.com (mail.adapt-ip.com [107.194.246.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A9556FA9
        for <backports@vger.kernel.org>; Thu, 12 May 2022 15:31:17 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 47CB46E3929;
        Thu, 12 May 2022 22:26:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id NsIpQittYDtq; Thu, 12 May 2022 22:25:57 +0000 (UTC)
Received: from mail.ibsgaard.io (c-73-162-155-239.hsd1.ca.comcast.net [73.162.155.239])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 3AF3A6E39F9;
        Thu, 12 May 2022 22:25:57 +0000 (UTC)
MIME-Version: 1.0
Date:   Thu, 12 May 2022 15:25:56 -0700
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     hauke@hauke-m.de, backports@vger.kernel.org,
        johannes@sipsolutions.net
Subject: Re: [PATCH 0/4] backports: use kconfig from git subtree
In-Reply-To: <20220204214131.1306843-1-mcgrof@kernel.org>
References: <20220204214131.1306843-1-mcgrof@kernel.org>
Message-ID: <33970b2070d31b3150acc41b1ddbf88e@adapt-ip.com>
X-Sender: thomas@adapt-ip.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On 2022-02-04 13:41, Luis Chamberlain wrote:
> Updated version of kconfig has always been a challenge.
> One of the pain points is figuring out how to do this well
> and what files / Makefile lines to edit. Part of this is
> because we don't carry all the kernel's helpers on our kconfig
> helper. The other aspect which makes it hard is figuring out
> adjustments of missing files, renames, and updates to things to
> make things compile.

Yep. When refreshing the integration mode patches[1] I went through the 
following process:

1) Realize kconfig changes are needed
2) Check if Luis' patches were merged
3) Decide to pull in new kconfig changes manually just to get unblocked
4) Wonder which kconfig files are actually needed.

> The kconfig git subtree effort aims at helping with this. It
> figures all the above out for you and all we need to do is just
> declare where we keep the kconfig data on, and then include a
> Makefile from the git subtree code into our project. That's it.

So, from my point of view this seems like a fine change.

[1] 
https://lore.kernel.org/all/YfyN2GnfeANyNhaS@bombadil.infradead.org/T/

-- 
thomas
--
To unsubscribe from this list: send the line "unsubscribe backports" in
