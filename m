Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A063921DD
	for <backports@vger.kernel.org>; Wed, 24 Jun 2026 07:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782286794; cv=none; b=SbfFtPvUZnzgqfbL2lqwxE22vJP+FC3qIh5NW/eLvxhvARojIjZczntyjrZfaFjeLEwaCVt2rfHuIT1JK4Dyu0xoYHOrsZVw0kjobTovjhIKBnTVxumYGZLGyBzszTeNOvqKmU7J37fDoR4VPDO4KBWI7cP9BF579FZSEGa+CKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782286794; c=relaxed/simple;
	bh=nNwgyq23aFQ7sL0Gn3fnyQ4VKPZ2Djqw4upusHIIyJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pVIhXu7U0plIH2jH9EII3jyMhIxxEV+FT/KeJC735EJ00P9fnzRoU6YQBsct+0viq+/Fg4qTL9wSrriarXCXHsZ/615naL6u1Vd8eD1nlUF/1yJ21kVaZ3Gr2MuYVEKFaRUSXaUV20YKZcPZJX9CVOnJSV3sTqsDe1syrBOgFM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SXFM4B23; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SXFM4B23"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782286791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GzMn+gmBk+o0pC2VkiGnDPa14eFzantijf0LyPPM1ks=;
	b=SXFM4B23iuxfsW/EU58O+dYdhcnfx1hjni1wMMDppeVXtWTmcFp4uXEw3ZyqKqDXArEMJr
	j75AfjimsC0Hd7AQ07g0x2aU0zEfJb36p++JCCU+XnoAEnT1tWDHhNw8LhpZtCzLK4W5ad
	WK841XNcmabYUBBxofqNTZqhXnYpN8Q=
From: Yi Cong <cong.yi@linux.dev>
To: hauke@hauke-m.de,
	backports@vger.kernel.org
Cc: Yi Cong <yicong@kylinos.cn>
Subject: [PATCH 00/20] backports: add missing backport-include header definitions
Date: Wed, 24 Jun 2026 15:38:24 +0800
Message-ID: <20260624073844.2097504-1-cong.yi@linux.dev>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Yi Cong <yicong@kylinos.cn>

This series adds a number of backport-include header definitions that
are currently missing from the backports tree. These are the small
compatibility shims needed so that backported drivers can reference
kernel APIs that were added in newer kernels.

The patches only add new definitions (new headers, or new wrappers
appended to existing ones); none of them modify or remove existing
backport code. Each definition is guarded with the usual
LINUX_VERSION_IS_LESS()/LINUX_VERSION_IN_RANGE() checks so it takes
effect only on kernels where the native definition is absent, and the
wrappers follow the upstream calling convention.

This is the first batch of a larger set of changes; the remaining
patches (which modify existing backport code and patches) will be sent
separately once this batch is reviewed.

Yi Cong (20):
  headers: Add timer_shutdown_sync()
  headers: include linux/module.h from backport.h
  headers: add kstrtox.h backport
  headers: add get_random_u32_inclusive() for kernels < 6.2
  headers: add genl_split_ops compat for kernels < 6.2
  headers: add thermal_zone_device_register_with_trips backport
  headers: add trace_sk_data_ready no-op for kernels < 6.0
  headers: add dropreason-core.h backport for kernels < 5.17
  headers: add dropreason.h backport for kernels < 6.0
  headers: add kfree_skb_reason() backport for kernels < 5.17
  headers: add thermal_zone_device_priv() backport for kernels < 6.4
  headers: add genl_small_ops backport for kernels < 5.10
  headers: add class_create() single-argument backport for kernels < 6.4
  headers: add list_count_nodes() backport for kernels < 6.5
  headers: add net/gso.h backport for kernels < 6.5
  headers: add vcalloc() backport for kernels < 5.18
  headers: add __counted_by macro for kernels < 6.6
  headers: add crypto/utils.h redirect for kernels < 6.6
  headers: add led_trigger_blink/oneshot value-to-pointer backport for
    kernels < 6.5
  headers: add of_property_present backport for kernels < 5.18

 backport/backport-include/backport/backport.h |  1 +
 backport/backport-include/crypto/utils.h      | 16 +++++++
 .../linux/compiler_attributes.h               |  8 ++++
 backport/backport-include/linux/device.h      | 14 ++++++
 backport/backport-include/linux/kstrtox.h     | 17 ++++++++
 backport/backport-include/linux/leds.h        | 39 +++++++++++++++++
 backport/backport-include/linux/list.h        | 25 +++++++++++
 backport/backport-include/linux/of.h          | 14 ++++++
 backport/backport-include/linux/random.h      |  7 +++
 backport/backport-include/linux/skbuff.h      | 17 ++++++++
 backport/backport-include/linux/thermal.h     | 25 +++++++++++
 backport/backport-include/linux/timer.h       | 14 ++++++
 backport/backport-include/linux/vmalloc.h     | 25 +++++++++++
 .../backport-include/net/dropreason-core.h    | 34 +++++++++++++++
 backport/backport-include/net/dropreason.h    | 43 +++++++++++++++++++
 backport/backport-include/net/genetlink.h     | 16 +++++++
 backport/backport-include/net/gso.h           | 16 +++++++
 backport/backport-include/trace/events/sock.h | 16 +++++++
 18 files changed, 347 insertions(+)
 create mode 100644 backport/backport-include/crypto/utils.h
 create mode 100644 backport/backport-include/linux/kstrtox.h
 create mode 100644 backport/backport-include/linux/leds.h
 create mode 100644 backport/backport-include/linux/list.h
 create mode 100644 backport/backport-include/linux/of.h
 create mode 100644 backport/backport-include/linux/vmalloc.h
 create mode 100644 backport/backport-include/net/dropreason-core.h
 create mode 100644 backport/backport-include/net/dropreason.h
 create mode 100644 backport/backport-include/net/gso.h
 create mode 100644 backport/backport-include/trace/events/sock.h

-- 
2.43.0

