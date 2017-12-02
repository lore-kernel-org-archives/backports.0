Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:45064 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751519AbdLBIIx (ORCPT
        <rfc822;backports@vger.kernel.org>); Sat, 2 Dec 2017 03:08:53 -0500
Message-ID: <1512202131.26976.4.camel@sipsolutions.net> (sfid-20171202_090902_798234_0982F0D6)
Subject: Re: Cross-compiling wifi driver on Android
From: Johannes Berg <johannes@sipsolutions.net>
To: Remington Furman <remicles2@gmail.com>, backports@vger.kernel.org
Date: Sat, 02 Dec 2017 09:08:51 +0100
In-Reply-To: <41f0fd53-25ef-420e-8ef8-f24498b8118e@gmail.com> (sfid-20171202_014451_466599_433CD4CB)
References: <41f0fd53-25ef-420e-8ef8-f24498b8118e@gmail.com>
         (sfid-20171202_014451_466599_433CD4CB)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2017-12-01 at 16:44 -0800, Remington Furman wrote:

> That succeeds and shows me a menu.  However, '<M> USB Network
> Adapters ----' is an empty menu and the rtl8192cu driver I am
> after is not available.  Enabling CPTCFG_WLAN_VENDOR_REALTEK in
> 'make menuconfig' doesn't lead to any other options.

In menuconfig, hit "/" and search for (part of) the symbol you want
(e.g. "RTL8192"), and check the dependencies.

It really only has one though "depends on USB", which is weird. Check
it there.

> If I understand this page correctly, I need to first disable
> conflicting drivers in my target kernel .config before running
> 'make menuconfig' in backports.
> <https://backports.wiki.kernel.org/index.php/Documentation/integration#Kernel_integration_menuconfig>
> I've tried a number of target kernel configurations, but haven't
> found a combination that makes backports happy yet.  I've disable
> CONFIG_CFG80211 and CONFIG_WLAN, but no luck.

You don't want integration, so I think you can ignore that page.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
