Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:37306 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957Ab3KDW24 (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 4 Nov 2013 17:28:56 -0500
Message-ID: <52781F9D.1090900@hauke-m.de> (sfid-20131104_232857_713208_D6360078)
Date: Mon, 04 Nov 2013 23:28:45 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: James Hilliard <james.hilliard1@gmail.com>
CC: "backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: Backporting codel
References: <CADvTj4oYwoF=hRo4WYGHBar9-trR7iJ32EtD_dHCLFYC49ruog@mail.gmail.com>
In-Reply-To: <CADvTj4oYwoF=hRo4WYGHBar9-trR7iJ32EtD_dHCLFYC49ruog@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 11/04/2013 05:50 PM, James Hilliard wrote:
> I was wondering if you might have any suggestions on how to backport the
> sch_codel and sch_fq_codel modules to kernel version 2.6.22, it looks
> like it is only compatible down to 2.6.25 so far. This would be useful
> for broadcom routers running on firmware variants based on the broadcom
> SDK kernel.

Hi James,

backports currently does not support any kernel older than 2.6.25. There
was support for kernel 2.6.24 some time ago, and it could be that it is
not too hard to make sch_codel and sch_fq_codel work with kernel 2.6.22.

You should try to build it against that old kernel and try to fix the
problems you get. You should remove all the other stuff you do not need
like wireless from backports.

Hauke
