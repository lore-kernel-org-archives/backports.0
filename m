Return-path: <backports-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:42892 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752095AbbHaNVP (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 31 Aug 2015 09:21:15 -0400
Subject: Re: newbie questions
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
References: <55E3A03D.6050607@linux.intel.com>
 (sfid-20150831_023101_616135_D37C8DBB)
 <1441006988.13980.3.camel@sipsolutions.net>
 <55E44DA7.3000209@linux.intel.com>
 <1441025664.13980.8.camel@sipsolutions.net>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <55E454C9.5070302@linux.intel.com> (sfid-20150831_152116_888193_1CB702F9)
Date: Mon, 31 Aug 2015 08:21:13 -0500
MIME-Version: 1.0
In-Reply-To: <1441025664.13980.8.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


>> humm... What I wanted is backport next-20150731 to v4.1.6. linux-next 
>> is checked out to next-20150731.
>> which of the two does git-revision refer two? the linux-next origin 
>> or the destination?
> 
> The *to* version is never relevant. A given backport will compile
> against many different *to* versions.

I guess I completely missed the concept. I was thinking that the gentree.py command would only port and adjust the delta between linux-next and the version I wanted. Looks like the backport is really an add-on that will apply to multiple versions. Not sure I understand how successive changes in the tree are handled if there is a single backport.

--
To unsubscribe from this list: send the line "unsubscribe backports" in
