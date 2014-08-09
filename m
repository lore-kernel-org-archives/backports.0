Return-path: <backports-owner@vger.kernel.org>
Received: from test.hauke-m.de ([5.39.93.123]:44953 "EHLO test.hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751650AbaHIO4J (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 9 Aug 2014 10:56:09 -0400
Message-ID: <53E63687.3080200@hauke-m.de> (sfid-20140809_165613_037406_CC392BA9)
Date: Sat, 09 Aug 2014 16:56:07 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Stefan Assmann <sassmann@kpanic.de>, backports@vger.kernel.org
CC: mcgrof@do-not-panic.com
Subject: Re: [PATCH] backports: irq_get_trigger_type requires CONFIG_HAVE_GENERIC_HARDIRQS=y
References: <1407499226-24011-1-git-send-email-sassmann@kpanic.de>
In-Reply-To: <1407499226-24011-1-git-send-email-sassmann@kpanic.de>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 08/08/2014 02:00 PM, Stefan Assmann wrote:
> Only backport irq_get_trigger_type on architectures that have
> CONFIG_HAVE_GENERIC_HARDIRQS=y. Otherwise we end up with:
> 
> In file included from drivers/pci/msi.c:11:0:
> backport/backport-include/linux/irq.h: In function 'irq_get_trigger_type':
> backport/backport-include/linux/irq.h:9:9: error: implicit declaration
> of function 'irq_get_irq_data' [-Werror=implicit-function-declaration]
>   struct irq_data *d = irq_get_irq_data(irq);
> 
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> ---
>  backport/backport-include/linux/irq.h | 2 ++
>  1 file changed, 2 insertions(+)

Thank you for the patch, it was applied and pushed out.

Hauke

