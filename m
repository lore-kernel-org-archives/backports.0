Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.62]:50710 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbeIJPNE (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 10 Sep 2018 11:13:04 -0400
Message-ID: <1536574774.3224.47.camel@sipsolutions.net> (sfid-20180910_121945_651060_900B609B)
Subject: Re: [PATCH v2] patches: update lib-bucket_locks.patch for v4.18-rc1
From: Johannes Berg <johannes@sipsolutions.net>
To: Winnie Chang <winnie.chang@cypress.com>, backports@vger.kernel.org
Cc: Chi-Hsien.Lin@cypress.com
Date: Mon, 10 Sep 2018 12:19:34 +0200
In-Reply-To: <20180910100207.GA28327@aremote01.aus.cypress.com> (sfid-20180910_120240_586331_C52E9F69)
References: <20180910100207.GA28327@aremote01.aus.cypress.com>
         (sfid-20180910_120240_586331_C52E9F69)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2018-09-10 at 05:02 -0500, Winnie Chang wrote:
> This patch do not apply to source code in v4.18-rc1 due to
> commit ce91f6ee5b3b (mm: kvmalloc does not fallback to vmalloc for
> incompatible gfp flags) so updating it.

I just applied Felix's removal of this, so this should no longer be
necessary.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
