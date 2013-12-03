Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:42731 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003Ab3LCKCp (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 3 Dec 2013 05:02:45 -0500
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] ckmake: sort kernel releases properly
Date: Tue,  3 Dec 2013 11:02:41 +0100
Message-Id: <1386064961-852-1-git-send-email-johannes@sipsolutions.net> (sfid-20131203_110248_745901_9AB0D0C5)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Ever since 3.10, kernel releases weren't sorted properly.
Put them into a parsed list first and then sort them to
get the 3.10/11/12 etc. to the bottom of the list.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 devel/ckmake | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/devel/ckmake b/devel/ckmake
index 7c0ab5a..8c44051 100755
--- a/devel/ckmake
+++ b/devel/ckmake
@@ -419,7 +419,7 @@ class kernel_set():
 	def parse_releases(self, target_kranges):
 		self.target_kranges = target_kranges
 		for dirname, dirnames, filenames in os.walk(modules):
-			dirnames.sort()
+		        rels = []
 			for subdirname in dirnames:
 				specifics = get_rel_spec_ubuntu(subdirname)
 				if (not specifics):
@@ -439,8 +439,7 @@ class kernel_set():
 					ver = ver + '.' + specifics['SUBLEVEL']
 
 				get_rel_spec_base(subdirname)
-				rel = dict(idx=len(self.releases),
-					   name=subdirname,
+				rel = dict(name=subdirname,
 					   full_path=dirname + '/' +
 							 subdirname,
 					   version=ver,
@@ -454,6 +453,12 @@ class kernel_set():
 					   processed=False,
 					   log='',
 					   status=1234)
+                                rels.append(rel)
+			def relsort(rel):
+				return int(rel['ver']), int(rel['pat']), int(rel['sub'])
+			rels.sort(key=relsort)
+			for rel in rels:
+				rel['idx'] = len(self.releases)
 				self.evaluate_new_rel(rel)
 		self.refresh()
 	def setup_screen(self):
-- 
1.8.4.rc3

