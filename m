Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:53178 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742Ab3HAHyd (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 1 Aug 2013 03:54:33 -0400
Received: by mail-lb0-f176.google.com with SMTP id w10so1259929lbi.21
        for <backports@vger.kernel.org>; Thu, 01 Aug 2013 00:54:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51F99AC6.8080909@gmail.com>
References: <51F99AC6.8080909@gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Thu, 1 Aug 2013 00:54:11 -0700
Message-ID: <CAB=NE6WyGTYtMZ60VPadoCEgur+LV3CKRWTWjzadaJ--2eEj3Q@mail.gmail.com> (sfid-20130801_095435_087679_6A5A1541)
Subject: Re: What if kernel CONFIG=Y or CONFIG=N and backports CONFIG=M?
To: Leon Woestenberg <sidebranch.linux@gmail.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, Jul 31, 2013 at 4:16 PM, Leon Woestenberg
<sidebranch.linux@gmail.com> wrote:
> Hello all,
>
> two questions (I am new to the backports project):
>
> If I configure backports to build a driver as a module, whilst the kernel we
> build against (KLIB/KLIB_BUILD) has this driver built-in, what is supposed
> to happen?

Well backports currently only allows =m for itself but non-modular
support is theoretically possible [0] and should be considered if its
a requirement.

[0] https://backports.wiki.kernel.org/index.php/Documentation/backports/hacking/todo#Non_modular_backport_support

Patches welcome :D lets kill stupid silly branching efforts on kernel
management efforts.

> Obviously I cannot load the backport module into the kernel.
>
>
> Is it possible (within the kernel and backports code) to build a subsystem
> or driver as a module, if the original kernel did not have this subsystem or
> driver built at all ("N" in the menu, CONFIG_ commented out in .config)?

Yes, however if the subsystem required certain requirements those
requirements will still be required. For example say your backported
driver needed CONFIG_PCI but you didn't enable it, CONFIG_PCI would
still be required.

> Can the kernel always load modules that were defined as =N during the kernel
> built itself?

Yes. Consider the case of *new* modules that were not available in
older kernels. We support that.

  Luis
