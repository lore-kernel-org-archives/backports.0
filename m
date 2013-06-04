Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:39867 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751416Ab3FDK7x (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 4 Jun 2013 06:59:53 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id D79EB205A3
	for <backports@vger.kernel.org>; Tue,  4 Jun 2013 10:59:52 +0000 (UTC)
Received: from bugzilla.kernel.org (bugzilla.kernel.org [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 2670720588
	for <backports@vger.kernel.org>; Tue,  4 Jun 2013 10:59:52 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 51851] Unable to use alx driver without CONFIG_MDIO
In-Reply-To: <bug-51851-58281@https.bugzilla.kernel.org/>
References: <bug-51851-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Message-Id: <20130604105952.1D78911F9D3@bugzilla.kernel.org> (sfid-20130604_125955_855268_BAD2F80A)
Date: Tue,  4 Jun 2013 10:59:52 +0000 (UTC)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=51851


bei <zhchun.bei@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |zhchun.bei@gmail.com




--- Comment #2 from bei <zhchun.bei@gmail.com>  2013-06-04 10:59:51 ---
compat-drivers-3.9-rc4-2-su or compat-drivers-2013-03-28-5-u with
kernel-3.9.4-gentoo on Gentoo Linux still not working.
alx: Unknown symbol mdio_mii_ioctl (err 0)

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug.
