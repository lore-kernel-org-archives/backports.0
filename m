Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:65282 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757098AbaEIThu (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 9 May 2014 15:37:50 -0400
Received: by mail-la0-f53.google.com with SMTP id ec20so211322lab.12
        for <backports@vger.kernel.org>; Fri, 09 May 2014 12:37:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1399616596-12805-1-git-send-email-johannes@sipsolutions.net>
References: <1399616596-12805-1-git-send-email-johannes@sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Fri, 9 May 2014 12:37:28 -0700
Message-ID: <CAB=NE6Ua=H0HjyaL3c812rXFZHbcTaWatecP7u27hWdREjmqVg@mail.gmail.com> (sfid-20140509_213753_075712_052B7066)
Subject: Re: [PATCH] backports: fix class/bus attribute group spatch conversion
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, May 8, 2014 at 11:23 PM, Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> The spatch conversion (commit 05d44557c6a83b4ecb935cb6306f62,
> "backports: transform group attribute backport to SmPL form")
> added an #ifdef that shouldn't be there - remove it.

When re-doing this I did make this change on purpose as I could not
see how those were being defined for newer kernels, where is that?

 Luis
