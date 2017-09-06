Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:54330 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932704AbdIFPFQ (ORCPT <rfc822;backports@vger.kernel.org>);
        Wed, 6 Sep 2017 11:05:16 -0400
Message-ID: <1504710312.23905.13.camel@sipsolutions.net> (sfid-20170906_170613_462584_00A73597)
Subject: Re: [PATCH 16/21] patches: brcmfmac: fix netdev destructor
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org
Date: Wed, 06 Sep 2017 17:05:12 +0200
In-Reply-To: <20170821222817.17376-17-hauke@hauke-m.de> (sfid-20170822_002850_383975_3743917C)
References: <20170821222817.17376-1-hauke@hauke-m.de>
         <20170821222817.17376-17-hauke@hauke-m.de>
         (sfid-20170822_002850_383975_3743917C)
Content-Type: text/plain
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Arend, can you review this?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
