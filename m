Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:42817 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753288AbaDKR6n (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 11 Apr 2014 13:58:43 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 53E6C2015E
	for <backports@vger.kernel.org>; Fri, 11 Apr 2014 17:58:42 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 5AEA820154
	for <backports@vger.kernel.org>; Fri, 11 Apr 2014 17:58:41 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 73861] New: AWUS 036NHR v.2 8188RU cant associate and cant
 capture handshake.
Date: Fri, 11 Apr 2014 17:58:40 +0000
Message-ID: <bug-73861-58281@https.bugzilla.kernel.org/> (sfid-20140411_195845_654859_03FB5ACB)
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=73861

            Bug ID: 73861
           Summary: AWUS 036NHR v.2 8188RU cant associate and cant capture
                    handshake.
           Product: Backports project
           Version: unspecified
    Kernel Version: Linux kali 3.12-kali1-686-pae #1 SMP Debian
                    3.12.6-2kali1 (2014-01-06) i686 GNU
          Hardware: i386
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: Backports
          Assignee: backports@vger.kernel.org
          Reporter: youlold@gmail.com
        Regression: No

https://monosnap.com/image/XYdmelapIpF6Q84vsStXLGjqok1Rc3.png
 CH  2 ][ Elapsed: 32 s ][ 2014-04-11 21:55                                     

 BSSID              STATION            PWR   Rate    Lost    Frames  Probe      

 (not associated)   08:ED:B9:B4:03:11  -73    0 - 1      0        2             
 (not associated)   10:08:C1:5D:55:46  -73    0 - 1      0        1 
katerina1950                                                           
 (not associated)   14:F4:2A:6C:47:34  -53    0 - 1      0       11  Wive-RTNL  
 (not associated)   50:B7:C3:1A:9C:7F  -59    0 - 1      0        3             
 (not associated)   EC:55:F9:7A:6B:2E  -65    0 - 1      0        1  X-ZIBIT    
 (not associated)   BC:0F:2B:6B:10:0D  -65    0 - 1     77        6             
 (not associated)   C0:F8:DA:B0:FD:41  -67    0 - 1      0        3             
 (not associated)   C0:18:85:79:3F:1B  -69    0 - 1      0        1             
 (not associated)   B8:03:05:7F:7E:61  -73    0 - 1      0        1             
 (not associated)   E8:03:9A:CD:49:EC  -73    0 - 1      0        1

-- 
You are receiving this mail because:
You are the assignee for the bug.
