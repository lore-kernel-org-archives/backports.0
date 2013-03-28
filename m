Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:41288 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752789Ab3C1WzI (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 28 Mar 2013 18:55:08 -0400
Message-ID: <5154CA3A.2010901@hauke-m.de> (sfid-20130328_235511_018896_ACB77A86)
Date: Thu, 28 Mar 2013 23:54:50 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
CC: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: compat-drivers wishlist
References: <1364507345.10397.42.camel@jlt4.sipsolutions.net>  <CAB=NE6X9X0apA0tR-f2_f24W-sWXhUVky2OGEQhAO3=ta1Q2pA@mail.gmail.com>  (sfid-20130328_231602_638862_02D2B887) <1364509642.10397.76.camel@jlt4.sipsolutions.net>
In-Reply-To: <1364509642.10397.76.camel@jlt4.sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 03/28/2013 11:27 PM, Johannes Berg wrote:
> On Thu, 2013-03-28 at 15:15 -0700, Luis R. Rodriguez wrote:
> 
>>> 1) Ability to copy only some drivers.
> 
>> Seems reasonable. Maybe admin-update can read your own .config
> 
> This is a tricky proposition, see below & my other mail on Kconfig
> thoughts.
> 
>> GNU patch could use some love. 
> 
> I'd hate to have to rely on a modified version of that :-)
> 
> FWIW, I think there's a python library to apply (unified) patches, if we
> want to get fancy.
> 
>> See commit 4a1a94f93 on compat-drivers.
> 
> Ah, what's that for? Refreshing patches? I've never seen dependencies in
> the compat patches so mostly I refresh manually, but yeah, the refresh
> part is something I'd have to think about. Though, to be honest, when
> you can just blow away your output directory and try again I'm not too
> worried about this. Trying to apply the patches could just leave it in
> the state you're in, and then you modify them until it works?

Refreshing patches should not be a problem. Normally I use
"./scripts/admin-refresh.sh -n -p -c -u refresh" to refresh the patches
and this should work with some minor changes with the proposal you made.

>> Maybe we need a context patch parser that given a .config will only
>> apply patches for the desired files. For this to work we'd need a
>> mapping of CONFIG_FOO symbols to respective driver path files regexps.
> 
> Even assuming we do have such a mapping, I think it's the wrong approach
> and causes a chicken-and-egg problem.
> 
> As I wrote in my other mail, you don't have a .config file before you
> know the target kernel. This is because, for example, there's no way to
> know if PCI is enabled in the target kernel, and thus sometimes you get
> PCI drivers and sometimes not. Also I think maintenance and driver split
> is not usually per Kconfig symbol but per directory. There are many more
> Kconfig symbols, after all.
> 
> Also above you said you could do the source copying (or pruning) based
> on the .config file. This has the exact same issue, I'd rather have the
> copying or pruning be based on directories.
> 
> Basically I'm saying the .config file only exists on the target build
> system, while the selective copying/pruning needs to be done on the
> tarball creation system.

How do you want to make the tar generation being configurable? The build
time Kconfig options should be generated from the Kconfig files provided
by the kernel and not by some own files.
I think some manual edited config file with the directories or files to
be included sounds good. This function would not be used by the normal
user so that should be good enough.

>>> 4) Kconfig.
> 
>> I think its possible to remove not desired source code based on
>> reading .config.
> 
> See above.
> 
> Oh, another issue I haven't addressed is default configurations, but I
> think that's easy to do by providing something like the kernel's
> defconfig.
> 
> johannes

