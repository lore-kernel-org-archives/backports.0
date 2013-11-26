Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:36321 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753650Ab3KZTNB convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 26 Nov 2013 14:13:01 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 96E6620435
	for <backports@vger.kernel.org>; Tue, 26 Nov 2013 19:12:59 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id C93912037B
	for <backports@vger.kernel.org>; Tue, 26 Nov 2013 19:12:54 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 65881] errors compiling after make defconfig-alx
Date: Tue, 26 Nov 2013 19:12:54 +0000
Message-ID: <bug-65881-58281-10P2RfMijC@https.bugzilla.kernel.org/> (sfid-20131126_201303_854553_8A27F1D3)
In-Reply-To: <bug-65881-58281@https.bugzilla.kernel.org/>
References: <bug-65881-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=65881

--- Comment #2 from Kenn <kolson@wsd1.org> ---
Just to confirm, the patch was simply to delete the lines indicated in the
attachment and retry the previous steps. (I didn't find a patch to download,
just the steps.)

Assuming that was the correct procedure, here is the result:

make[5]: `conf' is up to date.                                                  
#                                                                               
# configuration written to .config                                              
#                                                                               
Building backport-include/backport/autoconf.h ... done.                         
make -C ../../../linux-3.0.76-0.11
O=/usr/src/linux-3.0.76-0.11-obj/i386/default/. modules   
  CC [M]  /root/Documents/Downloads/backports-3.13-rc1-1/compat/main.o          
  CC [M]  /root/Documents/Downloads/backports-3.13-rc1-1/compat/compat-3.1.o    
In file included from /usr/src/linux-3.0.76-0.11/include/linux/cpufreq.h:17,    
                 from
/root/Documents/Downloads/backports-3.13-rc1-1/compat/compat-3.1.c:12: 
/root/Documents/Downloads/backports-3.13-rc1-1/backport-include/linux/device.h:42:1:
warning: "module_driver" redefined                                              
In file included from
/root/Documents/Downloads/backports-3.13-rc1-1/backport-include/linux/device.h:4, 
                 from /usr/src/linux-3.0.76-0.11/include/linux/cpufreq.h:17,    
                 from
/root/Documents/Downloads/backports-3.13-rc1-1/compat/compat-3.1.c:12:          
/usr/src/linux-3.0.76-0.11/include/linux/device.h:980:1: warning: this is the
location of the previous definition   
In file included from /usr/src/linux-3.0.76-0.11/include/linux/cpufreq.h:17,    
                 from
/root/Documents/Downloads/backports-3.13-rc1-1/compat/compat-3.1.c:12:          
/root/Documents/Downloads/backports-3.13-rc1-1/backport-include/linux/device.h:42:1:
warning: "module_driver" redefined                                              
In file included from
/root/Documents/Downloads/backports-3.13-rc1-1/backport-include/linux/device.h:4, 
                 from /usr/src/linux-3.0.76-0.11/include/linux/cpufreq.h:17,    
                 from
/root/Documents/Downloads/backports-3.13-rc1-1/compat/compat-3.1.c:12:          
/usr/src/linux-3.0.76-0.11/include/linux/device.h:980:1: warning: this is the
location of the previous definition   
  CC [M]  /root/Documents/Downloads/backports-3.13-rc1-1/compat/compat-3.3.o    
In file included from /usr/src/linux-3.0.76-0.11/include/linux/dmaengine.h:24,  
                 from /usr/src/linux-3.0.76-0.11/include/linux/skbuff.h:30,     
                 from
/root/Documents/Downloads/backports-3.13-rc1-1/backport-include/linux/skbuff.h:3, 
                 from
/root/Documents/Downloads/backports-3.13-rc1-1/compat/compat-3.3.c:13:          
/root/Documents/Downloads/backports-3.13-rc1-1/backport-include/linux/device.h:42:1:
warning: "module_driver" redefined                                              
In file included from
/root/Documents/Downloads/backports-3.13-rc1-1/backport-include/linux/device.h:4, 
                 from /usr/src/linux-3.0.76-0.11/include/linux/dmaengine.h:24,  
                 from /usr/src/linux-3.0.76-0.11/include/linux/skbuff.h:30,     
                 from
/root/Documents/Downloads/backports-3.13-rc1-1/backport-include/linux/skbuff.h:3, 
                 from
/root/Documents/Downloads/backports-3.13-rc1-1/compat/compat-3.3.c:13:          
/usr/src/linux-3.0.76-0.11/include/linux/device.h:980:1: warning: this is the
location of the previous definition   
In file included from /usr/src/linux-3.0.76-0.11/include/net/dst.h:12,          
                 from
/root/Documents/Downloads/backports-3.13-rc1-1/backport-include/net/dst.h:3,
                 from
/root/Documents/Downloads/backports-3.13-rc1-1/compat/compat-3.3.c:16:
/root/Documents/Downloads/backports-3.13-rc1-1/backport-include/linux/netdevice.h:160:
error: redefinition of ‘netdev_tx_sent_queue’
/usr/src/linux-3.0.76-0.11/include/linux/netdevice.h:1972: error: previous
definition of ‘netdev_tx_sent_queue’ was here
/root/Documents/Downloads/backports-3.13-rc1-1/backport-include/linux/netdevice.h:166:
error: redefinition of ‘netdev_sent_queue’
/usr/src/linux-3.0.76-0.11/include/linux/netdevice.h:1976: error: previous
definition of ‘netdev_sent_queue’ was here
/root/Documents/Downloads/backports-3.13-rc1-1/backport-include/linux/netdevice.h:171:
error: redefinition of ‘netdev_tx_completed_queue’
/usr/src/linux-3.0.76-0.11/include/linux/netdevice.h:1982: error: previous
definition of ‘netdev_tx_completed_queue’ was here
/root/Documents/Downloads/backports-3.13-rc1-1/backport-include/linux/netdevice.h:177:
error: redefinition of ‘netdev_completed_queue’
/usr/src/linux-3.0.76-0.11/include/linux/netdevice.h:1987: error: previous
definition of ‘netdev_completed_queue’ was here
/root/Documents/Downloads/backports-3.13-rc1-1/backport-include/linux/netdevice.h:183:
error: redefinition of ‘netdev_tx_reset_queue’
/usr/src/linux-3.0.76-0.11/include/linux/netdevice.h:1992: error: previous
definition of ‘netdev_tx_reset_queue’ was here
/root/Documents/Downloads/backports-3.13-rc1-1/backport-include/linux/netdevice.h:188:
error: redefinition of ‘netdev_reset_queue’
/usr/src/linux-3.0.76-0.11/include/linux/netdevice.h:1996: error: previous
definition of ‘netdev_reset_queue’ was here
make[8]: ***
[/root/Documents/Downloads/backports-3.13-rc1-1/compat/compat-3.3.o] Error 1
make[7]: *** [/root/Documents/Downloads/backports-3.13-rc1-1/compat] Error 2
make[6]: *** [_module_/root/Documents/Downloads/backports-3.13-rc1-1] Error 2
make[5]: *** [sub-make] Error 2
make[4]: *** [all] Error 2
make[3]: *** [modules] Error 2
make[2]: *** [modules] Error 2
make[1]: *** [modules] Error 2
make: *** [default] Error 2

-- 
You are receiving this mail because:
You are the assignee for the bug.