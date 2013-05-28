Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:57823 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753578Ab3E1TnN (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 28 May 2013 15:43:13 -0400
Message-ID: <1369770189.8548.20.camel@jlt4.sipsolutions.net> (sfid-20130528_214314_810781_E5D4DE96)
Subject: Re: Problem with backports git repo
From: Johannes Berg <johannes@sipsolutions.net>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: "Luis R. Rodriguez" <mcgrof@frijolero.org>,
	backports@vger.kernel.org
Date: Tue, 28 May 2013 21:43:09 +0200
In-Reply-To: <1369769122.8548.7.camel@jlt4.sipsolutions.net> (sfid-20130528_212531_921012_9500F06E)
References: <51A502AD.1060104@lwfinger.net>
	 (sfid-20130528_211707_085177_DE2DD9E0) <1369769122.8548.7.camel@jlt4.sipsolutions.net>
	 (sfid-20130528_212531_921012_9500F06E)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2013-05-28 at 21:25 +0200, Johannes Berg wrote:
> Hi Larry,
> 
> > I just used 'git clone' to get a fresh copy of the repo. When I try 'make 
> > menuconfig', I get the following error:
> > 
> > finger@larrylap:~/backports/backport> make menuconfig
> 
> The docs haven't been updated, but this is just the skeleton, you're not
> supposed to run anything in there. Go to the top-level first, and run

Oh, n/m me, it seems this was just an accidental resend of your previous
mail?

johannes

