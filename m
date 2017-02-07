Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:51018 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751164AbdBGGio (ORCPT <rfc822;backports@vger.kernel.org>);
        Tue, 7 Feb 2017 01:38:44 -0500
Message-ID: <1486449517.5430.12.camel@sipsolutions.net> (sfid-20170207_073846_216177_5FDA6108)
Subject: Re: deprecating more kernel versions
From: Johannes Berg <johannes@sipsolutions.net>
To: Steve deRosier <derosier@gmail.com>, Luca Coelho <luca@coelho.fi>
Cc: Arend Van Spriel <arend.vanspriel@broadcom.com>,
        backports@vger.kernel.org
Date: Tue, 07 Feb 2017 07:38:37 +0100
In-Reply-To: <CALLGbRJ8SG=u3JoShHAZ_p1d=mRRNiBJhXdzCddRYK1Hf_bBjQ@mail.gmail.com> (sfid-20170207_054810_868143_AAFA8F07)
References: <1486399064.5430.7.camel@sipsolutions.net>
         <04ef169d-49b1-98e0-1db6-7c4e7e9b5c9f@broadcom.com>
         <1486441223.3070.2.camel@coelho.fi>
         <CALLGbRJ8SG=u3JoShHAZ_p1d=mRRNiBJhXdzCddRYK1Hf_bBjQ@mail.gmail.com>
         (sfid-20170207_054810_868143_AAFA8F07)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


> Maybe this comes from ignorance or inexperience, but I'll throw out a
> few questions/thoughts.
> 
> * Do we have a policy on how far back or when/how we deprecate
> versions?

Not really.

> * What is the implication of doing so?  For example, is it a "we
> don't bother testing with versions less than 3.10"? or "it's going to
> stop working for < 3.10?"

In practice, it's going to be both, since it's not working for < 3.10
today :)

> * Is a deprecation in this case a warning we're not going to be
> supporting a version soon, or are we immediately dropping support?

If we make a decision now we should drop it immediately, since
otherwise we still have to bring it up again first.

* And finally the big one - what's the implication of _keeping_ a
> particular older version alive.

It's just a bunch more work to backport more APIs that old kernels
didn't have.

> I think an "official" position on the above would be appropriate and
> perhaps we should decide something and publish that.  And then the
> question won't come up anymore... we'll just deprecate at the correct
> time.
> 
> All that said, here's my issue - we still have customers doing
> integrations with our radios, supported via backports, as far back as
> 2.6.33!  Yes, that's NEW integrations. Usually has to do with BSPs
> that haven't been updated. Right now, to support that we're
> maintaining two backport "releases" one based on the 3.13 kernel for
> <3.0and one based on our 4.4.x kernel for the more modern ones
> (3.0+).

You can still add support for certain versions, even 2.6.33 if you
wish, I think. I have no problem for this to exist in the upstream
backport as well, but I don't want to be maintaining it myself.

Now, that said, 2.6.33 probably has some "special" challenges since
there was a lot of networking API changed somewhere around then, but
it's probably not impossible to do.

> I'll throw out another thought: what would be the implications of
> supporting all current non-eol LTS + all versions say the past 6
> (pick a number). So that'd be 3.2, 3.6, 3.10, 3.12, 3.16, 4.1,
> 4.4..4.10. Does that reduce the work, or does going all the way back
> to 3.2, even if we don't test and be sure say 3.3 works, still means
> we're doing all those version from 3.2 on?

It doesn't really make a significant difference, I think. Supporting
3.2 usually means supporting 3.3 as well, and then we might as well
compile-test 3.3 to make sure we didn't put an ifdef on 3.2 when it
should've been on 3.3.

For now I'm going to try to keep down to 3.0 and see what happens - I
haven't found any massive problem with that yet.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
