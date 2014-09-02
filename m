Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:43654 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754183AbaIBVtB (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 2 Sep 2014 17:49:01 -0400
Message-ID: <54063B49.2030700@hauke-m.de> (sfid-20140902_234902_906557_FE567DE3)
Date: Tue, 02 Sep 2014 23:48:57 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: tony <tony.makkiel@convergeddevices.net>, backports@vger.kernel.org
Subject: Re: Compiling error
References: <5405F05E.2090909@convergeddevices.net> <5405F832.8080406@convergeddevices.net>
In-Reply-To: <5405F832.8080406@convergeddevices.net>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 09/02/2014 07:02 PM, tony wrote:
> Hi,
>     I am trying to build "backports-3.12.8-1" for my kernel 3.1.10. I am
> following the instructions in the backports wiki to cross compile for
> arm. But the compilation fails complaining "‘THIS_MODULE’ undeclared".
> As suggested by one of the earlier posts in the forum, I tried including
> #include <linux/module.h>
> before
> #include <linux/skbuff.h>
>  But it did not make any difference.Attached is a error log.
> 
> Thank you in advance for any help.

This looks strange. You have to compile your kernel with CONFIG_MODULES
activated, backports needs that.

compat/main.c includes linux/module.h and that file contains
EXPORT_SYMBOL_GPL(), but that is not found in your build.

Why are you using version 3.12, the current stable version is 3.16?

Hauke
