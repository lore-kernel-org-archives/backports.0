Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:51877 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756324Ab3CQSHM convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 17 Mar 2013 14:07:12 -0400
Received: by mail-we0-f182.google.com with SMTP id t57so4271486wey.41
        for <backports@vger.kernel.org>; Sun, 17 Mar 2013 11:07:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130317175321.GA5732@stt008.linux.site>
References: <20130317175321.GA5732@stt008.linux.site>
Date: Sun, 17 Mar 2013 20:07:10 +0200
Message-ID: <CAFub=KSz7Qmm0VRNzdSvS1zGPvRZtRV8_gN7H0QM7VQpM2XX4Q@mail.gmail.com>
Subject: Re: Debian Wheezy: intel driver conflicts with compat-drivers
From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>
To: =?UTF-8?B?Q2FtYWxlw7Nu?= <noelamac@gmail.com>
Cc: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

>
> ***
> compat: exports duplicate symbol i2c_bit_algo (owned by i2c_algo_bit)
> ***

Hi,

I'm not quite sure how Luis, Hauke tend to fix this but I think
i2c_bit_algo should have been backported and renamed to sth different.
Am I right?



--
Ozan Çağlayan
Research Assistant
Galatasaray University - Computer Engineering Dept.
http://www.ozancaglayan.com
