Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:34634 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754087Ab3C2Aeo (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 28 Mar 2013 20:34:44 -0400
Received: by mail-la0-f48.google.com with SMTP id fq13so153172lab.7
        for <backports@vger.kernel.org>; Thu, 28 Mar 2013 17:34:42 -0700 (PDT)
MIME-Version: 1.0
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Thu, 28 Mar 2013 17:34:22 -0700
Message-ID: <CAB=NE6UTNwt8wyvhhwUfaow=Ps5VLjh7tiiOOiBuc56gn7uw-A@mail.gmail.com> (sfid-20130329_013446_884952_D72583DE)
Subject: Warnings on DRM
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is against 3.9-rcx, I haven't had time to look at these yet, but
we should try to address for the next bump.

  CC [M]  /home/mcgrof/devel/compat-drivers/drivers/gpu/drm/drm_modes.o
/home/mcgrof/devel/compat-drivers/drivers/gpu/drm/drm_modes.c:38:1:
warning: "__enabled_CONFIG_OF_VIDEOMODE" is not defined [-Wundef]
/home/mcgrof/devel/compat-drivers/drivers/gpu/drm/drm_modes.c:38:1:
warning: "__enabled_CONFIG_OF_VIDEOMODE_MODULE" is not defined
[-Wundef]
/home/mcgrof/devel/compat-drivers/drivers/gpu/drm/drm_modes.c:41:1:
warning: "__enabled_CONFIG_VIDEOMODE" is not defined [-Wundef]
/home/mcgrof/devel/compat-drivers/drivers/gpu/drm/drm_modes.c:41:1:
warning: "__enabled_CONFIG_VIDEOMODE_MODULE" is not defined [-Wundef]
/home/mcgrof/devel/compat-drivers/drivers/gpu/drm/drm_modes.c:513:1:
warning: "__enabled_CONFIG_VIDEOMODE" is not defined [-Wundef]
/home/mcgrof/devel/compat-drivers/drivers/gpu/drm/drm_modes.c:513:1:
warning: "__enabled_CONFIG_VIDEOMODE_MODULE" is not defined [-Wundef]
/home/mcgrof/devel/compat-drivers/drivers/gpu/drm/drm_modes.c:549:1:
warning: "__enabled_CONFIG_OF_VIDEOMODE" is not defined [-Wundef]
/home/mcgrof/devel/compat-drivers/drivers/gpu/drm/drm_modes.c:549:1:
warning: "__enabled_CONFIG_OF_VIDEOMODE_MODULE" is not defined
[-Wundef]
/home/mcgrof/devel/compat-drivers/drivers/gpu/drm/drm_modes.c:38:1:
warning: "__enabled_CONFIG_OF_VIDEOMODE" is not defined [-Wundef]
/home/mcgrof/devel/compat-drivers/drivers/gpu/drm/drm_modes.c:38:1:
warning: "__enabled_CONFIG_OF_VIDEOMODE_MODULE" is not defined
[-Wundef]
/home/mcgrof/devel/compat-drivers/drivers/gpu/drm/drm_modes.c:41:1:
warning: "__enabled_CONFIG_VIDEOMODE" is not defined [-Wundef]
/home/mcgrof/devel/compat-drivers/drivers/gpu/drm/drm_modes.c:41:1:
warning: "__enabled_CONFIG_VIDEOMODE_MODULE" is not defined [-Wundef]
/home/mcgrof/devel/compat-drivers/drivers/gpu/drm/drm_modes.c:513:1:
warning: "__enabled_CONFIG_VIDEOMODE" is not defined [-Wundef]
/home/mcgrof/devel/compat-drivers/drivers/gpu/drm/drm_modes.c:513:1:
warning: "__enabled_CONFIG_VIDEOMODE_MODULE" is not defined [-Wundef]
/home/mcgrof/devel/compat-drivers/drivers/gpu/drm/drm_modes.c:549:1:
warning: "__enabled_CONFIG_OF_VIDEOMODE" is not defined [-Wundef]
/home/mcgrof/devel/compat-drivers/drivers/gpu/drm/drm_modes.c:549:1:
warning: "__enabled_CONFIG_OF_VIDEOMODE_MODULE" is not defined
[-Wundef]

  Luis
