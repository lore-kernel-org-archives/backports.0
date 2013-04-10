Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:60150 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936468Ab3DJNru (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 10 Apr 2013 09:47:50 -0400
Message-ID: <1365601666.4235.18.camel@jlt4.sipsolutions.net> (sfid-20130410_154805_319156_99ABFDD8)
Subject: Re: [PATCH 16/18] backports: add udev rules if required for
 backported firmware_class
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org
Date: Wed, 10 Apr 2013 15:47:46 +0200
In-Reply-To: <1365593728-5720-17-git-send-email-mcgrof@do-not-panic.com> (sfid-20130410_133654_279802_E5324896)
References: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
	 <1365593728-5720-17-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20130410_133654_279802_E5324896)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Oh, I wonder if there's a way to know this isn't needed on newer
kernels? But I guess it doesn't really hurt anyway.

johannes

