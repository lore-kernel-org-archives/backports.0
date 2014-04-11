Return-path: <backports-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:64772 "EHLO
	mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750805AbaDKGBH (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 11 Apr 2014 02:01:07 -0400
Date: Fri, 11 Apr 2014 08:01:04 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: SF Markus Elfring <elfring@users.sourceforge.net>
cc: "Luis R. Rodriguez" <mcgrof@suse.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org, backports@vger.kernel.org,
	cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] coccinelle: add pycocci wrapper for	multithreaded
 support
In-Reply-To: <534783DB.4080200@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1404110800120.2032@localhost6.localdomain6> (sfid-20140411_080110_794728_F9A1E6A5)
References: <1397152097-315-1-git-send-email-mcgrof@do-not-panic.com> <1397152289.4757.28.camel@jlt4.sipsolutions.net> <20140410175748.GK14815@wotan.suse.de> <534783DB.4080200@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



On Fri, 11 Apr 2014, SF Markus Elfring wrote:

> > I checked the profile results, the reason the jobs finish is some threads
> > had no work or little work.
> 
> Could you find out during the data processing which parts or files
> result in a special application behaviour you would like to point out here?

I don't understand the question at all, but since the various files have 
different properties, it is hard to determine automatically in advance how 
much work Coccinelle will need to do on each one.

julia
