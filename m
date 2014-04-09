Return-path: <backports-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:41127 "EHLO nbd.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932358AbaDIJSv (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 9 Apr 2014 05:18:51 -0400
Message-ID: <53451077.2030102@openwrt.org> (sfid-20140409_111854_192527_B5A21A7B)
Date: Wed, 09 Apr 2014 11:18:47 +0200
From: Felix Fietkau <nbd@openwrt.org>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.cz>,
	Mauro Carvalho Chehab <m.chehab@samsung.com>
Subject: Re: Bumping required kernels to 3.0 for Linux backports ?
References: <CAB=NE6VvyBKzEg=ErZzQMktY8eLytQ21JCPrOQbxvZ9m-nqHkw@mail.gmail.com>
In-Reply-To: <CAB=NE6VvyBKzEg=ErZzQMktY8eLytQ21JCPrOQbxvZ9m-nqHkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 2014-04-09 03:03, Luis R. Rodriguez wrote:
> Folks,
> 
> we have a age old dance of random parties, in particular the embedded
> folks, ending up with random ancient kernels on embedded devices. I've
> tried to carefully document a few ideas on why and how I believe we
> can make automatic kernel backporting scale [0] and part of this will
> be to try to bring consensus about a unified front to persuade users,
> partners, customers, whatever, to be at least on a kernel listed as
> supported on kernel.org. Today we backport down to the last 30
> kernels, from 2.6.24 up to 3.14 and while this is manageable right now
> I expect the number of supported drivers and features to keep
> increasing (I've stopped counting). I am very aware of the reasons to
> support a slew of old kernels, but its nothing but our own fault for
> not educating enough about the importance on upgrading. I realize this
> is an age old issue, but since I think we need scale backports and
> wish to remove older kernels from it fast, I wanted to see if any
> folks might have ideas on what can help here other than saying, 'if
> you use Linux backports, your drivers will be automatically backported
> and supported'.
> 
> To start off -- what's the *last* kernel you realistically need for
> your users to use backports right now? Is it really 2.6.25? Would
> anyone kick and scream if for the backports-3.15 release try take
> things up to support only down to least 3.0 *right now* ?
> 
> [0] http://www.do-not-panic.com/2014/04/automatic-linux-kernel-backporting-with-coccinelle.html
The oldest kernel in OpenWrt that we're still supporting with updates of
the backports tree is 3.3, so raising the minimum requirement to 3.0 is
completely fine with me.

I'm looking forward to getting rid of patches for older kernels that
often get in the way when using various wireless-testing versions ;)

- Felix
