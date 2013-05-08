Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:57132 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140Ab3EHHuz (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 8 May 2013 03:50:55 -0400
Message-ID: <1367999451.8279.11.camel@jlt4.sipsolutions.net> (sfid-20130508_095056_519136_D7ED0699)
Subject: Re: [PATCH 0/3] backports: keep headers on patch refresh
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org, techtonik@gmail.com
Date: Wed, 08 May 2013 09:50:51 +0200
In-Reply-To: <1367895800-14305-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130507_050334_102477_409139F3)
References: <1367895800-14305-1-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20130507_050334_102477_409139F3)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2013-05-06 at 20:03 -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
> 
> This changeset updates the backports project to enable keeping
> headers around upon patch refresh. We now use a Python library
> for managing patches, update that library to the the latest
> from svn trunk, make a small change to it and then modify our
> gentree.py to take advantage of it.

Applied, with the change to remove the HG/GIT detection again.

> Anatoly, feel free to incorporate the patch.py change to your
> respective upstream if you see it fit.

If you do, let us know and we can update again :)

johannes

