Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:36408 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183AbbFIWRp (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 9 Jun 2015 18:17:45 -0400
Received: by ieclw1 with SMTP id lw1so22772448iec.3
        for <backports@vger.kernel.org>; Tue, 09 Jun 2015 15:17:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1432754105-9939-1-git-send-email-arend@broadcom.com>
References: <1432754105-9939-1-git-send-email-arend@broadcom.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 9 Jun 2015 15:17:24 -0700
Message-ID: <CAB=NE6UBwg8VPXvZE04HgzZZm--YXnGqY3wjCzB-aRUo9=Y48w@mail.gmail.com> (sfid-20150610_001747_723176_FD580369)
Subject: Re: [PATCH] backports: include: introduce backport for
 ACPI_COMPANION() macro
To: Arend van Spriel <arend@broadcom.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, May 27, 2015 at 12:15 PM, Arend van Spriel <arend@broadcom.com> wrote:
> The brcmfmac driver now uses the ACPI_COMPANION() macro which was
> introduced in v3.13 kernel. This provides a backport of that macro
> for older kernels.
>
> Signed-off-by: Arend van Spriel <arend@broadcom.com>

Thanks Arend, applied and pushed!

 Luis
