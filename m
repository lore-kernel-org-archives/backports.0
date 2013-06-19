Return-path: <backports-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:49817 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933869Ab3FSR73 (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 19 Jun 2013 13:59:29 -0400
Received: from mailout-de.gmx.net ([10.1.76.16]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0MRhah-1UiOXh1M4X-00Sy5P for
 <backports@vger.kernel.org>; Wed, 19 Jun 2013 19:59:28 +0200
Message-ID: <51C1F17D.5050604@gmx.de> (sfid-20130619_195931_723430_21C7D67C)
Date: Wed, 19 Jun 2013 19:59:25 +0200
From: Lars Zastrow <Lars.Zastrow@gmx.de>
MIME-Version: 1.0
To: Stanislaw Gruszka <sgruszka@redhat.com>
CC: backports@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: Re: bug-report: Ralink corp. Device [1814:539a] - Kernel 3.8
 +
References: <51BE8008.20302@gmx.de> <20130619131234.GB2580@redhat.com>
In-Reply-To: <20130619131234.GB2580@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Am 19.06.2013 15:12, schrieb Stanislaw Gruszka:
> On Mon, Jun 17, 2013 at 05:18:32AM +0200, Lars Zastrow wrote:
>> Dear Team,
>>
>> I'am using the following wireless-network-device:
>>
>> Network controller [0280]: Ralink corp. Device [1814:539a]
>> Subsystem: Hewlett-Packard Company Device [103c:1839]
>> Kernel driver in use: rt2800pci
>>
>> I had problems with it since I bought my laptop... The driver was
>> unstable with the kernel I used back in autumn 2012. Howeverer, one
>> kernel-update fixed it. Must be something about 3.4x?
>>
>> It was defenetly working with the Kernels from 3.5 till 3.7 on
>> multible distros. 3.8 was bringing back the old Problems:
>>
>> - extremly low signal
>> - hard to establish a connection to any acess-point.
>>
>> The last "problematic" kernel I have testet was 3.9.5-1 on
>> Arch-Linux. Compiling the compat-drivers manually did not bring any
>> fix.
>>
>> I am currently using 3.7.4-1 wich is working.
> This most likely is a RT5390 TX power problem I made on 3.8.
>
> This patch should help:
> https://git.kernel.org/cgit/linux/kernel/git/linville/wireless.git/commit/?id=8c8d2017ba25c510ddf093419048460db1109bc4
>
> Stanislaw
Yes, indeed! It helps.

Now it was possible to upgrade my kernel, without losing my 
wireless-device to be usable. Thank you very much.

I'm afraid it is not a "flawless" experience.

On the git-page you mentioned:

 > Once we implement proper TSSI tuning on 5390/3290 we can restore back 
setting TX power by BBP_R1  register for those chips.

Is there any hope, that the driver will increase its performance one day?
...there are better chips on the market, that is for sure.

Regards

Lars Zastrow
