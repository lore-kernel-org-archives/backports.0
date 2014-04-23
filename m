Return-path: <backports-owner@vger.kernel.org>
Received: from app1b.xlhost.de ([84.200.252.162]:49131 "EHLO app1b.xlhost.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751397AbaDWLNo (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Apr 2014 07:13:44 -0400
Message-ID: <5357A065.3020400@kpanic.de> (sfid-20140423_131346_871902_3B21AB33)
Date: Wed, 23 Apr 2014 13:13:41 +0200
From: Stefan Assmann <sassmann@kpanic.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
CC: Julia Lawall <julia.lawall@lip6.fr>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: cocci: multiple versions of function with different arguments
References: <53579593.40306@kpanic.de>	 (sfid-20140423_122737_920373_E36F87A8) <1398249715.4173.3.camel@jlt4.sipsolutions.net>
In-Reply-To: <1398249715.4173.3.camel@jlt4.sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 23.04.2014 12:41, Johannes Berg wrote:
> On Wed, 2014-04-23 at 12:27 +0200, Stefan Assmann wrote:
> 
>> I'm trying to generate a patch to define a function with different
>> arguments depending on the kernel version. I'm having some difficulties,
>> maybe you can tell me what's wrong with the following approach.
> 
> I can't answer that, but given the premise
> 
>> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
>>         vlan_rx_add_vid_func(a, b, c)
>> +#else
>> +       vlan_rx_add_vid_func(a, c)
>> +#endif
> 
> and the fact that later kernel versions add an argument, wouldn't it be
> much easier to provide a macro in the appropriate header file:
> 
> #define vlan_rx_add_vid_func(a,b,c) vlan_rx_add_vid_func(a,c)
> 
> johannes
> 

That's one way to handle it but I'm sure there will be other cases where
we might use coccinelle similarly, where a define might be tricky.
Luis asked me to do some cleanup on igb, so I'm exploring ways to make
it easier for other network drivers as well.

If for some reason cocci should have a problem with this the fallback
to a define is a good idea.

Thanks Johannes!

  Stefan
