Return-path: <backports-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:34410 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbcECJS6 (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 3 May 2016 05:18:58 -0400
Received: by mail-vk0-f65.google.com with SMTP id m188so1222101vka.1
        for <backports@vger.kernel.org>; Tue, 03 May 2016 02:18:58 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 3 May 2016 18:18:57 +0900
Message-ID: <CAArnnE7di429C8uhQCd=AQVej0mpA9BPMh-at+GyFgk16gj1ng@mail.gmail.com> (sfid-20160503_111901_478492_8CBE8E8E)
Subject: How to backport a bluetooth subsystem? not shown 'Bluetooth subsystem
 support' selection.
From: Hyuntak Lee <pphdev12@gmail.com>
To: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Dears,

I have been working with embedded boards. It only supports 3.4 kernel.
So, I'm trying to backport a latest bluetooth subsystem to 3.4 kernel.
(I used a backports-4.1.1-1 stable release)
But I could not backport because not shown 'Bluetooth subsystem
support' selection.

My steps is below:

###To compile old kernel
$ export ARCH=arm
$ export CROSS_COMPILE=$CCPREFIX
$ cd $KERNEL_SRC
KERNEL_SRC$ make defconfig
KERNEL_SRC$ make
KERNEL_SRC$ make INSTALL_MOD_PATH=$OUTPUT install
###To backport
$ export KLIB=$KERNEL_SRC
$ export KLIB_BUILD=$OUTPUT
$ wget http://www.kernel.org/pub/linux/kernel/projects/backports/stable/v4.1.1/backports-4.1.1-1.tar.xz
$ unxz backports-4.1.1-1.tar.xz
$ tar xfp backports-4.1.1-1.tar
$ cd backports-4.1.1-1
backports-4.1.1-1$ make menuconfig
### not shown 'Bluetooth subsystem support' selection.

But, if not set a KLIB env value, shown 'Bluetooth subsystem support' selection.

Am I missing some configuration?
Please advise me.

Best regards,
tak
--
To unsubscribe from this list: send the line "unsubscribe backports" in
