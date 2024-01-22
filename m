Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F64347F7D
	for <backports@vger.kernel.org>; Mon, 22 Jan 2024 21:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705959423; cv=none; b=oxOuTfPjP9DVms9LPZUVyYKDq4A8SpSi7Gr3Jnx9Z1YCMo2/NvPT8dikBYVrwMiMXII4RwhikTtX+3dj7abfgdrMnT3lpSm0cezaiJoxIJDHba5XBBAvcmbTEakVf5ZTD096HkVVB6WweAVSuzQUDqKzZZLJ0MhWo6iWZYEE5qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705959423; c=relaxed/simple;
	bh=tqnga7wpCtwqbIfV9EzPlnqTZXtyUY0LIycFsnSidIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHkMG9FJjWLfgMThSZwwx9LRwQMqL938jmDh+qYyDV8vPDepG6cg3vl5oGOzwYRqH2M001nNJqxKi+yp00uxbg/Grq/UXsUW9qpzQ7/PD1kn4lz/JUnjGClMnMbt91uQJryXliwPonnn4QFL29uyoGbo0ENc3xvmn/mLdcsVQQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=1C0LU5FP; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="1C0LU5FP"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TJk7s5871z9sZP;
	Mon, 22 Jan 2024 22:36:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1705959417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mteaq65zRRlfX4lC9pueRLc1p66gKJ0AUbTEuWO/aMw=;
	b=1C0LU5FPOJ6xAGzGy8r6Y2SaXdj35BgpgJkPCteR5Z88ZJV+Lnxv443HfA4vfuJAE6y7fJ
	6bMUoe25nWNAlryDZ0O7qgwh3Ppv0GaEwRX8qV7aMHFs8fwPR1EX0ULwKeyfnwqC83eHSa
	C1QpVPpy3ltCQOzcPI9yFl4KOxS3XN9Klwrknr0E14NdWlaMq1Pfw9PfSRi/tHtIqH2Hkf
	gistKe1KWzvpcRs7yc/P1oQ6xBZa5cvyFmjMFSVIYTufP5Lu1A1dqyYTmM4gnkk5U9hLsS
	hjV7EpooZpweDvCYzGj+1rdWVciFsiF5bP7Yy182zdDgWm61JvBjteejReiPpg==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/2] github: Add github action to test build
Date: Mon, 22 Jan 2024 22:36:49 +0100
Message-ID: <20240122213649.149703-2-hauke@hauke-m.de>
In-Reply-To: <20240122213649.149703-1-hauke@hauke-m.de>
References: <20240122213649.149703-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4TJk7s5871z9sZP

Use github actions to build test changes in backports.

This creates a docker container with the test kernel files to
test compile against. This should get stored persistently.

In addition the patch adds a github action which creates a new
backports tar file and uses this new container to build test the newly
created backports tar.

This allows to build test a backports release using github actions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 .github/workflows/build_publish_container.yml |  46 +++++++
 .../build_publish_container/Dockerfile        |  16 +++
 .github/workflows/create.yml                  | 115 ++++++++++++++++++
 3 files changed, 177 insertions(+)
 create mode 100644 .github/workflows/build_publish_container.yml
 create mode 100644 .github/workflows/build_publish_container/Dockerfile
 create mode 100644 .github/workflows/create.yml

diff --git a/.github/workflows/build_publish_container.yml b/.github/workflows/build_publish_container.yml
new file mode 100644
index 00000000..d4fabbd5
--- /dev/null
+++ b/.github/workflows/build_publish_container.yml
@@ -0,0 +1,46 @@
+name: Build and publish container
+
+on:
+  workflow_dispatch:
+  push:
+    tags:
+      - 'v*'
+
+env:
+  REGISTRY: ghcr.io
+  IMAGE_NAME: ${{ github.repository }}
+
+jobs:
+  push_to_registry:
+    name: push to registry
+    runs-on: ubuntu-latest
+
+    permissions:
+      contents: read
+      packages: write
+
+    steps:
+      - name: Check out the repo
+        uses: actions/checkout@v4
+      
+      - name: Log in to Docker Hub
+        uses: docker/login-action@343f7c4344506bcbf9b4de18042ae17996df046d
+        with:
+          registry: ${{ env.REGISTRY }}
+          username: ${{ github.actor }}
+          password: ${{ secrets.GITHUB_TOKEN }}
+      
+      - name: Extract metadata (tags, labels) for Docker
+        id: meta
+        uses: docker/metadata-action@dbef88086f6cef02e264edb7dbf63250c17cef6c
+        with:
+          images: ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}
+      
+      - name: Build and push Docker image
+        uses: docker/build-push-action@4a13e500e55cf31b7a5d59a38ab2040ab0f42f56
+        with:
+          context: .
+          file: .github/workflows/build_publish_container/Dockerfile
+          push: true
+          tags: ${{ steps.meta.outputs.tags }}
+          labels: ${{ steps.meta.outputs.labels }}
diff --git a/.github/workflows/build_publish_container/Dockerfile b/.github/workflows/build_publish_container/Dockerfile
new file mode 100644
index 00000000..1dcdb06f
--- /dev/null
+++ b/.github/workflows/build_publish_container/Dockerfile
@@ -0,0 +1,16 @@
+FROM ubuntu:22.04
+
+RUN apt update && \
+	apt install -y git coccinelle build-essential python3 python3-pip python-is-python3 flex bison libelf1 && \
+	rm -rf /var/lib/apt/lists/*
+
+RUN pip install pyzstd
+
+RUN git clone https://github.com/hauke/backports.git --branch github-action
+
+RUN /backports/devel/backports-update-manager --yes --no-git-update && \
+	rm -rf /ksrc-backports/debs/
+
+RUN rm -rf /backports
+
+WORKDIR /
diff --git a/.github/workflows/create.yml b/.github/workflows/create.yml
new file mode 100644
index 00000000..6ed0a270
--- /dev/null
+++ b/.github/workflows/create.yml
@@ -0,0 +1,115 @@
+name: 'Create backports tar'
+
+on:
+  push:
+
+jobs:
+  create_tar:
+    name: Create backports tar
+    runs-on: ubuntu-latest
+
+    steps:
+      - name: Install coccinelle
+        run: |
+          sudo apt update
+          sudo apt install -y coccinelle
+
+      - name: Checkout backports
+        uses: actions/checkout@v4
+        with:
+          path: backports
+
+      - name: Checkout kernel
+        uses: actions/checkout@v4
+        with:
+          repository: gregkh/linux
+          ref: refs/heads/linux-5.15.y
+          path: linux
+
+      - name: Generate backports tar
+        working-directory: backports
+        run: ./gentree.py --refresh  ${GITHUB_WORKSPACE}/linux ${GITHUB_WORKSPACE}/backports-generated
+
+      - name: Check for git changes
+        working-directory: backports
+        run: git diff
+
+      - name: Pack backports-generated.tar.gz
+        run: tar cfz backports-generated.tar.gz backports-generated
+
+      - name: Upload backports-generated.tar.gz
+        uses: actions/upload-artifact@v3
+        with:
+          name: backports-generated.tar.gz
+          path: backports-generated.tar.gz
+
+
+  check_build:
+    name: Test backports tar
+    runs-on: ubuntu-latest
+    container:
+      image: ghcr.io/hauke/backports
+
+    needs: create_tar
+    continue-on-error: true
+    strategy:
+      matrix:
+        kernel: [
+           "4.4",
+           "4.5",
+           "4.6",
+           "4.7",
+           "4.8",
+           "4.9",
+           "4.10",
+           "4.11",
+           "4.12",
+           "4.13",
+           "4.14",
+           "4.15",
+           "4.16",
+           "4.17",
+           "4.18",
+           "4.19",
+           "5.0",
+           "5.1",
+           "5.2",
+           "5.3",
+           "5.4",
+           "5.5",
+           "5.6",
+           "5.7",
+           "5.8",
+           "5.9",
+           "5.10",
+           "5.11",
+           "5.12",
+           "5.13",
+           "5.14",
+           "5.15"]
+        config: [
+           allyesconfig,
+           defconfig-wifi]
+
+    steps:
+      - name: Checkout backports
+        uses: actions/checkout@v4
+        with:
+          path: backports
+
+      - name: Download backports-generated.tar.gz
+        uses: actions/download-artifact@v3
+        with:
+          name: backports-generated.tar.gz
+
+      - name: Unpack backports-generated.tar.gz
+        run: tar xf backports-generated.tar.gz
+
+      - name: Create build configuration
+        working-directory: backports-generated
+        run: make -j$(nproc) KLIB=/ksrc-backports/lib/modules/${{ matrix.kernel }}.*/build/ KLIB_BUILD=/ksrc-backports/lib/modules/${{ matrix.kernel }}.*/build/ ${{ matrix.config }}
+
+      - name: Build
+        working-directory: backports-generated
+        run: make -j$(nproc) KLIB=/ksrc-backports/lib/modules/${{ matrix.kernel }}.*/build/ KLIB_BUILD=/ksrc-backports/lib/modules/${{ matrix.kernel }}.*/build/
+
-- 
2.43.0

