Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:57962 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755587Ab3E1UXw (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 28 May 2013 16:23:52 -0400
Message-ID: <1369772615.8548.30.camel@jlt4.sipsolutions.net> (sfid-20130528_222353_671019_DD212D02)
Subject: Re: [PATCH 6/9] lib/bpgit.py: add support for git paranoia
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Tue, 28 May 2013 22:23:35 +0200
In-Reply-To: <CAB=NE6Up+L2b_nQoLND4NrSD+J3ydKsnpP=178WhPFMSV4D6kQ@mail.gmail.com> (sfid-20130528_221443_210848_7453C4C7)
References: <1369222478-30577-1-git-send-email-mcgrof@do-not-panic.com>
	 <1369222478-30577-7-git-send-email-mcgrof@do-not-panic.com>
	 <1369224306.8207.7.camel@jlt4.sipsolutions.net>
	 <CAB=NE6WxO3tUjuK4gzxPSg+sukHB=ApxLr8F++Y+F2887=DW=Q@mail.gmail.com>
	 <1369322755.12002.21.camel@jlt4.sipsolutions.net>
	 <CAB=NE6UwkAunmKGLutnHsUjSYXv34zQ2n1eVUc3jTsE=9vWejg@mail.gmail.com>
	 <CAB=NE6VY=BAxfs9MCXxc8=fabt0bBbmcTwr7rovRG42ZUvEATA@mail.gmail.com>
	 <CAB=NE6Up+L2b_nQoLND4NrSD+J3ydKsnpP=178WhPFMSV4D6kQ@mail.gmail.com>
	 (sfid-20130528_221443_210848_7453C4C7)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2013-05-28 at 13:14 -0700, Luis R. Rodriguez wrote:

> Addressing RELMOD_TYPE seems easy with --git-revision, add arguments
> additional arguments: -s -n -p -c -u as release mode specifications as
> arguments to be passed to gentree.py either as:
> 
>   a) standalone arguments, or;
>   b) as a conglomeration of release modification types, ie something
> like --rel-mod=snpcu

I think this would fit better with the model of a separate tool, that
calls the gentree code to generate internally. Then you'd have maybe 

./devel/gen-and-kup.py -s -n -p -c -u ...

or something? Overall, that seems cleaner than cluttering gentree.py
with all these options, although gentree.py would probably (internally
only?) have to learn about being able to take patches and the skeleton
code from another directory to address the paranoia for the backport
tree itself.

> We just need a reasonable way to address RELMOD_UPDATE then. 

That's when you generate a new one for the same tag, due to updates,
right?

I don't really know how to handle this -- we don't really have a
canonical database of what we've generated before.

johannes

