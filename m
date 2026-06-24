Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5DD2ED870
	for <backports@vger.kernel.org>; Wed, 24 Jun 2026 07:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782286827; cv=none; b=ZqcZNwL+FdLrOqZ8zmCVP+eeXiO71+MIoD9tX7a2Ri9dV0VQDrWS1I8qOHTDz8lTsc4RmMJfWnVfM3mCp1P04rxV448K7ZbSlc1sEi7DVFfDnRsVm8oTRPyhAa4fAfK7rROqSMn3HaEQwu6q6cfclCQuc9XF72BPtNss+tCw8p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782286827; c=relaxed/simple;
	bh=qW+ESAQkqVno+lJ4cQlWS2Ir/XwTD/S5O1rB6zHXbgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lbAaMzJFKGoAvn5gk9gVInf77MM4hulU38NQ0w3Q4dR10TZF92wsKghpovvSezlyQD1J/BMt41dAy0/JkBLgQF+aTvY2bt3A3mx18p68F73AtUfhc9PVWfzmFDMqylWNP9Wi8kVqjt3NwpVvuHa8IzQMplGzlpR5+vkvk41haEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lE/L4tk+; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lE/L4tk+"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782286824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+A4uPEpu7PDlCiDrQaCjMjVd3tY9ge2GAAESk655+Vg=;
	b=lE/L4tk+W27ge4+eFpRSFRvTjvI4Y++bpb+Ioa37tSVOOENPNJfuHGeCbw6YtaJOaeTxLV
	70bCBZzx+TJVgtIBWkGmP3agk+VMQunj2nMuFFMC+QDtrCiwLvfN8jhSvOmmu3pXD2sLlO
	7Ffl7QnZOUhWW1PqYGsk4nEQISHF96k=
From: Yi Cong <cong.yi@linux.dev>
To: hauke@hauke-m.de,
	backports@vger.kernel.org
Cc: Yi Cong <yicong@kylinos.cn>
Subject: [PATCH 12/20] headers: add genl_small_ops backport for kernels < 5.10
Date: Wed, 24 Jun 2026 15:38:36 +0800
Message-ID: <20260624073844.2097504-13-cong.yi@linux.dev>
In-Reply-To: <20260624073844.2097504-1-cong.yi@linux.dev>
References: <20260624073844.2097504-1-cong.yi@linux.dev>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Yi Cong <yicong@kylinos.cn>

genl_small_ops was introduced in v5.10 as a more compact
representation of genl_ops. For older kernels, alias genl_small_ops
to genl_ops and map small_ops/n_small_ops struct fields to ops/n_ops.

Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 backport/backport-include/net/genetlink.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/backport/backport-include/net/genetlink.h b/backport/backport-include/net/genetlink.h
index b98d7110..a57cd200 100644
--- a/backport/backport-include/net/genetlink.h
+++ b/backport/backport-include/net/genetlink.h
@@ -7,6 +7,18 @@
 #define genl_split_ops genl_ops
 #endif
 
+#if LINUX_VERSION_IS_LESS(5,10,0)
+/*
+ * genl_small_ops was introduced in v5.10 to allow a more compact
+ * representation of genl_ops.  For older kernels, just alias it to
+ * genl_ops and map the struct genl_family small_ops/n_small_ops
+ * fields to ops/n_ops.
+ */
+#define genl_small_ops genl_ops
+#define small_ops ops
+#define n_small_ops n_ops
+#endif
+
 /* this is for patches we apply */
 static inline struct netlink_ext_ack *genl_callback_extack(struct netlink_callback *cb)
 {
-- 
2.43.0

