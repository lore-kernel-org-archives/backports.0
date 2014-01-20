Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:51715 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752762AbaATXNK (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 20 Jan 2014 18:13:10 -0500
Received: by mail-ie0-f178.google.com with SMTP id x13so9151963ief.37
        for <backports@vger.kernel.org>; Mon, 20 Jan 2014 15:13:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAEsx0Y8ro45a3sWckyOc-vhTCqqCL6UkZYK=ME10zCLv5C3byQ@mail.gmail.com>
References: <CAEsx0Y8ro45a3sWckyOc-vhTCqqCL6UkZYK=ME10zCLv5C3byQ@mail.gmail.com>
Date: Mon, 20 Jan 2014 15:13:09 -0800
Message-ID: <CAEsx0Y8GqLQyQPpuBZkZEG5mWoh32Dx=jLdz1cKHaN4UQG305g@mail.gmail.com> (sfid-20140121_001312_460345_5522FAD9)
Subject: Re: backport module can't see built in kernel symbol
From: Daniel Schultze <kinglag@gmail.com>
To: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Developers,

I have been able to answer my own question, remember to reload the
kernel image not just the file system image.

Thank you,

-Dan

On Mon, Jan 20, 2014 at 12:59 PM, Daniel Schultze <kinglag@gmail.com> wrote:
> Developers,
>
> I am having some trouble getting my cross compiled backport working
> with my kernel. I am getting the error message:
>
>     bluetooth: Unknown symbol crypto_shash_setkey
>
> I ran nm on the kernel file vmLinux and grep'ed System.map which does show:
>
>     c0153d40 T crypto_shash_setkey
>
>
> So I'm a bit confused as to why bluetooth.ko can't "see" it. Any help
> you could give would be appreciated.
>
> -Dan
