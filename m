Return-path: <backports-owner@vger.kernel.org>
Received: from mail-vb0-f51.google.com ([209.85.212.51]:37519 "EHLO
	mail-vb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756227Ab3GONIL (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 15 Jul 2013 09:08:11 -0400
Received: by mail-vb0-f51.google.com with SMTP id x17so3090234vbf.24
        for <backports@vger.kernel.org>; Mon, 15 Jul 2013 06:08:10 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 15 Jul 2013 09:08:10 -0400
Message-ID: <CAOvdn6Vs9pUOXwBYTPzvQp0TDKgDxotog-Srv0xF+41i5UXz0Q@mail.gmail.com> (sfid-20130715_150813_416070_8649FA88)
Subject: problems building backports-3.10-2
From: Ben Guthro <ben@guthro.net>
To: backports@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

I'm struggling to integrate the backports-3.10-2 release into my
build, and I'm hoping this is the proper venue to get some answers.

1. The build is complaining about ./gentree.py and local symbols. I
did not see gentree.py anywhere in the code released.

Even when removing this section of the Makefile, I am able to get a
bit further, to try to do a 'make menuconfig'
This does not present the options I expected - offering only the
following options:

Build all compat code
Voltage and Current Regulator Support


I also tried the some of the defconfigs (like iwlwifi) - but these
seem to only build the compat.ko, and nothing else.


Am I doing something wrong - or is something broken in this release?


Thanks for any pointers.

Ben
