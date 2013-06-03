Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:34668 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824Ab3FCDg1 (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 2 Jun 2013 23:36:27 -0400
Received: by mail-pd0-f176.google.com with SMTP id r11so4970523pdi.7
        for <backports@vger.kernel.org>; Sun, 02 Jun 2013 20:36:27 -0700 (PDT)
Date: Mon, 3 Jun 2013 10:36:05 +0700
From: "Anh K. Huynh" <kyanh@viettug.org>
To: Thomas Pedersen <thomas@cozybit.com>
Cc: backports@vger.kernel.org
Subject: Re: [PATCH] backports: specify python2.7 for gentree.py
Message-ID: <20130603103605.56ff3813@icy> (sfid-20130603_053629_702635_AD4EB738)
In-Reply-To: <CAG6hwVNs0w5we5fkg4j742Oq0uVkhEE4j5Uppcigbs=b3gE_mw@mail.gmail.com>
References: <1370214733-29993-1-git-send-email-thomas@cozybit.com>
	<20130603070014.57b6119c@icy>
	<CAG6hwVNs0w5we5fkg4j742Oq0uVkhEE4j5Uppcigbs=b3gE_mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, 2 Jun 2013 20:16:48 -0700
Thomas Pedersen <thomas@cozybit.com> wrote:

> > FYI, on ArchLinux, `/usr/bin/python` is 3.0, and the old Python
> > (installed by the package `python2`) uses `/usr/bin/python2`.
> 
> python2.7 is also provided by the python2 package. Do you think asking
> for python2 is a more portable solution?

Yes on ArchLinux `/usr/bin/python2` is a symbolic link of `/usr/bin/python2.7`.

Unless the script `gentree.py` requires `python2.7` strictly I think that
using `python2` is more portable. CentOS is still using `python2.6` [1]. 

[1] http://mirror.centos.org/centos/6.4/os/x86_64/Packages/python-2.6.6-36.el6.i686.rpm

--
I am ... 5 dog years old.
