Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:38193 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752321Ab2KSPYc convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 19 Nov 2012 10:24:32 -0500
Received: by mail-la0-f46.google.com with SMTP id p5so1171165lag.19
        for <backports@vger.kernel.org>; Mon, 19 Nov 2012 07:24:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <50A79A3C.9080706@hauke-m.de>
References: <CAGj=iG-eo0yNUR1rRrL-hEineQ=FHbEMA2He_=0NjuXHJ1KhuQ@mail.gmail.com>
	<50A3E2A4.7000806@erley.org>
	<50A79A3C.9080706@hauke-m.de>
Date: Mon, 19 Nov 2012 16:24:30 +0100
Message-ID: <CAGj=iG8BDs=_=m2109C=uX=xRTwVeAgtJAHBPtXtPCsAoTpy+Q@mail.gmail.com>
Subject: Re:
From: =?ISO-8859-1?Q?Felipe_L=F3pez?= <lopez.rottweiler@gmail.com>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Pat Erley <pat-lkml@erley.org>, backports@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi guys,

I already solved that problem. Using an older version of
compat-wireless I solved the problem related to cpufreq support and I
load the modules in the following order:

compat.ko
compat_firmware_class.ko
rfkill_backport.ko
cfg80211.ko
mac80211.ko
ath.ko
ath9k_hw.ko
ath9k_common.ko
ath9k.ko
ath9k_htc.ko

However, when I plug the WiFi module, the kernel says that it can not
find the firmware file. Below is what he says:

usb 1-1.3: new full speed USB device using at91_ohci and address 4
usb 1-1.3: configuration #1 chosen from 1 choice
usb 1-1.3: ath9k_htc: Firmware - htc_9271.fw not found
ath9k_htc: probe of 1-1.3:1.0 failed with error -22

I configured the kernel to look for firmware files under
/lib/firmware/    but still not working, it always says that it cannot
find the firmware file. I do not know whether the problem is in the
.config file before compiling the kernel or in the filesystem. I am a
bit lost because I do not know in what direction I should go. I have
to mention that I am using an old version of busybox that does not
have depmod or lsusb that would help me a lot. Configuring a new
busybox would take me a long time...

Any idea of what to do? Many thanks again for keeping helping me

Best Regards

Felipe Lopez


2012/11/17 Hauke Mehrtens <hauke@hauke-m.de>:
> On 11/14/2012 07:27 PM, Pat Erley wrote:
>> On 11/14/2012 05:21 AM, Felipe López wrote:
>>> Hello guys,
>>>
>>>
>>> I am Felipe López and I am working with an TL-WN722N that comes with a
>>> AR9271 chipset. I got it to work in my PC some time ago but now I am
>>> trying to install it in a ARM CPU.
>>>
>>> I selected the driver I need (./scripts/driver-select ath9k) and I
>>> cross-compiled it against the kernel 2.6.30. I think that everything
>>> is OK up to here. I get the following *.ko files:
>>>
>>> ./drivers/net/wireless/ath/
>>> ath.ko
>>> ./drivers/net/wireless/ath/ath9k/ath9k.ko
>>> ./drivers/net/wireless/ath/ath9k/ath9k_common.ko
>>> ./drivers/net/wireless/ath/ath9k/ath9k_htc.ko
>>> ./drivers/net/wireless/ath/ath9k/ath9k_hw.ko
>>> ./net/mac80211/mac80211.ko
>>> ./net/rfkill/rfkill_backport.ko
>>> ./net/wireless/cfg80211.ko
>>> ./compat/sch_codel.ko
>>> ./compat/sch_fq_codel.ko
>>> ./compat/compat.ko
>>> ./compat/compat_firmware_class.ko
>>>
>>> The first thing I do not know is in which order I should do the
>>> insmod. I suppose that compat.ko should be the first but then comes
>>> the second problem. This is what the board throws when I do the insmod
>>> of compat.ko:
>>>
>>> compat: Unknown symbol cpufreq_cpu_put
>>>
>>>
>>> I googled for that sentence and I found that that function is used in
>>> kernels >= 2.6.31 so maybe I should use an older version of
>>> compat-wireless. What version of compat-wireless is the best for the
>>> kernel 2.6.30? The only I can imagine I can solve the last problem by
>>> myself is trial-error.
>>>
>>>
>>> Many thanks in advance
>>>
>>>
>>> Felipe López
>>
>> You can find the order using the 'modinfo' command (if you're manually
>> loading all of the modules) like this:
>>
>> $ modinfo ./compat/compat.ko | grep depends
>> depends:
>>
>> However, it does look like cpufreq_cpu_put may be a separate issue.  Did
>> you compile your arm CPU with cpufreq support?  This may work as a
>> temporary solution, as looking in the 2.6.30 source shows that function
>> is exported.
>>
>> Pat Erley
>
> Hi Felipe,
>
> could you try the attached patch, if it fixes your problem.
>
> Hauke
>
