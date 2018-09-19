Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.62]:51614 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730392AbeISPk4 (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 19 Sep 2018 11:40:56 -0400
Message-ID: <1537351415.10305.34.camel@sipsolutions.net> (sfid-20180919_120348_454832_8A580E67)
Subject: Re: [PATCH] backports: add strreplace()
From: Johannes Berg <johannes@sipsolutions.net>
To: Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>,
        "backports@vger.kernel.org" <backports@vger.kernel.org>
Cc: Winnie Chang <Winnie.Chang@cypress.com>
Date: Wed, 19 Sep 2018 12:03:35 +0200
In-Reply-To: <1537351259-19914-1-git-send-email-chi-hsien.lin@cypress.com>
References: <1537351259-19914-1-git-send-email-chi-hsien.lin@cypress.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2018-09-19 at 10:01 +0000, Chi-Hsien Lin wrote:
> From: Winnie Chang <Winnie.Chang@cypress.com>
> 
> wireless-drivers-next.git commit cb18e2e9ec71 (brcmfmac: fix wrong
> strnchr usage) used strreplace(), which is not available in kernel prior
> to v4.12.

4.12,

> +#if LINUX_VERSION_IS_LESS(4,2,0)

or 4.2?

johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
