Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:34185 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966AbbFHWJf (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 8 Jun 2015 18:09:35 -0400
Received: by igbhj9 with SMTP id hj9so769038igb.1
        for <backports@vger.kernel.org>; Mon, 08 Jun 2015 15:09:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55701578.9030205@kpanic.de>
References: <1433330756-22733-1-git-send-email-sassmann@kpanic.de>
 <1433330756-22733-2-git-send-email-sassmann@kpanic.de> <556F5FD5.4070003@hauke-m.de>
 <55701578.9030205@kpanic.de>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Mon, 8 Jun 2015 15:09:14 -0700
Message-ID: <CAB=NE6UYbXqyo-O5Dj-FBTzhQ+LjRH86-fbgAQaqreVAoctQjg@mail.gmail.com> (sfid-20150609_000938_291403_8BF48A84)
Subject: Re: [PATCH 1/4] backports: replace igb skb->no_fcs patch with
 semantic patch
To: Stefan Assmann <sassmann@kpanic.de>
Cc: Hauke Mehrtens <hauke@hauke-m.de>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, Jun 4, 2015 at 2:08 AM, Stefan Assmann <sassmann@kpanic.de> wrote:
> On 03.06.2015 22:13, Hauke Mehrtens wrote:
>> Is it always save to just remove something which accesses skb->no_fcs in
>> all cases? I think sometimes some special handling for older kernel
>> version could be needed. This also looks very specific to the igb usage.
>
> In this case I'd say this is fine, no_fcs is used to send out frames with
> bad CRC for testing. So just commenting out related code shouldn't cause
> any harm. Yes, the cocci code is very specific and will likely need to be
> extended for other drivers when we pull them in. But you have to start
> somewhere.
>
> We always have the option to revert if something turns out to be a bad
> idea.

I'm fine with merging now but please note the discussion, Hauke was
curious about the generality over the Coccinelle patch replacement
over a patch series. In order to help maintainers make a proper
assessment over whether or not we can merge an SmPL patch to replace a
patch series it is extremely useful to annotate the SmPL patch with
header comments which track:

a) The respective upstream commit and kernel version which introduced
the collateral evolution for which you are generalizing
b) A good description which explains your understanding as to why this
should work and will not break run time

a) is easy, b) is hard but it is the least we can do and I think we
will remain sane if we put this as a litmus test for future SmPL patch
replacements. Its not easy but please see my own SmPL patches and
review the description. Its pretty lengthy but these discussions can
be avoided if we had someone do the full homework.

If we want to scale we need this. Are you folks OK with requiring a)
and b) on future SmPL patch replacements? Best effort at least. Keep
in mind reason for this is also I believe there are some further
generalizations we can reach if we follow these best practices which I
think will have further beneficial gains to us.

 Luis
