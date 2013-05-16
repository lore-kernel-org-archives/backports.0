Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:63301 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144Ab3EPFpE (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 16 May 2013 01:45:04 -0400
Received: by mail-la0-f52.google.com with SMTP id fo13so2603528lab.11
        for <backports@vger.kernel.org>; Wed, 15 May 2013 22:45:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAB=NE6Ut5CdpistLecYnbzK-t+Rymw-Gzhj=DdhYEcm8DGPBYw@mail.gmail.com>
References: <1368440675-23190-1-git-send-email-mcgrof@do-not-panic.com>
 <1368603799.8359.5.camel@jlt4.sipsolutions.net> <CAB=NE6UiZPP02y126Qxc5c7q1wFer0_9cZLFP_QCQo_Z6uGJmQ@mail.gmail.com>
 <CAB=NE6Ut5CdpistLecYnbzK-t+Rymw-Gzhj=DdhYEcm8DGPBYw@mail.gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Wed, 15 May 2013 22:44:42 -0700
Message-ID: <CAB=NE6UrCSYztvoe0HP8fBANki0C4huePhAxxpSb6eV8KnCo6w@mail.gmail.com> (sfid-20130516_074507_868699_13ED55E5)
Subject: Re: [PATCH 0/3] backports: take up up to next-20130426
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, May 15, 2013 at 8:56 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> On Wed, May 15, 2013 at 8:45 PM, Luis R. Rodriguez
> <mcgrof@do-not-panic.com> wrote:
>> while nouveau fails and uses the later.
>
> Actually I see now drivers that use either work so this seems to be
> nouveau specific.

This seems to be because of the new changes that stuffed nouveau files
into separate directories:

drivers/gpu/drm/nouveau/core/
drivers/gpu/drm/nouveau/dispnv04/

I've tried this but no luck.

--- a/drivers/gpu/drm/nouveau/Makefile
+++ b/drivers/gpu/drm/nouveau/Makefile
@@ -3,9 +3,9 @@
 # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.

 ccflags-y := -Iinclude/drm
-ccflags-y += -I$(src)/core/include
-ccflags-y += -I$(src)/core
-ccflags-y += -I$(src)
+ccflags-y += -I$(backport_srctree)/drivers/gpu/drm/nouveau/core/include/
+ccflags-y += -I$(backport_srctree)/drivers/gpu/drm/nouveau/core/
+ccflags-y += -I$(backport_srctree)/drivers/gpu/drm/nouveau/

 nouveau-y := core/core/client.o
 nouveau-y += core/core/engctx.o


  Luis
