Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:49865 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980Ab2J1OuJ convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 28 Oct 2012 10:50:09 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so3309651iag.19
        for <backports@vger.kernel.org>; Sun, 28 Oct 2012 07:50:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <508D29FD.2020704@hauke-m.de>
References: <CAFub=KSQ3xq1j8=dHqezh4NY05S7t0p4dSWdp=xa2HM74wL=Og@mail.gmail.com>
	<508D29FD.2020704@hauke-m.de>
Date: Sun, 28 Oct 2012 16:50:09 +0200
Message-ID: <CAFub=KRzDY=mxc_nyB3Y-fwHEqwm4OsCUj19vDCMwkwYqT34_g@mail.gmail.com>
Subject: Re: Regarding compat_autoconf.h generation
From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

> Hi,
>
> are you working o making nouveau work with compat-drivers? I just noticed
> that i915 is only activated driver and I have some problems with my nvidia
> card running nouveau and wanted to try out a new version.
>
> Hauke

Yep actually I got hit by this while trying to build nouveau. Now I
can succesfully build it but I broke up grub.cfg while adding a new
boot entry for compat-drivers trials and have to find out how to use
the uber-complicated grub2 command line...


-- 
Ozan Çağlayan
Research Assistant
Galatasaray University - Computer Engineering Dept.
http://www.ozancaglayan.com
