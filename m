Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:52235 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933251AbaDIXif (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 9 Apr 2014 19:38:35 -0400
Received: by mail-lb0-f169.google.com with SMTP id q8so1759008lbi.28
        for <backports@vger.kernel.org>; Wed, 09 Apr 2014 16:38:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE5JcOWEv65JjjhV0LyvTSBPYKrEyZem_+Wy07Cz4qaLP7218A@mail.gmail.com>
References: <CAE5JcOWEv65JjjhV0LyvTSBPYKrEyZem_+Wy07Cz4qaLP7218A@mail.gmail.com>
From: "Luis R. Rodriguez" <mcgrof@gmail.com>
Date: Wed, 9 Apr 2014 16:38:13 -0700
Message-ID: <CAB=NE6VnNNfRDO488S65Cjo1JfdonZ7tF6pmqQFE=5y0WhMLwg@mail.gmail.com> (sfid-20140410_013837_952398_785377D8)
Subject: Re: Back ports question
To: Shridatt Sugrim <ssugrim@winlab.rutgers.edu>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Cc'ing backports.

On Wed, Apr 9, 2014 at 4:11 PM, Shridatt Sugrim
<ssugrim@winlab.rutgers.edu> wrote:
> Hey Luis, I was trying to build a back ported version of iwlwifi for 3.2.0
> kernel. But I'm kinda lost as to how I get this to work. Do you still work
> on this / have  pointer on how to build against a running kernel?

Yeap, still chugging on backports. The best reference is the wiki:

https://backports.wiki.kernel.org

Have you tried that by any chance?

Be sure to use this repo:

git://git.kernel.org/pub/scm/linux/kernel/git/backports/backports.git

I just pushed out two tags I forgot to peg based on the new updates
form yesterday so if you have a fresh tree just git fetch --tags.

> Basically here is my problem: The older nodes use a non-pae kernel, but some
> of the newer wifi cards require the new iwlwifi driver. I'm trying to build
> the iwlwifi module against my current running kernel 3.2.0-60-generic. To
> that end I cloned the linux backports and hopped to the linux-3.2.y branch.
> But from here I don't know where to go.  Can I just slice out the iwlwifi
> directory  and graft it onto my existing source tree?

Sure, but a few notes. The branch on backports for linux-3.2.y is for
the respective linux-stable.git tree and its own linux-3.2.y branch.
If you want the latest you have the option of either using Linus' tree
and hopping on v3.14 (later Greg will have started a linux-3.14.y
branch on linux-stable.git) and using the backports linux-3.14.y
branch. If you want the very latest and greatest you can just stick to
the master branch of backports, and do git describe. That will tell
you the respective linux-next tag that you should use so
backports-20140320 tag right now means that you should have a
linux-next that is caught up to next-20140320. If you hop onto the
backports linux-3.14.y branch it is designed for the linux-stable.git
tree and if Greg hasn't pushed updates to it for v3.14 yet you can
just use Linus' tree and 'git reset --hard v3.14' to force it to
rewind to v3.14.

Since its a pain to expect folks to juggle tons of trees well (Linus'
tree, linux-stable.git, linux-next.git) and also the ksrc-backports
directory which we use to carry all the stable kernels headers we
support in case you want to test compile something accross all kernels
with ckmake, we provide a python script that does all the tree
management / synchs for you. On a clean system as a regular user in
your home directory you can just run:

devel/backports-update-manager

That'll do all the synching for you. In the next linux-next iteration
I hope to nuke a whole bunch of old kernels and get us to only require
supporting up to 3.2. so you'll need to run this then if you're a
developer and wish to also nuke all the old junk.

Another option is for you to wait for a release to be kicked out on
the release page:


  Luis
