Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:41595 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934588Ab3GWWsk (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 23 Jul 2013 18:48:40 -0400
Received: by mail-lb0-f176.google.com with SMTP id z5so6748571lbh.35
        for <backports@vger.kernel.org>; Tue, 23 Jul 2013 15:48:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51EA9B80.8040301@hauke-m.de>
References: <20130720122708.GA24056@shaftnet.org> <51EA9B80.8040301@hauke-m.de>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 23 Jul 2013 15:48:18 -0700
Message-ID: <CAB=NE6VJU-rG7UDF5-DrB-kZVVXAoga2cKUGsor0BRrAp+Y7tw@mail.gmail.com> (sfid-20130724_004858_195537_B3FDFC0B)
Subject: Re: cw1200 and older kernels (newbie question)
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Solomon Peachy <pizza@shaftnet.org>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sat, Jul 20, 2013 at 7:15 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> There are some pending changes regarding the
> workqueue API changes in the kernel, you should base your work on top
> of that [1].

This should be merged now with two line additions I made. Further
changes / enhancements to this are welcomed however.

  Luis
