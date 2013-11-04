Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:37348 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750749Ab3KDWiP (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 4 Nov 2013 17:38:15 -0500
Message-ID: <527821CF.3060007@hauke-m.de> (sfid-20131104_233818_295397_902654FE)
Date: Mon, 04 Nov 2013 23:38:07 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: James Hilliard <james.hilliard1@gmail.com>
CC: "backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: Backporting codel
References: <CADvTj4oYwoF=hRo4WYGHBar9-trR7iJ32EtD_dHCLFYC49ruog@mail.gmail.com>	<52781F9D.1090900@hauke-m.de> <CADvTj4r+bHifuTc-whK_TQK7e=iDFUX+HTWLrrOKYGfwunuKyQ@mail.gmail.com>
In-Reply-To: <CADvTj4r+bHifuTc-whK_TQK7e=iDFUX+HTWLrrOKYGfwunuKyQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 11/04/2013 11:32 PM, James Hilliard wrote:
> Should I attempt to build the regular version or the version from the
> backports package?

It is probably easier to use the version from backports.

Hauke

> 
> 
> On Mon, Nov 4, 2013 at 4:28 PM, Hauke Mehrtens <hauke@hauke-m.de
> <mailto:hauke@hauke-m.de>> wrote:
> 
>     On 11/04/2013 05:50 PM, James Hilliard wrote:
>     > I was wondering if you might have any suggestions on how to
>     backport the
>     > sch_codel and sch_fq_codel modules to kernel version 2.6.22, it looks
>     > like it is only compatible down to 2.6.25 so far. This would be useful
>     > for broadcom routers running on firmware variants based on the
>     broadcom
>     > SDK kernel.
> 
>     Hi James,
> 
>     backports currently does not support any kernel older than 2.6.25. There
>     was support for kernel 2.6.24 some time ago, and it could be that it is
>     not too hard to make sch_codel and sch_fq_codel work with kernel 2.6.22.
> 
>     You should try to build it against that old kernel and try to fix the
>     problems you get. You should remove all the other stuff you do not need
>     like wireless from backports.
> 
>     Hauke
> 
> 

