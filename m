Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ia0-f180.google.com ([209.85.210.180]:36159 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756712Ab3C2UlF convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 29 Mar 2013 16:41:05 -0400
Received: by mail-ia0-f180.google.com with SMTP id f27so658165iae.25
        for <backports@vger.kernel.org>; Fri, 29 Mar 2013 13:41:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKprTDEf_WYg-fqwmh1Ngi5fysbqQ47JvEbRhhN0PhScn1kqoA@mail.gmail.com>
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
	<CAKprTDHOO42s-wvr8mZGqxoB8BL986HxCTSJ0q9B=s5UHVmuQQ@mail.gmail.com>
	<CAKprTDES3t0p2117U9BwiCpTOzHPtvN_8RrQ4i1aTQCXa5nV7A@mail.gmail.com>
	<CAKprTDHOCOHw=Jc7rqFrhDXpOHMZ2OnH6+ps=fttTjZxc0o42g@mail.gmail.com>
	<CAB=NE6XSh1Ox2PVMhH4+6sW7UJ73kXuxvzU=eLZz=pGoR==POQ@mail.gmail.com>
	<CAKprTDEf_WYg-fqwmh1Ngi5fysbqQ47JvEbRhhN0PhScn1kqoA@mail.gmail.com>
Date: Fri, 29 Mar 2013 21:41:03 +0100
Message-ID: <CAKprTDEe8KGbft_z4PrM88HLffukq6Jr-hRgB3N1FqHWyBDnsw@mail.gmail.com> (sfid-20130329_214108_496007_41EDD2BF)
Subject: Re: brcmsmac: Unknown symbol backport_cordic_calc_iq (err 0)
From: =?ISO-8859-1?Q?Camale=F3n?= <noelamac@gmail.com>
To: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

2013/3/29 Camaleón <noelamac@gmail.com>:
> El 2013-03-29 a las 10:33 -0700, Luis R. Rodriguez escribió:

(...)

>> As for the backport issue can you try the new release?
>>
>> https://www.kernel.org/pub/linux/kernel/projects/backports/2013/03/28/
>
> Sure... it compiles with some warnings:
>
> WARNING: /lib/modules/3.9.0-rc2/updates/drivers/net/wireless/brcm80211/brcmsmac
                                       ^^^^^^^^^^

(...)

Sorry, my bad. That was another kernel O:-)

Okay, it works!

root@stt300:/home/hpc03/Escritorio/compat-drivers-2013-03-28-2-u# uname -r
3.9.0-rc4

[  577.510309] compat-drivers backport release: compat-drivers-2013-03-28-2-u
[  577.510324] Backport based on linux-next.git next-20130328
[  577.510332] compat.git: linux-next.git
[  577.544442] cfg80211: Calling CRDA to update world regulatory domain
[  577.578827] cfg80211: World regulatory domain updated:
[  577.578840] cfg80211:   (start_freq - end_freq @ bandwidth),
(max_antenna_gain, max_eirp)
[  577.578850] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)
[  577.578858] cfg80211:   (2457000 KHz - 2482000 KHz @ 20000 KHz),
(300 mBi, 2000 mBm)
[  577.578866] cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz),
(300 mBi, 2000 mBm)
[  577.578874] cfg80211:   (5170000 KHz - 5250000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)
[  577.578882] cfg80211:   (5735000 KHz - 5835000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)
[  577.609596] brcmsmac bcma0:0: mfg 4bf core 812 rev 24 class 0 irq 17
[  577.654496] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
[  577.657428] cfg80211: Calling CRDA for country: US
[  577.687167] cfg80211: Regulatory domain changed to country: US
[  577.687180] cfg80211:   (start_freq - end_freq @ bandwidth),
(max_antenna_gain, max_eirp)
[  577.687189] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz),
(300 mBi, 2700 mBm)
[  577.687197] cfg80211:   (5170000 KHz - 5250000 KHz @ 40000 KHz),
(300 mBi, 1700 mBm)
[  577.687205] cfg80211:   (5250000 KHz - 5330000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)
[  577.687214] cfg80211:   (5490000 KHz - 5600000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)
[  577.687222] cfg80211:   (5650000 KHz - 5710000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)
[  577.687231] cfg80211:   (5735000 KHz - 5835000 KHz @ 40000 KHz),
(300 mBi, 3000 mBm)
[  577.750198] brcmsmac bcma0:0: brcms_ops_bss_info_changed: qos
enabled: false (implement)
[  577.750216] brcmsmac bcma0:0: brcms_ops_config: change power-save
mode: false (implement)
[  577.750507] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
[  579.157734] wlan0: authenticate with 00:1a:2b:97:7a:97
[  579.159633] wlan0: send auth to 00:1a:2b:97:7a:97 (try 1/3)
[  579.161535] wlan0: authenticated
[  579.164698] wlan0: associate with 00:1a:2b:97:7a:97 (try 1/3)
[  579.182316] wlan0: RX AssocResp from 00:1a:2b:97:7a:97 (capab=0x411
status=0 aid=2)
[  579.182956] brcmsmac bcma0:0: brcmsmac: brcms_ops_bss_info_changed:
associated
[  579.182980] brcmsmac bcma0:0: brcms_ops_bss_info_changed: qos
enabled: true (implement)
[  579.183021] wlan0: associated
[  579.183141] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
[  579.295495] brcmsmac bcma0:0: brcms_ops_bss_info_changed: arp
filtering: 1 addresses (implement)
[  607.019875] brcmsmac bcma0:0: phyerr 0x10, rate 0x6e
[  607.019913] brcmsmac bcma0:0: brcms_c_ampdu_dotxstatus_complete:
ampdu tx phy error (0x10)
[  607.020227] brcmsmac bcma0:0: phyerr 0x10, rate 0x6e
[  607.020240] brcmsmac bcma0:0: brcms_c_ampdu_dotxstatus_complete:
ampdu tx phy error (0x10)

This one does not makes my system to freeze (I'm now browsing the web
using the compat-drivers). Yeeah! A bunch of thanks, Luis.

Greetings,

-- 
Camaleón
