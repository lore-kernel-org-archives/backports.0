Return-path: <backports-owner@vger.kernel.org>
Received: from iwavesystems.com ([207.32.180.10]:42554 "EHLO
	sip2-98.nexcess.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750908AbbKLFkv (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 12 Nov 2015 00:40:51 -0500
Message-ID: <20151112004050.12203drgwuatm1k2@iwavesystems.com> (sfid-20151112_064053_223648_1B96E315)
Date: Thu, 12 Nov 2015 00:40:50 -0500
From: anjalik@iwavesystems.com
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: backports@vger.kernel.org
Subject: Re: Realtek RTL8192DU Driver and Android LOllipop
References: <20151109054901.52833inkm5vggbh9@iwavesystems.com>
 <5640C86D.2090804@lwfinger.net>
 <20151111063247.203429dxmv42uelb@iwavesystems.com>
 <564377B6.6040306@lwfinger.net>
In-Reply-To: <564377B6.6040306@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,

  I am currently working with the firmware copied to the  
"system/lib/firmware/rtlwifi/" path in the target SD card. So from  
your mail I understood that the firmware must not be omitted .(but  
still wondering how it worked without the firmware in my initial  
testing.)

Thank you for the explanation provided for the querries.

Thanks & Regards,
Anjali.

Quoting Larry Finger <Larry.Finger@lwfinger.net>:

> On 11/11/2015 05:32 AM, anjalik@iwavesystems.com wrote:
>> Hi,
>>
>>  Thanks for the quick response. The driver is working fine. I  
>> tested Open, WEP
>> mode and WPA2 is yet to be tested since iwpriv is not working as it is
>> deprecated. I would like to ask a query regarding the firmware
>>
>> 1.Which is the firmware to be used ,rtl8192dufw.bin or rtl8192dufw_wol.bin ?
>>
>> I guess the firmware is rtl8192dufw.bin or do both the binaries  
>> together take
>> care of firmware functionalities.?
>>
>> In the previous driver which I used,the firmware image was embedded  
>> one. Even
>> without using the above binaries , everything is working fine. Is it really
>> required to copy these binaries under system/lib/firmware path.?
>>
>> I am using Dual Band USB 2.O Wi-Fi Adaptor with RTL8192DU chipset.
>
> The firmware with "wol" in its name is for Wake-On-Lan operation.  
> The feature requires special configuration, and I have not tested  
> it. At startup, the driver will load one or the other. If WOL is not  
> enabled, only the regular firmware will be used. I extracted both  
> versions before I eliminated the embedded data.
>
> Adding a driver with embedded firmware to the standard kernel is  
> frowned upon due to the several thousand lines of data. That is the  
> reason that I extracted the firmware, and converted the driver to  
> use external firmware. If your version of the driver has been  
> converted, then you need at least the standard firmware in the  
> /lib/firmware/ tree.
>
> Larry
>
>
>


--
To unsubscribe from this list: send the line "unsubscribe backports" in
