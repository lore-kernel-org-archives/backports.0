Return-path: <backports-owner@vger.kernel.org>
Received: from 162-17-110-37-static.hfc.comcastbusiness.net ([162.17.110.37]:35603
	"EHLO stuffed.shaftnet.org" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753220Ab3HQNDD (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 17 Aug 2013 09:03:03 -0400
Received: from stuffed.shaftnet.org (localhost [127.0.0.1])
	by stuffed.shaftnet.org (8.14.7/8.14.7) with ESMTP id r7HD30OC004545
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <backports@vger.kernel.org>; Sat, 17 Aug 2013 09:03:00 -0400
Received: (from pizza@localhost)
	by stuffed.shaftnet.org (8.14.7/8.14.7/Submit) id r7HD30G3004544
	for backports@vger.kernel.org; Sat, 17 Aug 2013 09:03:00 -0400
From: Solomon Peachy <pizza@shaftnet.org>
To: backports@vger.kernel.org
Subject: [PATCH v2 0/4] Enable cw1200 on >=2.6.34
Date: Sat, 17 Aug 2013 09:02:55 -0400
Message-Id: <1376744579-4245-1-git-send-email-pizza@shaftnet.org> (sfid-20130817_150305_654787_E65ABD2A)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This superscedes the earlier patch set I posted when apparently sleep 
deprived.  It enables the cw1200_wlan_sdio driver to build cleanly on 
>=2.6.34 kernels, and the cw1200_wlan_spi driver to build cleanly on 
>=2.6.35 kernels.

