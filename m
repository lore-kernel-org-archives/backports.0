Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:62690 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754477Ab3EGKEd (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 7 May 2013 06:04:33 -0400
Received: by mail-pa0-f44.google.com with SMTP id jh10so380893pab.17
        for <backports@vger.kernel.org>; Tue, 07 May 2013 03:04:33 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 2/2] ckmake: add support for kernel ranges
Date: Tue,  7 May 2013 02:07:06 -0700
Message-Id: <1367917626-21870-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20130507_120436_562355_2C81487D)
In-Reply-To: <1367917626-21870-1-git-send-email-mcgrof@do-not-panic.com>
References: <1367917626-21870-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

At times you may only want to test with ckmake a specific
kernel range or target kernels. You can do that now. ckmake
will use this list against what it finds on your system.

Examples:

  * ckmake --revs 3.3..3.4
  * ckmake --revs 2.6.24,2.6.30,2.6.32..3.2,3.4

The base kernels revisions is what is expected. The base kernel
revision of say 3.4.5 is 3.4, the base revision of say 2.6.24.2
is 2.6.24.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 devel/ckmake |  146 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 142 insertions(+), 4 deletions(-)

diff --git a/devel/ckmake b/devel/ckmake
index d77da62..7c0ab5a 100755
--- a/devel/ckmake
+++ b/devel/ckmake
@@ -220,6 +220,86 @@ def sig_handler(signal, frame):
 	clean()
 	sys.exit(-2)
 
+def compute_rel_weight_base_2(rel_specs):
+	weight = 0
+	sublevel = 0
+
+	if (rel_specs['SUBLEVEL'] != ''):
+		sublevel = int(rel_specs['SUBLEVEL'].lstrip(".")) * 20
+	else:
+		sublevel = 5
+
+	weight = (int(rel_specs['VERSION'])    << 32) + \
+		 (int(rel_specs['PATCHLEVEL']) << 16) + \
+		 (sublevel   		       << 8 )
+
+	return weight
+
+def compute_rel_weight_base_3(rel_specs):
+	weight = 0
+	extra = 0
+	sublevel = 0
+
+	weight = (int(rel_specs['VERSION'])    << 32) + \
+		 (int(rel_specs['PATCHLEVEL']) << 16)
+
+	return weight
+
+def compute_rel_weight_base(rel_specs):
+
+	if (int(rel_specs['VERSION']) == 2):
+		return compute_rel_weight_base_2(rel_specs)
+	if (int(rel_specs['VERSION']) == 3):
+		return compute_rel_weight_base_3(rel_specs)
+	return 0
+
+def compute_rel_weight(rel_specs):
+	weight = 0
+	extra = 0
+	sublevel = 0
+
+	if (rel_specs['EXTRAVERSION'] != ''):
+		if ("."  in rel_specs['EXTRAVERSION'] or
+		    "rc" in rel_specs['EXTRAVERSION']):
+			rc = rel_specs['EXTRAVERSION'].lstrip("-rc")
+			if (rc == ""):
+				rc = 0
+			else:
+				rc = int(rc) - 20
+			extra = int(rc)
+		else:
+			extra = int(rel_specs['EXTRAVERSION']) + 10
+
+	if (rel_specs['SUBLEVEL'] != ''):
+		sublevel = int(rel_specs['SUBLEVEL'].lstrip(".")) * 20
+	else:
+		sublevel = 5
+
+	weight = (int(rel_specs['VERSION'])    << 32) + \
+		 (int(rel_specs['PATCHLEVEL']) << 16) + \
+		 (sublevel   		       << 8 ) + \
+		 (extra * 60)
+
+	return weight
+
+def get_rel_spec_base(rel):
+	m = re.match(r"v*(?P<VERSION>\d+)\.+" \
+		     "(?P<PATCHLEVEL>\d+)[.]*" \
+		     "(?P<SUBLEVEL>\d*)",
+		     rel)
+	if (not m):
+		return m
+	rel_specs = m.groupdict()
+	return rel_specs
+
+def get_base_spec(rel_specs):
+	if (int(rel_specs['VERSION']) == 2):
+		rel = rel_specs['VERSION'] + "." + rel_specs['PATCHLEVEL'] + \
+		      "." + rel_specs['SUBLEVEL']
+	else:
+		rel = rel_specs['VERSION'] + "." + rel_specs['PATCHLEVEL']
+	return get_rel_spec_base(rel)
+
 def get_rel_spec_ubuntu(rel):
 	if ("rc" in rel):
 		m = re.match(r"v*(?P<VERSION>\d+)\.+" \
@@ -279,7 +359,9 @@ def krel_base_smaller(new_rel, rel):
 class kernel_set():
 	def __init__(self, stdscr):
 		self.queue = Queue()
+		self.target_krevs = []
 		self.releases = []
+		self.target_kranges = []
 		self.stdscr = stdscr
 		self.lock = Lock()
 		signal.signal(signal.SIGINT, sig_handler)
@@ -312,6 +394,16 @@ class kernel_set():
 		self.lock.acquire()
 		self.stdscr.refresh()
 		self.lock.release()
+	def wight_in_target_kranges(self, rel_base_weight):
+		for krange in self.target_kranges:
+			if (krange['is_range']):
+				if (krange['weight_lower'] <= rel_base_weight and
+				    rel_base_weight <= krange['weight_upper']):
+					return True
+			else:
+				if (rel_base_weight == krange['weight']):
+					return True
+		return False
 	def evaluate_new_rel(self, new_rel):
 		for rel in self.releases:
 			if (krel_base_update(new_rel, rel)):
@@ -320,14 +412,21 @@ class kernel_set():
 				break
 			if (krel_base_smaller(new_rel, rel)):
 				return
+		if (self.target_kranges):
+			if (not self.wight_in_target_kranges(new_rel['base_weight'])):
+				return
 		self.releases.insert(new_rel['idx'], new_rel)
-	def parse_releases(self):
+	def parse_releases(self, target_kranges):
+		self.target_kranges = target_kranges
 		for dirname, dirnames, filenames in os.walk(modules):
 			dirnames.sort()
 			for subdirname in dirnames:
 				specifics = get_rel_spec_ubuntu(subdirname)
 				if (not specifics):
 					continue
+				base_specs = get_base_spec(specifics)
+				if (not base_specs):
+					continue
 				rc = False
 
 				ver = specifics['VERSION'] + '.' + \
@@ -339,6 +438,7 @@ class kernel_set():
 				else:
 					ver = ver + '.' + specifics['SUBLEVEL']
 
+				get_rel_spec_base(subdirname)
 				rel = dict(idx=len(self.releases),
 					   name=subdirname,
 					   full_path=dirname + '/' +
@@ -349,6 +449,8 @@ class kernel_set():
 					   pat=specifics['PATCHLEVEL'],
 					   sub=specifics['SUBLEVEL'],
 					   ext=specifics['EXTRAVERSION'],
+					   base_weight=compute_rel_weight_base(base_specs),
+					   weight=compute_rel_weight(specifics),
 					   processed=False,
 					   log='',
 					   status=1234)
@@ -396,25 +498,61 @@ class kernel_set():
 		self.stdscr.refresh()
 		self.lock.release()
 
-def main(stdscr, args):
+def main(stdscr, args, target_kranges):
 	kset = kernel_set(stdscr)
 
 	kset.set_locale()
-	kset.parse_releases()
+	kset.parse_releases(target_kranges)
 	kset.setup_screen()
 	kset.create_threads(args)
 	kset.kick_threads()
 	kset.wait_threads()
 	kset.refresh()
 
+def build_krange(krange_list):
+	if (len(krange_list) == 2):
+		lower = krange_list.pop(0)
+		upper = krange_list.pop(0)
+		specifics_lower = get_rel_spec_base(lower)
+		if (not specifics_lower):
+			return {}
+		specifics_upper = get_rel_spec_base(upper)
+		if (not specifics_upper):
+			return {}
+		krange = dict(is_range = True,
+			      weight_lower=compute_rel_weight_base(specifics_lower),
+			      weight_upper=compute_rel_weight_base(specifics_upper))
+		return krange
+	elif (len(krange_list) == 1):
+		rel = krange_list.pop(0)
+		specifics = get_rel_spec_base(rel)
+		if (not specifics):
+			return {}
+		krange = dict(is_range = False,
+			      weight=compute_rel_weight_base(specifics))
+		return krange
+	else:
+		return {}
+	return {}
+
 if __name__ == "__main__":
 	parser = argparse.ArgumentParser(description='compile against all kernels you have')
 	parser.add_argument('--allyesconfig', const=True, default=False, action="store_const",
 			    help='Build allyesconfig rather than only backport code.')
 	parser.add_argument('--defconfig', metavar='<name>', type=str,
 			    help='Build this defconfig rather than only backport code.')
+	parser.add_argument('--revs', metavar='<revision-list>', type=str,
+			    help='Optional list of kernel revisions to test for, example: 2.6.24,2.6.30,2.6.32..3.2,3.4')
 	args = parser.parse_args()
 
+	target_kranges = []
+	if (args.revs):
+		klists = args.revs.split(",")
+		for klist in klists:
+			krange_list = klist.split("..")
+			krange = build_krange(krange_list)
+			target_kranges.append(krange)
+
 	if not os.path.exists(modules):
 		print "%s does not exist" % (modules)
 		sys.exit(1)
@@ -428,7 +566,7 @@ if __name__ == "__main__":
 	if os.path.exists(tmp_path):
 		rmtree(tmp_path)
 	os.makedirs(tmp_path)
-	curses.wrapper(main, args)
+	curses.wrapper(main, args, target_kranges)
 	kill_curses()
 	process_logs()
 	clean()
-- 
1.7.10.4

