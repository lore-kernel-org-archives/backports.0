Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:65407 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757848AbaKSWIG convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 19 Nov 2014 17:08:06 -0500
Received: by mail-ie0-f169.google.com with SMTP id y20so1538121ier.14
        for <backports@vger.kernel.org>; Wed, 19 Nov 2014 14:08:06 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 19 Nov 2014 23:08:06 +0100
Message-ID: <CACna6rxs6BOJh7dxBKYAeee-vtgr7s9iU5_MiEMc3-3Tf4S4zg@mail.gmail.com> (sfid-20141119_230810_768858_EA0418D4)
Subject: Including a comparable backported kernel version (number)?
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hello!

As you know, Linux includes such a lovely define called
LINUX_VERSION_CODE. It allows writing out-of-tree drivers that can
compile against few different kernel versions.

While this is surely a rare case, some ppl may want to develop &
compile out-of-tree drivers against... backports. Since there is
cfg80211/mac80211 in backports, out-of-tree drivers may want to check
for backported kernel version to decide which API version to use.

An example may be acx100/acx-mac80211 driver and OpenWrt project.
OpenWrt uses backports and acx code may need to be adjusted depending
on the version of backported mac80211.

Would it be sane/possible to add something like a LINUX_VERSION_CODE
for backports? I noticed we already have BACKPORTS_VERSION,
BACKPORTED_KERNEL_VERSION and BACKPORTED_KERNEL_NAME but they are all
strings.

-- 
Rafał
