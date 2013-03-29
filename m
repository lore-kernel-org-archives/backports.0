Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:33581 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755604Ab3C2SGk convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 29 Mar 2013 14:06:40 -0400
Received: by mail-ie0-f173.google.com with SMTP id 9so789147iec.18
        for <backports@vger.kernel.org>; Fri, 29 Mar 2013 11:06:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAB=NE6XSh1Ox2PVMhH4+6sW7UJ73kXuxvzU=eLZz=pGoR==POQ@mail.gmail.com>
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
Date: Fri, 29 Mar 2013 19:06:39 +0100
Message-ID: <CAKprTDEf_WYg-fqwmh1Ngi5fysbqQ47JvEbRhhN0PhScn1kqoA@mail.gmail.com> (sfid-20130329_190648_282448_1D331716)
Subject: Re: brcmsmac: Unknown symbol backport_cordic_calc_iq (err 0)
From: =?ISO-8859-1?Q?Camale=F3n?= <noelamac@gmail.com>
To: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

El 2013-03-29 a las 10:33 -0700, Luis R. Rodriguez escribió:

> On Fri, Mar 29, 2013 at 9:51 AM, Camaleón <noelamac@gmail.com> wrote:

(...)

> > I'm afraid I spoke too soon. It disconnected a couple of minutes ago ;-(
>
> OK now your are using wireless-testing so lets separate the issues. Go
> now report you are using wireless-testing and e-mail all the
> maintainers of the driver (listed on MAINTAINERS but for your
> convenience I'll paste them here) and Cc linux-wireess and explain
> your issue in detail.
>
> BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER
> M:      Brett Rudley <brudley@broadcom.com>
> M:      Arend van Spriel <arend@broadcom.com>
> M:      Franky (Zhenhui) Lin <frankyl@broadcom.com>
> M:      Hante Meuleman <meuleman@broadcom.com>
> L:      linux-wireless@vger.kernel.org
> L:      brcm80211-dev-list@broadcom.com
> S:      Supported
> F:      drivers/net/wireless/brcm80211/

Yes, this is already done, thanks for suggesting. Let's focus here the
compat-drivers freeze issue.

> As for the backport issue can you try the new release?
>
> https://www.kernel.org/pub/linux/kernel/projects/backports/2013/03/28/

Sure... it compiles with some warnings:

WARNING: /lib/modules/3.9.0-rc2/updates/drivers/net/wireless/brcm80211/brcmsmac/brcmsmac.ko
needs unknown symbol bcma_chipco_get_alp_clock
WARNING: /lib/modules/3.9.0-rc2/updates/drivers/net/wireless/brcm80211/brcmsmac/brcmsmac.ko
needs unknown symbol bcma_chipco_gpio_outen
WARNING: /lib/modules/3.9.0-rc2/updates/drivers/net/wireless/brcm80211/brcmsmac/brcmsmac.ko
needs unknown symbol bcma_chipco_gpio_out

And then fails when loading:

[ 3534.031747] compat-drivers backport release: compat-drivers-2013-03-28-2-u
[ 3534.031758] Backport based on linux-next.git next-20130328
[ 3534.031763] compat.git: linux-next.git
[ 3534.059984] cfg80211: Calling CRDA to update world regulatory domain
[ 3534.110047] cfg80211: World regulatory domain updated:
[ 3534.110059] cfg80211:   (start_freq - end_freq @ bandwidth),
(max_antenna_gain, max_eirp)
[ 3534.110068] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)
[ 3534.110076] cfg80211:   (2457000 KHz - 2482000 KHz @ 20000 KHz),
(300 mBi, 2000 mBm)
[ 3534.110083] cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz),
(300 mBi, 2000 mBm)
[ 3534.110091] cfg80211:   (5170000 KHz - 5250000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)
[ 3534.110097] cfg80211:   (5735000 KHz - 5835000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)
[ 3534.114133] bcma: bus0: Found chip with id 0x4313, rev 0x01 and package 0x08
[ 3534.114182] bcma: bus0: Core 0 found: ChipCommon (manuf 0x4BF, id
0x800, rev 0x24, class 0x0)
[ 3534.114219] bcma: bus0: Core 1 found: IEEE 802.11 (manuf 0x4BF, id
0x812, rev 0x18, class 0x0)
[ 3534.114275] bcma: bus0: Core 2 found: PCIe (manuf 0x4BF, id 0x820,
rev 0x11, class 0x0)
[ 3534.127246] bcma: bus0: Bus registered
[ 3534.146255] brcmsmac: Unknown symbol bcma_chipco_get_alp_clock (err 0)
[ 3534.146365] brcmsmac: Unknown symbol bcma_chipco_gpio_outen (err 0)
[ 3534.146479] brcmsmac: Unknown symbol bcma_chipco_gpio_out (err 0)

Greetings,

-- 
Camaleón
