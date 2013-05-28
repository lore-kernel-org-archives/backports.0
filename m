Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:55290 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755437Ab3E1UOn (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 28 May 2013 16:14:43 -0400
Received: by mail-wi0-f172.google.com with SMTP id m6so2896518wiv.5
        for <backports@vger.kernel.org>; Tue, 28 May 2013 13:14:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAB=NE6VY=BAxfs9MCXxc8=fabt0bBbmcTwr7rovRG42ZUvEATA@mail.gmail.com>
References: <1369222478-30577-1-git-send-email-mcgrof@do-not-panic.com>
 <1369222478-30577-7-git-send-email-mcgrof@do-not-panic.com>
 <1369224306.8207.7.camel@jlt4.sipsolutions.net> <CAB=NE6WxO3tUjuK4gzxPSg+sukHB=ApxLr8F++Y+F2887=DW=Q@mail.gmail.com>
 <1369322755.12002.21.camel@jlt4.sipsolutions.net> <CAB=NE6UwkAunmKGLutnHsUjSYXv34zQ2n1eVUc3jTsE=9vWejg@mail.gmail.com>
 <CAB=NE6VY=BAxfs9MCXxc8=fabt0bBbmcTwr7rovRG42ZUvEATA@mail.gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 28 May 2013 13:14:22 -0700
Message-ID: <CAB=NE6Up+L2b_nQoLND4NrSD+J3ydKsnpP=178WhPFMSV4D6kQ@mail.gmail.com> (sfid-20130528_221459_969980_E5F9EED1)
Subject: Re: [PATCH 6/9] lib/bpgit.py: add support for git paranoia
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, May 28, 2013 at 1:02 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> Right now we infer RELMOD_UPDATE based
> on the output directory but inferring RELMOD_TYPE from the same target
> output directory would be sloppy IMO so tackling these two with
> --git-revision would need to be addressed.

Addressing RELMOD_TYPE seems easy with --git-revision, add arguments
additional arguments: -s -n -p -c -u as release mode specifications as
arguments to be passed to gentree.py either as:

  a) standalone arguments, or;
  b) as a conglomeration of release modification types, ie something
like --rel-mod=snpcu

We just need a reasonable way to address RELMOD_UPDATE then. My
current set of patches infer the backports tag that we'd use, if we
rely on --git-revision we could just have an inferred map of what the
respective backports tag should be, but that still does not address
the RELMOD_UPDATE to use.

If the backports tag is inferred from the linux tree used we have a few options:

  1) Infer the RELMOD_UPDATE to use based on the latest backports tag,
and verify it
  2) Require the RELMOD_UPDATE to be specified it and then git verify it

If we go down this road I like the first option. This however would
likely require a map algorithm to be provided based on the linux tree
to be used. This is fine for linux-next and linux-stable (given I
merge Linus' tree on it but not sure if other folks are doing this)
but lets consider that some folks might be using backports to generate
releases (in theory) based on other trees like wireless-testing, let
alone vendor trees (which I am not privy to) and not sure if that is a
requirement.

If the backports tag is *not* inferred from the linux tree to use we
could ask --backports-revision I suppose, and from that infer the
RELMOD_UPDATE. I'm inclined towards this option -- but then do we use
git ls-tree and git rev-parse as you do with --git-revision or do we
go with git reset and git paranoia?

Do we have any use case for git paranoia then? Do we discard it? I'm
still considering implementing this upstream as I find it useful to
clean up my trees.

  Luis
