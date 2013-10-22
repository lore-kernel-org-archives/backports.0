Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:57886 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753971Ab3JVTXO (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 22 Oct 2013 15:23:14 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id E2DF8204A7
	for <backports@vger.kernel.org>; Tue, 22 Oct 2013 19:23:12 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id E3555204A0
	for <backports@vger.kernel.org>; Tue, 22 Oct 2013 19:23:11 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 63381] cpumask.h error
Date: Tue, 22 Oct 2013 19:23:07 +0000
Message-ID: <bug-63381-58281-zt4w6SGVBg@https.bugzilla.kernel.org/> (sfid-20131022_212315_905089_DB1594E2)
In-Reply-To: <bug-63381-58281@https.bugzilla.kernel.org/>
References: <bug-63381-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=63381

--- Comment #2 from DarinV <darin.vancoevering@gmail.com> ---
2.6.27.57 patches for bootsplash and squashfs 3. No issues building with
the 3.8.3 version and it is for x86. Mainline with only those 2 patches as
I built my own kernel for the SuperGamer Distro. What changed going from
the 3.8.3 to the 3.9 versions? I may have to build the the drivers with
stock kernel then build the kernel last with patches but was hoping I
didn't have to.


On Mon, Oct 21, 2013 at 10:46 AM, <bugzilla-daemon@bugzilla.kernel.org>wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=63381
>
> Hauke Mehrtens <hauke@hauke-m.de> changed:
>
>            What    |Removed                     |Added
>
> ----------------------------------------------------------------------------
>                  CC|                            |hauke@hauke-m.de
>
> --- Comment #1 from Hauke Mehrtens <hauke@hauke-m.de> ---
> What kernel are you compiling against? We only test this with mainline
> kernels,
> but when you have a patched kernel like one provided by distributions like
> RedHat, they contain many patches which are conflicting with backports.
>
> Are you compiling for x86 or for some other arch?
>
> --
> You are receiving this mail because:
> You reported the bug.
>

-- 
You are receiving this mail because:
You are the assignee for the bug.
