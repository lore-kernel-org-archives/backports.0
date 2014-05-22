Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:43362 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751187AbaEVGii (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 22 May 2014 02:38:38 -0400
Message-ID: <1400740701.4174.2.camel@jlt4.sipsolutions.net> (sfid-20140522_083839_921506_4BBE0ACD)
Subject: Re: Building Backports Without the Kernel Config
From: Johannes Berg <johannes@sipsolutions.net>
To: Daniel Schultze <kinglag@gmail.com>
Cc: backports@vger.kernel.org
Date: Thu, 22 May 2014 08:38:21 +0200
In-Reply-To: <CAEsx0Y9sRSEvnx533s+1HjD7MQtVJVxAnn7wyHfw7zQoNgdfCw@mail.gmail.com> (sfid-20140522_081835_166336_273366FA)
References: <CAEsx0Y9sRSEvnx533s+1HjD7MQtVJVxAnn7wyHfw7zQoNgdfCw@mail.gmail.com>
	 (sfid-20140522_081835_166336_273366FA)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2014-05-21 at 23:18 -0700, Daniel Schultze wrote:
> I need a driver that is available in backports but I do not have the
> original kernel's source or config. I do have a vanilla kernel of the
> same version and can approximate the config to some degree.
> 
> Given these conditions can I have a reasonable stable module for a
> production system?

No. This might work but it doesn't seem likely to be very reliable. If
you have module versioning enabled then it will probably not even load.

johannes

