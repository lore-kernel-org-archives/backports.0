Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:58458 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754799Ab3EVMFK (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 22 May 2013 08:05:10 -0400
Message-ID: <1369224306.8207.7.camel@jlt4.sipsolutions.net> (sfid-20130522_140511_583011_5B11BF46)
Subject: Re: [PATCH 6/9] lib/bpgit.py: add support for git paranoia
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org
Date: Wed, 22 May 2013 14:05:06 +0200
In-Reply-To: <1369222478-30577-7-git-send-email-mcgrof@do-not-panic.com> (sfid-20130522_133517_032877_8CD5B8EE)
References: <1369222478-30577-1-git-send-email-mcgrof@do-not-panic.com>
	 <1369222478-30577-7-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20130522_133517_032877_8CD5B8EE)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2013-05-22 at 04:34 -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
> 
> This cleans sanitizes a source tree and ensures
> no content is present from what was intended.

All of this (including the previous patches) makes me think
"--git-revision HEAD" should just be the default instead of trying to
muck with the working directory of the kernel tree too much?

johannes

