Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:56040 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753305Ab3BCSJV convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 3 Feb 2013 13:09:21 -0500
Received: by mail-wg0-f49.google.com with SMTP id 15so4270465wgd.16
        for <backports@vger.kernel.org>; Sun, 03 Feb 2013 10:09:20 -0800 (PST)
MIME-Version: 1.0
Date: Sun, 3 Feb 2013 20:09:19 +0200
Message-ID: <CAFub=KSf4d=57DF5sTAv5FUHqpw2TGRh3PY=YMutUAOGUhoYiQ@mail.gmail.com>
Subject: [RFC] More fine-grained building for compat-drivers
From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>
To: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,

Currently we're enabling both drm and network drivers in
scripts/admin-update.sh by default.

One of the problems is that I don't want to build network drivers at
all. If I change admin-update.sh to disable network drivers, another
problem arises: Makefile tries to add objects without looking at all
what subsystem is enabled.

So I changed things a little bit:
 1. Always pass parameters to admin-update.sh to define which
subsytems should be compiled, e.g. you should run
    scripts/admin-update.sh network drm

to compile both drivers.
 2. Write enabled subsystems into .enabled_subsystems
 3. Check .enabled_subsystems to conditionally add build targets in
Makefile. There was a BT=TRUE hack in Makefile that I dropped since I
didn't its function.

I'm now testing it and it seem to work nice. I'll send a patch for more reviews.

BTW, this is really a hack that we wouldn't need if we had kbuild support :)

Thanks.


--
Ozan Çağlayan
Research Assistant
Galatasaray University - Computer Engineering Dept.
http://www.ozancaglayan.com
