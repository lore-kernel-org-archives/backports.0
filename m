Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from external1.orbit-lab.org ([128.6.192.131]:45014 "HELO
	external1.orbit-lab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754201Ab3BJVMi (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 10 Feb 2013 16:12:38 -0500
Received: from repository3.orbit-lab.org (repository3.orbit-lab.org [10.50.0.41])
	by external1.orbit-lab.org (Postfix) with ESMTP id 031385401CC
	for <backports@vger.kernel.org>; Sun, 10 Feb 2013 16:12:37 -0500 (EST)
To: backports@vger.kernel.org
Subject: Compat-wireless release for 2013-02-10 is baked
Message-Id: <20130210211236.CA5BA40AC0@repository3.orbit-lab.org>
Date: Sun, 10 Feb 2013 16:12:36 -0500 (EST)
From: compat@orbit-lab.org (Compat-wireless cronjob account)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

git fetch hauke (/var/opt/compat/compat-drivers)
>From git://github.com/hauke/compat-drivers
   1ef7c8a..9ae3560  hauke      -> hauke/hauke
HEAD is now at 1ef7c8a compat-drivers: refresh patches on next-20130202
git fetch hauke (/var/opt/compat/compat)
>From git://github.com/hauke/compat
   726d9b2..3dfdf5d  hauke      -> hauke/hauke
HEAD is now at 726d9b2 compat: netdev_set_default_ethtool_ops() is not in kernel 3.7.5
git fetch origin (/var/opt/compat/linux-next)
Nothing new to pack.
HEAD is now at e347c98 Add linux-next specific files for 20130208
git fetch origin (/var/opt/compat/unified/alx)
Nothing new to pack.
HEAD is now at 8f56f40 alx: improve self-test for FPGA
Traceback (most recent call last):
  File "/var/opt/compat//compat/bin/ckmake", line 324, in <module>
    curses.wrapper(main)
  File "/usr/lib/python2.7/curses/wrapper.py", line 22, in wrapper
    stdscr = curses.initscr()
  File "/usr/lib/python2.7/curses/__init__.py", line 33, in initscr
    fd=_sys.__stdout__.fileno())
_curses.error: setupterm: could not find terminal
Failed...
/usr/bin/sha1sum: *.tar.bz2: No such file or directory

compat-drivers code metrics

   1278976 - Total upstream lines of code being pulled

   network
   ----------------------------------------
      3047 - backport code changes
      2557 - backport code additions
       490 - backport code deletions
     14654 - backport from compat module
     17701 - total backport code
    1.3840 - % of code consists of backport work

   drm
   ----------------------------------------
       436 - backport code changes
       293 - backport code additions
       143 - backport code deletions
     14654 - backport from compat module
     15090 - total backport code
    1.1799 - % of code consists of backport work

Base tree: linux-next.git
Base tree version: next-20130110
compat.git: compat-v3.8-rc2-1-5-g59a1d45
compat-drivers release: compat-drivers-2013-01-08-3-6-g06fd418
Code metrics archive: http://bit.ly/H6BTF7
