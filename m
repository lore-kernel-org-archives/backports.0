Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:54809 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490AbaJWU01 (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 23 Oct 2014 16:26:27 -0400
Received: by mail-la0-f48.google.com with SMTP id gi9so1521051lab.21
        for <backports@vger.kernel.org>; Thu, 23 Oct 2014 13:26:26 -0700 (PDT)
MIME-Version: 1.0
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Thu, 23 Oct 2014 13:26:05 -0700
Message-ID: <CAB=NE6V=-Ef08L+7fA66a3DdZUa-WYUKBnhiuHE0bWH2VhDPbA@mail.gmail.com> (sfid-20141023_222630_026286_02FA12E0)
Subject: Tag to help count manual patch fixes
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

I propose we we a tag to help count the amount of times we actually
have to do work in between release to fix patch manually. Not sure
what to use though, any ideas?

Manually-fixed ?

The use case? Well it would help us let keep count for starters and
see if things increase / decrease over time. This can also be used I
suppose by some tool to extract these patches and perhaps in the
future see if there's way to address these sorts of patches
automatically somehow.

Are the possible gains worth it?

  Luis
