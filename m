Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pl0-f50.google.com ([209.85.160.50]:35253 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbdLAFnz (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 1 Dec 2017 00:43:55 -0500
Received: by mail-pl0-f50.google.com with SMTP id b96so5703820pli.2
        for <backports@vger.kernel.org>; Thu, 30 Nov 2017 21:43:55 -0800 (PST)
Received: from ?IPv6:2600:100f:b000:9b80:6941:fc3f:6520:9004? ([2600:100f:b000:9b80:6941:fc3f:6520:9004])
        by smtp.gmail.com with ESMTPSA id u18sm488256pgn.72.2017.11.30.21.43.53
        for <backports@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Nov 2017 21:43:54 -0800 (PST)
To: backports@vger.kernel.org
From: Remington Furman <remicles2@gmail.com>
Subject: Parse error with genl-const.cocci
Message-ID: <925f98d2-047f-785f-4162-21b53a77cd62@gmail.com> (sfid-20171201_064358_586047_BC8ED658)
Date: Thu, 30 Nov 2017 21:43:52 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hello,

I'd like to say thank you for this very useful project.  I am
relatively new to kernel development, so it would be impossible
for me to sort out the "collateral evolutions" and history of the
linux internals without backports.

I am trying to backport the rtl8192cu driver from linux v4.14-rc4
to an Android 5.11 system running linux kernel v3.10.  My
development system is Linux Mint 17.1.  I chose v4.14-rc4 because
that's the latest tag in backports.  My backports repo and
linux-next repo are checked out to v4.14-rc4-1 and v4.14-rc4,
respectively.

I am getting an error when I try to create a backport package:

backports $ ./gentree.py --clean --verbose --git-revision v4.14-rc4 
../linux-next/ ../linux-backport/
Get original source files from git ...
Applying patches from patches to ../linux-backport/ ...
Applying patch 
0000-upstream-backport-changes/0005-uapi-compromise/mwifiex.patch
[...snip lots of good patches here...]
Applying SmPL patch 0027-genl-const/genl-const.cocci
Failed to process SmPL patch 0027-genl-const/genl-const.cocci with 1

Getting the output of pycocci:

backports $ ./devel/pycocci -j 1 -v 
./patches/0027-genl-const/genl-const.cocci ../linux-backport/
spatch --sp-file ./patches/0027-genl-const/genl-const.cocci --in-place 
--recursive-includes --relax-include-path --use-coccigrep --timeout 120 
--dir ../linux-backport/
Failed to apply changes from genl-const.cocci
Specific log output from change that failed using genl-const.cocci
init_defs_builtins: /usr/local/bin/../lib/coccinelle/standard.h
meta: parse error:
   File "./patches/0027-genl-const/genl-const.cocci", line 2, column 10, 
charpos = 13
   around = '__genl_const',
   whole content = attribute __genl_const;

Full log using genl-const.cocci
init_defs_builtins: /usr/local/bin/../lib/coccinelle/standard.h
meta: parse error:
   File "./patches/0027-genl-const/genl-const.cocci", line 2, column 10, 
charpos = 13
   around = '__genl_const',
   whole content = attribute __genl_const;
[...snip callstack...]

This is very similar to this problem:
<https://www.spinics.net/lists/backports/msg04216.html>
The conclusion of that thread is that the --integrate workflow is
no longer supported.

However, I am not using --integrate, and I am still getting
errors about parsing '__genl_const'.  Is that a bug in the patch
or possibly a regression in spatch?  I've tried v4.14-rc2 also,
but nothing older.

This page has a lot of great example info, and suggested that it
could be a problem with my version of spatch. Specifically, that
I was missing the menhir and libmenhir-ocaml-dev packages when
building Coccinelle and a rebuild should help.
<http://stonyslp.blogspot.com/2017/08/backport-driver.html>

Unfortunately, I still have the same errors after running make
distclean and rebuilding.

I have:
coccinelle $ git describe --tags
1.0.6-365-gd73c6e6
coccinelle $ spatch --version
spatch version 1.0.6-00365-gd73c6e6 compiled with OCaml version 4.01.0
Flags passed to the configure script: [none]
OCaml scripting support: yes
Python scripting support: yes
Syntax of regular expresssions: PCRE

I found this patch which describes how older versions can't
handle the __genl_const changes (20150209):
<https://www.spinics.net/lists/backports/msg03223.html>

But, I also see commit 748116c8 from shortly after (20150507)
which introduced genl-const.cocci and says only spatch 1.0.0-rc23
is needed.

I feel like I'm close to figuring this out, but would appreciate
any help or pointers.

Thank you,
Remington Furman
--
To unsubscribe from this list: send the line "unsubscribe backports" in
