Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:46902 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753575AbaJ3IrV (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 30 Oct 2014 04:47:21 -0400
Received: by mail-wi0-f177.google.com with SMTP id ex7so6691498wid.4
        for <backports@vger.kernel.org>; Thu, 30 Oct 2014 01:47:20 -0700 (PDT)
Message-ID: <5451FB15.80404@trego.co.il> (sfid-20141030_094724_685295_5B25874D)
Date: Thu, 30 Oct 2014 10:47:17 +0200
From: Eyal Ben-Sasson <eyal@trego.co.il>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
CC: backports@vger.kernel.org
Subject: Re: build backports-20140905 against 2.6.39 kernel failure
References: <5451179D.6020009@trego.co.il>	 (sfid-20141029_173700_652943_FC9D8B2D) <1414604671.1827.30.camel@jlt4.sipsolutions.net>
In-Reply-To: <1414604671.1827.30.camel@jlt4.sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

OK. Now I see it. I will go back to backports-3.14 and try it.
Thanx.

Eyal


On 10/29/2014 07:44 PM, Johannes Berg wrote:
> On Wed, 2014-10-29 at 18:36 +0200, Eyal Ben-Sasson wrote:
>
>> I understand the backports is tested against 2.6.39 successfully. Where
>> can I see the 2.6.39 .config file?
> This is no longer the case, the oldest supported kernel is now 3.0.
>
> johannes
>
>

