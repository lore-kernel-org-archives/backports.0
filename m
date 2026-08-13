Received: from mta1.migadu.com (out-53.mta1.migadu.com [95.215.58.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D5831E858
	for <backports@vger.kernel.org>; Thu, 13 Aug 2026 09:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786612484; cv=none; b=WIpPY6tz7bmPCPD/BOsfAHD7NVhA63m3ppn3R03N5QFTpj/iUQh1ieEQrYRwM2HVP8P3qIkqIbYcZppM6DFzEIxosa2oTXSKHUlmtmOHt3sNo1iqpIEqc9dF4OpXBogoLVsBumOBGt6p1juiENONjvEYwX3jhA/i+B6CPBg7Zs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786612484; c=relaxed/simple;
	bh=kgVz+81zOPp8XWz2Y0qIwvqhOP7hYGm9N8RJRXNoM4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KwrpsDAPFaWp9dj3O2XhDeY1fMN26E3b54JTWiwzyNuKZcmauGaud49Vfhn8Sftcg1ztzL+N5eyaPfe6yL/2txcHWpj88TKz+3YuaxBGyveNtmHWAuSfG3aOT4NgB4pv9UYeJrsgSCgkzqSApfILnq1D+0QBZuGHUWs+XjdqGGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F/XcsmG3; arc=none smtp.client-ip=95.215.58.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F/XcsmG3"
X-Envelope-To: backports@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=kgVz+81zOPp8XWz2Y0qIwvqhOP7hYGm9N8RJRXNoM4Y=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786612478; v=1; x=1787217278;
 b=F/XcsmG3PDZkEMDdsmscyNETCZ5cmwKFieEL0EuVL78aLsY/fBFiVnxfrztRnUmZHgwyLhpI
 SgMiO4jGNOH8ps3PynxY7DX7iukrSEOccyJvQTJXpsBNOndf3J6bi+IKRLZrq9gtEhPuX+ASFvr
 s/RrTVhRlIBzNPGKu0CuYXpw=
X-Envelope-To: backports@vger.kernel.org
Received: from localhost.localdomain (116.128.244.169)
	by mta11.migadu.com with ESMTPS id 3347b9e45de1c659;
	Thu, 13 Aug 2026 09:14:38 +0000
X-Migadu-Flow: FLOW_OUT
From: Yi Cong <cong.yi@linux.dev>
To: hauke@hauke-m.de
Cc: backports@vger.kernel.org,
	yicong@kylinos.cn
Subject: Re: [PATCH 00/20] backports: add missing backport-include header definitions
Date: Thu, 13 Aug 2026 17:14:29 +0800
Message-Id: <20260813091429.3018284-1-cong.yi@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260624073844.2097504-1-cong.yi@linux.dev>
References: <20260624073844.2097504-1-cong.yi@linux.dev>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 24 Jun 2026 15:38:24 +0800, Yi Cong <cong.yi@linux.dev> wrote:
>
> From: Yi Cong <yicong@kylinos.cn>
>
> This series adds a number of backport-include header definitions that
> are currently missing from the backports tree. These are the small
> compatibility shims needed so that backported drivers can reference
> kernel APIs that were added in newer kernels.
>
> The patches only add new definitions (new headers, or new wrappers
> appended to existing ones); none of them modify or remove existing
> backport code. Each definition is guarded with the usual
> LINUX_VERSION_IS_LESS()/LINUX_VERSION_IN_RANGE() checks so it takes
> effect only on kernels where the native definition is absent, and the
> wrappers follow the upstream calling convention.
>
> This is the first batch of a larger set of changes; the remaining
> patches (which modify existing backport code and patches) will be sent
> separately once this batch is reviewed.
>
> Yi Cong (20):
>   headers: Add timer_shutdown_sync()
>   headers: include linux/module.h from backport.h
>   headers: add kstrtox.h backport
>   headers: add get_random_u32_inclusive() for kernels < 6.2
>   headers: add genl_split_ops compat for kernels < 6.2
>   headers: add thermal_zone_device_register_with_trips backport
>   headers: add trace_sk_data_ready no-op for kernels < 6.0
>   headers: add dropreason-core.h backport for kernels < 5.17
>   headers: add dropreason.h backport for kernels < 6.0
>   headers: add kfree_skb_reason() backport for kernels < 5.17
>   headers: add thermal_zone_device_priv() backport for kernels < 6.4
>   headers: add genl_small_ops backport for kernels < 5.10
>   headers: add class_create() single-argument backport for kernels < 6.4
>   headers: add list_count_nodes() backport for kernels < 6.5
>   headers: add net/gso.h backport for kernels < 6.5
>   headers: add vcalloc() backport for kernels < 5.18
>   headers: add __counted_by macro for kernels < 6.6
>   headers: add crypto/utils.h redirect for kernels < 6.6
>   headers: add led_trigger_blink/oneshot value-to-pointer backport for
>     kernels < 6.5
>   headers: add of_property_present backport for kernels < 5.18
>
>  backport/backport-include/backport/backport.h |  1 +
>  backport/backport-include/crypto/utils.h      | 16 +++++++
>  .../linux/compiler_attributes.h               |  8 ++++
>  backport/backport-include/linux/device.h      | 14 ++++++
>  backport/backport-include/linux/kstrtox.h     | 17 ++++++++
>  backport/backport-include/linux/leds.h        | 39 +++++++++++++++++
>  backport/backport-include/linux/list.h        | 25 +++++++++++
>  backport/backport-include/linux/of.h          | 14 ++++++
>  backport/backport-include/linux/random.h      |  7 +++
>  backport/backport-include/linux/skbuff.h      | 17 ++++++++
>  backport/backport-include/linux/thermal.h     | 25 +++++++++++
>  backport/backport-include/linux/timer.h       | 14 ++++++
>  backport/backport-include/linux/vmalloc.h     | 25 +++++++++++
>  .../backport-include/net/dropreason-core.h    | 34 +++++++++++++++
>  backport/backport-include/net/dropreason.h    | 43 +++++++++++++++++++
>  backport/backport-include/net/genetlink.h     | 16 +++++++
>  backport/backport-include/net/gso.h           | 16 +++++++
>  backport/backport-include/trace/events/sock.h | 16 +++++++
>  18 files changed, 347 insertions(+)
>  create mode 100644 backport/backport-include/crypto/utils.h
>  create mode 100644 backport/backport-include/linux/kstrtox.h
>  create mode 100644 backport/backport-include/linux/leds.h
>  create mode 100644 backport/backport-include/linux/list.h
>  create mode 100644 backport/backport-include/linux/of.h
>  create mode 100644 backport/backport-include/linux/vmalloc.h
>  create mode 100644 backport/backport-include/net/dropreason-core.h
>  create mode 100644 backport/backport-include/net/dropreason.h
>  create mode 100644 backport/backport-include/net/gso.h
>  create mode 100644 backport/backport-include/trace/events/sock.h

Dear Maintainer:

I would like to know if this series of patches I have meet
the requirements and specifications of the project.

If there are any issues with these patches, please let me know.

Thank you very much.

Regards,
    Yi Cong
