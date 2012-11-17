Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:45504 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751477Ab2KQNvq (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 17 Nov 2012 08:51:46 -0500
Message-ID: <50A79668.2060901@hauke-m.de>
Date: Sat, 17 Nov 2012 14:51:36 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: shuox.liu@gmail.com
CC: backports@vger.kernel.org
Subject: Re: Build compat-wireless for linus tree
References: <50A675EE.9010406@gmail.com>
In-Reply-To: <50A675EE.9010406@gmail.com>
Content-Type: text/plain; charset=GB2312
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 11/16/2012 06:20 PM, Shuo wrote:
> Hi list,
> How could i get the latest compat-wireless code and compile against
> an new kernel which pull from linus' tree?
> I am using v3.7-rc4. It seems there is no ready compat-wireless code
> for it. Is there any repo for this?
> 
> Any comment would be appreciated!
> 
> Shuo

Hi Shuo,

compat-drivers compiles for me against kernel 3.7-rc6 without any
problems. Try out the latest version:
http://www.orbit-lab.org/kernel/compat-wireless/

Hauke
