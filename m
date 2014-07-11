Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37360 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbaGKWlU convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 11 Jul 2014 18:41:20 -0400
Received: by mail-wi0-f172.google.com with SMTP id n3so366713wiv.17
        for <backports@vger.kernel.org>; Fri, 11 Jul 2014 15:41:16 -0700 (PDT)
Received: from [192.168.1.23] ([2.49.149.245])
        by mx.google.com with ESMTPSA id gh16sm12211743wic.3.2014.07.11.15.41.14
        for <backports@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 15:41:15 -0700 (PDT)
From: Hosam Hittini <h.hittini@gmail.com>
Content-Type: text/plain; charset=windows-1252
Subject: AR9280 AP mode - 5GHz band
Date: Sat, 12 Jul 2014 02:41:12 +0400
References: <75688271-88AC-4AA3-9388-53C8B5EC188D@gmail.com>
To: backports@vger.kernel.org
Message-Id: <BA210F4A-D5E5-4404-9FA8-49794C5C94B2@gmail.com> (sfid-20140712_004121_984988_6066AD82)
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hello there,

I was facing a problem in configuring my dual band USB adapter https://www.thinkpenguin.com/gnu-linux/penguin-wireless-n-dual-band-usb-adapter-gnu-linux-tpe-nusbdb as an access point on the 5GHz band, it has AR9280 chipset
I have Ubuntu 13.10 and running 3.11 kernel, I’m using hostapd for the AP configuration
When I try to configure it, it says that the channel is not supported by the configured mode
I managed to change the CRDA settings by getting backports package http://www.kernel.org/pub/linux/kernel/projects/backports/stable/v3.15.1/, modifying the db.txt and forcing the driver to follow my db.txt
This how my db.txt looks like

country 00:
	(2402 - 2482 @ 20), (N/A, 20)
	(5170 - 5250 @ 40), (N/A, 20)
	(5250 - 5330 @ 40), (N/A, 20)
	(5490 - 5710 @ 40), (N/A, 20)
	(5735 - 5835 @ 40), (N/A, 20)Regards,

However, when I try to configure the AP on a 5GHz channel I still get the same error
wlan0: IEEE 802.11 Configured channel (36) not found from the channel list of current mode (2) IEEE 802.11a
There is one more strange thing, the output of iw reg get and iw list have a conflict

hosam@SanDisk-16:~$ iw reg get
country 00:
	(2402 - 2482 @ 20), (N/A, 20)
	(5170 - 5250 @ 40), (N/A, 20)
	(5250 - 5330 @ 40), (N/A, 20)
	(5490 - 5710 @ 40), (N/A, 20)
	(5735 - 5835 @ 40), (N/A, 20)
iw list
Frequencies:
			* 5180 MHz [36] (30.0 dBm) (passive scanning, no IBSS)
			* 5200 MHz [40] (30.0 dBm) (passive scanning, no IBSS)
			* 5220 MHz [44] (30.0 dBm) (passive scanning, no IBSS)
			* 5240 MHz [48] (30.0 dBm) (passive scanning, no IBSS)
			* 5260 MHz [52] (30.0 dBm) (passive scanning, no IBSS, radar detection)
			* 5280 MHz [56] (30.0 dBm) (passive scanning, no IBSS, radar detection)
			* 5300 MHz [60] (30.0 dBm) (passive scanning, no IBSS, radar detection)
			* 5320 MHz [64] (30.0 dBm) (passive scanning, no IBSS, radar detection)
			* 5500 MHz [100] (30.0 dBm) (passive scanning, no IBSS, radar detection)
			* 5520 MHz [104] (30.0 dBm) (passive scanning, no IBSS, radar detection)
			* 5540 MHz [108] (30.0 dBm) (passive scanning, no IBSS, radar detection)
			* 5560 MHz [112] (30.0 dBm) (passive scanning, no IBSS, radar detection)
			* 5580 MHz [116] (30.0 dBm) (passive scanning, no IBSS, radar detection)
			* 5600 MHz [120] (30.0 dBm) (passive scanning, no IBSS, radar detection)
			* 5620 MHz [124] (30.0 dBm) (passive scanning, no IBSS, radar detection)
			* 5640 MHz [128] (30.0 dBm) (passive scanning, no IBSS, radar detection)
			* 5660 MHz [132] (30.0 dBm) (passive scanning, no IBSS, radar detection)
			* 5680 MHz [136] (30.0 dBm) (passive scanning, no IBSS, radar detection)
			* 5700 MHz [140] (30.0 dBm) (passive scanning, no IBSS, radar detection)
			* 5745 MHz [149] (30.0 dBm) (passive scanning, no IBSS)
			* 5765 MHz [153] (30.0 dBm) (passive scanning, no IBSS)
			* 5785 MHz [157] (30.0 dBm) (passive scanning, no IBSS)
			* 5805 MHz [161] (30.0 dBm) (passive scanning, no IBSS)
			* 5825 MHz [165] (30.0 dBm) (passive scanning, no IBSS)
What’s wrong here?
Thank you

Regards,
Eng. Hosam Hittini