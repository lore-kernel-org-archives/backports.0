Return-path: <backports-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:61518 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751068AbaASRAV convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 19 Jan 2014 12:00:21 -0500
From: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To: Hauke Mehrtens <hauke@hauke-m.de>,
	"mcgrof@do-not-panic.com" <mcgrof@do-not-panic.com>
CC: "backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: RE: [PATCH 01/16] backports: adapt to changes in netdev
 select_queue call
Date: Sun, 19 Jan 2014 17:00:16 +0000
Message-ID: <0BA3FCBA62E2DC44AF3030971E174FB303D40C23@HASMSX103.ger.corp.intel.com> (sfid-20140119_180023_234921_FA287070)
References: <1390150057-11652-1-git-send-email-hauke@hauke-m.de>
 <1390150057-11652-2-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1390150057-11652-2-git-send-email-hauke@hauke-m.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

> Subject: [PATCH 01/16] backports: adapt to changes in netdev select_queue
> call
> 
> This patch reverts the changes done in the following commit for older kernel
> versions:
> commit f663dd9aaf9ed124f25f0f8452edf238f087ad50
> Author: Jason Wang <jasowang@redhat.com>
> Date:   Fri Jan 10 16:18:26 2014 +0800
> 
>     net: core: explicitly select a txq before doing l2 forwarding
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> CC: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This is obviously much better than my version :)
Thanks!

