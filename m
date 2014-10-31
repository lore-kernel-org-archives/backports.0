Return-path: <backports-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:41868 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417AbaJaSkJ (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 31 Oct 2014 14:40:09 -0400
Received: by mail-qg0-f48.google.com with SMTP id q108so6001524qgd.7
        for <backports@vger.kernel.org>; Fri, 31 Oct 2014 11:40:08 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 31 Oct 2014 16:40:08 -0200
Message-ID: <CAG_2TMdYXqO5bRC7gmjY-yZzw-KJQDc2bzsGKj6cdygYPGW1Jw@mail.gmail.com> (sfid-20141031_194011_516886_C6A25938)
Subject: compat-drivers-3.8.3-2-snpu with kernel 2.6.24
From: Renato <renatoriolino@gmail.com>
To: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,

I have and old Linux system built from scratch based on kernel 2.6.24
and I need to add support on it for an Atheros ethernet card that
doesnt have driver for kernel 2.6.24.

Unfortunately we can't update the kernel because my client has a
control hardware that only have binary e propertery driver for 2.6.24.

Because of that, I'm trying to use compat-drivers to do that.

What I did so far was:

Downloaded compat-drivers-3.8.3-2-snpu and extraceted it.
Compiled it using:

./scripts/driver-select alx
make
make install

After rebooting, I loaded the compat driver with:

modprobe compat

I can see the following on dmesg:

Compat-drivers backport release: compat-drivers-v3.8.3-2-snpu
Backport based on linux-stable.git v3.8.3
compat.git: linux-stable.git

Nothing more. And no eth yet.

What I am missing?

Thanks
