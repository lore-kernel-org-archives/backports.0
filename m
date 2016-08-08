Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46894 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752345AbcHHRgL (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 8 Aug 2016 13:36:11 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 9C1E320254
	for <backports@vger.kernel.org>; Mon,  8 Aug 2016 17:36:09 +0000 (UTC)
Received: from mail-yb0-f173.google.com (mail-yb0-f173.google.com [209.85.213.173])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 9FF332017D
	for <backports@vger.kernel.org>; Mon,  8 Aug 2016 17:36:08 +0000 (UTC)
Received: by mail-yb0-f173.google.com with SMTP id g133so40221319ybf.2
        for <backports@vger.kernel.org>; Mon, 08 Aug 2016 10:36:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <trinity-50e3397a-cfd4-4f35-ab8b-51700c2a6cf6-1470642723593@3capp-gmx-bs12>
References: <trinity-50e3397a-cfd4-4f35-ab8b-51700c2a6cf6-1470642723593@3capp-gmx-bs12>
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Date: Mon, 8 Aug 2016 10:35:47 -0700
Message-ID: <CAB=NE6W=-sOfJCTHZSzk1pFC20Zh9R-rELOe2zcoCDhY_hw33Q@mail.gmail.com> (sfid-20160808_193613_258375_8FD0DBB4)
Subject: Re: gentree fails at no such file compat/crypto-skcipher.c
To: Peter Huewe <PeterHuewe@gmx.de>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, Aug 8, 2016 at 12:52 AM, Peter Huewe <PeterHuewe@gmx.de> wrote:
>
> I'm currently looking into the backports project to figure out how hard it would be to add the tpm drivers.
> However unfortunately the gentree.py script fails, and I cannot really explain why:
>
> ./gentree.py --clean --git-revision v4.0 /home/peter/linux-next/ /home/peter/linux-4.0-backport
> Get original source files from git ...
> Traceback (most recent call last):
>   File "./gentree.py", line 1091, in <module>
>     ret = _main()
>   File "./gentree.py", line 724, in _main
>     logwrite=logwrite)
>   File "./gentree.py", line 862, in process
>     disable_list = add_automatic_backports(args)
>   File "./gentree.py", line 276, in add_automatic_backports
>     automatic_backport_mangle_c_file(f)), 'r'):
> IOError: [Errno 2] No such file or directory: '/home/peter/linux-4.0-backport/compat/crypto-skcipher.c'

If you are trying to use a target v4.0 kernel then you need to
checkout the linux-4.0.y branch from the backports tree as well.

git checkout -b linux-4.0.y origin/linux-4.0.y

And try again.

But if you are trying to add new drivers, best is to just try the
master branch of backports against the latest respective linux-next
tag that backports works against, so in this case backports is at
backports-20160324, so you can set you linux-next tree to
next-20160324:

git reset --hard next-20160324

This is because contributions would go to the master branch of backports.

  Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
