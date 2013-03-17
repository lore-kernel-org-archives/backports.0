Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:39787 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756254Ab3CQS6A (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 17 Mar 2013 14:58:00 -0400
Received: by mail-wi0-f178.google.com with SMTP id hq4so1894903wib.11
        for <backports@vger.kernel.org>; Sun, 17 Mar 2013 11:57:59 -0700 (PDT)
Date: Sun, 17 Mar 2013 19:57:54 +0100
From: =?utf-8?B?Q2FtYWxlw7Nu?= <noelamac@gmail.com>
To: Ozan =?utf-8?B?w4dhxJ9sYXlhbg==?= <ozancag@gmail.com>
Cc: backports@vger.kernel.org
Subject: Re: Debian Wheezy: intel driver conflicts with compat-drivers
Message-ID: <20130317185754.GA5972@stt008.linux.site>
References: <20130317175321.GA5732@stt008.linux.site> <CAFub=KSz7Qmm0VRNzdSvS1zGPvRZtRV8_gN7H0QM7VQpM2XX4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAFub=KSz7Qmm0VRNzdSvS1zGPvRZtRV8_gN7H0QM7VQpM2XX4Q@mail.gmail.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

El 2013-03-17 a las 20:07 +0200, Ozan Çağlayan escribió:

> > ***
> > compat: exports duplicate symbol i2c_bit_algo (owned by i2c_algo_bit)
> > ***
> 
> Hi,
> 
> I'm not quite sure how Luis, Hauke tend to fix this but I think
> i2c_bit_algo should have been backported and renamed to sth different.
> Am I right?

I don't know, but tried with the latests compat-drivers¹ and still get 
the above error in dmesg when loading the drivers.

¹https://www.kernel.org/pub/linux/kernel/projects/backports/2013/03/15/compat-drivers-2013-03-15-u.tar.bz2

Greetings,

-- 
Camaleón 
