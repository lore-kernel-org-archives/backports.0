Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:47248 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750881AbeDSIFP (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 19 Apr 2018 04:05:15 -0400
Message-ID: <1524125112.3024.14.camel@sipsolutions.net> (sfid-20180419_100518_939370_A9EF8AF4)
Subject: Re: [PATCH] backports: rename *-asn1.[ch] to *.asn1.[ch]
From: Johannes Berg <johannes@sipsolutions.net>
To: chi-hsien.lin@cypress.com, Winnie Chang <winnie.chang@cypress.com>,
        backports@vger.kernel.org
Cc: chln@cypress.com
Date: Thu, 19 Apr 2018 10:05:12 +0200
In-Reply-To: <91215546-664c-4714-9a36-aaf6edc35429@cypress.com>
References: <20180419061146.GA22072@aremote01.aus.cypress.com>
         <1524123197.3024.13.camel@sipsolutions.net>
         <91215546-664c-4714-9a36-aaf6edc35429@cypress.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 2018-04-19 at 16:02 +0800, Chi-Hsien Lin wrote:
> 
> The linux-stable file rename has caused build failure. It's because 
> backports pulls kernel pkcs7_parser.c, which includes the renamed header 
> file pkcs7.asn1.h, while our corresponding copy in backports.git still 
> has the old name pkcs7-asn1.h.
> 
> Here's the copy-list line that pulls pkcs_parser.c:
> crypto/asymmetric_keys/pkcs7_parser.c -> compat/verification/pkcs7_parser.c

Ah, header files too, right.

Ok, makes sense, thanks for the explanation.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
