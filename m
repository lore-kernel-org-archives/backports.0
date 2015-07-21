Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:36607 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757371AbbGUAcs (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 20 Jul 2015 20:32:48 -0400
Received: by wicgb10 with SMTP id gb10so40523944wic.1
        for <backports@vger.kernel.org>; Mon, 20 Jul 2015 17:32:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1436657918-16124-1-git-send-email-hauke@hauke-m.de>
References: <1436657918-16124-1-git-send-email-hauke@hauke-m.de>
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Date: Mon, 20 Jul 2015 17:32:27 -0700
Message-ID: <CAB=NE6WBmH51NONny+yh+0xPF-rH+Jv0BVCKpFvprb7WOPQZFQ@mail.gmail.com> (sfid-20150721_023250_991991_DEF15098)
Subject: Re: [PATCH] rel-html: backports: add version 4.2
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sat, Jul 11, 2015 at 4:38 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> This adds the version 4.2 to the list of supported versions.
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Applied, and pushed, thanks!

BTW we really should just finish off support for parsing json and use
it. An example implementation would be for  Linux:

https://www.kernel.org/releases.json

My biggest brain-block with this though was trying to figure out a way
to generate the json file in a standard way across projects. While
Linux may use its own thing, we can for instance use the
release-weight routines used in rel-html (and used in
backports/lib/bpreqs.py) to for instance enable developers to annotate
in a configuration file the minimum supported releases. The last step
is figuring out which of the releases are supported and which are
deprecated. I think I have a solution to this, for which I just asked
for feedback on.

 Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
