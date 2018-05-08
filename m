Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:40788 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753885AbeEHDFN (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 7 May 2018 23:05:13 -0400
Received: by mail-pf0-f169.google.com with SMTP id f189so23229624pfa.7
        for <backports@vger.kernel.org>; Mon, 07 May 2018 20:05:13 -0700 (PDT)
Received: from ?IPv6:2409:11:321:2100:7985:6369:ea00:43d2? ([2409:11:321:2100:7985:6369:ea00:43d2])
        by smtp.gmail.com with ESMTPSA id a6sm42678487pfo.88.2018.05.07.20.05.10
        for <backports@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 May 2018 20:05:11 -0700 (PDT)
To: backports@vger.kernel.org
From: Masashi Honma <masashi.honma@gmail.com>
Subject: Failed to backport from from Linux 4.4 drivers to Linux 3.10.108
Message-ID: <149bc44e-f521-cf4a-397a-c8e42d00081b@gmail.com> (sfid-20180508_050515_355323_48A52193)
Date: Tue, 8 May 2018 12:05:09 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

I am trying to backport from Linux 4.4 drivers to Linux 3.10.108 with 
backports.

These are my commands.
----
$ cd ~/git
$ git clone 
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

$ cd ~/git
$ git clone 
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
$ cd linux-stable
$ git checkout v3.10.108

$ cd ~/git
$ git clone 
git://git.kernel.org/pub/scm/linux/kernel/git/backports/backports.git
$ cd backports
$ git checkout linux-4.4.y
$ ./gentree.py --copy-list ./copy-list --integrate --clean 
--git-revision v4.4 ~/git/linux-next ~/git/linux-stable
----

The gentree.py command resulted in these messages.
----
Get original source files from git ...
Applying patches from patches to /home/honma/git/linux-stable/backports/ ...
Failed to process SmPL patch 
collateral-evolutions/network/0027-genl-const/genl-const.cocci
Traceback (most recent call last):
   File "./gentree.py", line 1091, in <module>
     ret = _main()
   File "./gentree.py", line 724, in _main
     logwrite=logwrite)
   File "./gentree.py", line 906, in process
     apply_patches(args, "backport", source_dir, 'patches', 
bpid.target_dir, logwrite)
   File "./gentree.py", line 605, in apply_patches
     raise Exception('SmPL patch failed')
Exception: SmPL patch failed
----

Is this caused by my invalid procedure ?
If so, please tell me right way.

Regards,
Masashi Honma.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
