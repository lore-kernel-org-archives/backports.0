Return-path: <backports-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:59217 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162278Ab3DERx3 (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 5 Apr 2013 13:53:29 -0400
Message-ID: <515F0F96.2080808@linux.intel.com> (sfid-20130405_195331_395863_CD59B692)
Date: Fri, 05 Apr 2013 19:53:26 +0200
From: Thierry Escande <thierry.escande@linux.intel.com>
MIME-Version: 1.0
To: Hauke Mehrtens <hauke@hauke-m.de>
CC: backports@vger.kernel.org
Subject: Re: [PATCH v2 2/5] backports: Add NFC core and drivers
References: <1365175014-6028-2-git-send-email-thierry.escande@linux.intel.com> <515EF012.6070301@hauke-m.de>
In-Reply-To: <515EF012.6070301@hauke-m.de>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 04/05/2013 05:38 PM, Hauke Mehrtens wrote:
> 
> include/uapi/linux/socket.h contains headers for kernel internal apis
> which are not backported, do not copy the header into backports when you
> do not add the implementation of the defined functions in backports,
> which you probably do not want.

include/linux/socket.h is not needed actually
Just need to add SOL_NFC definition in compat-3.10.h

 Thierry
