Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:43394 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756034AbaJ2VHj (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 29 Oct 2014 17:07:39 -0400
Received: by mail-lb0-f175.google.com with SMTP id b6so3169878lbj.20
        for <backports@vger.kernel.org>; Wed, 29 Oct 2014 14:07:37 -0700 (PDT)
MIME-Version: 1.0
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Wed, 29 Oct 2014 14:07:16 -0700
Message-ID: <CAB=NE6XpVW1J1E-0mZQvsHgAnCzAsw+yJHpYyvtXMsc_9-2hUA@mail.gmail.com> (sfid-20141029_220741_131109_61560E35)
Subject: Integration issues found and status
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Cc: Stefan Assmann <sassmann@kpanic.de>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

OK a few obvious issues and their status:

1) dependencies file does not use BACKPORT_ prefix and as such they
are not mapped correctly, I'm about to address this
2) some Kconfig files don't get the change:

-source "foo"
+source "backports/foo"

This is not allowing them to creep up on integration menuconfig, I'll
look into that next.

3) vmlinux build - something is missing on the last step on gentree.py
for integration, this can be observed when using gitdebug, I'm hoping
Stefan can help with this :D

  Luis
