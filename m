Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:43782 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753788Ab3DMUz5 (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 16:55:57 -0400
Message-ID: <1365886553.1089.1.camel@jlt4.sipsolutions.net> (sfid-20130413_225600_064851_83CABFD0)
Subject: Re: [PATCH 1/7] backports: add support for backport_srctree
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org
Date: Sat, 13 Apr 2013 22:55:53 +0200
In-Reply-To: <1365862424-6530-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20130413_161358_045253_866190AD)
References: <1365862424-6530-1-git-send-email-mcgrof@do-not-panic.com>
	 <1365862424-6530-2-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20130413_161358_045253_866190AD)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sat, 2013-04-13 at 07:13 -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
> 
> The Linux kernel uses srctree to help prefix header files
> and scripts. When backporting we want to be able to override
> driver's Makefiles' usage of srctree with our own. Since we
> can't easily and sanely override the srctree itself without
> causing a lot of issues just use the python generator to
> do the change for us on the target Makefiles. This addresses
> the srctree usage case and where ccflags was used without
> prefixing any parent directory when used with drivers, the
> kernel tends to fix that with addtree command.

Applied. I also removed the now unnecessary patches that change
-Idrivers/...

johannes

