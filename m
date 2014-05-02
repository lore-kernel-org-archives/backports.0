Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:48558 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbaEBA6E (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 1 May 2014 20:58:04 -0400
Received: by mail-pa0-f49.google.com with SMTP id kq14so4512044pab.22
        for <backports@vger.kernel.org>; Thu, 01 May 2014 17:58:03 -0700 (PDT)
Date: Thu, 1 May 2014 17:57:57 -0700
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: [PATCH] git-tracker: restrict shortlog to existing files
Message-ID: <20140502005757.GA957@garbanzo.do-not-panic.com> (sfid-20140502_025806_844826_B4103A15)
References: <1398367178.4154.3.camel@jlt4.sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1398367178.4154.3.camel@jlt4.sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, Apr 24, 2014 at 09:19:38PM +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> When the git-tracker updates through a merge commit or
> otherwise multiple kernel commits, it appends a shortlog
> of all the changes. That's fine, but is often unhelpful
> since it's so large - restrict it to the files that are
> actually backported to make it more readable.
> 
> While at it, rewrite the bpgit.status() helper function
> to actually do something useful.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Applied, thanks!

  Luis
