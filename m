Return-path: <backports-owner@vger.kernel.org>
Received: from app1b.xlhost.de ([84.200.252.162]:44187 "EHLO app1b.xlhost.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750785AbaDHHjY (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 8 Apr 2014 03:39:24 -0400
Message-ID: <5343A7A8.6010508@kpanic.de> (sfid-20140408_093926_751176_C657A033)
Date: Tue, 08 Apr 2014 09:39:20 +0200
From: Stefan Assmann <sassmann@kpanic.de>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
CC: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: ckmake build issue with undefined symbol mcount
References: <5342AED7.5080505@kpanic.de> <CAB=NE6WdU4fLKz9eMbVFqiD-r4YE2Hz8fo2cH9A18R7ap=hvDA@mail.gmail.com>
In-Reply-To: <CAB=NE6WdU4fLKz9eMbVFqiD-r4YE2Hz8fo2cH9A18R7ap=hvDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 08.04.2014 02:37, Luis R. Rodriguez wrote:
> On Mon, Apr 7, 2014 at 6:57 AM, Stefan Assmann <sassmann@kpanic.de> wrote:
>> next-20140221
> 
> Did you git reset --hard backports-20140221 ? The respective dated tag
> for backports must be used for a specific dated tag for linux-next.
> Likewise for the stable releases.
> 
>   Luis
> 

My backports tree is at 8e946501aef6e3dd5bac12eb45d24df8248672b0 which
should be the same as backports-20140221.

  Stefan
