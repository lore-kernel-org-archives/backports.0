Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:54764 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755264AbbBOURz (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 15 Feb 2015 15:17:55 -0500
Message-ID: <54E0FEEF.9070502@hauke-m.de> (sfid-20150215_211759_244274_28F14B0F)
Date: Sun, 15 Feb 2015 21:17:51 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>, backports@vger.kernel.org
Subject: Re: What distribution supports recent-enough spatch for backports
 project?
References: <54DE9680.5090900@candelatech.com>
In-Reply-To: <54DE9680.5090900@candelatech.com>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 02/14/2015 01:27 AM, Ben Greear wrote:
> It seems Fedora-21 has packages that are tool old, and I had very poor
> luck trying to build coccinelle, ocaml and all the other dependencies
> from source.
> 
> So, if there is a distribution that just works, please let me know.
> 
> My goal is to generate backports builds based on my own modified
> 3.17 and 3.19 kernels.
> 
> Thanks,
> Ben
> 
Hi Ben,

I am using Ubuntu 14.04 and it ships with coccinelle 1.0.0~rc21, Debian
testing also has a recent enough version and here [0] it says that
Fedora 22 will have a recent enough version. Isn't it possible to
install a library from a more recent fedora version on your fedora 21?

I do not know what features from 1.0.0~rc21 are used have you tried to
remove the check for that version any try it with version 1.0.0-rc20
which is in fedora 21?


Hauke

[0]: https://apps.fedoraproject.org/packages/coccinelle
