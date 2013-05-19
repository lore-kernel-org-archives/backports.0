Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:65118 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748Ab3ESCd5 (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 18 May 2013 22:33:57 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb10so4662725pad.9
        for <backports@vger.kernel.org>; Sat, 18 May 2013 19:33:56 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: mricon@kernel.org, "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 1/8] rel_html: add support for project aliases
Date: Sat, 18 May 2013 19:33:35 -0700
Message-Id: <1368930822-13641-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20130519_043359_569333_373C5266)
In-Reply-To: <1368930822-13641-1-git-send-email-mcgrof@do-not-panic.com>
References: <1368930822-13641-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

If a project changes its name you may still want to print
out the older project's releases as well. Add support
for this by letting you specify project aliases, you
can have however many project aliases as you need.
An example of your foo.cfg

[project]
rel_html_proj           = backports
rel_html_proj_aliases   = compat-drivers

Project versioning for figuring out which release
is newer or older is independent of the project
name and aliases, its all unified.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 rel-html.py |   82 ++++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 58 insertions(+), 24 deletions(-)

diff --git a/rel-html.py b/rel-html.py
index 76764bf..068d855 100755
--- a/rel-html.py
+++ b/rel-html.py
@@ -274,6 +274,37 @@ class index_tarball_hunter(HTMLParser):
 			    eol_specs['PATCHLEVEL'] == rel_specs['PATCHLEVEL']):
 				return True
 		return False
+	def get_rel_match(self, value):
+		index_parser = self.index_parser
+		rel_match = dict(m = None, rel_name = "")
+		for rel_name in index_parser.rel_names:
+			m = re.match(r'' + rel_name + '-+' \
+				      "v*(?P<VERSION>\d+)\.+" \
+				      "(?P<PATCHLEVEL>\d+)\.*" \
+				      "(?P<SUBLEVEL>\w*)[.-]*" \
+				      "(?P<EXTRAVERSION>\w*)[-]*" \
+				      "(?P<RELMOD_UPDATE>\d*)[-]*" \
+				      "(?P<RELMOD_TYPE>[usnpc]*)", \
+				      value)
+			if (m):
+				rel_match['m'] = m
+				rel_match['rel_name'] = rel_name
+				return rel_match
+		return rel_match
+	def get_rel_match_next(self, value):
+		index_parser = self.index_parser
+		rel_match = dict(m = None, rel_name = "")
+		for rel_name in index_parser.rel_names:
+			m = re.match(r'' + rel_name + '+' \
+				      + '\-(?P<DATE_VERSION>' + index_parser.next_rel_date + '+)' \
+				      + '\-*(?P<EXTRAVERSION>\d*)' \
+				      + '\-*(?P<RELMOD>\w*)',
+				      value)
+			if (m):
+				rel_match['m'] = m
+				rel_match['rel_name'] = rel_name
+				return rel_match
+		return rel_match
 	def update_latest_tarball_stable(self, value):
 		index_parser = self.index_parser
 		if (self.release not in value):
@@ -283,18 +314,11 @@ class index_tarball_hunter(HTMLParser):
 		if (index_parser.release_extension not in value):
 			return
 
-		m = re.match(r'' + index_parser.rel_html_proj + '-+' \
-			      "v*(?P<VERSION>\d+)\.+" \
-			      "(?P<PATCHLEVEL>\d+)\.*" \
-			      "(?P<SUBLEVEL>\w*)[.-]*" \
-			      "(?P<EXTRAVERSION>\w*)[-]*" \
-			      "(?P<RELMOD_UPDATE>\d*)[-]*" \
-			      "(?P<RELMOD_TYPE>[usnpc]*)", \
-			      value)
-		if (not m):
+		rel_match = self.get_rel_match(value)
+		if (not rel_match['m']):
 			return
 
-		rel_specifics = m.groupdict()
+		rel_specifics = rel_match['m'].groupdict()
 
 		supported = True
 		if (self.is_rel_eol(rel_specifics)):
@@ -303,7 +327,7 @@ class index_tarball_hunter(HTMLParser):
 		p = re.compile(index_parser.release_extension + '$')
 		rel_name = p.sub("", value)
 
-		ver = rel_name.lstrip(index_parser.rel_html_proj + '-')
+		ver = rel_name.lstrip(rel_match['rel_name'] + '-')
 
 		p = re.compile('-[usnpc]*$')
 		short_ver = p.sub("", ver)
@@ -348,18 +372,13 @@ class index_tarball_hunter(HTMLParser):
 		self.tarball_add_stable(tar)
 	def update_latest_tarball_next(self, value):
 		index_parser = self.index_parser
-		m = re.match(r'' + index_parser.rel_html_proj + '+' \
-			      + '\-(?P<DATE_VERSION>' + index_parser.next_rel_date + '+)' \
-			      + '\-*(?P<EXTRAVERSION>\d*)' \
-			      + '\-*(?P<RELMOD>\w*)',
-			      value)
-
-		if (not m):
+		rel_match = self.get_rel_match_next(value)
+		if (not rel_match['m']):
 			return
 
-		rel_specifics = m.groupdict()
+		rel_specifics = rel_match['m'].groupdict()
 
-		rel_name_next = index_parser.rel_html_proj + '-' + rel_specifics['DATE_VERSION']
+		rel_name_next = rel_match['rel_name'] + '-' + rel_specifics['DATE_VERSION']
 		next_version = rel_specifics['DATE_VERSION']
 
 		if (rel_specifics['EXTRAVERSION'] != ''):
@@ -451,10 +470,10 @@ class index_rel_inferrer(HTMLParser):
 		self.close()
 	def handle_decl(self, decl):
 		pass
-	def revise_inference(self, rel, value):
+	def revise_inference(self, rel, value, rel_name):
 		index_parser = self.index_parser
 
-		value = value.lstrip(index_parser.rel_html_proj + "-")
+		value = value.lstrip(rel_name + "-")
 
 		p = re.compile(index_parser.release_extension + '$')
 		value = p.sub("", value)
@@ -500,7 +519,8 @@ class index_rel_inferrer(HTMLParser):
 		if tag != 'a': return
 		for name, value in attributes:
 			if name != 'href': return
-			if (index_parser.rel_html_proj not in value):
+			rel_name = index_parser.search_rel_name(value)
+			if (not rel_name):
 				return
 			if (index_parser.release_extension not in value):
 				return
@@ -509,7 +529,7 @@ class index_rel_inferrer(HTMLParser):
 			for rel in index_parser.inferred_releases:
 				if (rel.get('base') not in value):
 					continue
-				self.revise_inference(rel, value)
+				self.revise_inference(rel, value, rel_name)
 	def handle_endtag(self, tag):
 		pass
 	def handle_data(self, data):
@@ -618,6 +638,13 @@ class index_parser(HTMLParser):
 		self.config.read(config_file)
 
 		self.rel_html_proj = self.config.get("project", "rel_html_proj")
+		if (self.config.has_option("project", "rel_html_proj_aliases")):
+			self.rel_html_proj_aliases = self.config.get("project", "rel_html_proj_aliases").split()
+		else:
+			self.rel_html_proj_aliases = list()
+
+		self.rel_names = self.rel_html_proj_aliases
+		self.rel_names.insert(0, self.rel_html_proj)
 
 		self.inferred_releases = []
 
@@ -692,6 +719,7 @@ class index_parser(HTMLParser):
 		self.changelog = ''
 		self.signed_changelog = False
 
+
 	def get_stable_ext_urls(self, url):
 		url_parser = stable_url_parser(self, url)
 		try:
@@ -701,6 +729,11 @@ class index_parser(HTMLParser):
 			self.stable_urls = url_parser.stable_urls
 		except urllib2.HTTPError, error:
 			return
+	def search_rel_name(self, value):
+		for rel_name in self.rel_names:
+			if (rel_name in value):
+				return rel_name
+		return ""
 	def search_stable_tarballs(self, ver, url):
 		try:
 			tarball_hunter = index_tarball_hunter(self, ver, url)
@@ -1133,6 +1166,7 @@ def try_rels(rels):
 	print_rels_weight(col)
 
 def debug_rel_tests():
+	try_rel_next("20130510-2-u")
 	try_rel_next("2013-01-10-2-u")
 	try_rel_next("20130110-2-u")
 	try_rel_next("2013-03-07-u")
-- 
1.7.10.4

