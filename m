Return-path: <backports-owner@vger.kernel.org>
Received: from mms2.broadcom.com ([216.31.210.18]:4213 "EHLO mms2.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753110Ab3JWNCU (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Oct 2013 09:02:20 -0400
Message-ID: <5267C8D1.9050203@broadcom.com> (sfid-20131023_150223_942407_3E7DA376)
Date: Wed, 23 Oct 2013 15:02:09 +0200
From: "Arend van Spriel" <arend@broadcom.com>
MIME-Version: 1.0
To: "Singh, Gaurav" <gauravps@slingmedia.com>
cc: "hostap@lists.shmoo.com" <hostap@lists.shmoo.com>,
	ath9k-devel@lists.ath9k.org,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: ath9k Driver crash
References: <D5275F3D4773D14CAF5C73B4B03C29464273683E@INWPIEXC01.SATS.CORP>
In-Reply-To: <D5275F3D4773D14CAF5C73B4B03C29464273683E@INWPIEXC01.SATS.CORP>
Content-Type: text/plain;
 charset=iso-8859-1;
 format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

+ ath9k-devel@lists.ath9k.org
+ backports@vger.kernel.org

On 10/23/2013 02:22 PM, Singh, Gaurav wrote:
> Hi,
>
> Setup info:
>
> Linux: mips le, 2.6.29 on ViXS XC4200 SoC
> Ath9k from compat-wireless-3.6.8-1-snpc
> wpa_supplicant 2.0
>
> Only using wpa_supplicant, no network-manager etc.
>
> I see a system reboot after following (or similar) (formatted) logs:
>
> [Tue Oct 22 19:03:39.828 2013] Debug: Monitor Message :  <3>CTRL-EVENT-BSS-ADDED 89 08:cc:68:5e:d7:41
> [Tue Oct 22 19:03:39.829 2013] Debug: Monitor Message :  <3>CTRL-EVENT-SCAN-RESULTS
> [Tue Oct 22 19:03:39.865 2013] Debug: Monitor Message :  <3>WPS-AP-AVAILABLE-PBC
> [Tue Oct 22 19:03:39.871 2013] Debug: Monitor Message :  <3>SME: Trying to authenticate with 00:23:69:3b:77:9a (SSID='STB Lease Line 1' freq=2422 MHz)
> [Tue Oct 22 19:03:39.872 2013] Debug: Monitor Message :  <3>Trying to associate with 00:23:69:3b:77:9a (SSID='STB Lease Line 1' freq=2422 MHz)
> [Tue Oct 22 19:03:40.740 2013] irq 7: nobody cared (try booting with the "irqpoll" option)
> [Tue Oct 22 19:03:40.746 2013] MIPS5_INTERRUPT 0x00000000
> [Tue Oct 22 19:03:40.756 2013] MIPS5_INTERRUPT1 0x00000004
> [Tue Oct 22 19:03:40.764 2013] PPC_INT_STATUS 0x01000000 MASK 0x063000c2
> [Tue Oct 22 19:03:40.764 2013]
> [Tue Oct 22 19:03:40.764 2013] Call Trace:
> [Tue Oct 22 19:03:40.764 2013] [<900484e4>] dump_stack+0x8/0x34
> [Tue Oct 22 19:03:40.772 2013] [<9009af9c>] __report_bad_irq+0xb4/0x158
> [Tue Oct 22 19:03:40.773 2013] [<9009b1b4>] note_interrupt+0x174/0x23c
> [Tue Oct 22 19:03:40.773 2013] [<9009b934>] handle_percpu_irq+0xa8/0xcc
> [Tue Oct 22 19:03:40.800 2013] [<9004b488>] xcode_ic_dispatch_pci+0x30/0x40
> [Tue Oct 22 19:03:40.801 2013] [<9004002c>] ret_from_irq+0x0/0x4
> [Tue Oct 22 19:03:40.832 2013] [<90072ec0>] __do_softirq+0x60/0x130
> [Tue Oct 22 19:03:40.832 2013] [<90072ffc>] do_softirq+0x6c/0x74
> [Tue Oct 22 19:03:40.832 2013] [<9004002c>] ret_from_irq+0x0/0x4
> [Tue Oct 22 19:03:40.832 2013] [<90069de8>] finish_task_switch+0xc0/0x178
> [Tue Oct 22 19:03:40.833 2013] [<90048dcc>] schedule+0x300/0x440
> [Tue Oct 22 19:03:40.833 2013] [<9009125c>] futex_wait+0x43c/0x4a4
> [Tue Oct 22 19:03:40.833 2013] [<9009284c>] do_futex+0x120/0x9c8
> [Tue Oct 22 19:03:40.833 2013] [<90093180>] sys_futex+0x8c/0x17c
> [Tue Oct 22 19:03:40.833 2013] [<90041d04>] stack_done+0x20/0x3c
> [Tue Oct 22 19:03:40.861 2013]
> [Tue Oct 22 19:03:40.861 2013] handlers:
> [Tue Oct 22 19:03:40.861 2013] [<c6b8ff74>] (ath_isr+0x0/0x2d0 [ath9k])
> [Tue Oct 22 19:03:40.861 2013] Disabling IRQ #7
> [Tue Oct 22 19:03:43.278 2013]
>
> Sometimes, a bunch of similar blocks of logs print together.
>
> I am not sure what's causing this. *Any* pointers would be helpful.
>
> I am no expert in wireless tech, but am tasked with implementing basic wifi feature-set  for the product.

I suspect the ath_isr is not returning a good value to the kernel 
interrupt framework, but it might be a backports/compat issue.

> Thanks and Regards
> -Gaurav
>
> _______________________________________________
> HostAP mailing list
> HostAP@lists.shmoo.com
> http://lists.shmoo.com/mailman/listinfo/hostap
>


