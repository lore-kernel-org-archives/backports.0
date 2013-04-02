Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:60167 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759702Ab3DBNTq (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 2 Apr 2013 09:19:46 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.0:DHE_RSA_CAMELLIA_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <johannes@sipsolutions.net>)
	id 1UN17o-0007FE-SK
	for backports@vger.kernel.org; Tue, 02 Apr 2013 15:19:45 +0200
Message-ID: <1364908781.8204.14.camel@jlt4.sipsolutions.net> (sfid-20130402_151948_622703_76140D33)
Subject: [ANN] new backports project
From: Johannes Berg <johannes@sipsolutions.net>
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Tue, 02 Apr 2013 15:19:41 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hey,

I guess just a few days later it's time to announce it ... I've been
working on a merge of compat/compat-drivers into a new backports tree.
That by itself would be boring, so here's what I also did:

 * made driver copying variable
   As discussed a few days ago, I wanted this to be able to port only
some
   drivers. To really achieve this without breaking all patches, I also
had to
   - split patches and make applying them smarter
   - remove Makefile patches and mangle the Makefiles in a scripted way
 * added Kconfig support
   This allows users to better select which drivers they want, with
their
   dependencies etc. To achieve this, it was necessary to also mangle
the Kconfig
   files in some ways, but that's all scripted as well
 * separate output directory
   My new script writes in a new output directory, which helps separate
the
   compat code creation step from the build step, and end users don't
get
   burdened with the scripting needed for the creation.

To be fair, I should say what I broke. I think the system should be
generic enough to allow adding it back easily though.
 * graphics drivers -- I couldn't even get the patches to apply
 * ethernet drivers -- I just wasn't sure which ones were needed etc.
 * "crap"/staging/... patches
 * plain 'make' -- you now need to do 'make allyesconfig' or so
first :-)
 * Redhat kernel backport support -- this should be fairly easy

I'm hoping that the improvements I have are sufficient to get everyone
to help out, and have the old compat/compat-drivers die ... :-)

The code is available here (for now):
http://git.sipsolutions.net/?p=backports.git;a=summary

And in case you're wondering ... I got ckmake to build an
"allyesconfig" (except for CFG80211_INTERNAL_REGDB which I forced off)
against all kernels on Luis's build machine. This took forever, but I
got this:

1   2.6.24              [  OK  ]
2   2.6.25              [  OK  ]
3   2.6.26              [  OK  ]
4   2.6.27              [  OK  ]
5   2.6.28              [  OK  ]
6   2.6.29              [  OK  ]
7   2.6.30              [  OK  ]
8   2.6.31              [  OK  ]
9   2.6.32              [  OK  ]
10  2.6.33              [  OK  ]
11  2.6.34              [  OK  ]
12  2.6.35              [  OK  ]
13  2.6.36              [  OK  ]
14  2.6.37              [  OK  ]
15  2.6.38              [  OK  ]
16  2.6.39              [  OK  ]
17  3.0.65              [  OK  ]
18  3.1.10              [  OK  ]
19  3.2.38              [  OK  ]
20  3.3.8               [  OK  ]
21  3.4.32              [  OK  ]
22  3.5.7               [  OK  ]
23  3.6.11              [  OK  ]
24  3.7.9               [  OK  ]
25  3.8.0               [  OK  ]
26  3.9-rc1             [  OK  ]

johannes

