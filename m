Return-path: <backports-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:32049
	"EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751259AbaJ3GZ7 (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 30 Oct 2014 02:25:59 -0400
Date: Thu, 30 Oct 2014 07:16:03 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Peter Senna Tschudin <peter.senna@gmail.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>,
	stefan.hengelein@fau.de, valentinrothberg@gmail.com
Subject: Re: Tool to match kernel C file to CONFIG symbol
In-Reply-To: <CAB=NE6WW5zAD_4Jqwaf2pyy5RVtt-tSAQQfDK4MFr+R+KQNi_Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1410300714090.2374@localhost6.localdomain6> (sfid-20141030_072601_726527_37614AD9)
References: <CAB=NE6UcT9suZDfnTY09rOoqOSoYEqV2fryCSo7BjJyqXKXewQ@mail.gmail.com> <CAB=NE6WW5zAD_4Jqwaf2pyy5RVtt-tSAQQfDK4MFr+R+KQNi_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



On Wed, 29 Oct 2014, Luis R. Rodriguez wrote:

> On Wed, Oct 29, 2014 at 4:15 PM, Luis R. Rodriguez
> <mcgrof@do-not-panic.com> wrote:
> > Anyone familiar with a tool to match a specific C file to a respective
> > CONFIG symbol on the kernel? I'd prefer if its written in C or Python.
> > This should be easy to write if we don't have it yet.
> 
> Peter, didn't you have such tool already?

I think that the Erlangen people can help you (added to CC).

I'm not sure which way you want to go: What config symbol will get my file 
compiled, or if I turn on this config symbol, what files will I get.  I 
think that Stefan's Vampyr tool can help with the first.

julia
