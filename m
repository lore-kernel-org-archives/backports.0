Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34121 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208AbaDRBYy (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 17 Apr 2014 21:24:54 -0400
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: m.chehab@samsung.com, felipensp@gmail.com, mkrufky@linuxtv.org,
	linux-media@vger.kernel.org
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 0/2] media: make drivers use their own namespace
Date: Thu, 17 Apr 2014 18:24:42 -0700
Message-Id: <1397784284-15946-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20140418_032456_839425_9E7139C3)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Couple of changes to help with backports, both to help with ensuring
drivers use their own namespace.

Luis R. Rodriguez (2):
  technisat-usb2: rename led enums to be specific to driver
  bt8xx: make driver routines fit into its own namespcae

 drivers/media/pci/bt8xx/dst.c              | 20 ++++++++++----------
 drivers/media/usb/dvb-usb/technisat-usb2.c | 28 ++++++++++++++--------------
 2 files changed, 24 insertions(+), 24 deletions(-)

-- 
1.9.1

