Return-path: <backports-owner@vger.kernel.org>
Received: from mms3.broadcom.com ([216.31.210.19]:4533 "EHLO mms3.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756489Ab3FMUe2 (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 13 Jun 2013 16:34:28 -0400
Message-ID: <51BA2CC7.7090701@broadcom.com> (sfid-20130613_223430_732413_D56D1AEB)
Date: Thu, 13 Jun 2013 22:34:15 +0200
From: "Arend van Spriel" <arend@broadcom.com>
MIME-Version: 1.0
To: "Johannes Berg" <johannes@sipsolutions.net>
cc: "Luis R. Rodriguez" <mcgrof@frijolero.org>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: [PATCH] compat-drivers: do not disable bcma when selecting
 brcmsmac
References: <1370806659-2875-1-git-send-email-arend@broadcom.com>
 <CAB=NE6WOs9+rVAAu0g_19BeXWnJsT2SRNZ6FdTZxAvT7JU5eEw@mail.gmail.com>
 <51BA24D8.4090805@broadcom.com> <51BA25FD.4000704@broadcom.com> (
 sfid-20130613_220531_488325_5FC5ABD7)
 <1371154140.8335.15.camel@jlt4.sipsolutions.net>
In-Reply-To: <1371154140.8335.15.camel@jlt4.sipsolutions.net>
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 06/13/2013 10:09 PM, Johannes Berg wrote:
>
>>> There are a couple of repositories: backports, compat-drivers, and
>>> compat. I followed the backports twiki and it does not mention the
>>> backports one or did I overlook?
>>
>> Yikes. cloned that one and I guess you made a major overhaul, right? Any
>> pointers, step-by-step instructions, or how-to article to get me started.
>
> I made most of the overhaul :-)
>
> ./gentree.py /path/to/linux-next/ /tmp/my-output/

Got it. Like the use of menuconfig. Just might come up with a defconfig 
for the brcm80211 drivers.

Gr. AvS

