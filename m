Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:56903 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846Ab3FCDTN (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 2 Jun 2013 23:19:13 -0400
Received: by mail-pa0-f45.google.com with SMTP id bi5so139548pad.4
        for <backports@vger.kernel.org>; Sun, 02 Jun 2013 20:19:12 -0700 (PDT)
Date: Mon, 3 Jun 2013 10:18:51 +0700
From: "Anh K. Huynh" <kyanh@viettug.org>
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
Subject: Re: Buid backports-20130528 on ArchLinux: /usr/bin/ld: cannot find
 -ltinfo
Message-ID: <20130603101851.30e174b2@icy> (sfid-20130603_051915_277870_41119FDD)
In-Reply-To: <1370194899.8366.5.camel@jlt4.sipsolutions.net>
References: <20130602220934.3079ee4f@icy>
	<1370194899.8366.5.camel@jlt4.sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, 02 Jun 2013 19:41:39 +0200
Johannes Berg <johannes@sipsolutions.net> wrote:

> ...
> > Is the `tinfo` library really needed to run `make menuconfig` when
> > building backports drivers?
> 
> It was needed on some distros, and not on others. This is probably the
> best option?
> 
> diff --git a/backport/kconf/Makefile b/backport/kconf/Makefile
> ...

Thank you for the explanation. The patch is a very good option.

--
I am ... 5 dog years old.
