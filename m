Return-path: <backports-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:64548 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732621AbeHNP4n (ORCPT <rfc822;backports@vger.kernel.org>);
        Tue, 14 Aug 2018 11:56:43 -0400
Message-ID: <32b52167e7dd5734ba4aa5f21aa1fddd257e6292.camel@intel.com> (sfid-20180814_150937_918498_BA1DA7F7)
Subject: New release after 1.0.7?
From: Luciano Coelho <luciano.coelho@intel.com>
To: cocci@systeme.lip6.fr
Cc: backports@vger.kernel.org
Date: Tue, 14 Aug 2018 16:09:33 +0300
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,

Is there a plan for a new release after 1.0.7? 1.0.7 was not tagged and
no tarballs were released, so I'm not sure what is the status of it. 
Additionally, I've had problems compiling it, and bisected it to this
commit:

commit 7ab8f01b63d7cdec988e5f05065f3c18fdab7319 (refs/bisect/bad)
Author:     Thierry Martinez <thierry.martinez@inria.fr>
AuthorDate: Wed Jun 20 15:46:18 2018 +0200
Commit:     Thierry Martinez <thierry.martinez@inria.fr>
CommitDate: Wed Jun 20 15:46:18 2018 +0200

    Allow bytecode compilation for pyml/generate
    
    This change generalizes a patch submitted by
      Christopher Zimmermann <chrisz@openbsd.org>
    for allowing pyml/generate to be compiled by ocamlc if ocamlopt
    is not available.
    
    The rules are adapted from pyml-current/Makefile.

Nevertheless, the compilation problem I had seems to be fixed in the
latest master (commit 97695d059cd5).

We (in the Linux backports project) have made a change to support the
new attributes style[1], which was supposed to work with 1.0.6, but
that seems to be broken too.

We don't want to revert to using the pre-1.0.6 versions, so we are
waiting for new release to choose for our project.  So, my question
again, can we expect a new stable release any time soon?

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/backports/backports.git/commit/?id=98272f479c2126a135dfcb12484e93d5888164ab

--
Cheers,
Luca.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
