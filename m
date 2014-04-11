Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:52818 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754626AbaDKSpY (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 11 Apr 2014 14:45:24 -0400
Message-ID: <1397241908.4643.1.camel@jlt4.sipsolutions.net> (sfid-20140411_204533_380332_5E8C101A)
Subject: Re: Bumping required kernels to 3.0 for Linux backports ?
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Cc: Harrison Lee <harrisonl@tme-inc.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Fri, 11 Apr 2014 20:45:08 +0200
In-Reply-To: <CAB=NE6WpApJ7dn7GNYM0K7B6dyLeQVM+PRn1Ly=KXfy_96GSVA@mail.gmail.com> (sfid-20140411_202409_632105_7926309A)
References: <CAB=NE6VvyBKzEg=ErZzQMktY8eLytQ21JCPrOQbxvZ9m-nqHkw@mail.gmail.com>
	 <53451077.2030102@openwrt.org>
	 <CAB=NE6UUN4vQd3SpsvO5tcgaYq3YXQeE0KtZGki7p7OnR=J4RA@mail.gmail.com>
	 <20140409191225.GA10560@kroah.com>
	 <CAB=NE6VqY8yXoYuE0o01vq86imY8EtqLdkPa4bGMvR3bTaj5KQ@mail.gmail.com>
	 <20140409202224.GA12953@kroah.com>
	 <CAB=NE6XY5++p7hJQpQdwrFNUcGbUsKpC+oJiZQciXNduo+8j8A@mail.gmail.com>
	 <20140409210613.GA14392@kroah.com> <s5heh15pr18.wl%tiwai@suse.de>
	 <CAB=NE6VeNTFeGxKXpYunkU-W=JPLMpOnrehttvsqB+yXkdz5fg@mail.gmail.com>
	 <006d01cf5591$694ee230$3beca690$@com>
	 <CAB=NE6WpApJ7dn7GNYM0K7B6dyLeQVM+PRn1Ly=KXfy_96GSVA@mail.gmail.com>
	 (sfid-20140411_202409_632105_7926309A)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2014-04-11 at 11:23 -0700, Luis R. Rodriguez wrote:

> compat-drivers is ancient as well, the new project is backports and we
> will be deprecating older kernels to help us scale better.

I know I pushed for the 2.6.24 deprecation, but do you see any
particular issue with other kernels < 3.0? The 2.6.24 was big and ugly,
but none of the other ones seem particularly big/ugly, and there aren't
a ton of patches either ...

Now, I'm all for dropping support if it really makes a difference, and
we might want to drop them from the ckmake tests to reduce the pain, but
I'm not entirely sure we should wholesale remove things if there are
still users for them out there.

johannes

