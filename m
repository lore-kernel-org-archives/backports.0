Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ea0-f173.google.com ([209.85.215.173]:45073 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834Ab3GaXQZ (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 31 Jul 2013 19:16:25 -0400
Received: by mail-ea0-f173.google.com with SMTP id g10so644638eak.32
        for <backports@vger.kernel.org>; Wed, 31 Jul 2013 16:16:23 -0700 (PDT)
Received: from [192.168.1.81] (ip503cba31.speed.planet.nl. [80.60.186.49])
        by mx.google.com with ESMTPSA id n42sm29638eeh.15.2013.07.31.16.16.22
        for <backports@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 31 Jul 2013 16:16:23 -0700 (PDT)
Message-ID: <51F99AC6.8080909@gmail.com> (sfid-20130801_011628_506952_B1405F41)
Date: Thu, 01 Aug 2013 01:16:22 +0200
From: Leon Woestenberg <sidebranch.linux@gmail.com>
MIME-Version: 1.0
To: backports@vger.kernel.org
Subject: What if kernel CONFIG=Y or CONFIG=N and backports CONFIG=M?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hello all,

two questions (I am new to the backports project):

If I configure backports to build a driver as a module, whilst the 
kernel we build against (KLIB/KLIB_BUILD) has this driver built-in, what 
is supposed to happen?

Obviously I cannot load the backport module into the kernel.


Is it possible (within the kernel and backports code) to build a 
subsystem or driver as a module, if the original kernel did not have 
this subsystem or driver built at all ("N" in the menu, CONFIG_ 
commented out in .config)?

Can the kernel always load modules that were defined as =N during the 
kernel built itself?

(My aim is Yocto/OpenEmbedded support for backports into the build system.)

Thanks,

Leon.
