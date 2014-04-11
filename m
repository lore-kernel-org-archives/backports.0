Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:40150 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbaDKSYG (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 11 Apr 2014 14:24:06 -0400
Received: by mail-lb0-f182.google.com with SMTP id n15so3754661lbi.41
        for <backports@vger.kernel.org>; Fri, 11 Apr 2014 11:24:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <006d01cf5591$694ee230$3beca690$@com>
References: <CAB=NE6VvyBKzEg=ErZzQMktY8eLytQ21JCPrOQbxvZ9m-nqHkw@mail.gmail.com>
 <53451077.2030102@openwrt.org> <CAB=NE6UUN4vQd3SpsvO5tcgaYq3YXQeE0KtZGki7p7OnR=J4RA@mail.gmail.com>
 <20140409191225.GA10560@kroah.com> <CAB=NE6VqY8yXoYuE0o01vq86imY8EtqLdkPa4bGMvR3bTaj5KQ@mail.gmail.com>
 <20140409202224.GA12953@kroah.com> <CAB=NE6XY5++p7hJQpQdwrFNUcGbUsKpC+oJiZQciXNduo+8j8A@mail.gmail.com>
 <20140409210613.GA14392@kroah.com> <s5heh15pr18.wl%tiwai@suse.de>
 <CAB=NE6VeNTFeGxKXpYunkU-W=JPLMpOnrehttvsqB+yXkdz5fg@mail.gmail.com> <006d01cf5591$694ee230$3beca690$@com>
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Date: Fri, 11 Apr 2014 11:23:44 -0700
Message-ID: <CAB=NE6WpApJ7dn7GNYM0K7B6dyLeQVM+PRn1Ly=KXfy_96GSVA@mail.gmail.com> (sfid-20140411_202409_632105_7926309A)
Subject: Re: Bumping required kernels to 3.0 for Linux backports ?
To: Harrison Lee <harrisonl@tme-inc.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, Apr 11, 2014 at 7:22 AM, Harrison Lee <harrisonl@tme-inc.com> wrote=
:
> Compat-wireless drivers have been very useful to users like us, who have =
to work with embedded linux system based on old kernel. For example, we wor=
k on a arm based system with 2.6.28 kernel, and could use ath9k drivers tha=
nks to compat-wireless-3.6.8-1. The company who provided the SDK, a big nam=
e company, does not have any plan to upgrade the kernel, so we are stuck wi=
th it due to all the customized drivers for the chip.

compat-wireless is ancient and anyone giving you anything like a
release like that is not giving you the best, which is the latest, and
that is anything based on the latest kernel releases, right now, v3.14
based which I hope today to make a release.

> But the situation seems to be changing. Compat-drivers does not support 2=
.6.28 any more for ath9k. It only supports from 2.6.30 according to "depend=
encies" list.

compat-drivers is ancient as well, the new project is backports and we
will be deprecating older kernels to help us scale better.

> I've just joined the mailing list to learn how to backport wwan drivers. =
And the first message I see is about dumping supports for older kernels...

wwan drivers backports are welcomed, but backporting it to ancient
kenrels, anything below 3.0 is not something I wish to take on now
given the overhead and as I noted the objectives to scale.

> Would there be any alternatives for old kernel users, then?

You could upkeep the maintenance yourself on a separate tree.

  Luis
