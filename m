Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:43786 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753788Ab3DMU5b (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 16:57:31 -0400
Message-ID: <1365886647.1089.2.camel@jlt4.sipsolutions.net> (sfid-20130413_225733_826269_752ED546)
Subject: Re: [PATCH 3/7] compat: backport IORESOURCE_REG definition
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org
Date: Sat, 13 Apr 2013 22:57:27 +0200
In-Reply-To: <1365862424-6530-4-git-send-email-mcgrof@do-not-panic.com> (sfid-20130413_161406_771904_BD2A16FF)
References: <1365862424-6530-1-git-send-email-mcgrof@do-not-panic.com>
	 <1365862424-6530-4-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20130413_161406_771904_BD2A16FF)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sat, 2013-04-13 at 07:13 -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
> 
> This was added to help regmap drivers avoid having
> to use some non memory mapped equivalent, IORESOURCE_IO,
> to help avoid confusion. This is simply carried over.

Applied.

johannes

