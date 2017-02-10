Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34653 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750910AbdBJXdH (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 10 Feb 2017 18:33:07 -0500
Received: by mail-wm0-f66.google.com with SMTP id c85so9428441wmi.1
        for <backports@vger.kernel.org>; Fri, 10 Feb 2017 15:33:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170207090433.22264-1-johannes@sipsolutions.net>
References: <20170207090433.22264-1-johannes@sipsolutions.net>
From: Steve deRosier <derosier@gmail.com>
Date: Fri, 10 Feb 2017 15:33:06 -0800
Message-ID: <CALLGbRJ0nZ=+8H_XXMtdVcakAnBYLeJKi4e7Y5p_Xe8VOTffxQ@mail.gmail.com> (sfid-20170211_003310_536840_F8FD328E)
Subject: Re: [PATCH] backports: improve MTU spatch
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, Feb 7, 2017 at 1:04 AM, Johannes Berg <johannes@sipsolutions.net> wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>
> Improve the MTU spatch to
>  1) not handle arbitrary expressions, only constants - the one
>     case where I found expressions can't actually just move it
>     to a function, it won't compile
>  2) if min_mtu isn't set, assume 0
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---

Looks OK to me, though I'm still only starting to get used to coccinelle.

- Steve
--
To unsubscribe from this list: send the line "unsubscribe backports" in
