Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:50350 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751401Ab3LBOrf convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 2 Dec 2013 09:47:35 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 4F0E220268
	for <backports@vger.kernel.org>; Mon,  2 Dec 2013 14:47:30 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id BF5D720279
	for <backports@vger.kernel.org>; Mon,  2 Dec 2013 14:47:28 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 65881] errors compiling after make defconfig-alx
Date: Mon, 02 Dec 2013 14:47:28 +0000
Message-ID: <bug-65881-58281-InWPJMbMmD@https.bugzilla.kernel.org/> (sfid-20131202_154737_853312_D32FBE2A)
In-Reply-To: <bug-65881-58281@https.bugzilla.kernel.org/>
References: <bug-65881-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=65881

--- Comment #4 from Kenn <kolson@wsd1.org> ---
(In reply to Hauke Mehrtens from comment #3)
> Is it correct that you are using Suse Linux Enterprise Server?

Yes.

> Their kernel probably has lots of patches like the Red Hat kernel and it is
> not that easy to get backports running on such a kernel as nobody tried it
> before.

This is the default kernel for SLES 11.3 and unfortunately is the kernel Novell
uses for their production version of their current ZENworks Imaging product,
for which I need an updated alx. They just recently changed kernels (happens
roughly yearly), and this marks the first time I've had any major difficulty
compiling an updated driver. It is true that I can open an SR with them and in
time they will update the driver, but that can take weeks/months, whereas
*usually* I can get it done in about half an hour.

> Could you try the attached patch, it will probably not work completely with
> that patch, but you should get a set forward.

First off, I noted that on line 167 there was no closing parenthesis, so I put
one in. Hopefully that's correct.

Secondly, I got new errors, but fewer:

make[5]: `conf' is up to date.                                                  
#                                                                               
# configuration written to .config                                              
#                                                                               
Building backport-include/backport/autoconf.h ... done.                         
make -C ../../../linux-3.0.76-0.11
O=/usr/src/linux-3.0.76-0.11-obj/i386/default/. modules
  CC [M]  /root/Documents/Downloads/backports-3.13-rc1-1/compat/main.o
  CC [M]  /root/Documents/Downloads/backports-3.13-rc1-1/compat/compat-3.1.o
  CC [M]  /root/Documents/Downloads/backports-3.13-rc1-1/compat/compat-3.3.o
  CC [M]  /root/Documents/Downloads/backports-3.13-rc1-1/compat/compat-3.4.o
  CC [M]  /root/Documents/Downloads/backports-3.13-rc1-1/compat/compat-3.5.o
  CC [M] 
/root/Documents/Downloads/backports-3.13-rc1-1/compat/user_namespace.o
  CC [M]  /root/Documents/Downloads/backports-3.13-rc1-1/compat/compat-3.6.o
  CC [M]  /root/Documents/Downloads/backports-3.13-rc1-1/compat/compat-3.7.o
In file included from
/root/Documents/Downloads/backports-3.13-rc1-1/compat/compat-3.7.c:13:
/root/Documents/Downloads/backports-3.13-rc1-1/backport-include/linux/pci.h:103:
error: redefinition of ‘pcie_capability_set_word’
/usr/src/linux-3.0.76-0.11/include/linux/pci.h:805: error: previous definition
of ‘pcie_capability_set_word’ was here
/root/Documents/Downloads/backports-3.13-rc1-1/backport-include/linux/pci.h:109:
error: redefinition of ‘pcie_capability_set_dword’
/usr/src/linux-3.0.76-0.11/include/linux/pci.h:811: error: previous definition
of ‘pcie_capability_set_dword’ was here
/root/Documents/Downloads/backports-3.13-rc1-1/backport-include/linux/pci.h:115:
error: redefinition of ‘pcie_capability_clear_word’
/usr/src/linux-3.0.76-0.11/include/linux/pci.h:817: error: previous definition
of ‘pcie_capability_clear_word’ was here
/root/Documents/Downloads/backports-3.13-rc1-1/backport-include/linux/pci.h:121:
error: redefinition of ‘pcie_capability_clear_dword’
/usr/src/linux-3.0.76-0.11/include/linux/pci.h:823: error: previous definition
of ‘pcie_capability_clear_dword’ was here
/root/Documents/Downloads/backports-3.13-rc1-1/compat/compat-3.7.c:49: error:
conflicting types for ‘pci_pcie_type’
/usr/src/linux-3.0.76-0.11/include/linux/pci.h:1576: error: previous definition
of ‘pci_pcie_type’ was here
make[8]: ***
[/root/Documents/Downloads/backports-3.13-rc1-1/compat/compat-3.7.o] Error 1
make[7]: *** [/root/Documents/Downloads/backports-3.13-rc1-1/compat] Error 2
make[6]: *** [_module_/root/Documents/Downloads/backports-3.13-rc1-1] Error 2
make[5]: *** [sub-make] Error 2
make[4]: *** [all] Error 2
make[3]: *** [modules] Error 2
make[2]: *** [modules] Error 2
make[1]: *** [modules] Error 2
make: *** [default] Error 2


> When you click on "attachment" and then on View you get the patch.

When I click on "attachment" I get a nice web document that has the old code on
the left and the new code on the right, with changes highlighted in blue and
green.

when I click on "View" I see a screen that appears to have a script in it,
starting out:

diff --git a/backport-include/linux/device.h b/backport-include/linux/device.h
index e1d7bb7..198aec4 100644 ....

and so on. 

I tried copying this into a script file and executing it, but got these errors:

iff: unrecognized option '--git'                                              
diff: Try `diff --help' for more information.                                  
If 'index' is not a typo you can run the following command to lookup the
package that contains the binary:
    command-not-found index                                                     
bash: index: command not found                                                  
If '---' is not a typo you can run the following command to lookup the package
that contains the binary:  
    command-not-found ---                                                       
bash: ---: command not found                                                    
If '+++' is not a typo you can run the following command to lookup the package
that contains the binary:  
    command-not-found +++                                                       
bash: +++: command not found                                                    
bash: patch2: line 5: syntax error near unexpected token `('                    
bash: patch2: line 5: `@@ -29,7 +29,7 @@ backport_device_move(struct device
*dev, struct device *new_parent,'

-- 
You are receiving this mail because:
You are the assignee for the bug.