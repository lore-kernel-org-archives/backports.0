Return-path: <backports-owner@vger.kernel.org>
Received: from iwavesystems.com ([207.32.180.10]:49179 "EHLO
	sip2-98.nexcess.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750893AbbK1G6r (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 28 Nov 2015 01:58:47 -0500
Message-ID: <20151128015846.19244qyj5g66hb52@iwavesystems.com> (sfid-20151128_075856_174988_6284C4D1)
Date: Sat, 28 Nov 2015 01:58:46 -0500
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

Hi ,

  I have a doubt regarding the WPS support in the driver u shared.

  I was testing WPS Push button, the device connected once with the AP  
and it was pinging fine too. But later the connection is getting  
disconnected immediately ,hardly within seconds. I captured the frames  
and the sequence number has some variation from normal working case  
(My android phone and the same AP).

AP sends EAPOL key packey to client with sequence number 0

Client sends EAPOL key packet to cleint with sequence number 1  
(working case it is zero)


Again the AP sends EAPOl key packet with sequence number 1

But Client sends EAPOL key packet with sequence number 2 (working case  
it is 1)


I am not able to find out the exact reason for the DEAUTH event  
received right after the connection. The sniffer capture showing the  
reason as "Unspecified reason".

Awaiting for your suggestion .


Thanks & Regards,
Anjali


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
