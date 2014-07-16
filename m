Return-path: <backports-owner@vger.kernel.org>
Received: from vms173025pub.verizon.net ([206.46.173.25]:37588 "EHLO
	vms173025pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540AbaGPVaW (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 16 Jul 2014 17:30:22 -0400
MIME-version: 1.0
Content-type: text/plain; charset=windows-1252; format=flowed
Received: from [192.168.1.2] ([unknown] [173.66.161.182])
 by vms173025.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0N8T004KRNLQZDH0@vms173025.mailsrvcs.net> for
 backports@vger.kernel.org; Wed, 16 Jul 2014 15:29:51 -0500 (CDT)
Message-id: <53C6E0BE.9070800@verizon.net> (sfid-20140716_233025_245154_7D0435A4)
Date: Wed, 16 Jul 2014 16:29:50 -0400
From: "C. McPherson" <ccmcphe@verizon.net>
To: backports@vger.kernel.org
Subject: Backport issue net/mac80211/iface.c
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

When I build backports-3.15-rc1-1 I get the following warnings (my linux 
kernel version is 3.13.0-24) Mint 17:

Here is my version information:
linuxbox backports-3.15-rc1-1 # uname -r
3.13.0-24-generic
linuxbox backports-3.15-rc1-1 # uname -a
Linux linuxbox 3.13.0-24-generic #47-Ubuntu SMP Fri May 2 23:30:00 UTC 
2014 x86_64 x86_64 x86_64 GNU/Linux
linuxbox backports-3.15-rc1-1 #



CC [M] /usr/src/backports-3.15-rc1-1/net/mac80211/vht.o
CC [M] /usr/src/backports-3.15-rc1-1/net/mac80211/ibss.o
CC [M] /usr/src/backports-3.15-rc1-1/net/mac80211/iface.o
/usr/src/backports-3.15-rc1-1/net/mac80211/iface.c:1080:2: warning: 
initialization from incompatible pointer type [enabled by default]
.ndo_select_queue = ieee80211_netdev_select_queue,
^
/usr/src/backports-3.15-rc1-1/net/mac80211/iface.c:1080:2: warning: 
(near initialization for ‘ieee80211_dataif_ops.ndo_select_queue’) 
[enabled by default]
/usr/src/backports-3.15-rc1-1/net/mac80211/iface.c:1122:2: warning: 
initialization from incompatible pointer type [enabled by default]
.ndo_select_queue = ieee80211_monitor_select_queue,
^
/usr/src/backports-3.15-rc1-1/net/mac80211/iface.c:1122:2: warning: 
(near initialization for ‘ieee80211_monitorif_ops.ndo_select_queue’) 
[enabled by default]
CC [M] /usr/src/backports-3.15-rc1-1/net/mac80211/rate.o
CC [M] /usr/src/backports-3.15-rc1-1/net/mac80211/michael.o
CC [M] /usr/src/backports-3.15-rc1-1/net/mac80211/tkip.o
CC [M] /usr/src/backports-3.15-rc1-1/net/mac80211/aes_ccm.o
CC [M] /usr/src/backports-3.15-rc1-1/net/mac80211/aes_cmac.o


When I use backports-3.16-rc1 I get the same warnings:

CC [M] /usr/src/backports-3.16-rc1-1/net/mac80211/agg-rx.o
CC [M] /usr/src/backports-3.16-rc1-1/net/mac80211/vht.o
CC [M] /usr/src/backports-3.16-rc1-1/net/mac80211/ibss.o
CC [M] /usr/src/backports-3.16-rc1-1/net/mac80211/iface.o
/usr/src/backports-3.16-rc1-1/net/mac80211/iface.c:1099:2: warning: 
initialization from incompatible pointer type [enabled by default]
.ndo_select_queue = ieee80211_netdev_select_queue,
^
/usr/src/backports-3.16-rc1-1/net/mac80211/iface.c:1099:2: warning: 
(near initialization for ‘ieee80211_dataif_ops.ndo_select_queue’) 
[enabled by default]
/usr/src/backports-3.16-rc1-1/net/mac80211/iface.c:1141:2: warning: 
initialization from incompatible pointer type [enabled by default]
.ndo_select_queue = ieee80211_monitor_select_queue,
^
/usr/src/backports-3.16-rc1-1/net/mac80211/iface.c:1141:2: warning: 
(near initialization for ‘ieee80211_monitorif_ops.ndo_select_queue’) 
[enabled by default]
CC [M] /usr/src/backports-3.16-rc1-1/net/mac80211/rate.o
CC [M] /usr/src/backports-3.16-rc1-1/net/mac80211/michael.o
CC [M] /usr/src/backports-3.16-rc1-1/net/mac80211/tkip.o
CC [M] /usr/src/backports-3.16-rc1-1/net/mac80211/aes_ccm.o
^Cmake[6]: *** [/usr/src/backports-3.16-rc1-1/net/mac80211/aes_ccm.o] 
Interrupt
make[5]: *** [/usr/src/backports-3.16-rc1-1/net/mac80211] Interrupt
make[4]: *** [_module_/usr/src/backports-3.16-rc1-1] Interrupt


The reference in iface.c contains:
#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
static u16 ieee80211_netdev_select_queue(struct net_device *dev,
struct sk_buff *skb,
void *accel_priv,
select_queue_fallback_t fallback)
#elif LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
static u16 ieee80211_netdev_select_queue(struct net_device *dev,
struct sk_buff *skb,
void *accel_priv)
#else
static u16 ieee80211_netdev_select_queue(struct net_device *dev,
struct sk_buff *skb)
#endif

The linux 3.13 net_device_ops structure has the following arguments for 
ndo_select_queue:
struct net_device_ops {
int (*ndo_init)(struct net_device *dev);
void (*ndo_uninit)(struct net_device *dev);
int (*ndo_open)(struct net_device *dev);
int (*ndo_stop)(struct net_device *dev);
netdev_tx_t (*ndo_start_xmit) (struct sk_buff *skb,
struct net_device *dev);
u16 (*ndo_select_queue)(struct net_device *dev,
struct sk_buff *skb,
void *accel_priv,
select_queue_fallback_t fallback);

When I modify the ifdefs for the function to include the fallback 
argument, iface.c compiles without warnings. I accomplish this by 
changing the ifdef:

#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
to

#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)


and the original select_queue function I modify the ifdef to:
#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)


I also do this for the ieee80211_monitor_select_queue function definiations.

It looks like these conditionals are not aligned properly to the kernel 
versions.


Thanks in advance
Clyde


