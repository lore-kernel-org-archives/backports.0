Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:59646 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757351AbaJaTDS (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 31 Oct 2014 15:03:18 -0400
Message-ID: <5453DCF4.9040101@broadcom.com> (sfid-20141031_200320_380602_111DE3FB)
Date: Fri, 31 Oct 2014 20:03:16 +0100
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Renato <renatoriolino@gmail.com>
CC: <backports@vger.kernel.org>
Subject: Re: compat-drivers-3.8.3-2-snpu with kernel 2.6.24
References: <CAG_2TMdYXqO5bRC7gmjY-yZzw-KJQDc2bzsGKj6cdygYPGW1Jw@mail.gmail.com>
In-Reply-To: <CAG_2TMdYXqO5bRC7gmjY-yZzw-KJQDc2bzsGKj6cdygYPGW1Jw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 10/31/14 19:40, Renato wrote:
> Hi,
>
> I have and old Linux system built from scratch based on kernel 2.6.24
> and I need to add support on it for an Atheros ethernet card that
> doesnt have driver for kernel 2.6.24.
>
> Unfortunately we can't update the kernel because my client has a
> control hardware that only have binary e propertery driver for 2.6.24.
>
> Because of that, I'm trying to use compat-drivers to do that.
>
> What I did so far was:
>
> Downloaded compat-drivers-3.8.3-2-snpu and extraceted it.
> Compiled it using:
>
> ./scripts/driver-select alx
> make
> make install
>
> After rebooting, I loaded the compat driver with:
>
> modprobe compat
>
> I can see the following on dmesg:
>
> Compat-drivers backport release: compat-drivers-v3.8.3-2-snpu
> Backport based on linux-stable.git v3.8.3
> compat.git: linux-stable.git
>
> Nothing more. And no eth yet.
>
> What I am missing?

After loading compat you have the glue layer in place to load the actual 
3.8.3 drivers on 2.6.24. So your next step would be to modprobe the alx 
driver or whatever it is called.

Regards,
Arend
> Thanks
> --
> To unsubscribe from this list: send the line "unsubscribe backports" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

