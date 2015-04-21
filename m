Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:48050 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752475AbbDUUox (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 21 Apr 2015 16:44:53 -0400
Message-ID: <5536B6C2.90105@hauke-m.de> (sfid-20150421_224455_083892_F6F39DC6)
Date: Tue, 21 Apr 2015 22:44:50 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Stefan Assmann <sassmann@kpanic.de>, backports@vger.kernel.org
CC: mcgrof@do-not-panic.com
Subject: Re: [PATCH 09/10] backports: remove devm_hwmon_device_register_with_groups
 references with smpl patch
References: <1424874054-22956-1-git-send-email-sassmann@kpanic.de> <1424874054-22956-10-git-send-email-sassmann@kpanic.de>
In-Reply-To: <1424874054-22956-10-git-send-email-sassmann@kpanic.de>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 02/25/2015 03:20 PM, Stefan Assmann wrote:
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> ---
>  ...m_hwmon_device_register_with_groups.patch.cocci | 40 ++++++++++++++++++++++
>  ...gb-devm_hwmon_device_register_with_groups.patch | 28 ---------------
>  2 files changed, 40 insertions(+), 28 deletions(-)
>  create mode 100644 patches/collateral-evolutions/network/0041-devm_hwmon_device_register_with_groups/devm_hwmon_device_register_with_groups.patch.cocci
>  delete mode 100644 patches/collateral-evolutions/network/0041-devm_hwmon_device_register_with_groups/igb-devm_hwmon_device_register_with_groups.patch
> 

I think this patch and this spatch is not needed.

devm_hwmon_device_register_with_groups() gets backported in
https://git.kernel.org/cgit/linux/kernel/git/backports/backports.git/commit/?id=69dbc7cf6d34b903c1dc80f1d4f880fc9acfe6fb

I haven't tested igb without this patch.

Hauke

