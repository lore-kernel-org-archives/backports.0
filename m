Return-path: <backports-owner@vger.kernel.org>
Received: from boosthardware.com ([88.198.122.139]:33608 "EHLO
	boosthardware.localdomain" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756534AbaGQQB6 (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 17 Jul 2014 12:01:58 -0400
Message-ID: <53203.108.179.34.114.1405611022.squirrel@boosthardware.com> (sfid-20140717_180159_779141_831E65FB)
Date: Fri, 18 Jul 2014 01:30:22 +1000 (EST)
Subject: backport 3.12 to 3.4
From: "Patrick Shirkey" <pshirkey@boosthardware.com>
To: backports@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,

I am running 3.4.39 on an arm platform which I cannot easily upgrade to a
newer kernel.

I would like like to test an experimental driver for the nfc chipset pn532
which is written against 3.12

Unfortunately the chipset is different enough from pn533 that it needs
it's own driver.

Is there a backport of 3.12 nfc codebase to 3.4.39 available somewhere?




--
Patrick Shirkey
Boost Hardware Ltd
