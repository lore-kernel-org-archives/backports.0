Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:49746 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752276AbeAaLfV (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 31 Jan 2018 06:35:21 -0500
Message-ID: <1517398519.2189.53.camel@sipsolutions.net> (sfid-20180131_123523_705134_5741DD73)
Subject: Re: [PATCH] backports: include linux/err.h in key.c
From: Johannes Berg <johannes@sipsolutions.net>
To: Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        backports@vger.kernel.org
Cc: Winnie Chang <winnie.chang@cypress.com>
Date: Wed, 31 Jan 2018 12:35:19 +0100
In-Reply-To: <20180119080215.GA102758@aremote07.aus.cypress.com> (sfid-20180119_090250_042216_85C253C3)
References: <20180119080215.GA102758@aremote07.aus.cypress.com>
         (sfid-20180119_090250_042216_85C253C3)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2018-01-19 at 02:02 -0600, Chi-Hsien Lin wrote:
> From: Winnie Chang <winnie.chang@cypress.com>
> 
> Function IS_ERR, PTR_ERR and ERR_PTR are not found. Need to include
> linux/err.h to fix compiling errors.
> 
Applied, thanks. Sorry for the delay.

johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
