Return-path: <backports-owner@vger.kernel.org>
Received: from cluster-d.mailcontrol.com ([85.115.60.190]:49450 "EHLO
	cluster-d.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754194AbbGJLXA convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 10 Jul 2015 07:23:00 -0400
Received: from banapppus01.asia.root.pri (static-42.188.93.111-tataidc.co.in [111.93.188.42] (may be forged))
	by rly07d.srv.mailcontrol.com (MailControl) with ESMTP id t6ABMtuN048911
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <backports@vger.kernel.org>; Fri, 10 Jul 2015 12:22:57 +0100
From: Arunkumar K <Arunkumar.K@csr.com>
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Query regarding back porting of upstreamed Linux kernel drivers
Date: Fri, 10 Jul 2015 11:22:52 +0000
Message-ID: <b43797e602f34e10a7924f0d3b6a1368@BANASIEXM02.ASIA.ROOT.PRI> (sfid-20150710_132308_695446_378530BA)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,

I have the following queries regarding back porting of up-streamed Linux kernel driver:

Suppose a new driver is added to Linux mainline in release 4.2, will the developer who added new driver to the mainline need to submit the changes for back porting to the backports git?

Or will the backports project team be doing the back porting of the new driver?


>From the following page https://backports.wiki.kernel.org/index.php/Main_Page

"Current versions of backports support all mainline kernels starting with version 3.0, for kernel versions older than 3.0 please use backports-3.14, which supports all kernel versions back to 2.6.26."

Suppose we have release backports-4.2 and new driver has been backported. Will it have support only till kernel version 3.0. Suppose if the new driver needs to be supported in version 2.6.32 what is the process followed?

Regards,
Arun



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
You can now access the wide range of products powered by aptX at www.aptx.com
--
To unsubscribe from this list: send the line "unsubscribe backports" in
