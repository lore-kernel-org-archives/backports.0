Return-path: <backports-owner@vger.kernel.org>
Received: from [89.91.64.97] ([89.91.64.97]:57814 "EHLO
	mailhost.actiasodielec.fr" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753005AbaCaHsi convert rfc822-to-8bit
	(ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 31 Mar 2014 03:48:38 -0400
From: Vu Hai NGUYEN <vh.nguyen@actiasodielec.fr>
To: Hauke Mehrtens <hauke@hauke-m.de>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
CC: Patrick CARNEIRO RODRIGUEZ <p.carneiro@actiasodielec.fr>
Date: Mon, 31 Mar 2014 09:46:49 +0200
Subject: RE : RE : Compilation backport ath10k on kernel 3.2.36
Message-ID: <EE97821C81277E459BEA5C6384C6F241012F06CC4836@srvexch01.SODIELEC.local> (sfid-20140331_094841_352240_0B8B6954)
References: <EE97821C81277E459BEA5C6384C6F241012D6BF72CC8@srvexch01.SODIELEC.local>,<87lhvy3ewa.fsf@kamboji.qca.qualcomm.com>,<EE97821C81277E459BEA5C6384C6F241012D6BF72CC9@srvexch01.SODIELEC.local>
 <EE97821C81277E459BEA5C6384C6F241012D6BF72CCA@srvexch01.SODIELEC.local>,<5332B428.30500@hauke-m.de>
 <EE97821C81277E459BEA5C6384C6F241012D76253EC8@srvexch01.SODIELEC.local>,<5337041A.70506@hauke-m.de>
In-Reply-To: <5337041A.70506@hauke-m.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,
If i desactivated the symbol CONFIG_AVERAGE and I look in the file Module.symsvers (output after compilation backport) , I saw backport_ewma_add and backport_ewma_init.
I thought if I didn't desactivatedf that symbol, it would use ewma_add and ewma_init?
I didn't rebuild the kernel , I just change the menuconfig and then re-compile the backports.
Should I look for the way to desactivate it from the menuconfig or just leave it, because it may create bugs or errors later?
Sincerely,


NGUYEN Vu Hai
Acita-Sodielec
Route de Mayres - B.P. 9
12100 St GEORGES DE LUZENCON
FRANCE

________________________________________
De : Hauke Mehrtens [hauke@hauke-m.de]
Date d'envoi : samedi 29 mars 2014 18:34
À : Vu Hai NGUYEN; backports@vger.kernel.org
Cc : Patrick CARNEIRO RODRIGUEZ
Objet : Re: RE : Compilation backport ath10k on kernel 3.2.36

Hi,

you are right it is better to use menuconfig to make changes to the config.

When CONFIG_AVERAGE is set in your kernel config, backports should use
the in kernel version.
Your kenrel config contains CONFIG_AVERAGE and you rebuild the kernel
after changing this config option in the kernel?

Hauke

On 03/26/2014 03:35 PM, Vu Hai NGUYEN wrote:
> Thank you Hauke Mehrtens for your response,
> I  did what you said but not by activating the symbol CONFIG_CRYPTO_CCM by hand (I mean opening the file .config and change it)  but from running the command"make menuconfig" and activate this parameter;
> Cryptographic API --> CCM Support
> I also activated other parameter in other to compile the driver ath10k (mac80211, cfg80211, atheros etc.)
> However I had another problem: The module output mac80211.ko that I created had 2 warnings:
> WARNING: "ewma_init" [/home/alberix2/Desktop/backports-3.13.2-1/net/mac80211/mac80211.ko] undefined!
> WARNING: "ewma_add" [/home/alberix2/Desktop/backports-3.13.2-1/net/mac80211/mac80211.ko] undefined!
> So If keep these warnings I cannot install the module to the system linux 3.2.36: these errors I saw from the command "dmesg":
> mac80211: Unknown symbol ewma_add (err 0)
> mac80211: Unknown symbol ewma_init (err 0)
> I found out that these functions was used in 2 files: rx.c and sta_info.c in the directory /net/mac80211  and included from average.h and average.c
> Then I look for the symbol CONFIG_AVERAGE and desactivated it by open the file .config and correct by hand (I was not able to desactivate it from the interface graphic (You can see it in the sceen shot)
> So I wonder if this function is important or not because if I desactived the symbol CONFIG_AVERAGE, my module mac80211.ko doesn't have any warnings like before and I can install this module in my linux 3.2.36.
> But I'm not sure that it won't create errors or bugs later because it doesn't know the function "ewma_init" and "ewma_add". I think by desactivating the symbol, I ignore that warning.
> Thank you in advanced for your response.
> Sincerely,
>
>
> NGUYEN Vu Hai
> Acita-Sodielec
> Route de Mayres - B.P. 9
> 12100 St GEORGES DE LUZENCON
> FRANCE
>
> ________________________________________
> De : Hauke Mehrtens [hauke@hauke-m.de]
> Date d'envoi : mercredi 26 mars 2014 12:04
> À : Vu Hai NGUYEN; backports@vger.kernel.org
> Cc : Patrick CARNEIRO RODRIGUEZ
> Objet : Re: Compilation backport ath10k on kernel 3.2.36
>
> On 03/25/2014 10:44 AM, Vu Hai NGUYEN wrote:
>> Hello everyone,
>> My PC run ubuntu 12.04 which has linux 3.2.0-60-generic-pae. But I need to cross compile the driver ath10k to put it on a PC cible (which has linux 3.2.36).
>
> This looks fine,
>
>> First I try to compile the backports-3.13.2-1 on kernel 3.2.55, I do it like below:
>> 1) I download backports-3.13.2-1 from http://drvbp1.linux-foundation.org/~mcgrof/rel-html/backports/  and kernel 3.2.55 from https://www.kernel.org/
>> 2) I build the kernel 3.2.55 by running make "menuconfig" and then "make".
>> 3) In the directory of backports-3.13.2-1 I run: "make defconfig-ath10k"  and "make ARCH=arm CROSS_COMPILE=/home/alberix2/Cross-Compiler/Marvell_toolchain_201201/armv7-marvell-linux-gnueabi-softfp_i686/bin/arm-marvell-linux-gnueabi- KLIB=/home/alberix2/Desktop/linux-3.2.55/ KLIB_BUILD=/home/alberix2/Desktop/linux-3.2.55/ -j 10"
>
> You should add the cross compile options also to the make
> defconfig-ath10k command, because you want a config based on the kernel
> your are cross compiling against and not your local kernel.
>
> CONFIG_CRYPTO_CCM has to be activates in your marvell kernel.
>
>> (If I don't do the 2 step (building  kernel 3.2.55) there are errors when I run make so I think it is mandatory to build the kernel before compile ath10 from backports?)
>> After 3 steps above I can obtain 6 module .ko of the driver ath10k which have vermagic: 3.2.55
>> Now when I try to compile ath10k on the kernel 3.2.36 (provided by marvell for my pc cible), I repeat 3  steps above but there is some warnings in 3th step when I run the command make (you can see it below my signature) and I obtain only 2 modules:
>> cfg80211.ko
>> compat.ko
>>
>> So I suppose that the my kernel 3.2.36 provided from marvell miss library to compiled ath10k. Do you guys have some ideas how to fix it?.
>> Thank you in advanced for your response.
>> Sincerely,
>>
>> NGUYEN Vu Hai
>> Acita-Sodielec
>> Route de Mayres - B.P. 9
>> 12100 St GEORGES DE LUZENCON
>> FRANCE
>>
>>
>> .config:142:warning: symbol value 'm' invalid for OPROFILE
>> .config:497:warning: symbol value 'm' invalid for INET_TUNNEL
>> .config:498:warning: symbol value 'm' invalid for INET_XFRM_MODE_TRANSPORT
>> .config:499:warning: symbol value 'm' invalid for INET_XFRM_MODE_TUNNEL
>> .config:500:warning: symbol value 'm' invalid for INET_XFRM_MODE_BEET
>> .config:502:warning: symbol value 'm' invalid for INET_DIAG
>> .config:503:warning: symbol value 'm' invalid for INET_TCP_DIAG
>> .config:529:warning: symbol value 'm' invalid for INET6_XFRM_MODE_TRANSPORT
>> .config:530:warning: symbol value 'm' invalid for INET6_XFRM_MODE_TUNNEL
>> .config:531:warning: symbol value 'm' invalid for INET6_XFRM_MODE_BEET
>> .config:533:warning: symbol value 'm' invalid for IPV6_SIT
>> .config:769:warning: symbol value 'm' invalid for STP
>> .config:771:warning: symbol value 'm' invalid for BRIDGE
>> .config:777:warning: symbol value 'm' invalid for VLAN_8021Q
>> .config:963:warning: symbol value 'm' invalid for MTD
>> .config:966:warning: symbol value 'm' invalid for MTD_CHAR
>> .config:968:warning: symbol value 'm' invalid for MTD_BLKDEVS
>> .config:969:warning: symbol value 'm' invalid for MTD_BLOCK
>> .config:980:warning: symbol value 'm' invalid for MTD_CFI
>> .config:981:warning: symbol value 'm' invalid for MTD_JEDECPROBE
>> .config:982:warning: symbol value 'm' invalid for MTD_GEN_PROBE
>> .config:988:warning: symbol value 'm' invalid for MTD_CFI_INTELEXT
>> .config:990:warning: symbol value 'm' invalid for MTD_CFI_STAA
>> .config:991:warning: symbol value 'm' invalid for MTD_CFI_UTIL
>> .config:996:warning: symbol value 'm' invalid for MTD_PHYSMAP
>> .config:1018:warning: symbol value 'm' invalid for MTD_M25P80
>> .config:1031:warning: symbol value 'm' invalid for MTD_NAND_ECC
>> .config:1032:warning: symbol value 'm' invalid for MTD_NAND
>> .config:1037:warning: symbol value 'm' invalid for MTD_NAND_IDS
>> .config:1052:warning: symbol value 'm' invalid for MTD_UBI
>> .config:1305:warning: symbol value 'm' invalid for SATA_MV
>> .config:1369:warning: symbol value 'm' invalid for MD_LINEAR
>> .config:1370:warning: symbol value 'm' invalid for MD_RAID0
>> .config:1371:warning: symbol value 'm' invalid for MD_RAID1
>> .config:1372:warning: symbol value 'm' invalid for MD_RAID10
>> .config:1373:warning: symbol value 'm' invalid for MD_RAID456
>> .config:1534:warning: symbol value 'm' invalid for E100
>> .config:1535:warning: symbol value 'm' invalid for E1000
>> .config:1536:warning: symbol value 'm' invalid for E1000E
>> .config:1560:warning: symbol value 'm' invalid for SKY2
>> .config:1852:warning: symbol value 'm' invalid for PHONE
>> .config:2146:warning: symbol value 'm' invalid for I2C_CHARDEV
>> .config:2323:warning: symbol value 'm' invalid for SENSORS_JC42
>> .config:2663:warning: symbol value 'm' invalid for SOUND
>> .config:2665:warning: symbol value 'm' invalid for SND
>> .config:2666:warning: symbol value 'm' invalid for SND_TIMER
>> .config:2667:warning: symbol value 'm' invalid for SND_PCM
>> .config:2852:warning: symbol value 'm' invalid for SND_SOC
>> .config:2853:warning: symbol value 'm' invalid for SND_SOC_I2C_AND_SPI
>> .config:2854:warning: symbol value 'm' invalid for SND_SOC_ALL_CODECS
>> .config:2856:warning: symbol value 'm' invalid for SND_SOC_WM_HUBS
>> .config:2857:warning: symbol value 'm' invalid for SND_SOC_AD1836
>> .config:2858:warning: symbol value 'm' invalid for SND_SOC_AD193X
>> .config:2859:warning: symbol value 'm' invalid for SND_SOC_AD73311
>> .config:2860:warning: symbol value 'm' invalid for SND_SOC_ADAU1373
>> .config:2861:warning: symbol value 'm' invalid for SND_SOC_ADAV80X
>> .config:2862:warning: symbol value 'm' invalid for SND_SOC_ADS117X
>> .config:2863:warning: symbol value 'm' invalid for SND_SOC_AK4104
>> .config:2864:warning: symbol value 'm' invalid for SND_SOC_AK4535
>> .config:2865:warning: symbol value 'm' invalid for SND_SOC_AK4641
>> .config:2866:warning: symbol value 'm' invalid for SND_SOC_AK4642
>> .config:2867:warning: symbol value 'm' invalid for SND_SOC_AK4671
>> .config:2868:warning: symbol value 'm' invalid for SND_SOC_ALC5623
>> .config:2869:warning: symbol value 'm' invalid for SND_SOC_CS42L51
>> .config:2870:warning: symbol value 'm' invalid for SND_SOC_CS4270
>> .config:2871:warning: symbol value 'm' invalid for SND_SOC_CS4271
>> .config:2872:warning: symbol value 'm' invalid for SND_SOC_CX20442
>> .config:2873:warning: symbol value 'm' invalid for SND_SOC_JZ4740_CODEC
>> .config:2874:warning: symbol value 'm' invalid for SND_SOC_L3
>> .config:2875:warning: symbol value 'm' invalid for SND_SOC_DA7210
>> .config:2876:warning: symbol value 'm' invalid for SND_SOC_DFBMCS320
>> .config:2877:warning: symbol value 'm' invalid for SND_SOC_MAX98088
>> .config:2878:warning: symbol value 'm' invalid for SND_SOC_MAX98095
>> .config:2879:warning: symbol value 'm' invalid for SND_SOC_MAX9850
>> .config:2880:warning: symbol value 'm' invalid for SND_SOC_PCM3008
>> .config:2881:warning: symbol value 'm' invalid for SND_SOC_RT5631
>> .config:2882:warning: symbol value 'm' invalid for SND_SOC_SGTL5000
>> .config:2883:warning: symbol value 'm' invalid for SND_SOC_SPDIF
>> .config:2884:warning: symbol value 'm' invalid for SND_SOC_SSM2602
>> .config:2885:warning: symbol value 'm' invalid for SND_SOC_STA32X
>> .config:2886:warning: symbol value 'm' invalid for SND_SOC_TLV320AIC23
>> .config:2887:warning: symbol value 'm' invalid for SND_SOC_TLV320AIC26
>> .config:2888:warning: symbol value 'm' invalid for SND_SOC_TLV320AIC32X4
>> .config:2889:warning: symbol value 'm' invalid for SND_SOC_TLV320AIC3X
>> .config:2890:warning: symbol value 'm' invalid for SND_SOC_TLV320DAC33
>> .config:2891:warning: symbol value 'm' invalid for SND_SOC_UDA134X
>> .config:2892:warning: symbol value 'm' invalid for SND_SOC_UDA1380
>> .config:2894:warning: symbol value 'm' invalid for SND_SOC_WM1250_EV1
>> .config:2895:warning: symbol value 'm' invalid for SND_SOC_WM5100
>> .config:2898:warning: symbol value 'm' invalid for SND_SOC_WM8510
>> .config:2899:warning: symbol value 'm' invalid for SND_SOC_WM8523
>> .config:2900:warning: symbol value 'm' invalid for SND_SOC_WM8580
>> .config:2901:warning: symbol value 'm' invalid for SND_SOC_WM8711
>> .config:2902:warning: symbol value 'm' invalid for SND_SOC_WM8727
>> .config:2903:warning: symbol value 'm' invalid for SND_SOC_WM8728
>> .config:2904:warning: symbol value 'm' invalid for SND_SOC_WM8731
>> .config:2905:warning: symbol value 'm' invalid for SND_SOC_WM8737
>> .config:2906:warning: symbol value 'm' invalid for SND_SOC_WM8741
>> .config:2907:warning: symbol value 'm' invalid for SND_SOC_WM8750
>> .config:2908:warning: symbol value 'm' invalid for SND_SOC_WM8753
>> .config:2909:warning: symbol value 'm' invalid for SND_SOC_WM8770
>> .config:2910:warning: symbol value 'm' invalid for SND_SOC_WM8776
>> .config:2911:warning: symbol value 'm' invalid for SND_SOC_WM8782
>> .config:2912:warning: symbol value 'm' invalid for SND_SOC_WM8804
>> .config:2913:warning: symbol value 'm' invalid for SND_SOC_WM8900
>> .config:2914:warning: symbol value 'm' invalid for SND_SOC_WM8903
>> .config:2915:warning: symbol value 'm' invalid for SND_SOC_WM8904
>> .config:2916:warning: symbol value 'm' invalid for SND_SOC_WM8940
>> .config:2917:warning: symbol value 'm' invalid for SND_SOC_WM8955
>> .config:2918:warning: symbol value 'm' invalid for SND_SOC_WM8960
>> .config:2919:warning: symbol value 'm' invalid for SND_SOC_WM8961
>> .config:2920:warning: symbol value 'm' invalid for SND_SOC_WM8962
>> .config:2921:warning: symbol value 'm' invalid for SND_SOC_WM8971
>> .config:2922:warning: symbol value 'm' invalid for SND_SOC_WM8974
>> .config:2923:warning: symbol value 'm' invalid for SND_SOC_WM8978
>> .config:2924:warning: symbol value 'm' invalid for SND_SOC_WM8983
>> .config:2925:warning: symbol value 'm' invalid for SND_SOC_WM8985
>> .config:2926:warning: symbol value 'm' invalid for SND_SOC_WM8988
>> .config:2927:warning: symbol value 'm' invalid for SND_SOC_WM8990
>> .config:2928:warning: symbol value 'm' invalid for SND_SOC_WM8991
>> .config:2929:warning: symbol value 'm' invalid for SND_SOC_WM8993
>> .config:2931:warning: symbol value 'm' invalid for SND_SOC_WM8995
>> .config:2932:warning: symbol value 'm' invalid for SND_SOC_WM8996
>> .config:2933:warning: symbol value 'm' invalid for SND_SOC_WM9081
>> .config:2934:warning: symbol value 'm' invalid for SND_SOC_LM4857
>> .config:2935:warning: symbol value 'm' invalid for SND_SOC_MAX9877
>> .config:2936:warning: symbol value 'm' invalid for SND_SOC_TPA6130A2
>> .config:2937:warning: symbol value 'm' invalid for SND_SOC_WM2000
>> .config:2938:warning: symbol value 'm' invalid for SND_SOC_WM9090
>> .config:2941:warning: symbol value 'm' invalid for HID
>> .config:2943:warning: symbol value 'm' invalid for USB_HID
>> .config:2948:warning: symbol value 'm' invalid for HID_A4TECH
>> .config:2951:warning: symbol value 'm' invalid for HID_APPLE
>> .config:2952:warning: symbol value 'm' invalid for HID_BELKIN
>> .config:2953:warning: symbol value 'm' invalid for HID_CHERRY
>> .config:2954:warning: symbol value 'm' invalid for HID_CHICONY
>> .config:2956:warning: symbol value 'm' invalid for HID_CYPRESS
>> .config:2961:warning: symbol value 'm' invalid for HID_EZKEY
>> .config:2968:warning: symbol value 'm' invalid for HID_GYRATION
>> .config:2972:warning: symbol value 'm' invalid for HID_LOGITECH
>> .config:2979:warning: symbol value 'm' invalid for HID_MICROSOFT
>> .config:2980:warning: symbol value 'm' invalid for HID_MONTEREY
>> .config:2984:warning: symbol value 'm' invalid for HID_PANTHERLORD
>> .config:2986:warning: symbol value 'm' invalid for HID_PETALYNX
>> .config:3000:warning: symbol value 'm' invalid for HID_SAMSUNG
>> .config:3001:warning: symbol value 'm' invalid for HID_SONY
>> .config:3003:warning: symbol value 'm' invalid for HID_SUNPLUS
>> .config:3051:warning: symbol value 'm' invalid for USB_STORAGE
>> .config:3054:warning: symbol value 'm' invalid for USB_STORAGE_DATAFAB
>> .config:3055:warning: symbol value 'm' invalid for USB_STORAGE_FREECOM
>> .config:3058:warning: symbol value 'm' invalid for USB_STORAGE_SDDR09
>> .config:3059:warning: symbol value 'm' invalid for USB_STORAGE_SDDR55
>> .config:3060:warning: symbol value 'm' invalid for USB_STORAGE_JUMPSHOT
>> .config:3202:warning: symbol value 'm' invalid for MMC_BLOCK
>> .config:3775:warning: symbol value 'm' invalid for EXT2_FS
>> .config:3799:warning: symbol value 'm' invalid for XFS_FS
>> .config:3836:warning: symbol value 'm' invalid for ISO9660_FS
>> .config:3841:warning: symbol value 'm' invalid for FAT_FS
>> .config:3842:warning: symbol value 'm' invalid for MSDOS_FS
>> .config:3843:warning: symbol value 'm' invalid for VFAT_FS
>> .config:3866:warning: symbol value 'm' invalid for JFFS2_FS
>> .config:3873:warning: symbol value 'm' invalid for UBIFS_FS
>> .config:3878:warning: symbol value 'm' invalid for SQUASHFS
>> .config:3897:warning: symbol value 'm' invalid for NFS_FS
>> .config:3912:warning: symbol value 'm' invalid for LOCKD
>> .config:3916:warning: symbol value 'm' invalid for SUNRPC
>> .config:3961:warning: symbol value 'm' invalid for NLS_CODEPAGE_437
>> .config:3964:warning: symbol value 'm' invalid for NLS_CODEPAGE_850
>> .config:3985:warning: symbol value 'm' invalid for NLS_ISO8859_1
>> .config:3986:warning: symbol value 'm' invalid for NLS_ISO8859_2
>> .config:3998:warning: symbol value 'm' invalid for NLS_UTF8
>> .config:4091:warning: symbol value 'm' invalid for XOR_BLOCKS
>> .config:4092:warning: symbol value 'm' invalid for ASYNC_CORE
>> .config:4093:warning: symbol value 'm' invalid for ASYNC_MEMCPY
>> .config:4094:warning: symbol value 'm' invalid for ASYNC_XOR
>> .config:4095:warning: symbol value 'm' invalid for ASYNC_PQ
>> .config:4096:warning: symbol value 'm' invalid for ASYNC_RAID6_RECOV
>> .config:4172:warning: symbol value 'm' invalid for CRYPTO_DEFLATE
>> .config:4174:warning: symbol value 'm' invalid for CRYPTO_LZO
>> .config:4196:warning: symbol value 'm' invalid for RAID6_PQ
>> .config:4199:warning: symbol value 'm' invalid for CRC_CCITT
>> .config:4205:warning: symbol value 'm' invalid for LIBCRC32C
>> .config:4209:warning: symbol value 'm' invalid for ZLIB_DEFLATE
>> --
>> To unsubscribe from this list: send the line "unsubscribe backports" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>

