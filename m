Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:51819 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbaEBBNZ (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 1 May 2014 21:13:25 -0400
Received: by mail-pd0-f179.google.com with SMTP id g10so1680256pdj.38
        for <backports@vger.kernel.org>; Thu, 01 May 2014 18:13:24 -0700 (PDT)
Date: Thu, 1 May 2014 18:13:20 -0700
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 2/2] gentree: strip useless defconfig files
Message-ID: <20140502011320.GG957@garbanzo.do-not-panic.com> (sfid-20140502_031327_292592_9F314010)
References: <1398763888-20688-1-git-send-email-johannes@sipsolutions.net>
 <1398763888-20688-2-git-send-email-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1398763888-20688-2-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, Apr 29, 2014 at 11:31:28AM +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> If a defconfig file has symbols that can't be satisfied
> with the given copy-list file, then there's no point in
> shipping it, so just copy selectively the ones needed.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

That's pretty neat, thanks! Applied!

  Luis
