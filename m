Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60649 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751580AbaL3HD5 (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 30 Dec 2014 02:03:57 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id CB8292012E
	for <backports@vger.kernel.org>; Tue, 30 Dec 2014 07:03:55 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 1144D2010E
	for <backports@vger.kernel.org>; Tue, 30 Dec 2014 07:03:55 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 90491] New: filter timeout warning during channel
 scanning(DVB_T EyeTV_DTT_0fd9_003f)
Date: Tue, 30 Dec 2014 07:03:54 +0000
Message-ID: <bug-90491-58281@https.bugzilla.kernel.org/> (sfid-20141230_080359_345133_1F7F1DC0)
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=90491

            Bug ID: 90491
           Summary: filter timeout warning during channel scanning(DVB_T
                    EyeTV_DTT_0fd9_003f)
           Product: Backports project
           Version: unspecified
    Kernel Version: 3.10.35
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Backports
          Assignee: backports@vger.kernel.org
          Reporter: rickwang.syno@gmail.com
        Regression: No

Hi all,

My Backports version is v3.18-rc1-1-0-g1f4af51.
I live in Taiwan, when I use this dongle(EyeTV_DTT 0fd9:003f) to scan channels,
I only got 16 channels, which should have got 20 channels.

I only found my scanning logs showed something about that 4 missing
channels(frequency 581000000) as below, while dmesg shows nothing:

PAT
PMT 0x07d0 for service 0x00c8
SDT (actual TS)
>>> tune to: 581000000:INVERSION_AUTO:BANDWIDTH_6_MHZ:FEC_AUTO:FEC_AUTO:QAM_AUTO:TRANSMISSION_MODE_AUTO:GUARD_INTERVAL_AUTO:HIERARCHY_NONE
>>> tuning status == 0x0b
>>> tuning status == 0x1b
WARNING: filter timeout pid 0x0011
WARNING: filter timeout pid 0x0000


But when i try another dongle(Nova-T_Stick 2040/7070), i can get all of 20
channels.

does anyone have any idea how to solve this problem?


Thanks for any help!

-- 
You are receiving this mail because:
You are the assignee for the bug.
