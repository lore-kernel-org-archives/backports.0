Return-path: <backports-owner@vger.kernel.org>
Received: from app1b.xlhost.de ([84.200.252.162]:52658 "EHLO app1b.xlhost.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752854AbaDWK1f (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Apr 2014 06:27:35 -0400
Message-ID: <53579593.40306@kpanic.de> (sfid-20140423_122737_920373_E36F87A8)
Date: Wed, 23 Apr 2014 12:27:31 +0200
From: Stefan Assmann <sassmann@kpanic.de>
MIME-Version: 1.0
To: Julia Lawall <julia.lawall@lip6.fr>
CC: "backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: cocci: multiple versions of function with different arguments
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi Julia,

I'm trying to generate a patch to define a function with different
arguments depending on the kernel version. I'm having some difficulties,
maybe you can tell me what's wrong with the following approach.

@ rule1 @
struct net_device_ops ops;
identifier vlan_rx_add_vid_func;
@@
ops.ndo_vlan_rx_add_vid = vlan_rx_add_vid_func;

@ rule2 @
identifier rule1.vlan_rx_add_vid_func;
expression a,b,c;
@@
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
        vlan_rx_add_vid_func(a, b, c)
+#else
+       vlan_rx_add_vid_func(a, c)
+#endif


This results in
spatch --sp-file test3.cocci drivers/net/ethernet/intel/igb/igb_main.c
init_defs_builtins: /usr/local/share/coccinelle/standard.h
282 302
Fatal error: exception Failure("plus: parse error:
 = File "test3.cocci", line 14, column 2,  charpos = 282
    around = 'vlan_rx_add_vid_func', whole content = +  vlan_rx_add_vid_func(a, c)
")


If I remove "vlan_rx_add_vid_func(a, c)" it works, but that defeats the
whole idea.

Thanks!

  Stefan
