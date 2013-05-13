Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:47014 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170Ab3EMMIR (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 13 May 2013 08:08:17 -0400
Message-ID: <1368446891.8300.25.camel@jlt4.sipsolutions.net> (sfid-20130513_140820_192933_82FDBDF9)
Subject: Re: [PATCH v2 1/5] backports: backport rfkill properly
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>
Date: Mon, 13 May 2013 14:08:11 +0200
In-Reply-To: <1368298469-29143-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20130511_205441_505600_DB2F8E73)
References: <1368298469-29143-1-git-send-email-mcgrof@do-not-panic.com>
	 <1368298469-29143-2-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20130511_205441_505600_DB2F8E73)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sat, 2013-05-11 at 11:54 -0700, Luis R. Rodriguez wrote:
>   * For kernels >= 2.6.31:
>         o use the standard
>                 /dev/rfkill
>                 /sys/class/rfkill

I think this is wrong. It means that if you build rfkill (e.g. for 3.2)
then it would conflict with the kernel's rfkill.

The thing is that *usually*, for >=2.6.31, you just want to use the
kernel's rfkill. So for that usage, we should backport the rfkill API,
like we usually backport things.

However, NFC probably requires a backported rfkill, not just backporting
around rfkill. For this we do need it named rfkill_backport though, I
think.

Maybe we can backport the NFC support in some other way?

johannes

