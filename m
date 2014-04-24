Return-path: <backports-owner@vger.kernel.org>
Received: from app1b.xlhost.de ([84.200.252.162]:59674 "EHLO app1b.xlhost.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753966AbaDXLmm (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 24 Apr 2014 07:42:42 -0400
Message-ID: <5358F8AE.6080009@kpanic.de> (sfid-20140424_134250_281459_306AAF6C)
Date: Thu, 24 Apr 2014 13:42:38 +0200
From: Stefan Assmann <sassmann@kpanic.de>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@frijolero.org>,
	Johannes Berg <johannes@sipsolutions.net>
CC: Julia Lawall <julia.lawall@lip6.fr>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: cocci: multiple versions of function with different arguments
References: <53579593.40306@kpanic.de> <1398249715.4173.3.camel@jlt4.sipsolutions.net> <5357A065.3020400@kpanic.de> <1398251810.4173.6.camel@jlt4.sipsolutions.net> <CAB=NE6W2FqvbkwiTeV-aoOOqzmRqwbjpYkF05sosF4+wg7gY1Q@mail.gmail.com>
In-Reply-To: <CAB=NE6W2FqvbkwiTeV-aoOOqzmRqwbjpYkF05sosF4+wg7gY1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 23.04.2014 20:27, Luis R. Rodriguez wrote:
> On Wed, Apr 23, 2014 at 4:16 AM, Johannes Berg
> <johannes@sipsolutions.net> wrote:
>>> If for some reason cocci should have a problem with this the fallback
>>> to a define is a good idea.
>>
>> I don't disagree that we might have to solve this cocci problem, but I
>> would much prefer the define over the cocci patch as it leaves the
>> output code closer to the input code, which can be important for some
>> use cases (e.g. ours - development based on a backport tree.)
> 
> Coccinelle has a slight overhead cost in comparison to using our
> headers through defines, static inlines, or a new exported symbol on
> the backports module (called compat now). The code generation cost is
> is O(0) for a backport done through the headers / backports module,
> using Coccinelle we have a slight overhead before compile time, during
> code generation time. We want to minimize this as much as possible.
> Because of this I would also prefer a define for the example use case
> unless there's another reason that a define or a new symbol cannot be
> used. We should use Coccinelle to try to solve backports for solutions
> we didn't have strategies for, that is we should strive to backport
> first through the backports module / header files, then as a second
> step consider Coccinelle, and only if Coccinelle cannot solve our
> backports we leave nasty legacy patches lying around.

If we use use the define I think we still have to patch the individual
driver because we're trying to assign a function pointer with 3
arguments when there are only 2 expected. I could be wrong though.


What I'm trying to do here is deal with, for example, new (or changed)
function pointers in struct net_device_ops. So instead of patching
every driver manually we could have a cocci patch that changes/ifdefs
all drivers at once for specific kernel versions.

Here's an example.
80d5c3689b886308247da295a228a54df49a44f6 introduces the following change
to struct net_device_ops.
        int                     (*ndo_vlan_rx_add_vid)(struct net_device *dev,
-                                                      unsigned short vid);
+                                                      __be16 proto, u16 vid);

Ultimately what I'd like to see is automagically
- change/ifdef function calls in all drivers
- change/ifdef function declarations/prototypes in all drivers
- adapt code? That's a maybe, my cocci skill is still pretty low


Yes there will be overhead, it's not for free. But there's potential to
ease adding of new drivers and reduce overall maintenance overhead.
Also if I look at the recent changes, we might run cocci in parallel
which should reduce the runtime overhead further.

Here's another example.
5f8444a3fa617076f8da51a3e8ecce01a5d7f738 adds function pointer
ndo_set_vf_spoofchk to struct net_device_ops in kernel 3.2. In previous
kernel we might be able to get away by just commenting out everything
related to ndo_set_vf_spoofchk in the drivers with a cocci patch.

  Stefan
