Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:60683 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754562AbbLGMvQ (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 7 Dec 2015 07:51:16 -0500
Message-ID: <1449492673.4040.4.camel@sipsolutions.net> (sfid-20151207_135118_775197_23BEFD60)
Subject: Re: [PATCH v2] backports: add ktime_get_boot_ns()
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>,
	Arend van Spriel <arend@broadcom.com>,
	backports@vger.kernel.org
Date: Mon, 07 Dec 2015 13:51:13 +0100
In-Reply-To: <56620234.8010104@hauke-m.de>
References: <1449046594-9738-1-git-send-email-johannes@sipsolutions.net>
	 <1449046985.2449.0.camel@sipsolutions.net>
	 <1449047089.2449.1.camel@sipsolutions.net> <565EC8F7.4030800@broadcom.com>
	 <1449053189.2449.8.camel@sipsolutions.net> <56620234.8010104@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2015-12-04 at 22:14 +0100, Hauke Mehrtens wrote:
> 
> I am getting this error with your patch on kernel 4.3:
> 
> hauke@hauke-desktop:~/compat-wireless/tmp$ ionice -c 3 nice -n 20
> make V=99
>   CC [M]  /home/hauke/compat-wireless/tmp/compat/main.o
> In file included from include/linux/hrtimer.h:18:0,
>                  from
> /home/hauke/compat-wireless/tmp/backport-
> include/linux/timekeeping.h:5,
>                  from include/linux/ktime.h:297,
>                  from
> /home/hauke/compat-wireless/tmp/backport-include/linux/ktime.h:3,
>                  from include/linux/rcupdate.h:47,
>                  from
> /home/hauke/compat-wireless/tmp/backport-include/linux/rcupdate.h:3,
>                  from include/linux/srcu.h:33,
>                  from include/linux/notifier.h:15,
>                  from include/linux/memory_hotplug.h:6,
>                  from include/linux/mmzone.h:812,
>                  from include/linux/gfp.h:5,
>                  from
> /home/hauke/compat-wireless/tmp/backport-include/linux/gfp.h:3,
>                  from include/linux/kmod.h:22,
>                  from include/linux/module.h:13,
>                  from
> /home/hauke/compat-wireless/tmp/backport-include/linux/module.h:3,
>                  from /home/hauke/compat-
> wireless/tmp/compat/main.c:1:
> include/linux/rbtree.h: In function ‘rb_link_node_rcu’:
> include/linux/rbtree.h:95:2: error: implicit declaration of function
> ‘rcu_assign_pointer’ [-Werror=implicit-function-declaration]
>   rcu_assign_pointer(*rb_link, node);
>   ^
> 

Strange. I got different but similarly strange warnings though, I'll
send the patch I ended up using.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
