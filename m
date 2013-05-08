Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:60302 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557Ab3EHI7b (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 8 May 2013 04:59:31 -0400
Received: by mail-lb0-f179.google.com with SMTP id d10so1690573lbj.10
        for <backports@vger.kernel.org>; Wed, 08 May 2013 01:59:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1367997056.8279.10.camel@jlt4.sipsolutions.net>
References: <1367997031-11574-1-git-send-email-johannes@sipsolutions.net> <1367997056.8279.10.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Date: Wed, 8 May 2013 01:59:09 -0700
Message-ID: <CAB=NE6UiDwf4ojR=XaVF+QqttKxKnNHcLJ9otF2ud3kdkdoddQ@mail.gmail.com> (sfid-20130508_105934_674024_FE85A550)
Subject: Re: [PATCH] backports: adjust snd_portid patch for nl80211 update
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, May 8, 2013 at 12:10 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Wed, 2013-05-08 at 09:10 +0200, Johannes Berg wrote:
>> From: Johannes Berg <johannes.berg@intel.com>
>>
>> The new code for the "critical protocol indication" uses
>> snd_portid and must be adjusted in the backport patches.
>
> This will be needed starting from next-20130423.

Thanks for the heads up. If anyone wants to help shortcut further:

commit c1be5a5b1b355d40e6cf79cc979eb66dafa24ad1
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Apr 28 17:36:01 2013 -0700

    Linux 3.9

diff --git a/Makefile b/Makefile
index 46263d8..8fe6991 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 3
 PATCHLEVEL = 9
 SUBLEVEL = 0
-EXTRAVERSION = -rc8
+EXTRAVERSION =
 NAME = Unicycling Gorilla

So that's next-20130428 but since that doesn't exist we want to easily
branch out into a linux-3.10.y branch by having at least:

  * next-20130426
  * next-20130426
  * next-20130429

Given that johill has likely time warped us to next-20130423 perhaps
its also good to have next-20130424. That would be the full set prior
to the merge window for v3.10 (or whatever $linux_deity wants to call
it).

  Luis
