Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:40157 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754456AbaDKT4Y (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 11 Apr 2014 15:56:24 -0400
Received: by mail-la0-f47.google.com with SMTP id pn19so3837341lab.6
        for <backports@vger.kernel.org>; Fri, 11 Apr 2014 12:56:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <00ac01cf55bf$71c84ae0$5558e0a0$@com>
References: <CAB=NE6VvyBKzEg=ErZzQMktY8eLytQ21JCPrOQbxvZ9m-nqHkw@mail.gmail.com>
 <53451077.2030102@openwrt.org> <CAB=NE6UUN4vQd3SpsvO5tcgaYq3YXQeE0KtZGki7p7OnR=J4RA@mail.gmail.com>
 <20140409191225.GA10560@kroah.com> <CAB=NE6VqY8yXoYuE0o01vq86imY8EtqLdkPa4bGMvR3bTaj5KQ@mail.gmail.com>
 <20140409202224.GA12953@kroah.com> <CAB=NE6XY5++p7hJQpQdwrFNUcGbUsKpC+oJiZQciXNduo+8j8A@mail.gmail.com>
 <20140409210613.GA14392@kroah.com> <s5heh15pr18.wl%tiwai@suse.de>
 <CAB=NE6VeNTFeGxKXpYunkU-W=JPLMpOnrehttvsqB+yXkdz5fg@mail.gmail.com>
 <006d01cf5591$694ee230$3beca690$@com> <CAB=NE6WpApJ7dn7GNYM0K7B6dyLeQVM+PRn1Ly=KXfy_96GSVA@mail.gmail.com>
 <1397241908.4643.1.camel@jlt4.sipsolutions.net> <CAB=NE6VzUomkkVXBtwKD0vbGwdHwoNivMrwipv=d-0Qw7Y__JQ@mail.gmail.com>
 <00ac01cf55bf$71c84ae0$5558e0a0$@com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Fri, 11 Apr 2014 12:56:01 -0700
Message-ID: <CAB=NE6XNKkvVgQ_tCnvHJVeE4e7W1QRr4fFqqdox++oz4GOHeA@mail.gmail.com> (sfid-20140411_215625_733128_87F751D4)
Subject: Re: Bumping required kernels to 3.0 for Linux backports ?
To: Harrison Lee <harrisonl@tme-inc.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, Apr 11, 2014 at 12:51 PM, Harrison Lee <harrisonl@tme-inc.com> wrote:
> I do understand that dumping "ancient" kernel support would make things a lot easier.
> But, in the embedded system world, upgrading kernel isn't that easy like in PC world.
> Most of those systems put to market today has 2.6 kernels, and backports project is a great job and it will revive so many systems if it keeps the tradition to support down 2.6.24 as its predecessor.

Supporting bad ways to do embedded development is not a good thing,
which is why I had poked OpenWrt folks, which do *good* embedded
development, and wanted to ensure we support them. Models not
embracing a path to upgrade should seriously consider their
architecture.

  Luis
