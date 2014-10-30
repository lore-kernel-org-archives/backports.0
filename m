Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:53590 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932595AbaJ3KK3 (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 30 Oct 2014 06:10:29 -0400
Received: by mail-wg0-f47.google.com with SMTP id a1so3833891wgh.34
        for <backports@vger.kernel.org>; Thu, 30 Oct 2014 03:10:27 -0700 (PDT)
Message-ID: <54520E90.6060401@einserver.de> (sfid-20141030_111755_877650_76788C91)
Date: Thu, 30 Oct 2014 11:10:24 +0100
From: Andreas Ruprecht <rupran@einserver.de>
MIME-Version: 1.0
To: Julia Lawall <julia.lawall@lip6.fr>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Peter Senna Tschudin <peter.senna@gmail.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>,
	stefan.hengelein@fau.de, valentinrothberg@gmail.com
Subject: Re: Re: Tool to match kernel C file to CONFIG symbol
References: <CAB=NE6UcT9suZDfnTY09rOoqOSoYEqV2fryCSo7BjJyqXKXewQ@mail.gmail.com> <CAB=NE6WW5zAD_4Jqwaf2pyy5RVtt-tSAQQfDK4MFr+R+KQNi_Q@mail.gmail.com> <alpine.DEB.2.02.1410300714090.2374@localhost6.localdomain6>
In-Reply-To: <alpine.DEB.2.02.1410300714090.2374@localhost6.localdomain6>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi all,

actually the problem isn't that easy... some of the information from the
Kbuild files is not entirely straight-forward to extract.

If you're interested in the former (that is, what config symbols have to
be enabled to have a file compiled), there is a Python tool called
"golem" in the toolsuite[0] from our group which determines the
preconditions for files to be built (called with parameter "-i"). Sadly
it currently takes a few hours to finish as it probes the build system
with changing partial configurations.

I'm currently working on a faster combined parsing/probing approach and
could make an early development snapshot of the parser available to you,
please contact me directly if you want to have a look at that.

For something similar to the latter problem (which files get compiled
from a specific configuration) golem can be called with the "-c"
parameter and a source file to determine if the file is compiled with
the current configuration. You could use that to match a configuration
option to a file. Alternatively, you can use the "-l" parameter to see a
list of all files compiled with the current configuration.

Hope this helps,

Andreas

[0] https://undertaker.cs.fau.de

On 30.10.2014 07:16, Julia Lawall wrote:
> 
> 
> On Wed, 29 Oct 2014, Luis R. Rodriguez wrote:
> 
>> On Wed, Oct 29, 2014 at 4:15 PM, Luis R. Rodriguez
>> <mcgrof@do-not-panic.com> wrote:
>>> Anyone familiar with a tool to match a specific C file to a respective
>>> CONFIG symbol on the kernel? I'd prefer if its written in C or Python.
>>> This should be easy to write if we don't have it yet.
>>
>> Peter, didn't you have such tool already?
> 
> I think that the Erlangen people can help you (added to CC).
> 
> I'm not sure which way you want to go: What config symbol will get my file 
> compiled, or if I turn on this config symbol, what files will I get.  I 
> think that Stefan's Vampyr tool can help with the first.
> 
> julia
> 
