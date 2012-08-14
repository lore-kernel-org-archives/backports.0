Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:26088 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757066Ab2HNTAq (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 14 Aug 2012 15:00:46 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q7EJ0ikh014483
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <backports@vger.kernel.org>; Tue, 14 Aug 2012 15:00:46 -0400
Received: from quad.redhat.com (vpn-10-121.rdu.redhat.com [10.11.10.121])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q7EJ0h1Y003968
	for <backports@vger.kernel.org>; Tue, 14 Aug 2012 15:00:44 -0400
From: Andy Gospodarek <andy@greyhouse.net>
To: backports@vger.kernel.org
Subject: [PATCH 0/5] compat: additional patches needed for RHEL6.3 support
Date: Tue, 14 Aug 2012 14:59:44 -0400
Message-Id: <1344970789-13047-1-git-send-email-andy@greyhouse.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The following patches should round out support for RHEL6.3 for compat.

After applying the patches I ran ckmake and get the following results.

Trying kernel 3.5.0-030500-generic [OK]
Trying kernel 3.4.4-030404-generic [OK]
Trying kernel 3.3.7-030307-generic [OK]
Trying kernel 3.2.2-030202-generic [OK]
Trying kernel 3.1.10-030110-generic [OK]
Trying kernel 3.0.18-030018-generic [OK]
Trying kernel 2.6.39-02063904-generic [OK]
Trying kernel 2.6.38-02063808-generic [OK]
Trying kernel 2.6.37-02063706-generic [OK]
Trying kernel 2.6.36-02063604-generic [OK]
Trying kernel 2.6.35-02063512-generic [OK]
Trying kernel 2.6.34-02063410-generic [OK]
Trying kernel 2.6.33-02063305-generic [OK]
Trying kernel 2.6.32-02063255-generic [OK]
Trying kernel 2.6.31-02063113-generic [OK]
Trying kernel 2.6.30-02063010-generic [OK]
Trying kernel 2.6.29-02062906-generic [OK]
Trying kernel 2.6.28-02062810-generic [OK]
Trying kernel 2.6.27-020627-generic [OK]
Trying kernel 2.6.26-020626-generic [OK]
Trying kernel 2.6.25-020625-generic [OK]
Trying kernel 2.6.24-020624-generic [OK]

Andy Gospodarek (5):
  compat: RHEL build script fixup from upstream
  compat: fix defines for RHEL by adding RHEL to string
  compat: disable KFIFO on RHEL6.1 and later
  compat: disable compat firmware module on RHEL6.0 and later
  compat: fixup firmware defines on RHEL6

 include/linux/compat-2.6.33.h |    2 ++
 scripts/gen-compat-config.sh  |   14 +++++++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

