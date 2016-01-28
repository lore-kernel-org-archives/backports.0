Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51184 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933741AbcA1AKI convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 27 Jan 2016 19:10:08 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id BC8E720117
	for <backports@vger.kernel.org>; Thu, 28 Jan 2016 00:10:07 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id F2C3A20107
	for <backports@vger.kernel.org>; Thu, 28 Jan 2016 00:10:06 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 111401] New: Missing country on atheros driver regd_common.h
 and regd.h
Date: Thu, 28 Jan 2016 00:10:06 +0000
Message-ID: <bug-111401-58281@https.bugzilla.kernel.org/> (sfid-20160128_011011_674085_C1838744)
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=111401

            Bug ID: 111401
           Summary: Missing country on atheros driver regd_common.h and
                    regd.h
           Product: Backports project
           Version: unspecified
    Kernel Version: backports-4.0.1-1
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Backports
          Assignee: backports@vger.kernel.org
          Reporter: brunoaduarte@hotmail.com
        Regression: No

Country Guyana is missing from the enums in these files.

wireless-regdb-2015.12.14 -> db.txt
country GY:
    (2402 - 2482 @ 40), (30)
    (5735 - 5835 @ 80), (30)

regd_common.h
> {CTRY_GUYANA, NULL1_WORLD, "GY"},


regd.h
> enum CountryCode {
>	CTRY_ALBANIA = xx,
> ...

-- 
You are receiving this mail because:
You are the assignee for the bug.--
To unsubscribe from this list: send the line "unsubscribe backports" in
