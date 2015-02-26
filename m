Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:57046 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932194AbbBZNNo (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 26 Feb 2015 08:13:44 -0500
Message-ID: <54EF1C05.2000901@broadcom.com> (sfid-20150226_141347_089387_4D1D062C)
Date: Thu, 26 Feb 2015 14:13:41 +0100
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
CC: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	<backports@vger.kernel.org>
Subject: Re: [PATCH] backports: allow building backports package on 4.0+ kernel
References: <1424954998-31984-1-git-send-email-arend@broadcom.com>	 (sfid-20150226_135011_981321_0099BE5A) <1424955956.1885.23.camel@sipsolutions.net>
In-Reply-To: <1424955956.1885.23.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 02/26/15 14:05, Johannes Berg wrote:
> On Thu, 2015-02-26 at 13:49 +0100, Arend van Spriel wrote:
>> When attempting to build backport package the error message
>> "Kernel version parse failed" popped up. Realizing the machine
>> was already running a 4.0-rc1 kernel, this patch fixes the
>> issue. At least until kernel 9.x it will.
>
> Is this really enough? we also generate those kernel version Kconfig
> symbols for dependencies - I htink that needs to be adjusted as well.

Will double-check the results. Building it worked without issues, but it 
could be due to the fact that backport and target kernel versions are 
the same. You made me a bit wary to actually load the modules, but I 
will do it anyway ;-)

Arend

> johannes
>

