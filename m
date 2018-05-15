Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:47632 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752311AbeEOUEJ (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 15 May 2018 16:04:09 -0400
Message-ID: <1526414646.4450.13.camel@sipsolutions.net> (sfid-20180515_220411_290881_71A7AE72)
Subject: Re: How to use backports?
From: Johannes Berg <johannes@sipsolutions.net>
To: Patrick Doyle <wpdster@gmail.com>, backports@vger.kernel.org
Date: Tue, 15 May 2018 22:04:06 +0200
In-Reply-To: <CAF_dkJDhJtg95_DZ96OFuYNRtZkS1YWNZSvB9f_UJL0teDK8eQ@mail.gmail.com> (sfid-20180515_214223_713521_1BD8D086)
References: <CAF_dkJDhJtg95_DZ96OFuYNRtZkS1YWNZSvB9f_UJL0teDK8eQ@mail.gmail.com>
         (sfid-20180515_214223_713521_1BD8D086)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi Patrick,

> From reading https://backports.wiki.kernel.org/index.php/Documentation/integration
> it would appear that I should be able to do something vaguely like:
> 
> $ ./gentree.py --integrate --clean --gitdebug ../linux-ath-erstrom
> ../buildroot/build/linux-custom

In theory yes. I can't really recommend --integrate, it's untested. I
may remove it entirely since nobody is maintaining it.

> You need to have installed: spatch >= 1.0.6
> Try installing the package: coccinelle

Indeed. There was actually a very recent commit (latest commit) that
would make this require only an earlier version. Reverting that may be
easier for you.

> So now I am trying to compile coccinelle from source and that is failing:
> 
> cp: cannot stat '/usr/lib/ocaml/parmap/parmap.cmx': No such file or directory
> Makefile:620: recipe for target 'ocaml/parmap.cmi' failed
> 
> It appears that the version of libparmap-ocaml-dev I installed on my
> Ubuntu 16.04 workstation does not include parmap.cmx.  (It includes
> parmap.cmxa and parmap.cmxs, but not parmap.cmx).
> 
> Or, perhaps I'm off on completely the wrong tangent here.

That I can't really say. I guess you could ask the coccinelle mailing
list about it.

> So, first questions first...
> If I want to port a driver from the latest linux-ath-erstrom source
> tree to my custom 4.9 source tree, is backports and gentree.py the
> right way to go?

Yes, that sounds reasonable. I don't know what "linux-ath-erstrom" is,
but if it's reasonably close to upstream now it should be OK.

> Should I reasonably expect gentree to run on a 16.04 LTS Ubuntu?  If
> so, what dependencies should I install?

No idea, sorry.

johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
