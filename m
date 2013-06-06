Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:43813 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757076Ab3FFDjD (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 5 Jun 2013 23:39:03 -0400
Received: by mail-la0-f49.google.com with SMTP id fp12so1500553lab.22
        for <backports@vger.kernel.org>; Wed, 05 Jun 2013 20:39:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1369958718-18711-1-git-send-email-anoop.karollil@gmail.com>
References: <1369958718-18711-1-git-send-email-anoop.karollil@gmail.com>
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Date: Wed, 5 Jun 2013 20:38:41 -0700
Message-ID: <CAB=NE6XtDKF46kEL6Nr4L4EaTmBLLitSYKS8=KS2y2A1RXpOSQ@mail.gmail.com> (sfid-20130606_053906_048845_CA929690)
Subject: Re: [PATCH] backports: fix firmware install for old udev on Ubuntu
To: Anoop Karollil <anoop.karollil@gmail.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, May 30, 2013 at 5:05 PM, Anoop Karollil
<anoop.karollil@gmail.com> wrote:
> Rules for older versions of udev (e.g. version 113-0ubuntu16 on Ubuntu 7.10) are
> looked for in /etc/udev/rules.d. For later versions, they are looked for in
> either the default /lib/udev/rules.d location or the custom /etc/udev/rules.d
> location. For backwards compatibility with older udev, the rules should be
> installed in /etc/udev/rules.d.
>
> Signed-off-by: Anoop Karollil <anoop.karollil@gmail.com>

Applied and pushed, thanks!

  Luis
