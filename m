Return-path: <backports-owner@vger.kernel.org>
Received: from test.hauke-m.de ([5.39.93.123]:55564 "EHLO test.hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933576AbaGWW1y (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Jul 2014 18:27:54 -0400
Message-ID: <53D036E8.5070707@hauke-m.de> (sfid-20140724_002756_009063_2C4FD016)
Date: Thu, 24 Jul 2014 00:27:52 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: "C. McPherson" <ccmcphe@verizon.net>, backports@vger.kernel.org
Subject: Re: Backport issue net/mac80211/iface.c
References: <53C6E0BE.9070800@verizon.net>
In-Reply-To: <53C6E0BE.9070800@verizon.net>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 07/16/2014 10:29 PM, C. McPherson wrote:
> When I build backports-3.15-rc1-1 I get the following warnings (my linux
> kernel version is 3.13.0-24) Mint 17:
> 
> Here is my version information:
> linuxbox backports-3.15-rc1-1 # uname -r
> 3.13.0-24-generic
> linuxbox backports-3.15-rc1-1 # uname -a
> Linux linuxbox 3.13.0-24-generic #47-Ubuntu SMP Fri May 2 23:30:00 UTC
> 2014 x86_64 x86_64 x86_64 GNU/Linux
> linuxbox backports-3.15-rc1-1 #
> 
> 
> 
> CC [M] /usr/src/backports-3.15-rc1-1/net/mac80211/vht.o
> CC [M] /usr/src/backports-3.15-rc1-1/net/mac80211/ibss.o
> CC [M] /usr/src/backports-3.15-rc1-1/net/mac80211/iface.o
> /usr/src/backports-3.15-rc1-1/net/mac80211/iface.c:1080:2: warning:
> initialization from incompatible pointer type [enabled by default]
> .ndo_select_queue = ieee80211_netdev_select_queue,
> ^
> /usr/src/backports-3.15-rc1-1/net/mac80211/iface.c:1080:2: warning:
> (near initialization for ‘ieee80211_dataif_ops.ndo_select_queue’)
> [enabled by default]
> /usr/src/backports-3.15-rc1-1/net/mac80211/iface.c:1122:2: warning:
> initialization from incompatible pointer type [enabled by default]
> .ndo_select_queue = ieee80211_monitor_select_queue,
> ^
> /usr/src/backports-3.15-rc1-1/net/mac80211/iface.c:1122:2: warning:
> (near initialization for ‘ieee80211_monitorif_ops.ndo_select_queue’)
> [enabled by default]
> CC [M] /usr/src/backports-3.15-rc1-1/net/mac80211/rate.o
> CC [M] /usr/src/backports-3.15-rc1-1/net/mac80211/michael.o
> CC [M] /usr/src/backports-3.15-rc1-1/net/mac80211/tkip.o
> CC [M] /usr/src/backports-3.15-rc1-1/net/mac80211/aes_ccm.o
> CC [M] /usr/src/backports-3.15-rc1-1/net/mac80211/aes_cmac.o
> 
> 
> When I use backports-3.16-rc1 I get the same warnings:
> 
> CC [M] /usr/src/backports-3.16-rc1-1/net/mac80211/agg-rx.o
> CC [M] /usr/src/backports-3.16-rc1-1/net/mac80211/vht.o
> CC [M] /usr/src/backports-3.16-rc1-1/net/mac80211/ibss.o
> CC [M] /usr/src/backports-3.16-rc1-1/net/mac80211/iface.o
> /usr/src/backports-3.16-rc1-1/net/mac80211/iface.c:1099:2: warning:
> initialization from incompatible pointer type [enabled by default]
> .ndo_select_queue = ieee80211_netdev_select_queue,
> ^
> /usr/src/backports-3.16-rc1-1/net/mac80211/iface.c:1099:2: warning:
> (near initialization for ‘ieee80211_dataif_ops.ndo_select_queue’)
> [enabled by default]
> /usr/src/backports-3.16-rc1-1/net/mac80211/iface.c:1141:2: warning:
> initialization from incompatible pointer type [enabled by default]
> .ndo_select_queue = ieee80211_monitor_select_queue,
> ^
> /usr/src/backports-3.16-rc1-1/net/mac80211/iface.c:1141:2: warning:
> (near initialization for ‘ieee80211_monitorif_ops.ndo_select_queue’)
> [enabled by default]
> CC [M] /usr/src/backports-3.16-rc1-1/net/mac80211/rate.o
> CC [M] /usr/src/backports-3.16-rc1-1/net/mac80211/michael.o
> CC [M] /usr/src/backports-3.16-rc1-1/net/mac80211/tkip.o
> CC [M] /usr/src/backports-3.16-rc1-1/net/mac80211/aes_ccm.o
> ^Cmake[6]: *** [/usr/src/backports-3.16-rc1-1/net/mac80211/aes_ccm.o]
> Interrupt
> make[5]: *** [/usr/src/backports-3.16-rc1-1/net/mac80211] Interrupt
> make[4]: *** [_module_/usr/src/backports-3.16-rc1-1] Interrupt
> 
> 
> The reference in iface.c contains:
> #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
> static u16 ieee80211_netdev_select_queue(struct net_device *dev,
> struct sk_buff *skb,
> void *accel_priv,
> select_queue_fallback_t fallback)
> #elif LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
> static u16 ieee80211_netdev_select_queue(struct net_device *dev,
> struct sk_buff *skb,
> void *accel_priv)
> #else
> static u16 ieee80211_netdev_select_queue(struct net_device *dev,
> struct sk_buff *skb)
> #endif
> 
> The linux 3.13 net_device_ops structure has the following arguments for
> ndo_select_queue:
> struct net_device_ops {
> int (*ndo_init)(struct net_device *dev);
> void (*ndo_uninit)(struct net_device *dev);
> int (*ndo_open)(struct net_device *dev);
> int (*ndo_stop)(struct net_device *dev);
> netdev_tx_t (*ndo_start_xmit) (struct sk_buff *skb,
> struct net_device *dev);
> u16 (*ndo_select_queue)(struct net_device *dev,
> struct sk_buff *skb,
> void *accel_priv,
> select_queue_fallback_t fallback);
> 
> When I modify the ifdefs for the function to include the fallback
> argument, iface.c compiles without warnings. I accomplish this by
> changing the ifdef:
> 
> #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
> to
> 
> #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
> 
> 
> and the original select_queue function I modify the ifdef to:
> #if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
> 
> 
> I also do this for the ieee80211_monitor_select_queue function
> definiations.
> 
> It looks like these conditionals are not aligned properly to the kernel
> versions.
> 
> 
> Thanks in advance
> Clyde
> 

This is fixed in backports-20140710.

Hauke

