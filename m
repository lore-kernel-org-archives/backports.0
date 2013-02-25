Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from fep28.mx.upcmail.net ([62.179.121.48]:64734 "EHLO
	fep28.mx.upcmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529Ab3BYL2z (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 25 Feb 2013 06:28:55 -0500
Received: from edge03.upcmail.net ([192.168.13.238])
          by viefep17-int.chello.at
          (InterMail vM.8.01.05.05 201-2260-151-110-20120111) with ESMTP
          id <20130225112657.VXSV18677.viefep17-int.chello.at@edge03.upcmail.net>
          for <backports@vger.kernel.org>; Mon, 25 Feb 2013 12:26:57 +0100
Message-ID: <1361791599.9408.7.camel@Halley>
Subject: conpat-drivers: scripts/admin-update.sh fails with patches being in
 subfolder "patches"
From: Stefan Kuhn <stefan.kuhn@hispeed.ch>
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Mon, 25 Feb 2013 12:26:39 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi all

I'm packaging "compat-drivers" for Gentoo/Pentoo.
The docu at
https://backports.wiki.kernel.org/index.php/Documentation/compat-drivers/hacking
mentions running script:
"scripts/admin-update.sh -s refresh"

But that dies until all patches are moved out of the folder "patches":
mv patches/* .

Reason for the failure is commit:
bb67ef032a61f5d0fdc6fa32ee28ed94503555e4
where all patches were moved to that subfolder "patches".

Pls tell if I should put this on bugzilla or anywhere else?

Best regards
Stefan

