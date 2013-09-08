Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:57096 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752094Ab3IHPme (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 8 Sep 2013 11:42:34 -0400
Message-ID: <522C9ADF.1020809@hauke-m.de> (sfid-20130908_174238_039299_29E2F83D)
Date: Sun, 08 Sep 2013 17:42:23 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	"Luis R. Rodriguez" <mcgrof@gmail.com>,
	=?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>
Subject: Removing of GPU drivers from backports
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi all,

bringing backports to a new version of linux next is a much bigger task
now that we have lots of more drivers we backport, especially the GPU
driver need a big effort to be backported. My rough estimation is that
the GPU driver are taking as much efforts as the wireless drivers and
subsystem to be maintained, thereby the wireless driver are supported on
much older kernel versions. There is little code shared between the
wireless and the GPU drivers expect the build system.

I tried to use the Intel i915 driver on my device with kernel 3.5 and it
did not worked (some in kernel errors) and when using kernel 3.7 it also
failed (kernel oops).

Who uses the GPU drivers form backports?
Which GPU driver were successfully runtime tested by anyone in the last
few months?

As we do not have that big constant man power I am for removing the GPU
drivers to make it easier to add support for a new linux next versions.
Most of the users are using backports to get a recent wireless driver
for their desktop Linux or their (old) Linux on an embedded device.

Hauke
