Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:44966 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932282AbbGJN0g (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 10 Jul 2015 09:26:36 -0400
Message-ID: <559FC80A.6090209@broadcom.com> (sfid-20150710_152638_388509_059DB58A)
Date: Fri, 10 Jul 2015 15:26:34 +0200
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Arunkumar K <Arunkumar.K@csr.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: Query regarding back porting of upstreamed Linux kernel drivers
References: <b43797e602f34e10a7924f0d3b6a1368@BANASIEXM02.ASIA.ROOT.PRI>
In-Reply-To: <b43797e602f34e10a7924f0d3b6a1368@BANASIEXM02.ASIA.ROOT.PRI>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 07/10/2015 01:22 PM, Arunkumar K wrote:
> Hi,
>
> I have the following queries regarding back porting of up-streamed Linux kernel driver:
>
> Suppose a new driver is added to Linux mainline in release 4.2, will the developer who added new driver to the mainline need to submit the changes for back porting to the backports git?
>
> Or will the backports project team be doing the back porting of the new driver?

Guess the one with most incentive will do it.

>
>  From the following page https://backports.wiki.kernel.org/index.php/Main_Page
>
> "Current versions of backports support all mainline kernels starting with version 3.0, for kernel versions older than 3.0 please use backports-3.14, which supports all kernel versions back to 2.6.26."
>
> Suppose we have release backports-4.2 and new driver has been backported. Will it have support only till kernel version 3.0. Suppose if the new driver needs to be supported in version 2.6.32 what is the process followed?

That is a problem that backports can not solve. So you could manually 
backport your new driver into the backport-3.14 tarball to minimize your 
effort.

Regards,
Arend

> Regards,
> Arun
>
>
>
> Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
> More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
> You can now access the wide range of products powered by aptX at www.aptx.com
> --
> To unsubscribe from this list: send the line "unsubscribe backports" in
>

--
To unsubscribe from this list: send the line "unsubscribe backports" in
