Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/5] compat-drivers: fixes for admin-update.sh script, mostly refresh
Date: Thu, 29 Nov 2012 16:24:36 +0100
Message-Id: <1354202681-11787-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

This fixes some problems with in the admin-update.sh script.
Refresh did not copy the manually fixes drm patches into the network 
directory and it is now possible to refresh all patches from all 
directories with one run.

Hauke Mehrtens (5):
  compat-drivers: print original name and path of patch in refresh
  compat-drivers: remove copy of README in refresh
  compat-drivers: prevent mixing patches from different directories in
    refresh
  compat-drivers: run refresh for all patches
  compat-drivers: do not apply patches in natural sort order

 scripts/admin-update.sh |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

-- 
1.7.10.4
