Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ia0-f181.google.com ([209.85.210.181]:48013 "EHLO
	mail-ia0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753687Ab3C2O3d convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 29 Mar 2013 10:29:33 -0400
Received: by mail-ia0-f181.google.com with SMTP id o25so442889iad.12
        for <backports@vger.kernel.org>; Fri, 29 Mar 2013 07:29:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAB=NE6UqpfTgK=EAeQL_FmxtP7qC=FetiwLDs+ORix4jazet2A@mail.gmail.com>
References: <CAB=NE6Wbym4XksV=uKz9eZD0rZwmtS3ZfP-zbXg9TAc2+2+Z9g@mail.gmail.com>
	<CAKprTDEEEdy++Bk5AY4Zfrtwsc9HOKGQ+uWR58PFCWU=v+PE1g@mail.gmail.com>
	<CAB=NE6UtuxuTduYhDy5BcPap-rri+P1mcKYr2KEjAbuE2FU13g@mail.gmail.com>
	<20130327175711.GA8794@stt008.linux.site>
	<CAKprTDFspW4B2tk9EZPBBXy3C6gL_NJsjwj-bUeYj1rN3j6sYg@mail.gmail.com>
	<CAB=NE6W6Ey8iU1vs=XfA7Or0wF=Qh6Gu8zF-DxMatgk-V+wdkQ@mail.gmail.com>
	<CAKprTDFJet+m7RmkZt5uyf=FMyEYciCYUahEcCC6_ukRQ2pjgw@mail.gmail.com>
	<CAB=NE6VzvVkFvGaudZHQTM5R3s05QV5Jw23wZ_DLxkNf00Utdg@mail.gmail.com>
	<20130328104030.GA4602@stt008.linux.site>
	<CAB=NE6V=AnTabh3p_yY+GmzPo-+GLAdzEBTQMm4VN1xUuVm_sw@mail.gmail.com>
	<20130328111250.GA4671@stt008.linux.site>
	<CAKprTDGZAzLMGTYw0sY+oW+T3uX8WNh98oXkjcX+Cf5LEwYTHA@mail.gmail.com>
	<CAB=NE6UqpfTgK=EAeQL_FmxtP7qC=FetiwLDs+ORix4jazet2A@mail.gmail.com>
Date: Fri, 29 Mar 2013 15:29:32 +0100
Message-ID: <CAKprTDHOO42s-wvr8mZGqxoB8BL986HxCTSJ0q9B=s5UHVmuQQ@mail.gmail.com> (sfid-20130329_152938_487080_C5E4DBD2)
Subject: Re: brcmsmac: Unknown symbol backport_cordic_calc_iq (err 0)
From: =?ISO-8859-1?Q?Camale=F3n?= <noelamac@gmail.com>
To: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

2013/3/28 Luis R. Rodriguez <mcgrof@frijolero.org>:
> On Thu, Mar 28, 2013 at 9:24 AM, Camaleón <noelamac@gmail.com> wrote:

>> Okay, I managed to install the generated kernel:
>>
>> root@stt300:/home/hpc03/wireless-testing# uname -r
>> 3.9.0-rc4
>>
>> But it seems no brcmsmac modules was created:
>>
>> root@stt300:/home/hpc03/wireless-testing# modprobe brcmsmac
>> FATAL: Module brcmsmac not found.
>
> make menuconfig
>
> Then go to
>
> Device Drivers -->
>   Network device support -->
>     Wireless LAN  --->
>       Broadcom IEEE802.11n PCIe SoftMAC WLAN driver
>
> Hit space on that one until you get an <M>. Then exit, a few times, it
> will as you to save, say yes. Then run make, and after that make
> install.

Okay, thanks... yes, the .config lacked from "brcmsmac" driver and
thus it was not compiled with it. This is now solved :-)

root@stt300:~# uname -r; modinfo brcmsmac
3.9.0-rc4
filename:
/lib/modules/3.9.0-rc4/kernel/drivers/net/wireless/brcm80211/brcmsmac/brcmsmac.ko
firmware:       brcm/bcm43xx_hdr-0.fw
firmware:       brcm/bcm43xx-0.fw
license:        Dual BSD/GPL
description:    Broadcom 802.11n wireless LAN driver.
author:         Broadcom Corporation
alias:          bcma:m04BFid0812rev18cl*
alias:          bcma:m04BFid0812rev17cl*
alias:          bcma:m04BFid0812rev11cl*
depends:        mac80211,bcma,brcmutil,cfg80211,cordic
intree:         Y
vermagic:       3.9.0-rc4 SMP mod_unload modversions 686

Curiously enough, loading the module does not makes the system to
freeze. In fact, I can even get associated with the AP without much
hassle (!) but I still experience the same behaviuor than using the
stock drivers from kernel 3.9.0-rc2 (wlan0 is up but pings are
rejected).

[  203.787669] wlan0: authenticate with 00:1a:2b:97:7a:97
[  203.787847] wlan0: send auth to 00:1a:2b:97:7a:97 (try 1/3)
[  203.804524] wlan0: authenticated
[  203.808282] wlan0: associate with 00:1a:2b:97:7a:97 (try 1/3)
[  203.886215] wlan0: RX AssocResp from 00:1a:2b:97:7a:97 (capab=0x411
status=0 aid=1)
[  203.886784] brcmsmac bcma0:0: brcmsmac: brcms_ops_bss_info_changed:
associated
[  203.886795] brcmsmac bcma0:0: brcms_ops_bss_info_changed: qos
enabled: true (implement)
[  203.886813] wlan0: associated
[  210.067594] brcmsmac bcma0:0: brcms_ops_bss_info_changed: arp
filtering: 1 addresses (implement)
[  323.206432] brcmsmac bcma0:0: brcms_c_ampdu_dotxstatus_complete:
Pkt tx suppressed, illegal channel possibly 1
[  323.206606] brcmsmac bcma0:0: brcms_c_ampdu_dotxstatus_complete:
Pkt tx suppressed, illegal channel possibly 1
[  323.206777] brcmsmac bcma0:0: brcms_c_ampdu_dotxstatus_complete:
Pkt tx suppressed, illegal channel possibly 1
[  323.206870] brcmsmac bcma0:0: brcms_c_ampdu_dotxstatus_complete:
Pkt tx suppressed, illegal channel possibly 1
[  323.206915] brcmsmac bcma0:0: brcms_c_ampdu_dotxstatus_complete:
Pkt tx suppressed, illegal channel possibly 1
[  323.206951] brcmsmac bcma0:0: brcms_c_ampdu_dotxstatus_complete:
Pkt tx suppressed, illegal channel possibly 1
[  325.829738] brcmsmac bcma0:0: brcms_c_ampdu_dotxstatus_complete:
Pkt tx suppressed, illegal channel possibly 5

Well, the important here is that compat-drivers freeze the system and
these ones do work fine, so Luis, if you want me to run some tests,
just tell.

Greetings,

-- 
Camaleón
