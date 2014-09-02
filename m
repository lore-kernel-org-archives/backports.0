Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:43637 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751633AbaIBVg6 (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 2 Sep 2014 17:36:58 -0400
Message-ID: <54063878.3010006@hauke-m.de> (sfid-20140902_233706_723255_37092C9D)
Date: Tue, 02 Sep 2014 23:36:56 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Javier Casas Marin <jcasas@wifense.com>, backports@vger.kernel.org
Subject: Re: Error compiling backports-3.16-1 on a device with a 2.6.30 kernel
References: <5405F4F1.1050808@wifense.com>
In-Reply-To: <5405F4F1.1050808@wifense.com>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 09/02/2014 06:48 PM, Javier Casas Marin wrote:
> 
> I am trying to compile backports-3.16-1 on a device with a 2.6.30 linux
> kernel and I get this error:
......
> it looks like I can't compile it for kernel 2.6.30 because some headers
> files are missing (printk.h was inside kernel.h in previous kernel
> versions like in 2.6.30). But the documentation says that kernels 2.6.27
> and older are supported, so what am I doing wrong?

Backports-3.16 does not support kernel version < 3.0 any more, you have
to use backports-3.14

Hauke
