Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:43770 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756205Ab3GKWxw (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 11 Jul 2013 18:53:52 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id B11A3201ED
	for <backports@vger.kernel.org>; Thu, 11 Jul 2013 22:53:51 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id CE90E201B7
	for <backports@vger.kernel.org>; Thu, 11 Jul 2013 22:53:50 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 51851] Unable to use alx driver without CONFIG_MDIO
Date: Thu, 11 Jul 2013 22:53:50 +0000
Message-ID: <bug-51851-58281-9T9vkSnn6h@https.bugzilla.kernel.org/> (sfid-20130712_005355_279160_B4A8BC50)
In-Reply-To: <bug-51851-58281@https.bugzilla.kernel.org/>
References: <bug-51851-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=51851

Norman Shulman <norman.shulman@n-dimension.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |norman.shulman@n-dimension.
                   |                            |com

--- Comment #3 from Norman Shulman <norman.shulman@n-dimension.com> ---
Still a problem with

nshulman@nvshp:/usr/src/linux
$ uname -r
3.9.5-hardened

and backports-20130618

-- 
You are receiving this mail because:
You are the assignee for the bug.
