Return-path: <backports-owner@vger.kernel.org>
Received: from mail01.echostar.com ([139.85.4.20]:41278 "EHLO
	chapzsmtp1.echostar.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751163AbaJ1JCh convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 28 Oct 2014 05:02:37 -0400
From: "Paramahamsa, Viplav" <Viplav.Paramaham@slingmedia.com>
To: Hauke Mehrtens <hauke@hauke-m.de>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
CC: "Raikar, Yatish" <yatishjnr@slingmedia.com>
Subject: RE: Backports - v3.18-rc1 build problems
Date: Tue, 28 Oct 2014 09:02:35 +0000
Message-ID: <65B68BAF3C31D54B9A10B0592C9E025B9050F9B2@CHWPIEXC10.SATS.CORP> (sfid-20141028_100242_103244_A7AD9F06)
References: <65B68BAF3C31D54B9A10B0592C9E025B9050D73C@CHWPIEXC10.SATS.CORP>
 <544F56D1.6040603@hauke-m.de>
In-Reply-To: <544F56D1.6040603@hauke-m.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi Hauke,
	I am actually trying to find a driver for vendor ID : 625, product ID : 1026 & firmware 3.0 for linux kernel version - 2.6.35.
Backports-3.14.22-1 & earlier releases doesn't support this product ID. Backports - v3.18-rc1 seem to have the support for the device but doesn't seem to be building for 2.6.35.

Is there a plan to support this kernel version for this device?

Is there any restrictions or compatibility issues on 2.6.x kernels to support this device?

Regards,
Viplav

-----Original Message-----
From: Hauke Mehrtens [mailto:hauke@hauke-m.de] 
Sent: Tuesday, October 28, 2014 2:12 PM
To: Paramahamsa, Viplav; backports@vger.kernel.org
Cc: Raikar, Yatish
Subject: Re: Backports - v3.18-rc1 build problems

On 10/27/2014 02:39 PM, Paramahamsa, Viplav wrote:
> Hi All,
>                 I am facing build problems with latest release of backports - v3.18-rc1.
> 
> I am trying to cross compile with Freescale's LTIB. These are the details of the platform on which I am trying to build:
> Linux kernel version : 2.6.35
> ARCH : ARM
> Freescale BSP : L2.6.35_1.1.0_130130
> 
> This is the build command I am using : make 
> CROSS_COMPILE=/opt/freescale/usr/local/gcc-4.4.4-glibc-2.11.1-multilib
> -1.0/arm-fsl-linux-gnueabi/bin/arm-none-linux-gnueabi- ARCH=arm KLIB= 
> ${TOP}/rootfs/lib/modules/2.6.35.3-571-gcca29a0/ KLIB_BUILD= 
> ${TOP}/rpm/BUILD/linux/
> 
> PFA file which has compilation errors I am getting.
> I tried fixing these. But I was getting more errors in compat-3.x.x.c file compilation.
> 
> I am able to successfully compile an older version of backports - 3.10.17.
> 
> Please suggest how can I fix these errors. Is there any patch I need to apply to get rid of these? If yes, can you please provide the link for the same.
> 
> Regards,
> Viplav
> 

Hi Viplav,

starting with backports-3.15 we only support kernel versions >= 3.0. For kernel 3.6.35 you should try bcackports-3.14.22-1.

Hauke
