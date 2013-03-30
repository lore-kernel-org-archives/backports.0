Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:48062 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757395Ab3C3A3c (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 29 Mar 2013 20:29:32 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.0:DHE_RSA_CAMELLIA_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ULjfm-0007IX-89
	for backports@vger.kernel.org; Sat, 30 Mar 2013 01:29:30 +0100
Message-ID: <1364603366.8218.2.camel@jlt4.sipsolutions.net> (sfid-20130330_012936_402659_4B8CF056)
Subject: Re: compat-drivers wishlist
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Date: Sat, 30 Mar 2013 01:29:26 +0100
In-Reply-To: <1364509206.10397.69.camel@jlt4.sipsolutions.net> (sfid-20130328_232017_460041_62851092)
References: <1364507345.10397.42.camel@jlt4.sipsolutions.net>
	 (sfid-20130328_224915_104660_21BB9723) <1364509206.10397.69.camel@jlt4.sipsolutions.net>
	 (sfid-20130328_232017_460041_62851092)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 2013-03-28 at 23:20 +0100, Johannes Berg wrote:
> > 1) Ability to copy only some drivers.
> > 2) To make that easier: split all patches per *file* in addition to per change.
> > 3) Separate the output from the compat-drivers tree.

done.

> > 4) Kconfig.

pretty much done -- right now users can get into unbuildable situations,
I obviously want to avoid.


I also decided to merge compat and compat-drivers -- right now I see no
value in them being combined. I therefore created a new backports.git
tree.

Note that this is very very raw. It doesn't even have the ability to
*build* the drivers yet, which is kinda the whole point ... But I had to
start somewhere, and obviously that was at step 1: building the
sources :-)

It's all here, if anyone wants to risk a look.
http://git.sipsolutions.net/?p=backports.git;a=summary

I'll continue next week, most likely.

johannes

