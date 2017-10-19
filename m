Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:42830 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751586AbdJSGlD (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 19 Oct 2017 02:41:03 -0400
Message-ID: <1508395260.8801.0.camel@sipsolutions.net> (sfid-20171019_084107_032745_FD8A7C1A)
Subject: Re: [PATCH] backports: remove CRYPTO_CCM backport
From: Johannes Berg <johannes@sipsolutions.net>
To: Luca Coelho <luca@coelho.fi>, backports@vger.kernel.org
Date: Thu, 19 Oct 2017 08:41:00 +0200
In-Reply-To: <1508391450.5497.177.camel@coelho.fi>
References: <20171013103157.26545-1-johannes@sipsolutions.net>
         <1508391450.5497.177.camel@coelho.fi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 2017-10-19 at 08:37 +0300, Luca Coelho wrote:
> 
> Should backports then depend on CRYPTO_CCM? It didn't really work in
> the past and I got a few reports of broken backport with old kernels
> due to missing CRYPTO_CCM in the kernel config.

this change will automatically make mac80211 depend on it, after re-
generation.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
