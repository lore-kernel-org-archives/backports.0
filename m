Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:38712 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183AbbFIWRH (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 9 Jun 2015 18:17:07 -0400
Received: by igblz2 with SMTP id lz2so21003829igb.1
        for <backports@vger.kernel.org>; Tue, 09 Jun 2015 15:17:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1433509613-3272-1-git-send-email-net147@gmail.com>
References: <1433509613-3272-1-git-send-email-net147@gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 9 Jun 2015 15:16:46 -0700
Message-ID: <CAB=NE6ViUX9z3Q1iqVhGJ8U93Syeg2DbbEstn05XL3VDy9nZBQ@mail.gmail.com> (sfid-20150610_001709_861916_A3D45F34)
Subject: Re: [PATCH] backports: add missing include for vfree
To: Jonathan Liu <net147@gmail.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, Jun 5, 2015 at 6:06 AM, Jonathan Liu <net147@gmail.com> wrote:
> Signed-off-by: Jonathan Liu <net147@gmail.com>
> ---
>  backport/compat/backport-3.15.c | 1 +
>  1 file changed, 1 insertion(+)

Thanks Jonathan, applied and pushed! In the future please provide a
commit log description as to why this was done.

 Luis
