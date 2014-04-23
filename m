Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:46901 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210AbaDWMKB (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 23 Apr 2014 08:10:01 -0400
Message-ID: <1398254986.4173.8.camel@jlt4.sipsolutions.net> (sfid-20140423_141003_807585_E9D3AF3E)
Subject: Re: cocci: multiple versions of function with different arguments
From: Johannes Berg <johannes@sipsolutions.net>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Stefan Assmann <sassmann@kpanic.de>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Wed, 23 Apr 2014 14:09:46 +0200
In-Reply-To: <alpine.DEB.2.10.1404231405130.3422@hadrien>
References: <53579593.40306@kpanic.de>
	  (sfid-20140423_122737_920373_E36F87A8) <1398249715.4173.3.camel@jlt4.sipsolutions.net>
	 <5357A065.3020400@kpanic.de> <alpine.DEB.2.10.1404231405130.3422@hadrien>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2014-04-23 at 14:07 +0200, Julia Lawall wrote:

> I think that the problem is that the SmPL parser doesn't really understand
> about the ifdef.  So it sees one expression right after another one, which
> it is not happy about.  It would be fine if there were semicolons after
> the function call.  If you can move up to the statement level in each
> possible case, that might be a solution, but it might be too awkward in
> practice.  If the macro solution is feasible, that could be better.  Fewer
> changes to the source code as well.

Yeah I was confused about all this as well - turns out that he's not
trying to do function calls but rather function declarations:

#if ...
static int foo(void *a, int b, char c)
#else
static int foo(void *a, char c)
#endif
{
 ...
}

or such.

I'm not sure how that would compile (it would require "b" being unused),
but still.

johannes

