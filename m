Return-path: <kavitam@cdot.in>
From: "KAVITA MATHUR" <kavitam@cdot.in>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org
Subject: compilation errors in ath10k driver with latest backports git
Date: Thu, 7 Sep 2017 14:34:48 +0530
Message-Id: <20170907090319.M77568@cdot.in>
In-Reply-To: <cd9ddade-391a-686a-c023-c7a10a575cdc@broadcom.com>
References: <20170821222817.17376-1-hauke@hauke-m.de> <20170821222817.17376-17-hauke@hauke-m.de> <1504710312.23905.13.camel@sipsolutions.net> <cd9ddade-391a-686a-c023-c7a10a575cdc@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=utf-8
List-ID: <backports@vger.kernel.org>

Hi,

I am using backports git and ath10k git to download latest changes in ath0k driver.
There are build errors in ath10k drivers due to definitions not backported from kernel
4.12. Backpors-git is backported kernel till 4.8. Please suggest how to fix these issues.

Following is the build error log:

CC [M]  /home/shw/kavita/backports/backports-output_14Aug17/compat/backport-3.13.o
CC [M]  /home/shw/kavita/backports/backports-output_14Aug17/compat/backport-3.15.o
CC [M]  /home/shw/kavita/backports/backports-output_14Aug17/compat/backport-3.18.o
CC [M]  /home/shw/kavita/backports/backports-output_14Aug17/compat/backport-3.19.o
CC [M]  /home/shw/kavita/backports/backports-output_14Aug17/compat/backport-4.1.o
CC [M]  /home/shw/kavita/backports/backports-output_14Aug17/compat/backport-4.2.o
CC [M]  /home/shw/kavita/backports/backports-output_14Aug17/compat/backport-4.4.o
CC [M]  /home/shw/kavita/backports/backports-output_14Aug17/compat/backport-4.5.o
CC [M]  /home/shw/kavita/backports/backports-output_14Aug17/compat/backport-4.7.o
LD [M]  /home/shw/kavita/backports/backports-output_14Aug17/compat/compat.o
CC [M]
/home/shw/kavita/backports/backports-output_14Aug17/drivers/net/wireless/ath/main.o
CC [M]
/home/shw/kavita/backports/backports-output_14Aug17/drivers/net/wireless/ath/regd.o
CC [M]  /home/shw/kavita/backports/backports-output_14Aug17/drivers/net/wireless/ath/hw.o
CC [M]  /home/shw/kavita/backports/backports-output_14Aug17/drivers/net/wireless/ath/key.o
CC [M]
/home/shw/kavita/backports/backports-output_14Aug17/drivers/net/wireless/ath/dfs_pattern_detector.o
CC [M]
/home/shw/kavita/backports/backports-output_14Aug17/drivers/net/wireless/ath/dfs_pri_detector.o
LD [M]  /home/shw/kavita/backports/backports-output_14Aug17/drivers/net/wireless/ath/ath.o
CC [M]
/home/shw/kavita/backports/backports-output_14Aug17/drivers/net/wireless/ath/ath10k/mac.o
In file included from
/home/shw/kavita/backports/backports-output_14Aug17/drivers/net/wireless/ath/ath10k/mac.h:22,
               from
/home/shw/kavita/backports/backports-output_14Aug17/drivers/net/wireless/ath/ath10k/mac.c:18:
/home/shw/kavita/backports/backports-output_14Aug17/drivers/net/wireless/ath/ath10k/core.h:465:
error: expected specifier-qualifier-list before 'guid_t'
/home/shw/kavita/backports/backports-output_14Aug17/drivers/net/wireless/ath/ath10k/mac.c:
In function 'ath10k_tx_h_add_p2p_noa_ie':
/home/shw/kavita/backports/backports-output_14Aug17/drivers/net/wireless/ath/ath10k/mac.c:3492:
error: implicit declaration of function 'skb_put_data'
make[8]: ***
[/home/shw/kavita/backports/backports-output_14Aug17/drivers/net/wireless/ath/ath10k/mac.o]
Error 1
make[7]: ***
[/home/shw/kavita/backports/backports-output_14Aug17/drivers/net/wireless/ath/ath10k]
Error 2
make[6]: ***
[/home/shw/kavita/backports/backports-output_14Aug17/drivers/net/wireless/ath] Error 2
make[5]: *** [/home/shw/kavita/backports/backports-output_14Aug17/drivers/net/wireless]
Error 2
make[4]: *** [_module_/home/shw/kavita/backports/backports-output_14Aug17] Error 2
make[3]: *** [modules] Error 2
make[2]: *** [modules] Error 2
make[1]: *** [modules] Error 2
make: *** [default] Error 2 


Thanks & Regards,
कविता माथुर Kavita Mathur 
वरिष्ठ अनुसंधान अभियंता  Senior Research Engineer 
सी-डॉट                      C-DOT
इलैक्ट्रॉनिक्स सिटी फेज़ I         Electronics City Phase I
होसूर रोड, बेंगलूरु               Hosur Road, Bengaluru – 560100
फोन  Ph 080-28529896
Disclaimer:
----------
This email and any files transmitted with it
