Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:46956 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727AbaDWMSo (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 23 Apr 2014 08:18:44 -0400
Message-ID: <1398255513.4173.9.camel@jlt4.sipsolutions.net> (sfid-20140423_141846_725888_93EAE0E0)
Subject: Re: cocci: multiple versions of function with different arguments
From: Johannes Berg <johannes@sipsolutions.net>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Stefan Assmann <sassmann@kpanic.de>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Wed, 23 Apr 2014 14:18:33 +0200
In-Reply-To: <alpine.DEB.2.10.1404231412450.3422@hadrien>
References: <53579593.40306@kpanic.de>
	   (sfid-20140423_122737_920373_E36F87A8) <1398249715.4173.3.camel@jlt4.sipsolutions.net>
	  <5357A065.3020400@kpanic.de> <alpine.DEB.2.10.1404231405130.3422@hadrien>
	 <1398254986.4173.8.camel@jlt4.sipsolutions.net>
	 <alpine.DEB.2.10.1404231412450.3422@hadrien>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2014-04-23 at 14:14 +0200, Julia Lawall wrote:

> I can think  about it, but it is pretty far from the vision of Coccinelle,
> which is that the combination of context code and + code should be a valid
> syntactic unit, and on the side that we don't think much about ifdefs.
> 
> But I will think about it, because I can see that it is not a solvable
> problem with the current technology.

Luis kinda solved it by introducing an intermediate function that would
call the original, and then #ifdef'ing the assignment of the function
instead.

(This is only a problem when there's a function assignment to start
with, otherwise there's likely no need to modify the function
declaration - this only comes up with function pointer APIs)

johannes


