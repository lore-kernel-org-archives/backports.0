Return-path: <backports-owner@vger.kernel.org>
Received: from iwavesystems.com ([207.32.180.10]:41745 "EHLO
	sip2-98.nexcess.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751069AbbKKLcr (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 11 Nov 2015 06:32:47 -0500
Message-ID: <20151111063247.203429dxmv42uelb@iwavesystems.com> (sfid-20151111_123250_169384_3C30ACCA)
Date: Wed, 11 Nov 2015 06:32:47 -0500
From: anjalik@iwavesystems.com
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: backports@vger.kernel.org
Subject: Re: Realtek RTL8192DU Driver and Android LOllipop
References: <20151109054901.52833inkm5vggbh9@iwavesystems.com>
 <5640C86D.2090804@lwfinger.net>
In-Reply-To: <5640C86D.2090804@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,

  Thanks for the quick response. The driver is working fine. I tested  
Open, WEP mode and WPA2 is yet to be tested since iwpriv is not  
working as it is deprecated. I would like to ask a query regarding the  
firmware

1.Which is the firmware to be used ,rtl8192dufw.bin or rtl8192dufw_wol.bin ?

I guess the firmware is rtl8192dufw.bin or do both the binaries  
together take care of firmware functionalities.?

In the previous driver which I used,the firmware image was embedded  
one. Even without using the above binaries , everything is working  
fine. Is it really required to copy these binaries under  
system/lib/firmware path.?

I am using Dual Band USB 2.O Wi-Fi Adaptor with RTL8192DU chipset.

Thanks & Regards,
Anjali

Quoting Larry Finger <Larry.Finger@lwfinger.net>:

> On 11/09/2015 04:49 AM, anjalik@iwavesystems.com wrote:
>> Hi ,
>>
>>  I am working on a project on Android Lollipop and I need to use  
>> Realtek Wi-Fi
>> Driver RTL8192DU . The Linux kernel version used in Android  
>> LOllipop is 3.10.53.
>> And I am getting compile time error during the ko file generation  
>> due to many
>> deperecated APIS used in the driver.
>>
>> Have u released or worked on Realtek Wi-Fi Driver RTL8192DU for the above
>> mentioned Linux kernel?
>
> Backports can only backport drivers that are in the kernel. For  
> several reasons, the driver for RTL8192DU has never been submitted  
> for inclusion.
>
> The vendor driver for your device has been updated for later kernels  
> and posted at http://github.com/lwfinger/rtl8192du.git. If that one  
> does not build on your 3.10 kernel, please report an issue for it at  
> GitHub.
>
> Larry
>
>
>


--
To unsubscribe from this list: send the line "unsubscribe backports" in
