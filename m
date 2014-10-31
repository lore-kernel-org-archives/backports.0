Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:50296 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751362AbaJaHmI (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 31 Oct 2014 03:42:08 -0400
Message-ID: <1414741319.3014.4.camel@jlt4.sipsolutions.net> (sfid-20141031_084210_446659_9CED1155)
Subject: Re: [RFC v2 2/4] backports: replace BACKPORT_PWD with BACKPORT_DIR
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org, linux-kernel@vger.kernel.org,
	yann.morin.1998@free.fr, mmarek@suse.cz, sassmann@kpanic.de,
	"Luis R. Rodriguez" <mcgrof@suse.com>
Date: Fri, 31 Oct 2014 08:41:59 +0100
In-Reply-To: <1414570902-5675-3-git-send-email-mcgrof@do-not-panic.com> (sfid-20141029_092415_159248_4CCB658A)
References: <1414570902-5675-1-git-send-email-mcgrof@do-not-panic.com>
	 <1414570902-5675-3-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20141029_092415_159248_4CCB658A)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2014-10-29 at 01:21 -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
> 
> This will also be used for built-in kernel integration, by
> using this we can share more code with the built-in kernel
> approach.

I see no issues with this, looks like a straight rename.

johannes

