Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:56872 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752051Ab3D0Uhg (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 27 Apr 2013 16:37:36 -0400
Received: by mail-la0-f46.google.com with SMTP id fs13so1814268lab.33
        for <backports@vger.kernel.org>; Sat, 27 Apr 2013 13:37:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJqaZwwH6HQqd0m9QO-Noc+SUAx79pHoSNWGfysei1Zgr9K4+g@mail.gmail.com>
References: <CAJqaZwwH6HQqd0m9QO-Noc+SUAx79pHoSNWGfysei1Zgr9K4+g@mail.gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Sat, 27 Apr 2013 13:37:14 -0700
Message-ID: <CAB=NE6UOhsxqXMhVJJ6=oKOAerR=8zfHxR6z79YNKUs0GvznSg@mail.gmail.com> (sfid-20130427_223738_960579_8711E09E)
Subject: Re: [PATCH v2] compat-drivers/Makefile: make uninstall leaves drm and
 two b44 files
To: ASIC Felix <ic.felix@gmail.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, Apr 26, 2013 at 9:18 PM, ASIC Felix <ic.felix@gmail.com> wrote:
> make uninstall doesn't remove drm and two b44 ethernet modules.
>
> Signed-off-by: Felix Bitterli <ic.felix@gmail.com>
> ---

Applied and pushed onto the linux-3.9.y branch. I didn't apply to the
master branch as the 3.10 releases will be coming from the new
backports tree. I'll post more on this later though.

Thanks!

  Luis
