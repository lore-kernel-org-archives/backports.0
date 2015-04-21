Return-path: <backports-owner@vger.kernel.org>
Received: from app1b.xlhost.de ([84.200.252.162]:47120 "EHLO app1b.xlhost.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750937AbbDUGlm (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 21 Apr 2015 02:41:42 -0400
Message-ID: <5535EEFE.5080904@kpanic.de> (sfid-20150421_084145_219201_CA1E65EB)
Date: Tue, 21 Apr 2015 08:32:30 +0200
From: Stefan Assmann <sassmann@kpanic.de>
MIME-Version: 1.0
To: Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Subject: Re: struct timespec64 in igb
References: <55357066.1080405@hauke-m.de>
In-Reply-To: <55357066.1080405@hauke-m.de>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 20.04.2015 23:32, Hauke Mehrtens wrote:
> Hi Stefan,
> 
> igb makes use of "struct timespec64" now, which was added with kernel
> 3.17. are you able to create a nice coccinelle patch for this?
> 
> The commit in question is this:
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=d4c496fe45de9dc33ace3a5796e4211e2e809231
> 
> Hauke
> 

I'll look into it.

  Stefan
