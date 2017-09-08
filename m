Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:60776 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750850AbdIHJ2J (ORCPT <rfc822;backports@vger.kernel.org>);
        Fri, 8 Sep 2017 05:28:09 -0400
Message-ID: <1504862887.6177.19.camel@sipsolutions.net> (sfid-20170908_112810_667580_DB38371E)
Subject: Re: [PATCH 08/21] header: backport devm_acpi_dev_add_driver_gpios()
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org
Date: Fri, 08 Sep 2017 11:28:07 +0200
In-Reply-To: <1504862738.6177.18.camel@sipsolutions.net> (sfid-20170908_112541_179205_041F014E)
References: <20170821222817.17376-1-hauke@hauke-m.de>
         <20170821222817.17376-9-hauke@hauke-m.de>
         <1504710103.23905.12.camel@sipsolutions.net>
         <c5f48794-8d4c-b4e2-bfac-7d5473490756@hauke-m.de>
         <1504862738.6177.18.camel@sipsolutions.net>
         (sfid-20170908_112541_179205_041F014E)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2017-09-08 at 11:25 +0200, Johannes Berg wrote:
> 
> Right. I'll fix this and apply then.

Heh, turns out I accidentally applied it already anyway - so I just
fixed the version thing then.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
