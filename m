Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783E6376EB
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570606; cv=none; b=kWVh6LctDDi1JTr4Gd2gDHUvfNwFci8ounzsAz2DCF42WAymXRMedcTj1TjJfw3ZuyBSeyr+IBy9oOT6wceRLdX8n46p++BQQNPG9kcJoX0Au3+sZDnp8yn9L+mDtEZhjVXLHuiupR7Kt+BcklFEH1vALVZ04tEhIDqSB7OciMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570606; c=relaxed/simple;
	bh=e6c0JiVGjsMA3KCSwMuC6F39GvQI4cIiA6DFZ7ZY9y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TfYewd80QWp1ZUeXuE5+LBBdoFtDpf75tKYQE/T2T3qMl0Q4rQJSSsoalbpIJlDSmaqPOqL3zi/pj19CG8+Vhm5B9ftx2+ilOi71iCQxaXkaqsfxHMW0q55o6Q1LfANyrZbUYZUHbEZ9tYgnfH5fm2UVoa9hReOEjhjxt1xIV8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=wGoukIbn; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="wGoukIbn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=19XpGuhuhY1sB91YsRknKR6ggp9MphhDINmpz9DkYdg=;
	t=1716570605; x=1717780205; b=wGoukIbnPjU/PbrKql+jCsdSkLFafOH3wtnnF3aAcCowYl6
	qbSnfXJbNPYq0Pu8NuGUFpgWHMy8vTPmahdMF5UN+HKOYE/LbjHvogenXd13eF9A6kiRwGhWeaEDL
	buBnXRQO39xOmwQbtEKHnhauucH7Tler6KrNwZDIruKcch6pdsWtnE3IeTmm2S/abcnZjNaBrcq5j
	RYEHpGXJdlzSE3tXT5vTbAjOy1t9N9bDpttVCac7J8+mgBEcuMF8DjHmJxsuJMsiChIIZeSyJIl7N
	BhT34BpsQ3OlRhUWfqyMAtv3rZt9Ayt/7lKKDyFaI+wdpwF/lWzhwoVYGopHol5w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQd-00000008Xuw-0rEB;
	Fri, 24 May 2024 19:10:03 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 50/74] headers: add __vstring and __assign_vstr
Date: Fri, 24 May 2024 19:08:02 +0200
Message-ID: <20240524190907.67ec030e44de.I027a0b45d32f671a7eaa83ff3b6213978df4a4b1@changeid>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524170906.54680-76-johannes@sipsolutions.net>
References: <20240524170906.54680-76-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Felix Fietkau <nbd@nbd.name>

Used within tracepoints on a few drivers

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/trace/trace_events.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 backport/backport-include/trace/trace_events.h

diff --git a/backport/backport-include/trace/trace_events.h b/backport/backport-include/trace/trace_events.h
new file mode 100644
index 000000000000..fd6a4f3c343d
--- /dev/null
+++ b/backport/backport-include/trace/trace_events.h
@@ -0,0 +1,16 @@
+#include <linux/version.h>
+
+#if LINUX_VERSION_IS_LESS(6,0,0)
+#undef VSTRING_MSG_MAX
+#define VSTRING_MSG_MAX	512
+
+#undef __vstring
+#define __vstring(msg, fmt, va) __dynamic_array(char, msg, VSTRING_MSG_MAX)
+
+#undef __assign_vstr
+#define __assign_vstr(msg, fmt, va)					  \
+	WARN_ON_ONCE(vsnprintf(__get_dynamic_array(msg), VSTRING_MSG_MAX, \
+			       fmt, *va) >= VSTRING_MSG_MAX)
+#endif /* <6.0 */
+
+#include_next <trace/trace_events.h>
-- 
2.45.1

