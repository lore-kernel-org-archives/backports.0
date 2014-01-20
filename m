Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:35413 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750743AbaATU7c (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 20 Jan 2014 15:59:32 -0500
Received: by mail-ie0-f170.google.com with SMTP id u16so7110260iet.15
        for <backports@vger.kernel.org>; Mon, 20 Jan 2014 12:59:31 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 20 Jan 2014 12:59:31 -0800
Message-ID: <CAEsx0Y8ro45a3sWckyOc-vhTCqqCL6UkZYK=ME10zCLv5C3byQ@mail.gmail.com> (sfid-20140120_215935_087510_433BA432)
Subject: backport module can't see built in kernel symbol
From: Daniel Schultze <kinglag@gmail.com>
To: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Developers,

I am having some trouble getting my cross compiled backport working
with my kernel. I am getting the error message:

    bluetooth: Unknown symbol crypto_shash_setkey

I ran nm on the kernel file vmLinux and grep'ed System.map which does show:

    c0153d40 T crypto_shash_setkey


So I'm a bit confused as to why bluetooth.ko can't "see" it. Any help
you could give would be appreciated.

-Dan
