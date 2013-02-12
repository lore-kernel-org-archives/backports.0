Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:51866 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754500Ab3BLV2l (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 12 Feb 2013 16:28:41 -0500
Message-ID: <511AB3FD.4020804@hauke-m.de>
Date: Tue, 12 Feb 2013 22:28:29 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: "Bitterli, Felix" <felixb@qca.qualcomm.com>
CC: "Rodriguez, Luis" <rodrigue@qca.qualcomm.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: compat-drivers ./driver-select ath9k builds i915 as well, breaks
 my video
References: <40F35DA312B2CC468349B21A177FEE633C8AD5FA@NASANEXD02E.na.qualcomm.com>,<511A998B.8080204@hauke-m.de> <40F35DA312B2CC468349B21A177FEE633C8AD8A5@NASANEXD02E.na.qualcomm.com>
In-Reply-To: <40F35DA312B2CC468349B21A177FEE633C8AD8A5@NASANEXD02E.na.qualcomm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 02/12/2013 09:19 PM, Bitterli, Felix wrote:
>>> compat-drivers ./driver-select ath9k builds i915 as well, shouldn't, are
>>> you available for fixing this or do we wait for Luis to get back from
>>> Antarctica?
>> I can not reproduce this with the current version based on linux-next
>>from [0].
>>
>> Hauke
>>
>> [0]: https://www.kernel.org/pub/linux/kernel/projects/backports/2013/02/08/
> Thanks Hauke,
> 
> The i915 issue was with stable compat-drivers-3.7.1-3 sorry for omitting that. It is solved with both backports/stable/v3.8-rc7/ and backports/2013/02/08/
> 
> Different issue: 'make uninstall' does nothing for me. history|tail -7
>  2020  tar xjvf compat-drivers-2013-02-10.tar.bz2
>  2021  cd compat-drivers-3.8-rc7-1/
>  2022  ./scripts/driver-select ath9k
>  2023  make
>  2024  sudo make install
>  2025  sudo make uninstall
>  2026  history | tail -7
> 

Hi Felix,

It looks like Luis already fixed this bug in the more recent versions,
see [0], You could apply it locally to your build and I will add it to
the next release, but it will take some time till I new release from 3.7.

Hauke

[0]:
https://github.com/hauke/compat-drivers/commit/2371a496060c87378c27eb0cb33feeefbc29f2fc
