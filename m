Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:55457 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbaEBBHB (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 1 May 2014 21:07:01 -0400
Received: by mail-pd0-f180.google.com with SMTP id x10so3876968pdj.25
        for <backports@vger.kernel.org>; Thu, 01 May 2014 18:07:00 -0700 (PDT)
Date: Thu, 1 May 2014 18:06:54 -0700
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] backports: remove mac80211.h
Message-ID: <20140502010654.GD957@garbanzo.do-not-panic.com> (sfid-20140502_030706_344907_4547FED5)
References: <1398686818-16234-1-git-send-email-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1398686818-16234-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, Apr 28, 2014 at 02:06:58PM +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> As support for old kernels has been removed, there's no need to keep
> around the mac80211.h file that redefines the ieee80211_rx() symbol;
> In 2.6.32 this name was changed to belong to mac80211.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Applied, thanks!
s
