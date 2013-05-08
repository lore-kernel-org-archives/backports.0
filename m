Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:42382 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753286Ab3EHAU2 (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 7 May 2013 20:20:28 -0400
Received: by mail-la0-f45.google.com with SMTP id fp12so1193232lab.32
        for <backports@vger.kernel.org>; Tue, 07 May 2013 17:20:25 -0700 (PDT)
MIME-Version: 1.0
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 7 May 2013 17:20:05 -0700
Message-ID: <CAB=NE6V7drWK18ij8Ue78J+GSDdVpTJWwqTt3+tVNk01EN4q6Q@mail.gmail.com> (sfid-20130508_022029_958604_D44EF59E)
Subject: Backports project release tags for daily snapshots
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Now'also a good time to consider tagging efforts. I used to tag
compat-drivers releases to match the same next tag from linux-next as
we moved on with the only difference I used compat-drivers-2013-05-07
dates instead  of next-20130507 and I also added a -1 or -2 if I
bumped updates by sticking to the same linux-next target.

Whatever we decide I'll just note that rel-html currently supports the
scheme of dates that are split. I'll still have to update rel-html to
support the project name change so perhaps its good for us to consider
the tag use / practice. To be clear I only added a signed tag if and
only if ckmake yielded good results on all supported kernels. Using
git describe you'd be able to easily get the target next release tag.

Thoughts, preferences?

  Luis
