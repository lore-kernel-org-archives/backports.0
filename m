Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:44258 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754197Ab3BBMt1 convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 2 Feb 2013 07:49:27 -0500
Received: by mail-wg0-f53.google.com with SMTP id fn15so3680656wgb.32
        for <backports@vger.kernel.org>; Sat, 02 Feb 2013 04:49:26 -0800 (PST)
MIME-Version: 1.0
Date: Sat, 2 Feb 2013 14:49:26 +0200
Message-ID: <CAFub=KRc30sW-zFKscTSOtAPa-jX-bLc777jcUX92eDgiSDBzg@mail.gmail.com>
Subject: Return values in ckmake
From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>
To: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,

I can't build current compat against 3.7:

 make -C /root/compat-ksrc/lib/modules/3.7.0-030700-generic/build/
M=/root/git/compat/.tmp.ckmake/3.7.0 modules
make[1]: Entering directory
`/root/compat-ksrc/usr/src/linux-headers-3.7.0-030700-generic'
   CC [M]  /root/git/compat/.tmp.ckmake/3.7.0/compat/main.o
   CC [M]  /root/git/compat/.tmp.ckmake/3.7.0/compat/compat-3.8.o
 /root/git/compat/.tmp.ckmake/3.7.0/compat/compat-3.8.c: In function
‘netdev_set_default_ethtool_ops’:
 /root/git/compat/.tmp.ckmake/3.7.0/compat/compat-3.8.c:34:27: error:
‘default_ethtool_ops’ undeclared (first use in this function)
 /root/git/compat/.tmp.ckmake/3.7.0/compat/compat-3.8.c:34:27: note:
each undeclared identifier is reported only once for each function it
appears in
 make[3]: *** [/root/git/compat/.tmp.ckmake/3.7.0/compat/compat-3.8.o] Error 1
 make[2]: *** [/root/git/compat/.tmp.ckmake/3.7.0/compat] Error 2
 make[1]: *** [_module_/root/git/compat/.tmp.ckmake/3.7.0] Error 2
 make[1]: Leaving directory
`/root/compat-ksrc/usr/src/linux-headers-3.7.0-030700-generic'
 make: *** [modules] Error 2

--

This returns 2 but ckmake interprets return values 0 and 2 to "OK" in
get_status_name() thus logs and curses shows OK for this failed build.

--
Ozan Çağlayan
Research Assistant
Galatasaray University - Computer Engineering Dept.
http://www.ozancaglayan.com
