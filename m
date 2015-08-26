Return-path: <backports-owner@vger.kernel.org>
Received: from mail-yk0-f174.google.com ([209.85.160.174]:36305 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919AbbHZTYL convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 26 Aug 2015 15:24:11 -0400
Received: by ykfw73 with SMTP id w73so197792681ykf.3
        for <backports@vger.kernel.org>; Wed, 26 Aug 2015 12:24:11 -0700 (PDT)
MIME-Version: 1.0
From: Ramprasad Vempati <ramprasad.vempati@gmail.com>
Date: Thu, 27 Aug 2015 00:53:51 +0530
Message-ID: <CAB6w8enUz5ahWzvM80Q1cgtsbOV70ZcO3Mfpw9kNOrPLOE5Npw@mail.gmail.com> (sfid-20150826_212413_399807_3DED2A09)
Subject: Backports Integration Error during patch!
To: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

I'm trying to integrate Linux kernel 4.1.1 backports into 3.18.13 Kernel.

I've done below steps:

1.       Created a top level directory: “backports-integration” .

2.       git clone
git://git.kernel.org/pub/scm/linux/kernel/git/backports/backports.git

3.       cd backports

4.       git checkout v4.1.1-1

5.       cd ..

6.       git clone
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
linux-next  <<<<<<<<<<<<<<< This is created as I though kernel sources
for 4.1.1 is required

7.       cd linux-next

8.       git checkout v4.1.1

9.       cd ..

10.   git clone
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git

11.   cd linux-try

12.   git checkout v3.18.13

13.   cd ..

14.   cd backports

15.   Executed “./gentree.py --integrate --clean --gitdebug
--git-revision v4.1.1
/root/Desktop/ramprasad/backports-integration/linux-next/
/root/Desktop/ramprasad/backports-integration/linux-try/”

I've ensured there are no local changes by creating multiple git
clones and dong the above steps. So no local changes are present.


For the above command, I get below error:


root@ramprasad-11ac-lap:~/Desktop/ramprasad/backports-integration/backports#
./gentree.py --integrate --clean --gitdebug --git-revision v4.1.1
/root/Desktop/ramprasad/backports-integration/linux-next/
/root/Desktop/ramprasad/backports-integration/linux-try/
Get original source files from git ...
Applying patches from patches to
/root/Desktop/ramprasad/backports-integration/linux-try/backports/ ...
Modify Kconfig tree ...
Rewrite Makefiles and Kconfig files ...
Applying patches from integration-patches/ to
/root/Desktop/ramprasad/backports-integration/linux-try/ ...
Failed to apply changes from
001-enable-backports/0001-enable-backports-built-in.patch
> patching file Makefile
> Hunk #1 succeeded at 545 (offset 3 lines).
> Hunk #2 FAILED at 821.
> Hunk #3 succeeded at 901 (offset 63 lines).
> 1 out of 3 hunks FAILED -- saving rejects to file Makefile.rej
Traceback (most recent call last):
  File "./gentree.py", line 1091, in <module>
    ret = _main()
  File "./gentree.py", line 724, in _main
    logwrite=logwrite)
  File "./gentree.py", line 1078, in process
    bpid.project_dir, logwrite)
  File "./gentree.py", line 552, in apply_patches
    raise Exception('Patch failed')
Exception: Patch failed
root@ramprasad-11ac-lap:~/Desktop/ramprasad/backports-integration/backports
--
To unsubscribe from this list: send the line "unsubscribe backports" in
