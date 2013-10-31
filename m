Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:41966 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752450Ab3JaKVf (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 31 Oct 2013 06:21:35 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id A68DB203DC
	for <backports@vger.kernel.org>; Thu, 31 Oct 2013 10:21:33 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 03291202B8
	for <backports@vger.kernel.org>; Thu, 31 Oct 2013 10:21:29 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 64091] backports build error
Date: Thu, 31 Oct 2013 10:21:28 +0000
Message-ID: <bug-64091-58281-2OG1KsW1nf@https.bugzilla.kernel.org/> (sfid-20131031_112137_388648_8FD73F91)
In-Reply-To: <bug-64091-58281@https.bugzilla.kernel.org/>
References: <bug-64091-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=64091

Hauke Mehrtens <hauke@hauke-m.de> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |hauke@hauke-m.de

--- Comment #2 from Hauke Mehrtens <hauke@hauke-m.de> ---
I looked into these error messages and I do not know my you get them. On our
test build with kernel 2.6.27.62 we haven't seen such an error, but this was
done with gcc-4.7.3.

Is it correct that you have a 2.6.27.57 kernel? What gcc version are you using?

For the first error in bitmap.h:145:

bitmap.h:
#include <linux/bitops.h>
#include <linux/kernel.h>
...
int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);

bitops.h
#define BITS_TO_LONGS(nr)    DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))

kernel.h:
#define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))


You kernel.h is modified for me the include for types.h is in line 3, in your
error message it is in line 13.

Please post the first 25 lines of your kernel.h

You haven't installed the Module.symvers which is needed, this is probably
provided by some kernel development package.

-- 
You are receiving this mail because:
You are the assignee for the bug.
