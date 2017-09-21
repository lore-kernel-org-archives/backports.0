Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:45324 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751617AbdIUNXd (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 21 Sep 2017 09:23:33 -0400
Message-ID: <1506000210.2048.2.camel@sipsolutions.net> (sfid-20170921_152336_612637_76025155)
Subject: Re: [PATCH 0/4] backports: make compatible with kernel 4.14-rc
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org
Date: Thu, 21 Sep 2017 15:23:30 +0200
In-Reply-To: <20170917165813.17580-1-hauke@hauke-m.de> (sfid-20170917_185834_631711_EC2A368E)
References: <20170917165813.17580-1-hauke@hauke-m.de>
         (sfid-20170917_185834_631711_EC2A368E)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, 2017-09-17 at 18:58 +0200, Hauke Mehrtens wrote:
> This makes it possible to base backports on top of Linux 4.14-rc1.

All applied, thanks.

> I got these compile results:
> 
> 1   3.0.101             [  FAIL  ]
> 2   3.1.10              [  FAIL  ]
> 3   3.2.92              [  FAIL  ]
> 4   3.3.8               [  FAIL  ]
> 5   3.4.110             [  LINK  ]
> 6   3.5.7               [  LINK  ]
> 7   3.6.11              [  LINK  ]
> 8   3.7.10              [  LINK  ]
> 9   3.8.13              [  LINK  ]
> 10  3.9.11              [  LINK  ]
> 11  3.10.107            [  FAIL  ]
> 12  3.11.10             [  FAIL  ]
> 13  3.12.74             [  FAIL  ]

All of those really seem to have mostly tracing issues :(

johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
