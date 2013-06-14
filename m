Return-path: <backports-owner@vger.kernel.org>
Received: from mms3.broadcom.com ([216.31.210.19]:3634 "EHLO mms3.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750796Ab3FNIAY (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 14 Jun 2013 04:00:24 -0400
Message-ID: <51BACD8D.8050801@broadcom.com> (sfid-20130614_100027_630471_8A01633E)
Date: Fri, 14 Jun 2013 10:00:13 +0200
From: "Arend van Spriel" <arend@broadcom.com>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@frijolero.org>
cc: "Johannes Berg" <johannes@sipsolutions.net>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: [PATCH] compat-drivers: do not disable bcma when selecting
 brcmsmac
References: <1370806659-2875-1-git-send-email-arend@broadcom.com>
 <CAB=NE6WOs9+rVAAu0g_19BeXWnJsT2SRNZ6FdTZxAvT7JU5eEw@mail.gmail.com>
 <51BA24D8.4090805@broadcom.com> <51BA25FD.4000704@broadcom.com>
 <1371154140.8335.15.camel@jlt4.sipsolutions.net>
 <51BA2CC7.7090701@broadcom.com>
 <CAB=NE6XnYCHrNDoQGB8S+pZWqw-7qA3xyyY7yyQxcUy3GbjPUA@mail.gmail.com>
In-Reply-To: <CAB=NE6XnYCHrNDoQGB8S+pZWqw-7qA3xyyY7yyQxcUy3GbjPUA@mail.gmail.com>
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 06/13/2013 10:47 PM, Luis R. Rodriguez wrote:
> On Thu, Jun 13, 2013 at 1:34 PM, Arend van Spriel <arend@broadcom.com> wrote:
>>
>> Got it. Like the use of menuconfig. Just might come up with a defconfig for
>> the brcm80211 drivers.
>
> Its already there, the same upstream Kconfig files are used.

You are right. I was looking at the linux-3.10.y branch. Thanks.

Gr. AvS


