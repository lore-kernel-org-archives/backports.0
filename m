Return-path: <backports-owner@vger.kernel.org>
Received: from [178.33.119.222] ([178.33.119.222]:32440 "EHLO mail.wifense.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754172AbaIBQ5y (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 2 Sep 2014 12:57:54 -0400
Received: from localhost (unknown [127.0.0.1])
	by mail.wifense.com (Postfix) with ESMTP id 6DB732C0857
	for <backports@vger.kernel.org>; Tue,  2 Sep 2014 16:52:25 +0000 (UTC)
Received: from mail.wifense.com ([127.0.0.1])
	by localhost (mail.wifense.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oxbSkx6gPj94 for <backports@vger.kernel.org>;
	Tue,  2 Sep 2014 18:52:12 +0200 (CEST)
Received: from [172.30.200.107] (230.red-80-28-132.adsl.static.ccgg.telefonica.net [80.28.132.230])
	(Authenticated sender: jcasas@wifense.com)
	by mail.wifense.com (Postfix) with ESMTPSA id AA4C82C084D
	for <backports@vger.kernel.org>; Tue,  2 Sep 2014 18:52:12 +0200 (CEST)
Message-ID: <5405F4F1.1050808@wifense.com> (sfid-20140902_185756_416367_1528858B)
Date: Tue, 02 Sep 2014 18:48:49 +0200
From: Javier Casas Marin <jcasas@wifense.com>
MIME-Version: 1.0
To: backports@vger.kernel.org
Subject: Error compiling backports-3.16-1 on a device with a 2.6.30 kernel
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


I am trying to compile backports-3.16-1 on a device with a 2.6.30 linux 
kernel and I get this error:
$ make
   CC [M]  /root/modules/backports-3.16-1/compat/main.o
In file included from 
/root/modules/backports-3.16-1/backport-include/linux/kernel.h:9,
                  from 
/mnt/cfdata/src/linux-2.6.30/arch/x86/include/asm/system.h:10,
                  from 
/mnt/cfdata/src/linux-2.6.30/arch/x86/include/asm/processor.h:17,
                  from include/linux/prefetch.h:14,
                  from include/linux/list.h:6,
                  from 
/root/modules/backports-3.16-1/backport-include/linux/list.h:3,
                  from include/linux/module.h:9,
                  from 
/root/modules/backports-3.16-1/backport-include/linux/module.h:3,
                  from /root/modules/backports-3.16-1/compat/main.c:1:
/root/modules/backports-3.16-1/backport-include/linux/printk.h:5:31: 
error: linux/printk.h: No such file or directory
make[6]: *** [/root/modules/backports-3.16-1/compat/main.o] Error 1
make[5]: *** [/root/modules/backports-3.16-1/compat] Error 2
make[4]: *** [_module_/root/modules/backports-3.16-1] Error 2
make[3]: *** [modules] Error 2
make[2]: *** [modules] Error 2
make[1]: *** [modules] Error 2
make: *** [default] Error 2

it looks like I can't compile it for kernel 2.6.30 because some headers 
files are missing (printk.h was inside kernel.h in previous kernel 
versions like in 2.6.30). But the documentation says that kernels 2.6.27 
and older are supported, so what am I doing wrong?


please, I'm stuck, any hint or information will be very appreciated!

Thanks
