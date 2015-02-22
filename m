Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:58783 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751810AbbBVCCQ (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 21 Feb 2015 21:02:16 -0500
Message-ID: <54E938A5.8070302@hauke-m.de> (sfid-20150222_030227_017754_03136102)
Date: Sun, 22 Feb 2015 03:02:13 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Mathieu Olivari <mathieu@qca.qualcomm.com>, mcgrof@kernel.org
CC: backports@vger.kernel.org, kvalo@qca.qualcomm.com
Subject: Re: [PATCH v2 2/2] backport: add hwmon group registration functions
References: <1422207962-23988-1-git-send-email-mathieu@qca.qualcomm.com> <1422207962-23988-2-git-send-email-mathieu@qca.qualcomm.com>
In-Reply-To: <1422207962-23988-2-git-send-email-mathieu@qca.qualcomm.com>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 01/25/2015 06:46 PM, Mathieu Olivari wrote:
> hwmon group registration functions have been added in 3.13 kernel.
> Latest ath10k patches make use of this mechanism, therefore the
> need for the backport.
> 
> Signed-off-by: Mathieu Olivari <mathieu@qca.qualcomm.com>
> 
> ---
>  backport/backport-include/linux/hwmon.h |   34 ++++++++++++++++++++
>  backport/compat/backport-3.13.c         |   52 +++++++++++++++++++++++++++++++
>  2 files changed, 86 insertions(+)
>  create mode 100644 backport/backport-include/linux/hwmon.h
> 
> Notes:
>     v2: address the comments reported by Hauke
>     *make devm_hwmon_release() static and moved it above
>      devm_hwmon_device_register_with_group()
>     *moved new includes at the top of the file
>     *set dev->groups and drvdata in hwmon_device_register_with_groups()
> 

Thank you for the patches. Both were applied to backports and added to
the latest release.

> +	struct device *hwdev;
> +
> +	hwdev = hwmon_device_register(dev);
> +	hwdev->groups = groups;
> +	dev_set_drvdata(&hwdev, drvdata);

I did a small change to this line. hwdev should not be given by double
reference here. I removed the &.

Hauke
