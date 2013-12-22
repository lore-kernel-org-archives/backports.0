Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:14096 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab3LVKmR (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 22 Dec 2013 05:42:17 -0500
Message-ID: <52B6C206.30502@broadcom.com> (sfid-20131222_114220_255601_C37B9DA4)
Date: Sun, 22 Dec 2013 11:42:14 +0100
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
CC: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	<backports@vger.kernel.org>
Subject: Re: [PATCH] network: mac80211: rework multicast patches for mac80211
References: <1387706902-12322-1-git-send-email-arend@broadcom.com>	 (sfid-20131222_110836_368323_821C7D89) <1387708422.4346.0.camel@jlt4.sipsolutions.net>
In-Reply-To: <1387708422.4346.0.camel@jlt4.sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 12/22/2013 11:33 AM, Johannes Berg wrote:
> On Sun, 2013-12-22 at 11:08 +0100, Arend van Spriel wrote:
>> Fixing up the patches for mac80211 that were located under
>> collateral-evolutions/network/25-multicast-list_head.
> 
> I had an almost identical patch, sorry for not sending that out.
> 
> 
>> --- a/gen-brcm-backport.sh
>> +++ b/gen-brcm-backport.sh
>> @@ -34,7 +34,6 @@ function get_sha1ref() {
>>  }
>>  
>>  parse_cmdline $*
>> -echo ${GITTREE}
>>  SHA1REF=$(get_sha1ref)
>>  BACKPORT_RELEASE=brcm-backports${REPOTAG}-g$(get_sha1ref)
>>  TMPDIR=/tmp/${BACKPORT_RELEASE}
> 
> ?

Yikes. That is a script in my local tree for creating a tarball
internally. So either a V2 or your patch.

Gr. AvS

