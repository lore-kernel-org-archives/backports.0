Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44322 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753951Ab3C1VtL (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 28 Mar 2013 17:49:11 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.0:DHE_RSA_CAMELLIA_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ULKh2-0001A5-Ja
	for backports@vger.kernel.org; Thu, 28 Mar 2013 22:49:08 +0100
Message-ID: <1364507345.10397.42.camel@jlt4.sipsolutions.net> (sfid-20130328_224915_104660_21BB9723)
Subject: compat-drivers wishlist
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Date: Thu, 28 Mar 2013 22:49:05 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,

I've long been fed up with the state of compat's build system, so I
figured I'd start by soliciting wishlist items.

FWIW, I think that the whole compat-drivers/scripts/ dir needs to be
rewritten for this ... :-)

My personal wishlist is below. I realize that some of these wishes cause
contradictions/problems in their implementation, but nonetheless I have
them :-)

1) Ability to copy only some drivers.
   We're interested in using compat-drivers to ship our driver to
customers for
   older kernels. We're not at all interested in shipping DRM, Atheros
drivers,
   etc.

2) To make that easier: split all patches per *file* in addition to per
change.
   That way, it would be possible to apply only patches for those files
that are
   actually in the tree. Right now, I heavily patch out those patches
that aren't
   really need.
   I suppose the best way would be to have directories for each change
and change
   the script that applies them to parse the patch header first. Or just
ignore
   patches that fail with "no file", but I don't know if that's easy to
determine
   from the patch exit status code.

3) Separate the output from the compat-drivers tree.
   There's no reason to ship patches/, most of scripts/ etc. in the
resulting
   tarball, in fact it's just confusing. Having the output in a separate
   directory, copying there only the few things that are needed, would
be very
   helpful.

4) Kconfig.
   This is a bit conflicting with 1) because a valid Kconfig structure
requires
   all the sub-Kconfig files exist. Maybe ship all Kconfig files, or
automate a
   way to remove "source" statements for files that don't exist
(probably easy)

I'll leave it at that for now, and follow up with some concrete
implementation ideas :-)

Any other thoughts?

johannes

