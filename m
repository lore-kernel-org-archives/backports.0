Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:53414 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783Ab3G2SFW (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 29 Jul 2013 14:05:22 -0400
Received: by mail-ee0-f41.google.com with SMTP id d17so2620087eek.28
        for <backports@vger.kernel.org>; Mon, 29 Jul 2013 11:05:20 -0700 (PDT)
Received: from [192.168.1.81] (ip503cba31.speed.planet.nl. [80.60.186.49])
        by mx.google.com with ESMTPSA id i2sm103749797eeu.4.2013.07.29.11.05.19
        for <backports@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 29 Jul 2013 11:05:20 -0700 (PDT)
Message-ID: <51F6AEE2.2050207@gmail.com> (sfid-20130729_200524_753501_0F5F2BF4)
Date: Mon, 29 Jul 2013 20:05:22 +0200
From: Leon Woestenberg <sidebranch.linux@gmail.com>
MIME-Version: 1.0
To: backports@vger.kernel.org
Subject: backports in a cross-compilation environment
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hello,

I would like to use the backports release against 2.6.37, but in a 
cross-compilation environment. I.e. the kernel is not meant for my host 
system.

More specific, I'm interested in integrating backports-3.x into 
Yocto/OpenEmbedded.

I have ARCH and CROSS_COMPILE defined, what other environment variables 
should I set for the backports configuration to pick up the right kernel 
sources?

 From looking at the Makefile I need to override KLIB_BUILD.

However I could use a high-level description of where/what gets built

Best regards,

Leon.
