Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:47286 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503AbaEBBHm (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 1 May 2014 21:07:42 -0400
Received: by mail-pa0-f50.google.com with SMTP id rd3so4507495pab.37
        for <backports@vger.kernel.org>; Thu, 01 May 2014 18:07:41 -0700 (PDT)
Date: Thu, 1 May 2014 18:07:37 -0700
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] backports: remove more old ifdef/compat code
Message-ID: <20140502010737.GE957@garbanzo.do-not-panic.com> (sfid-20140502_030758_231041_B084CC3D)
References: <1398690735-6313-1-git-send-email-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1398690735-6313-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, Apr 28, 2014 at 03:12:15PM +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Since support for kernels < 3.0 was removed, there's now a bunch
> of dead code that can be removed - do it.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Thanks! Applied and stuff.

  Luis
