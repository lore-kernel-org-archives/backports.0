Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:57474 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866Ab3GLXjQ (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 12 Jul 2013 19:39:16 -0400
MIME-Version: 1.0
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Fri, 12 Jul 2013 16:38:54 -0700
Message-ID: <CAB=NE6XyC0Svxh8yeVNvnpdkVBTWEAcmi8wZocc6MC=kxLs2iw@mail.gmail.com> (sfid-20130713_013918_517904_CB1CD07C)
Subject: [ANN] backports-v3.10 released - first release!
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Kicked out the first Linux kernel backports release under the new
project name, "backports" that hopefully clarifies this a generic
backport project now. Backported subsystems in this release:

  * Ethernet
  * Wireless
  * Bluetooth
  * NFC
  * GPU
  * Media
  * Regulator

Go read the git tree for a full ChangeLog, moving forward I won't be
providing those anymore. The highlights are  Johannes Berg's awesome
work on adding full Kconfig support, which makes you can use 'make
menuconfig', and his huge rework of the entire build system, and
kicking us into pythonifying everything non-user / build related.
Other obvious highlights are huge ongoing contributions by Hauke
without which any of this wouldn't have happened. Thierry Escande
threw in NFC, and we also now have Media and Regulator subsystems
backported. We should have now over 830 drivers backported.

Under the new build system users should query 'make help' and 'make
defconfig-help'.

Go download the new release [0] and if you want something more fancy
check out the new shiny but temporary release page [1].

[0] http://www.kernel.org/pub/linux/kernel/projects/backports/stable/v3.10/backports-3.10-1.tar.bz2
[1] http://drvbp1.linux-foundation.org/~mcgrof/rel-html/backports/

  Luis
