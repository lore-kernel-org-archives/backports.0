Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57728 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754502AbbCLRmN (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 12 Mar 2015 13:42:13 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 7713220251
	for <backports@vger.kernel.org>; Thu, 12 Mar 2015 17:42:12 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 1F66620373
	for <backports@vger.kernel.org>; Thu, 12 Mar 2015 17:42:11 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 94811] New: Backport kernel integration fails
Date: Thu, 12 Mar 2015 17:42:10 +0000
Message-ID: <bug-94811-58281@https.bugzilla.kernel.org/> (sfid-20150312_184215_908688_40254576)
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=94811

            Bug ID: 94811
           Summary: Backport kernel integration fails
           Product: Backports project
           Version: unspecified
    Kernel Version: linux-next-20150306
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Backports
          Assignee: backports@vger.kernel.org
          Reporter: mikem388@gmail.com
        Regression: No

I installed the latest the latest coccinelle and the backport seems to
beworking until I hit this failure.

I am trying to backport to the linux-3.4.y branch. This is the first time I
have used this tool so I have probably done something wrong, but I am stuck.

Thanks for any help.

Mike


spatch version 1.0.0-rc24 with Python support and with PCRE support

mike@mikes-laptop:~/gentree$ ./gentree.py --integrate --clean --gitdebug
--git-revision v3.19 ~/devel/integrate/linux-next/
~/devel/integrate/linux-stable/
Get original source files from git ...
Applying patches from patches to
/home/mike/devel/integrate/linux-stable/backports/ ...
Failed to apply changes from
collateral-evolutions/network/0027-genl-const/nl80211.patch
> patching file net/wireless/nl80211.c
> Hunk #2 FAILED at 58.
> Hunk #3 succeeded at 9937 (offset -220 lines).
> Hunk #4 succeeded at 10006 (offset -220 lines).
> Hunk #5 succeeded at 10035 (offset -220 lines).
> 1 out of 5 hunks FAILED -- saving rejects to file net/wireless/nl80211.c.rej
Traceback (most recent call last):
  File "./gentree.py", line 1091, in <module>
    ret = _main()
  File "./gentree.py", line 724, in _main
    logwrite=logwrite)
  File "./gentree.py", line 906, in process
    apply_patches(args, "backport", source_dir, 'patches', bpid.target_dir,
logwrite)
  File "./gentree.py", line 552, in apply_patches
    raise Exception('Patch failed')
Exception: Patch failed


mike@mikes-laptop:~/devel/integrate/linux-stable/backports$ cat
net/wireless/nl80211.c.rej
--- net/wireless/nl80211.c
+++ net/wireless/nl80211.c
@@ -58,7 +58,7 @@
        NL80211_MCGRP_TESTMODE /* keep last - ifdef! */
 };

-static const struct genl_multicast_group nl80211_mcgrps[] = {
+static __genl_const struct genl_multicast_group nl80211_mcgrps[] = {
        [NL80211_MCGRP_CONFIG] = { .name = NL80211_MULTICAST_GROUP_CONFIG },
        [NL80211_MCGRP_SCAN] = { .name = NL80211_MULTICAST_GROUP_SCAN },
        [NL80211_MCGRP_REGULATORY] = { .name = NL80211_MULTICAST_GROUP_REG },
mike@mikes-laptop:~/devel/integrate/linux-stable/backports$

-- 
You are receiving this mail because:
You are the assignee for the bug.
