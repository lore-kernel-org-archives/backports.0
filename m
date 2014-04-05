Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:37471 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596AbaDEMnZ (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 5 Apr 2014 08:43:25 -0400
Received: by mail-pd0-f170.google.com with SMTP id v10so4552588pde.1
        for <backports@vger.kernel.org>; Sat, 05 Apr 2014 05:43:25 -0700 (PDT)
Received: from mcgrof@gmail.com (c-98-234-145-61.hsd1.ca.comcast.net. [98.234.145.61])
        by mx.google.com with ESMTPSA id jd5sm24224649pbb.18.2014.04.05.05.43.21
        for <backports@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 05 Apr 2014 05:43:23 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Subject: [PATCH 00/27] backports: synch up to next-20140311
Date: Sat,  5 Apr 2014 05:41:02 -0700
Message-Id: <1396701662-15165-29-git-send-email-mcgrof@do-not-panic.com> (sfid-20140405_144448_201511_8B5E115C)
In-Reply-To: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
References: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

I'm back from Limbo! Thanks to Hauke for taking on backports while I was
gone and to Johannes for taking on the first seires of SmPL patches. This
series takes what I saw was pending on the backports mailing list and also
puts out what I have been working on in collaboration with the folks at LIP6,
in particular Julia Lawall, on the helping automate backport the Linux kernel
further. I've put together a lenghty write up [0] of the series of changes
that have been ongoing on the Linux backports project [1] which I hope can
serve as both some form of ramp up education on using Coccinelle and writing
grammar rules in Semantic Patch Language (SmPL) but also concerte evidence of
how this technology can help us scale Linux and scale Linux backporting and
extend the way we do automatic backporting.

This also puts us in synch with next-20140311 and I have some small changes
which lets us create a linux-3.14.y branch ready for release provided I don't
hear back with any issues or qualms observed. All this obviously goes compile
tested against the last 30 Linux kernel releases.

At the Linux Collaboration Summit and on elsewhere I've been beeing poked about
backports and if anyone was working on it and will continue to do so. There
were some isues which I needed to get resolved, its all done and I'm back, now
at SUSE. Now at SUSE I have other responsibilities but I'm going going to
continue to extend backports but with a slightly different set of requirements
and considerations, one of them being focusing on kernels >= 3.0. I understand
there is still huge interest in upkeeping support for older kernels, I don't
plan on removing those immediately but with your help I think we should strive
to build consensus on only using kernels listed on kernel.org. The flexibility
provided by Linux backports can hopefully be used to help persuade folks to
abandon unsupported kernels. This won't happen overnight, but that's the goal.

If you want to test all this agains the latest master branch you can wget the
all in one series of patches [2] and git am it.

[0] http://www.do-not-panic.com//2014/04/automatic-linux-kernel-backporting-with-coccinelle.html
[1] https://backports.wiki.kernel.org
[2] http://drvbp1.linux-foundation.org/~mcgrof/patches/backports/2014/05/synch-up-next-next-20140311.patch
