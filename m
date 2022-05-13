Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E92C433EF
	for <backports@archiver.kernel.org>; Fri, 13 May 2022 16:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344683AbiEMQhh (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 13 May 2022 12:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381108AbiEMQhg (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 13 May 2022 12:37:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B1F50B00
        for <backports@vger.kernel.org>; Fri, 13 May 2022 09:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OHGwGBzglf1TAHfrvXAYYI+MTMUsqLoxwYBPJeUW1PE=; b=Yh0v2Chc7GAPHKgaD/4B1ASn7U
        mMWbQP/oe8BW0Fe2VOcmuhQQHWCGi9howIPjMvxGVYrzqq9a5ITFEhBMnEoaNAAqYvVzaM1vic9zC
        B48cZz5I9Z4TDMxrcKREPtNv4N/3sRHBHzHn8qTNFBwr7h25He87s/e+USPmO9OTFuxkZ3GA2QrWs
        RsEPmRYfzXADXtz4BEVUgecUVdEoeG2SClQ6qYMptlilHk+yPBxTpHQxT3tUFwIU9JkiMXwosrDks
        VlcSPVPIwfdkZerRijA+HAVrzdj7Z0ADrNphCMneE63YeDmz/nQdJb6dVS2Uh6P+MOOXirYcbdcQa
        BQ4RqQjg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1npYII-00GsCk-AJ; Fri, 13 May 2022 16:37:34 +0000
Date:   Fri, 13 May 2022 09:37:34 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     backports <backports@vger.kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [PATCH v2 00/15] Resurrect Integration Mode v2
Message-ID: <Yn6JTjZLl7DxC9hk@bombadil.infradead.org>
References: <20220513160523.2944694-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513160523.2944694-1-thomas@adapt-ip.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Fri, May 13, 2022 at 09:05:08AM -0700, Thomas Pedersen wrote:

For all:

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
