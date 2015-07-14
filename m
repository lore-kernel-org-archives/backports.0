Return-path: <backports-owner@vger.kernel.org>
Received: from cluster-d.mailcontrol.com ([85.115.60.190]:34850 "EHLO
	cluster-d.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbbGNFgJ convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 14 Jul 2015 01:36:09 -0400
From: Arunkumar K <Arunkumar.K@csr.com>
To: Arend van Spriel <arend@broadcom.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: RE: Query regarding back porting of upstreamed Linux kernel drivers
Date: Tue, 14 Jul 2015 05:35:52 +0000
Message-ID: <4fb66ea0da5940858c5f81362410ab68@BANASIEXM02.ASIA.ROOT.PRI> (sfid-20150714_073611_439451_0CAB1976)
References: <b43797e602f34e10a7924f0d3b6a1368@BANASIEXM02.ASIA.ROOT.PRI>
 <559FC80A.6090209@broadcom.com>
In-Reply-To: <559FC80A.6090209@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Thanks for your response Arend.

Regards,
Arun

-----Original Message-----
From: Arend van Spriel [mailto:arend@broadcom.com] 
Sent: 10 July 2015 18:57
To: Arunkumar K; backports@vger.kernel.org
Subject: Re: Query regarding back porting of upstreamed Linux kernel drivers

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
>  From the following page 
> https://backports.wiki.kernel.org/index.php/Main_Page
>
> "Current versions of backports support all mainline kernels starting with version 3.0, for kernel versions older than 3.0 please use backports-3.14, which supports all kernel versions back to 2.6.26."
>
> Suppose we have release backports-4.2 and new driver has been backported. Will it have support only till kernel version 3.0. Suppose if the new driver needs to be supported in version 2.6.32 what is the process followed?

That is a problem that backports can not solve. So you could manually backport your new driver into the backport-3.14 tarball to minimize your effort.

Regards,
Arend

> Regards,
> Arun
>
>
>
> Member of the CSR plc group of companies. CSR plc registered in 
> England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
> You can now access the wide range of products powered by aptX at 
> www.aptx.com
> --
> To unsubscribe from this list: send the line "unsubscribe backports" 
> in
>



 To report this email as spam click https://www.mailcontrol.com/sr/71ZG6X1WMXbGX2PQPOmvUqW!RI4xIDLrpnWLJ2TOncz1J54P8Pz2BYKVEZWF1MWbmXpsabQE6AvgE3KctAewCA== .
--
To unsubscribe from this list: send the line "unsubscribe backports" in
