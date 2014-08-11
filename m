Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:53719 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752030AbaHKGrb (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 11 Aug 2014 02:47:31 -0400
Message-ID: <1407739647.1718.1.camel@jlt4.sipsolutions.net> (sfid-20140811_084733_627728_7A8D437A)
Subject: Re: [PATCH] backports: fix mconf compilation on OpenSUSE factory
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: hauke@hauke-m.de, backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@suse.com>
Date: Mon, 11 Aug 2014 08:47:27 +0200
In-Reply-To: <1407739093.1718.0.camel@jlt4.sipsolutions.net> (sfid-20140811_083823_481212_C030DBDF)
References: <1407597803-11371-1-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20140809_172333_446755_55AB6E1D) <1407739093.1718.0.camel@jlt4.sipsolutions.net>
	 (sfid-20140811_083823_481212_C030DBDF)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2014-08-11 at 08:38 +0200, Johannes Berg wrote:

> I have a vague feeling that we used to have this and it broke somewhere
> else, and it was supposed to get added via check-lxdialog.sh...

commit d58be321df286371d50ed54e835efeea087a9fac
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Mon Jun 3 17:54:33 2013 +0200

    backports: use check-lxdialog.sh


johannes

