Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:43360 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab3CQRx1 (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 17 Mar 2013 13:53:27 -0400
Received: by mail-we0-f182.google.com with SMTP id t57so4337012wey.13
        for <backports@vger.kernel.org>; Sun, 17 Mar 2013 10:53:25 -0700 (PDT)
Date: Sun, 17 Mar 2013 18:53:21 +0100
From: =?utf-8?B?Q2FtYWxlw7Nu?= <noelamac@gmail.com>
To: backports@vger.kernel.org
Subject: Debian Wheezy: intel driver conflicts with compat-drivers
Message-ID: <20130317175321.GA5732@stt008.linux.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hello,

After compiling the compat-drivers (thanks to this mailing list 
support) I was unable to load the generated kernel module. It failed 
with a succinct message:

***
ERROR: could not insert 'alx': Exec format error
***

But dmesg showed more:

***
compat: exports duplicate symbol i2c_bit_algo (owned by i2c_algo_bit)
***

After restartig the system, gnome-shell crashed because Xorg loaded the
VESA driver. I did not join the points until I found a related bug 
report at Debian:

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=703142#51

And then was "pointed" to ask you :-)

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=703142#71

True is that I was able to compile and load "compat-drivers" with no 
problems at all from another system with no Intel card on it, so here
I am. 

Is is a known problem? Is there a workaround for Intel VGA-based 
systems?

Greetings,

-- 
Camaleón 
