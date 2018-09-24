Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.62]:57244 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbeIXNUS (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 24 Sep 2018 09:20:18 -0400
Message-ID: <1537773565.1707.21.camel@sipsolutions.net> (sfid-20180924_091938_593997_8B2E0645)
Subject: Re: [PATCH v2] backports: add strreplace()
From: Johannes Berg <johannes@sipsolutions.net>
To: Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>,
        "backports@vger.kernel.org" <backports@vger.kernel.org>
Cc: Winnie Chang <Winnie.Chang@cypress.com>
Date: Mon, 24 Sep 2018 09:19:25 +0200
In-Reply-To: <1537354267-42104-1-git-send-email-chi-hsien.lin@cypress.com> (sfid-20180919_125122_741789_0CE09797)
References: <1537354267-42104-1-git-send-email-chi-hsien.lin@cypress.com>
         (sfid-20180919_125122_741789_0CE09797)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2018-09-19 at 10:51 +0000, Chi-Hsien Lin wrote:
> From: Winnie Chang <Winnie.Chang@cypress.com>
> 
> wireless-drivers-next.git commit cb18e2e9ec71 (brcmfmac: fix wrong
> strnchr usage) used strreplace(), which is not available in kernel prior
> to v4.2. Before this commit proprgates to linux-stable.git, add
> strreplace() to avoid gentree failure.

Something's fishy with your email - there's no whitespace in it at all??

Anyway, since it was only a few lines I've fixed it up, but please check
what the reason was before/when you send a new patch.

Thanks,
johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
