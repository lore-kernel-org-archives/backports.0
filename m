Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:39236 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751562AbdLATjZ (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 1 Dec 2017 14:39:25 -0500
Message-ID: <1512157163.25588.22.camel@sipsolutions.net> (sfid-20171201_204053_139050_544567D0)
Subject: Re: [Cocci] Parse error with genl-const.cocci
From: Johannes Berg <johannes@sipsolutions.net>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Remington Furman <remicles2@gmail.com>, backports@vger.kernel.org,
        cocci <cocci@systeme.lip6.fr>
Date: Fri, 01 Dec 2017 20:39:23 +0100
In-Reply-To: <alpine.DEB.2.20.1712011954500.2825@hadrien>
References: <925f98d2-047f-785f-4162-21b53a77cd62@gmail.com>
         <1512116859.25588.4.camel@sipsolutions.net>
         <5c6cb44c-9e19-8cf2-8946-a9c0e08c3974@gmail.com>
         (sfid-20171201_185732_488308_017133DA) <1512151378.25588.20.camel@sipsolutions.net>
         <alpine.DEB.2.20.1712011954500.2825@hadrien>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2017-12-01 at 19:57 +0100, Julia Lawall wrote:

> You can also set a timeout, for example --timeout 120 (120 seconds).  It
> will report on the files that timed out and you can check on them
> manually.  Some other useful options are:

Right, but the result won't compile if you do that and it doesn't
modify some files :-)

> --profile: see how long it spends in each rule or various parts of the
> OCaml code
> 
> --show-trying: see what function it is working on
> 
> --debug see what rule and with what inputs it is working on

I guess I should play with these and figure out why this particular
spatch is so slow, thanks for the pointers!

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
