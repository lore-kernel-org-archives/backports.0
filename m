Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:32919 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755202Ab3FCAAf (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 2 Jun 2013 20:00:35 -0400
Received: by mail-pd0-f172.google.com with SMTP id t10so1293076pdi.3
        for <backports@vger.kernel.org>; Sun, 02 Jun 2013 17:00:35 -0700 (PDT)
Date: Mon, 3 Jun 2013 07:00:14 +0700
From: "Anh K. Huynh" <kyanh@viettug.org>
To: Thomas Pedersen <thomas@cozybit.com>, backports@vger.kernel.org
Subject: Re: [PATCH] backports: specify python2.7 for gentree.py
Message-ID: <20130603070014.57b6119c@icy> (sfid-20130603_020037_730435_01737C3A)
In-Reply-To: <1370214733-29993-1-git-send-email-thomas@cozybit.com>
References: <1370214733-29993-1-git-send-email-thomas@cozybit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,

On Sun,  2 Jun 2013 16:12:13 -0700
Thomas Pedersen <thomas@cozybit.com> wrote:

> Apparently gentree.py uses some python2.7 specific syntax. Fixes:
> 
> ./gentree.py -h
>   File "./gentree.py", line 72
>     except OSError, e:
>                   ^
> SyntaxError: invalid syntax
> 
> On distros where /usr/bin/python points to python3.

FYI, on ArchLinux, `/usr/bin/python` is 3.0, and the old Python
(installed by the package `python2`) uses `/usr/bin/python2`.

--
I am ... 5 dog years old.
