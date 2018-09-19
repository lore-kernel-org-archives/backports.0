Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.62]:51286 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbeISPDC (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 19 Sep 2018 11:03:02 -0400
Message-ID: <1537349150.10305.26.camel@sipsolutions.net> (sfid-20180919_112602_754757_D6E4258E)
Subject: Re: [PATCH 1/7] backports: Remove unused parts
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org, john@phrozen.org
Date: Wed, 19 Sep 2018 11:25:50 +0200
In-Reply-To: <20180917213142.7875-1-hauke@hauke-m.de> (sfid-20180917_233159_610644_0F2A0550)
References: <20180917213142.7875-1-hauke@hauke-m.de>
         (sfid-20180917_233159_610644_0F2A0550)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

I've applied all of this, and changed the netdev destructor patch to
<+... ...+>

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
