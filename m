Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:47629 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752535Ab3FMUJQ (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 13 Jun 2013 16:09:16 -0400
Message-ID: <1371154140.8335.15.camel@jlt4.sipsolutions.net> (sfid-20130613_220918_301884_4BB9819C)
Subject: Re: [PATCH] compat-drivers: do not disable bcma when selecting
 brcmsmac
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend@broadcom.com>
Cc: "Luis R. Rodriguez" <mcgrof@frijolero.org>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Thu, 13 Jun 2013 22:09:00 +0200
In-Reply-To: <51BA25FD.4000704@broadcom.com> (sfid-20130613_220531_488325_5FC5ABD7)
References: <1370806659-2875-1-git-send-email-arend@broadcom.com>
	 <CAB=NE6WOs9+rVAAu0g_19BeXWnJsT2SRNZ6FdTZxAvT7JU5eEw@mail.gmail.com>
	 <51BA24D8.4090805@broadcom.com> <51BA25FD.4000704@broadcom.com>
	 (sfid-20130613_220531_488325_5FC5ABD7)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


> > There are a couple of repositories: backports, compat-drivers, and
> > compat. I followed the backports twiki and it does not mention the
> > backports one or did I overlook?
> 
> Yikes. cloned that one and I guess you made a major overhaul, right? Any 
> pointers, step-by-step instructions, or how-to article to get me started.

I made most of the overhaul :-)

./gentree.py /path/to/linux-next/ /tmp/my-output/

johannes

