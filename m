Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.62]:49484 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbeHVLCY (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 22 Aug 2018 07:02:24 -0400
Message-ID: <1534922281.25523.57.camel@sipsolutions.net> (sfid-20180822_093902_267050_85B2BFD5)
Subject: Re: [PATCH v2] backports: add header file for function memcmp
From: Johannes Berg <johannes@sipsolutions.net>
To: Winnie Chang <winnie.chang@cypress.com>, backports@vger.kernel.org
Cc: Chi-Hsien.Lin@cypress.com
Date: Wed, 22 Aug 2018 09:18:01 +0200
In-Reply-To: <20180822030554.GA73398@aremote01.aus.cypress.com> (sfid-20180822_050625_036935_A42BDE44)
References: <20180822030554.GA73398@aremote01.aus.cypress.com>
         (sfid-20180822_050625_036935_A42BDE44)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2018-08-21 at 22:06 -0500, Winnie Chang wrote:
> Function memcmp is implicit declaration on kernel 4.9.88 ARM platform.
> backport-include/keys/asymmetric-type.h uses function memcmp but its
> caller compat/verification/verify.c and all its related header files
> do not include string.h. The header file is usually included from
> arch/arm/include/asm, but in this configuration, it doesn't. We need
> to be safe and insure string.h is there.

Makes sense, thanks!

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
