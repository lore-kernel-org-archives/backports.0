Return-path: <backports-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:56737 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851Ab3E1StF (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 28 May 2013 14:49:05 -0400
Received: by mail-we0-f181.google.com with SMTP id u57so5492494wes.26
        for <backports@vger.kernel.org>; Tue, 28 May 2013 11:49:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1369318287-18024-1-git-send-email-johannes@sipsolutions.net>
References: <1369318287-18024-1-git-send-email-johannes@sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Date: Tue, 28 May 2013 11:48:43 -0700
Message-ID: <CAB=NE6Voe6E7hMsWfKyKETFhvQdiJ3xhECAfHePs1zRTCJh_jA@mail.gmail.com> (sfid-20130528_204907_714909_74453ED7)
Subject: Re: [PATCH] backport: move kconfig code to "kconf" directory
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, May 23, 2013 at 7:11 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>
> Having the kconfig code in a directory called "kconfig"
> and having a file called "Kconfig" causes issues if the
> code is ever stored on a case-insensitive filesystem.
> Avoid these by just calling the kconfig directory kconf
> instead.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Thanks, applied and pushed!

  Luis
