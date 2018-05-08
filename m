Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:51604 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754231AbeEHHJV (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 8 May 2018 03:09:21 -0400
Message-ID: <1525770549.14830.1.camel@sipsolutions.net> (sfid-20180508_090923_752185_689AD7AD)
Subject: Re: Failed to backport from from Linux 4.4 drivers to Linux 3.10.108
From: Johannes Berg <johannes@sipsolutions.net>
To: Masashi Honma <masashi.honma@gmail.com>, backports@vger.kernel.org
Date: Tue, 08 May 2018 11:09:09 +0200
In-Reply-To: <149bc44e-f521-cf4a-397a-c8e42d00081b@gmail.com> (sfid-20180508_050515_355323_48A52193)
References: <149bc44e-f521-cf4a-397a-c8e42d00081b@gmail.com>
         (sfid-20180508_050515_355323_48A52193)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2018-05-08 at 12:05 +0900, Masashi Honma wrote:
> I am trying to backport from Linux 4.4

This will probably not work unless you use an old backports git tree
snapshot.

> The gentree.py command resulted in these messages.
> ----
> Get original source files from git ...
> Applying patches from patches to /home/honma/git/linux-stable/backports/ ...
> Failed to process SmPL patch 
> collateral-evolutions/network/0027-genl-const/genl-const.cocci
> Traceback (most recent call last):
>    File "./gentree.py", line 1091, in <module>
>      ret = _main()
>    File "./gentree.py", line 724, in _main
>      logwrite=logwrite)
>    File "./gentree.py", line 906, in process
>      apply_patches(args, "backport", source_dir, 'patches', 
> bpid.target_dir, logwrite)
>    File "./gentree.py", line 605, in apply_patches
>      raise Exception('SmPL patch failed')
> Exception: SmPL patch failed

Then again, this shouldn't happen.

> Is this caused by my invalid procedure ?
> If so, please tell me right way.

No, looks fine - perhaps your spatch version isn't right? What version
do you have, and what does it say if you run

mkdir /tmp/xyz && spatch --sp-file .../genl-const.cocci --dir /tmp/xyz

or something like that?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
