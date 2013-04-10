Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:60153 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752758Ab3DJNsW (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 10 Apr 2013 09:48:22 -0400
Message-ID: <1365601698.4235.19.camel@jlt4.sipsolutions.net> (sfid-20130410_154823_538634_4A9E7264)
Subject: Re: [PATCH 18/18] backports: add update-initramfs support
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org
Date: Wed, 10 Apr 2013 15:48:18 +0200
In-Reply-To: <1365593728-5720-19-git-send-email-mcgrof@do-not-panic.com> (sfid-20130410_133704_968712_2A471864)
References: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
	 <1365593728-5720-19-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20130410_133704_968712_2A471864)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2013-04-10 at 04:35 -0700, Luis R. Rodriguez wrote:

> +KLIB=1

pretty sure that should be "$1" or at least just $1 ?

johannes


