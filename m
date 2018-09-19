Return-path: <backports-owner@vger.kernel.org>
Received: from mail-eopbgr720119.outbound.protection.outlook.com ([40.107.72.119]:53040
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728059AbeISQ2l (ORCPT <rfc822;backports@vger.kernel.org>);
        Wed, 19 Sep 2018 12:28:41 -0400
From: Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>
To: "backports@vger.kernel.org" <backports@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
CC: Winnie Chang <Winnie.Chang@cypress.com>,
        Winnie Chang <Winnie.Chang@cypress.com>,
        Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>
Subject: [PATCH v2] backports: add strreplace()
Date: Wed, 19 Sep 2018 10:51:15 +0000
Message-ID: <1537354267-42104-1-git-send-email-chi-hsien.lin@cypress.com> (sfid-20180919_125122_741789_0CE09797)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Winnie Chang <Winnie.Chang@cypress.com>

wireless-drivers-next.git commit cb18e2e9ec71 (brcmfmac: fix wrong
strnchr usage) used strreplace(), which is not available in kernel prior
to v4.2. Before this commit proprgates to linux-stable.git, add
strreplace() to avoid gentree failure.

Signed-off-by: Winnie Chang <winnie.chang@cypress.com>
Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
---
 backport/backport-include/linux/string.h | 4 ++++
 backport/compat/backport-4.2.c           | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/backport/backport-include/linux/string.h b/backport/backport-i=
nclude/linux/string.h
index b85d9c73dc27..4b35eb9f2baf 100644
--- a/backport/backport-include/linux/string.h
+++ b/backport/backport-include/linux/string.h
@@ -29,4 +29,8 @@ void memzero_explicit(void *s, size_t count);
 ssize_t strscpy(char *dest, const char *src, size_t count);
 #endif

+#if LINUX_VERSION_IS_LESS(4,2,0)
+char *strreplace(char *s, char old, char new);
+#endif
+
 #endif /* __BACKPORT_LINUX_STRING_H */
diff --git a/backport/compat/backport-4.2.c b/backport/compat/backport-4.2.=
c
index e00aa49c7e4a..b275d349f7eb 100644
--- a/backport/compat/backport-4.2.c
+++ b/backport/compat/backport-4.2.c
@@ -65,3 +65,12 @@ struct aead_request *crypto_backport_convert(struct aead=
_request *req)
 return &nreq->subreq;
 }
 EXPORT_SYMBOL_GPL(crypto_backport_convert);
+
+char *strreplace(char *s, char old, char new)
+{
+for (; *s; ++s)
+if (*s =3D=3D old)
+*s =3D new;
+return s;
+}
+EXPORT_SYMBOL_GPL(strreplace);
--
2.1.0


This message and any attachments may contain confidential information from =
Cypress or its subsidiaries. If it has been received in error, please advis=
e the sender and immediately delete this message.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
