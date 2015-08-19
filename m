Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:56731 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751498AbbHSJkX (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 19 Aug 2015 05:40:23 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.86)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ZRzr3-0003MR-Vl
	for backports@vger.kernel.org; Wed, 19 Aug 2015 11:40:22 +0200
Message-ID: <1439977220.2089.3.camel@sipsolutions.net> (sfid-20150819_114025_184409_20DA6EB3)
Subject: Re: [PATCH] git-tracker: read INPUT_HTTP[S]_PROXY environment
 variable
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Date: Wed, 19 Aug 2015 11:40:20 +0200
In-Reply-To: <1439976363.2089.2.camel@sipsolutions.net> (sfid-20150819_112609_092507_D1F11647)
References: <1439976363.2089.2.camel@sipsolutions.net>
	 (sfid-20150819_112609_092507_D1F11647)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2015-08-19 at 11:26 +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> This allows using a different HTTP[S] proxy for input and output
> trees, if necessary.
> 

Oops, this was incomplete - will send v2.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
