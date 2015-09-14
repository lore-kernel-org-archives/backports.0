Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:36219 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751532AbbINTfD (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 14 Sep 2015 15:35:03 -0400
Subject: Re: [PATCH 06/10] patches: add additional include to brcmfmac
To: Arend van Spriel <arend@broadcom.com>, backports@vger.kernel.org
References: <1442216922-3318-1-git-send-email-hauke@hauke-m.de>
 <1442216922-3318-7-git-send-email-hauke@hauke-m.de>
 <55F68256.4090405@broadcom.com>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <55F72164.8030501@hauke-m.de> (sfid-20150914_213505_702818_FE41577F)
Date: Mon, 14 Sep 2015 21:35:00 +0200
MIME-Version: 1.0
In-Reply-To: <55F68256.4090405@broadcom.com>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 09/14/2015 10:16 AM, Arend van Spriel wrote:
> On 09/14/2015 09:48 AM, Hauke Mehrtens wrote:
>> brcmfmac uses atomic_or(), but does not include linux/atomic.h which
>> causes problems on kernel 3.0
> 
> Hi Hauke,
> 
> Will you also submit the actual patch upstream?
> 
> Regards,
> Arend

Yes, already planed that.

Hauke
--
To unsubscribe from this list: send the line "unsubscribe backports" in
