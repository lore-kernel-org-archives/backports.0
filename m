Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E8C55C1A
	for <backports@vger.kernel.org>; Mon,  1 Apr 2024 21:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712008576; cv=none; b=cGPwhgtCntaIXQ9xgEMU0gqabNbGxK7vB71px1Mp4MW5a+GF1EmeMvwTBsoYKaPrAJLgkH3MdJ2hzD+LqfmKPMLkrWUbHKPJ56SSnWTxUcF0WiqugJb2kwud/rcJQnuaCwCXSPwbczKMwpjwtEMW7a24PtOQVKBBWrP7fZwrkvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712008576; c=relaxed/simple;
	bh=HTzyymMUYHxGBHd6EfHE/0sPHlAFSVkXMoJIjyHrxck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uqULIFVE9QKBNVv9fYcMIW3StL93+ql5bt7ROBctIqZnXH1bskCS6xqSvMd1yy1JzAs+vw+MEDneaqplzSVr1d0NGwkE2Q/0GbKEGajlOIUMiWQFxDFu/IfiGgnzbCKvYfBIe9acysJfq5R0FyEbYgutF5GHBKv9NeeMtGbtV4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=WjMKUfMA; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="WjMKUfMA"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4V7lFc6Fvkz9sn2;
	Mon,  1 Apr 2024 23:56:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1712008564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=04v0k4JexZp8X6C3XWFjGHG6FsEeqgOR9itfwkKRjSU=;
	b=WjMKUfMA8oQQSZVDeHEh6XM7SgvpfMg416oGKVVZAfsdBrxEveM9M4OpKCIUBGCvJ/sAto
	XotxmgXAIk+W7auvUBSG81Hrdo5pEVDeMIrxArnDnhpw44vZDBuc+//JwZQzVUOqyvkXd2
	ULPo8qjyEpAIp8l/aYIfAzaQU3SqWd2CPWhKo63+vPTxv4NbNTLTJ8iR7jXQWfTXDxbRCm
	frQAoIaij7Rj4D4bEI/0fdrIuVodwq1E3G635G/i5o17NMYZwuW/4ZljNzojL9mbeG+BcA
	904H2e9OblbH6BiauvYtJBWzP854j5e5xpeFdLZBtTZoOQsnQwP8mTEPD0VyHw==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/4] backports-update-manager: Use zstandard from pip
Date: Mon,  1 Apr 2024 23:55:34 +0200
Message-ID: <20240401215535.2432969-3-hauke@hauke-m.de>
In-Reply-To: <20240401215535.2432969-1-hauke@hauke-m.de>
References: <20240401215535.2432969-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the zstandard package from python pip instead of pystd. zstandard is
more common and also integrated in later Ubuntu versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .devcontainer/Dockerfile       |  2 +-
 devel/backports-update-manager | 15 ++++++++-------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/.devcontainer/Dockerfile b/.devcontainer/Dockerfile
index 3894196e..f758c9cb 100644
--- a/.devcontainer/Dockerfile
+++ b/.devcontainer/Dockerfile
@@ -4,7 +4,7 @@ RUN apt update && \
 	apt install -y git coccinelle build-essential python3 python3-pip python-is-python3 flex bison libelf1 libelf-dev && \
 	rm -rf /var/lib/apt/lists/*
 
-RUN pip install pyzstd
+RUN pip install pyzstd zstandard
 
 RUN git clone https://github.com/hauke/backports.git
 
diff --git a/devel/backports-update-manager b/devel/backports-update-manager
index c2900b64..79f0ae23 100755
--- a/devel/backports-update-manager
+++ b/devel/backports-update-manager
@@ -1,11 +1,11 @@
 #!/usr/bin/env python3
 import argparse, os, sys, errno, getopt, re
 import shutil
+import zstandard
 from urllib.request import urlopen
 from urllib.parse import urljoin
 import tarfile, tempfile
 import fileinput, subprocess
-from pyzstd import ZstdFile
 source_dir = os.path.abspath(os.path.dirname(__file__))
 sys.path.append(source_dir + '/../')
 from lib import bpar as ar
@@ -543,13 +543,14 @@ class backport_kernel_updater:
                 data, dpath = tempfile.mkstemp(prefix=tmp_prefix)
                 ar.print_data(target, data)
                 try:
-                   tar = tarfile.open(name=dpath, mode='r')
-                   tar.extractall(path=tmpdir_path, members=bk_tar_members(tar))
+                   with tarfile.open(name=dpath, mode='r') as tar:
+                      tar.extractall(path=tmpdir_path, members=bk_tar_members(tar))
                 except (tarfile.ReadError):
-                   zstd_file = ZstdFile(dpath)
-                   tar = tarfile.open(fileobj=zstd_file, mode='r')
-                   tar.extractall(path=tmpdir_path, members=bk_tar_members(tar))
-                   zstd_file.close()
+                   with open(dpath, 'rb') as file:
+                      unzstd = zstandard.ZstdDecompressor()
+                      with unzstd.stream_reader(file) as stream:
+                         with tarfile.open(fileobj=stream, mode='r|') as tar:
+                            tar.extractall(path=tmpdir_path, members=bk_tar_members(tar))
                 os.unlink(dpath)
 
                 self.sanitize_and_install_kernel_dirs(tmpdir_path)
-- 
2.44.0

