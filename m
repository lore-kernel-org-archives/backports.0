Return-path: <backports-owner@vger.kernel.org>
Received: from [178.33.119.222] ([178.33.119.222]:38155 "EHLO mail.wifense.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753231AbaIHIeb (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 8 Sep 2014 04:34:31 -0400
Received: from localhost (unknown [127.0.0.1])
	by mail.wifense.com (Postfix) with ESMTP id 858CD2C084C
	for <backports@vger.kernel.org>; Mon,  8 Sep 2014 08:37:54 +0000 (UTC)
Received: from mail.wifense.com ([127.0.0.1])
	by localhost (mail.wifense.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IPtXMc4KQLJQ for <backports@vger.kernel.org>;
	Mon,  8 Sep 2014 10:37:41 +0200 (CEST)
Received: from [172.30.200.107] (230.red-80-28-132.adsl.static.ccgg.telefonica.net [80.28.132.230])
	(Authenticated sender: jcasas@wifense.com)
	by mail.wifense.com (Postfix) with ESMTPSA id D38462C0840
	for <backports@vger.kernel.org>; Mon,  8 Sep 2014 10:37:41 +0200 (CEST)
Message-ID: <540D6A0A.30609@wifense.com> (sfid-20140908_103435_474263_1E24BCB7)
Date: Mon, 08 Sep 2014 10:34:18 +0200
From: Javier Casas Marin <jcasas@wifense.com>
MIME-Version: 1.0
To: backports@vger.kernel.org
Subject: error compiling backports-3.14-1: too many arguments to function
 'request_firmware_nowait'
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


Hi,
when I try to compile backports-3.14-1 in a 2.6.30 kernel I get this error:

/root/modules/backports-3.14-1/drivers/net/wireless/ath/ath9k/init.c: In 
function 'ath9k_eeprom_request':
/root/modules/backports-3.14-1/drivers/net/wireless/ath/ath9k/init.c:647: warning: 
passing argument 5 of 'request_firmware_nowait' makes pointer from 
integer without a cast
/root/modules/backports-3.14-1/drivers/net/wireless/ath/ath9k/init.c:647: warning: 
passing argument 6 of 'request_firmware_nowait' from incompatible 
pointer type
/root/modules/backports-3.14-1/drivers/net/wireless/ath/ath9k/init.c:647: error: 
too many arguments to function 'request_firmware_nowait'
make[8]: *** 
[/root/modules/backports-3.14-1/drivers/net/wireless/ath/ath9k/init.o] 
Error 1
make[7]: *** 
[/root/modules/backports-3.14-1/drivers/net/wireless/ath/ath9k] Error 2
make[6]: *** [/root/modules/backports-3.14-1/drivers/net/wireless/ath] 
Error 2
make[5]: *** [/root/modules/backports-3.14-1/drivers/net/wireless] Error 2
make[4]: *** [_module_/root/modules/backports-3.14-1] Error 2
make[3]: *** [modules] Error 2
make[2]: *** [modules] Error 2
make[1]: *** [modules] Error 2
make: *** [default] Error 2

I saw that in backport-include/linux/firmware.h there is a pre-compiler 
directive to use the backport's version of request_firmware_nowait function:

#if defined(CPTCFG_BACKPORT_BUILD_FW_LOADER_MODULE)
#define request_firmware_nowait LINUX_BACKPORT(request_firmware_nowait)

But I haven't found where the CPTCFG_BACKPORT_BUILD_FW_LOADER_MODULE is 
defined.

I just ran:
make defconfig-ath9k
make

Am I missing a previous configuration step?

Thanks!
