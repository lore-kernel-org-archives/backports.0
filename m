Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3359C433F5
	for <backports@archiver.kernel.org>; Fri,  4 Feb 2022 21:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242848AbiBDVlR (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 4 Feb 2022 16:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbiBDVlR (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 4 Feb 2022 16:41:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84904C061714
        for <backports@vger.kernel.org>; Fri,  4 Feb 2022 13:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zfF7xLzTtO6zuZECy+DMDyvANEikk6tcFdjhx75LqVg=; b=JcDOWrvvYVJUDsJZsTRx+bi+6f
        mNRlTdcjPqsxvB7+cmopSSM8+dcwfPGWPEAwx0bEK6TPGJHa/QJAOqRI1CPR9mZ17DTxzxT+t8t96
        HnXPCKsCKVwHWx+O6rQX7WScELo4wsQQCKRQGwMkn1kLxXCpUX/0yNY3Cfu0VqDWlvnvdGb0+WvSA
        pHdvBzxgOVxzoh45coaIc8eT9Yjg/PRlPUw2uh0/d6pMuzVir6OlCWp9mQCNumS43MrDpKD+UIrjz
        1Uu0BYrylgvTITwNX90ip8Uj9fKIPbJbCylXlVRPTzgyN4bcV3mi8rQO0ovytVF4NL2xboTDyfEt8
        YP7BVxeA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG6KO-005TwV-WB; Fri, 04 Feb 2022 21:41:12 +0000
Date:   Fri, 4 Feb 2022 13:41:12 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     backports <backports@vger.kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 0/7] Resurrect backports Integration Mode
Message-ID: <Yf2deGvC/8OQg3Z0@bombadil.infradead.org>
References: <20211124055505.1267128-1-thomas@adapt-ip.com>
 <YZ5E0B+r0MylLwJw@bombadil.infradead.org>
 <36a7926bc3d5529b0d5f76a28deec840@adapt-ip.com>
 <YfyN2GnfeANyNhaS@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfyN2GnfeANyNhaS@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Thu, Feb 03, 2022 at 06:22:16PM -0800, Luis Chamberlain wrote:
> Can someone try to convert over backports to it?

Nevermind, I've done this work and I'll post patches now.

  Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
