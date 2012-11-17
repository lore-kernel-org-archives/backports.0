Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:45536 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751675Ab2KQOIH (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 17 Nov 2012 09:08:07 -0500
Message-ID: <50A79A3C.9080706@hauke-m.de>
Date: Sat, 17 Nov 2012 15:07:56 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Pat Erley <pat-lkml@erley.org>
CC: =?ISO-8859-1?Q?Felipe_L=F3pez?= <lopez.rottweiler@gmail.com>,
	backports@vger.kernel.org
Subject: Re:
References: <CAGj=iG-eo0yNUR1rRrL-hEineQ=FHbEMA2He_=0NjuXHJ1KhuQ@mail.gmail.com> <50A3E2A4.7000806@erley.org>
In-Reply-To: <50A3E2A4.7000806@erley.org>
Content-Type: multipart/mixed;
 boundary="------------000206010906010404060602"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is a multi-part message in MIME format.
--------------000206010906010404060602
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

On 11/14/2012 07:27 PM, Pat Erley wrote:
> On 11/14/2012 05:21 AM, Felipe López wrote:
>> Hello guys,
>>
>>
>> I am Felipe López and I am working with an TL-WN722N that comes with a
>> AR9271 chipset. I got it to work in my PC some time ago but now I am
>> trying to install it in a ARM CPU.
>>
>> I selected the driver I need (./scripts/driver-select ath9k) and I
>> cross-compiled it against the kernel 2.6.30. I think that everything
>> is OK up to here. I get the following *.ko files:
>>
>> ./drivers/net/wireless/ath/
>> ath.ko
>> ./drivers/net/wireless/ath/ath9k/ath9k.ko
>> ./drivers/net/wireless/ath/ath9k/ath9k_common.ko
>> ./drivers/net/wireless/ath/ath9k/ath9k_htc.ko
>> ./drivers/net/wireless/ath/ath9k/ath9k_hw.ko
>> ./net/mac80211/mac80211.ko
>> ./net/rfkill/rfkill_backport.ko
>> ./net/wireless/cfg80211.ko
>> ./compat/sch_codel.ko
>> ./compat/sch_fq_codel.ko
>> ./compat/compat.ko
>> ./compat/compat_firmware_class.ko
>>
>> The first thing I do not know is in which order I should do the
>> insmod. I suppose that compat.ko should be the first but then comes
>> the second problem. This is what the board throws when I do the insmod
>> of compat.ko:
>>
>> compat: Unknown symbol cpufreq_cpu_put
>>
>>
>> I googled for that sentence and I found that that function is used in
>> kernels >= 2.6.31 so maybe I should use an older version of
>> compat-wireless. What version of compat-wireless is the best for the
>> kernel 2.6.30? The only I can imagine I can solve the last problem by
>> myself is trial-error.
>>
>>
>> Many thanks in advance
>>
>>
>> Felipe López
> 
> You can find the order using the 'modinfo' command (if you're manually
> loading all of the modules) like this:
> 
> $ modinfo ./compat/compat.ko | grep depends
> depends:
> 
> However, it does look like cpufreq_cpu_put may be a separate issue.  Did
> you compile your arm CPU with cpufreq support?  This may work as a
> temporary solution, as looking in the 2.6.30 source shows that function
> is exported.
> 
> Pat Erley

Hi Felipe,

could you try the attached patch, if it fixes your problem.

Hauke


--------------000206010906010404060602
Content-Type: text/x-patch;
 name="0001-compat-make-compat-load-without-CONFIG_CPU_FREQ.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-compat-make-compat-load-without-CONFIG_CPU_FREQ.patch"

>From 3ae967cde2c00d5f1f54e9c41cb50c670047498f Mon Sep 17 00:00:00 2001
From: Hauke Mehrtens <hauke@hauke-m.de>
Date: Sat, 17 Nov 2012 15:03:25 +0100
Subject: [PATCH] compat: make compat load without CONFIG_CPU_FREQ

If the kernel was compiled without CONFIG_CPU_FREQ cpufreq_cpu_put() is
not available, this is the case for some ARM kernels. In this case do
not add the backport function compat_cpufreq_quick_get_max to compat.ko.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 compat/compat-3.1.c        |    4 ++--
 include/linux/compat-3.1.h |    2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/compat/compat-3.1.c b/compat/compat-3.1.c
index 03735f6..354a8a3 100644
--- a/compat/compat-3.1.c
+++ b/compat/compat-3.1.c
@@ -18,7 +18,7 @@
  *
  * 	cpufreq: expose a cpufreq_quick_get_max routine
  */
-
+#ifdef CONFIG_CPU_FREQ
 unsigned int compat_cpufreq_quick_get_max(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
@@ -32,7 +32,7 @@ unsigned int compat_cpufreq_quick_get_max(unsigned int cpu)
 	return ret_freq;
 }
 EXPORT_SYMBOL(compat_cpufreq_quick_get_max);
-
+#endif
 
 static DEFINE_SPINLOCK(compat_simple_ida_lock);
 
diff --git a/include/linux/compat-3.1.h b/include/linux/compat-3.1.h
index dfd87a3..fc05245 100644
--- a/include/linux/compat-3.1.h
+++ b/include/linux/compat-3.1.h
@@ -111,10 +111,12 @@ int ida_simple_get(struct ida *ida, unsigned int start, unsigned int end,
 
 void ida_simple_remove(struct ida *ida, unsigned int id);
 
+#ifdef CONFIG_CPU_FREQ
 /* mask cpufreq_quick_get_max as RHEL6 backports this */
 #define cpufreq_quick_get_max(a) compat_cpufreq_quick_get_max(a)
 
 unsigned int cpufreq_quick_get_max(unsigned int cpu);
+#endif
 #endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)) */
 
 #endif /* LINUX_3_1_COMPAT_H */
-- 
1.7.10.4


--------------000206010906010404060602--
