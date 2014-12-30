Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:59656 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbaL3Byo (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 29 Dec 2014 20:54:44 -0500
Received: by mail-ie0-f180.google.com with SMTP id rp18so13083348iec.39
        for <backports@vger.kernel.org>; Mon, 29 Dec 2014 17:54:44 -0800 (PST)
MIME-Version: 1.0
From: Ash Charles <ashcharles@gmail.com>
Date: Mon, 29 Dec 2014 17:54:14 -0800
Message-ID: <CAK8F28=6-rCCbAwA20OvW3VMFG8yBV7oZpvgRcNL1s=snR33Sg@mail.gmail.com> (sfid-20141230_025447_995379_C03AD297)
Subject: Providing Platform Data to Backported Module
To: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hello,

I'm trying to get add support for a wl18xx wireless device to my
omap3-based board running a 3.2 kernel.  Using backports (package, not
direct integration), I can compile the required drivers and load them
onto my system.  The driver needs some platform-specific data to
control the wireless device.  Normally, I'd pass this as platform data
from a board file (I'm not using device tree on this 3.2 kernel) but
as the required structures come from the backport, I can't.  How can I
provide this data to the module?

Things that come to mind but don't seem quite right:
1. Hard-code this setup data into the driver for my particular board
(seem a little heavy-handed)
2. Add a backport to support a board file/pdata-quirks. (nothing else
in the arch tree is backported...seems to indicate this is not the
right way)
3. Use the backports with direct integration as I think I could just
make the changes to the board file directly in this case (I'm using a
TI backport tree that doesn't support integration yet)
4. Add a device tree blob or some shim such that the target kernel can
provide the module the data.

Many thanks in advance for any advice or insight.

--Ash
