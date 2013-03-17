Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:37079 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855Ab3CQJkc (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 17 Mar 2013 05:40:32 -0400
Received: by mail-wi0-f181.google.com with SMTP id hm6so1677002wib.2
        for <backports@vger.kernel.org>; Sun, 17 Mar 2013 02:40:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130317085202.GB3547@stt008.linux.site>
References: <20130317085202.GB3547@stt008.linux.site>
Date: Sun, 17 Mar 2013 11:40:30 +0200
Message-ID: <CAFub=KRQgdhMBxda2QHK-x6CYCb_WUVq2o6pgpDKMtfZj8MtiQ@mail.gmail.com>
Subject: Re: Unable to compile "compat-drivers" in Debian Wheezy
From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>
To: =?UTF-8?B?Q2FtYWxlw7Nu?= <noelamac@gmail.com>
Cc: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,

This is caused because Debian already defined those
structures/functions/etc in their vendor kernel using 2 patches:
- features/all/ethernet-define-eth_hw_addr_random.patch
- features/all/drm/slab-introduce-kmalloc_array.patch

This kind of problems occur from time to time with other distributions
too. I don't know if in the code level there is a dynamic way to
detect whether those symbols are already defined or not but for now
you can edit compat-3.4.h in the compat-drivers folder and comment out
the lines defining kmalloc_array and eth_hw_addr_random.
