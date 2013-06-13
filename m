Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:37656 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454Ab3FMTEC (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 13 Jun 2013 15:04:02 -0400
Received: by mail-lb0-f175.google.com with SMTP id r10so5781980lbi.6
        for <backports@vger.kernel.org>; Thu, 13 Jun 2013 12:04:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1370789000-31032-1-git-send-email-hauke@hauke-m.de>
References: <1370789000-31032-1-git-send-email-hauke@hauke-m.de>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Thu, 13 Jun 2013 12:03:40 -0700
Message-ID: <CAB=NE6W6SgQGLooTjKy=N3+FJeqfRkO68NvW1jdc1gndz-jQeA@mail.gmail.com> (sfid-20130613_210404_867984_F5F9A980)
Subject: Re: [PATCH] backprots: add default config with all wifi drivers
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, Jun 9, 2013 at 7:43 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> This default config contains all wifi drivers.
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  backport/defconfigs/wifi |  105 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 backport/defconfigs/wifi

Thanks, applied and pushed all patches.

  Luis
