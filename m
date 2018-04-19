Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:46434 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750708AbeDSHdU (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 19 Apr 2018 03:33:20 -0400
Message-ID: <1524123197.3024.13.camel@sipsolutions.net> (sfid-20180419_093321_953447_0A528785)
Subject: Re: [PATCH] backports: rename *-asn1.[ch] to *.asn1.[ch]
From: Johannes Berg <johannes@sipsolutions.net>
To: Winnie Chang <winnie.chang@cypress.com>, backports@vger.kernel.org
Cc: chln@cypress.com
Date: Thu, 19 Apr 2018 09:33:17 +0200
In-Reply-To: <20180419061146.GA22072@aremote01.aus.cypress.com> (sfid-20180419_081221_410832_BEBBCF66)
References: <20180419061146.GA22072@aremote01.aus.cypress.com>
         (sfid-20180419_081221_410832_BEBBCF66)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 2018-04-19 at 01:11 -0500, Winnie Chang wrote:
> linux-stable 4fa8bc949de11c99ee2433c602d43f87c452f4f2 renamed
> *-asn1.[ch] files to *.asn1.[ch]. Make the corresponding change
> for backports.

Does it matter? I mean, I don't really mind the patch, but I also see
little reason for it?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
