Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:45130 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748Ab3ESCeK (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 18 May 2013 22:34:10 -0400
Received: by mail-pd0-f173.google.com with SMTP id v10so4422539pde.18
        for <backports@vger.kernel.org>; Sat, 18 May 2013 19:34:09 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: mricon@kernel.org, "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 4/8] rel-html: add RFC3339 / short style next release types support
Date: Sat, 18 May 2013 19:33:38 -0700
Message-Id: <1368930822-13641-5-git-send-email-mcgrof@do-not-panic.com> (sfid-20130519_043411_552229_8F403646)
In-Reply-To: <1368930822-13641-1-git-send-email-mcgrof@do-not-panic.com>
References: <1368930822-13641-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

A project might be using RFC3339 (2013-05-02) style release
names for their latest releases and if they switch to the
smaller style (20130502) we need to treat both release
styles as possible. Add support for this.

Your project need not do anything if you switch, the tarball
hunter will everything for for you.

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 rel-html.py |   65 ++++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 23 deletions(-)

diff --git a/rel-html.py b/rel-html.py
index f50fa6f..ef83833 100755
--- a/rel-html.py
+++ b/rel-html.py
@@ -255,9 +255,10 @@ class index_tarball_hunter(HTMLParser):
 		for t_old in self.tarballs:
 			s_old = t_old.get('specifics')
 			idx = self.tarballs.index(t_old)
-			if (index_parser.next_rel_date in t_old.get('rel')):
-				self.tarballs.insert(idx-1, t_new)
-				return
+			for next_date in index_parser.next_rel_dates:
+				if (next_date in t_old.get('rel')):
+					self.tarballs.insert(idx-1, t_new)
+					return
 		self.tarballs.append(t_new)
 	def is_rel_eol(self, rel_specs):
 		index_parser = self.index_parser
@@ -295,19 +296,26 @@ class index_tarball_hunter(HTMLParser):
 		index_parser = self.index_parser
 		rel_match = dict(m = None, rel_name = "")
 		for rel_name in index_parser.rel_names:
-			m = re.match(r'' + rel_name + '+' \
-				      + '\-(?P<DATE_VERSION>' + index_parser.next_rel_date + '+)' \
-				      + '\-*(?P<EXTRAVERSION>\d*)' \
-				      + '\-*(?P<RELMOD>\w*)',
-				      value)
-			if (m):
-				rel_match['m'] = m
-				rel_match['rel_name'] = rel_name
-				return rel_match
+			for next_date in index_parser.next_rel_dates:
+				m = re.match(r'' + rel_name + '+' \
+					      + '\-(?P<DATE_VERSION>' + next_date + '+)' \
+					      + '\-*(?P<EXTRAVERSION>\d*)' \
+					      + '\-*(?P<RELMOD>\w*)',
+					      value)
+				if (m):
+					rel_match['m'] = m
+					rel_match['rel_name'] = rel_name
+					return rel_match
 		return rel_match
+	def get_rel_name(self, value):
+		for rel in self.releases:
+			if (rel in value):
+				return rel
+		return ""
 	def update_latest_tarball_stable(self, value):
 		index_parser = self.index_parser
-		if (self.release not in value):
+		release = self.get_rel_name(value)
+		if (not release):
 			return
 		if ('tar.sign' in value):
 			return
@@ -433,18 +441,24 @@ class index_tarball_hunter(HTMLParser):
 		index_parser = self.index_parser
 		for tar in self.tarballs:
 			index_parser.rel_html_rels.append(tar)
+	def is_next_rel(self, value):
+		index_parser = self.index_parser
+		for next_date in index_parser.next_rel_dates:
+			if (next_date != '' and
+			    next_date in value and
+			    index_parser.release_extension in value):
+				return True
+		return False
 	def handle_starttag(self, tag, attributes):
 		"Process a tags and its 'attributes'."
 		index_parser = self.index_parser
 		if tag != 'a': pass
 		for name, value in attributes:
 			if name != 'href': pass
-			if (self.release not in value):
+			release = self.get_rel_name(value)
+			if (release not in value):
 				pass
-
-			if (index_parser.next_rel_date != '' and
-			    index_parser.next_rel_date in value and
-			    index_parser.release_extension in value):
+			if (self.is_next_rel(value)):
 				self.update_latest_tarball_next(value)
 				pass
 
@@ -455,11 +469,11 @@ class index_tarball_hunter(HTMLParser):
 		pass
 	def handle_comment(self, data):
 		pass
-	def __init__(self, index_parser, release, url):
+	def __init__(self, index_parser, releases, url):
 		HTMLParser.__init__(self)
 		self.index_parser = index_parser
 		self.base_url = url.rstrip("/")
-		self.release = release
+		self.releases = releases
 		self.tarballs = []
 
 class index_rel_inferrer(HTMLParser):
@@ -695,6 +709,8 @@ class index_parser(HTMLParser):
 		self.next_rel_month = 0
 		self.next_rel_url = ''
 		self.next_rel_date = ''
+		self.next_rel_date_rfc3339  = ''
+		self.next_rel_dates = list()
 
 		self.rel_license = self.config.get("project", "rel_license")
 		self.html_title = self.config.get("html", "title")
@@ -736,7 +752,7 @@ class index_parser(HTMLParser):
 		return ""
 	def search_stable_tarballs(self, ver, url):
 		try:
-			tarball_hunter = index_tarball_hunter(self, ver, url)
+			tarball_hunter = index_tarball_hunter(self, [ver], url)
 
 			f = urllib2.urlopen(url)
 			html = f.read()
@@ -775,11 +791,14 @@ class index_parser(HTMLParser):
 		self.next_rel_day   = self.__get_next_rel_page(url + self.next_rel_month)
 		self.next_rel_url   = url + self.next_rel_month + '/' + self.next_rel_day
 		# XXX: automatically look for the largest year
-		self.next_rel_date  = '2013' + '-' + self.next_rel_month + '-' + self.next_rel_day
+		self.next_rel_date_rfc3339  = '2013' + '-' + self.next_rel_month + '-' + self.next_rel_day
+		self.next_rel_date = self.next_rel_date_rfc3339.replace("-", "")
+		self.next_rel_dates.append(self.next_rel_date_rfc3339)
+		self.next_rel_dates.append(self.next_rel_date)
 	def evaluate_next_url(self):
 		try:
 			tarball_hunter = index_tarball_hunter(self,
-							      self.next_rel_date,
+							      self.next_rel_dates,
 							      self.next_rel_url)
 
 			f = urllib2.urlopen(self.next_rel_url)
-- 
1.7.10.4

