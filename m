Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:38783 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710AbaJaTx2 (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 31 Oct 2014 15:53:28 -0400
Received: by mail-la0-f46.google.com with SMTP id hs14so6814719lab.19
        for <backports@vger.kernel.org>; Fri, 31 Oct 2014 12:53:27 -0700 (PDT)
MIME-Version: 1.0
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Fri, 31 Oct 2014 12:53:07 -0700
Message-ID: <CAB=NE6VyjTcCqJmETLK+epozEG0=NwHkDqnWX8=xG95+ihUvkw@mail.gmail.com> (sfid-20141031_205330_458995_3151A0C4)
Subject: Backports non-modular kernel integration status - II
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Just booted my machine with a non modular kernel using the v3.15
kernel and pulling in drivers from next-20141003, worked like a charm.
I'll address the feedback on patches and respin, but it seems this
should be ready for use rather soon.

 Luis
