Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:49370 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161054Ab2KNKV7 convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 14 Nov 2012 05:21:59 -0500
Received: by mail-la0-f46.google.com with SMTP id h6so186114lag.19
        for <backports@vger.kernel.org>; Wed, 14 Nov 2012 02:21:58 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 14 Nov 2012 11:21:58 +0100
Message-ID: <CAGj=iG-eo0yNUR1rRrL-hEineQ=FHbEMA2He_=0NjuXHJ1KhuQ@mail.gmail.com>
Subject: 
From: =?ISO-8859-1?Q?Felipe_L=F3pez?= <lopez.rottweiler@gmail.com>
To: backports@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hello guys,


I am Felipe López and I am working with an TL-WN722N that comes with a
AR9271 chipset. I got it to work in my PC some time ago but now I am
trying to install it in a ARM CPU.

I selected the driver I need (./scripts/driver-select ath9k) and I
cross-compiled it against the kernel 2.6.30. I think that everything
is OK up to here. I get the following *.ko files:

./drivers/net/wireless/ath/
ath.ko
./drivers/net/wireless/ath/ath9k/ath9k.ko
./drivers/net/wireless/ath/ath9k/ath9k_common.ko
./drivers/net/wireless/ath/ath9k/ath9k_htc.ko
./drivers/net/wireless/ath/ath9k/ath9k_hw.ko
./net/mac80211/mac80211.ko
./net/rfkill/rfkill_backport.ko
./net/wireless/cfg80211.ko
./compat/sch_codel.ko
./compat/sch_fq_codel.ko
./compat/compat.ko
./compat/compat_firmware_class.ko

The first thing I do not know is in which order I should do the
insmod. I suppose that compat.ko should be the first but then comes
the second problem. This is what the board throws when I do the insmod
of compat.ko:

compat: Unknown symbol cpufreq_cpu_put


I googled for that sentence and I found that that function is used in
kernels >= 2.6.31 so maybe I should use an older version of
compat-wireless. What version of compat-wireless is the best for the
kernel 2.6.30? The only I can imagine I can solve the last problem by
myself is trial-error.


Many thanks in advance


Felipe López
