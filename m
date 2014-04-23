Return-path: <backports-owner@vger.kernel.org>
Received: from app1b.xlhost.de ([84.200.252.162]:53136 "EHLO app1b.xlhost.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753834AbaDWMgn (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Apr 2014 08:36:43 -0400
Message-ID: <5357B3D8.1040400@kpanic.de> (sfid-20140423_144250_128795_AF8D0CA5)
Date: Wed, 23 Apr 2014 14:36:40 +0200
From: Stefan Assmann <sassmann@kpanic.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	Julia Lawall <julia.lawall@lip6.fr>
CC: "backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: cocci: multiple versions of function with different arguments
References: <53579593.40306@kpanic.de>	   (sfid-20140423_122737_920373_E36F87A8) <1398249715.4173.3.camel@jlt4.sipsolutions.net>	  <5357A065.3020400@kpanic.de> <alpine.DEB.2.10.1404231405130.3422@hadrien>	 <1398254986.4173.8.camel@jlt4.sipsolutions.net>	 <alpine.DEB.2.10.1404231412450.3422@hadrien> <1398255513.4173.9.camel@jlt4.sipsolutions.net>
In-Reply-To: <1398255513.4173.9.camel@jlt4.sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 23.04.2014 14:18, Johannes Berg wrote:
> On Wed, 2014-04-23 at 14:14 +0200, Julia Lawall wrote:
> 
>> I can think  about it, but it is pretty far from the vision of Coccinelle,
>> which is that the combination of context code and + code should be a valid
>> syntactic unit, and on the side that we don't think much about ifdefs.
>>
>> But I will think about it, because I can see that it is not a solvable
>> problem with the current technology.
> 
> Luis kinda solved it by introducing an intermediate function that would
> call the original, and then #ifdef'ing the assignment of the function
> instead.
> 
> (This is only a problem when there's a function assignment to start
> with, otherwise there's likely no need to modify the function
> declaration - this only comes up with function pointer APIs)
> 
> johannes
> 

Thanks Johannes and Julia. I think the missing semicolon is what caused
the issue. I'll do some tests and report back.

  Stefan
