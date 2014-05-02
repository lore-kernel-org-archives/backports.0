Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:50693 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbaEBGwH (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 2 May 2014 02:52:07 -0400
Received: by mail-la0-f43.google.com with SMTP id c6so2789946lan.2
        for <backports@vger.kernel.org>; Thu, 01 May 2014 23:52:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140502013948.GH957@garbanzo.do-not-panic.com>
References: <CAFjWW+ZsCZpmh-CVWX9Y+73tOAS5JG5f7mvrr8biAVgN_a+Fng@mail.gmail.com>
 <20140502013948.GH957@garbanzo.do-not-panic.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Thu, 1 May 2014 23:51:45 -0700
Message-ID: <CAB=NE6W0EKgE5cH3Biv7xdpp5RuR-VmLhGoZCbrHoZ3ehEArOw@mail.gmail.com> (sfid-20140502_085209_841463_D6EA715E)
Subject: Re: 3.14-1 Compile Problem for 2.6.39.4 Kernel
To: Aaron Hamilton <aaron@logicdatasystems.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, May 1, 2014 at 6:39 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> This *should* have triggered a compile failure when we had tested this..
> Going to run another test now.

I reran the compile test with ckmake and a fresh pull of code and I
get the same results.

1   2.6.25              [  OK  ]
2   2.6.26              [  OK  ]
3   2.6.27              [  OK  ]
4   2.6.28              [  OK  ]
5   2.6.29              [  OK  ]
6   2.6.30              [  OK  ]
7   2.6.31              [  OK  ]
8   2.6.32              [  OK  ]
9   2.6.33              [  OK  ]
10  2.6.34              [  OK  ]
11  2.6.35              [  OK  ]
12  2.6.36              [  OK  ]
13  2.6.37              [  OK  ]
14  2.6.38              [  OK  ]
15  2.6.39              [  OK  ]
16  3.0.101             [  OK  ]
17  3.1.10              [  OK  ]
18  3.2.54              [  OK  ]
19  3.3.8               [  OK  ]
20  3.4.79              [  OK  ]
21  3.5.7               [  OK  ]
22  3.6.11              [  OK  ]
23  3.7.10              [  OK  ]
24  3.8.13              [  OK  ]
25  3.9.11              [  OK  ]
26  3.10.29             [  OK  ]
27  3.11.10             [  OK  ]
28  3.12.10             [  OK  ]
29  3.13.2              [  OK  ]
30  3.14-rc1            [  OK  ]

real    35m40.235s
user    990m33.700s
sys     115m19.584s

This time I checked the logs and I don't see crypto_ccm being
compiled, even though ckmake --allyesconfig was used, which should
enable *everything*. We can look at the Makefile to see what symbol
defines it:

mcgrof@drvbp1 ~/build/backports-3.14-test $ grep crypto-ccm compat/Makefile
compat-$(CPTCFG_BACKPORT_BUILD_CRYPTO_CCM) += crypto-ccm.o
compat-$(CPTCFG_BACKPORT_BUILD_CRYPTO_CCM) += crypto-ccm.o

For some reason there are two entries but it doesn't matter for this
case as that would not have presented an issue. Then we can look at
compat/Kconfig to see what options enable it:

config BACKPORT_BUILD_CRYPTO_CCM
        bool
        default n if CRYPTO_CCM
        default y if BACKPORT_CRYPTO_CCM
        #c-file crypto/ccm.c

The c-file line here is used by gentree.py to copy the upstream linux
crypto/ccm.c file over to compat/crypto-ccm.c. Next we look at who
enables this on the code then:

mcgrof@drvbp1 ~/build/backports-3.14-test $ grep -nHr BACKPORT_CRYPTO_CCM
.local-symbols:28:BACKPORT_CRYPTO_CCM=
net/mac80211/Kconfig:8: select BACKPORT_CRYPTO_CCM
compat/Kconfig:183:config BACKPORT_CRYPTO_CCM
compat/Kconfig:189:     default y if BACKPORT_CRYPTO_CCM

So only mac80211 would ever have enabled this. Here's the full entry:

config MAC80211
        tristate "Generic IEEE 802.11 Networking Stack (mac80211)"
        depends on m
        depends on CFG80211
        depends on CRYPTO
        depends on CRYPTO_ARC4
        depends on CRYPTO_AES
        select BACKPORT_CRYPTO_CCM
        depends on CRC32
        select BACKPORT_AVERAGE
        ---help---
          This option enables the hardware independent IEEE 802.11
          networking stack.

The logs show mac80211 being compiled but not crypto-ccm, something is
fishy here.

  Luis
