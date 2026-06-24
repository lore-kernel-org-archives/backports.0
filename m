Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E3427FD4F
	for <backports@vger.kernel.org>; Wed, 24 Jun 2026 07:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782286831; cv=none; b=lSQXJYZdK4AYCjhy0n2eBZ/ml0eO0cbuxF+C+yTqFa6TaqFxZADAbH/TyxLjAipF6bsvnHHvJd7kUfPbNQo5jGaovJdjrfrOS6+am3nxgicX9kI5U9twC3XlHt1acRxWRbY1EA9l3sqLkYLtnqsCToYNh8PK+wTIc81la0dyEhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782286831; c=relaxed/simple;
	bh=jwsGlGhtBTeK0f01xC0U1C3ff9b/g10W7JvcYYQTMZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G2ikgzPK852tozcVl90YTxrgvA1I+AwcHnDLFA7RTv76Q2T2kzu7oBBWVYwU5JTQRDIJD5QdHTM93SkU6ppsSyVRnTnL9+fxTIdgUT/7XZ141UEctrSiO0L9MppzWSzz+bxFMyeP5cDnjym0OZUIQLmw541urK5kUGFq19f1fPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Nrrr76hA; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Nrrr76hA"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782286828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xRhmoFRqyvHSvuNO8qcZKygv43mK2O82sInxREZ6q/E=;
	b=Nrrr76hAl2h7mMdC2Bxsni1wlOmEbF11RGyJRnMh+snOxrijsZNqvnPLDMLaAWye7+Z1os
	NyWbv2gQEb1BzNaGca58Xnx35UXzw8jdLKc+Qze3HrDkPXeeY/cbbkfZAv66Y27+TLHCcW
	VSuxMUNw+ACPn1+fmANP12G9n9+CODI=
From: Yi Cong <cong.yi@linux.dev>
To: hauke@hauke-m.de,
	backports@vger.kernel.org
Cc: Yi Cong <yicong@kylinos.cn>
Subject: [PATCH 14/20] headers: add list_count_nodes() backport for kernels < 6.5
Date: Wed, 24 Jun 2026 15:38:38 +0800
Message-ID: <20260624073844.2097504-15-cong.yi@linux.dev>
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

list_count_nodes() was introduced in v6.5 to count the number of
nodes in a struct list_head. Provide an inline backport using
list_for_each() for older kernels.

Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 backport/backport-include/linux/list.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 backport/backport-include/linux/list.h

diff --git a/backport/backport-include/linux/list.h b/backport/backport-include/linux/list.h
new file mode 100644
index 00000000..47d8d24f
--- /dev/null
+++ b/backport/backport-include/linux/list.h
@@ -0,0 +1,25 @@
+#ifndef __BACKPORT_LINUX_LIST_H
+#define __BACKPORT_LINUX_LIST_H
+#include_next <linux/list.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_IS_LESS(6,5,0)
+/**
+ * list_count_nodes - count nodes in the list
+ * @head:	the head for your list.
+ *
+ * Introduced in v6.5. Provide a backport for older kernels.
+ */
+static inline size_t list_count_nodes(struct list_head *head)
+{
+	struct list_head *pos;
+	size_t count = 0;
+
+	list_for_each(pos, head)
+		count++;
+
+	return count;
+}
+#endif
+
+#endif /* __BACKPORT_LINUX_LIST_H */
-- 
2.43.0

