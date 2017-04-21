Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:46610 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424172AbdDUSy2 (ORCPT <rfc822;backports@vger.kernel.org>);
        Fri, 21 Apr 2017 14:54:28 -0400
Message-ID: <1492800860.19290.3.camel@sipsolutions.net> (sfid-20170421_205445_515164_EC2774A7)
Subject: Re: [PATCH 2/2] backports: add the necessary backports for netlink
 extack
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>,
        backports@vger.kernel.org
Date: Fri, 21 Apr 2017 20:54:20 +0200
In-Reply-To: <d79056c4-ff9d-0e16-ed84-03fae4cdee83@broadcom.com> (sfid-20170421_205053_447231_D19084FD)
References: <20170421104722.21538-1-johannes@sipsolutions.net>
         <20170421104722.21538-2-johannes@sipsolutions.net>
         <d79056c4-ff9d-0e16-ed84-03fae4cdee83@broadcom.com>
         (sfid-20170421_205053_447231_D19084FD)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2017-04-21 at 20:50 +0200, Arend Van Spriel wrote:
> On 21-4-2017 12:47, Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> 
> I did not follow everything about this extack thing, but does it
> impose a version requirement on the libnl used in user-space?

No. It turns out that libnl doesn't care at all about the ack message
contents, so you can use any version.

Here's a sample iw patch:

https://git.kernel.org/pub/scm/linux/kernel/git/jberg/iw.git/commit/?h=bpf&id=7105f7614c13680306cf3b91ad8711eccfa70df3

> > +/* this is for patches we apply */
> 
> Guess the comment is inspired by the one below ;-) but would it not
> be a bit more clear to say:
> 
> /* this is for files patched using 0078-genl-extack.cocci */

Yeah I guess that'd make some sense :)

Though realistically none of it is really all that necessary since one
can always grep ;-)

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
