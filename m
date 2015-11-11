Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:35905 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239AbbKKRPh (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 11 Nov 2015 12:15:37 -0500
Received: by obdgf3 with SMTP id gf3so26767501obd.3
        for <backports@vger.kernel.org>; Wed, 11 Nov 2015 09:15:36 -0800 (PST)
Subject: Re: Realtek RTL8192DU Driver and Android LOllipop
To: anjalik@iwavesystems.com
References: <20151109054901.52833inkm5vggbh9@iwavesystems.com>
 <5640C86D.2090804@lwfinger.net>
 <20151111063247.203429dxmv42uelb@iwavesystems.com>
Cc: backports@vger.kernel.org
From: Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <564377B6.6040306@lwfinger.net> (sfid-20151111_181539_201566_228AB81C)
Date: Wed, 11 Nov 2015 11:15:34 -0600
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

The firmware with "wol" in its name is for Wake-On-Lan operation. The feature 
requires special configuration, and I have not tested it. At startup, the driver 
will load one or the other. If WOL is not enabled, only the regular firmware 
will be used. I extracted both versions before I eliminated the embedded data.

Adding a driver with embedded firmware to the standard kernel is frowned upon 
due to the several thousand lines of data. That is the reason that I extracted 
the firmware, and converted the driver to use external firmware. If your version 
of the driver has been converted, then you need at least the standard firmware 
in the /lib/firmware/ tree.

Larry


--
To unsubscribe from this list: send the line "unsubscribe backports" in
