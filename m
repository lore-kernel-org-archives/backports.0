Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:41560 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753098AbdBNJrV (ORCPT <rfc822;backports@vger.kernel.org>);
        Tue, 14 Feb 2017 04:47:21 -0500
Message-ID: <1487065638.4705.9.camel@sipsolutions.net> (sfid-20170214_105058_219451_057D75EF)
Subject: Re: [PATCH] backports: add "MBIM Extended Functional Descriptor"
 structure definition
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: backports@vger.kernel.org
Date: Tue, 14 Feb 2017 10:47:18 +0100
In-Reply-To: <1486854899-13118-1-git-send-email-arend.vanspriel@broadcom.com> (sfid-20170212_001555_428221_3909FA4D)
References: <1486854899-13118-1-git-send-email-arend.vanspriel@broadcom.com>
         (sfid-20170212_001555_428221_3909FA4D)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sat, 2017-02-11 at 23:14 +0000, Arend van Spriel wrote:
> commit 477c6d345604 ("backports: add USB_CDC_MBIM_EXTENDED_TYPE if
> needed")
> added define but the structure definition that goes with it is also
> needed.
> As they were introduced in the same kernel version we can add the
> structure
> with the same #ifndef USB_CDC_MBIM_EXTENDED_TYPE.
> 
applied.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
