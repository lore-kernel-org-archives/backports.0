Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:62538 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562AbaDZRVT (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 26 Apr 2014 13:21:19 -0400
Received: by mail-lb0-f179.google.com with SMTP id q8so3902353lbi.38
        for <backports@vger.kernel.org>; Sat, 26 Apr 2014 10:21:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1398422668-11735-1-git-send-email-arend@broadcom.com>
References: <1398422668-11735-1-git-send-email-arend@broadcom.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Sat, 26 Apr 2014 10:20:57 -0700
Message-ID: <CAB=NE6VMQY9O4mvp50-e7yavUG=An9spKj4bLBj_ZH663c9Dmg@mail.gmail.com> (sfid-20140426_192135_608057_AB037476)
Subject: Re: [PATCH] backports: lib: remove raising ExecutionError exception
To: Arend van Spriel <arend@broadcom.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, Apr 25, 2014 at 3:44 AM, Arend van Spriel <arend@broadcom.com> wrote:
> In spatch a ExecutionError was raised, but that causes the thread
> to finish without closing the outfile and more importantly without
> putting (ret, fn) tuple on the return queue. This results in the
> threaded_spatch routine to get stuck on the ret_q.get() call. This
> patch removes raising the ExecutionError and just return the tuple.
> The non-zero return code will result in ExecutionErrorThread exception
> anyway.
>
> Signed-off-by: Arend van Spriel <arend@broadcom.com>

Thanks but this no longer applies, can you rebase against master?

  Luis
