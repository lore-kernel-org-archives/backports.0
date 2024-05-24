Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D36D12E1EB
	for <backports@vger.kernel.org>; Fri, 24 May 2024 17:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570569; cv=none; b=R7kwtmlOktp85duMZLJg8E/DzuT5EnTGyQgp0+Pv8ixwsO5YFAZRztgXJCRkL1cY+cKq+oawZ/PU+9xhvJCOc5gqFZ+eOjd8aHpy1ek+iVEN6fgTgFgPM0wTGLtaK1wzdfjzqExb7l2t9hYwgWu6eanrk2SruFtKBap3fEgFTkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570569; c=relaxed/simple;
	bh=g8EwKXqncZhqMZAre5Y8nlj4ctC/jQIfuhVDKNOU0m0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dZMR2iSKIpF+UkNwFAn5TFpqCSy2avqyc4qgJkFFMlLPOxsPdGPl2TWNkdT+WIB5zJP+lVIDU1FL746Jc6bTWchXxmq+DZLajdFCIgkV+G8cVcUjhzFWLsfMTyKa/YsmDr76BRYzJnujLJddMDM+yLjS60O60TQm8zQJ/Y1yXoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=U3G8aV8t; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="U3G8aV8t"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=e6wkcraKwBiHiT4EOjcQx5jwHnW+T1P8Kv1o76GVLaQ=;
	t=1716570568; x=1717780168; b=U3G8aV8tOP6oKdjKJYNNtvzcXv55TRmbu8ZsXYwwmOwgDx5
	jDpNfYE/c3JDNUOVSpQ6is5Jg+JJpWSYvYdLos0wc6iRy+fffzzzCPGsHvs4PCJb3YZuV5KoiTrmT
	xJ1FpPrFQpxEzTPeHEcPp8JmWnLkC97rSvnNBQXB0cMVbQXwfwc4Q7f7BDjnlQLwvEkzx+QhWPe5B
	29Q3hcQKec1T7qJqzQ17vnWtZw/Qh3Osapz2HvUz2aDE8KuSSEnWpsfZoAAxlg2zlSCa5Vmg9Cv9r
	fsoapxKnJH3OkoVqhftOAyNo3pB1MeXtQbKlV32eZs15G7UrIUPFFHb3rVbQrtMA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sAYQ2-00000008Xuw-0Lc6;
	Fri, 24 May 2024 19:09:26 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 18/74] backport: adjust led_trigger_blink*() to v6.5
Date: Fri, 24 May 2024 19:07:30 +0200
Message-ID: <20240524190907.4ae8dcacd09b.I0afa6437fec4e5e9a29e27bf4d88fb47ee6e8964@changeid>
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

From: Gregory Greenman <gregory.greenman@intel.com>

The signature of led_trigger_blink_oneshot() and led_trigger_blink()
was changed in v6.5. Adjust to this change.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/linux/leds.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 backport/backport-include/linux/leds.h

diff --git a/backport/backport-include/linux/leds.h b/backport/backport-include/linux/leds.h
new file mode 100644
index 000000000000..3ebae49d3c8b
--- /dev/null
+++ b/backport/backport-include/linux/leds.h
@@ -0,0 +1,25 @@
+#ifndef __BACKPORT_LINUX_LEDS_H
+#define __BACKPORT_LINUX_LEDS_H
+#include_next <linux/leds.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_IS_LESS(6,5,0)
+static inline void backport_led_trigger_blink_oneshot(struct led_trigger *trigger,
+						      unsigned long delay_on,
+						      unsigned long delay_off,
+						      int invert)
+{
+	led_trigger_blink_oneshot(trigger, &delay_on, &delay_off, invert);
+}
+#define led_trigger_blink_oneshot LINUX_BACKPORT(led_trigger_blink_oneshot)
+
+static inline void backport_led_trigger_blink(struct led_trigger *trigger,
+					      unsigned long delay_on,
+					      unsigned long delay_off)
+{
+	led_trigger_blink(trigger, &delay_on, &delay_off);
+}
+#define led_trigger_blink LINUX_BACKPORT(led_trigger_blink)
+#endif /*  < 6.5 */
+
+#endif /* __BACKPORT_LINUX_LEDS_H */
-- 
2.45.1

