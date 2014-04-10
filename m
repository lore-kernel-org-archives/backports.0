Return-path: <backports-owner@vger.kernel.org>
Received: from app1b.xlhost.de ([84.200.252.162]:53980 "EHLO app1b.xlhost.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750849AbaDJHf4 (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 10 Apr 2014 03:35:56 -0400
Message-ID: <534649D8.6040208@kpanic.de> (sfid-20140410_093558_261303_1164F361)
Date: Thu, 10 Apr 2014 09:35:52 +0200
From: Stefan Assmann <sassmann@kpanic.de>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
CC: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: ckmake build issue with undefined symbol mcount
References: <5342AED7.5080505@kpanic.de> <CAB=NE6WdU4fLKz9eMbVFqiD-r4YE2Hz8fo2cH9A18R7ap=hvDA@mail.gmail.com> <5343A7A8.6010508@kpanic.de>
In-Reply-To: <5343A7A8.6010508@kpanic.de>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 08.04.2014 09:39, Stefan Assmann wrote:
> On 08.04.2014 02:37, Luis R. Rodriguez wrote:
>> On Mon, Apr 7, 2014 at 6:57 AM, Stefan Assmann <sassmann@kpanic.de> wrote:
>>> next-20140221
>>
>> Did you git reset --hard backports-20140221 ? The respective dated tag
>> for backports must be used for a specific dated tag for linux-next.
>> Likewise for the stable releases.
>>
>>   Luis
>>
> 
> My backports tree is at 8e946501aef6e3dd5bac12eb45d24df8248672b0 which
> should be the same as backports-20140221.
> 
>   Stefan
> 

I tried the same again in a newly installed VM and don't see any issues
there. Probably an issue with my build env then. Please ignore.

  Stefan
