Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:48448 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726504AbeIKNGs (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 11 Sep 2018 09:06:48 -0400
Message-ID: <fa1892a1698ad83235d455a947c354a54fa34c1d.camel@coelho.fi> (sfid-20180911_100843_159685_AF4740A4)
From: Luca Coelho <luca@coelho.fi>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: cocci@systeme.lip6.fr, backports@vger.kernel.org,
        johannes.berg@intel.com, felipe.balbi@intel.com
Date: Tue, 11 Sep 2018 11:08:37 +0300
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Weird problem trying to match code inside a function
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi Julia,

I bumped in to another weird problem.  I'm trying to match some code
inside a function that has a specific struct as a parameter, but I
can't get it to work.

This is cocci code I tried first: 

http://pastebin.coelho.fi/6f8f346822a7c99e.txt

And this is the file I'm trying to match:

http://pastebin.coelho.fi/f73f542932add1c6.txt

The led activate op changed from being a function that returns void to
one that returns int and I had to backport that.

The strange thing is that if I have only the first rule, it works fine,
but when I add the second rule it fails.

I can make it work if I match the entire code, without trying to match
the function in the first rule:

http://pastebin.coelho.fi/46c18ce890330d57.txt

And this is fine for me now, but I'm really curious as to why I had the
problem with my first implementation...

Can you shed some light?

--
Cheers,
Luca.

--
To unsubscribe from this list: send the line "unsubscribe backports" in
