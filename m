Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:45446 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755253Ab3C2Rdo convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 29 Mar 2013 13:33:44 -0400
Received: by mail-lb0-f173.google.com with SMTP id w20so490367lbh.18
        for <backports@vger.kernel.org>; Fri, 29 Mar 2013 10:33:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKprTDHOCOHw=Jc7rqFrhDXpOHMZ2OnH6+ps=fttTjZxc0o42g@mail.gmail.com>
References: <CAB=NE6Wbym4XksV=uKz9eZD0rZwmtS3ZfP-zbXg9TAc2+2+Z9g@mail.gmail.com>
 <CAKprTDEEEdy++Bk5AY4Zfrtwsc9HOKGQ+uWR58PFCWU=v+PE1g@mail.gmail.com>
 <CAB=NE6UtuxuTduYhDy5BcPap-rri+P1mcKYr2KEjAbuE2FU13g@mail.gmail.com>
 <20130327175711.GA8794@stt008.linux.site> <CAKprTDFspW4B2tk9EZPBBXy3C6gL_NJsjwj-bUeYj1rN3j6sYg@mail.gmail.com>
 <CAB=NE6W6Ey8iU1vs=XfA7Or0wF=Qh6Gu8zF-DxMatgk-V+wdkQ@mail.gmail.com>
 <CAKprTDFJet+m7RmkZt5uyf=FMyEYciCYUahEcCC6_ukRQ2pjgw@mail.gmail.com>
 <CAB=NE6VzvVkFvGaudZHQTM5R3s05QV5Jw23wZ_DLxkNf00Utdg@mail.gmail.com>
 <20130328104030.GA4602@stt008.linux.site> <CAB=NE6V=AnTabh3p_yY+GmzPo-+GLAdzEBTQMm4VN1xUuVm_sw@mail.gmail.com>
 <20130328111250.GA4671@stt008.linux.site> <CAKprTDGZAzLMGTYw0sY+oW+T3uX8WNh98oXkjcX+Cf5LEwYTHA@mail.gmail.com>
 <CAB=NE6UqpfTgK=EAeQL_FmxtP7qC=FetiwLDs+ORix4jazet2A@mail.gmail.com>
 <CAKprTDHOO42s-wvr8mZGqxoB8BL986HxCTSJ0q9B=s5UHVmuQQ@mail.gmail.com>
 <CAKprTDES3t0p2117U9BwiCpTOzHPtvN_8RrQ4i1aTQCXa5nV7A@mail.gmail.com> <CAKprTDHOCOHw=Jc7rqFrhDXpOHMZ2OnH6+ps=fttTjZxc0o42g@mail.gmail.com>
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Date: Fri, 29 Mar 2013 10:33:22 -0700
Message-ID: <CAB=NE6XSh1Ox2PVMhH4+6sW7UJ73kXuxvzU=eLZz=pGoR==POQ@mail.gmail.com> (sfid-20130329_183353_920485_628FEE41)
Subject: Re: brcmsmac: Unknown symbol backport_cordic_calc_iq (err 0)
To: =?UTF-8?B?Q2FtYWxlw7Nu?= <noelamac@gmail.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, Mar 29, 2013 at 9:51 AM, Camaleón <noelamac@gmail.com> wrote:
> 2013/3/29 Camaleón <noelamac@gmail.com>:
>
>> Well, after manually setting channel 11 for the AP (it was set to
>> "auto") and removing any previous information from N-M I'm right now
>> successfully connecetd to the AP since 15 minutes and still not
>> disconnected. This looks very promising :-D
>
> I'm afraid I spoke too soon. It disconnected a couple of minutes ago ;-(

OK now your are using wireless-testing so lets separate the issues. Go
now report you are using wireless-testing and e-mail all the
maintainers of the driver (listed on MAINTAINERS but for your
convenience I'll paste them here) and Cc linux-wireess and explain
your issue in detail.

BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER
M:      Brett Rudley <brudley@broadcom.com>
M:      Arend van Spriel <arend@broadcom.com>
M:      Franky (Zhenhui) Lin <frankyl@broadcom.com>
M:      Hante Meuleman <meuleman@broadcom.com>
L:      linux-wireless@vger.kernel.org
L:      brcm80211-dev-list@broadcom.com
S:      Supported
F:      drivers/net/wireless/brcm80211/

As for the backport issue can you try the new release?

https://www.kernel.org/pub/linux/kernel/projects/backports/2013/03/28/

  Luis
