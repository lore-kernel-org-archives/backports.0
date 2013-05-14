Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:52109 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757884Ab3ENTce (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 14 May 2013 15:32:34 -0400
Message-ID: <1368559950.12858.9.camel@jlt4.sipsolutions.net> (sfid-20130514_213237_189358_D0486989)
Subject: Re: [PATCH v2] backports: don't backport rfkill, only API
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: sameo@linux.intel.com
Date: Tue, 14 May 2013 21:32:30 +0200
In-Reply-To: <1368559736-14602-1-git-send-email-johannes@sipsolutions.net> (sfid-20130514_212904_539236_35FDB1E5)
References: <1368559736-14602-1-git-send-email-johannes@sipsolutions.net>
	 (sfid-20130514_212904_539236_35FDB1E5)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2013-05-14 at 21:28 +0200, Johannes Berg wrote:

> If the base kernel is 2.6.33 or higher (with the new rfkill API)
> then just wrap the API and disable rfkill registrations for any
> types that the base kernel doesn't know about.

Basically, this means that any type not present in the base kernel (e.g.
NFC on any base kernel < 3.10) won't get rfkill. As I outlined, I think
that's a useful compromise, having all the rfkill stuff but not being
able to use it because it's in /dev/rfkill_backport won't help either.

johannes

