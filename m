Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:33018 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752513AbeB1TYY (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 28 Feb 2018 14:24:24 -0500
From: Luca Coelho <luca@coelho.fi>
To: backports@vger.kernel.org
Cc: hauke@hauke-m.de, luciano.coelho@intel.com, sara.sharon@intel.com
Date: Wed, 28 Feb 2018 21:24:17 +0200
Message-Id: <20180228192417.7292-1-luca@coelho.fi> (sfid-20180228_202426_061481_913FC55D)
Subject: [PATCH] backport: move percpu.h file to the correct location
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Luca Coelho <luciano.coelho@intel.com>

Mistakenly, the percpu.h file was added to a new backport-include
directory at the root.  It should be in the proper location at
backport/backport-include instead.  Fix that.

Fixes: a4c44dbee35d ("backport: implement alloc_percpu_gfp() for < 3.18.")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 {backport-include => backport/backport-include}/linux/percpu.h | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename {backport-include => backport/backport-include}/linux/percpu.h (100%)

diff --git a/backport-include/linux/percpu.h b/backport/backport-include/linux/percpu.h
similarity index 100%
rename from backport-include/linux/percpu.h
rename to backport/backport-include/linux/percpu.h
-- 
2.16.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
