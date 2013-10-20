Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:45407 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750956Ab3JTOMS (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 20 Oct 2013 10:12:18 -0400
Message-ID: <5263E4B9.4040303@hauke-m.de> (sfid-20131020_161224_061470_86D97541)
Date: Sun, 20 Oct 2013 16:12:09 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Hauke Mehrtens <hauke@hauke-m.de>, mcgrof@gmail.com
CC: backports@vger.kernel.org, ozancag@gmail.com
Subject: Re: [RFC 00/15] backports: remove DRM drivers
References: <1381013044-7724-1-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1381013044-7724-1-git-send-email-hauke@hauke-m.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 10/06/2013 12:43 AM, Hauke Mehrtens wrote:
> Maintaining the DRM driver takes a lot of recourses as there they are
> depending on many API changes done to the core kernel code and
> currently we do not have that many recourses to follow them. On the
> other side one needs also new userspace drivers to make use of the new
> features added to the DRM kernel drivers and it is not easy to update
> the X drivers. Therefore we came to the conclusion to remove the drm
> drivers for now.
> 
> If someone wants to maintain the DRM drivers I would be very happy with
> that and they should not be removed.
> 
> There were also some problems with some DRM drivers, like the Intel
> i915 driver caused kernel panic on some systems and was probably only
> usable on some very recent kernel versions.
> 
> 1   2.6.25              [  OK  ]
> 2   2.6.26              [  OK  ]
> 3   2.6.27              [  OK  ]
> 4   2.6.28              [  OK  ]
> 5   2.6.29              [  OK  ]
> 6   2.6.30              [  OK  ]
> 7   2.6.31              [  OK  ]
> 8   2.6.32              [  OK  ]
> 9   2.6.33              [  OK  ]
> 10  2.6.34              [  OK  ]
> 11  2.6.35              [  OK  ]
> 12  2.6.36              [  OK  ]
> 13  2.6.37              [  OK  ]
> 14  2.6.38              [  OK  ]
> 15  2.6.39              [  OK  ]
> 16  3.0.98              [  OK  ]
> 17  3.1.10              [  OK  ]
> 18  3.10.14             [  OK  ]
> 19  3.11.3              [  OK  ]
> 20  3.12-rc3            [  FAIL  ]
> 21  3.2.51              [  OK  ]
> 22  3.3.8               [  OK  ]
> 23  3.4.64              [  OK  ]
> 24  3.5.7               [  OK  ]
> 25  3.6.11              [  OK  ]
> 26  3.7.10              [  OK  ]
> 27  3.8.13              [  OK  ]
> 28  3.9.11              [  OK  ]
> 
> You can pull it from
> https://github.com/hauke/backports/tree/drm-remove
> 
> This is based on the "backports: add next-20130822" patch series.
> 
> Hauke Mehrtens (15):
>   backports: remove DRM driver
>   backports: remove platform drivers
>   backports: remove BACKPORT_BUILD_CROSS_RESERVATION
>   backports: remove CPTCFG_BACKPORT_BUILD_WW_MUTEX
>   backports: remove BACKPORT_BUILD_RADIX_HELPERS
>   backports: remove BACKPORT_BUILD_HDMI
>   backports: remove more hdmi stuff
>   backports: remove some stuff related to MTRR
>   backports: remove scatterlist
>   backports: remove ktime_get_monotonic_offset()
>   backports: remove devm_regmap_init_spi()
>   backports: remove compat_wake_up_locked()
>   backports: remove i2c_bit_algo()
>   backports: remove cpufreq_quick_get_max()
>   backports: remove shmem_read_mapping_page_gfp()

Any comments on this?

If nobody has a problem with this series I would like to relabel it into
a patch series so it could be included.

Hauke
