Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:60100 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753552Ab3ESBFU (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 18 May 2013 21:05:20 -0400
Received: by mail-la0-f49.google.com with SMTP id fp13so4779929lab.36
        for <backports@vger.kernel.org>; Sat, 18 May 2013 18:05:19 -0700 (PDT)
MIME-Version: 1.0
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Sat, 18 May 2013 18:04:58 -0700
Message-ID: <CAB=NE6Ukgibio21rgu2xBZwpZrCsKQjwhOMX9sGTAQ5GXBiLjg@mail.gmail.com> (sfid-20130519_030523_200998_B70F8B0C)
Subject: backports daily snapshots move on
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

I'm going to keep moving on with daily backports snapshots now that
we've caught up. First daily snapshot release:

https://www.kernel.org/pub/linux/kernel/projects/backports/2013/05/02/backports-20130502.tar.bz2

The backports.git tree tags for these will match linux-next tags but
replacing the long RFC 3339 dates (compat-drivers-2012-02-02) with the
shorter linux-next style dates (backports-20130502). Note that for
stable releases the tags will simply match Linus' stags with the
addition of an extra tag release to match the update revision during
that same release in case we need a fix / update for it.

  Luis
