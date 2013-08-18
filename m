Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:51196 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603Ab3HRHFU (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 18 Aug 2013 03:05:20 -0400
Received: by mail-pd0-f173.google.com with SMTP id p10so3769376pdj.32
        for <backports@vger.kernel.org>; Sun, 18 Aug 2013 00:05:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CA+XVXfdc9baMQzATby4Hs6ivCgxegyYTzrmosQMC6Hqdft19=g@mail.gmail.com>
References: <1376674003-5801-1-git-send-email-hauke@hauke-m.de>
 <1376674003-5801-2-git-send-email-hauke@hauke-m.de> <CA+XVXfdc9baMQzATby4Hs6ivCgxegyYTzrmosQMC6Hqdft19=g@mail.gmail.com>
From: Arik Nemtsov <arik@wizery.com>
Date: Sun, 18 Aug 2013 10:05:04 +0300
Message-ID: <CA+XVXfeC1oWU6RiE9BShwsHj8NdA68KiPeW0dRZb_rkc4wfeNw@mail.gmail.com> (sfid-20130818_090524_767266_4E932325)
Subject: Re: [PATCH 02/13] backports: fix conditional include of arch_phys_wc_add()
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: mcgrof@gmail.com, backports@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, Aug 16, 2013 at 10:32 PM, Arik Nemtsov <arik@wizery.com> wrote:
> On Fri, Aug 16, 2013 at 8:26 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>> This fixes a problem introduced in this commit:
>> commit c871780b5afa182878884bf5ccd8df4817a2660f
>> Author: Arik Nemtsov <arik@wizery.com>
>> Date:   Wed Aug 14 10:48:05 2013 +0300
>>
>>     backports: rename some mem functions to not break custom kernels
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> Cc: Arik Nemtsov <arik@wizery.com>
>
> Thanks for the fix (again). Indeed it was stupid of me to make the
> #ifndef redundant.
> I'll test it on my setup next week.

Ok. This doesn't work for me, and it's pretty obvious why that I look
at the code. I'm using a custom 3.9 kernel that contains the patch
adding "arch_phys_wc_add".

If indeed "arch_phys_wc_add" is defined (as is my case), we don't
enter the clause at all and the LINUX_BACKPORT() definition doesn't
happen.
But the code in backport-3.11.c does the following anyway:

EXPORT_SYMBOL_GPL(arch_phys_wc_add);

So we still get the exported symbol "arch_phys_wc_add", clashing with
the kernel's.
Maybe some new define should be added to the backports header file to
control when backport-3.11.c exports the symbol?

Something in io.h along the lines of:

#ifndef arch_phys_wc_add
#define BACKPORTS_DEFINE_arch_phys_wc_add
...

and then condition the symbol export in the .c file on
BACKPORTS_DEFINE_arch_phys_wc_add.

Arik
