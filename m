Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:42876 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754629Ab3EPDp0 (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 15 May 2013 23:45:26 -0400
Received: by mail-lb0-f175.google.com with SMTP id v10so2614381lbd.20
        for <backports@vger.kernel.org>; Wed, 15 May 2013 20:45:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1368603799.8359.5.camel@jlt4.sipsolutions.net>
References: <1368440675-23190-1-git-send-email-mcgrof@do-not-panic.com> <1368603799.8359.5.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Wed, 15 May 2013 20:45:04 -0700
Message-ID: <CAB=NE6UiZPP02y126Qxc5c7q1wFer0_9cZLFP_QCQo_Z6uGJmQ@mail.gmail.com> (sfid-20130516_054531_252697_4FEB3A1C)
Subject: Re: [PATCH 0/3] backports: take up up to next-20130426
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, May 15, 2013 at 12:43 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
>>   * remove_proc_subtree()

This can't be backported modularly so I'm going to revert the patches
that add this and encourage debugfs to be used in the future.

>>   * proc_set_size()

I just backported this.

>>   * ttm_bo_reference()
>>   * ttm_bo_unref()
>>   * ttm_kmap_obj_virtual()

These seem to be issues with header include order for ttm_bo_driver.h
and I cannot figure out why or how, for the failing case I suspect the
kernel's header file is being used instead of our copy. DRM drivers
use two include forms for including ttm_bo_driver.h:

#include <ttm/ttm_bo_driver.h>
#include <drm/ttm/ttm_bo_driver.h>

drivers/gpu/drm/ttm/ttm_bo_vm.c compiled fine which used the first
form while nouveau fails and uses the later.

  Luis
