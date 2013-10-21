Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:43305 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751233Ab3JUFcu (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 21 Oct 2013 01:32:50 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id C3E8D203B5
	for <backports@vger.kernel.org>; Mon, 21 Oct 2013 05:32:49 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id B83542037F
	for <backports@vger.kernel.org>; Mon, 21 Oct 2013 05:32:48 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 63381] New: cpumask.h error
Date: Mon, 21 Oct 2013 05:32:47 +0000
Message-ID: <bug-63381-58281@https.bugzilla.kernel.org/> (sfid-20131021_073255_512845_2F7AE8E8)
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=63381

            Bug ID: 63381
           Summary: cpumask.h error
           Product: Backports project
           Version: unspecified
    Kernel Version: 2.6.27.57
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: Backports
          Assignee: backports@vger.kernel.org
          Reporter: darin.vancoevering@gmail.com
        Regression: No

e/linux/kernel.h:3,
                 from
/home/supervl/Desktop/2/backports-3.10.4-1/compat/kstrtox. c:14:
include/linux/cpumask.h: At top level:
include/linux/cpumask.h:141: error: variable-size type declared outside of any
f unction
include/linux/cpumask.h:276: error: variable-size type declared outside of any
f unction
In file included from include/asm/processor.h:25,
                 from include/asm/atomic_32.h:5,
                 from include/asm/atomic.h:2,
                 from
/home/supervl/Desktop/2/backports-3.10.4-1/backport-includ e/asm/atomic.h:3,
                 from
/home/supervl/Desktop/2/backports-3.10.4-1/backport-includ e/linux/types.h:47,
                 from include/linux/kernel.h:13,
                 from
/home/supervl/Desktop/2/backports-3.10.4-1/backport-includ e/linux/kernel.h:3,
                 from
/home/supervl/Desktop/2/backports-3.10.4-1/compat/kstrtox. c:14:
/home/supervl/Desktop/2/backports-3.10.4-1/backport-include/linux/cpumask.h:7:
e rror: variable-size type declared outside of any function
In file included from include/asm/atomic_32.h:5,
                 from include/asm/atomic.h:2,
                 from
/home/supervl/Desktop/2/backports-3.10.4-1/backport-includ e/asm/atomic.h:3,
                 from
/home/supervl/Desktop/2/backports-3.10.4-1/backport-includ e/linux/types.h:47,
                 from include/linux/kernel.h:13,
                 from
/home/supervl/Desktop/2/backports-3.10.4-1/backport-includ e/linux/kernel.h:3,
                 from
/home/supervl/Desktop/2/backports-3.10.4-1/compat/kstrtox. c:14:
include/asm/processor.h: In function `native_get_debugreg':
include/asm/processor.h:443: error: implicit declaration of function `BUG'
make[6]: *** [/home/supervl/Desktop/2/backports-3.10.4-1/compat/kstrtox.o]
Error  1
make[5]: *** [/home/supervl/Desktop/2/backports-3.10.4-1/compat] Error 2
make[4]: *** [_module_/home/supervl/Desktop/2/backports-3.10.4-1] Error 2
make[3]: *** [modules] Error 2
make[2]: *** [modules] Error 2
make[1]: *** [modules] Error 2
make: *** [default] Error 2

Driver build error from 3.9 version upwards

  INSTALL
/home/supervl/Desktop/1/compat-drivers-3.8.3-2-snpu/drivers/net/wireless/rtl818x/rtl8180/rtl8180.ko
  INSTALL
/home/supervl/Desktop/1/compat-drivers-3.8.3-2-snpu/drivers/net/wireless/rtl818x/rtl8187/rtl8187.ko
  INSTALL
/home/supervl/Desktop/1/compat-drivers-3.8.3-2-snpu/drivers/net/wireless/rtlwifi/rtl8192c/rtl8192c-common.ko
  INSTALL
/home/supervl/Desktop/1/compat-drivers-3.8.3-2-snpu/drivers/net/wireless/rtlwifi/rtl8192ce/rtl8192ce.ko
  INSTALL
/home/supervl/Desktop/1/compat-drivers-3.8.3-2-snpu/drivers/net/wireless/rtlwifi/rtl8192cu/rtl8192cu.ko
  INSTALL
/home/supervl/Desktop/1/compat-drivers-3.8.3-2-snpu/drivers/net/wireless/rtlwifi/rtl8192de/rtl8192de.ko
  INSTALL
/home/supervl/Desktop/1/compat-drivers-3.8.3-2-snpu/drivers/net/wireless/rtlwifi/rtl8192se/rtl8192se.ko
  INSTALL
/home/supervl/Desktop/1/compat-drivers-3.8.3-2-snpu/drivers/net/wireless/rtlwifi/rtl8723ae/rtl8723ae.ko
  INSTALL
/home/supervl/Desktop/1/compat-drivers-3.8.3-2-snpu/drivers/net/wireless/rtlwifi/rtlwifi.ko
  INSTALL
/home/supervl/Desktop/1/compat-drivers-3.8.3-2-snpu/net/rfkill/rfkill_backport.ko
  INSTALL
/home/supervl/Desktop/1/compat-drivers-3.8.3-2-snpu/net/wireless/lib80211.ko
  INSTALL
/home/supervl/Desktop/1/compat-drivers-3.8.3-2-snpu/net/wireless/lib80211_crypt_ccmp.ko
  INSTALL
/home/supervl/Desktop/1/compat-drivers-3.8.3-2-snpu/net/wireless/lib80211_crypt_tkip.ko
  INSTALL
/home/supervl/Desktop/1/compat-drivers-3.8.3-2-snpu/net/wireless/lib80211_crypt_wep.ko
  DEPMOD  2.6.27.57-SG
make[1]: Leaving directory `/usr/src/linux-2.6.27.57'


Drivers build normally with 3.8.3 with same kernel and same stripped sources
aka crippled sources.

-- 
You are receiving this mail because:
You are the assignee for the bug.
