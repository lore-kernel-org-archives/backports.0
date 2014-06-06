Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:40595 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750730AbaFFGJb (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 6 Jun 2014 02:09:31 -0400
Message-ID: <1402034962.4158.1.camel@jlt4.sipsolutions.net> (sfid-20140606_080933_070797_D7FF597C)
Subject: Re: Procedure to make the driver into the backports project
From: Johannes Berg <johannes@sipsolutions.net>
To: Fariya <fariyaf@gmail.com>
Cc: Arend van Spriel <arend@broadcom.com>, backports@vger.kernel.org
Date: Fri, 06 Jun 2014 08:09:22 +0200
In-Reply-To: <CAG+h2qi4b7OJwj+0X=M1sFC3GzfZ70EMc2tLTHW9YKoPw7gAeg@mail.gmail.com> (sfid-20140606_015911_268556_8849B381)
References: <CAG+h2qgoudEKwwL7pwYAaSbwvtJw4efi3e_or1yq0YOLm98fuQ@mail.gmail.com>
	 <53834533.8030800@broadcom.com> <53834C8E.5020903@broadcom.com>
	 <CAG+h2qgsK5LMaK768sVgpv5e08dPdH0QLoBraRhPDxA7yV2Kfw@mail.gmail.com>
	 <53874684.5070907@broadcom.com>
	 <CAG+h2qjirPQYDnajR-3VBvZgr+TxBkMwS3q5xXUrNC+YQmfuog@mail.gmail.com>
	 <CAG+h2qgi_bwyiC0YPSAkeXda7hTffVk6VbR8wA+gh5ztuTYQKQ@mail.gmail.com>
	 <5390E76A.1000205@broadcom.com>
	 <CAG+h2qi4b7OJwj+0X=M1sFC3GzfZ70EMc2tLTHW9YKoPw7gAeg@mail.gmail.com>
	 (sfid-20140606_015911_268556_8849B381)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2014-06-06 at 05:29 +0530, Fariya wrote:

> Considering that my driver doesn't compile on kernel versions < the
> latest one, I wanted to submit a patch/patches to handle all kernel
> versions. My question was relating to this - do I need to submit a
> patch [which handles kernel versions from 3.0 to 3.14] or patches for
> each kernel version from 3.0 to 3.14, which when applied on the latest
> driver of mine, would make it compilable for all kernel versions?

You need a single patch - hopefully much is already handled by the
backports project?

Ideally, you don't patch your driver at all, but extend the backport
(include files, compat.ko module) to provide the APIs that your driver
needs but that don't exist on older kernels. Sometimes, patching (the)
driver(s) is unavoidable, in which case semantic patches would be
preferred.

However, you can start with a patch and we can help you disentangle it.

johannes

