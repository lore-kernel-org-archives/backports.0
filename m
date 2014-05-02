Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:45343 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664AbaEBBIE (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 1 May 2014 21:08:04 -0400
Received: by mail-pa0-f51.google.com with SMTP id fb1so4502161pad.24
        for <backports@vger.kernel.org>; Thu, 01 May 2014 18:08:02 -0700 (PDT)
Date: Thu, 1 May 2014 18:07:57 -0700
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 1/2] backports: remove IWLWIFI_P2P from iwlwifi defconfig
Message-ID: <20140502010757.GF957@garbanzo.do-not-panic.com> (sfid-20140502_030805_690122_00A0FAE6)
References: <1398763888-20688-1-git-send-email-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1398763888-20688-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, Apr 29, 2014 at 11:31:27AM +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> This symbol is obsolete, it was removed upstream, so just
> remove it from the defconfig file as well.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Thanks, applied!

  Luis
