Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:47365 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492Ab3FBPJz (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 2 Jun 2013 11:09:55 -0400
Received: by mail-pb0-f53.google.com with SMTP id un4so4508159pbc.26
        for <backports@vger.kernel.org>; Sun, 02 Jun 2013 08:09:55 -0700 (PDT)
Received: from icy ([199.180.254.75])
        by mx.google.com with ESMTPSA id cd2sm55263036pbd.35.2013.06.02.08.09.53
        for <backports@vger.kernel.org>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Sun, 02 Jun 2013 08:09:54 -0700 (PDT)
Date: Sun, 2 Jun 2013 22:09:34 +0700
From: "Anh K. Huynh" <kyanh@viettug.org>
To: backports@vger.kernel.org
Subject: Buid backports-20130528 on ArchLinux: /usr/bin/ld: cannot find
 -ltinfo
Message-ID: <20130602220934.3079ee4f@icy> (sfid-20130602_170957_728483_48913C26)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hello,

I'm building the `backports-20130528` on ArchLinux (kernel = 3.2.46).
I see the error as in http://pastie.org/7996763 .

I don't have any problem when building the new Linux kernel. When I
remove the `tinfo` support from the file `kconf/Makefile` I can run 
`make menuconfig` perfectly.

Is the `tinfo` library really needed to run `make menuconfig` when
building backports drivers?

Thank you for your helps,

--
I am ... 5 dog years old.
