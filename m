Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ot0-f171.google.com ([74.125.82.171]:39331 "EHLO
        mail-ot0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751578AbeEOTmV (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 15 May 2018 15:42:21 -0400
Received: by mail-ot0-f171.google.com with SMTP id l12-v6so1611182oth.6
        for <backports@vger.kernel.org>; Tue, 15 May 2018 12:42:21 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Doyle <wpdster@gmail.com>
Date: Tue, 15 May 2018 15:41:50 -0400
Message-ID: <CAF_dkJDhJtg95_DZ96OFuYNRtZkS1YWNZSvB9f_UJL0teDK8eQ@mail.gmail.com> (sfid-20180515_214223_713521_1BD8D086)
Subject: How to use backports?
To: backports@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Please forgive my ignorance.  I would like to use the backports tool
to backport a driver from a fork of linux-next to my (vendor's) custom
4.9 kernel.

>From reading https://backports.wiki.kernel.org/index.php/Documentation/integration
it would appear that I should be able to do something vaguely like:

$ ./gentree.py --integrate --clean --gitdebug ../linux-ath-erstrom
../buildroot/build/linux-custom

But, the first time I tried that, I received the following error:

You need to have installed: spatch
Try installing the package: coccinelle

So:

$ sudo apt install coccinelle

and try again, only to get this error:

You need to have installed: spatch >= 1.0.6
Try installing the package: coccinelle

So now I am trying to compile coccinelle from source and that is failing:

cp: cannot stat '/usr/lib/ocaml/parmap/parmap.cmx': No such file or directory
Makefile:620: recipe for target 'ocaml/parmap.cmi' failed

It appears that the version of libparmap-ocaml-dev I installed on my
Ubuntu 16.04 workstation does not include parmap.cmx.  (It includes
parmap.cmxa and parmap.cmxs, but not parmap.cmx).

Or, perhaps I'm off on completely the wrong tangent here.

So, first questions first...
If I want to port a driver from the latest linux-ath-erstrom source
tree to my custom 4.9 source tree, is backports and gentree.py the
right way to go?

Should I reasonably expect gentree to run on a 16.04 LTS Ubuntu?  If
so, what dependencies should I install?

Or am I going about this the wrong way?

I'm stuck, and would appreciate any help anybody can give me.

Thanks in advance.

--wpd
--
To unsubscribe from this list: send the line "unsubscribe backports" in
