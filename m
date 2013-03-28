MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <CAKprTDGZAzLMGTYw0sY+oW+T3uX8WNh98oXkjcX+Cf5LEwYTHA@mail.gmail.com>
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
Date: Thu, 28 Mar 2013 11:22:16 -0700
Message-ID: <CAB=NE6UqpfTgK=EAeQL_FmxtP7qC=FetiwLDs+ORix4jazet2A@mail.gmail.com>
Subject: Re: brcmsmac: Unknown symbol backport_cordic_calc_iq (err 0)
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
To: =?UTF-8?B?Q2FtYWxlw7Nu?= <noelamac@gmail.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Thu, Mar 28, 2013 at 9:24 AM, Camale=C3=B3n <noelamac@gmail.com> wrote:
> 2013/3/28 Camale=C3=B3n <noelamac@gmail.com>:
>
> (...)
>
>> Thanks for the explanation. Now awaiting for "git clone" ends its job.
>
> Okay, I managed to install the generated kernel:
>
> root@stt300:/home/hpc03/wireless-testing# uname -r
> 3.9.0-rc4
>
> But it seems no brcmsmac modules was created:
>
> root@stt300:/home/hpc03/wireless-testing# modprobe brcmsmac
> FATAL: Module brcmsmac not found.

make menuconfig

Then go to

Device Drivers -->
  Network device support -->
    Wireless LAN  --->
      Broadcom IEEE802.11n PCIe SoftMAC WLAN driver

Hit space on that one until you get an <M>. Then exit, a few times, it
will as you to save, say yes. Then run make, and after that make
install.

  Luis
