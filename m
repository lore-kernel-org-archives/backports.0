Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:37432 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754333Ab3H0U3Q (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 27 Aug 2013 16:29:16 -0400
Message-ID: <521D0C11.6090402@hauke-m.de> (sfid-20130827_222923_347045_E84D9D83)
Date: Tue, 27 Aug 2013 22:29:05 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
CC: backports@vger.kernel.org
Subject: Re: kernel version management
References: <1377630791.20012.12.camel@jlt4.sipsolutions.net>
In-Reply-To: <1377630791.20012.12.camel@jlt4.sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 08/27/2013 09:13 PM, Johannes Berg wrote:
> Hi,
> 
> So ... I guess I succeeded in killing off 2.6.24 support, but I think we
> should talk about when we drop which version?
> 
> http://en.wikipedia.org/wiki/Linux_kernel#Maintenance has a handy list
> of which version was supported until when, telling us that the oldest
> kernel still supported now is 2.6.32.
> 
> What do people think? What kernels do you use? How old is "really far
> too old to worry about"?
> 
> johannes

When you look at the users of old backports no one cares about using a
supported kernel version. One group are the desktop users which are
using Ubuntu, Debian, or some RedHat kernel, these kernels are based on
2.6.32 or some 3.X version. The other big group are the embedded
developers which are using any random kernel version with many patches
for some specific SoC in it. They do not care about security updates.

I think we should drop support for some versions if there are some
thinks that are harder to backport.

The bigger maintenance problem I currently see is the adding for more
and more subsystems. The GPU drivers for example are taking about 30% of
the time when adding support for a new linux next version.

Hauke
