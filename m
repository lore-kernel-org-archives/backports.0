Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from sabertooth01.qualcomm.com ([65.197.215.72]:33165 "EHLO
	sabertooth01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989Ab3BLUTz convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 12 Feb 2013 15:19:55 -0500
From: "Bitterli, Felix" <felixb@qca.qualcomm.com>
To: Hauke Mehrtens <hauke@hauke-m.de>
CC: "Rodriguez, Luis" <rodrigue@qca.qualcomm.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: RE: compat-drivers ./driver-select ath9k builds i915 as well,
 breaks my video
Date: Tue, 12 Feb 2013 20:19:36 +0000
Message-ID: <40F35DA312B2CC468349B21A177FEE633C8AD8A5@NASANEXD02E.na.qualcomm.com>
References: <40F35DA312B2CC468349B21A177FEE633C8AD5FA@NASANEXD02E.na.qualcomm.com>,<511A998B.8080204@hauke-m.de>
In-Reply-To: <511A998B.8080204@hauke-m.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

>> compat-drivers ./driver-select ath9k builds i915 as well, shouldn't, are
>> you available for fixing this or do we wait for Luis to get back from
>> Antarctica?
>I can not reproduce this with the current version based on linux-next
>from [0].
>
> Hauke
>
>[0]: https://www.kernel.org/pub/linux/kernel/projects/backports/2013/02/08/
Thanks Hauke,

The i915 issue was with stable compat-drivers-3.7.1-3 sorry for omitting that. It is solved with both backports/stable/v3.8-rc7/ and backports/2013/02/08/

Different issue: 'make uninstall' does nothing for me. history|tail -7
 2020  tar xjvf compat-drivers-2013-02-10.tar.bz2
 2021  cd compat-drivers-3.8-rc7-1/
 2022  ./scripts/driver-select ath9k
 2023  make
 2024  sudo make install
 2025  sudo make uninstall
 2026  history | tail -7

