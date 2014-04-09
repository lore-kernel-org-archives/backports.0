Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:39168 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758317AbaDIK7q (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 9 Apr 2014 06:59:46 -0400
Message-ID: <53452817.5060502@broadcom.com> (sfid-20140409_125948_482296_E2FE4840)
Date: Wed, 9 Apr 2014 12:59:35 +0200
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.cz>, Felix Fietkau <nbd@openwrt.org>,
	Mauro Carvalho Chehab <m.chehab@samsung.com>
Subject: Re: Bumping required kernels to 3.0 for Linux backports ?
References: <CAB=NE6VvyBKzEg=ErZzQMktY8eLytQ21JCPrOQbxvZ9m-nqHkw@mail.gmail.com>
In-Reply-To: <CAB=NE6VvyBKzEg=ErZzQMktY8eLytQ21JCPrOQbxvZ9m-nqHkw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 09/04/14 03:03, Luis R. Rodriguez wrote:
> Folks,
>

[...]

> To start off -- what's the *last* kernel you realistically need for
> your users to use backports right now? Is it really 2.6.25? Would
> anyone kick and scream if for the backports-3.15 release try take
> things up to support only down to least 3.0 *right now* ?

A lot of test teams in broadcom wlan are still using Fedora 15 running a 
2.6.38 kernel. We are pushing them to move to Fedora 19.

Regards,
Arend

> [0] http://www.do-not-panic.com/2014/04/automatic-linux-kernel-backporting-with-coccinelle.html
>
>    Luis
> --
> To unsubscribe from this list: send the line "unsubscribe backports" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

