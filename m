Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:47839 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792Ab3HSGDJ (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 19 Aug 2013 02:03:09 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr4so4530617pbb.6
        for <backports@vger.kernel.org>; Sun, 18 Aug 2013 23:03:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1376869084-16513-2-git-send-email-hauke@hauke-m.de>
References: <1376869084-16513-1-git-send-email-hauke@hauke-m.de> <1376869084-16513-2-git-send-email-hauke@hauke-m.de>
From: Arik Nemtsov <arik@wizery.com>
Date: Mon, 19 Aug 2013 09:02:53 +0300
Message-ID: <CA+XVXfdqirfmENS+YYteqGzavPV5wkCyFUc0XNrRwjdzC=TQ2w@mail.gmail.com> (sfid-20130819_080311_520719_DA6DECAB)
Subject: Re: [PATCH v2 01/19] backports: fix conditional include of arch_phys_wc_add()
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: mcgrof@gmail.com, backports@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, Aug 19, 2013 at 2:37 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>
> This fixes a problem introduced in this commit:
> commit c871780b5afa182878884bf5ccd8df4817a2660f
> Author: Arik Nemtsov <arik@wizery.com>
> Date:   Wed Aug 14 10:48:05 2013 +0300
>
>     backports: rename some mem functions to not break custom kernels
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> Cc: Arik Nemtsov <arik@wizery.com>

This one is ok. Thanks.

Arik
