Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D78C433F5
	for <backports@archiver.kernel.org>; Fri,  4 Feb 2022 21:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242937AbiBDVld (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 4 Feb 2022 16:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbiBDVld (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 4 Feb 2022 16:41:33 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287C2C061714
        for <backports@vger.kernel.org>; Fri,  4 Feb 2022 13:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=o3rugJoW9wTG5rtKZd7EEi/RKMLh2YRN0DNR8r0wd74=; b=Ww4z0sqxKtohKcJcveuCOtBLgR
        bJOEUbIAf+7VNTYBKvM5hj5N5IG7Fp23x31RBHkS68NHGmVyCJ0RjwmQorD0ggUYuM2Zd06pv6Xrk
        /N7ghGBFNX1try9XdXVTJsIeQBFMOqzBVwgExlS1KRfl5Hsl5j248TpfjZMwPvjSSNfudvQPxJz4Y
        lkzDjAH4yn9DTkSx5yQ87XBh3a2ZRc7EX2D5JIzYSLO/uT+HKvphCun432fpvlyI16w6EAC7c9bQk
        a2HYIJRk981biQLxcl9bC91qtGWGi1sYhUVvz2cXYuz1AS597sTTwuNYZHXx1LR4CJuKYvHUz1JzN
        UhbITKrw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG6Ki-005Tz2-R5; Fri, 04 Feb 2022 21:41:32 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hauke@hauke-m.de, backports@vger.kernel.org, mcgrof@kernel.org
Cc:     thomas@adapt-ip.com, johannes@sipsolutions.net
Subject: [PATCH 0/4] backports: use kconfig from git subtree
Date:   Fri,  4 Feb 2022 13:41:27 -0800
Message-Id: <20220204214131.1306843-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Updated version of kconfig has always been a challenge.
One of the pain points is figuring out how to do this well
and what files / Makefile lines to edit. Part of this is
because we don't carry all the kernel's helpers on our kconfig
helper. The other aspect which makes it hard is figuring out
adjustments of missing files, renames, and updates to things to
make things compile.

The kconfig git subtree effort aims at helping with this. It
figures all the above out for you and all we need to do is just
declare where we keep the kconfig data on, and then include a
Makefile from the git subtree code into our project. That's it.

Of course then there may also be fixes to our Kconfig files for
deprecated features, but that's expected collateral. This drops
our version of kconfig and embraces the git subtree version
whic is now up to date with the latest kconfig from linux-next
next-20220204.

That makes for 4 projects now using this new kconfig git subtree:

 * init-kconfig
 * kdevops
 * fio-tests
 * backports

I've tested this by generating a backport using Linux stable
kernel v5.15.8. At least make menuconfig works.

Luis Chamberlain (4):
  backport/kconf: remove our version of kconfig
  Squashed 'backport/kconf/' content from commit 98bda615
  kconfig: fix backport syntax to work with linux-next next-20220204
  Makefile.subtrees: document how to update kconfig

-- 
2.34.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
