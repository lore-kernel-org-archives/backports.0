Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from erley.org ([97.107.129.9]:38380 "EHLO remote.erley.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423146Ab2KNSgC (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 14 Nov 2012 13:36:02 -0500
Message-ID: <50A3E2A4.7000806@erley.org>
Date: Wed, 14 Nov 2012 13:27:48 -0500
From: Pat Erley <pat-lkml@erley.org>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Felipe_L=F3pez?= <lopez.rottweiler@gmail.com>
CC: backports@vger.kernel.org
Subject: Re:
References: <CAGj=iG-eo0yNUR1rRrL-hEineQ=FHbEMA2He_=0NjuXHJ1KhuQ@mail.gmail.com>
In-Reply-To: <CAGj=iG-eo0yNUR1rRrL-hEineQ=FHbEMA2He_=0NjuXHJ1KhuQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 11/14/2012 05:21 AM, Felipe López wrote:
> Hello guys,
>
>
> I am Felipe López and I am working with an TL-WN722N that comes with a
> AR9271 chipset. I got it to work in my PC some time ago but now I am
> trying to install it in a ARM CPU.
>
> I selected the driver I need (./scripts/driver-select ath9k) and I
> cross-compiled it against the kernel 2.6.30. I think that everything
> is OK up to here. I get the following *.ko files:
>
> ./drivers/net/wireless/ath/
> ath.ko
> ./drivers/net/wireless/ath/ath9k/ath9k.ko
> ./drivers/net/wireless/ath/ath9k/ath9k_common.ko
> ./drivers/net/wireless/ath/ath9k/ath9k_htc.ko
> ./drivers/net/wireless/ath/ath9k/ath9k_hw.ko
> ./net/mac80211/mac80211.ko
> ./net/rfkill/rfkill_backport.ko
> ./net/wireless/cfg80211.ko
> ./compat/sch_codel.ko
> ./compat/sch_fq_codel.ko
> ./compat/compat.ko
> ./compat/compat_firmware_class.ko
>
> The first thing I do not know is in which order I should do the
> insmod. I suppose that compat.ko should be the first but then comes
> the second problem. This is what the board throws when I do the insmod
> of compat.ko:
>
> compat: Unknown symbol cpufreq_cpu_put
>
>
> I googled for that sentence and I found that that function is used in
> kernels >= 2.6.31 so maybe I should use an older version of
> compat-wireless. What version of compat-wireless is the best for the
> kernel 2.6.30? The only I can imagine I can solve the last problem by
> myself is trial-error.
>
>
> Many thanks in advance
>
>
> Felipe López

You can find the order using the 'modinfo' command (if you're manually 
loading all of the modules) like this:

$ modinfo ./compat/compat.ko | grep depends
depends:

However, it does look like cpufreq_cpu_put may be a separate issue.  Did 
you compile your arm CPU with cpufreq support?  This may work as a 
temporary solution, as looking in the 2.6.30 source shows that function 
is exported.

Pat Erley

