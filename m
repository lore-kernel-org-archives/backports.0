Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:38421 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752238Ab3JCMEi (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 3 Oct 2013 08:04:38 -0400
Message-ID: <524D5D4E.2040908@hauke-m.de> (sfid-20131003_140440_674431_ADE5BFA6)
Date: Thu, 03 Oct 2013 14:04:30 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: mcgrof@gmail.com
CC: backports@vger.kernel.org
Subject: Re: [PATCH 00/11] backports: update to next-20130816
References: <1378901515-14206-1-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1378901515-14206-1-git-send-email-hauke@hauke-m.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 09/11/2013 02:11 PM, Hauke Mehrtens wrote:
> This is based on "backports: fix intel i915 drm driver".
> 
> Hauke Mehrtens (11):
>   backports: add include/drm/drm_agpsupport.h
>   backports: add hdmi_infoframe_pack()
>   backports: add HDMI_INFOFRAME_SIZE
>   backports: REGULATOR_DA9210 needs at least kernel 3.5
>   backports: refresh patches for next-20130802
>   backports: replace new portid usage
>   backports: use old led api on old kernel versions.
>   backports: do not use DMA SG on old kernel versions
>   backports: add debugfs_create_x64()
>   backports: do not build REGULATOR_PALMAS on older kernel versions.
>   backports: refresh patches for next-20130816

Hi Luis,

did you missed these patches?

You can also pull them from https://github.com/hauke/backports.git

Hauke
