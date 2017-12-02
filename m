Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:52484 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752121AbdLBU2L (ORCPT
        <rfc822;backports@vger.kernel.org>); Sat, 2 Dec 2017 15:28:11 -0500
Message-ID: <1512246489.26976.6.camel@sipsolutions.net> (sfid-20171202_212813_379502_73F01EEF)
Subject: Re: Cross-compiling wifi driver on Android
From: Johannes Berg <johannes@sipsolutions.net>
To: Remington Furman <remicles2@gmail.com>, backports@vger.kernel.org
Date: Sat, 02 Dec 2017 21:28:09 +0100
In-Reply-To: <043841bf-92f4-e240-ea3b-2ae6946aae66@gmail.com> (sfid-20171202_173104_365595_E4B4EAD5)
References: <41f0fd53-25ef-420e-8ef8-f24498b8118e@gmail.com>
         <1512202131.26976.4.camel@sipsolutions.net>
         <043841bf-92f4-e240-ea3b-2ae6946aae66@gmail.com>
         (sfid-20171202_173104_365595_E4B4EAD5)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,

> Thank you very much.  That tip to follow the dependencies helped a lot.  
> I had been using "/" before, but just learned you can type the numbers 
> in parenthesis in the search results to jump to them. Saves a lot of time.

Hah, nice trick, I wasn't aware of that either :-)

Thanks!

> After working recursively through the dependencies for the backports 
> menuconfig option I wanted (RTL8192CU) I found out that CPTCFG_MAC80211 
> wasn't appearing as an option in backports because my target kernel did 
> not satisfy it's dependencies for CRYPTO_CCM, CRYPTO_GCM, and 
> CRYPTO_CMAC.  After enabling those on my target kernel, CPTCFG_MAC80211 
> appeared and I could enable everything in backports down to my desired 
> driver.

Ah, yes, I should've guessed that, but forgot that the driver needs
mac80211 at all. I had attempted to backport these (crypto) at some
point, but it's very tricky.

Glad you could sort it out :)

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
