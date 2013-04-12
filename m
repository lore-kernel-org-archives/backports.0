Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:38256 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752Ab3DLGLH (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 12 Apr 2013 02:11:07 -0400
Received: by mail-la0-f53.google.com with SMTP id fp13so2185274lab.40
        for <backports@vger.kernel.org>; Thu, 11 Apr 2013 23:11:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
References: <1365723771-10660-1-git-send-email-johannes@sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Date: Thu, 11 Apr 2013 23:10:44 -0700
Message-ID: <CAB=NE6VEv9A=0y9xfUr-UGvTuHZMbgFaqA-jDSs_R8exWM_RWw@mail.gmail.com> (sfid-20130412_081109_422026_22D1E049)
Subject: Re: [RFC/WIP 00/24] backports: disentangle header file mess
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, Apr 11, 2013 at 4:42 PM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> As we were discussing, let's disentangle the header file mess
> and the various random includes all over the place and instead
> provide each header file that needs something backported with
> those backported things and and #include_next.
>
> The list.h stuff was a bit tricky, but not really a big issue
> thanks to Hauke's idea.
>
> I'm also removing compatibility with < 2.6.24 ... it just doesn't
> seem worth it any more.
>
> Up until patch 22 it passes ckmake --allyesconfig, but then after
> that I haven't tried and clearly with patch 24 it won't, that one
> can only work for kernels 3.5 and up or so since not all of the
> compat headers are dissolved yet.
>
> One of the nice things is that we can get rid of the pr_fmt mess,
> that's a huge patch removal. But overall, this is also nicer as
> it will better replicate the include structure of the kernel.

I'm supportive of the switch.

  Luis
