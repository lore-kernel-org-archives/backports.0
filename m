Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from external1.orbit-lab.org ([128.6.192.131]:52482 "HELO
	external1.orbit-lab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1759674Ab3BZVP1 (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 26 Feb 2013 16:15:27 -0500
Received: from repository3.orbit-lab.org (repository3.orbit-lab.org [10.50.0.41])
	by external1.orbit-lab.org (Postfix) with ESMTP id AC9C35402B6
	for <backports@vger.kernel.org>; Tue, 26 Feb 2013 16:15:26 -0500 (EST)
To: backports@vger.kernel.org
Subject: Compat-wireless release for 2013-02-26 is baked
Message-Id: <20130226211526.9298A40AC0@repository3.orbit-lab.org>
Date: Tue, 26 Feb 2013 16:15:26 -0500 (EST)
From: compat@orbit-lab.org (Compat-wireless cronjob account)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

git fetch hauke (/var/opt/compat/compat-drivers)
Nothing new to pack.
HEAD is now at 81f04c4 compat-drivers: refresh patches
git fetch hauke (/var/opt/compat/compat)
Nothing new to pack.
HEAD is now at fb57da5 compat: update kernel versions in bin/get-compat-kernels
git fetch origin (/var/opt/compat/linux-next)
Nothing new to pack.
HEAD is now at ff8035a Add linux-next specific files for 20130226
git fetch origin (/var/opt/compat/unified/alx)
Nothing new to pack.
HEAD is now at 8f56f40 alx: improve self-test for FPGA
Error while updating from linux-next

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
skipping directory 2008
skipping directory 2009
skipping directory 2010
skipping directory 2011
skipping directory 2012
skipping directory 2013
ckmake-2012-06-29.log.bz2
ckmake-2012-07-03.log.bz2
ckmake-2012-08-26.log.bz2
ckmake-2012-08-27.log.bz2
ckmake-2012-08-28.log.bz2
ckmake-2012-08-29.log.bz2
ckmake-2012-08-30.log.bz2
ckmake-2012-08-31.log.bz2
ckmake-2012-09-01.log.bz2
ckmake-2012-09-02.log.bz2
ckmake-2012-09-03.log.bz2
ckmake-2012-09-05.log.bz2
ckmake-2012-09-07.log.bz2
ckmake-2012-09-08.log.bz2
ckmake-2012-09-09.log.bz2
ckmake-2012-09-10.log.bz2
ckmake-2012-09-14.log.bz2
ckmake-2012-09-15.log.bz2
ckmake-2012-09-16.log.bz2
ckmake-2012-09-17.log.bz2
ckmake-2012-09-18.log.bz2
ckmake-2012-09-19.log.bz2
ckmake-2012-09-20.log.bz2
ckmake-2012-09-21.log.bz2
ckmake-2012-09-22.log.bz2
ckmake-2012-09-23.log.bz2
ckmake-2012-09-24.log.bz2
ckmake-2012-09-25.log.bz2
ckmake-2012-09-26.log.bz2
ckmake-2012-09-27.log.bz2
ckmake-2012-10-03.log.bz2
ckmake-2012-10-19.log.bz2
ckmake-2012-10-20.log.bz2
ckmake-2012-10-21.log.bz2
ckmake-2012-10-27.log.bz2
ckmake-2012-10-28.log.bz2
ckmake-2012-10-29.log.bz2
ckmake-2012-10-30.log.bz2
ckmake-2012-11-04.log.bz2
ckmake-2012-11-05.log.bz2
ckmake-2012-11-06.log.bz2
ckmake-2012-11-07.log.bz2
ckmake-2012-11-08.log.bz2
ckmake-2012-11-09.log.bz2
ckmake-2012-11-10.log.bz2
ckmake-2012-11-11.log.bz2
ckmake-2012-11-12.log.bz2
ckmake-2012-11-13.log.bz2
ckmake-2012-11-14.log.bz2
ckmake-2012-11-17.log.bz2
ckmake-2012-11-18.log.bz2
ckmake-2012-11-19.log.bz2
ckmake-2012-11-20.log.bz2
ckmake-2012-11-21.log.bz2
ckmake-2012-11-22.log.bz2
ckmake-2012-11-23.log.bz2
ckmake-2012-11-24.log.bz2
ckmake-2012-11-25.log.bz2
ckmake-2012-12-01.log.bz2
ckmake-2012-12-02.log.bz2
ckmake-2012-12-04.log.bz2
ckmake-2012-12-05.log.bz2
ckmake-2012-12-06.log.bz2
ckmake-2012-12-13.log.bz2
ckmake-2012-12-14.log.bz2
ckmake-2012-12-15.log.bz2
ckmake-2012-12-16.log.bz2
ckmake-2012-12-17.log.bz2
ckmake-2012-12-18.log.bz2
ckmake-report-2012-06-29.log
ckmake-report-2012-07-03.log
ckmake-report-2012-08-26.log
ckmake-report-2012-08-27.log
ckmake-report-2012-08-28.log
ckmake-report-2012-08-29.log
ckmake-report-2012-08-30.log
ckmake-report-2012-08-31.log
ckmake-report-2012-09-01.log
ckmake-report-2012-09-02.log
ckmake-report-2012-09-03.log
ckmake-report-2012-09-05.log
ckmake-report-2012-09-07.log
ckmake-report-2012-09-08.log
ckmake-report-2012-09-09.log
ckmake-report-2012-09-10.log
ckmake-report-2012-09-14.log
ckmake-report-2012-09-15.log
ckmake-report-2012-09-16.log
ckmake-report-2012-09-17.log
ckmake-report-2012-09-18.log
ckmake-report-2012-09-19.log
ckmake-report-2012-09-20.log
ckmake-report-2012-09-21.log
ckmake-report-2012-09-22.log
ckmake-report-2012-09-23.log
ckmake-report-2012-09-24.log
ckmake-report-2012-09-25.log
ckmake-report-2012-09-26.log
ckmake-report-2012-09-27.log
ckmake-report-2012-10-03.log
ckmake-report-2012-10-19.log
ckmake-report-2012-10-20.log
ckmake-report-2012-10-21.log
ckmake-report-2012-10-27.log
ckmake-report-2012-10-28.log
ckmake-report-2012-10-29.log
ckmake-report-2012-10-30.log
ckmake-report-2012-11-04.log
ckmake-report-2012-11-05.log
ckmake-report-2012-11-06.log
ckmake-report-2012-11-07.log
ckmake-report-2012-11-08.log
ckmake-report-2012-11-09.log
ckmake-report-2012-11-10.log
ckmake-report-2012-11-11.log
ckmake-report-2012-11-12.log
ckmake-report-2012-11-13.log
ckmake-report-2012-11-14.log
ckmake-report-2012-11-17.log
ckmake-report-2012-11-18.log
ckmake-report-2012-11-19.log
ckmake-report-2012-11-20.log
ckmake-report-2012-11-21.log
ckmake-report-2012-11-22.log
ckmake-report-2012-11-23.log
ckmake-report-2012-11-24.log
ckmake-report-2012-11-25.log
ckmake-report-2012-12-01.log
ckmake-report-2012-12-02.log
ckmake-report-2012-12-04.log
ckmake-report-2012-12-05.log
ckmake-report-2012-12-06.log
ckmake-report-2012-12-13.log
ckmake-report-2012-12-14.log
ckmake-report-2012-12-15.log
ckmake-report-2012-12-16.log
ckmake-report-2012-12-17.log
ckmake-report-2012-12-18.log
compat-wireless-2012-06-29-p.tar.bz2
compat-wireless-2012-06-29-pc.tar.bz2
compat-wireless-2012-06-29.tar.bz2
compat-wireless-2012-07-03-p.tar.bz2
compat-wireless-2012-07-03-pc.tar.bz2
compat-wireless-2012-07-03.tar.bz2
compat-wireless-2012-08-26-p.tar.bz2
compat-wireless-2012-08-26-pc.tar.bz2
compat-wireless-2012-08-26.tar.bz2
compat-wireless-2012-08-27-p.tar.bz2
compat-wireless-2012-08-27-pc.tar.bz2
compat-wireless-2012-08-27.tar.bz2
compat-wireless-2012-08-28-p.tar.bz2
compat-wireless-2012-08-28-pc.tar.bz2
compat-wireless-2012-08-28.tar.bz2
compat-wireless-2012-08-29-p.tar.bz2
compat-wireless-2012-08-29-pc.tar.bz2
compat-wireless-2012-08-29.tar.bz2
compat-wireless-2012-08-30-p.tar.bz2
compat-wireless-2012-08-30-pc.tar.bz2
compat-wireless-2012-08-30.tar.bz2
compat-wireless-2012-08-31-p.tar.bz2
compat-wireless-2012-08-31-pc.tar.bz2
compat-wireless-2012-08-31.tar.bz2
compat-wireless-2012-09-01-p.tar.bz2
compat-wireless-2012-09-01-pc.tar.bz2
compat-wireless-2012-09-01.tar.bz2
compat-wireless-2012-09-02-p.tar.bz2
compat-wireless-2012-09-02-pc.tar.bz2
compat-wireless-2012-09-02.tar.bz2
compat-wireless-2012-09-03-p.tar.bz2
compat-wireless-2012-09-03-pc.tar.bz2
compat-wireless-2012-09-03.tar.bz2
compat-wireless-2012-09-05-p.tar.bz2
compat-wireless-2012-09-05-pc.tar.bz2
compat-wireless-2012-09-05.tar.bz2
compat-wireless-2012-09-07-p.tar.bz2
compat-wireless-2012-09-07-pc.tar.bz2
compat-wireless-2012-09-07.tar.bz2
compat-wireless-2012-09-08-p.tar.bz2
compat-wireless-2012-09-08-pc.tar.bz2
compat-wireless-2012-09-08.tar.bz2
compat-wireless-2012-09-09-p.tar.bz2
compat-wireless-2012-09-09-pc.tar.bz2
compat-wireless-2012-09-09.tar.bz2
compat-wireless-2012-09-10-p.tar.bz2
compat-wireless-2012-09-10-pc.tar.bz2
compat-wireless-2012-09-10.tar.bz2
compat-wireless-2012-09-14-p.tar.bz2
compat-wireless-2012-09-14-pc.tar.bz2
compat-wireless-2012-09-14.tar.bz2
compat-wireless-2012-09-15-p.tar.bz2
compat-wireless-2012-09-15-pc.tar.bz2
compat-wireless-2012-09-15.tar.bz2
compat-wireless-2012-09-16-p.tar.bz2
compat-wireless-2012-09-16-pc.tar.bz2
compat-wireless-2012-09-16.tar.bz2
compat-wireless-2012-09-17-p.tar.bz2
compat-wireless-2012-09-17-pc.tar.bz2
compat-wireless-2012-09-17.tar.bz2
compat-wireless-2012-09-18-p.tar.bz2
compat-wireless-2012-09-18-pc.tar.bz2
compat-wireless-2012-09-18.tar.bz2
compat-wireless-2012-09-19-p.tar.bz2
compat-wireless-2012-09-19-pc.tar.bz2
compat-wireless-2012-09-19.tar.bz2
compat-wireless-2012-09-20-p.tar.bz2
compat-wireless-2012-09-20-pc.tar.bz2
compat-wireless-2012-09-20.tar.bz2
compat-wireless-2012-09-21-p.tar.bz2
compat-wireless-2012-09-21-pc.tar.bz2
compat-wireless-2012-09-21.tar.bz2
compat-wireless-2012-09-22-p.tar.bz2
compat-wireless-2012-09-22-pc.tar.bz2
compat-wireless-2012-09-22.tar.bz2
compat-wireless-2012-09-23-p.tar.bz2
compat-wireless-2012-09-23-pc.tar.bz2
compat-wireless-2012-09-23.tar.bz2
compat-wireless-2012-09-24-p.tar.bz2
compat-wireless-2012-09-24-pc.tar.bz2
compat-wireless-2012-09-24.tar.bz2
compat-wireless-2012-09-25-p.tar.bz2
compat-wireless-2012-09-25-pc.tar.bz2
compat-wireless-2012-09-25.tar.bz2
compat-wireless-2012-09-26-p.tar.bz2
compat-wireless-2012-09-26-pc.tar.bz2
compat-wireless-2012-09-26.tar.bz2
compat-wireless-2012-09-27-p.tar.bz2
compat-wireless-2012-09-27-pc.tar.bz2
compat-wireless-2012-09-27.tar.bz2
compat-wireless-2012-10-03-p.tar.bz2
compat-wireless-2012-10-03-pc.tar.bz2
compat-wireless-2012-10-03.tar.bz2
compat-wireless-2012-10-19-p.tar.bz2
compat-wireless-2012-10-19-pc.tar.bz2
compat-wireless-2012-10-19.tar.bz2
compat-wireless-2012-10-20-p.tar.bz2
compat-wireless-2012-10-20-pc.tar.bz2
compat-wireless-2012-10-20.tar.bz2
compat-wireless-2012-10-21-p.tar.bz2
compat-wireless-2012-10-21-pc.tar.bz2
compat-wireless-2012-10-21.tar.bz2
compat-wireless-2012-10-27-p.tar.bz2
compat-wireless-2012-10-27-pc.tar.bz2
compat-wireless-2012-10-27.tar.bz2
compat-wireless-2012-10-28-p.tar.bz2
compat-wireless-2012-10-28-pc.tar.bz2
compat-wireless-2012-10-28.tar.bz2
compat-wireless-2012-10-29-p.tar.bz2
compat-wireless-2012-10-29-pc.tar.bz2
compat-wireless-2012-10-29.tar.bz2
compat-wireless-2012-10-30-p.tar.bz2
compat-wireless-2012-10-30-pc.tar.bz2
compat-wireless-2012-10-30.tar.bz2
compat-wireless-2012-11-04-p.tar.bz2
compat-wireless-2012-11-04-pc.tar.bz2
compat-wireless-2012-11-04.tar.bz2
compat-wireless-2012-11-05-p.tar.bz2
compat-wireless-2012-11-05-pc.tar.bz2
compat-wireless-2012-11-05.tar.bz2
compat-wireless-2012-11-06-p.tar.bz2
compat-wireless-2012-11-06-pc.tar.bz2
compat-wireless-2012-11-06.tar.bz2
compat-wireless-2012-11-07-p.tar.bz2
compat-wireless-2012-11-07-pc.tar.bz2
compat-wireless-2012-11-07.tar.bz2
compat-wireless-2012-11-08-p.tar.bz2
compat-wireless-2012-11-08-pc.tar.bz2
compat-wireless-2012-11-08.tar.bz2
compat-wireless-2012-11-09-p.tar.bz2
compat-wireless-2012-11-09-pc.tar.bz2
compat-wireless-2012-11-09.tar.bz2
compat-wireless-2012-11-10-p.tar.bz2
compat-wireless-2012-11-10-pc.tar.bz2
compat-wireless-2012-11-10.tar.bz2
compat-wireless-2012-11-11-p.tar.bz2
compat-wireless-2012-11-11-pc.tar.bz2
compat-wireless-2012-11-11.tar.bz2
compat-wireless-2012-11-12-p.tar.bz2
compat-wireless-2012-11-12-pc.tar.bz2
compat-wireless-2012-11-12.tar.bz2
compat-wireless-2012-11-13-p.tar.bz2
compat-wireless-2012-11-13-pc.tar.bz2
compat-wireless-2012-11-13.tar.bz2
compat-wireless-2012-11-14-p.tar.bz2
compat-wireless-2012-11-14-pc.tar.bz2
compat-wireless-2012-11-14.tar.bz2
compat-wireless-2012-11-17-p.tar.bz2
compat-wireless-2012-11-17-pc.tar.bz2
compat-wireless-2012-11-17.tar.bz2
compat-wireless-2012-11-18-p.tar.bz2
compat-wireless-2012-11-18-pc.tar.bz2
compat-wireless-2012-11-18.tar.bz2
compat-wireless-2012-11-19-p.tar.bz2
compat-wireless-2012-11-19-pc.tar.bz2
compat-wireless-2012-11-19.tar.bz2
compat-wireless-2012-11-20-p.tar.bz2
compat-wireless-2012-11-20-pc.tar.bz2
compat-wireless-2012-11-20.tar.bz2
compat-wireless-2012-11-21-p.tar.bz2
compat-wireless-2012-11-21-pc.tar.bz2
compat-wireless-2012-11-21.tar.bz2
compat-wireless-2012-11-22-p.tar.bz2
compat-wireless-2012-11-22-pc.tar.bz2
compat-wireless-2012-11-22.tar.bz2
compat-wireless-2012-11-23-p.tar.bz2
compat-wireless-2012-11-23-pc.tar.bz2
compat-wireless-2012-11-23.tar.bz2
compat-wireless-2012-11-24-p.tar.bz2
compat-wireless-2012-11-24-pc.tar.bz2
compat-wireless-2012-11-24.tar.bz2
compat-wireless-2012-11-25-p.tar.bz2
compat-wireless-2012-11-25-pc.tar.bz2
compat-wireless-2012-11-25.tar.bz2
compat-wireless-2012-12-01-p.tar.bz2
compat-wireless-2012-12-01-pc.tar.bz2
compat-wireless-2012-12-01.tar.bz2
compat-wireless-2012-12-02-p.tar.bz2
compat-wireless-2012-12-02-pc.tar.bz2
compat-wireless-2012-12-02.tar.bz2
compat-wireless-2012-12-04-p.tar.bz2
compat-wireless-2012-12-04-pc.tar.bz2
compat-wireless-2012-12-04.tar.bz2
compat-wireless-2012-12-05-p.tar.bz2
compat-wireless-2012-12-05-pc.tar.bz2
compat-wireless-2012-12-05.tar.bz2
compat-wireless-2012-12-06-p.tar.bz2
compat-wireless-2012-12-06-pc.tar.bz2
compat-wireless-2012-12-06.tar.bz2
compat-wireless-2012-12-13-p.tar.bz2
compat-wireless-2012-12-13-pc.tar.bz2
compat-wireless-2012-12-13.tar.bz2
compat-wireless-2012-12-14-p.tar.bz2
compat-wireless-2012-12-14-pc.tar.bz2
compat-wireless-2012-12-14.tar.bz2
compat-wireless-2012-12-15-p.tar.bz2
compat-wireless-2012-12-15-pc.tar.bz2
compat-wireless-2012-12-15.tar.bz2
compat-wireless-2012-12-16-p.tar.bz2
compat-wireless-2012-12-16-pc.tar.bz2
compat-wireless-2012-12-16.tar.bz2
compat-wireless-2012-12-17-p.tar.bz2
compat-wireless-2012-12-17-pc.tar.bz2
compat-wireless-2012-12-17.tar.bz2
compat-wireless-2012-12-18-p.tar.bz2
compat-wireless-2012-12-18-pc.tar.bz2
compat-wireless-2012-12-18.tar.bz2
sha1sums.txt

sent 2023091 bytes  received 3010960 bytes  47268.08 bytes/sec
total size is 1163331375  speedup is 231.09
