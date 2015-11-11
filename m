Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:36840 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591AbbKKQzf (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 11 Nov 2015 11:55:35 -0500
Received: by obdgf3 with SMTP id gf3so26293193obd.3
        for <backports@vger.kernel.org>; Wed, 11 Nov 2015 08:55:35 -0800 (PST)
Subject: Re: Realtek RTL8192DU Driver and Android LOllipop
To: anjalik@iwavesystems.com
References: <20151109054901.52833inkm5vggbh9@iwavesystems.com>
 <5640C86D.2090804@lwfinger.net>
 <20151111063247.203429dxmv42uelb@iwavesystems.com>
Cc: backports@vger.kernel.org
From: Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <56437303.6090901@lwfinger.net> (sfid-20151111_175538_241309_B1D8ED6D)
Date: Wed, 11 Nov 2015 10:55:31 -0600
MIME-Version: 1.0
In-Reply-To: <20151111063247.203429dxmv42uelb@iwavesystems.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 11/11/2015 05:32 AM, anjalik@iwavesystems.com wrote:
> Hi,
>
>   Thanks for the quick response. The driver is working fine. I tested Open, WEP
> mode and WPA2 is yet to be tested since iwpriv is not working as it is
> deprecated. I would like to ask a query regarding the firmware
>
> 1.Which is the firmware to be used ,rtl8192dufw.bin or rtl8192dufw_wol.bin ?
>
> I guess the firmware is rtl8192dufw.bin or do both the binaries together take
> care of firmware functionalities.?
>
> In the previous driver which I used,the firmware image was embedded one. Even
> without using the above binaries , everything is working fine. Is it really
> required to copy these binaries under system/lib/firmware path.?
>
> I am using Dual Band USB 2.O Wi-Fi Adaptor with RTL8192DU chipset.

The "wol" part is for Wake On Lan. You need to configure the source specially to 
use that feature, which I have not tested. I expect that you only need 
rtl8192dufw.bin.

The firmware files came from the embedded data in the Realtek standard driver. 
When submitting a driver for inclusion in the kernel, having embedded firmware 
is frowned upon, thus the reason for extracting it. If you use the driver 
version after the firmware was removed, then you need the firmware in the 
standard path.

Larry


--
To unsubscribe from this list: send the line "unsubscribe backports" in
