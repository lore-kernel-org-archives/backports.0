Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:52202 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751989AbdLFVSg (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 6 Dec 2017 16:18:36 -0500
Message-ID: <1512595113.26976.36.camel@sipsolutions.net> (sfid-20171206_221838_403405_6E657CEC)
Subject: Re: Errors backporting to 3.4
From: Johannes Berg <johannes@sipsolutions.net>
To: Michael McElroy <mikem388@gmail.com>, backports@vger.kernel.org
Date: Wed, 06 Dec 2017 22:18:33 +0100
In-Reply-To: <CAJt7DwwqoJMWk1=-BO5O+cfutLfTwE04oYo46GqcMhb9zgGwPA@mail.gmail.com> (sfid-20171205_172916_304793_B93BEC9D)
References: <CAJt7DwwqoJMWk1=-BO5O+cfutLfTwE04oYo46GqcMhb9zgGwPA@mail.gmail.com>
         (sfid-20171205_172916_304793_B93BEC9D)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,

So, frankly, we haven't been maintaining < 3.10 or so well.

> I tried building against various kernels and didn't find
> netdev_upper_dev_link' defined until 3, so anything less that that probably
> has this error.  I didn't know exactly what to use here so I just did an
> #if 0 around that section and resolved the problem for me.

IIRC we did the same in our internal tree, it simply can't be done on
earlier kernels - Luca, care to send that out?

> The second problem is in commit 2ebca7b7d087be04e25b1fc50cf08137d423af3d.
> 
> Author: Luca Coelho <luciano.coelho@intel.com>
> Date:   Tue Apr 19 22:13:11 2016 +0300
> 
>     backport: add pm_runtime_active() implementation for < 3.9 kernels

Oi, that's pretty old.

> In linux/pm.h, those members addition to the struct are controlled by
> CONFIG_PM_RUNTIME, not CONFIG_PM. I changed pm_runtime.h to
> use CONFIG_PM_RUNTIME and that resolved the problem.

Interesting. Can you send the patch?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
