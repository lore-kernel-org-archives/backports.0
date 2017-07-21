Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:39714 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750861AbdGUNVZ (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 21 Jul 2017 09:21:25 -0400
Message-ID: <1500643281.20057.0.camel@coelho.fi> (sfid-20170721_152132_789563_131446C7)
From: Luca Coelho <luca@coelho.fi>
To: AceLan Kao <acelan.kao@canonical.com>, hauke@hauke-m.de,
        mcgrof@kernel.org, backports@vger.kernel.org
Date: Fri, 21 Jul 2017 16:21:21 +0300
In-Reply-To: <1500620116-20476-1-git-send-email-acelan.kao@canonical.com>
References: <1500620116-20476-1-git-send-email-acelan.kao@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] backport: add some new kv[mz]alloc function
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2017-07-21 at 14:55 +0800, AceLan Kao wrote:
> add some new kv[mz]alloc functions which introduced after v4.12
> by this commit
> 
> commit a7c3e901a46ff54c016d040847eda598a9e3e653
> Author: Michal Hocko <mhocko@suse.com>
> Date:   Mon May 8 15:57:09 2017 -0700
> 
>     mm: introduce kv[mz]alloc helpers
> 
> Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
> ---

I don't see any backported code using any of these yet... Why do you
need it?

--
Cheers,
Luca.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
