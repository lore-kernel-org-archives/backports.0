Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:45932 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754558AbaKRUrA (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 18 Nov 2014 15:47:00 -0500
Received: by mail-lb0-f180.google.com with SMTP id z11so11173281lbi.25
        for <backports@vger.kernel.org>; Tue, 18 Nov 2014 12:46:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1416343319-9395-1-git-send-email-johannes@sipsolutions.net>
References: <1416343319-9395-1-git-send-email-johannes@sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Date: Tue, 18 Nov 2014 12:46:37 -0800
Message-ID: <CAB=NE6U7uN06jfjv-eaLzQ-ZpQrKNVpPauKmnJVqQ9fLiE1ZWQ@mail.gmail.com> (sfid-20141118_214707_221065_F5A56590)
Subject: Re: [PATCH] backports: fix breakage from integration patchset
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, Nov 18, 2014 at 12:41 PM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>
> Various small things broken in the integration patchset, fix
> them to actually make backports useful again.
>
> For example, a driver using devcoredump wouldn't have worked
> without these changes as it would depend on devcoredump, and
> that wasn't backported due to the bugs, despite being in the
> backport Kconfig file.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Thanks, applied and pushed.

  Luis
