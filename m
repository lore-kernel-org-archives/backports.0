Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:36886 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753322AbbFHUJT convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 8 Jun 2015 16:09:19 -0400
Received: by igbsb11 with SMTP id sb11so1000917igb.0
        for <backports@vger.kernel.org>; Mon, 08 Jun 2015 13:09:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1433792751.10172.0.camel@sipsolutions.net>
References: <1433549401-17006-1-git-send-email-mcgrof@do-not-panic.com>
 <1433549401-17006-4-git-send-email-mcgrof@do-not-panic.com>
 <1433592743.2467.7.camel@sipsolutions.net> <CAB=NE6X6=uuof0BdhVctobb_Ypvj-Q03Akma_PWGe17PUn=7PA@mail.gmail.com>
 <1433792751.10172.0.camel@sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@suse.com>
Date: Mon, 8 Jun 2015 13:08:58 -0700
Message-ID: <CAB=NE6WTxatq3BAw=_84qwVEOhQezY3ik8GMM-zxeHZYYPZKYg@mail.gmail.com> (sfid-20150608_220924_307798_DF240DE7)
Subject: Re: [PATCH 3/4] gentree.py: add SmPL patch equivalence proof support
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	"cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, Jun 8, 2015 at 12:45 PM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Mon, 2015-06-08 at 12:31 -0700, Luis R. Rodriguez wrote:
>
>> This is true, its in the like of how we wrote pycocci to provide us
>> with a multithreaded solution for spatch integration / development as
>> well and how pycocci now is upstream on Coccinelle.
>
> Speaking of which - are you aware that pycocci fails (or rather doesn't
> fail!) miserably when cocci isn't installed/in the $PATH? At least I got
> a report to that extent,

Did you verify it?

> that it didn't really complete nor report an error in that case.

Definitely not. Error reporting from pycocci's use of Coccinelle use
sucked though because it  was adding extra spaces in between each
character though, I just fixed that last week, will sync now. Patches
/ reports for issues are welcome but please note that pycocci is now
part of Coccinelle so issues / patches should copy that list. For a
while I'll just keep these in sync for convenience given that
Coccinelle tends to batch a few commits before a release is made. I'll
sync up now though.

mcgrof@ergon ~/linux-next (git::20150604-proto_ops-send-rcv-smpl)$ which pycocci
which: no pycocci in
(/usr/local/bin/:/usr/local/sbin/:/sbin/:/usr/sbin/:/home/mcgrof/bin/:/usr/bin:/usr/local/bin/:/usr/local/sbin/:/sbin/:/usr/sbin/:/home/mcgrof/bin/:/usr/bin:/usr/local/bin/:/usr/local/sbin/:/sbin/:/usr/sbin/:/home/mcgrof/bin/:/usr/bin:/home/mcgrof/bin:/usr/local/bin:/usr/bin:/bin:/usr/bin/X11:/usr/games)

So not on my path.

mcgrof@ergon ~/linux-next (git::20150604-proto_ops-send-rcv-smpl)$
/home/mcgrof/devel/coccinelle/tools/pycocci 0002-no_dmabuf.cocci
drivers/media/v4l2-core/videobuf2-dma-contig.c
spatch --sp-file 0002-no_dmabuf.cocci --in-place --recursive-includes
--relax-include-path --use-coccigrep --timeout 120 --dir
drivers/media/v4l2-core/videobuf2-dma-contig.c -max 4 -index 0
spatch --sp-file 0002-no_dmabuf.cocci --in-place --recursive-includes
--relax-include-path --use-coccigrep --timeout 120 --dir
drivers/media/v4l2-core/videobuf2-dma-contig.c -max 4 -index 1
spatch --sp-file 0002-no_dmabuf.cocci --in-place --recursive-includes
--relax-include-path --use-coccigrep --timeout 120 --dir
drivers/media/v4l2-core/videobuf2-dma-contig.c -max 4 -index 2
spatch --sp-file 0002-no_dmabuf.cocci --in-place --recursive-includes
--relax-include-path --use-coccigrep --timeout 120 --dir
drivers/media/v4l2-core/videobuf2-dma-contig.c -max 4 -index 3

and git diff yields exact same results as if when pycocci is in my
path. Please have the user report the issue to this list  and copy the
cocci list. Also Johannes, I value your time and I feel you're
investing quite a bit of time into this NACK discussion, I obviously
trust your judgement completely on gentree.py maintenance so for your
convenience feel free to be concise in your NACK's for patches there.

 Luis
