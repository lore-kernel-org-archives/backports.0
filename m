Return-path: <backports-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:35902 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932410AbbDQQOJ (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 17 Apr 2015 12:14:09 -0400
Received: by oift201 with SMTP id t201so80883137oif.3
        for <backports@vger.kernel.org>; Fri, 17 Apr 2015 09:14:08 -0700 (PDT)
Message-ID: <5531314D.1000706@lwfinger.net> (sfid-20150417_181411_559997_6D84A8C0)
Date: Fri, 17 Apr 2015 11:14:05 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
MIME-Version: 1.0
To: Petr Vorel <petr.vorel@gmail.com>, backports@vger.kernel.org
Subject: Re: Possible to build-in backports modules into kernel
References: <20150417133004.GC16380@vorel-pc>
In-Reply-To: <20150417133004.GC16380@vorel-pc>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 04/17/2015 08:30 AM, Petr Vorel wrote:
> Hi there,
>
> is it possible to build-in to backports modules into kernel (link them into kernel, not
> build them as separate modules).

It is possible to build most drivers into the kernel, but it must be done when 
the kernel is compiled and linked. Once the kernel is built, you can only build 
new drivers as modules.

The short answer is no for the backports code. If you want them built-in, grab 
the mainline 4.0 or 3.19.4 source, configure, and build a complete new kernel.

Larry


