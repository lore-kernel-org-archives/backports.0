Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:49168 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757701AbdJMJmf (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 13 Oct 2017 05:42:35 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 06/11] backports: add signature verification code
Date: Fri, 13 Oct 2017 11:42:21 +0200
Message-Id: <20171013094226.10021-6-johannes@sipsolutions.net> (sfid-20171013_114239_643143_3C553B34)
In-Reply-To: <20171013094226.10021-1-johannes@sipsolutions.net>
References: <20171013094226.10021-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Uh, this was awful. Because the crypto/ things are completely
impossible to backport, I've actually implemented this by using
mbedtls and embedding the relevant functions it has...

The mbedtls code is taken from mbedtls version 2.6.0 and only
minimally modified (mostly to remove <string.h> and similar).

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/keys/asymmetric-type.h   |   33 +
 backport/backport-include/keys/system_keyring.h    |   10 +
 backport/backport-include/linux/key.h              |   66 +
 backport/backport-include/linux/verification.h     |   28 +
 backport/compat/.gitignore                         |    1 +
 backport/compat/Kconfig                            |   26 +
 backport/compat/Makefile                           |   29 +
 backport/compat/verification/asn1parse.c           |  393 ++++
 backport/compat/verification/bignum.c              | 2447 ++++++++++++++++++++
 backport/compat/verification/key.c                 |  171 ++
 backport/compat/verification/mbedtls/asn1.h        |  344 +++
 backport/compat/verification/mbedtls/bignum.h      |  760 ++++++
 backport/compat/verification/mbedtls/bn_mul.h      |  887 +++++++
 backport/compat/verification/mbedtls/config.h      |   15 +
 backport/compat/verification/mbedtls/md.h          |  356 +++
 backport/compat/verification/mbedtls/md_internal.h |  116 +
 backport/compat/verification/mbedtls/oid.h         |  572 +++++
 backport/compat/verification/mbedtls/pk.h          |  618 +++++
 backport/compat/verification/mbedtls/platform.h    |   12 +
 backport/compat/verification/mbedtls/rsa.h         |  672 ++++++
 backport/compat/verification/mbedtls/sha1.h        |  135 ++
 backport/compat/verification/mbedtls/sha256.h      |  140 ++
 backport/compat/verification/md.c                  |  471 ++++
 backport/compat/verification/md_wrap.c             |  577 +++++
 backport/compat/verification/oid.c                 |  709 ++++++
 backport/compat/verification/pkcs7-asn1.c          |  355 +++
 backport/compat/verification/pkcs7-asn1.h          |   27 +
 backport/compat/verification/public_key.c          |  131 ++
 backport/compat/verification/rsa.c                 | 1872 +++++++++++++++
 backport/compat/verification/rsapubkey-asn1.c      |   38 +
 backport/compat/verification/rsapubkey-asn1.h      |   15 +
 backport/compat/verification/sha256.c              |  458 ++++
 backport/compat/verification/verify.c              |   65 +
 backport/compat/verification/x509-asn1.c           |  182 ++
 backport/compat/verification/x509-asn1.h           |   22 +
 backport/compat/verification/x509_akid-asn1.c      |  144 ++
 backport/compat/verification/x509_akid-asn1.h      |   15 +
 copy-list                                          |   13 +
 patches/verify.patch                               |   86 +
 39 files changed, 13011 insertions(+)
 create mode 100644 backport/backport-include/keys/asymmetric-type.h
 create mode 100644 backport/backport-include/keys/system_keyring.h
 create mode 100644 backport/backport-include/linux/key.h
 create mode 100644 backport/backport-include/linux/verification.h
 create mode 100644 backport/compat/.gitignore
 create mode 100644 backport/compat/verification/asn1parse.c
 create mode 100644 backport/compat/verification/bignum.c
 create mode 100644 backport/compat/verification/key.c
 create mode 100644 backport/compat/verification/mbedtls/asn1.h
 create mode 100644 backport/compat/verification/mbedtls/bignum.h
 create mode 100644 backport/compat/verification/mbedtls/bn_mul.h
 create mode 100644 backport/compat/verification/mbedtls/config.h
 create mode 100644 backport/compat/verification/mbedtls/md.h
 create mode 100644 backport/compat/verification/mbedtls/md_internal.h
 create mode 100644 backport/compat/verification/mbedtls/oid.h
 create mode 100644 backport/compat/verification/mbedtls/pk.h
 create mode 100644 backport/compat/verification/mbedtls/platform.h
 create mode 100644 backport/compat/verification/mbedtls/rsa.h
 create mode 100644 backport/compat/verification/mbedtls/sha1.h
 create mode 100644 backport/compat/verification/mbedtls/sha256.h
 create mode 100644 backport/compat/verification/md.c
 create mode 100644 backport/compat/verification/md_wrap.c
 create mode 100644 backport/compat/verification/oid.c
 create mode 100644 backport/compat/verification/pkcs7-asn1.c
 create mode 100644 backport/compat/verification/pkcs7-asn1.h
 create mode 100644 backport/compat/verification/public_key.c
 create mode 100644 backport/compat/verification/rsa.c
 create mode 100644 backport/compat/verification/rsapubkey-asn1.c
 create mode 100644 backport/compat/verification/rsapubkey-asn1.h
 create mode 100644 backport/compat/verification/sha256.c
 create mode 100644 backport/compat/verification/verify.c
 create mode 100644 backport/compat/verification/x509-asn1.c
 create mode 100644 backport/compat/verification/x509-asn1.h
 create mode 100644 backport/compat/verification/x509_akid-asn1.c
 create mode 100644 backport/compat/verification/x509_akid-asn1.h
 create mode 100644 patches/verify.patch

diff --git a/backport/backport-include/keys/asymmetric-type.h b/backport/backport-include/keys/asymmetric-type.h
new file mode 100644
index 000000000000..ee9c418618ac
--- /dev/null
+++ b/backport/backport-include/keys/asymmetric-type.h
@@ -0,0 +1,33 @@
+#ifndef __BP_ASYMMETRIC_TYPE_H
+#define __BP_ASYMMETRIC_TYPE_H
+#ifdef CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION
+
+struct asymmetric_key_id {
+	unsigned short	len;
+	unsigned char	data[];
+};
+
+struct asymmetric_key_ids {
+	struct asymmetric_key_id *id[2];
+};
+
+static inline bool asymmetric_key_id_same(const struct asymmetric_key_id *kid1,
+					  const struct asymmetric_key_id *kid2)
+{
+	if (!kid1 || !kid2)
+		return false;
+	if (kid1->len != kid2->len)
+		return false;
+	return memcmp(kid1->data, kid2->data, kid1->len) == 0;
+}
+
+extern struct asymmetric_key_id *
+asymmetric_key_generate_id(const void *val_1, size_t len_1,
+			   const void *val_2, size_t len_2);
+
+extern struct key *find_asymmetric_key(struct key *keyring,
+				       const struct asymmetric_key_id *id_0,
+				       const struct asymmetric_key_id *id_1,
+				       bool partial);
+#endif
+#endif /* __BP_ASYMMETRIC_TYPE_H */
diff --git a/backport/backport-include/keys/system_keyring.h b/backport/backport-include/keys/system_keyring.h
new file mode 100644
index 000000000000..00d2bfffa835
--- /dev/null
+++ b/backport/backport-include/keys/system_keyring.h
@@ -0,0 +1,10 @@
+#ifndef __BP_SYSTEM_KEYRING_H
+#define __BP_SYSTEM_KEYRING_H
+#ifndef CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION
+#include_next <keys/system_keyring.h>
+#else
+#include <linux/key.h>
+
+#define is_hash_blacklisted(...)	0
+#endif /* CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION */
+#endif /* __BP_SYSTEM_KEYRING_H */
diff --git a/backport/backport-include/linux/key.h b/backport/backport-include/linux/key.h
new file mode 100644
index 000000000000..e7abbf4789ca
--- /dev/null
+++ b/backport/backport-include/linux/key.h
@@ -0,0 +1,66 @@
+#ifndef __BP_KEY_H
+#define __BP_KEY_H
+#ifndef CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION
+#include_next <linux/key.h>
+#else
+#include <linux/types.h>
+#include <linux/refcount.h>
+#include <linux/list.h>
+#include <keys/asymmetric-type.h>
+
+typedef uint32_t key_perm_t;
+
+struct key {
+	refcount_t refcount;
+	const char *description;
+	s32 serial;
+	struct list_head list;
+
+	struct asymmetric_key_ids kids;
+	struct public_key *public_key;
+	struct public_key_signature *sig;
+
+	bool keyring;
+};
+
+typedef struct __key_reference_with_attributes *key_ref_t;
+
+static inline key_ref_t make_key_ref(const struct key *key,
+				     bool possession)
+{
+	return (key_ref_t) ((unsigned long) key | possession);
+}
+
+static inline struct key *key_ref_to_ptr(const key_ref_t key_ref)
+{
+	return (struct key *) ((unsigned long) key_ref & ~1UL);
+}
+
+#define key_put LINUX_BACKPORT(key_put)
+extern void key_put(struct key *key);
+
+static inline void key_ref_put(key_ref_t key_ref)
+{
+	key_put(key_ref_to_ptr(key_ref));
+}
+
+#define key_create_or_update(keyring, type, desc, payload, plen, perm, flags) \
+	bp_key_create_or_update(keyring, desc, payload, plen)
+
+extern key_ref_t bp_key_create_or_update(key_ref_t keyring,
+					 const char *description,
+					 const void *payload,
+					 size_t plen);
+
+#define keyring_alloc(desc, uid, gid, cred, perm, flags, restrict, dest) \
+	bp_keyring_alloc();
+
+extern struct key *bp_keyring_alloc(void);
+
+static inline s32 key_serial(const struct key *key)
+{
+	return key ? key->serial : 0;
+}
+
+#endif /* CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION */
+#endif /* __BP_KEY_H */
diff --git a/backport/backport-include/linux/verification.h b/backport/backport-include/linux/verification.h
new file mode 100644
index 000000000000..10e1bcfb2c00
--- /dev/null
+++ b/backport/backport-include/linux/verification.h
@@ -0,0 +1,28 @@
+#ifndef __BP_VERIFICATION_H
+#define __BP_VERIFICATION_H
+#include <linux/version.h>
+#ifndef CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION
+#include_next <linux/verification.h>
+#else
+#include <linux/key.h>
+
+enum key_being_used_for {
+	VERIFYING_MODULE_SIGNATURE,
+	VERIFYING_FIRMWARE_SIGNATURE,
+	VERIFYING_KEXEC_PE_SIGNATURE,
+	VERIFYING_KEY_SIGNATURE,
+	VERIFYING_KEY_SELF_SIGNATURE,
+	VERIFYING_UNSPECIFIED_SIGNATURE,
+	NR__KEY_BEING_USED_FOR
+};
+
+extern int verify_pkcs7_signature(const void *data, size_t len,
+				  const void *raw_pkcs7, size_t pkcs7_len,
+				  struct key *trusted_keys,
+				  enum key_being_used_for usage,
+				  int (*view_content)(void *ctx,
+						      const void *data, size_t len,
+						      size_t asn1hdrlen),
+				  void *ctx);
+#endif /* LINUX_VERSION_IS_GEQ(4,7,0) */
+#endif /* __BP_VERIFICATION_H */
diff --git a/backport/compat/.gitignore b/backport/compat/.gitignore
new file mode 100644
index 000000000000..72ff0e993b1d
--- /dev/null
+++ b/backport/compat/.gitignore
@@ -0,0 +1 @@
+oid_registry_data.c
diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index b16667109489..542cf0cca781 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -174,3 +174,29 @@ config BPAUTO_REFCOUNT
 	depends on KERNEL_4_11
 	#h-file linux/refcount.h
 	#c-file lib/refcount.c
+
+config BPAUTO_SYSTEM_DATA_VERIFICATION
+	bool
+
+config BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION
+	bool
+	default y if BPAUTO_SYSTEM_DATA_VERIFICATION
+	depends on KERNEL_4_7 || !SYSTEM_DATA_VERIFICATION
+	select BPAUTO_ASN1_DECODER
+	select BPAUTO_PUBLIC_KEY
+	select BPAUTO_PKCS7
+	#h-file linux/oid_registry.h
+	#c-file lib/oid_registry.c
+
+config BPAUTO_PUBLIC_KEY
+	bool
+	#h-file crypto/public_key.h
+
+config BPAUTO_ASN1_DECODER
+	bool
+	#h-file linux/asn1_decoder.h
+	#c-file lib/asn1_decoder.c
+
+config BPAUTO_PKCS7
+	bool
+	#h-file crypto/pkcs7.h
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 1658f588c68f..ead22a0099fc 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -39,3 +39,32 @@ compat-$(CPTCFG_KERNEL_4_10) += backport-4.10.o
 
 compat-$(CPTCFG_BPAUTO_BUILD_CRYPTO_CCM) += crypto-ccm.o
 compat-$(CPTCFG_BPAUTO_CRYPTO_SKCIPHER) += crypto-skcipher.o
+
+compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/verify.o
+compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/pkcs7-asn1.o
+compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/pkcs7_verify.o
+compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/pkcs7_parser.o
+compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/x509-asn1.o
+compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/x509_akid-asn1.o
+compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/x509_cert_parser.o
+compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/x509_public_key.o
+compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/pkcs7_trust.o
+compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/key.o
+compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/public_key.o
+compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/rsa.o
+compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/bignum.o
+compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/md.o
+compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/md_wrap.o
+compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/sha256.o
+compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/oid.o
+compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/asn1parse.o
+compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/rsapubkey-asn1.o
+
+$(obj)/lib-oid_registry.o: $(obj)/oid_registry_data.c
+
+$(obj)/oid_registry_data.c: $(src)/../include/linux/backport-oid_registry.h \
+			    $(src)/build_OID_registry
+	$(call cmd,build_OID_registry)
+
+quiet_cmd_build_OID_registry = GEN     $@
+	cmd_build_OID_registry = perl $(src)/build_OID_registry $< $@
diff --git a/backport/compat/verification/asn1parse.c b/backport/compat/verification/asn1parse.c
new file mode 100644
index 000000000000..e81713c7433f
--- /dev/null
+++ b/backport/compat/verification/asn1parse.c
@@ -0,0 +1,393 @@
+/*
+ *  Generic ASN.1 parsing
+ *
+ *  Copyright (C) 2006-2015, ARM Limited, All Rights Reserved
+ *  SPDX-License-Identifier: GPL-2.0
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ *  This file is part of mbed TLS (https://tls.mbed.org)
+ */
+
+#if !defined(MBEDTLS_CONFIG_FILE)
+#include "mbedtls/config.h"
+#else
+#include MBEDTLS_CONFIG_FILE
+#endif
+
+#if defined(MBEDTLS_ASN1_PARSE_C)
+
+#include "mbedtls/asn1.h"
+
+#if defined(MBEDTLS_BIGNUM_C)
+#include "mbedtls/bignum.h"
+#endif
+
+#if defined(MBEDTLS_PLATFORM_C)
+#include "mbedtls/platform.h"
+#else
+#include <stdlib.h>
+#define mbedtls_calloc    calloc
+#define mbedtls_free       free
+#endif
+
+/* Implementation that should never be optimized out by the compiler */
+static void mbedtls_zeroize( void *v, size_t n ) {
+    volatile unsigned char *p = (unsigned char*)v; while( n-- ) *p++ = 0;
+}
+
+/*
+ * ASN.1 DER decoding routines
+ */
+int mbedtls_asn1_get_len( unsigned char **p,
+                  const unsigned char *end,
+                  size_t *len )
+{
+    if( ( end - *p ) < 1 )
+        return( MBEDTLS_ERR_ASN1_OUT_OF_DATA );
+
+    if( ( **p & 0x80 ) == 0 )
+        *len = *(*p)++;
+    else
+    {
+        switch( **p & 0x7F )
+        {
+        case 1:
+            if( ( end - *p ) < 2 )
+                return( MBEDTLS_ERR_ASN1_OUT_OF_DATA );
+
+            *len = (*p)[1];
+            (*p) += 2;
+            break;
+
+        case 2:
+            if( ( end - *p ) < 3 )
+                return( MBEDTLS_ERR_ASN1_OUT_OF_DATA );
+
+            *len = ( (size_t)(*p)[1] << 8 ) | (*p)[2];
+            (*p) += 3;
+            break;
+
+        case 3:
+            if( ( end - *p ) < 4 )
+                return( MBEDTLS_ERR_ASN1_OUT_OF_DATA );
+
+            *len = ( (size_t)(*p)[1] << 16 ) |
+                   ( (size_t)(*p)[2] << 8  ) | (*p)[3];
+            (*p) += 4;
+            break;
+
+        case 4:
+            if( ( end - *p ) < 5 )
+                return( MBEDTLS_ERR_ASN1_OUT_OF_DATA );
+
+            *len = ( (size_t)(*p)[1] << 24 ) | ( (size_t)(*p)[2] << 16 ) |
+                   ( (size_t)(*p)[3] << 8  ) |           (*p)[4];
+            (*p) += 5;
+            break;
+
+        default:
+            return( MBEDTLS_ERR_ASN1_INVALID_LENGTH );
+        }
+    }
+
+    if( *len > (size_t) ( end - *p ) )
+        return( MBEDTLS_ERR_ASN1_OUT_OF_DATA );
+
+    return( 0 );
+}
+
+int mbedtls_asn1_get_tag( unsigned char **p,
+                  const unsigned char *end,
+                  size_t *len, int tag )
+{
+    if( ( end - *p ) < 1 )
+        return( MBEDTLS_ERR_ASN1_OUT_OF_DATA );
+
+    if( **p != tag )
+        return( MBEDTLS_ERR_ASN1_UNEXPECTED_TAG );
+
+    (*p)++;
+
+    return( mbedtls_asn1_get_len( p, end, len ) );
+}
+
+int mbedtls_asn1_get_bool( unsigned char **p,
+                   const unsigned char *end,
+                   int *val )
+{
+    int ret;
+    size_t len;
+
+    if( ( ret = mbedtls_asn1_get_tag( p, end, &len, MBEDTLS_ASN1_BOOLEAN ) ) != 0 )
+        return( ret );
+
+    if( len != 1 )
+        return( MBEDTLS_ERR_ASN1_INVALID_LENGTH );
+
+    *val = ( **p != 0 ) ? 1 : 0;
+    (*p)++;
+
+    return( 0 );
+}
+
+int mbedtls_asn1_get_int( unsigned char **p,
+                  const unsigned char *end,
+                  int *val )
+{
+    int ret;
+    size_t len;
+
+    if( ( ret = mbedtls_asn1_get_tag( p, end, &len, MBEDTLS_ASN1_INTEGER ) ) != 0 )
+        return( ret );
+
+    if( len == 0 || len > sizeof( int ) || ( **p & 0x80 ) != 0 )
+        return( MBEDTLS_ERR_ASN1_INVALID_LENGTH );
+
+    *val = 0;
+
+    while( len-- > 0 )
+    {
+        *val = ( *val << 8 ) | **p;
+        (*p)++;
+    }
+
+    return( 0 );
+}
+
+#if defined(MBEDTLS_BIGNUM_C)
+int mbedtls_asn1_get_mpi( unsigned char **p,
+                  const unsigned char *end,
+                  mbedtls_mpi *X )
+{
+    int ret;
+    size_t len;
+
+    if( ( ret = mbedtls_asn1_get_tag( p, end, &len, MBEDTLS_ASN1_INTEGER ) ) != 0 )
+        return( ret );
+
+    ret = mbedtls_mpi_read_binary( X, *p, len );
+
+    *p += len;
+
+    return( ret );
+}
+#endif /* MBEDTLS_BIGNUM_C */
+
+int mbedtls_asn1_get_bitstring( unsigned char **p, const unsigned char *end,
+                        mbedtls_asn1_bitstring *bs)
+{
+    int ret;
+
+    /* Certificate type is a single byte bitstring */
+    if( ( ret = mbedtls_asn1_get_tag( p, end, &bs->len, MBEDTLS_ASN1_BIT_STRING ) ) != 0 )
+        return( ret );
+
+    /* Check length, subtract one for actual bit string length */
+    if( bs->len < 1 )
+        return( MBEDTLS_ERR_ASN1_OUT_OF_DATA );
+    bs->len -= 1;
+
+    /* Get number of unused bits, ensure unused bits <= 7 */
+    bs->unused_bits = **p;
+    if( bs->unused_bits > 7 )
+        return( MBEDTLS_ERR_ASN1_INVALID_LENGTH );
+    (*p)++;
+
+    /* Get actual bitstring */
+    bs->p = *p;
+    *p += bs->len;
+
+    if( *p != end )
+        return( MBEDTLS_ERR_ASN1_LENGTH_MISMATCH );
+
+    return( 0 );
+}
+
+/*
+ * Get a bit string without unused bits
+ */
+int mbedtls_asn1_get_bitstring_null( unsigned char **p, const unsigned char *end,
+                             size_t *len )
+{
+    int ret;
+
+    if( ( ret = mbedtls_asn1_get_tag( p, end, len, MBEDTLS_ASN1_BIT_STRING ) ) != 0 )
+        return( ret );
+
+    if( (*len)-- < 2 || *(*p)++ != 0 )
+        return( MBEDTLS_ERR_ASN1_INVALID_DATA );
+
+    return( 0 );
+}
+
+
+
+/*
+ *  Parses and splits an ASN.1 "SEQUENCE OF <tag>"
+ */
+int mbedtls_asn1_get_sequence_of( unsigned char **p,
+                          const unsigned char *end,
+                          mbedtls_asn1_sequence *cur,
+                          int tag)
+{
+    int ret;
+    size_t len;
+    mbedtls_asn1_buf *buf;
+
+    /* Get main sequence tag */
+    if( ( ret = mbedtls_asn1_get_tag( p, end, &len,
+            MBEDTLS_ASN1_CONSTRUCTED | MBEDTLS_ASN1_SEQUENCE ) ) != 0 )
+        return( ret );
+
+    if( *p + len != end )
+        return( MBEDTLS_ERR_ASN1_LENGTH_MISMATCH );
+
+    while( *p < end )
+    {
+        buf = &(cur->buf);
+        buf->tag = **p;
+
+        if( ( ret = mbedtls_asn1_get_tag( p, end, &buf->len, tag ) ) != 0 )
+            return( ret );
+
+        buf->p = *p;
+        *p += buf->len;
+
+        /* Allocate and assign next pointer */
+        if( *p < end )
+        {
+            cur->next = (mbedtls_asn1_sequence*)mbedtls_calloc( 1,
+                                            sizeof( mbedtls_asn1_sequence ) );
+
+            if( cur->next == NULL )
+                return( MBEDTLS_ERR_ASN1_ALLOC_FAILED );
+
+            cur = cur->next;
+        }
+    }
+
+    /* Set final sequence entry's next pointer to NULL */
+    cur->next = NULL;
+
+    if( *p != end )
+        return( MBEDTLS_ERR_ASN1_LENGTH_MISMATCH );
+
+    return( 0 );
+}
+
+int mbedtls_asn1_get_alg( unsigned char **p,
+                  const unsigned char *end,
+                  mbedtls_asn1_buf *alg, mbedtls_asn1_buf *params )
+{
+    int ret;
+    size_t len;
+
+    if( ( ret = mbedtls_asn1_get_tag( p, end, &len,
+            MBEDTLS_ASN1_CONSTRUCTED | MBEDTLS_ASN1_SEQUENCE ) ) != 0 )
+        return( ret );
+
+    if( ( end - *p ) < 1 )
+        return( MBEDTLS_ERR_ASN1_OUT_OF_DATA );
+
+    alg->tag = **p;
+    end = *p + len;
+
+    if( ( ret = mbedtls_asn1_get_tag( p, end, &alg->len, MBEDTLS_ASN1_OID ) ) != 0 )
+        return( ret );
+
+    alg->p = *p;
+    *p += alg->len;
+
+    if( *p == end )
+    {
+        mbedtls_zeroize( params, sizeof(mbedtls_asn1_buf) );
+        return( 0 );
+    }
+
+    params->tag = **p;
+    (*p)++;
+
+    if( ( ret = mbedtls_asn1_get_len( p, end, &params->len ) ) != 0 )
+        return( ret );
+
+    params->p = *p;
+    *p += params->len;
+
+    if( *p != end )
+        return( MBEDTLS_ERR_ASN1_LENGTH_MISMATCH );
+
+    return( 0 );
+}
+
+int mbedtls_asn1_get_alg_null( unsigned char **p,
+                       const unsigned char *end,
+                       mbedtls_asn1_buf *alg )
+{
+    int ret;
+    mbedtls_asn1_buf params;
+
+    memset( &params, 0, sizeof(mbedtls_asn1_buf) );
+
+    if( ( ret = mbedtls_asn1_get_alg( p, end, alg, &params ) ) != 0 )
+        return( ret );
+
+    if( ( params.tag != MBEDTLS_ASN1_NULL && params.tag != 0 ) || params.len != 0 )
+        return( MBEDTLS_ERR_ASN1_INVALID_DATA );
+
+    return( 0 );
+}
+
+void mbedtls_asn1_free_named_data( mbedtls_asn1_named_data *cur )
+{
+    if( cur == NULL )
+        return;
+
+    mbedtls_free( cur->oid.p );
+    mbedtls_free( cur->val.p );
+
+    mbedtls_zeroize( cur, sizeof( mbedtls_asn1_named_data ) );
+}
+
+void mbedtls_asn1_free_named_data_list( mbedtls_asn1_named_data **head )
+{
+    mbedtls_asn1_named_data *cur;
+
+    while( ( cur = *head ) != NULL )
+    {
+        *head = cur->next;
+        mbedtls_asn1_free_named_data( cur );
+        mbedtls_free( cur );
+    }
+}
+
+mbedtls_asn1_named_data *mbedtls_asn1_find_named_data( mbedtls_asn1_named_data *list,
+                                       const char *oid, size_t len )
+{
+    while( list != NULL )
+    {
+        if( list->oid.len == len &&
+            memcmp( list->oid.p, oid, len ) == 0 )
+        {
+            break;
+        }
+
+        list = list->next;
+    }
+
+    return( list );
+}
+
+#endif /* MBEDTLS_ASN1_PARSE_C */
diff --git a/backport/compat/verification/bignum.c b/backport/compat/verification/bignum.c
new file mode 100644
index 000000000000..7edfb0837557
--- /dev/null
+++ b/backport/compat/verification/bignum.c
@@ -0,0 +1,2447 @@
+/*
+ *  Multi-precision integer library
+ *
+ *  Copyright (C) 2006-2015, ARM Limited, All Rights Reserved
+ *  SPDX-License-Identifier: GPL-2.0
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ *  This file is part of mbed TLS (https://tls.mbed.org)
+ */
+
+/*
+ *  The following sources were referenced in the design of this Multi-precision
+ *  Integer library:
+ *
+ *  [1] Handbook of Applied Cryptography - 1997
+ *      Menezes, van Oorschot and Vanstone
+ *
+ *  [2] Multi-Precision Math
+ *      Tom St Denis
+ *      https://github.com/libtom/libtommath/blob/develop/tommath.pdf
+ *
+ *  [3] GNU Multi-Precision Arithmetic Library
+ *      https://gmplib.org/manual/index.html
+ *
+ */
+
+#if !defined(MBEDTLS_CONFIG_FILE)
+#include "mbedtls/config.h"
+#else
+#include MBEDTLS_CONFIG_FILE
+#endif
+
+#if defined(MBEDTLS_BIGNUM_C)
+
+#include "mbedtls/bignum.h"
+#include "mbedtls/bn_mul.h"
+
+#if defined(MBEDTLS_PLATFORM_C)
+#include "mbedtls/platform.h"
+#else
+#include <stdio.h>
+#include <stdlib.h>
+#define mbedtls_printf     printf
+#define mbedtls_calloc    calloc
+#define mbedtls_free       free
+#endif
+
+/* Implementation that should never be optimized out by the compiler */
+static void mbedtls_mpi_zeroize( mbedtls_mpi_uint *v, size_t n ) {
+    volatile mbedtls_mpi_uint *p = v; while( n-- ) *p++ = 0;
+}
+
+#define ciL    (sizeof(mbedtls_mpi_uint))         /* chars in limb  */
+#define biL    (ciL << 3)               /* bits  in limb  */
+#define biH    (ciL << 2)               /* half limb size */
+
+#define MPI_SIZE_T_MAX  ( (size_t) -1 ) /* SIZE_T_MAX is not standard */
+
+/*
+ * Convert between bits/chars and number of limbs
+ * Divide first in order to avoid potential overflows
+ */
+#define BITS_TO_LIMBS(i)  ( (i) / biL + ( (i) % biL != 0 ) )
+#define CHARS_TO_LIMBS(i) ( (i) / ciL + ( (i) % ciL != 0 ) )
+
+/*
+ * Initialize one MPI
+ */
+void mbedtls_mpi_init( mbedtls_mpi *X )
+{
+    if( X == NULL )
+        return;
+
+    X->s = 1;
+    X->n = 0;
+    X->p = NULL;
+}
+
+/*
+ * Unallocate one MPI
+ */
+void mbedtls_mpi_free( mbedtls_mpi *X )
+{
+    if( X == NULL )
+        return;
+
+    if( X->p != NULL )
+    {
+        mbedtls_mpi_zeroize( X->p, X->n );
+        mbedtls_free( X->p );
+    }
+
+    X->s = 1;
+    X->n = 0;
+    X->p = NULL;
+}
+
+/*
+ * Enlarge to the specified number of limbs
+ */
+int mbedtls_mpi_grow( mbedtls_mpi *X, size_t nblimbs )
+{
+    mbedtls_mpi_uint *p;
+
+    if( nblimbs > MBEDTLS_MPI_MAX_LIMBS )
+        return( MBEDTLS_ERR_MPI_ALLOC_FAILED );
+
+    if( X->n < nblimbs )
+    {
+        if( ( p = (mbedtls_mpi_uint*)mbedtls_calloc( nblimbs, ciL ) ) == NULL )
+            return( MBEDTLS_ERR_MPI_ALLOC_FAILED );
+
+        if( X->p != NULL )
+        {
+            memcpy( p, X->p, X->n * ciL );
+            mbedtls_mpi_zeroize( X->p, X->n );
+            mbedtls_free( X->p );
+        }
+
+        X->n = nblimbs;
+        X->p = p;
+    }
+
+    return( 0 );
+}
+
+/*
+ * Resize down as much as possible,
+ * while keeping at least the specified number of limbs
+ */
+int mbedtls_mpi_shrink( mbedtls_mpi *X, size_t nblimbs )
+{
+    mbedtls_mpi_uint *p;
+    size_t i;
+
+    /* Actually resize up in this case */
+    if( X->n <= nblimbs )
+        return( mbedtls_mpi_grow( X, nblimbs ) );
+
+    for( i = X->n - 1; i > 0; i-- )
+        if( X->p[i] != 0 )
+            break;
+    i++;
+
+    if( i < nblimbs )
+        i = nblimbs;
+
+    if( ( p = (mbedtls_mpi_uint*)mbedtls_calloc( i, ciL ) ) == NULL )
+        return( MBEDTLS_ERR_MPI_ALLOC_FAILED );
+
+    if( X->p != NULL )
+    {
+        memcpy( p, X->p, i * ciL );
+        mbedtls_mpi_zeroize( X->p, X->n );
+        mbedtls_free( X->p );
+    }
+
+    X->n = i;
+    X->p = p;
+
+    return( 0 );
+}
+
+/*
+ * Copy the contents of Y into X
+ */
+int mbedtls_mpi_copy( mbedtls_mpi *X, const mbedtls_mpi *Y )
+{
+    int ret;
+    size_t i;
+
+    if( X == Y )
+        return( 0 );
+
+    if( Y->p == NULL )
+    {
+        mbedtls_mpi_free( X );
+        return( 0 );
+    }
+
+    for( i = Y->n - 1; i > 0; i-- )
+        if( Y->p[i] != 0 )
+            break;
+    i++;
+
+    X->s = Y->s;
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_grow( X, i ) );
+
+    memset( X->p, 0, X->n * ciL );
+    memcpy( X->p, Y->p, i * ciL );
+
+cleanup:
+
+    return( ret );
+}
+
+/*
+ * Swap the contents of X and Y
+ */
+void mbedtls_mpi_swap( mbedtls_mpi *X, mbedtls_mpi *Y )
+{
+    mbedtls_mpi T;
+
+    memcpy( &T,  X, sizeof( mbedtls_mpi ) );
+    memcpy(  X,  Y, sizeof( mbedtls_mpi ) );
+    memcpy(  Y, &T, sizeof( mbedtls_mpi ) );
+}
+
+/*
+ * Conditionally assign X = Y, without leaking information
+ * about whether the assignment was made or not.
+ * (Leaking information about the respective sizes of X and Y is ok however.)
+ */
+int mbedtls_mpi_safe_cond_assign( mbedtls_mpi *X, const mbedtls_mpi *Y, unsigned char assign )
+{
+    int ret = 0;
+    size_t i;
+
+    /* make sure assign is 0 or 1 in a time-constant manner */
+    assign = (assign | (unsigned char)-assign) >> 7;
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_grow( X, Y->n ) );
+
+    X->s = X->s * ( 1 - assign ) + Y->s * assign;
+
+    for( i = 0; i < Y->n; i++ )
+        X->p[i] = X->p[i] * ( 1 - assign ) + Y->p[i] * assign;
+
+    for( ; i < X->n; i++ )
+        X->p[i] *= ( 1 - assign );
+
+cleanup:
+    return( ret );
+}
+
+/*
+ * Conditionally swap X and Y, without leaking information
+ * about whether the swap was made or not.
+ * Here it is not ok to simply swap the pointers, which whould lead to
+ * different memory access patterns when X and Y are used afterwards.
+ */
+int mbedtls_mpi_safe_cond_swap( mbedtls_mpi *X, mbedtls_mpi *Y, unsigned char swap )
+{
+    int ret, s;
+    size_t i;
+    mbedtls_mpi_uint tmp;
+
+    if( X == Y )
+        return( 0 );
+
+    /* make sure swap is 0 or 1 in a time-constant manner */
+    swap = (swap | (unsigned char)-swap) >> 7;
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_grow( X, Y->n ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_grow( Y, X->n ) );
+
+    s = X->s;
+    X->s = X->s * ( 1 - swap ) + Y->s * swap;
+    Y->s = Y->s * ( 1 - swap ) +    s * swap;
+
+
+    for( i = 0; i < X->n; i++ )
+    {
+        tmp = X->p[i];
+        X->p[i] = X->p[i] * ( 1 - swap ) + Y->p[i] * swap;
+        Y->p[i] = Y->p[i] * ( 1 - swap ) +     tmp * swap;
+    }
+
+cleanup:
+    return( ret );
+}
+
+/*
+ * Set value from integer
+ */
+int mbedtls_mpi_lset( mbedtls_mpi *X, mbedtls_mpi_sint z )
+{
+    int ret;
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_grow( X, 1 ) );
+    memset( X->p, 0, X->n * ciL );
+
+    X->p[0] = ( z < 0 ) ? -z : z;
+    X->s    = ( z < 0 ) ? -1 : 1;
+
+cleanup:
+
+    return( ret );
+}
+
+/*
+ * Get a specific bit
+ */
+int mbedtls_mpi_get_bit( const mbedtls_mpi *X, size_t pos )
+{
+    if( X->n * biL <= pos )
+        return( 0 );
+
+    return( ( X->p[pos / biL] >> ( pos % biL ) ) & 0x01 );
+}
+
+/*
+ * Set a bit to a specific value of 0 or 1
+ */
+int mbedtls_mpi_set_bit( mbedtls_mpi *X, size_t pos, unsigned char val )
+{
+    int ret = 0;
+    size_t off = pos / biL;
+    size_t idx = pos % biL;
+
+    if( val != 0 && val != 1 )
+        return( MBEDTLS_ERR_MPI_BAD_INPUT_DATA );
+
+    if( X->n * biL <= pos )
+    {
+        if( val == 0 )
+            return( 0 );
+
+        MBEDTLS_MPI_CHK( mbedtls_mpi_grow( X, off + 1 ) );
+    }
+
+    X->p[off] &= ~( (mbedtls_mpi_uint) 0x01 << idx );
+    X->p[off] |= (mbedtls_mpi_uint) val << idx;
+
+cleanup:
+
+    return( ret );
+}
+
+/*
+ * Return the number of less significant zero-bits
+ */
+size_t mbedtls_mpi_lsb( const mbedtls_mpi *X )
+{
+    size_t i, j, count = 0;
+
+    for( i = 0; i < X->n; i++ )
+        for( j = 0; j < biL; j++, count++ )
+            if( ( ( X->p[i] >> j ) & 1 ) != 0 )
+                return( count );
+
+    return( 0 );
+}
+
+/*
+ * Count leading zero bits in a given integer
+ */
+static size_t mbedtls_clz( const mbedtls_mpi_uint x )
+{
+    size_t j;
+    mbedtls_mpi_uint mask = (mbedtls_mpi_uint) 1 << (biL - 1);
+
+    for( j = 0; j < biL; j++ )
+    {
+        if( x & mask ) break;
+
+        mask >>= 1;
+    }
+
+    return j;
+}
+
+/*
+ * Return the number of bits
+ */
+size_t mbedtls_mpi_bitlen( const mbedtls_mpi *X )
+{
+    size_t i, j;
+
+    if( X->n == 0 )
+        return( 0 );
+
+    for( i = X->n - 1; i > 0; i-- )
+        if( X->p[i] != 0 )
+            break;
+
+    j = biL - mbedtls_clz( X->p[i] );
+
+    return( ( i * biL ) + j );
+}
+
+/*
+ * Return the total size in bytes
+ */
+size_t mbedtls_mpi_size( const mbedtls_mpi *X )
+{
+    return( ( mbedtls_mpi_bitlen( X ) + 7 ) >> 3 );
+}
+
+/*
+ * Convert an ASCII character to digit value
+ */
+static int mpi_get_digit( mbedtls_mpi_uint *d, int radix, char c )
+{
+    *d = 255;
+
+    if( c >= 0x30 && c <= 0x39 ) *d = c - 0x30;
+    if( c >= 0x41 && c <= 0x46 ) *d = c - 0x37;
+    if( c >= 0x61 && c <= 0x66 ) *d = c - 0x57;
+
+    if( *d >= (mbedtls_mpi_uint) radix )
+        return( MBEDTLS_ERR_MPI_INVALID_CHARACTER );
+
+    return( 0 );
+}
+
+/*
+ * Import from an ASCII string
+ */
+int mbedtls_mpi_read_string( mbedtls_mpi *X, int radix, const char *s )
+{
+    int ret;
+    size_t i, j, slen, n;
+    mbedtls_mpi_uint d;
+    mbedtls_mpi T;
+
+    if( radix < 2 || radix > 16 )
+        return( MBEDTLS_ERR_MPI_BAD_INPUT_DATA );
+
+    mbedtls_mpi_init( &T );
+
+    slen = strlen( s );
+
+    if( radix == 16 )
+    {
+        if( slen > MPI_SIZE_T_MAX >> 2 )
+            return( MBEDTLS_ERR_MPI_BAD_INPUT_DATA );
+
+        n = BITS_TO_LIMBS( slen << 2 );
+
+        MBEDTLS_MPI_CHK( mbedtls_mpi_grow( X, n ) );
+        MBEDTLS_MPI_CHK( mbedtls_mpi_lset( X, 0 ) );
+
+        for( i = slen, j = 0; i > 0; i--, j++ )
+        {
+            if( i == 1 && s[i - 1] == '-' )
+            {
+                X->s = -1;
+                break;
+            }
+
+            MBEDTLS_MPI_CHK( mpi_get_digit( &d, radix, s[i - 1] ) );
+            X->p[j / ( 2 * ciL )] |= d << ( ( j % ( 2 * ciL ) ) << 2 );
+        }
+    }
+    else
+    {
+        MBEDTLS_MPI_CHK( mbedtls_mpi_lset( X, 0 ) );
+
+        for( i = 0; i < slen; i++ )
+        {
+            if( i == 0 && s[i] == '-' )
+            {
+                X->s = -1;
+                continue;
+            }
+
+            MBEDTLS_MPI_CHK( mpi_get_digit( &d, radix, s[i] ) );
+            MBEDTLS_MPI_CHK( mbedtls_mpi_mul_int( &T, X, radix ) );
+
+            if( X->s == 1 )
+            {
+                MBEDTLS_MPI_CHK( mbedtls_mpi_add_int( X, &T, d ) );
+            }
+            else
+            {
+                MBEDTLS_MPI_CHK( mbedtls_mpi_sub_int( X, &T, d ) );
+            }
+        }
+    }
+
+cleanup:
+
+    mbedtls_mpi_free( &T );
+
+    return( ret );
+}
+
+/*
+ * Helper to write the digits high-order first
+ */
+static int mpi_write_hlp( mbedtls_mpi *X, int radix, char **p )
+{
+    int ret;
+    mbedtls_mpi_uint r;
+
+    if( radix < 2 || radix > 16 )
+        return( MBEDTLS_ERR_MPI_BAD_INPUT_DATA );
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_mod_int( &r, X, radix ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_div_int( X, NULL, X, radix ) );
+
+    if( mbedtls_mpi_cmp_int( X, 0 ) != 0 )
+        MBEDTLS_MPI_CHK( mpi_write_hlp( X, radix, p ) );
+
+    if( r < 10 )
+        *(*p)++ = (char)( r + 0x30 );
+    else
+        *(*p)++ = (char)( r + 0x37 );
+
+cleanup:
+
+    return( ret );
+}
+
+/*
+ * Export into an ASCII string
+ */
+int mbedtls_mpi_write_string( const mbedtls_mpi *X, int radix,
+                              char *buf, size_t buflen, size_t *olen )
+{
+    int ret = 0;
+    size_t n;
+    char *p;
+    mbedtls_mpi T;
+
+    if( radix < 2 || radix > 16 )
+        return( MBEDTLS_ERR_MPI_BAD_INPUT_DATA );
+
+    n = mbedtls_mpi_bitlen( X );
+    if( radix >=  4 ) n >>= 1;
+    if( radix >= 16 ) n >>= 1;
+    /*
+     * Round up the buffer length to an even value to ensure that there is
+     * enough room for hexadecimal values that can be represented in an odd
+     * number of digits.
+     */
+    n += 3 + ( ( n + 1 ) & 1 );
+
+    if( buflen < n )
+    {
+        *olen = n;
+        return( MBEDTLS_ERR_MPI_BUFFER_TOO_SMALL );
+    }
+
+    p = buf;
+    mbedtls_mpi_init( &T );
+
+    if( X->s == -1 )
+        *p++ = '-';
+
+    if( radix == 16 )
+    {
+        int c;
+        size_t i, j, k;
+
+        for( i = X->n, k = 0; i > 0; i-- )
+        {
+            for( j = ciL; j > 0; j-- )
+            {
+                c = ( X->p[i - 1] >> ( ( j - 1 ) << 3) ) & 0xFF;
+
+                if( c == 0 && k == 0 && ( i + j ) != 2 )
+                    continue;
+
+                *(p++) = "0123456789ABCDEF" [c / 16];
+                *(p++) = "0123456789ABCDEF" [c % 16];
+                k = 1;
+            }
+        }
+    }
+    else
+    {
+        MBEDTLS_MPI_CHK( mbedtls_mpi_copy( &T, X ) );
+
+        if( T.s == -1 )
+            T.s = 1;
+
+        MBEDTLS_MPI_CHK( mpi_write_hlp( &T, radix, &p ) );
+    }
+
+    *p++ = '\0';
+    *olen = p - buf;
+
+cleanup:
+
+    mbedtls_mpi_free( &T );
+
+    return( ret );
+}
+
+#if defined(MBEDTLS_FS_IO)
+/*
+ * Read X from an opened file
+ */
+int mbedtls_mpi_read_file( mbedtls_mpi *X, int radix, FILE *fin )
+{
+    mbedtls_mpi_uint d;
+    size_t slen;
+    char *p;
+    /*
+     * Buffer should have space for (short) label and decimal formatted MPI,
+     * newline characters and '\0'
+     */
+    char s[ MBEDTLS_MPI_RW_BUFFER_SIZE ];
+
+    memset( s, 0, sizeof( s ) );
+    if( fgets( s, sizeof( s ) - 1, fin ) == NULL )
+        return( MBEDTLS_ERR_MPI_FILE_IO_ERROR );
+
+    slen = strlen( s );
+    if( slen == sizeof( s ) - 2 )
+        return( MBEDTLS_ERR_MPI_BUFFER_TOO_SMALL );
+
+    if( slen > 0 && s[slen - 1] == '\n' ) { slen--; s[slen] = '\0'; }
+    if( slen > 0 && s[slen - 1] == '\r' ) { slen--; s[slen] = '\0'; }
+
+    p = s + slen;
+    while( p-- > s )
+        if( mpi_get_digit( &d, radix, *p ) != 0 )
+            break;
+
+    return( mbedtls_mpi_read_string( X, radix, p + 1 ) );
+}
+
+/*
+ * Write X into an opened file (or stdout if fout == NULL)
+ */
+int mbedtls_mpi_write_file( const char *p, const mbedtls_mpi *X, int radix, FILE *fout )
+{
+    int ret;
+    size_t n, slen, plen;
+    /*
+     * Buffer should have space for (short) label and decimal formatted MPI,
+     * newline characters and '\0'
+     */
+    char s[ MBEDTLS_MPI_RW_BUFFER_SIZE ];
+
+    memset( s, 0, sizeof( s ) );
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_write_string( X, radix, s, sizeof( s ) - 2, &n ) );
+
+    if( p == NULL ) p = "";
+
+    plen = strlen( p );
+    slen = strlen( s );
+    s[slen++] = '\r';
+    s[slen++] = '\n';
+
+    if( fout != NULL )
+    {
+        if( fwrite( p, 1, plen, fout ) != plen ||
+            fwrite( s, 1, slen, fout ) != slen )
+            return( MBEDTLS_ERR_MPI_FILE_IO_ERROR );
+    }
+    else
+        mbedtls_printf( "%s%s", p, s );
+
+cleanup:
+
+    return( ret );
+}
+#endif /* MBEDTLS_FS_IO */
+
+/*
+ * Import X from unsigned binary data, big endian
+ */
+int mbedtls_mpi_read_binary( mbedtls_mpi *X, const unsigned char *buf, size_t buflen )
+{
+    int ret;
+    size_t i, j, n;
+
+    for( n = 0; n < buflen; n++ )
+        if( buf[n] != 0 )
+            break;
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_grow( X, CHARS_TO_LIMBS( buflen - n ) ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_lset( X, 0 ) );
+
+    for( i = buflen, j = 0; i > n; i--, j++ )
+        X->p[j / ciL] |= ((mbedtls_mpi_uint) buf[i - 1]) << ((j % ciL) << 3);
+
+cleanup:
+
+    return( ret );
+}
+
+/*
+ * Export X into unsigned binary data, big endian
+ */
+int mbedtls_mpi_write_binary( const mbedtls_mpi *X, unsigned char *buf, size_t buflen )
+{
+    size_t i, j, n;
+
+    n = mbedtls_mpi_size( X );
+
+    if( buflen < n )
+        return( MBEDTLS_ERR_MPI_BUFFER_TOO_SMALL );
+
+    memset( buf, 0, buflen );
+
+    for( i = buflen - 1, j = 0; n > 0; i--, j++, n-- )
+        buf[i] = (unsigned char)( X->p[j / ciL] >> ((j % ciL) << 3) );
+
+    return( 0 );
+}
+
+/*
+ * Left-shift: X <<= count
+ */
+int mbedtls_mpi_shift_l( mbedtls_mpi *X, size_t count )
+{
+    int ret;
+    size_t i, v0, t1;
+    mbedtls_mpi_uint r0 = 0, r1;
+
+    v0 = count / (biL    );
+    t1 = count & (biL - 1);
+
+    i = mbedtls_mpi_bitlen( X ) + count;
+
+    if( X->n * biL < i )
+        MBEDTLS_MPI_CHK( mbedtls_mpi_grow( X, BITS_TO_LIMBS( i ) ) );
+
+    ret = 0;
+
+    /*
+     * shift by count / limb_size
+     */
+    if( v0 > 0 )
+    {
+        for( i = X->n; i > v0; i-- )
+            X->p[i - 1] = X->p[i - v0 - 1];
+
+        for( ; i > 0; i-- )
+            X->p[i - 1] = 0;
+    }
+
+    /*
+     * shift by count % limb_size
+     */
+    if( t1 > 0 )
+    {
+        for( i = v0; i < X->n; i++ )
+        {
+            r1 = X->p[i] >> (biL - t1);
+            X->p[i] <<= t1;
+            X->p[i] |= r0;
+            r0 = r1;
+        }
+    }
+
+cleanup:
+
+    return( ret );
+}
+
+/*
+ * Right-shift: X >>= count
+ */
+int mbedtls_mpi_shift_r( mbedtls_mpi *X, size_t count )
+{
+    size_t i, v0, v1;
+    mbedtls_mpi_uint r0 = 0, r1;
+
+    v0 = count /  biL;
+    v1 = count & (biL - 1);
+
+    if( v0 > X->n || ( v0 == X->n && v1 > 0 ) )
+        return mbedtls_mpi_lset( X, 0 );
+
+    /*
+     * shift by count / limb_size
+     */
+    if( v0 > 0 )
+    {
+        for( i = 0; i < X->n - v0; i++ )
+            X->p[i] = X->p[i + v0];
+
+        for( ; i < X->n; i++ )
+            X->p[i] = 0;
+    }
+
+    /*
+     * shift by count % limb_size
+     */
+    if( v1 > 0 )
+    {
+        for( i = X->n; i > 0; i-- )
+        {
+            r1 = X->p[i - 1] << (biL - v1);
+            X->p[i - 1] >>= v1;
+            X->p[i - 1] |= r0;
+            r0 = r1;
+        }
+    }
+
+    return( 0 );
+}
+
+/*
+ * Compare unsigned values
+ */
+int mbedtls_mpi_cmp_abs( const mbedtls_mpi *X, const mbedtls_mpi *Y )
+{
+    size_t i, j;
+
+    for( i = X->n; i > 0; i-- )
+        if( X->p[i - 1] != 0 )
+            break;
+
+    for( j = Y->n; j > 0; j-- )
+        if( Y->p[j - 1] != 0 )
+            break;
+
+    if( i == 0 && j == 0 )
+        return( 0 );
+
+    if( i > j ) return(  1 );
+    if( j > i ) return( -1 );
+
+    for( ; i > 0; i-- )
+    {
+        if( X->p[i - 1] > Y->p[i - 1] ) return(  1 );
+        if( X->p[i - 1] < Y->p[i - 1] ) return( -1 );
+    }
+
+    return( 0 );
+}
+
+/*
+ * Compare signed values
+ */
+int mbedtls_mpi_cmp_mpi( const mbedtls_mpi *X, const mbedtls_mpi *Y )
+{
+    size_t i, j;
+
+    for( i = X->n; i > 0; i-- )
+        if( X->p[i - 1] != 0 )
+            break;
+
+    for( j = Y->n; j > 0; j-- )
+        if( Y->p[j - 1] != 0 )
+            break;
+
+    if( i == 0 && j == 0 )
+        return( 0 );
+
+    if( i > j ) return(  X->s );
+    if( j > i ) return( -Y->s );
+
+    if( X->s > 0 && Y->s < 0 ) return(  1 );
+    if( Y->s > 0 && X->s < 0 ) return( -1 );
+
+    for( ; i > 0; i-- )
+    {
+        if( X->p[i - 1] > Y->p[i - 1] ) return(  X->s );
+        if( X->p[i - 1] < Y->p[i - 1] ) return( -X->s );
+    }
+
+    return( 0 );
+}
+
+/*
+ * Compare signed values
+ */
+int mbedtls_mpi_cmp_int( const mbedtls_mpi *X, mbedtls_mpi_sint z )
+{
+    mbedtls_mpi Y;
+    mbedtls_mpi_uint p[1];
+
+    *p  = ( z < 0 ) ? -z : z;
+    Y.s = ( z < 0 ) ? -1 : 1;
+    Y.n = 1;
+    Y.p = p;
+
+    return( mbedtls_mpi_cmp_mpi( X, &Y ) );
+}
+
+/*
+ * Unsigned addition: X = |A| + |B|  (HAC 14.7)
+ */
+int mbedtls_mpi_add_abs( mbedtls_mpi *X, const mbedtls_mpi *A, const mbedtls_mpi *B )
+{
+    int ret;
+    size_t i, j;
+    mbedtls_mpi_uint *o, *p, c, tmp;
+
+    if( X == B )
+    {
+        const mbedtls_mpi *T = A; A = X; B = T;
+    }
+
+    if( X != A )
+        MBEDTLS_MPI_CHK( mbedtls_mpi_copy( X, A ) );
+
+    /*
+     * X should always be positive as a result of unsigned additions.
+     */
+    X->s = 1;
+
+    for( j = B->n; j > 0; j-- )
+        if( B->p[j - 1] != 0 )
+            break;
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_grow( X, j ) );
+
+    o = B->p; p = X->p; c = 0;
+
+    /*
+     * tmp is used because it might happen that p == o
+     */
+    for( i = 0; i < j; i++, o++, p++ )
+    {
+        tmp= *o;
+        *p +=  c; c  = ( *p <  c );
+        *p += tmp; c += ( *p < tmp );
+    }
+
+    while( c != 0 )
+    {
+        if( i >= X->n )
+        {
+            MBEDTLS_MPI_CHK( mbedtls_mpi_grow( X, i + 1 ) );
+            p = X->p + i;
+        }
+
+        *p += c; c = ( *p < c ); i++; p++;
+    }
+
+cleanup:
+
+    return( ret );
+}
+
+/*
+ * Helper for mbedtls_mpi subtraction
+ */
+static void mpi_sub_hlp( size_t n, mbedtls_mpi_uint *s, mbedtls_mpi_uint *d )
+{
+    size_t i;
+    mbedtls_mpi_uint c, z;
+
+    for( i = c = 0; i < n; i++, s++, d++ )
+    {
+        z = ( *d <  c );     *d -=  c;
+        c = ( *d < *s ) + z; *d -= *s;
+    }
+
+    while( c != 0 )
+    {
+        z = ( *d < c ); *d -= c;
+        c = z; i++; d++;
+    }
+}
+
+/*
+ * Unsigned subtraction: X = |A| - |B|  (HAC 14.9)
+ */
+int mbedtls_mpi_sub_abs( mbedtls_mpi *X, const mbedtls_mpi *A, const mbedtls_mpi *B )
+{
+    mbedtls_mpi TB;
+    int ret;
+    size_t n;
+
+    if( mbedtls_mpi_cmp_abs( A, B ) < 0 )
+        return( MBEDTLS_ERR_MPI_NEGATIVE_VALUE );
+
+    mbedtls_mpi_init( &TB );
+
+    if( X == B )
+    {
+        MBEDTLS_MPI_CHK( mbedtls_mpi_copy( &TB, B ) );
+        B = &TB;
+    }
+
+    if( X != A )
+        MBEDTLS_MPI_CHK( mbedtls_mpi_copy( X, A ) );
+
+    /*
+     * X should always be positive as a result of unsigned subtractions.
+     */
+    X->s = 1;
+
+    ret = 0;
+
+    for( n = B->n; n > 0; n-- )
+        if( B->p[n - 1] != 0 )
+            break;
+
+    mpi_sub_hlp( n, B->p, X->p );
+
+cleanup:
+
+    mbedtls_mpi_free( &TB );
+
+    return( ret );
+}
+
+/*
+ * Signed addition: X = A + B
+ */
+int mbedtls_mpi_add_mpi( mbedtls_mpi *X, const mbedtls_mpi *A, const mbedtls_mpi *B )
+{
+    int ret, s = A->s;
+
+    if( A->s * B->s < 0 )
+    {
+        if( mbedtls_mpi_cmp_abs( A, B ) >= 0 )
+        {
+            MBEDTLS_MPI_CHK( mbedtls_mpi_sub_abs( X, A, B ) );
+            X->s =  s;
+        }
+        else
+        {
+            MBEDTLS_MPI_CHK( mbedtls_mpi_sub_abs( X, B, A ) );
+            X->s = -s;
+        }
+    }
+    else
+    {
+        MBEDTLS_MPI_CHK( mbedtls_mpi_add_abs( X, A, B ) );
+        X->s = s;
+    }
+
+cleanup:
+
+    return( ret );
+}
+
+/*
+ * Signed subtraction: X = A - B
+ */
+int mbedtls_mpi_sub_mpi( mbedtls_mpi *X, const mbedtls_mpi *A, const mbedtls_mpi *B )
+{
+    int ret, s = A->s;
+
+    if( A->s * B->s > 0 )
+    {
+        if( mbedtls_mpi_cmp_abs( A, B ) >= 0 )
+        {
+            MBEDTLS_MPI_CHK( mbedtls_mpi_sub_abs( X, A, B ) );
+            X->s =  s;
+        }
+        else
+        {
+            MBEDTLS_MPI_CHK( mbedtls_mpi_sub_abs( X, B, A ) );
+            X->s = -s;
+        }
+    }
+    else
+    {
+        MBEDTLS_MPI_CHK( mbedtls_mpi_add_abs( X, A, B ) );
+        X->s = s;
+    }
+
+cleanup:
+
+    return( ret );
+}
+
+/*
+ * Signed addition: X = A + b
+ */
+int mbedtls_mpi_add_int( mbedtls_mpi *X, const mbedtls_mpi *A, mbedtls_mpi_sint b )
+{
+    mbedtls_mpi _B;
+    mbedtls_mpi_uint p[1];
+
+    p[0] = ( b < 0 ) ? -b : b;
+    _B.s = ( b < 0 ) ? -1 : 1;
+    _B.n = 1;
+    _B.p = p;
+
+    return( mbedtls_mpi_add_mpi( X, A, &_B ) );
+}
+
+/*
+ * Signed subtraction: X = A - b
+ */
+int mbedtls_mpi_sub_int( mbedtls_mpi *X, const mbedtls_mpi *A, mbedtls_mpi_sint b )
+{
+    mbedtls_mpi _B;
+    mbedtls_mpi_uint p[1];
+
+    p[0] = ( b < 0 ) ? -b : b;
+    _B.s = ( b < 0 ) ? -1 : 1;
+    _B.n = 1;
+    _B.p = p;
+
+    return( mbedtls_mpi_sub_mpi( X, A, &_B ) );
+}
+
+/*
+ * Helper for mbedtls_mpi multiplication
+ */
+static
+#if defined(__APPLE__) && defined(__arm__)
+/*
+ * Apple LLVM version 4.2 (clang-425.0.24) (based on LLVM 3.2svn)
+ * appears to need this to prevent bad ARM code generation at -O3.
+ */
+__attribute__ ((noinline))
+#endif
+void mpi_mul_hlp( size_t i, mbedtls_mpi_uint *s, mbedtls_mpi_uint *d, mbedtls_mpi_uint b )
+{
+    mbedtls_mpi_uint c = 0, t = 0;
+
+#if defined(MULADDC_HUIT)
+    for( ; i >= 8; i -= 8 )
+    {
+        MULADDC_INIT
+        MULADDC_HUIT
+        MULADDC_STOP
+    }
+
+    for( ; i > 0; i-- )
+    {
+        MULADDC_INIT
+        MULADDC_CORE
+        MULADDC_STOP
+    }
+#else /* MULADDC_HUIT */
+    for( ; i >= 16; i -= 16 )
+    {
+        MULADDC_INIT
+        MULADDC_CORE   MULADDC_CORE
+        MULADDC_CORE   MULADDC_CORE
+        MULADDC_CORE   MULADDC_CORE
+        MULADDC_CORE   MULADDC_CORE
+
+        MULADDC_CORE   MULADDC_CORE
+        MULADDC_CORE   MULADDC_CORE
+        MULADDC_CORE   MULADDC_CORE
+        MULADDC_CORE   MULADDC_CORE
+        MULADDC_STOP
+    }
+
+    for( ; i >= 8; i -= 8 )
+    {
+        MULADDC_INIT
+        MULADDC_CORE   MULADDC_CORE
+        MULADDC_CORE   MULADDC_CORE
+
+        MULADDC_CORE   MULADDC_CORE
+        MULADDC_CORE   MULADDC_CORE
+        MULADDC_STOP
+    }
+
+    for( ; i > 0; i-- )
+    {
+        MULADDC_INIT
+        MULADDC_CORE
+        MULADDC_STOP
+    }
+#endif /* MULADDC_HUIT */
+
+    t++;
+
+    do {
+        *d += c; c = ( *d < c ); d++;
+    }
+    while( c != 0 );
+}
+
+/*
+ * Baseline multiplication: X = A * B  (HAC 14.12)
+ */
+int mbedtls_mpi_mul_mpi( mbedtls_mpi *X, const mbedtls_mpi *A, const mbedtls_mpi *B )
+{
+    int ret;
+    size_t i, j;
+    mbedtls_mpi TA, TB;
+
+    mbedtls_mpi_init( &TA ); mbedtls_mpi_init( &TB );
+
+    if( X == A ) { MBEDTLS_MPI_CHK( mbedtls_mpi_copy( &TA, A ) ); A = &TA; }
+    if( X == B ) { MBEDTLS_MPI_CHK( mbedtls_mpi_copy( &TB, B ) ); B = &TB; }
+
+    for( i = A->n; i > 0; i-- )
+        if( A->p[i - 1] != 0 )
+            break;
+
+    for( j = B->n; j > 0; j-- )
+        if( B->p[j - 1] != 0 )
+            break;
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_grow( X, i + j ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_lset( X, 0 ) );
+
+    for( i++; j > 0; j-- )
+        mpi_mul_hlp( i - 1, A->p, X->p + j - 1, B->p[j - 1] );
+
+    X->s = A->s * B->s;
+
+cleanup:
+
+    mbedtls_mpi_free( &TB ); mbedtls_mpi_free( &TA );
+
+    return( ret );
+}
+
+/*
+ * Baseline multiplication: X = A * b
+ */
+int mbedtls_mpi_mul_int( mbedtls_mpi *X, const mbedtls_mpi *A, mbedtls_mpi_uint b )
+{
+    mbedtls_mpi _B;
+    mbedtls_mpi_uint p[1];
+
+    _B.s = 1;
+    _B.n = 1;
+    _B.p = p;
+    p[0] = b;
+
+    return( mbedtls_mpi_mul_mpi( X, A, &_B ) );
+}
+
+/*
+ * Unsigned integer divide - double mbedtls_mpi_uint dividend, u1/u0, and
+ * mbedtls_mpi_uint divisor, d
+ */
+static mbedtls_mpi_uint mbedtls_int_div_int( mbedtls_mpi_uint u1,
+            mbedtls_mpi_uint u0, mbedtls_mpi_uint d, mbedtls_mpi_uint *r )
+{
+#if defined(MBEDTLS_HAVE_UDBL)
+    mbedtls_t_udbl dividend, quotient;
+#else
+    const mbedtls_mpi_uint radix = (mbedtls_mpi_uint) 1 << biH;
+    const mbedtls_mpi_uint uint_halfword_mask = ( (mbedtls_mpi_uint) 1 << biH ) - 1;
+    mbedtls_mpi_uint d0, d1, q0, q1, rAX, r0, quotient;
+    mbedtls_mpi_uint u0_msw, u0_lsw;
+    size_t s;
+#endif
+
+    /*
+     * Check for overflow
+     */
+    if( 0 == d || u1 >= d )
+    {
+        if (r != NULL) *r = ~0;
+
+        return ( ~0 );
+    }
+
+#if defined(MBEDTLS_HAVE_UDBL)
+    dividend  = (mbedtls_t_udbl) u1 << biL;
+    dividend |= (mbedtls_t_udbl) u0;
+    quotient = dividend / d;
+    if( quotient > ( (mbedtls_t_udbl) 1 << biL ) - 1 )
+        quotient = ( (mbedtls_t_udbl) 1 << biL ) - 1;
+
+    if( r != NULL )
+        *r = (mbedtls_mpi_uint)( dividend - (quotient * d ) );
+
+    return (mbedtls_mpi_uint) quotient;
+#else
+
+    /*
+     * Algorithm D, Section 4.3.1 - The Art of Computer Programming
+     *   Vol. 2 - Seminumerical Algorithms, Knuth
+     */
+
+    /*
+     * Normalize the divisor, d, and dividend, u0, u1
+     */
+    s = mbedtls_clz( d );
+    d = d << s;
+
+    u1 = u1 << s;
+    u1 |= ( u0 >> ( biL - s ) ) & ( -(mbedtls_mpi_sint)s >> ( biL - 1 ) );
+    u0 =  u0 << s;
+
+    d1 = d >> biH;
+    d0 = d & uint_halfword_mask;
+
+    u0_msw = u0 >> biH;
+    u0_lsw = u0 & uint_halfword_mask;
+
+    /*
+     * Find the first quotient and remainder
+     */
+    q1 = u1 / d1;
+    r0 = u1 - d1 * q1;
+
+    while( q1 >= radix || ( q1 * d0 > radix * r0 + u0_msw ) )
+    {
+        q1 -= 1;
+        r0 += d1;
+
+        if ( r0 >= radix ) break;
+    }
+
+    rAX = ( u1 * radix ) + ( u0_msw - q1 * d );
+    q0 = rAX / d1;
+    r0 = rAX - q0 * d1;
+
+    while( q0 >= radix || ( q0 * d0 > radix * r0 + u0_lsw ) )
+    {
+        q0 -= 1;
+        r0 += d1;
+
+        if ( r0 >= radix ) break;
+    }
+
+    if (r != NULL)
+        *r = ( rAX * radix + u0_lsw - q0 * d ) >> s;
+
+    quotient = q1 * radix + q0;
+
+    return quotient;
+#endif
+}
+
+/*
+ * Division by mbedtls_mpi: A = Q * B + R  (HAC 14.20)
+ */
+int mbedtls_mpi_div_mpi( mbedtls_mpi *Q, mbedtls_mpi *R, const mbedtls_mpi *A, const mbedtls_mpi *B )
+{
+    int ret;
+    size_t i, n, t, k;
+    mbedtls_mpi X, Y, Z, T1, T2;
+
+    if( mbedtls_mpi_cmp_int( B, 0 ) == 0 )
+        return( MBEDTLS_ERR_MPI_DIVISION_BY_ZERO );
+
+    mbedtls_mpi_init( &X ); mbedtls_mpi_init( &Y ); mbedtls_mpi_init( &Z );
+    mbedtls_mpi_init( &T1 ); mbedtls_mpi_init( &T2 );
+
+    if( mbedtls_mpi_cmp_abs( A, B ) < 0 )
+    {
+        if( Q != NULL ) MBEDTLS_MPI_CHK( mbedtls_mpi_lset( Q, 0 ) );
+        if( R != NULL ) MBEDTLS_MPI_CHK( mbedtls_mpi_copy( R, A ) );
+        return( 0 );
+    }
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_copy( &X, A ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_copy( &Y, B ) );
+    X.s = Y.s = 1;
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_grow( &Z, A->n + 2 ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_lset( &Z,  0 ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_grow( &T1, 2 ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_grow( &T2, 3 ) );
+
+    k = mbedtls_mpi_bitlen( &Y ) % biL;
+    if( k < biL - 1 )
+    {
+        k = biL - 1 - k;
+        MBEDTLS_MPI_CHK( mbedtls_mpi_shift_l( &X, k ) );
+        MBEDTLS_MPI_CHK( mbedtls_mpi_shift_l( &Y, k ) );
+    }
+    else k = 0;
+
+    n = X.n - 1;
+    t = Y.n - 1;
+    MBEDTLS_MPI_CHK( mbedtls_mpi_shift_l( &Y, biL * ( n - t ) ) );
+
+    while( mbedtls_mpi_cmp_mpi( &X, &Y ) >= 0 )
+    {
+        Z.p[n - t]++;
+        MBEDTLS_MPI_CHK( mbedtls_mpi_sub_mpi( &X, &X, &Y ) );
+    }
+    MBEDTLS_MPI_CHK( mbedtls_mpi_shift_r( &Y, biL * ( n - t ) ) );
+
+    for( i = n; i > t ; i-- )
+    {
+        if( X.p[i] >= Y.p[t] )
+            Z.p[i - t - 1] = ~0;
+        else
+        {
+            Z.p[i - t - 1] = mbedtls_int_div_int( X.p[i], X.p[i - 1],
+                                                            Y.p[t], NULL);
+        }
+
+        Z.p[i - t - 1]++;
+        do
+        {
+            Z.p[i - t - 1]--;
+
+            MBEDTLS_MPI_CHK( mbedtls_mpi_lset( &T1, 0 ) );
+            T1.p[0] = ( t < 1 ) ? 0 : Y.p[t - 1];
+            T1.p[1] = Y.p[t];
+            MBEDTLS_MPI_CHK( mbedtls_mpi_mul_int( &T1, &T1, Z.p[i - t - 1] ) );
+
+            MBEDTLS_MPI_CHK( mbedtls_mpi_lset( &T2, 0 ) );
+            T2.p[0] = ( i < 2 ) ? 0 : X.p[i - 2];
+            T2.p[1] = ( i < 1 ) ? 0 : X.p[i - 1];
+            T2.p[2] = X.p[i];
+        }
+        while( mbedtls_mpi_cmp_mpi( &T1, &T2 ) > 0 );
+
+        MBEDTLS_MPI_CHK( mbedtls_mpi_mul_int( &T1, &Y, Z.p[i - t - 1] ) );
+        MBEDTLS_MPI_CHK( mbedtls_mpi_shift_l( &T1,  biL * ( i - t - 1 ) ) );
+        MBEDTLS_MPI_CHK( mbedtls_mpi_sub_mpi( &X, &X, &T1 ) );
+
+        if( mbedtls_mpi_cmp_int( &X, 0 ) < 0 )
+        {
+            MBEDTLS_MPI_CHK( mbedtls_mpi_copy( &T1, &Y ) );
+            MBEDTLS_MPI_CHK( mbedtls_mpi_shift_l( &T1, biL * ( i - t - 1 ) ) );
+            MBEDTLS_MPI_CHK( mbedtls_mpi_add_mpi( &X, &X, &T1 ) );
+            Z.p[i - t - 1]--;
+        }
+    }
+
+    if( Q != NULL )
+    {
+        MBEDTLS_MPI_CHK( mbedtls_mpi_copy( Q, &Z ) );
+        Q->s = A->s * B->s;
+    }
+
+    if( R != NULL )
+    {
+        MBEDTLS_MPI_CHK( mbedtls_mpi_shift_r( &X, k ) );
+        X.s = A->s;
+        MBEDTLS_MPI_CHK( mbedtls_mpi_copy( R, &X ) );
+
+        if( mbedtls_mpi_cmp_int( R, 0 ) == 0 )
+            R->s = 1;
+    }
+
+cleanup:
+
+    mbedtls_mpi_free( &X ); mbedtls_mpi_free( &Y ); mbedtls_mpi_free( &Z );
+    mbedtls_mpi_free( &T1 ); mbedtls_mpi_free( &T2 );
+
+    return( ret );
+}
+
+/*
+ * Division by int: A = Q * b + R
+ */
+int mbedtls_mpi_div_int( mbedtls_mpi *Q, mbedtls_mpi *R, const mbedtls_mpi *A, mbedtls_mpi_sint b )
+{
+    mbedtls_mpi _B;
+    mbedtls_mpi_uint p[1];
+
+    p[0] = ( b < 0 ) ? -b : b;
+    _B.s = ( b < 0 ) ? -1 : 1;
+    _B.n = 1;
+    _B.p = p;
+
+    return( mbedtls_mpi_div_mpi( Q, R, A, &_B ) );
+}
+
+/*
+ * Modulo: R = A mod B
+ */
+int mbedtls_mpi_mod_mpi( mbedtls_mpi *R, const mbedtls_mpi *A, const mbedtls_mpi *B )
+{
+    int ret;
+
+    if( mbedtls_mpi_cmp_int( B, 0 ) < 0 )
+        return( MBEDTLS_ERR_MPI_NEGATIVE_VALUE );
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_div_mpi( NULL, R, A, B ) );
+
+    while( mbedtls_mpi_cmp_int( R, 0 ) < 0 )
+      MBEDTLS_MPI_CHK( mbedtls_mpi_add_mpi( R, R, B ) );
+
+    while( mbedtls_mpi_cmp_mpi( R, B ) >= 0 )
+      MBEDTLS_MPI_CHK( mbedtls_mpi_sub_mpi( R, R, B ) );
+
+cleanup:
+
+    return( ret );
+}
+
+/*
+ * Modulo: r = A mod b
+ */
+int mbedtls_mpi_mod_int( mbedtls_mpi_uint *r, const mbedtls_mpi *A, mbedtls_mpi_sint b )
+{
+    size_t i;
+    mbedtls_mpi_uint x, y, z;
+
+    if( b == 0 )
+        return( MBEDTLS_ERR_MPI_DIVISION_BY_ZERO );
+
+    if( b < 0 )
+        return( MBEDTLS_ERR_MPI_NEGATIVE_VALUE );
+
+    /*
+     * handle trivial cases
+     */
+    if( b == 1 )
+    {
+        *r = 0;
+        return( 0 );
+    }
+
+    if( b == 2 )
+    {
+        *r = A->p[0] & 1;
+        return( 0 );
+    }
+
+    /*
+     * general case
+     */
+    for( i = A->n, y = 0; i > 0; i-- )
+    {
+        x  = A->p[i - 1];
+        y  = ( y << biH ) | ( x >> biH );
+        z  = y / b;
+        y -= z * b;
+
+        x <<= biH;
+        y  = ( y << biH ) | ( x >> biH );
+        z  = y / b;
+        y -= z * b;
+    }
+
+    /*
+     * If A is negative, then the current y represents a negative value.
+     * Flipping it to the positive side.
+     */
+    if( A->s < 0 && y != 0 )
+        y = b - y;
+
+    *r = y;
+
+    return( 0 );
+}
+
+/*
+ * Fast Montgomery initialization (thanks to Tom St Denis)
+ */
+static void mpi_montg_init( mbedtls_mpi_uint *mm, const mbedtls_mpi *N )
+{
+    mbedtls_mpi_uint x, m0 = N->p[0];
+    unsigned int i;
+
+    x  = m0;
+    x += ( ( m0 + 2 ) & 4 ) << 1;
+
+    for( i = biL; i >= 8; i /= 2 )
+        x *= ( 2 - ( m0 * x ) );
+
+    *mm = ~x + 1;
+}
+
+/*
+ * Montgomery multiplication: A = A * B * R^-1 mod N  (HAC 14.36)
+ */
+static int mpi_montmul( mbedtls_mpi *A, const mbedtls_mpi *B, const mbedtls_mpi *N, mbedtls_mpi_uint mm,
+                         const mbedtls_mpi *T )
+{
+    size_t i, n, m;
+    mbedtls_mpi_uint u0, u1, *d;
+
+    if( T->n < N->n + 1 || T->p == NULL )
+        return( MBEDTLS_ERR_MPI_BAD_INPUT_DATA );
+
+    memset( T->p, 0, T->n * ciL );
+
+    d = T->p;
+    n = N->n;
+    m = ( B->n < n ) ? B->n : n;
+
+    for( i = 0; i < n; i++ )
+    {
+        /*
+         * T = (T + u0*B + u1*N) / 2^biL
+         */
+        u0 = A->p[i];
+        u1 = ( d[0] + u0 * B->p[0] ) * mm;
+
+        mpi_mul_hlp( m, B->p, d, u0 );
+        mpi_mul_hlp( n, N->p, d, u1 );
+
+        *d++ = u0; d[n + 1] = 0;
+    }
+
+    memcpy( A->p, d, ( n + 1 ) * ciL );
+
+    if( mbedtls_mpi_cmp_abs( A, N ) >= 0 )
+        mpi_sub_hlp( n, N->p, A->p );
+    else
+        /* prevent timing attacks */
+        mpi_sub_hlp( n, A->p, T->p );
+
+    return( 0 );
+}
+
+/*
+ * Montgomery reduction: A = A * R^-1 mod N
+ */
+static int mpi_montred( mbedtls_mpi *A, const mbedtls_mpi *N, mbedtls_mpi_uint mm, const mbedtls_mpi *T )
+{
+    mbedtls_mpi_uint z = 1;
+    mbedtls_mpi U;
+
+    U.n = U.s = (int) z;
+    U.p = &z;
+
+    return( mpi_montmul( A, &U, N, mm, T ) );
+}
+
+/*
+ * Sliding-window exponentiation: X = A^E mod N  (HAC 14.85)
+ */
+int mbedtls_mpi_exp_mod( mbedtls_mpi *X, const mbedtls_mpi *A, const mbedtls_mpi *E, const mbedtls_mpi *N, mbedtls_mpi *_RR )
+{
+    int ret;
+    size_t wbits, wsize, one = 1;
+    size_t i, j, nblimbs;
+    size_t bufsize, nbits;
+    mbedtls_mpi_uint ei, mm, state;
+    mbedtls_mpi RR, T, W[ 2 << MBEDTLS_MPI_WINDOW_SIZE ], Apos;
+    int neg;
+
+    if( mbedtls_mpi_cmp_int( N, 0 ) < 0 || ( N->p[0] & 1 ) == 0 )
+        return( MBEDTLS_ERR_MPI_BAD_INPUT_DATA );
+
+    if( mbedtls_mpi_cmp_int( E, 0 ) < 0 )
+        return( MBEDTLS_ERR_MPI_BAD_INPUT_DATA );
+
+    /*
+     * Init temps and window size
+     */
+    mpi_montg_init( &mm, N );
+    mbedtls_mpi_init( &RR ); mbedtls_mpi_init( &T );
+    mbedtls_mpi_init( &Apos );
+    memset( W, 0, sizeof( W ) );
+
+    i = mbedtls_mpi_bitlen( E );
+
+    wsize = ( i > 671 ) ? 6 : ( i > 239 ) ? 5 :
+            ( i >  79 ) ? 4 : ( i >  23 ) ? 3 : 1;
+
+    if( wsize > MBEDTLS_MPI_WINDOW_SIZE )
+        wsize = MBEDTLS_MPI_WINDOW_SIZE;
+
+    j = N->n + 1;
+    MBEDTLS_MPI_CHK( mbedtls_mpi_grow( X, j ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_grow( &W[1],  j ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_grow( &T, j * 2 ) );
+
+    /*
+     * Compensate for negative A (and correct at the end)
+     */
+    neg = ( A->s == -1 );
+    if( neg )
+    {
+        MBEDTLS_MPI_CHK( mbedtls_mpi_copy( &Apos, A ) );
+        Apos.s = 1;
+        A = &Apos;
+    }
+
+    /*
+     * If 1st call, pre-compute R^2 mod N
+     */
+    if( _RR == NULL || _RR->p == NULL )
+    {
+        MBEDTLS_MPI_CHK( mbedtls_mpi_lset( &RR, 1 ) );
+        MBEDTLS_MPI_CHK( mbedtls_mpi_shift_l( &RR, N->n * 2 * biL ) );
+        MBEDTLS_MPI_CHK( mbedtls_mpi_mod_mpi( &RR, &RR, N ) );
+
+        if( _RR != NULL )
+            memcpy( _RR, &RR, sizeof( mbedtls_mpi ) );
+    }
+    else
+        memcpy( &RR, _RR, sizeof( mbedtls_mpi ) );
+
+    /*
+     * W[1] = A * R^2 * R^-1 mod N = A * R mod N
+     */
+    if( mbedtls_mpi_cmp_mpi( A, N ) >= 0 )
+        MBEDTLS_MPI_CHK( mbedtls_mpi_mod_mpi( &W[1], A, N ) );
+    else
+        MBEDTLS_MPI_CHK( mbedtls_mpi_copy( &W[1], A ) );
+
+    MBEDTLS_MPI_CHK( mpi_montmul( &W[1], &RR, N, mm, &T ) );
+
+    /*
+     * X = R^2 * R^-1 mod N = R mod N
+     */
+    MBEDTLS_MPI_CHK( mbedtls_mpi_copy( X, &RR ) );
+    MBEDTLS_MPI_CHK( mpi_montred( X, N, mm, &T ) );
+
+    if( wsize > 1 )
+    {
+        /*
+         * W[1 << (wsize - 1)] = W[1] ^ (wsize - 1)
+         */
+        j =  one << ( wsize - 1 );
+
+        MBEDTLS_MPI_CHK( mbedtls_mpi_grow( &W[j], N->n + 1 ) );
+        MBEDTLS_MPI_CHK( mbedtls_mpi_copy( &W[j], &W[1]    ) );
+
+        for( i = 0; i < wsize - 1; i++ )
+            MBEDTLS_MPI_CHK( mpi_montmul( &W[j], &W[j], N, mm, &T ) );
+
+        /*
+         * W[i] = W[i - 1] * W[1]
+         */
+        for( i = j + 1; i < ( one << wsize ); i++ )
+        {
+            MBEDTLS_MPI_CHK( mbedtls_mpi_grow( &W[i], N->n + 1 ) );
+            MBEDTLS_MPI_CHK( mbedtls_mpi_copy( &W[i], &W[i - 1] ) );
+
+            MBEDTLS_MPI_CHK( mpi_montmul( &W[i], &W[1], N, mm, &T ) );
+        }
+    }
+
+    nblimbs = E->n;
+    bufsize = 0;
+    nbits   = 0;
+    wbits   = 0;
+    state   = 0;
+
+    while( 1 )
+    {
+        if( bufsize == 0 )
+        {
+            if( nblimbs == 0 )
+                break;
+
+            nblimbs--;
+
+            bufsize = sizeof( mbedtls_mpi_uint ) << 3;
+        }
+
+        bufsize--;
+
+        ei = (E->p[nblimbs] >> bufsize) & 1;
+
+        /*
+         * skip leading 0s
+         */
+        if( ei == 0 && state == 0 )
+            continue;
+
+        if( ei == 0 && state == 1 )
+        {
+            /*
+             * out of window, square X
+             */
+            MBEDTLS_MPI_CHK( mpi_montmul( X, X, N, mm, &T ) );
+            continue;
+        }
+
+        /*
+         * add ei to current window
+         */
+        state = 2;
+
+        nbits++;
+        wbits |= ( ei << ( wsize - nbits ) );
+
+        if( nbits == wsize )
+        {
+            /*
+             * X = X^wsize R^-1 mod N
+             */
+            for( i = 0; i < wsize; i++ )
+                MBEDTLS_MPI_CHK( mpi_montmul( X, X, N, mm, &T ) );
+
+            /*
+             * X = X * W[wbits] R^-1 mod N
+             */
+            MBEDTLS_MPI_CHK( mpi_montmul( X, &W[wbits], N, mm, &T ) );
+
+            state--;
+            nbits = 0;
+            wbits = 0;
+        }
+    }
+
+    /*
+     * process the remaining bits
+     */
+    for( i = 0; i < nbits; i++ )
+    {
+        MBEDTLS_MPI_CHK( mpi_montmul( X, X, N, mm, &T ) );
+
+        wbits <<= 1;
+
+        if( ( wbits & ( one << wsize ) ) != 0 )
+            MBEDTLS_MPI_CHK( mpi_montmul( X, &W[1], N, mm, &T ) );
+    }
+
+    /*
+     * X = A^E * R * R^-1 mod N = A^E mod N
+     */
+    MBEDTLS_MPI_CHK( mpi_montred( X, N, mm, &T ) );
+
+    if( neg && E->n != 0 && ( E->p[0] & 1 ) != 0 )
+    {
+        X->s = -1;
+        MBEDTLS_MPI_CHK( mbedtls_mpi_add_mpi( X, N, X ) );
+    }
+
+cleanup:
+
+    for( i = ( one << ( wsize - 1 ) ); i < ( one << wsize ); i++ )
+        mbedtls_mpi_free( &W[i] );
+
+    mbedtls_mpi_free( &W[1] ); mbedtls_mpi_free( &T ); mbedtls_mpi_free( &Apos );
+
+    if( _RR == NULL || _RR->p == NULL )
+        mbedtls_mpi_free( &RR );
+
+    return( ret );
+}
+
+/*
+ * Greatest common divisor: G = gcd(A, B)  (HAC 14.54)
+ */
+int mbedtls_mpi_gcd( mbedtls_mpi *G, const mbedtls_mpi *A, const mbedtls_mpi *B )
+{
+    int ret;
+    size_t lz, lzt;
+    mbedtls_mpi TG, TA, TB;
+
+    mbedtls_mpi_init( &TG ); mbedtls_mpi_init( &TA ); mbedtls_mpi_init( &TB );
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_copy( &TA, A ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_copy( &TB, B ) );
+
+    lz = mbedtls_mpi_lsb( &TA );
+    lzt = mbedtls_mpi_lsb( &TB );
+
+    if( lzt < lz )
+        lz = lzt;
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_shift_r( &TA, lz ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_shift_r( &TB, lz ) );
+
+    TA.s = TB.s = 1;
+
+    while( mbedtls_mpi_cmp_int( &TA, 0 ) != 0 )
+    {
+        MBEDTLS_MPI_CHK( mbedtls_mpi_shift_r( &TA, mbedtls_mpi_lsb( &TA ) ) );
+        MBEDTLS_MPI_CHK( mbedtls_mpi_shift_r( &TB, mbedtls_mpi_lsb( &TB ) ) );
+
+        if( mbedtls_mpi_cmp_mpi( &TA, &TB ) >= 0 )
+        {
+            MBEDTLS_MPI_CHK( mbedtls_mpi_sub_abs( &TA, &TA, &TB ) );
+            MBEDTLS_MPI_CHK( mbedtls_mpi_shift_r( &TA, 1 ) );
+        }
+        else
+        {
+            MBEDTLS_MPI_CHK( mbedtls_mpi_sub_abs( &TB, &TB, &TA ) );
+            MBEDTLS_MPI_CHK( mbedtls_mpi_shift_r( &TB, 1 ) );
+        }
+    }
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_shift_l( &TB, lz ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_copy( G, &TB ) );
+
+cleanup:
+
+    mbedtls_mpi_free( &TG ); mbedtls_mpi_free( &TA ); mbedtls_mpi_free( &TB );
+
+    return( ret );
+}
+
+/*
+ * Fill X with size bytes of random.
+ *
+ * Use a temporary bytes representation to make sure the result is the same
+ * regardless of the platform endianness (useful when f_rng is actually
+ * deterministic, eg for tests).
+ */
+int mbedtls_mpi_fill_random( mbedtls_mpi *X, size_t size,
+                     int (*f_rng)(void *, unsigned char *, size_t),
+                     void *p_rng )
+{
+    int ret;
+    unsigned char buf[MBEDTLS_MPI_MAX_SIZE];
+
+    if( size > MBEDTLS_MPI_MAX_SIZE )
+        return( MBEDTLS_ERR_MPI_BAD_INPUT_DATA );
+
+    MBEDTLS_MPI_CHK( f_rng( p_rng, buf, size ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_read_binary( X, buf, size ) );
+
+cleanup:
+    return( ret );
+}
+
+/*
+ * Modular inverse: X = A^-1 mod N  (HAC 14.61 / 14.64)
+ */
+int mbedtls_mpi_inv_mod( mbedtls_mpi *X, const mbedtls_mpi *A, const mbedtls_mpi *N )
+{
+    int ret;
+    mbedtls_mpi G, TA, TU, U1, U2, TB, TV, V1, V2;
+
+    if( mbedtls_mpi_cmp_int( N, 1 ) <= 0 )
+        return( MBEDTLS_ERR_MPI_BAD_INPUT_DATA );
+
+    mbedtls_mpi_init( &TA ); mbedtls_mpi_init( &TU ); mbedtls_mpi_init( &U1 ); mbedtls_mpi_init( &U2 );
+    mbedtls_mpi_init( &G ); mbedtls_mpi_init( &TB ); mbedtls_mpi_init( &TV );
+    mbedtls_mpi_init( &V1 ); mbedtls_mpi_init( &V2 );
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_gcd( &G, A, N ) );
+
+    if( mbedtls_mpi_cmp_int( &G, 1 ) != 0 )
+    {
+        ret = MBEDTLS_ERR_MPI_NOT_ACCEPTABLE;
+        goto cleanup;
+    }
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_mod_mpi( &TA, A, N ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_copy( &TU, &TA ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_copy( &TB, N ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_copy( &TV, N ) );
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_lset( &U1, 1 ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_lset( &U2, 0 ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_lset( &V1, 0 ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_lset( &V2, 1 ) );
+
+    do
+    {
+        while( ( TU.p[0] & 1 ) == 0 )
+        {
+            MBEDTLS_MPI_CHK( mbedtls_mpi_shift_r( &TU, 1 ) );
+
+            if( ( U1.p[0] & 1 ) != 0 || ( U2.p[0] & 1 ) != 0 )
+            {
+                MBEDTLS_MPI_CHK( mbedtls_mpi_add_mpi( &U1, &U1, &TB ) );
+                MBEDTLS_MPI_CHK( mbedtls_mpi_sub_mpi( &U2, &U2, &TA ) );
+            }
+
+            MBEDTLS_MPI_CHK( mbedtls_mpi_shift_r( &U1, 1 ) );
+            MBEDTLS_MPI_CHK( mbedtls_mpi_shift_r( &U2, 1 ) );
+        }
+
+        while( ( TV.p[0] & 1 ) == 0 )
+        {
+            MBEDTLS_MPI_CHK( mbedtls_mpi_shift_r( &TV, 1 ) );
+
+            if( ( V1.p[0] & 1 ) != 0 || ( V2.p[0] & 1 ) != 0 )
+            {
+                MBEDTLS_MPI_CHK( mbedtls_mpi_add_mpi( &V1, &V1, &TB ) );
+                MBEDTLS_MPI_CHK( mbedtls_mpi_sub_mpi( &V2, &V2, &TA ) );
+            }
+
+            MBEDTLS_MPI_CHK( mbedtls_mpi_shift_r( &V1, 1 ) );
+            MBEDTLS_MPI_CHK( mbedtls_mpi_shift_r( &V2, 1 ) );
+        }
+
+        if( mbedtls_mpi_cmp_mpi( &TU, &TV ) >= 0 )
+        {
+            MBEDTLS_MPI_CHK( mbedtls_mpi_sub_mpi( &TU, &TU, &TV ) );
+            MBEDTLS_MPI_CHK( mbedtls_mpi_sub_mpi( &U1, &U1, &V1 ) );
+            MBEDTLS_MPI_CHK( mbedtls_mpi_sub_mpi( &U2, &U2, &V2 ) );
+        }
+        else
+        {
+            MBEDTLS_MPI_CHK( mbedtls_mpi_sub_mpi( &TV, &TV, &TU ) );
+            MBEDTLS_MPI_CHK( mbedtls_mpi_sub_mpi( &V1, &V1, &U1 ) );
+            MBEDTLS_MPI_CHK( mbedtls_mpi_sub_mpi( &V2, &V2, &U2 ) );
+        }
+    }
+    while( mbedtls_mpi_cmp_int( &TU, 0 ) != 0 );
+
+    while( mbedtls_mpi_cmp_int( &V1, 0 ) < 0 )
+        MBEDTLS_MPI_CHK( mbedtls_mpi_add_mpi( &V1, &V1, N ) );
+
+    while( mbedtls_mpi_cmp_mpi( &V1, N ) >= 0 )
+        MBEDTLS_MPI_CHK( mbedtls_mpi_sub_mpi( &V1, &V1, N ) );
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_copy( X, &V1 ) );
+
+cleanup:
+
+    mbedtls_mpi_free( &TA ); mbedtls_mpi_free( &TU ); mbedtls_mpi_free( &U1 ); mbedtls_mpi_free( &U2 );
+    mbedtls_mpi_free( &G ); mbedtls_mpi_free( &TB ); mbedtls_mpi_free( &TV );
+    mbedtls_mpi_free( &V1 ); mbedtls_mpi_free( &V2 );
+
+    return( ret );
+}
+
+#if defined(MBEDTLS_GENPRIME)
+
+static const int small_prime[] =
+{
+        3,    5,    7,   11,   13,   17,   19,   23,
+       29,   31,   37,   41,   43,   47,   53,   59,
+       61,   67,   71,   73,   79,   83,   89,   97,
+      101,  103,  107,  109,  113,  127,  131,  137,
+      139,  149,  151,  157,  163,  167,  173,  179,
+      181,  191,  193,  197,  199,  211,  223,  227,
+      229,  233,  239,  241,  251,  257,  263,  269,
+      271,  277,  281,  283,  293,  307,  311,  313,
+      317,  331,  337,  347,  349,  353,  359,  367,
+      373,  379,  383,  389,  397,  401,  409,  419,
+      421,  431,  433,  439,  443,  449,  457,  461,
+      463,  467,  479,  487,  491,  499,  503,  509,
+      521,  523,  541,  547,  557,  563,  569,  571,
+      577,  587,  593,  599,  601,  607,  613,  617,
+      619,  631,  641,  643,  647,  653,  659,  661,
+      673,  677,  683,  691,  701,  709,  719,  727,
+      733,  739,  743,  751,  757,  761,  769,  773,
+      787,  797,  809,  811,  821,  823,  827,  829,
+      839,  853,  857,  859,  863,  877,  881,  883,
+      887,  907,  911,  919,  929,  937,  941,  947,
+      953,  967,  971,  977,  983,  991,  997, -103
+};
+
+/*
+ * Small divisors test (X must be positive)
+ *
+ * Return values:
+ * 0: no small factor (possible prime, more tests needed)
+ * 1: certain prime
+ * MBEDTLS_ERR_MPI_NOT_ACCEPTABLE: certain non-prime
+ * other negative: error
+ */
+static int mpi_check_small_factors( const mbedtls_mpi *X )
+{
+    int ret = 0;
+    size_t i;
+    mbedtls_mpi_uint r;
+
+    if( ( X->p[0] & 1 ) == 0 )
+        return( MBEDTLS_ERR_MPI_NOT_ACCEPTABLE );
+
+    for( i = 0; small_prime[i] > 0; i++ )
+    {
+        if( mbedtls_mpi_cmp_int( X, small_prime[i] ) <= 0 )
+            return( 1 );
+
+        MBEDTLS_MPI_CHK( mbedtls_mpi_mod_int( &r, X, small_prime[i] ) );
+
+        if( r == 0 )
+            return( MBEDTLS_ERR_MPI_NOT_ACCEPTABLE );
+    }
+
+cleanup:
+    return( ret );
+}
+
+/*
+ * Miller-Rabin pseudo-primality test  (HAC 4.24)
+ */
+static int mpi_miller_rabin( const mbedtls_mpi *X,
+                             int (*f_rng)(void *, unsigned char *, size_t),
+                             void *p_rng )
+{
+    int ret, count;
+    size_t i, j, k, n, s;
+    mbedtls_mpi W, R, T, A, RR;
+
+    mbedtls_mpi_init( &W ); mbedtls_mpi_init( &R ); mbedtls_mpi_init( &T ); mbedtls_mpi_init( &A );
+    mbedtls_mpi_init( &RR );
+
+    /*
+     * W = |X| - 1
+     * R = W >> lsb( W )
+     */
+    MBEDTLS_MPI_CHK( mbedtls_mpi_sub_int( &W, X, 1 ) );
+    s = mbedtls_mpi_lsb( &W );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_copy( &R, &W ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_shift_r( &R, s ) );
+
+    i = mbedtls_mpi_bitlen( X );
+    /*
+     * HAC, table 4.4
+     */
+    n = ( ( i >= 1300 ) ?  2 : ( i >=  850 ) ?  3 :
+          ( i >=  650 ) ?  4 : ( i >=  350 ) ?  8 :
+          ( i >=  250 ) ? 12 : ( i >=  150 ) ? 18 : 27 );
+
+    for( i = 0; i < n; i++ )
+    {
+        /*
+         * pick a random A, 1 < A < |X| - 1
+         */
+        MBEDTLS_MPI_CHK( mbedtls_mpi_fill_random( &A, X->n * ciL, f_rng, p_rng ) );
+
+        if( mbedtls_mpi_cmp_mpi( &A, &W ) >= 0 )
+        {
+            j = mbedtls_mpi_bitlen( &A ) - mbedtls_mpi_bitlen( &W );
+            MBEDTLS_MPI_CHK( mbedtls_mpi_shift_r( &A, j + 1 ) );
+        }
+        A.p[0] |= 3;
+
+        count = 0;
+        do {
+            MBEDTLS_MPI_CHK( mbedtls_mpi_fill_random( &A, X->n * ciL, f_rng, p_rng ) );
+
+            j = mbedtls_mpi_bitlen( &A );
+            k = mbedtls_mpi_bitlen( &W );
+            if (j > k) {
+                MBEDTLS_MPI_CHK( mbedtls_mpi_shift_r( &A, j - k ) );
+            }
+
+            if (count++ > 30) {
+                return MBEDTLS_ERR_MPI_NOT_ACCEPTABLE;
+            }
+
+        } while ( mbedtls_mpi_cmp_mpi( &A, &W ) >= 0 ||
+                  mbedtls_mpi_cmp_int( &A, 1 )  <= 0    );
+
+        /*
+         * A = A^R mod |X|
+         */
+        MBEDTLS_MPI_CHK( mbedtls_mpi_exp_mod( &A, &A, &R, X, &RR ) );
+
+        if( mbedtls_mpi_cmp_mpi( &A, &W ) == 0 ||
+            mbedtls_mpi_cmp_int( &A,  1 ) == 0 )
+            continue;
+
+        j = 1;
+        while( j < s && mbedtls_mpi_cmp_mpi( &A, &W ) != 0 )
+        {
+            /*
+             * A = A * A mod |X|
+             */
+            MBEDTLS_MPI_CHK( mbedtls_mpi_mul_mpi( &T, &A, &A ) );
+            MBEDTLS_MPI_CHK( mbedtls_mpi_mod_mpi( &A, &T, X  ) );
+
+            if( mbedtls_mpi_cmp_int( &A, 1 ) == 0 )
+                break;
+
+            j++;
+        }
+
+        /*
+         * not prime if A != |X| - 1 or A == 1
+         */
+        if( mbedtls_mpi_cmp_mpi( &A, &W ) != 0 ||
+            mbedtls_mpi_cmp_int( &A,  1 ) == 0 )
+        {
+            ret = MBEDTLS_ERR_MPI_NOT_ACCEPTABLE;
+            break;
+        }
+    }
+
+cleanup:
+    mbedtls_mpi_free( &W ); mbedtls_mpi_free( &R ); mbedtls_mpi_free( &T ); mbedtls_mpi_free( &A );
+    mbedtls_mpi_free( &RR );
+
+    return( ret );
+}
+
+/*
+ * Pseudo-primality test: small factors, then Miller-Rabin
+ */
+int mbedtls_mpi_is_prime( const mbedtls_mpi *X,
+                  int (*f_rng)(void *, unsigned char *, size_t),
+                  void *p_rng )
+{
+    int ret;
+    mbedtls_mpi XX;
+
+    XX.s = 1;
+    XX.n = X->n;
+    XX.p = X->p;
+
+    if( mbedtls_mpi_cmp_int( &XX, 0 ) == 0 ||
+        mbedtls_mpi_cmp_int( &XX, 1 ) == 0 )
+        return( MBEDTLS_ERR_MPI_NOT_ACCEPTABLE );
+
+    if( mbedtls_mpi_cmp_int( &XX, 2 ) == 0 )
+        return( 0 );
+
+    if( ( ret = mpi_check_small_factors( &XX ) ) != 0 )
+    {
+        if( ret == 1 )
+            return( 0 );
+
+        return( ret );
+    }
+
+    return( mpi_miller_rabin( &XX, f_rng, p_rng ) );
+}
+
+/*
+ * Prime number generation
+ */
+int mbedtls_mpi_gen_prime( mbedtls_mpi *X, size_t nbits, int dh_flag,
+                   int (*f_rng)(void *, unsigned char *, size_t),
+                   void *p_rng )
+{
+    int ret;
+    size_t k, n;
+    mbedtls_mpi_uint r;
+    mbedtls_mpi Y;
+
+    if( nbits < 3 || nbits > MBEDTLS_MPI_MAX_BITS )
+        return( MBEDTLS_ERR_MPI_BAD_INPUT_DATA );
+
+    mbedtls_mpi_init( &Y );
+
+    n = BITS_TO_LIMBS( nbits );
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_fill_random( X, n * ciL, f_rng, p_rng ) );
+
+    k = mbedtls_mpi_bitlen( X );
+    if( k > nbits ) MBEDTLS_MPI_CHK( mbedtls_mpi_shift_r( X, k - nbits + 1 ) );
+
+    mbedtls_mpi_set_bit( X, nbits-1, 1 );
+
+    X->p[0] |= 1;
+
+    if( dh_flag == 0 )
+    {
+        while( ( ret = mbedtls_mpi_is_prime( X, f_rng, p_rng ) ) != 0 )
+        {
+            if( ret != MBEDTLS_ERR_MPI_NOT_ACCEPTABLE )
+                goto cleanup;
+
+            MBEDTLS_MPI_CHK( mbedtls_mpi_add_int( X, X, 2 ) );
+        }
+    }
+    else
+    {
+        /*
+         * An necessary condition for Y and X = 2Y + 1 to be prime
+         * is X = 2 mod 3 (which is equivalent to Y = 2 mod 3).
+         * Make sure it is satisfied, while keeping X = 3 mod 4
+         */
+
+        X->p[0] |= 2;
+
+        MBEDTLS_MPI_CHK( mbedtls_mpi_mod_int( &r, X, 3 ) );
+        if( r == 0 )
+            MBEDTLS_MPI_CHK( mbedtls_mpi_add_int( X, X, 8 ) );
+        else if( r == 1 )
+            MBEDTLS_MPI_CHK( mbedtls_mpi_add_int( X, X, 4 ) );
+
+        /* Set Y = (X-1) / 2, which is X / 2 because X is odd */
+        MBEDTLS_MPI_CHK( mbedtls_mpi_copy( &Y, X ) );
+        MBEDTLS_MPI_CHK( mbedtls_mpi_shift_r( &Y, 1 ) );
+
+        while( 1 )
+        {
+            /*
+             * First, check small factors for X and Y
+             * before doing Miller-Rabin on any of them
+             */
+            if( ( ret = mpi_check_small_factors(  X         ) ) == 0 &&
+                ( ret = mpi_check_small_factors( &Y         ) ) == 0 &&
+                ( ret = mpi_miller_rabin(  X, f_rng, p_rng  ) ) == 0 &&
+                ( ret = mpi_miller_rabin( &Y, f_rng, p_rng  ) ) == 0 )
+            {
+                break;
+            }
+
+            if( ret != MBEDTLS_ERR_MPI_NOT_ACCEPTABLE )
+                goto cleanup;
+
+            /*
+             * Next candidates. We want to preserve Y = (X-1) / 2 and
+             * Y = 1 mod 2 and Y = 2 mod 3 (eq X = 3 mod 4 and X = 2 mod 3)
+             * so up Y by 6 and X by 12.
+             */
+            MBEDTLS_MPI_CHK( mbedtls_mpi_add_int(  X,  X, 12 ) );
+            MBEDTLS_MPI_CHK( mbedtls_mpi_add_int( &Y, &Y, 6  ) );
+        }
+    }
+
+cleanup:
+
+    mbedtls_mpi_free( &Y );
+
+    return( ret );
+}
+
+#endif /* MBEDTLS_GENPRIME */
+
+#if defined(MBEDTLS_SELF_TEST)
+
+#define GCD_PAIR_COUNT  3
+
+static const int gcd_pairs[GCD_PAIR_COUNT][3] =
+{
+    { 693, 609, 21 },
+    { 1764, 868, 28 },
+    { 768454923, 542167814, 1 }
+};
+
+/*
+ * Checkup routine
+ */
+int mbedtls_mpi_self_test( int verbose )
+{
+    int ret, i;
+    mbedtls_mpi A, E, N, X, Y, U, V;
+
+    mbedtls_mpi_init( &A ); mbedtls_mpi_init( &E ); mbedtls_mpi_init( &N ); mbedtls_mpi_init( &X );
+    mbedtls_mpi_init( &Y ); mbedtls_mpi_init( &U ); mbedtls_mpi_init( &V );
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_read_string( &A, 16,
+        "EFE021C2645FD1DC586E69184AF4A31E" \
+        "D5F53E93B5F123FA41680867BA110131" \
+        "944FE7952E2517337780CB0DB80E61AA" \
+        "E7C8DDC6C5C6AADEB34EB38A2F40D5E6" ) );
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_read_string( &E, 16,
+        "B2E7EFD37075B9F03FF989C7C5051C20" \
+        "34D2A323810251127E7BF8625A4F49A5" \
+        "F3E27F4DA8BD59C47D6DAABA4C8127BD" \
+        "5B5C25763222FEFCCFC38B832366C29E" ) );
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_read_string( &N, 16,
+        "0066A198186C18C10B2F5ED9B522752A" \
+        "9830B69916E535C8F047518A889A43A5" \
+        "94B6BED27A168D31D4A52F88925AA8F5" ) );
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_mul_mpi( &X, &A, &N ) );
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_read_string( &U, 16,
+        "602AB7ECA597A3D6B56FF9829A5E8B85" \
+        "9E857EA95A03512E2BAE7391688D264A" \
+        "A5663B0341DB9CCFD2C4C5F421FEC814" \
+        "8001B72E848A38CAE1C65F78E56ABDEF" \
+        "E12D3C039B8A02D6BE593F0BBBDA56F1" \
+        "ECF677152EF804370C1A305CAF3B5BF1" \
+        "30879B56C61DE584A0F53A2447A51E" ) );
+
+    if( verbose != 0 )
+        mbedtls_printf( "  MPI test #1 (mul_mpi): " );
+
+    if( mbedtls_mpi_cmp_mpi( &X, &U ) != 0 )
+    {
+        if( verbose != 0 )
+            mbedtls_printf( "failed\n" );
+
+        ret = 1;
+        goto cleanup;
+    }
+
+    if( verbose != 0 )
+        mbedtls_printf( "passed\n" );
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_div_mpi( &X, &Y, &A, &N ) );
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_read_string( &U, 16,
+        "256567336059E52CAE22925474705F39A94" ) );
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_read_string( &V, 16,
+        "6613F26162223DF488E9CD48CC132C7A" \
+        "0AC93C701B001B092E4E5B9F73BCD27B" \
+        "9EE50D0657C77F374E903CDFA4C642" ) );
+
+    if( verbose != 0 )
+        mbedtls_printf( "  MPI test #2 (div_mpi): " );
+
+    if( mbedtls_mpi_cmp_mpi( &X, &U ) != 0 ||
+        mbedtls_mpi_cmp_mpi( &Y, &V ) != 0 )
+    {
+        if( verbose != 0 )
+            mbedtls_printf( "failed\n" );
+
+        ret = 1;
+        goto cleanup;
+    }
+
+    if( verbose != 0 )
+        mbedtls_printf( "passed\n" );
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_exp_mod( &X, &A, &E, &N, NULL ) );
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_read_string( &U, 16,
+        "36E139AEA55215609D2816998ED020BB" \
+        "BD96C37890F65171D948E9BC7CBAA4D9" \
+        "325D24D6A3C12710F10A09FA08AB87" ) );
+
+    if( verbose != 0 )
+        mbedtls_printf( "  MPI test #3 (exp_mod): " );
+
+    if( mbedtls_mpi_cmp_mpi( &X, &U ) != 0 )
+    {
+        if( verbose != 0 )
+            mbedtls_printf( "failed\n" );
+
+        ret = 1;
+        goto cleanup;
+    }
+
+    if( verbose != 0 )
+        mbedtls_printf( "passed\n" );
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_inv_mod( &X, &A, &N ) );
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_read_string( &U, 16,
+        "003A0AAEDD7E784FC07D8F9EC6E3BFD5" \
+        "C3DBA76456363A10869622EAC2DD84EC" \
+        "C5B8A74DAC4D09E03B5E0BE779F2DF61" ) );
+
+    if( verbose != 0 )
+        mbedtls_printf( "  MPI test #4 (inv_mod): " );
+
+    if( mbedtls_mpi_cmp_mpi( &X, &U ) != 0 )
+    {
+        if( verbose != 0 )
+            mbedtls_printf( "failed\n" );
+
+        ret = 1;
+        goto cleanup;
+    }
+
+    if( verbose != 0 )
+        mbedtls_printf( "passed\n" );
+
+    if( verbose != 0 )
+        mbedtls_printf( "  MPI test #5 (simple gcd): " );
+
+    for( i = 0; i < GCD_PAIR_COUNT; i++ )
+    {
+        MBEDTLS_MPI_CHK( mbedtls_mpi_lset( &X, gcd_pairs[i][0] ) );
+        MBEDTLS_MPI_CHK( mbedtls_mpi_lset( &Y, gcd_pairs[i][1] ) );
+
+        MBEDTLS_MPI_CHK( mbedtls_mpi_gcd( &A, &X, &Y ) );
+
+        if( mbedtls_mpi_cmp_int( &A, gcd_pairs[i][2] ) != 0 )
+        {
+            if( verbose != 0 )
+                mbedtls_printf( "failed at %d\n", i );
+
+            ret = 1;
+            goto cleanup;
+        }
+    }
+
+    if( verbose != 0 )
+        mbedtls_printf( "passed\n" );
+
+cleanup:
+
+    if( ret != 0 && verbose != 0 )
+        mbedtls_printf( "Unexpected error, return code = %08X\n", ret );
+
+    mbedtls_mpi_free( &A ); mbedtls_mpi_free( &E ); mbedtls_mpi_free( &N ); mbedtls_mpi_free( &X );
+    mbedtls_mpi_free( &Y ); mbedtls_mpi_free( &U ); mbedtls_mpi_free( &V );
+
+    if( verbose != 0 )
+        mbedtls_printf( "\n" );
+
+    return( ret );
+}
+
+#endif /* MBEDTLS_SELF_TEST */
+
+#endif /* MBEDTLS_BIGNUM_C */
diff --git a/backport/compat/verification/key.c b/backport/compat/verification/key.c
new file mode 100644
index 000000000000..3a3c9bc596d5
--- /dev/null
+++ b/backport/compat/verification/key.c
@@ -0,0 +1,171 @@
+#include <linux/export.h>
+#include <linux/slab.h>
+#include <linux/key.h>
+#include <keys/asymmetric-type.h>
+#include "x509_parser.h"
+
+static void keyring_clear(struct key *keyring)
+{
+	struct key *key, *tmp;
+
+	if (!keyring->keyring)
+		return;
+
+	list_for_each_entry_safe(key, tmp, &keyring->list, list) {
+		WARN_ON(refcount_read(&key->refcount) > 1);
+		key_put(key);
+	}
+}
+
+void key_put(struct key *key)
+{
+	if (refcount_dec_and_test(&key->refcount)) {
+		keyring_clear(key);
+		list_del(&key->list);
+		kfree(key->description);
+		public_key_free(key->public_key);
+		public_key_signature_free(key->sig);
+		kfree(key->kids.id[0]);
+		kfree(key->kids.id[1]);
+		kfree(key);
+	}
+}
+EXPORT_SYMBOL_GPL(key_put);
+
+static struct key *key_alloc(void)
+{
+	struct key *key = kzalloc(sizeof(*key), GFP_KERNEL);
+
+	if (!key)
+		return NULL;
+	refcount_set(&key->refcount, 1);
+	INIT_LIST_HEAD(&key->list);
+
+	return key;
+}
+
+struct key *bp_keyring_alloc(void)
+{
+	struct key *key = key_alloc();
+
+	if (!key)
+		return NULL;
+
+	key->keyring = true;
+
+	return key;
+}
+EXPORT_SYMBOL_GPL(bp_keyring_alloc);
+
+key_ref_t bp_key_create_or_update(key_ref_t keyring,
+				  const char *description,
+				  const void *payload,
+				  size_t plen)
+{
+	struct key *key = key_alloc();
+	struct x509_certificate *cert;
+	const char *q;
+	size_t srlen, sulen;
+	char *desc = NULL, *p;
+	int err;
+
+	if (!key)
+		return NULL;
+
+	cert = x509_cert_parse(payload, plen);
+	if (IS_ERR(cert)) {
+		err = PTR_ERR(cert);
+		goto free;
+	}
+
+	if (cert->unsupported_sig) {
+		public_key_signature_free(cert->sig);
+		cert->sig = NULL;
+	}
+
+	sulen = strlen(cert->subject);
+	if (cert->raw_skid) {
+		srlen = cert->raw_skid_size;
+		q = cert->raw_skid;
+	} else {
+		srlen = cert->raw_serial_size;
+		q = cert->raw_serial;
+	}
+
+	err = -ENOMEM;
+	desc = kmalloc(sulen + 2 + srlen * 2 + 1, GFP_KERNEL);
+	if (!desc)
+		goto free;
+	p = memcpy(desc, cert->subject, sulen);
+	p += sulen;
+	*p++ = ':';
+	*p++ = ' ';
+	p = bin2hex(p, q, srlen);
+	*p = 0;
+	key->description = desc;
+
+	key->kids.id[0] = cert->id;
+	key->kids.id[1] = cert->skid;
+	key->public_key = cert->pub;
+	key->sig = cert->sig;
+
+	cert->id = NULL;
+	cert->skid = NULL;
+	cert->pub = NULL;
+	cert->sig = NULL;
+	x509_free_certificate(cert);
+
+	refcount_inc(&key->refcount);
+	list_add_tail(&key->list, &key_ref_to_ptr(keyring)->list);
+
+	return make_key_ref(key, 0);
+free:
+	kfree(key);
+	return ERR_PTR(err);
+}
+EXPORT_SYMBOL_GPL(bp_key_create_or_update);
+
+struct key *find_asymmetric_key(struct key *keyring,
+				const struct asymmetric_key_id *id_0,
+				const struct asymmetric_key_id *id_1,
+				bool partial)
+{
+	struct key *key;
+
+	if (WARN_ON(partial))
+		return ERR_PTR(-ENOENT);
+	if (WARN_ON(!keyring))
+		return ERR_PTR(-EINVAL);
+
+	list_for_each_entry(key, &keyring->list, list) {
+		const struct asymmetric_key_ids *kids = &key->kids;
+
+		if (id_0 && (!kids->id[0] ||
+			     !asymmetric_key_id_same(id_0, kids->id[0])))
+			continue;
+		if (id_1 && (!kids->id[1] ||
+			     !asymmetric_key_id_same(id_0, kids->id[1])))
+			continue;
+
+		refcount_inc(&key->refcount);
+		return key;
+	}
+
+	return ERR_PTR(-ENOKEY);
+}
+
+struct asymmetric_key_id *
+asymmetric_key_generate_id(const void *val_1, size_t len_1,
+			   const void *val_2, size_t len_2)
+{
+	struct asymmetric_key_id *kid;
+
+	kid = kmalloc(sizeof(struct asymmetric_key_id) + len_1 + len_2,
+		      GFP_KERNEL);
+	if (!kid)
+		return ERR_PTR(-ENOMEM);
+	kid->len = len_1 + len_2;
+	memcpy(kid->data, val_1, len_1);
+	memcpy(kid->data + len_1, val_2, len_2);
+	return kid;
+}
diff --git a/backport/compat/verification/mbedtls/asn1.h b/backport/compat/verification/mbedtls/asn1.h
new file mode 100644
index 000000000000..bc6b48b8d9ce
--- /dev/null
+++ b/backport/compat/verification/mbedtls/asn1.h
@@ -0,0 +1,344 @@
+/**
+ * \file asn1.h
+ *
+ * \brief Generic ASN.1 parsing
+ *
+ *  Copyright (C) 2006-2015, ARM Limited, All Rights Reserved
+ *  SPDX-License-Identifier: GPL-2.0
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ *  This file is part of mbed TLS (https://tls.mbed.org)
+ */
+#ifndef MBEDTLS_ASN1_H
+#define MBEDTLS_ASN1_H
+
+#if !defined(MBEDTLS_CONFIG_FILE)
+#include "config.h"
+#else
+#include MBEDTLS_CONFIG_FILE
+#endif
+
+#include <stddef.h>
+
+#if defined(MBEDTLS_BIGNUM_C)
+#include "bignum.h"
+#endif
+
+/**
+ * \addtogroup asn1_module
+ * \{
+ */
+
+/**
+ * \name ASN1 Error codes
+ * These error codes are OR'ed to X509 error codes for
+ * higher error granularity.
+ * ASN1 is a standard to specify data structures.
+ * \{
+ */
+#define MBEDTLS_ERR_ASN1_OUT_OF_DATA                      -0x0060  /**< Out of data when parsing an ASN1 data structure. */
+#define MBEDTLS_ERR_ASN1_UNEXPECTED_TAG                   -0x0062  /**< ASN1 tag was of an unexpected value. */
+#define MBEDTLS_ERR_ASN1_INVALID_LENGTH                   -0x0064  /**< Error when trying to determine the length or invalid length. */
+#define MBEDTLS_ERR_ASN1_LENGTH_MISMATCH                  -0x0066  /**< Actual length differs from expected length. */
+#define MBEDTLS_ERR_ASN1_INVALID_DATA                     -0x0068  /**< Data is invalid. (not used) */
+#define MBEDTLS_ERR_ASN1_ALLOC_FAILED                     -0x006A  /**< Memory allocation failed */
+#define MBEDTLS_ERR_ASN1_BUF_TOO_SMALL                    -0x006C  /**< Buffer too small when writing ASN.1 data structure. */
+
+/* \} name */
+
+/**
+ * \name DER constants
+ * These constants comply with DER encoded the ANS1 type tags.
+ * DER encoding uses hexadecimal representation.
+ * An example DER sequence is:\n
+ * - 0x02 -- tag indicating INTEGER
+ * - 0x01 -- length in octets
+ * - 0x05 -- value
+ * Such sequences are typically read into \c ::mbedtls_x509_buf.
+ * \{
+ */
+#define MBEDTLS_ASN1_BOOLEAN                 0x01
+#define MBEDTLS_ASN1_INTEGER                 0x02
+#define MBEDTLS_ASN1_BIT_STRING              0x03
+#define MBEDTLS_ASN1_OCTET_STRING            0x04
+#define MBEDTLS_ASN1_NULL                    0x05
+#define MBEDTLS_ASN1_OID                     0x06
+#define MBEDTLS_ASN1_UTF8_STRING             0x0C
+#define MBEDTLS_ASN1_SEQUENCE                0x10
+#define MBEDTLS_ASN1_SET                     0x11
+#define MBEDTLS_ASN1_PRINTABLE_STRING        0x13
+#define MBEDTLS_ASN1_T61_STRING              0x14
+#define MBEDTLS_ASN1_IA5_STRING              0x16
+#define MBEDTLS_ASN1_UTC_TIME                0x17
+#define MBEDTLS_ASN1_GENERALIZED_TIME        0x18
+#define MBEDTLS_ASN1_UNIVERSAL_STRING        0x1C
+#define MBEDTLS_ASN1_BMP_STRING              0x1E
+#define MBEDTLS_ASN1_PRIMITIVE               0x00
+#define MBEDTLS_ASN1_CONSTRUCTED             0x20
+#define MBEDTLS_ASN1_CONTEXT_SPECIFIC        0x80
+/* \} name */
+/* \} addtogroup asn1_module */
+
+/** Returns the size of the binary string, without the trailing \\0 */
+#define MBEDTLS_OID_SIZE(x) (sizeof(x) - 1)
+
+/**
+ * Compares an mbedtls_asn1_buf structure to a reference OID.
+ *
+ * Only works for 'defined' oid_str values (MBEDTLS_OID_HMAC_SHA1), you cannot use a
+ * 'unsigned char *oid' here!
+ */
+#define MBEDTLS_OID_CMP(oid_str, oid_buf)                                   \
+        ( ( MBEDTLS_OID_SIZE(oid_str) != (oid_buf)->len ) ||                \
+          memcmp( (oid_str), (oid_buf)->p, (oid_buf)->len) != 0 )
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/**
+ * \name Functions to parse ASN.1 data structures
+ * \{
+ */
+
+/**
+ * Type-length-value structure that allows for ASN1 using DER.
+ */
+typedef struct mbedtls_asn1_buf
+{
+    int tag;                /**< ASN1 type, e.g. MBEDTLS_ASN1_UTF8_STRING. */
+    size_t len;             /**< ASN1 length, in octets. */
+    unsigned char *p;       /**< ASN1 data, e.g. in ASCII. */
+}
+mbedtls_asn1_buf;
+
+/**
+ * Container for ASN1 bit strings.
+ */
+typedef struct mbedtls_asn1_bitstring
+{
+    size_t len;                 /**< ASN1 length, in octets. */
+    unsigned char unused_bits;  /**< Number of unused bits at the end of the string */
+    unsigned char *p;           /**< Raw ASN1 data for the bit string */
+}
+mbedtls_asn1_bitstring;
+
+/**
+ * Container for a sequence of ASN.1 items
+ */
+typedef struct mbedtls_asn1_sequence
+{
+    mbedtls_asn1_buf buf;                   /**< Buffer containing the given ASN.1 item. */
+    struct mbedtls_asn1_sequence *next;    /**< The next entry in the sequence. */
+}
+mbedtls_asn1_sequence;
+
+/**
+ * Container for a sequence or list of 'named' ASN.1 data items
+ */
+typedef struct mbedtls_asn1_named_data
+{
+    mbedtls_asn1_buf oid;                   /**< The object identifier. */
+    mbedtls_asn1_buf val;                   /**< The named value. */
+    struct mbedtls_asn1_named_data *next;  /**< The next entry in the sequence. */
+    unsigned char next_merged;      /**< Merge next item into the current one? */
+}
+mbedtls_asn1_named_data;
+
+/**
+ * \brief       Get the length of an ASN.1 element.
+ *              Updates the pointer to immediately behind the length.
+ *
+ * \param p     The position in the ASN.1 data
+ * \param end   End of data
+ * \param len   The variable that will receive the value
+ *
+ * \return      0 if successful, MBEDTLS_ERR_ASN1_OUT_OF_DATA on reaching
+ *              end of data, MBEDTLS_ERR_ASN1_INVALID_LENGTH if length is
+ *              unparseable.
+ */
+int mbedtls_asn1_get_len( unsigned char **p,
+                  const unsigned char *end,
+                  size_t *len );
+
+/**
+ * \brief       Get the tag and length of the tag. Check for the requested tag.
+ *              Updates the pointer to immediately behind the tag and length.
+ *
+ * \param p     The position in the ASN.1 data
+ * \param end   End of data
+ * \param len   The variable that will receive the length
+ * \param tag   The expected tag
+ *
+ * \return      0 if successful, MBEDTLS_ERR_ASN1_UNEXPECTED_TAG if tag did
+ *              not match requested tag, or another specific ASN.1 error code.
+ */
+int mbedtls_asn1_get_tag( unsigned char **p,
+                  const unsigned char *end,
+                  size_t *len, int tag );
+
+/**
+ * \brief       Retrieve a boolean ASN.1 tag and its value.
+ *              Updates the pointer to immediately behind the full tag.
+ *
+ * \param p     The position in the ASN.1 data
+ * \param end   End of data
+ * \param val   The variable that will receive the value
+ *
+ * \return      0 if successful or a specific ASN.1 error code.
+ */
+int mbedtls_asn1_get_bool( unsigned char **p,
+                   const unsigned char *end,
+                   int *val );
+
+/**
+ * \brief       Retrieve an integer ASN.1 tag and its value.
+ *              Updates the pointer to immediately behind the full tag.
+ *
+ * \param p     The position in the ASN.1 data
+ * \param end   End of data
+ * \param val   The variable that will receive the value
+ *
+ * \return      0 if successful or a specific ASN.1 error code.
+ */
+int mbedtls_asn1_get_int( unsigned char **p,
+                  const unsigned char *end,
+                  int *val );
+
+/**
+ * \brief       Retrieve a bitstring ASN.1 tag and its value.
+ *              Updates the pointer to immediately behind the full tag.
+ *
+ * \param p     The position in the ASN.1 data
+ * \param end   End of data
+ * \param bs    The variable that will receive the value
+ *
+ * \return      0 if successful or a specific ASN.1 error code.
+ */
+int mbedtls_asn1_get_bitstring( unsigned char **p, const unsigned char *end,
+                        mbedtls_asn1_bitstring *bs);
+
+/**
+ * \brief       Retrieve a bitstring ASN.1 tag without unused bits and its
+ *              value.
+ *              Updates the pointer to the beginning of the bit/octet string.
+ *
+ * \param p     The position in the ASN.1 data
+ * \param end   End of data
+ * \param len   Length of the actual bit/octect string in bytes
+ *
+ * \return      0 if successful or a specific ASN.1 error code.
+ */
+int mbedtls_asn1_get_bitstring_null( unsigned char **p, const unsigned char *end,
+                             size_t *len );
+
+/**
+ * \brief       Parses and splits an ASN.1 "SEQUENCE OF <tag>"
+ *              Updated the pointer to immediately behind the full sequence tag.
+ *
+ * \param p     The position in the ASN.1 data
+ * \param end   End of data
+ * \param cur   First variable in the chain to fill
+ * \param tag   Type of sequence
+ *
+ * \return      0 if successful or a specific ASN.1 error code.
+ */
+int mbedtls_asn1_get_sequence_of( unsigned char **p,
+                          const unsigned char *end,
+                          mbedtls_asn1_sequence *cur,
+                          int tag);
+
+#if defined(MBEDTLS_BIGNUM_C)
+/**
+ * \brief       Retrieve a MPI value from an integer ASN.1 tag.
+ *              Updates the pointer to immediately behind the full tag.
+ *
+ * \param p     The position in the ASN.1 data
+ * \param end   End of data
+ * \param X     The MPI that will receive the value
+ *
+ * \return      0 if successful or a specific ASN.1 or MPI error code.
+ */
+int mbedtls_asn1_get_mpi( unsigned char **p,
+                  const unsigned char *end,
+                  mbedtls_mpi *X );
+#endif /* MBEDTLS_BIGNUM_C */
+
+/**
+ * \brief       Retrieve an AlgorithmIdentifier ASN.1 sequence.
+ *              Updates the pointer to immediately behind the full
+ *              AlgorithmIdentifier.
+ *
+ * \param p     The position in the ASN.1 data
+ * \param end   End of data
+ * \param alg   The buffer to receive the OID
+ * \param params The buffer to receive the params (if any)
+ *
+ * \return      0 if successful or a specific ASN.1 or MPI error code.
+ */
+int mbedtls_asn1_get_alg( unsigned char **p,
+                  const unsigned char *end,
+                  mbedtls_asn1_buf *alg, mbedtls_asn1_buf *params );
+
+/**
+ * \brief       Retrieve an AlgorithmIdentifier ASN.1 sequence with NULL or no
+ *              params.
+ *              Updates the pointer to immediately behind the full
+ *              AlgorithmIdentifier.
+ *
+ * \param p     The position in the ASN.1 data
+ * \param end   End of data
+ * \param alg   The buffer to receive the OID
+ *
+ * \return      0 if successful or a specific ASN.1 or MPI error code.
+ */
+int mbedtls_asn1_get_alg_null( unsigned char **p,
+                       const unsigned char *end,
+                       mbedtls_asn1_buf *alg );
+
+/**
+ * \brief       Find a specific named_data entry in a sequence or list based on
+ *              the OID.
+ *
+ * \param list  The list to seek through
+ * \param oid   The OID to look for
+ * \param len   Size of the OID
+ *
+ * \return      NULL if not found, or a pointer to the existing entry.
+ */
+mbedtls_asn1_named_data *mbedtls_asn1_find_named_data( mbedtls_asn1_named_data *list,
+                                       const char *oid, size_t len );
+
+/**
+ * \brief       Free a mbedtls_asn1_named_data entry
+ *
+ * \param entry The named data entry to free
+ */
+void mbedtls_asn1_free_named_data( mbedtls_asn1_named_data *entry );
+
+/**
+ * \brief       Free all entries in a mbedtls_asn1_named_data list
+ *              Head will be set to NULL
+ *
+ * \param head  Pointer to the head of the list of named data entries to free
+ */
+void mbedtls_asn1_free_named_data_list( mbedtls_asn1_named_data **head );
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* asn1.h */
diff --git a/backport/compat/verification/mbedtls/bignum.h b/backport/compat/verification/mbedtls/bignum.h
new file mode 100644
index 000000000000..69f8e2d90c6d
--- /dev/null
+++ b/backport/compat/verification/mbedtls/bignum.h
@@ -0,0 +1,760 @@
+/**
+ * \file bignum.h
+ *
+ * \brief  Multi-precision integer library
+ *
+ *  Copyright (C) 2006-2015, ARM Limited, All Rights Reserved
+ *  SPDX-License-Identifier: GPL-2.0
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ *  This file is part of mbed TLS (https://tls.mbed.org)
+ */
+#ifndef MBEDTLS_BIGNUM_H
+#define MBEDTLS_BIGNUM_H
+
+#if !defined(MBEDTLS_CONFIG_FILE)
+#include "config.h"
+#else
+#include MBEDTLS_CONFIG_FILE
+#endif
+
+#if defined(MBEDTLS_FS_IO)
+#include <stdio.h>
+#endif
+
+#define MBEDTLS_ERR_MPI_FILE_IO_ERROR                     -0x0002  /**< An error occurred while reading from or writing to a file. */
+#define MBEDTLS_ERR_MPI_BAD_INPUT_DATA                    -0x0004  /**< Bad input parameters to function. */
+#define MBEDTLS_ERR_MPI_INVALID_CHARACTER                 -0x0006  /**< There is an invalid character in the digit string. */
+#define MBEDTLS_ERR_MPI_BUFFER_TOO_SMALL                  -0x0008  /**< The buffer is too small to write to. */
+#define MBEDTLS_ERR_MPI_NEGATIVE_VALUE                    -0x000A  /**< The input arguments are negative or result in illegal output. */
+#define MBEDTLS_ERR_MPI_DIVISION_BY_ZERO                  -0x000C  /**< The input argument for division is zero, which is not allowed. */
+#define MBEDTLS_ERR_MPI_NOT_ACCEPTABLE                    -0x000E  /**< The input arguments are not acceptable. */
+#define MBEDTLS_ERR_MPI_ALLOC_FAILED                      -0x0010  /**< Memory allocation failed. */
+
+#define MBEDTLS_MPI_CHK(f) do { if( ( ret = f ) != 0 ) goto cleanup; } while( 0 )
+
+/*
+ * Maximum size MPIs are allowed to grow to in number of limbs.
+ */
+#define MBEDTLS_MPI_MAX_LIMBS                             10000
+
+#if !defined(MBEDTLS_MPI_WINDOW_SIZE)
+/*
+ * Maximum window size used for modular exponentiation. Default: 6
+ * Minimum value: 1. Maximum value: 6.
+ *
+ * Result is an array of ( 2 << MBEDTLS_MPI_WINDOW_SIZE ) MPIs used
+ * for the sliding window calculation. (So 64 by default)
+ *
+ * Reduction in size, reduces speed.
+ */
+#define MBEDTLS_MPI_WINDOW_SIZE                           6        /**< Maximum windows size used. */
+#endif /* !MBEDTLS_MPI_WINDOW_SIZE */
+
+#if !defined(MBEDTLS_MPI_MAX_SIZE)
+/*
+ * Maximum size of MPIs allowed in bits and bytes for user-MPIs.
+ * ( Default: 512 bytes => 4096 bits, Maximum tested: 2048 bytes => 16384 bits )
+ *
+ * Note: Calculations can results temporarily in larger MPIs. So the number
+ * of limbs required (MBEDTLS_MPI_MAX_LIMBS) is higher.
+ */
+#define MBEDTLS_MPI_MAX_SIZE                              1024     /**< Maximum number of bytes for usable MPIs. */
+#endif /* !MBEDTLS_MPI_MAX_SIZE */
+
+#define MBEDTLS_MPI_MAX_BITS                              ( 8 * MBEDTLS_MPI_MAX_SIZE )    /**< Maximum number of bits for usable MPIs. */
+
+/*
+ * When reading from files with mbedtls_mpi_read_file() and writing to files with
+ * mbedtls_mpi_write_file() the buffer should have space
+ * for a (short) label, the MPI (in the provided radix), the newline
+ * characters and the '\0'.
+ *
+ * By default we assume at least a 10 char label, a minimum radix of 10
+ * (decimal) and a maximum of 4096 bit numbers (1234 decimal chars).
+ * Autosized at compile time for at least a 10 char label, a minimum radix
+ * of 10 (decimal) for a number of MBEDTLS_MPI_MAX_BITS size.
+ *
+ * This used to be statically sized to 1250 for a maximum of 4096 bit
+ * numbers (1234 decimal chars).
+ *
+ * Calculate using the formula:
+ *  MBEDTLS_MPI_RW_BUFFER_SIZE = ceil(MBEDTLS_MPI_MAX_BITS / ln(10) * ln(2)) +
+ *                                LabelSize + 6
+ */
+#define MBEDTLS_MPI_MAX_BITS_SCALE100          ( 100 * MBEDTLS_MPI_MAX_BITS )
+#define MBEDTLS_LN_2_DIV_LN_10_SCALE100                 332
+#define MBEDTLS_MPI_RW_BUFFER_SIZE             ( ((MBEDTLS_MPI_MAX_BITS_SCALE100 + MBEDTLS_LN_2_DIV_LN_10_SCALE100 - 1) / MBEDTLS_LN_2_DIV_LN_10_SCALE100) + 10 + 6 )
+
+/*
+ * Define the base integer type, architecture-wise.
+ *
+ * 32 or 64-bit integer types can be forced regardless of the underlying
+ * architecture by defining MBEDTLS_HAVE_INT32 or MBEDTLS_HAVE_INT64
+ * respectively and undefining MBEDTLS_HAVE_ASM.
+ *
+ * Double-width integers (e.g. 128-bit in 64-bit architectures) can be
+ * disabled by defining MBEDTLS_NO_UDBL_DIVISION.
+ */
+#if !defined(MBEDTLS_HAVE_INT32)
+    #if defined(_MSC_VER) && defined(_M_AMD64)
+        /* Always choose 64-bit when using MSC */
+        #if !defined(MBEDTLS_HAVE_INT64)
+            #define MBEDTLS_HAVE_INT64
+        #endif /* !MBEDTLS_HAVE_INT64 */
+        typedef  int64_t mbedtls_mpi_sint;
+        typedef uint64_t mbedtls_mpi_uint;
+    #elif defined(__GNUC__) && (                         \
+        defined(__amd64__) || defined(__x86_64__)     || \
+        defined(__ppc64__) || defined(__powerpc64__)  || \
+        defined(__ia64__)  || defined(__alpha__)      || \
+        ( defined(__sparc__) && defined(__arch64__) ) || \
+        defined(__s390x__) || defined(__mips64) )
+        #if !defined(MBEDTLS_HAVE_INT64)
+            #define MBEDTLS_HAVE_INT64
+        #endif /* MBEDTLS_HAVE_INT64 */
+        typedef  int64_t mbedtls_mpi_sint;
+        typedef uint64_t mbedtls_mpi_uint;
+        #if !defined(MBEDTLS_NO_UDBL_DIVISION)
+            /* mbedtls_t_udbl defined as 128-bit unsigned int */
+            typedef unsigned int mbedtls_t_udbl __attribute__((mode(TI)));
+            #define MBEDTLS_HAVE_UDBL
+        #endif /* !MBEDTLS_NO_UDBL_DIVISION */
+    #elif defined(__ARMCC_VERSION) && defined(__aarch64__)
+        /*
+         * __ARMCC_VERSION is defined for both armcc and armclang and
+         * __aarch64__ is only defined by armclang when compiling 64-bit code
+         */
+        #if !defined(MBEDTLS_HAVE_INT64)
+            #define MBEDTLS_HAVE_INT64
+        #endif /* !MBEDTLS_HAVE_INT64 */
+        typedef  int64_t mbedtls_mpi_sint;
+        typedef uint64_t mbedtls_mpi_uint;
+        #if !defined(MBEDTLS_NO_UDBL_DIVISION)
+            /* mbedtls_t_udbl defined as 128-bit unsigned int */
+            typedef __uint128_t mbedtls_t_udbl;
+            #define MBEDTLS_HAVE_UDBL
+        #endif /* !MBEDTLS_NO_UDBL_DIVISION */
+    #elif defined(MBEDTLS_HAVE_INT64)
+        /* Force 64-bit integers with unknown compiler */
+        typedef  int64_t mbedtls_mpi_sint;
+        typedef uint64_t mbedtls_mpi_uint;
+    #endif
+#endif /* !MBEDTLS_HAVE_INT32 */
+
+#if !defined(MBEDTLS_HAVE_INT64)
+    /* Default to 32-bit compilation */
+    #if !defined(MBEDTLS_HAVE_INT32)
+        #define MBEDTLS_HAVE_INT32
+    #endif /* !MBEDTLS_HAVE_INT32 */
+    typedef  int32_t mbedtls_mpi_sint;
+    typedef uint32_t mbedtls_mpi_uint;
+    #if !defined(MBEDTLS_NO_UDBL_DIVISION)
+        typedef uint64_t mbedtls_t_udbl;
+        #define MBEDTLS_HAVE_UDBL
+    #endif /* !MBEDTLS_NO_UDBL_DIVISION */
+#endif /* !MBEDTLS_HAVE_INT64 */
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/**
+ * \brief          MPI structure
+ */
+typedef struct
+{
+    int s;              /*!<  integer sign      */
+    size_t n;           /*!<  total # of limbs  */
+    mbedtls_mpi_uint *p;          /*!<  pointer to limbs  */
+}
+mbedtls_mpi;
+
+/**
+ * \brief           Initialize one MPI (make internal references valid)
+ *                  This just makes it ready to be set or freed,
+ *                  but does not define a value for the MPI.
+ *
+ * \param X         One MPI to initialize.
+ */
+void mbedtls_mpi_init( mbedtls_mpi *X );
+
+/**
+ * \brief          Unallocate one MPI
+ *
+ * \param X        One MPI to unallocate.
+ */
+void mbedtls_mpi_free( mbedtls_mpi *X );
+
+/**
+ * \brief          Enlarge to the specified number of limbs
+ *
+ * \param X        MPI to grow
+ * \param nblimbs  The target number of limbs
+ *
+ * \return         0 if successful,
+ *                 MBEDTLS_ERR_MPI_ALLOC_FAILED if memory allocation failed
+ */
+int mbedtls_mpi_grow( mbedtls_mpi *X, size_t nblimbs );
+
+/**
+ * \brief          Resize down, keeping at least the specified number of limbs
+ *
+ * \param X        MPI to shrink
+ * \param nblimbs  The minimum number of limbs to keep
+ *
+ * \return         0 if successful,
+ *                 MBEDTLS_ERR_MPI_ALLOC_FAILED if memory allocation failed
+ */
+int mbedtls_mpi_shrink( mbedtls_mpi *X, size_t nblimbs );
+
+/**
+ * \brief          Copy the contents of Y into X
+ *
+ * \param X        Destination MPI
+ * \param Y        Source MPI
+ *
+ * \return         0 if successful,
+ *                 MBEDTLS_ERR_MPI_ALLOC_FAILED if memory allocation failed
+ */
+int mbedtls_mpi_copy( mbedtls_mpi *X, const mbedtls_mpi *Y );
+
+/**
+ * \brief          Swap the contents of X and Y
+ *
+ * \param X        First MPI value
+ * \param Y        Second MPI value
+ */
+void mbedtls_mpi_swap( mbedtls_mpi *X, mbedtls_mpi *Y );
+
+/**
+ * \brief          Safe conditional assignement X = Y if assign is 1
+ *
+ * \param X        MPI to conditionally assign to
+ * \param Y        Value to be assigned
+ * \param assign   1: perform the assignment, 0: keep X's original value
+ *
+ * \return         0 if successful,
+ *                 MBEDTLS_ERR_MPI_ALLOC_FAILED if memory allocation failed,
+ *
+ * \note           This function is equivalent to
+ *                      if( assign ) mbedtls_mpi_copy( X, Y );
+ *                 except that it avoids leaking any information about whether
+ *                 the assignment was done or not (the above code may leak
+ *                 information through branch prediction and/or memory access
+ *                 patterns analysis).
+ */
+int mbedtls_mpi_safe_cond_assign( mbedtls_mpi *X, const mbedtls_mpi *Y, unsigned char assign );
+
+/**
+ * \brief          Safe conditional swap X <-> Y if swap is 1
+ *
+ * \param X        First mbedtls_mpi value
+ * \param Y        Second mbedtls_mpi value
+ * \param assign   1: perform the swap, 0: keep X and Y's original values
+ *
+ * \return         0 if successful,
+ *                 MBEDTLS_ERR_MPI_ALLOC_FAILED if memory allocation failed,
+ *
+ * \note           This function is equivalent to
+ *                      if( assign ) mbedtls_mpi_swap( X, Y );
+ *                 except that it avoids leaking any information about whether
+ *                 the assignment was done or not (the above code may leak
+ *                 information through branch prediction and/or memory access
+ *                 patterns analysis).
+ */
+int mbedtls_mpi_safe_cond_swap( mbedtls_mpi *X, mbedtls_mpi *Y, unsigned char assign );
+
+/**
+ * \brief          Set value from integer
+ *
+ * \param X        MPI to set
+ * \param z        Value to use
+ *
+ * \return         0 if successful,
+ *                 MBEDTLS_ERR_MPI_ALLOC_FAILED if memory allocation failed
+ */
+int mbedtls_mpi_lset( mbedtls_mpi *X, mbedtls_mpi_sint z );
+
+/**
+ * \brief          Get a specific bit from X
+ *
+ * \param X        MPI to use
+ * \param pos      Zero-based index of the bit in X
+ *
+ * \return         Either a 0 or a 1
+ */
+int mbedtls_mpi_get_bit( const mbedtls_mpi *X, size_t pos );
+
+/**
+ * \brief          Set a bit of X to a specific value of 0 or 1
+ *
+ * \note           Will grow X if necessary to set a bit to 1 in a not yet
+ *                 existing limb. Will not grow if bit should be set to 0
+ *
+ * \param X        MPI to use
+ * \param pos      Zero-based index of the bit in X
+ * \param val      The value to set the bit to (0 or 1)
+ *
+ * \return         0 if successful,
+ *                 MBEDTLS_ERR_MPI_ALLOC_FAILED if memory allocation failed,
+ *                 MBEDTLS_ERR_MPI_BAD_INPUT_DATA if val is not 0 or 1
+ */
+int mbedtls_mpi_set_bit( mbedtls_mpi *X, size_t pos, unsigned char val );
+
+/**
+ * \brief          Return the number of zero-bits before the least significant
+ *                 '1' bit
+ *
+ * Note: Thus also the zero-based index of the least significant '1' bit
+ *
+ * \param X        MPI to use
+ */
+size_t mbedtls_mpi_lsb( const mbedtls_mpi *X );
+
+/**
+ * \brief          Return the number of bits up to and including the most
+ *                 significant '1' bit'
+ *
+ * Note: Thus also the one-based index of the most significant '1' bit
+ *
+ * \param X        MPI to use
+ */
+size_t mbedtls_mpi_bitlen( const mbedtls_mpi *X );
+
+/**
+ * \brief          Return the total size in bytes
+ *
+ * \param X        MPI to use
+ */
+size_t mbedtls_mpi_size( const mbedtls_mpi *X );
+
+/**
+ * \brief          Import from an ASCII string
+ *
+ * \param X        Destination MPI
+ * \param radix    Input numeric base
+ * \param s        Null-terminated string buffer
+ *
+ * \return         0 if successful, or a MBEDTLS_ERR_MPI_XXX error code
+ */
+int mbedtls_mpi_read_string( mbedtls_mpi *X, int radix, const char *s );
+
+/**
+ * \brief          Export into an ASCII string
+ *
+ * \param X        Source MPI
+ * \param radix    Output numeric base
+ * \param buf      Buffer to write the string to
+ * \param buflen   Length of buf
+ * \param olen     Length of the string written, including final NUL byte
+ *
+ * \return         0 if successful, or a MBEDTLS_ERR_MPI_XXX error code.
+ *                 *olen is always updated to reflect the amount
+ *                 of data that has (or would have) been written.
+ *
+ * \note           Call this function with buflen = 0 to obtain the
+ *                 minimum required buffer size in *olen.
+ */
+int mbedtls_mpi_write_string( const mbedtls_mpi *X, int radix,
+                              char *buf, size_t buflen, size_t *olen );
+
+#if defined(MBEDTLS_FS_IO)
+/**
+ * \brief          Read MPI from a line in an opened file
+ *
+ * \param X        Destination MPI
+ * \param radix    Input numeric base
+ * \param fin      Input file handle
+ *
+ * \return         0 if successful, MBEDTLS_ERR_MPI_BUFFER_TOO_SMALL if
+ *                 the file read buffer is too small or a
+ *                 MBEDTLS_ERR_MPI_XXX error code
+ *
+ * \note           On success, this function advances the file stream
+ *                 to the end of the current line or to EOF.
+ *
+ *                 The function returns 0 on an empty line.
+ *
+ *                 Leading whitespaces are ignored, as is a
+ *                 '0x' prefix for radix 16.
+ *
+ */
+int mbedtls_mpi_read_file( mbedtls_mpi *X, int radix, FILE *fin );
+
+/**
+ * \brief          Write X into an opened file, or stdout if fout is NULL
+ *
+ * \param p        Prefix, can be NULL
+ * \param X        Source MPI
+ * \param radix    Output numeric base
+ * \param fout     Output file handle (can be NULL)
+ *
+ * \return         0 if successful, or a MBEDTLS_ERR_MPI_XXX error code
+ *
+ * \note           Set fout == NULL to print X on the console.
+ */
+int mbedtls_mpi_write_file( const char *p, const mbedtls_mpi *X, int radix, FILE *fout );
+#endif /* MBEDTLS_FS_IO */
+
+/**
+ * \brief          Import X from unsigned binary data, big endian
+ *
+ * \param X        Destination MPI
+ * \param buf      Input buffer
+ * \param buflen   Input buffer size
+ *
+ * \return         0 if successful,
+ *                 MBEDTLS_ERR_MPI_ALLOC_FAILED if memory allocation failed
+ */
+int mbedtls_mpi_read_binary( mbedtls_mpi *X, const unsigned char *buf, size_t buflen );
+
+/**
+ * \brief          Export X into unsigned binary data, big endian.
+ *                 Always fills the whole buffer, which will start with zeros
+ *                 if the number is smaller.
+ *
+ * \param X        Source MPI
+ * \param buf      Output buffer
+ * \param buflen   Output buffer size
+ *
+ * \return         0 if successful,
+ *                 MBEDTLS_ERR_MPI_BUFFER_TOO_SMALL if buf isn't large enough
+ */
+int mbedtls_mpi_write_binary( const mbedtls_mpi *X, unsigned char *buf, size_t buflen );
+
+/**
+ * \brief          Left-shift: X <<= count
+ *
+ * \param X        MPI to shift
+ * \param count    Amount to shift
+ *
+ * \return         0 if successful,
+ *                 MBEDTLS_ERR_MPI_ALLOC_FAILED if memory allocation failed
+ */
+int mbedtls_mpi_shift_l( mbedtls_mpi *X, size_t count );
+
+/**
+ * \brief          Right-shift: X >>= count
+ *
+ * \param X        MPI to shift
+ * \param count    Amount to shift
+ *
+ * \return         0 if successful,
+ *                 MBEDTLS_ERR_MPI_ALLOC_FAILED if memory allocation failed
+ */
+int mbedtls_mpi_shift_r( mbedtls_mpi *X, size_t count );
+
+/**
+ * \brief          Compare unsigned values
+ *
+ * \param X        Left-hand MPI
+ * \param Y        Right-hand MPI
+ *
+ * \return         1 if |X| is greater than |Y|,
+ *                -1 if |X| is lesser  than |Y| or
+ *                 0 if |X| is equal to |Y|
+ */
+int mbedtls_mpi_cmp_abs( const mbedtls_mpi *X, const mbedtls_mpi *Y );
+
+/**
+ * \brief          Compare signed values
+ *
+ * \param X        Left-hand MPI
+ * \param Y        Right-hand MPI
+ *
+ * \return         1 if X is greater than Y,
+ *                -1 if X is lesser  than Y or
+ *                 0 if X is equal to Y
+ */
+int mbedtls_mpi_cmp_mpi( const mbedtls_mpi *X, const mbedtls_mpi *Y );
+
+/**
+ * \brief          Compare signed values
+ *
+ * \param X        Left-hand MPI
+ * \param z        The integer value to compare to
+ *
+ * \return         1 if X is greater than z,
+ *                -1 if X is lesser  than z or
+ *                 0 if X is equal to z
+ */
+int mbedtls_mpi_cmp_int( const mbedtls_mpi *X, mbedtls_mpi_sint z );
+
+/**
+ * \brief          Unsigned addition: X = |A| + |B|
+ *
+ * \param X        Destination MPI
+ * \param A        Left-hand MPI
+ * \param B        Right-hand MPI
+ *
+ * \return         0 if successful,
+ *                 MBEDTLS_ERR_MPI_ALLOC_FAILED if memory allocation failed
+ */
+int mbedtls_mpi_add_abs( mbedtls_mpi *X, const mbedtls_mpi *A, const mbedtls_mpi *B );
+
+/**
+ * \brief          Unsigned subtraction: X = |A| - |B|
+ *
+ * \param X        Destination MPI
+ * \param A        Left-hand MPI
+ * \param B        Right-hand MPI
+ *
+ * \return         0 if successful,
+ *                 MBEDTLS_ERR_MPI_NEGATIVE_VALUE if B is greater than A
+ */
+int mbedtls_mpi_sub_abs( mbedtls_mpi *X, const mbedtls_mpi *A, const mbedtls_mpi *B );
+
+/**
+ * \brief          Signed addition: X = A + B
+ *
+ * \param X        Destination MPI
+ * \param A        Left-hand MPI
+ * \param B        Right-hand MPI
+ *
+ * \return         0 if successful,
+ *                 MBEDTLS_ERR_MPI_ALLOC_FAILED if memory allocation failed
+ */
+int mbedtls_mpi_add_mpi( mbedtls_mpi *X, const mbedtls_mpi *A, const mbedtls_mpi *B );
+
+/**
+ * \brief          Signed subtraction: X = A - B
+ *
+ * \param X        Destination MPI
+ * \param A        Left-hand MPI
+ * \param B        Right-hand MPI
+ *
+ * \return         0 if successful,
+ *                 MBEDTLS_ERR_MPI_ALLOC_FAILED if memory allocation failed
+ */
+int mbedtls_mpi_sub_mpi( mbedtls_mpi *X, const mbedtls_mpi *A, const mbedtls_mpi *B );
+
+/**
+ * \brief          Signed addition: X = A + b
+ *
+ * \param X        Destination MPI
+ * \param A        Left-hand MPI
+ * \param b        The integer value to add
+ *
+ * \return         0 if successful,
+ *                 MBEDTLS_ERR_MPI_ALLOC_FAILED if memory allocation failed
+ */
+int mbedtls_mpi_add_int( mbedtls_mpi *X, const mbedtls_mpi *A, mbedtls_mpi_sint b );
+
+/**
+ * \brief          Signed subtraction: X = A - b
+ *
+ * \param X        Destination MPI
+ * \param A        Left-hand MPI
+ * \param b        The integer value to subtract
+ *
+ * \return         0 if successful,
+ *                 MBEDTLS_ERR_MPI_ALLOC_FAILED if memory allocation failed
+ */
+int mbedtls_mpi_sub_int( mbedtls_mpi *X, const mbedtls_mpi *A, mbedtls_mpi_sint b );
+
+/**
+ * \brief          Baseline multiplication: X = A * B
+ *
+ * \param X        Destination MPI
+ * \param A        Left-hand MPI
+ * \param B        Right-hand MPI
+ *
+ * \return         0 if successful,
+ *                 MBEDTLS_ERR_MPI_ALLOC_FAILED if memory allocation failed
+ */
+int mbedtls_mpi_mul_mpi( mbedtls_mpi *X, const mbedtls_mpi *A, const mbedtls_mpi *B );
+
+/**
+ * \brief          Baseline multiplication: X = A * b
+ *
+ * \param X        Destination MPI
+ * \param A        Left-hand MPI
+ * \param b        The unsigned integer value to multiply with
+ *
+ * \note           b is unsigned
+ *
+ * \return         0 if successful,
+ *                 MBEDTLS_ERR_MPI_ALLOC_FAILED if memory allocation failed
+ */
+int mbedtls_mpi_mul_int( mbedtls_mpi *X, const mbedtls_mpi *A, mbedtls_mpi_uint b );
+
+/**
+ * \brief          Division by mbedtls_mpi: A = Q * B + R
+ *
+ * \param Q        Destination MPI for the quotient
+ * \param R        Destination MPI for the rest value
+ * \param A        Left-hand MPI
+ * \param B        Right-hand MPI
+ *
+ * \return         0 if successful,
+ *                 MBEDTLS_ERR_MPI_ALLOC_FAILED if memory allocation failed,
+ *                 MBEDTLS_ERR_MPI_DIVISION_BY_ZERO if B == 0
+ *
+ * \note           Either Q or R can be NULL.
+ */
+int mbedtls_mpi_div_mpi( mbedtls_mpi *Q, mbedtls_mpi *R, const mbedtls_mpi *A, const mbedtls_mpi *B );
+
+/**
+ * \brief          Division by int: A = Q * b + R
+ *
+ * \param Q        Destination MPI for the quotient
+ * \param R        Destination MPI for the rest value
+ * \param A        Left-hand MPI
+ * \param b        Integer to divide by
+ *
+ * \return         0 if successful,
+ *                 MBEDTLS_ERR_MPI_ALLOC_FAILED if memory allocation failed,
+ *                 MBEDTLS_ERR_MPI_DIVISION_BY_ZERO if b == 0
+ *
+ * \note           Either Q or R can be NULL.
+ */
+int mbedtls_mpi_div_int( mbedtls_mpi *Q, mbedtls_mpi *R, const mbedtls_mpi *A, mbedtls_mpi_sint b );
+
+/**
+ * \brief          Modulo: R = A mod B
+ *
+ * \param R        Destination MPI for the rest value
+ * \param A        Left-hand MPI
+ * \param B        Right-hand MPI
+ *
+ * \return         0 if successful,
+ *                 MBEDTLS_ERR_MPI_ALLOC_FAILED if memory allocation failed,
+ *                 MBEDTLS_ERR_MPI_DIVISION_BY_ZERO if B == 0,
+ *                 MBEDTLS_ERR_MPI_NEGATIVE_VALUE if B < 0
+ */
+int mbedtls_mpi_mod_mpi( mbedtls_mpi *R, const mbedtls_mpi *A, const mbedtls_mpi *B );
+
+/**
+ * \brief          Modulo: r = A mod b
+ *
+ * \param r        Destination mbedtls_mpi_uint
+ * \param A        Left-hand MPI
+ * \param b        Integer to divide by
+ *
+ * \return         0 if successful,
+ *                 MBEDTLS_ERR_MPI_ALLOC_FAILED if memory allocation failed,
+ *                 MBEDTLS_ERR_MPI_DIVISION_BY_ZERO if b == 0,
+ *                 MBEDTLS_ERR_MPI_NEGATIVE_VALUE if b < 0
+ */
+int mbedtls_mpi_mod_int( mbedtls_mpi_uint *r, const mbedtls_mpi *A, mbedtls_mpi_sint b );
+
+/**
+ * \brief          Sliding-window exponentiation: X = A^E mod N
+ *
+ * \param X        Destination MPI
+ * \param A        Left-hand MPI
+ * \param E        Exponent MPI
+ * \param N        Modular MPI
+ * \param _RR      Speed-up MPI used for recalculations
+ *
+ * \return         0 if successful,
+ *                 MBEDTLS_ERR_MPI_ALLOC_FAILED if memory allocation failed,
+ *                 MBEDTLS_ERR_MPI_BAD_INPUT_DATA if N is negative or even or
+ *                 if E is negative
+ *
+ * \note           _RR is used to avoid re-computing R*R mod N across
+ *                 multiple calls, which speeds up things a bit. It can
+ *                 be set to NULL if the extra performance is unneeded.
+ */
+int mbedtls_mpi_exp_mod( mbedtls_mpi *X, const mbedtls_mpi *A, const mbedtls_mpi *E, const mbedtls_mpi *N, mbedtls_mpi *_RR );
+
+/**
+ * \brief          Fill an MPI X with size bytes of random
+ *
+ * \param X        Destination MPI
+ * \param size     Size in bytes
+ * \param f_rng    RNG function
+ * \param p_rng    RNG parameter
+ *
+ * \return         0 if successful,
+ *                 MBEDTLS_ERR_MPI_ALLOC_FAILED if memory allocation failed
+ */
+int mbedtls_mpi_fill_random( mbedtls_mpi *X, size_t size,
+                     int (*f_rng)(void *, unsigned char *, size_t),
+                     void *p_rng );
+
+/**
+ * \brief          Greatest common divisor: G = gcd(A, B)
+ *
+ * \param G        Destination MPI
+ * \param A        Left-hand MPI
+ * \param B        Right-hand MPI
+ *
+ * \return         0 if successful,
+ *                 MBEDTLS_ERR_MPI_ALLOC_FAILED if memory allocation failed
+ */
+int mbedtls_mpi_gcd( mbedtls_mpi *G, const mbedtls_mpi *A, const mbedtls_mpi *B );
+
+/**
+ * \brief          Modular inverse: X = A^-1 mod N
+ *
+ * \param X        Destination MPI
+ * \param A        Left-hand MPI
+ * \param N        Right-hand MPI
+ *
+ * \return         0 if successful,
+ *                 MBEDTLS_ERR_MPI_ALLOC_FAILED if memory allocation failed,
+ *                 MBEDTLS_ERR_MPI_BAD_INPUT_DATA if N is <= 1,
+                   MBEDTLS_ERR_MPI_NOT_ACCEPTABLE if A has no inverse mod N.
+ */
+int mbedtls_mpi_inv_mod( mbedtls_mpi *X, const mbedtls_mpi *A, const mbedtls_mpi *N );
+
+/**
+ * \brief          Miller-Rabin primality test
+ *
+ * \param X        MPI to check
+ * \param f_rng    RNG function
+ * \param p_rng    RNG parameter
+ *
+ * \return         0 if successful (probably prime),
+ *                 MBEDTLS_ERR_MPI_ALLOC_FAILED if memory allocation failed,
+ *                 MBEDTLS_ERR_MPI_NOT_ACCEPTABLE if X is not prime
+ */
+int mbedtls_mpi_is_prime( const mbedtls_mpi *X,
+                  int (*f_rng)(void *, unsigned char *, size_t),
+                  void *p_rng );
+
+/**
+ * \brief          Prime number generation
+ *
+ * \param X        Destination MPI
+ * \param nbits    Required size of X in bits
+ *                 ( 3 <= nbits <= MBEDTLS_MPI_MAX_BITS )
+ * \param dh_flag  If 1, then (X-1)/2 will be prime too
+ * \param f_rng    RNG function
+ * \param p_rng    RNG parameter
+ *
+ * \return         0 if successful (probably prime),
+ *                 MBEDTLS_ERR_MPI_ALLOC_FAILED if memory allocation failed,
+ *                 MBEDTLS_ERR_MPI_BAD_INPUT_DATA if nbits is < 3
+ */
+int mbedtls_mpi_gen_prime( mbedtls_mpi *X, size_t nbits, int dh_flag,
+                   int (*f_rng)(void *, unsigned char *, size_t),
+                   void *p_rng );
+
+/**
+ * \brief          Checkup routine
+ *
+ * \return         0 if successful, or 1 if the test failed
+ */
+int mbedtls_mpi_self_test( int verbose );
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* bignum.h */
diff --git a/backport/compat/verification/mbedtls/bn_mul.h b/backport/compat/verification/mbedtls/bn_mul.h
new file mode 100644
index 000000000000..5f59ec6430a2
--- /dev/null
+++ b/backport/compat/verification/mbedtls/bn_mul.h
@@ -0,0 +1,887 @@
+/**
+ * \file bn_mul.h
+ *
+ * \brief  Multi-precision integer library
+ *
+ *  Copyright (C) 2006-2015, ARM Limited, All Rights Reserved
+ *  SPDX-License-Identifier: GPL-2.0
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ *  This file is part of mbed TLS (https://tls.mbed.org)
+ */
+/*
+ *      Multiply source vector [s] with b, add result
+ *       to destination vector [d] and set carry c.
+ *
+ *      Currently supports:
+ *
+ *         . IA-32 (386+)         . AMD64 / EM64T
+ *         . IA-32 (SSE2)         . Motorola 68000
+ *         . PowerPC, 32-bit      . MicroBlaze
+ *         . PowerPC, 64-bit      . TriCore
+ *         . SPARC v8             . ARM v3+
+ *         . Alpha                . MIPS32
+ *         . C, longlong          . C, generic
+ */
+#ifndef MBEDTLS_BN_MUL_H
+#define MBEDTLS_BN_MUL_H
+
+#include "bignum.h"
+
+#if defined(MBEDTLS_HAVE_ASM)
+
+#ifndef asm
+#define asm __asm
+#endif
+
+/* armcc5 --gnu defines __GNUC__ but doesn't support GNU's extended asm */
+#if defined(__GNUC__) && \
+    ( !defined(__ARMCC_VERSION) || __ARMCC_VERSION >= 6000000 )
+#if defined(__i386__)
+
+#define MULADDC_INIT                        \
+    asm(                                    \
+        "movl   %%ebx, %0           \n\t"   \
+        "movl   %5, %%esi           \n\t"   \
+        "movl   %6, %%edi           \n\t"   \
+        "movl   %7, %%ecx           \n\t"   \
+        "movl   %8, %%ebx           \n\t"
+
+#define MULADDC_CORE                        \
+        "lodsl                      \n\t"   \
+        "mull   %%ebx               \n\t"   \
+        "addl   %%ecx,   %%eax      \n\t"   \
+        "adcl   $0,      %%edx      \n\t"   \
+        "addl   (%%edi), %%eax      \n\t"   \
+        "adcl   $0,      %%edx      \n\t"   \
+        "movl   %%edx,   %%ecx      \n\t"   \
+        "stosl                      \n\t"
+
+#if defined(MBEDTLS_HAVE_SSE2)
+
+#define MULADDC_HUIT                            \
+        "movd     %%ecx,     %%mm1      \n\t"   \
+        "movd     %%ebx,     %%mm0      \n\t"   \
+        "movd     (%%edi),   %%mm3      \n\t"   \
+        "paddq    %%mm3,     %%mm1      \n\t"   \
+        "movd     (%%esi),   %%mm2      \n\t"   \
+        "pmuludq  %%mm0,     %%mm2      \n\t"   \
+        "movd     4(%%esi),  %%mm4      \n\t"   \
+        "pmuludq  %%mm0,     %%mm4      \n\t"   \
+        "movd     8(%%esi),  %%mm6      \n\t"   \
+        "pmuludq  %%mm0,     %%mm6      \n\t"   \
+        "movd     12(%%esi), %%mm7      \n\t"   \
+        "pmuludq  %%mm0,     %%mm7      \n\t"   \
+        "paddq    %%mm2,     %%mm1      \n\t"   \
+        "movd     4(%%edi),  %%mm3      \n\t"   \
+        "paddq    %%mm4,     %%mm3      \n\t"   \
+        "movd     8(%%edi),  %%mm5      \n\t"   \
+        "paddq    %%mm6,     %%mm5      \n\t"   \
+        "movd     12(%%edi), %%mm4      \n\t"   \
+        "paddq    %%mm4,     %%mm7      \n\t"   \
+        "movd     %%mm1,     (%%edi)    \n\t"   \
+        "movd     16(%%esi), %%mm2      \n\t"   \
+        "pmuludq  %%mm0,     %%mm2      \n\t"   \
+        "psrlq    $32,       %%mm1      \n\t"   \
+        "movd     20(%%esi), %%mm4      \n\t"   \
+        "pmuludq  %%mm0,     %%mm4      \n\t"   \
+        "paddq    %%mm3,     %%mm1      \n\t"   \
+        "movd     24(%%esi), %%mm6      \n\t"   \
+        "pmuludq  %%mm0,     %%mm6      \n\t"   \
+        "movd     %%mm1,     4(%%edi)   \n\t"   \
+        "psrlq    $32,       %%mm1      \n\t"   \
+        "movd     28(%%esi), %%mm3      \n\t"   \
+        "pmuludq  %%mm0,     %%mm3      \n\t"   \
+        "paddq    %%mm5,     %%mm1      \n\t"   \
+        "movd     16(%%edi), %%mm5      \n\t"   \
+        "paddq    %%mm5,     %%mm2      \n\t"   \
+        "movd     %%mm1,     8(%%edi)   \n\t"   \
+        "psrlq    $32,       %%mm1      \n\t"   \
+        "paddq    %%mm7,     %%mm1      \n\t"   \
+        "movd     20(%%edi), %%mm5      \n\t"   \
+        "paddq    %%mm5,     %%mm4      \n\t"   \
+        "movd     %%mm1,     12(%%edi)  \n\t"   \
+        "psrlq    $32,       %%mm1      \n\t"   \
+        "paddq    %%mm2,     %%mm1      \n\t"   \
+        "movd     24(%%edi), %%mm5      \n\t"   \
+        "paddq    %%mm5,     %%mm6      \n\t"   \
+        "movd     %%mm1,     16(%%edi)  \n\t"   \
+        "psrlq    $32,       %%mm1      \n\t"   \
+        "paddq    %%mm4,     %%mm1      \n\t"   \
+        "movd     28(%%edi), %%mm5      \n\t"   \
+        "paddq    %%mm5,     %%mm3      \n\t"   \
+        "movd     %%mm1,     20(%%edi)  \n\t"   \
+        "psrlq    $32,       %%mm1      \n\t"   \
+        "paddq    %%mm6,     %%mm1      \n\t"   \
+        "movd     %%mm1,     24(%%edi)  \n\t"   \
+        "psrlq    $32,       %%mm1      \n\t"   \
+        "paddq    %%mm3,     %%mm1      \n\t"   \
+        "movd     %%mm1,     28(%%edi)  \n\t"   \
+        "addl     $32,       %%edi      \n\t"   \
+        "addl     $32,       %%esi      \n\t"   \
+        "psrlq    $32,       %%mm1      \n\t"   \
+        "movd     %%mm1,     %%ecx      \n\t"
+
+#define MULADDC_STOP                    \
+        "emms                   \n\t"   \
+        "movl   %4, %%ebx       \n\t"   \
+        "movl   %%ecx, %1       \n\t"   \
+        "movl   %%edi, %2       \n\t"   \
+        "movl   %%esi, %3       \n\t"   \
+        : "=m" (t), "=m" (c), "=m" (d), "=m" (s)        \
+        : "m" (t), "m" (s), "m" (d), "m" (c), "m" (b)   \
+        : "eax", "ecx", "edx", "esi", "edi"             \
+    );
+
+#else
+
+#define MULADDC_STOP                    \
+        "movl   %4, %%ebx       \n\t"   \
+        "movl   %%ecx, %1       \n\t"   \
+        "movl   %%edi, %2       \n\t"   \
+        "movl   %%esi, %3       \n\t"   \
+        : "=m" (t), "=m" (c), "=m" (d), "=m" (s)        \
+        : "m" (t), "m" (s), "m" (d), "m" (c), "m" (b)   \
+        : "eax", "ecx", "edx", "esi", "edi"             \
+    );
+#endif /* SSE2 */
+#endif /* i386 */
+
+#if defined(__amd64__) || defined (__x86_64__)
+
+#define MULADDC_INIT                        \
+    asm(                                    \
+        "xorq   %%r8, %%r8          \n\t"
+
+#define MULADDC_CORE                        \
+        "movq   (%%rsi), %%rax      \n\t"   \
+        "mulq   %%rbx               \n\t"   \
+        "addq   $8,      %%rsi      \n\t"   \
+        "addq   %%rcx,   %%rax      \n\t"   \
+        "movq   %%r8,    %%rcx      \n\t"   \
+        "adcq   $0,      %%rdx      \n\t"   \
+        "nop                        \n\t"   \
+        "addq   %%rax,   (%%rdi)    \n\t"   \
+        "adcq   %%rdx,   %%rcx      \n\t"   \
+        "addq   $8,      %%rdi      \n\t"
+
+#define MULADDC_STOP                        \
+        : "+c" (c), "+D" (d), "+S" (s)      \
+        : "b" (b)                           \
+        : "rax", "rdx", "r8"                \
+    );
+
+#endif /* AMD64 */
+
+#if defined(__mc68020__) || defined(__mcpu32__)
+
+#define MULADDC_INIT                    \
+    asm(                                \
+        "movl   %3, %%a2        \n\t"   \
+        "movl   %4, %%a3        \n\t"   \
+        "movl   %5, %%d3        \n\t"   \
+        "movl   %6, %%d2        \n\t"   \
+        "moveq  #0, %%d0        \n\t"
+
+#define MULADDC_CORE                    \
+        "movel  %%a2@+, %%d1    \n\t"   \
+        "mulul  %%d2, %%d4:%%d1 \n\t"   \
+        "addl   %%d3, %%d1      \n\t"   \
+        "addxl  %%d0, %%d4      \n\t"   \
+        "moveq  #0,   %%d3      \n\t"   \
+        "addl   %%d1, %%a3@+    \n\t"   \
+        "addxl  %%d4, %%d3      \n\t"
+
+#define MULADDC_STOP                    \
+        "movl   %%d3, %0        \n\t"   \
+        "movl   %%a3, %1        \n\t"   \
+        "movl   %%a2, %2        \n\t"   \
+        : "=m" (c), "=m" (d), "=m" (s)              \
+        : "m" (s), "m" (d), "m" (c), "m" (b)        \
+        : "d0", "d1", "d2", "d3", "d4", "a2", "a3"  \
+    );
+
+#define MULADDC_HUIT                        \
+        "movel  %%a2@+,  %%d1       \n\t"   \
+        "mulul  %%d2,    %%d4:%%d1  \n\t"   \
+        "addxl  %%d3,    %%d1       \n\t"   \
+        "addxl  %%d0,    %%d4       \n\t"   \
+        "addl   %%d1,    %%a3@+     \n\t"   \
+        "movel  %%a2@+,  %%d1       \n\t"   \
+        "mulul  %%d2,    %%d3:%%d1  \n\t"   \
+        "addxl  %%d4,    %%d1       \n\t"   \
+        "addxl  %%d0,    %%d3       \n\t"   \
+        "addl   %%d1,    %%a3@+     \n\t"   \
+        "movel  %%a2@+,  %%d1       \n\t"   \
+        "mulul  %%d2,    %%d4:%%d1  \n\t"   \
+        "addxl  %%d3,    %%d1       \n\t"   \
+        "addxl  %%d0,    %%d4       \n\t"   \
+        "addl   %%d1,    %%a3@+     \n\t"   \
+        "movel  %%a2@+,  %%d1       \n\t"   \
+        "mulul  %%d2,    %%d3:%%d1  \n\t"   \
+        "addxl  %%d4,    %%d1       \n\t"   \
+        "addxl  %%d0,    %%d3       \n\t"   \
+        "addl   %%d1,    %%a3@+     \n\t"   \
+        "movel  %%a2@+,  %%d1       \n\t"   \
+        "mulul  %%d2,    %%d4:%%d1  \n\t"   \
+        "addxl  %%d3,    %%d1       \n\t"   \
+        "addxl  %%d0,    %%d4       \n\t"   \
+        "addl   %%d1,    %%a3@+     \n\t"   \
+        "movel  %%a2@+,  %%d1       \n\t"   \
+        "mulul  %%d2,    %%d3:%%d1  \n\t"   \
+        "addxl  %%d4,    %%d1       \n\t"   \
+        "addxl  %%d0,    %%d3       \n\t"   \
+        "addl   %%d1,    %%a3@+     \n\t"   \
+        "movel  %%a2@+,  %%d1       \n\t"   \
+        "mulul  %%d2,    %%d4:%%d1  \n\t"   \
+        "addxl  %%d3,    %%d1       \n\t"   \
+        "addxl  %%d0,    %%d4       \n\t"   \
+        "addl   %%d1,    %%a3@+     \n\t"   \
+        "movel  %%a2@+,  %%d1       \n\t"   \
+        "mulul  %%d2,    %%d3:%%d1  \n\t"   \
+        "addxl  %%d4,    %%d1       \n\t"   \
+        "addxl  %%d0,    %%d3       \n\t"   \
+        "addl   %%d1,    %%a3@+     \n\t"   \
+        "addxl  %%d0,    %%d3       \n\t"
+
+#endif /* MC68000 */
+
+#if defined(__powerpc64__) || defined(__ppc64__)
+
+#if defined(__MACH__) && defined(__APPLE__)
+
+#define MULADDC_INIT                        \
+    asm(                                    \
+        "ld     r3, %3              \n\t"   \
+        "ld     r4, %4              \n\t"   \
+        "ld     r5, %5              \n\t"   \
+        "ld     r6, %6              \n\t"   \
+        "addi   r3, r3, -8          \n\t"   \
+        "addi   r4, r4, -8          \n\t"   \
+        "addic  r5, r5,  0          \n\t"
+
+#define MULADDC_CORE                        \
+        "ldu    r7, 8(r3)           \n\t"   \
+        "mulld  r8, r7, r6          \n\t"   \
+        "mulhdu r9, r7, r6          \n\t"   \
+        "adde   r8, r8, r5          \n\t"   \
+        "ld     r7, 8(r4)           \n\t"   \
+        "addze  r5, r9              \n\t"   \
+        "addc   r8, r8, r7          \n\t"   \
+        "stdu   r8, 8(r4)           \n\t"
+
+#define MULADDC_STOP                        \
+        "addze  r5, r5              \n\t"   \
+        "addi   r4, r4, 8           \n\t"   \
+        "addi   r3, r3, 8           \n\t"   \
+        "std    r5, %0              \n\t"   \
+        "std    r4, %1              \n\t"   \
+        "std    r3, %2              \n\t"   \
+        : "=m" (c), "=m" (d), "=m" (s)              \
+        : "m" (s), "m" (d), "m" (c), "m" (b)        \
+        : "r3", "r4", "r5", "r6", "r7", "r8", "r9"  \
+    );
+
+
+#else /* __MACH__ && __APPLE__ */
+
+#define MULADDC_INIT                        \
+    asm(                                    \
+        "ld     %%r3, %3            \n\t"   \
+        "ld     %%r4, %4            \n\t"   \
+        "ld     %%r5, %5            \n\t"   \
+        "ld     %%r6, %6            \n\t"   \
+        "addi   %%r3, %%r3, -8      \n\t"   \
+        "addi   %%r4, %%r4, -8      \n\t"   \
+        "addic  %%r5, %%r5,  0      \n\t"
+
+#define MULADDC_CORE                        \
+        "ldu    %%r7, 8(%%r3)       \n\t"   \
+        "mulld  %%r8, %%r7, %%r6    \n\t"   \
+        "mulhdu %%r9, %%r7, %%r6    \n\t"   \
+        "adde   %%r8, %%r8, %%r5    \n\t"   \
+        "ld     %%r7, 8(%%r4)       \n\t"   \
+        "addze  %%r5, %%r9          \n\t"   \
+        "addc   %%r8, %%r8, %%r7    \n\t"   \
+        "stdu   %%r8, 8(%%r4)       \n\t"
+
+#define MULADDC_STOP                        \
+        "addze  %%r5, %%r5          \n\t"   \
+        "addi   %%r4, %%r4, 8       \n\t"   \
+        "addi   %%r3, %%r3, 8       \n\t"   \
+        "std    %%r5, %0            \n\t"   \
+        "std    %%r4, %1            \n\t"   \
+        "std    %%r3, %2            \n\t"   \
+        : "=m" (c), "=m" (d), "=m" (s)              \
+        : "m" (s), "m" (d), "m" (c), "m" (b)        \
+        : "r3", "r4", "r5", "r6", "r7", "r8", "r9"  \
+    );
+
+#endif /* __MACH__ && __APPLE__ */
+
+#elif defined(__powerpc__) || defined(__ppc__) /* end PPC64/begin PPC32  */
+
+#if defined(__MACH__) && defined(__APPLE__)
+
+#define MULADDC_INIT                    \
+    asm(                                \
+        "lwz    r3, %3          \n\t"   \
+        "lwz    r4, %4          \n\t"   \
+        "lwz    r5, %5          \n\t"   \
+        "lwz    r6, %6          \n\t"   \
+        "addi   r3, r3, -4      \n\t"   \
+        "addi   r4, r4, -4      \n\t"   \
+        "addic  r5, r5,  0      \n\t"
+
+#define MULADDC_CORE                    \
+        "lwzu   r7, 4(r3)       \n\t"   \
+        "mullw  r8, r7, r6      \n\t"   \
+        "mulhwu r9, r7, r6      \n\t"   \
+        "adde   r8, r8, r5      \n\t"   \
+        "lwz    r7, 4(r4)       \n\t"   \
+        "addze  r5, r9          \n\t"   \
+        "addc   r8, r8, r7      \n\t"   \
+        "stwu   r8, 4(r4)       \n\t"
+
+#define MULADDC_STOP                    \
+        "addze  r5, r5          \n\t"   \
+        "addi   r4, r4, 4       \n\t"   \
+        "addi   r3, r3, 4       \n\t"   \
+        "stw    r5, %0          \n\t"   \
+        "stw    r4, %1          \n\t"   \
+        "stw    r3, %2          \n\t"   \
+        : "=m" (c), "=m" (d), "=m" (s)              \
+        : "m" (s), "m" (d), "m" (c), "m" (b)        \
+        : "r3", "r4", "r5", "r6", "r7", "r8", "r9"  \
+    );
+
+#else /* __MACH__ && __APPLE__ */
+
+#define MULADDC_INIT                        \
+    asm(                                    \
+        "lwz    %%r3, %3            \n\t"   \
+        "lwz    %%r4, %4            \n\t"   \
+        "lwz    %%r5, %5            \n\t"   \
+        "lwz    %%r6, %6            \n\t"   \
+        "addi   %%r3, %%r3, -4      \n\t"   \
+        "addi   %%r4, %%r4, -4      \n\t"   \
+        "addic  %%r5, %%r5,  0      \n\t"
+
+#define MULADDC_CORE                        \
+        "lwzu   %%r7, 4(%%r3)       \n\t"   \
+        "mullw  %%r8, %%r7, %%r6    \n\t"   \
+        "mulhwu %%r9, %%r7, %%r6    \n\t"   \
+        "adde   %%r8, %%r8, %%r5    \n\t"   \
+        "lwz    %%r7, 4(%%r4)       \n\t"   \
+        "addze  %%r5, %%r9          \n\t"   \
+        "addc   %%r8, %%r8, %%r7    \n\t"   \
+        "stwu   %%r8, 4(%%r4)       \n\t"
+
+#define MULADDC_STOP                        \
+        "addze  %%r5, %%r5          \n\t"   \
+        "addi   %%r4, %%r4, 4       \n\t"   \
+        "addi   %%r3, %%r3, 4       \n\t"   \
+        "stw    %%r5, %0            \n\t"   \
+        "stw    %%r4, %1            \n\t"   \
+        "stw    %%r3, %2            \n\t"   \
+        : "=m" (c), "=m" (d), "=m" (s)              \
+        : "m" (s), "m" (d), "m" (c), "m" (b)        \
+        : "r3", "r4", "r5", "r6", "r7", "r8", "r9"  \
+    );
+
+#endif /* __MACH__ && __APPLE__ */
+
+#endif /* PPC32 */
+
+/*
+ * The Sparc(64) assembly is reported to be broken.
+ * Disable it for now, until we're able to fix it.
+ */
+#if 0 && defined(__sparc__)
+#if defined(__sparc64__)
+
+#define MULADDC_INIT                                    \
+    asm(                                                \
+                "ldx     %3, %%o0               \n\t"   \
+                "ldx     %4, %%o1               \n\t"   \
+                "ld      %5, %%o2               \n\t"   \
+                "ld      %6, %%o3               \n\t"
+
+#define MULADDC_CORE                                    \
+                "ld      [%%o0], %%o4           \n\t"   \
+                "inc     4, %%o0                \n\t"   \
+                "ld      [%%o1], %%o5           \n\t"   \
+                "umul    %%o3, %%o4, %%o4       \n\t"   \
+                "addcc   %%o4, %%o2, %%o4       \n\t"   \
+                "rd      %%y, %%g1              \n\t"   \
+                "addx    %%g1, 0, %%g1          \n\t"   \
+                "addcc   %%o4, %%o5, %%o4       \n\t"   \
+                "st      %%o4, [%%o1]           \n\t"   \
+                "addx    %%g1, 0, %%o2          \n\t"   \
+                "inc     4, %%o1                \n\t"
+
+        #define MULADDC_STOP                            \
+                "st      %%o2, %0               \n\t"   \
+                "stx     %%o1, %1               \n\t"   \
+                "stx     %%o0, %2               \n\t"   \
+        : "=m" (c), "=m" (d), "=m" (s)          \
+        : "m" (s), "m" (d), "m" (c), "m" (b)    \
+        : "g1", "o0", "o1", "o2", "o3", "o4",   \
+          "o5"                                  \
+        );
+
+#else /* __sparc64__ */
+
+#define MULADDC_INIT                                    \
+    asm(                                                \
+                "ld      %3, %%o0               \n\t"   \
+                "ld      %4, %%o1               \n\t"   \
+                "ld      %5, %%o2               \n\t"   \
+                "ld      %6, %%o3               \n\t"
+
+#define MULADDC_CORE                                    \
+                "ld      [%%o0], %%o4           \n\t"   \
+                "inc     4, %%o0                \n\t"   \
+                "ld      [%%o1], %%o5           \n\t"   \
+                "umul    %%o3, %%o4, %%o4       \n\t"   \
+                "addcc   %%o4, %%o2, %%o4       \n\t"   \
+                "rd      %%y, %%g1              \n\t"   \
+                "addx    %%g1, 0, %%g1          \n\t"   \
+                "addcc   %%o4, %%o5, %%o4       \n\t"   \
+                "st      %%o4, [%%o1]           \n\t"   \
+                "addx    %%g1, 0, %%o2          \n\t"   \
+                "inc     4, %%o1                \n\t"
+
+#define MULADDC_STOP                                    \
+                "st      %%o2, %0               \n\t"   \
+                "st      %%o1, %1               \n\t"   \
+                "st      %%o0, %2               \n\t"   \
+        : "=m" (c), "=m" (d), "=m" (s)          \
+        : "m" (s), "m" (d), "m" (c), "m" (b)    \
+        : "g1", "o0", "o1", "o2", "o3", "o4",   \
+          "o5"                                  \
+        );
+
+#endif /* __sparc64__ */
+#endif /* __sparc__ */
+
+#if defined(__microblaze__) || defined(microblaze)
+
+#define MULADDC_INIT                    \
+    asm(                                \
+        "lwi   r3,   %3         \n\t"   \
+        "lwi   r4,   %4         \n\t"   \
+        "lwi   r5,   %5         \n\t"   \
+        "lwi   r6,   %6         \n\t"   \
+        "andi  r7,   r6, 0xffff \n\t"   \
+        "bsrli r6,   r6, 16     \n\t"
+
+#define MULADDC_CORE                    \
+        "lhui  r8,   r3,   0    \n\t"   \
+        "addi  r3,   r3,   2    \n\t"   \
+        "lhui  r9,   r3,   0    \n\t"   \
+        "addi  r3,   r3,   2    \n\t"   \
+        "mul   r10,  r9,  r6    \n\t"   \
+        "mul   r11,  r8,  r7    \n\t"   \
+        "mul   r12,  r9,  r7    \n\t"   \
+        "mul   r13,  r8,  r6    \n\t"   \
+        "bsrli  r8, r10,  16    \n\t"   \
+        "bsrli  r9, r11,  16    \n\t"   \
+        "add   r13, r13,  r8    \n\t"   \
+        "add   r13, r13,  r9    \n\t"   \
+        "bslli r10, r10,  16    \n\t"   \
+        "bslli r11, r11,  16    \n\t"   \
+        "add   r12, r12, r10    \n\t"   \
+        "addc  r13, r13,  r0    \n\t"   \
+        "add   r12, r12, r11    \n\t"   \
+        "addc  r13, r13,  r0    \n\t"   \
+        "lwi   r10,  r4,   0    \n\t"   \
+        "add   r12, r12, r10    \n\t"   \
+        "addc  r13, r13,  r0    \n\t"   \
+        "add   r12, r12,  r5    \n\t"   \
+        "addc   r5, r13,  r0    \n\t"   \
+        "swi   r12,  r4,   0    \n\t"   \
+        "addi   r4,  r4,   4    \n\t"
+
+#define MULADDC_STOP                    \
+        "swi   r5,   %0         \n\t"   \
+        "swi   r4,   %1         \n\t"   \
+        "swi   r3,   %2         \n\t"   \
+        : "=m" (c), "=m" (d), "=m" (s)              \
+        : "m" (s), "m" (d), "m" (c), "m" (b)        \
+        : "r3", "r4"  "r5", "r6", "r7", "r8",       \
+          "r9", "r10", "r11", "r12", "r13"          \
+    );
+
+#endif /* MicroBlaze */
+
+#if defined(__tricore__)
+
+#define MULADDC_INIT                            \
+    asm(                                        \
+        "ld.a   %%a2, %3                \n\t"   \
+        "ld.a   %%a3, %4                \n\t"   \
+        "ld.w   %%d4, %5                \n\t"   \
+        "ld.w   %%d1, %6                \n\t"   \
+        "xor    %%d5, %%d5              \n\t"
+
+#define MULADDC_CORE                            \
+        "ld.w   %%d0,   [%%a2+]         \n\t"   \
+        "madd.u %%e2, %%e4, %%d0, %%d1  \n\t"   \
+        "ld.w   %%d0,   [%%a3]          \n\t"   \
+        "addx   %%d2,    %%d2,  %%d0    \n\t"   \
+        "addc   %%d3,    %%d3,    0     \n\t"   \
+        "mov    %%d4,    %%d3           \n\t"   \
+        "st.w  [%%a3+],  %%d2           \n\t"
+
+#define MULADDC_STOP                            \
+        "st.w   %0, %%d4                \n\t"   \
+        "st.a   %1, %%a3                \n\t"   \
+        "st.a   %2, %%a2                \n\t"   \
+        : "=m" (c), "=m" (d), "=m" (s)          \
+        : "m" (s), "m" (d), "m" (c), "m" (b)    \
+        : "d0", "d1", "e2", "d4", "a2", "a3"    \
+    );
+
+#endif /* TriCore */
+
+/*
+ * gcc -O0 by default uses r7 for the frame pointer, so it complains about our
+ * use of r7 below, unless -fomit-frame-pointer is passed. Unfortunately,
+ * passing that option is not easy when building with yotta.
+ *
+ * On the other hand, -fomit-frame-pointer is implied by any -Ox options with
+ * x !=0, which we can detect using __OPTIMIZE__ (which is also defined by
+ * clang and armcc5 under the same conditions).
+ *
+ * So, only use the optimized assembly below for optimized build, which avoids
+ * the build error and is pretty reasonable anyway.
+ */
+#if defined(__GNUC__) && !defined(__OPTIMIZE__)
+#define MULADDC_CANNOT_USE_R7
+#endif
+
+#if defined(__arm__) && !defined(MULADDC_CANNOT_USE_R7)
+
+#if defined(__thumb__) && !defined(__thumb2__)
+
+#define MULADDC_INIT                                    \
+    asm(                                                \
+            "ldr    r0, %3                      \n\t"   \
+            "ldr    r1, %4                      \n\t"   \
+            "ldr    r2, %5                      \n\t"   \
+            "ldr    r3, %6                      \n\t"   \
+            "lsr    r7, r3, #16                 \n\t"   \
+            "mov    r9, r7                      \n\t"   \
+            "lsl    r7, r3, #16                 \n\t"   \
+            "lsr    r7, r7, #16                 \n\t"   \
+            "mov    r8, r7                      \n\t"
+
+#define MULADDC_CORE                                    \
+            "ldmia  r0!, {r6}                   \n\t"   \
+            "lsr    r7, r6, #16                 \n\t"   \
+            "lsl    r6, r6, #16                 \n\t"   \
+            "lsr    r6, r6, #16                 \n\t"   \
+            "mov    r4, r8                      \n\t"   \
+            "mul    r4, r6                      \n\t"   \
+            "mov    r3, r9                      \n\t"   \
+            "mul    r6, r3                      \n\t"   \
+            "mov    r5, r9                      \n\t"   \
+            "mul    r5, r7                      \n\t"   \
+            "mov    r3, r8                      \n\t"   \
+            "mul    r7, r3                      \n\t"   \
+            "lsr    r3, r6, #16                 \n\t"   \
+            "add    r5, r5, r3                  \n\t"   \
+            "lsr    r3, r7, #16                 \n\t"   \
+            "add    r5, r5, r3                  \n\t"   \
+            "add    r4, r4, r2                  \n\t"   \
+            "mov    r2, #0                      \n\t"   \
+            "adc    r5, r2                      \n\t"   \
+            "lsl    r3, r6, #16                 \n\t"   \
+            "add    r4, r4, r3                  \n\t"   \
+            "adc    r5, r2                      \n\t"   \
+            "lsl    r3, r7, #16                 \n\t"   \
+            "add    r4, r4, r3                  \n\t"   \
+            "adc    r5, r2                      \n\t"   \
+            "ldr    r3, [r1]                    \n\t"   \
+            "add    r4, r4, r3                  \n\t"   \
+            "adc    r2, r5                      \n\t"   \
+            "stmia  r1!, {r4}                   \n\t"
+
+#define MULADDC_STOP                                    \
+            "str    r2, %0                      \n\t"   \
+            "str    r1, %1                      \n\t"   \
+            "str    r0, %2                      \n\t"   \
+         : "=m" (c),  "=m" (d), "=m" (s)        \
+         : "m" (s), "m" (d), "m" (c), "m" (b)   \
+         : "r0", "r1", "r2", "r3", "r4", "r5",  \
+           "r6", "r7", "r8", "r9", "cc"         \
+         );
+
+#else
+
+#define MULADDC_INIT                                    \
+    asm(                                                \
+            "ldr    r0, %3                      \n\t"   \
+            "ldr    r1, %4                      \n\t"   \
+            "ldr    r2, %5                      \n\t"   \
+            "ldr    r3, %6                      \n\t"
+
+#define MULADDC_CORE                                    \
+            "ldr    r4, [r0], #4                \n\t"   \
+            "mov    r5, #0                      \n\t"   \
+            "ldr    r6, [r1]                    \n\t"   \
+            "umlal  r2, r5, r3, r4              \n\t"   \
+            "adds   r7, r6, r2                  \n\t"   \
+            "adc    r2, r5, #0                  \n\t"   \
+            "str    r7, [r1], #4                \n\t"
+
+#define MULADDC_STOP                                    \
+            "str    r2, %0                      \n\t"   \
+            "str    r1, %1                      \n\t"   \
+            "str    r0, %2                      \n\t"   \
+         : "=m" (c),  "=m" (d), "=m" (s)        \
+         : "m" (s), "m" (d), "m" (c), "m" (b)   \
+         : "r0", "r1", "r2", "r3", "r4", "r5",  \
+           "r6", "r7", "cc"                     \
+         );
+
+#endif /* Thumb */
+
+#endif /* ARMv3 */
+
+#if defined(__alpha__)
+
+#define MULADDC_INIT                    \
+    asm(                                \
+        "ldq    $1, %3          \n\t"   \
+        "ldq    $2, %4          \n\t"   \
+        "ldq    $3, %5          \n\t"   \
+        "ldq    $4, %6          \n\t"
+
+#define MULADDC_CORE                    \
+        "ldq    $6,  0($1)      \n\t"   \
+        "addq   $1,  8, $1      \n\t"   \
+        "mulq   $6, $4, $7      \n\t"   \
+        "umulh  $6, $4, $6      \n\t"   \
+        "addq   $7, $3, $7      \n\t"   \
+        "cmpult $7, $3, $3      \n\t"   \
+        "ldq    $5,  0($2)      \n\t"   \
+        "addq   $7, $5, $7      \n\t"   \
+        "cmpult $7, $5, $5      \n\t"   \
+        "stq    $7,  0($2)      \n\t"   \
+        "addq   $2,  8, $2      \n\t"   \
+        "addq   $6, $3, $3      \n\t"   \
+        "addq   $5, $3, $3      \n\t"
+
+#define MULADDC_STOP                                    \
+        "stq    $3, %0          \n\t"   \
+        "stq    $2, %1          \n\t"   \
+        "stq    $1, %2          \n\t"   \
+        : "=m" (c), "=m" (d), "=m" (s)              \
+        : "m" (s), "m" (d), "m" (c), "m" (b)        \
+        : "$1", "$2", "$3", "$4", "$5", "$6", "$7"  \
+    );
+#endif /* Alpha */
+
+#if defined(__mips__) && !defined(__mips64)
+
+#define MULADDC_INIT                    \
+    asm(                                \
+        "lw     $10, %3         \n\t"   \
+        "lw     $11, %4         \n\t"   \
+        "lw     $12, %5         \n\t"   \
+        "lw     $13, %6         \n\t"
+
+#define MULADDC_CORE                    \
+        "lw     $14, 0($10)     \n\t"   \
+        "multu  $13, $14        \n\t"   \
+        "addi   $10, $10, 4     \n\t"   \
+        "mflo   $14             \n\t"   \
+        "mfhi   $9              \n\t"   \
+        "addu   $14, $12, $14   \n\t"   \
+        "lw     $15, 0($11)     \n\t"   \
+        "sltu   $12, $14, $12   \n\t"   \
+        "addu   $15, $14, $15   \n\t"   \
+        "sltu   $14, $15, $14   \n\t"   \
+        "addu   $12, $12, $9    \n\t"   \
+        "sw     $15, 0($11)     \n\t"   \
+        "addu   $12, $12, $14   \n\t"   \
+        "addi   $11, $11, 4     \n\t"
+
+#define MULADDC_STOP                    \
+        "sw     $12, %0         \n\t"   \
+        "sw     $11, %1         \n\t"   \
+        "sw     $10, %2         \n\t"   \
+        : "=m" (c), "=m" (d), "=m" (s)                      \
+        : "m" (s), "m" (d), "m" (c), "m" (b)                \
+        : "$9", "$10", "$11", "$12", "$13", "$14", "$15"    \
+    );
+
+#endif /* MIPS */
+#endif /* GNUC */
+
+#if (defined(_MSC_VER) && defined(_M_IX86)) || defined(__WATCOMC__)
+
+#define MULADDC_INIT                            \
+    __asm   mov     esi, s                      \
+    __asm   mov     edi, d                      \
+    __asm   mov     ecx, c                      \
+    __asm   mov     ebx, b
+
+#define MULADDC_CORE                            \
+    __asm   lodsd                               \
+    __asm   mul     ebx                         \
+    __asm   add     eax, ecx                    \
+    __asm   adc     edx, 0                      \
+    __asm   add     eax, [edi]                  \
+    __asm   adc     edx, 0                      \
+    __asm   mov     ecx, edx                    \
+    __asm   stosd
+
+#if defined(MBEDTLS_HAVE_SSE2)
+
+#define EMIT __asm _emit
+
+#define MULADDC_HUIT                            \
+    EMIT 0x0F  EMIT 0x6E  EMIT 0xC9             \
+    EMIT 0x0F  EMIT 0x6E  EMIT 0xC3             \
+    EMIT 0x0F  EMIT 0x6E  EMIT 0x1F             \
+    EMIT 0x0F  EMIT 0xD4  EMIT 0xCB             \
+    EMIT 0x0F  EMIT 0x6E  EMIT 0x16             \
+    EMIT 0x0F  EMIT 0xF4  EMIT 0xD0             \
+    EMIT 0x0F  EMIT 0x6E  EMIT 0x66  EMIT 0x04  \
+    EMIT 0x0F  EMIT 0xF4  EMIT 0xE0             \
+    EMIT 0x0F  EMIT 0x6E  EMIT 0x76  EMIT 0x08  \
+    EMIT 0x0F  EMIT 0xF4  EMIT 0xF0             \
+    EMIT 0x0F  EMIT 0x6E  EMIT 0x7E  EMIT 0x0C  \
+    EMIT 0x0F  EMIT 0xF4  EMIT 0xF8             \
+    EMIT 0x0F  EMIT 0xD4  EMIT 0xCA             \
+    EMIT 0x0F  EMIT 0x6E  EMIT 0x5F  EMIT 0x04  \
+    EMIT 0x0F  EMIT 0xD4  EMIT 0xDC             \
+    EMIT 0x0F  EMIT 0x6E  EMIT 0x6F  EMIT 0x08  \
+    EMIT 0x0F  EMIT 0xD4  EMIT 0xEE             \
+    EMIT 0x0F  EMIT 0x6E  EMIT 0x67  EMIT 0x0C  \
+    EMIT 0x0F  EMIT 0xD4  EMIT 0xFC             \
+    EMIT 0x0F  EMIT 0x7E  EMIT 0x0F             \
+    EMIT 0x0F  EMIT 0x6E  EMIT 0x56  EMIT 0x10  \
+    EMIT 0x0F  EMIT 0xF4  EMIT 0xD0             \
+    EMIT 0x0F  EMIT 0x73  EMIT 0xD1  EMIT 0x20  \
+    EMIT 0x0F  EMIT 0x6E  EMIT 0x66  EMIT 0x14  \
+    EMIT 0x0F  EMIT 0xF4  EMIT 0xE0             \
+    EMIT 0x0F  EMIT 0xD4  EMIT 0xCB             \
+    EMIT 0x0F  EMIT 0x6E  EMIT 0x76  EMIT 0x18  \
+    EMIT 0x0F  EMIT 0xF4  EMIT 0xF0             \
+    EMIT 0x0F  EMIT 0x7E  EMIT 0x4F  EMIT 0x04  \
+    EMIT 0x0F  EMIT 0x73  EMIT 0xD1  EMIT 0x20  \
+    EMIT 0x0F  EMIT 0x6E  EMIT 0x5E  EMIT 0x1C  \
+    EMIT 0x0F  EMIT 0xF4  EMIT 0xD8             \
+    EMIT 0x0F  EMIT 0xD4  EMIT 0xCD             \
+    EMIT 0x0F  EMIT 0x6E  EMIT 0x6F  EMIT 0x10  \
+    EMIT 0x0F  EMIT 0xD4  EMIT 0xD5             \
+    EMIT 0x0F  EMIT 0x7E  EMIT 0x4F  EMIT 0x08  \
+    EMIT 0x0F  EMIT 0x73  EMIT 0xD1  EMIT 0x20  \
+    EMIT 0x0F  EMIT 0xD4  EMIT 0xCF             \
+    EMIT 0x0F  EMIT 0x6E  EMIT 0x6F  EMIT 0x14  \
+    EMIT 0x0F  EMIT 0xD4  EMIT 0xE5             \
+    EMIT 0x0F  EMIT 0x7E  EMIT 0x4F  EMIT 0x0C  \
+    EMIT 0x0F  EMIT 0x73  EMIT 0xD1  EMIT 0x20  \
+    EMIT 0x0F  EMIT 0xD4  EMIT 0xCA             \
+    EMIT 0x0F  EMIT 0x6E  EMIT 0x6F  EMIT 0x18  \
+    EMIT 0x0F  EMIT 0xD4  EMIT 0xF5             \
+    EMIT 0x0F  EMIT 0x7E  EMIT 0x4F  EMIT 0x10  \
+    EMIT 0x0F  EMIT 0x73  EMIT 0xD1  EMIT 0x20  \
+    EMIT 0x0F  EMIT 0xD4  EMIT 0xCC             \
+    EMIT 0x0F  EMIT 0x6E  EMIT 0x6F  EMIT 0x1C  \
+    EMIT 0x0F  EMIT 0xD4  EMIT 0xDD             \
+    EMIT 0x0F  EMIT 0x7E  EMIT 0x4F  EMIT 0x14  \
+    EMIT 0x0F  EMIT 0x73  EMIT 0xD1  EMIT 0x20  \
+    EMIT 0x0F  EMIT 0xD4  EMIT 0xCE             \
+    EMIT 0x0F  EMIT 0x7E  EMIT 0x4F  EMIT 0x18  \
+    EMIT 0x0F  EMIT 0x73  EMIT 0xD1  EMIT 0x20  \
+    EMIT 0x0F  EMIT 0xD4  EMIT 0xCB             \
+    EMIT 0x0F  EMIT 0x7E  EMIT 0x4F  EMIT 0x1C  \
+    EMIT 0x83  EMIT 0xC7  EMIT 0x20             \
+    EMIT 0x83  EMIT 0xC6  EMIT 0x20             \
+    EMIT 0x0F  EMIT 0x73  EMIT 0xD1  EMIT 0x20  \
+    EMIT 0x0F  EMIT 0x7E  EMIT 0xC9
+
+#define MULADDC_STOP                            \
+    EMIT 0x0F  EMIT 0x77                        \
+    __asm   mov     c, ecx                      \
+    __asm   mov     d, edi                      \
+    __asm   mov     s, esi                      \
+
+#else
+
+#define MULADDC_STOP                            \
+    __asm   mov     c, ecx                      \
+    __asm   mov     d, edi                      \
+    __asm   mov     s, esi                      \
+
+#endif /* SSE2 */
+#endif /* MSVC */
+
+#endif /* MBEDTLS_HAVE_ASM */
+
+#if !defined(MULADDC_CORE)
+#if defined(MBEDTLS_HAVE_UDBL)
+
+#define MULADDC_INIT                    \
+{                                       \
+    mbedtls_t_udbl r;                           \
+    mbedtls_mpi_uint r0, r1;
+
+#define MULADDC_CORE                    \
+    r   = *(s++) * (mbedtls_t_udbl) b;          \
+    r0  = (mbedtls_mpi_uint) r;                   \
+    r1  = (mbedtls_mpi_uint)( r >> biL );         \
+    r0 += c;  r1 += (r0 <  c);          \
+    r0 += *d; r1 += (r0 < *d);          \
+    c = r1; *(d++) = r0;
+
+#define MULADDC_STOP                    \
+}
+
+#else
+#define MULADDC_INIT                    \
+{                                       \
+    mbedtls_mpi_uint s0, s1, b0, b1;              \
+    mbedtls_mpi_uint r0, r1, rx, ry;              \
+    b0 = ( b << biH ) >> biH;           \
+    b1 = ( b >> biH );
+
+#define MULADDC_CORE                    \
+    s0 = ( *s << biH ) >> biH;          \
+    s1 = ( *s >> biH ); s++;            \
+    rx = s0 * b1; r0 = s0 * b0;         \
+    ry = s1 * b0; r1 = s1 * b1;         \
+    r1 += ( rx >> biH );                \
+    r1 += ( ry >> biH );                \
+    rx <<= biH; ry <<= biH;             \
+    r0 += rx; r1 += (r0 < rx);          \
+    r0 += ry; r1 += (r0 < ry);          \
+    r0 +=  c; r1 += (r0 <  c);          \
+    r0 += *d; r1 += (r0 < *d);          \
+    c = r1; *(d++) = r0;
+
+#define MULADDC_STOP                    \
+}
+
+#endif /* C (generic)  */
+#endif /* C (longlong) */
+
+#endif /* bn_mul.h */
diff --git a/backport/compat/verification/mbedtls/config.h b/backport/compat/verification/mbedtls/config.h
new file mode 100644
index 000000000000..91d900de7169
--- /dev/null
+++ b/backport/compat/verification/mbedtls/config.h
@@ -0,0 +1,15 @@
+#ifndef __MBEDTLS_CONFIG_H
+#define __MBEDTLS_CONFIG_H
+#define MBEDTLS_RSA_C
+#define MBEDTLS_PKCS1_V15
+#define MBEDTLS_MD_C
+#define __OpenBSD__
+#define MBEDTLS_PLATFORM_C
+#define MBEDTLS_BIGNUM_C
+#define MBEDTLS_OID_C
+#define MBEDTLS_ASN1_PARSE_C
+#define MBEDTLS_NO_UDBL_DIVISION
+#define MBEDTLS_SHA256_C
+#include <linux/types.h>
+#include "platform.h"
+#endif /* __MBEDTLS_CONFIG_H */
diff --git a/backport/compat/verification/mbedtls/md.h b/backport/compat/verification/mbedtls/md.h
new file mode 100644
index 000000000000..9385116c14e5
--- /dev/null
+++ b/backport/compat/verification/mbedtls/md.h
@@ -0,0 +1,356 @@
+/**
+ * \file md.h
+ *
+ * \brief Generic message digest wrapper
+ *
+ * \author Adriaan de Jong <dejong@fox-it.com>
+ *
+ *  Copyright (C) 2006-2015, ARM Limited, All Rights Reserved
+ *  SPDX-License-Identifier: GPL-2.0
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ *  This file is part of mbed TLS (https://tls.mbed.org)
+ */
+#ifndef MBEDTLS_MD_H
+#define MBEDTLS_MD_H
+
+#include <stddef.h>
+
+#define MBEDTLS_ERR_MD_FEATURE_UNAVAILABLE                -0x5080  /**< The selected feature is not available. */
+#define MBEDTLS_ERR_MD_BAD_INPUT_DATA                     -0x5100  /**< Bad input parameters to function. */
+#define MBEDTLS_ERR_MD_ALLOC_FAILED                       -0x5180  /**< Failed to allocate memory. */
+#define MBEDTLS_ERR_MD_FILE_IO_ERROR                      -0x5200  /**< Opening or reading of file failed. */
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+typedef enum {
+    MBEDTLS_MD_NONE=0,
+    MBEDTLS_MD_MD2,
+    MBEDTLS_MD_MD4,
+    MBEDTLS_MD_MD5,
+    MBEDTLS_MD_SHA1,
+    MBEDTLS_MD_SHA224,
+    MBEDTLS_MD_SHA256,
+    MBEDTLS_MD_SHA384,
+    MBEDTLS_MD_SHA512,
+    MBEDTLS_MD_RIPEMD160,
+} mbedtls_md_type_t;
+
+#if defined(MBEDTLS_SHA512_C)
+#define MBEDTLS_MD_MAX_SIZE         64  /* longest known is SHA512 */
+#else
+#define MBEDTLS_MD_MAX_SIZE         32  /* longest known is SHA256 or less */
+#endif
+
+/**
+ * Opaque struct defined in md_internal.h
+ */
+typedef struct mbedtls_md_info_t mbedtls_md_info_t;
+
+/**
+ * Generic message digest context.
+ */
+typedef struct {
+    /** Information about the associated message digest */
+    const mbedtls_md_info_t *md_info;
+
+    /** Digest-specific context */
+    void *md_ctx;
+
+    /** HMAC part of the context */
+    void *hmac_ctx;
+} mbedtls_md_context_t;
+
+/**
+ * \brief Returns the list of digests supported by the generic digest module.
+ *
+ * \return          a statically allocated array of digests, the last entry
+ *                  is 0.
+ */
+const int *mbedtls_md_list( void );
+
+/**
+ * \brief           Returns the message digest information associated with the
+ *                  given digest name.
+ *
+ * \param md_name   Name of the digest to search for.
+ *
+ * \return          The message digest information associated with md_name or
+ *                  NULL if not found.
+ */
+const mbedtls_md_info_t *mbedtls_md_info_from_string( const char *md_name );
+
+/**
+ * \brief           Returns the message digest information associated with the
+ *                  given digest type.
+ *
+ * \param md_type   type of digest to search for.
+ *
+ * \return          The message digest information associated with md_type or
+ *                  NULL if not found.
+ */
+const mbedtls_md_info_t *mbedtls_md_info_from_type( mbedtls_md_type_t md_type );
+
+/**
+ * \brief           Initialize a md_context (as NONE)
+ *                  This should always be called first.
+ *                  Prepares the context for mbedtls_md_setup() or mbedtls_md_free().
+ */
+void mbedtls_md_init( mbedtls_md_context_t *ctx );
+
+/**
+ * \brief           Free and clear the internal structures of ctx.
+ *                  Can be called at any time after mbedtls_md_init().
+ *                  Mandatory once mbedtls_md_setup() has been called.
+ */
+void mbedtls_md_free( mbedtls_md_context_t *ctx );
+
+#if ! defined(MBEDTLS_DEPRECATED_REMOVED)
+#if defined(MBEDTLS_DEPRECATED_WARNING)
+#define MBEDTLS_DEPRECATED    __attribute__((deprecated))
+#else
+#define MBEDTLS_DEPRECATED
+#endif
+/**
+ * \brief           Select MD to use and allocate internal structures.
+ *                  Should be called after mbedtls_md_init() or mbedtls_md_free().
+ *                  Makes it necessary to call mbedtls_md_free() later.
+ *
+ * \deprecated      Superseded by mbedtls_md_setup() in 2.0.0
+ *
+ * \param ctx       Context to set up.
+ * \param md_info   Message digest to use.
+ *
+ * \returns         \c 0 on success,
+ *                  \c MBEDTLS_ERR_MD_BAD_INPUT_DATA on parameter failure,
+ *                  \c MBEDTLS_ERR_MD_ALLOC_FAILED memory allocation failure.
+ */
+int mbedtls_md_init_ctx( mbedtls_md_context_t *ctx, const mbedtls_md_info_t *md_info ) MBEDTLS_DEPRECATED;
+#undef MBEDTLS_DEPRECATED
+#endif /* MBEDTLS_DEPRECATED_REMOVED */
+
+/**
+ * \brief           Select MD to use and allocate internal structures.
+ *                  Should be called after mbedtls_md_init() or mbedtls_md_free().
+ *                  Makes it necessary to call mbedtls_md_free() later.
+ *
+ * \param ctx       Context to set up.
+ * \param md_info   Message digest to use.
+ * \param hmac      0 to save some memory if HMAC will not be used,
+ *                  non-zero is HMAC is going to be used with this context.
+ *
+ * \returns         \c 0 on success,
+ *                  \c MBEDTLS_ERR_MD_BAD_INPUT_DATA on parameter failure,
+ *                  \c MBEDTLS_ERR_MD_ALLOC_FAILED memory allocation failure.
+ */
+int mbedtls_md_setup( mbedtls_md_context_t *ctx, const mbedtls_md_info_t *md_info, int hmac );
+
+/**
+ * \brief           Clone the state of an MD context
+ *
+ * \note            The two contexts must have been setup to the same type
+ *                  (cloning from SHA-256 to SHA-512 make no sense).
+ *
+ * \warning         Only clones the MD state, not the HMAC state! (for now)
+ *
+ * \param dst       The destination context
+ * \param src       The context to be cloned
+ *
+ * \return          \c 0 on success,
+ *                  \c MBEDTLS_ERR_MD_BAD_INPUT_DATA on parameter failure.
+ */
+int mbedtls_md_clone( mbedtls_md_context_t *dst,
+                      const mbedtls_md_context_t *src );
+
+/**
+ * \brief           Returns the size of the message digest output.
+ *
+ * \param md_info   message digest info
+ *
+ * \return          size of the message digest output in bytes.
+ */
+unsigned char mbedtls_md_get_size( const mbedtls_md_info_t *md_info );
+
+/**
+ * \brief           Returns the type of the message digest output.
+ *
+ * \param md_info   message digest info
+ *
+ * \return          type of the message digest output.
+ */
+mbedtls_md_type_t mbedtls_md_get_type( const mbedtls_md_info_t *md_info );
+
+/**
+ * \brief           Returns the name of the message digest output.
+ *
+ * \param md_info   message digest info
+ *
+ * \return          name of the message digest output.
+ */
+const char *mbedtls_md_get_name( const mbedtls_md_info_t *md_info );
+
+/**
+ * \brief           Prepare the context to digest a new message.
+ *                  Generally called after mbedtls_md_setup() or mbedtls_md_finish().
+ *                  Followed by mbedtls_md_update().
+ *
+ * \param ctx       generic message digest context.
+ *
+ * \returns         0 on success, MBEDTLS_ERR_MD_BAD_INPUT_DATA if parameter
+ *                  verification fails.
+ */
+int mbedtls_md_starts( mbedtls_md_context_t *ctx );
+
+/**
+ * \brief           Generic message digest process buffer
+ *                  Called between mbedtls_md_starts() and mbedtls_md_finish().
+ *                  May be called repeatedly.
+ *
+ * \param ctx       Generic message digest context
+ * \param input     buffer holding the  datal
+ * \param ilen      length of the input data
+ *
+ * \returns         0 on success, MBEDTLS_ERR_MD_BAD_INPUT_DATA if parameter
+ *                  verification fails.
+ */
+int mbedtls_md_update( mbedtls_md_context_t *ctx, const unsigned char *input, size_t ilen );
+
+/**
+ * \brief           Generic message digest final digest
+ *                  Called after mbedtls_md_update().
+ *                  Usually followed by mbedtls_md_free() or mbedtls_md_starts().
+ *
+ * \param ctx       Generic message digest context
+ * \param output    Generic message digest checksum result
+ *
+ * \returns         0 on success, MBEDTLS_ERR_MD_BAD_INPUT_DATA if parameter
+ *                  verification fails.
+ */
+int mbedtls_md_finish( mbedtls_md_context_t *ctx, unsigned char *output );
+
+/**
+ * \brief          Output = message_digest( input buffer )
+ *
+ * \param md_info  message digest info
+ * \param input    buffer holding the  data
+ * \param ilen     length of the input data
+ * \param output   Generic message digest checksum result
+ *
+ * \returns        0 on success, MBEDTLS_ERR_MD_BAD_INPUT_DATA if parameter
+ *                 verification fails.
+ */
+int mbedtls_md( const mbedtls_md_info_t *md_info, const unsigned char *input, size_t ilen,
+        unsigned char *output );
+
+#if defined(MBEDTLS_FS_IO)
+/**
+ * \brief          Output = message_digest( file contents )
+ *
+ * \param md_info  message digest info
+ * \param path     input file name
+ * \param output   generic message digest checksum result
+ *
+ * \return         0 if successful,
+ *                 MBEDTLS_ERR_MD_FILE_IO_ERROR if file input failed,
+ *                 MBEDTLS_ERR_MD_BAD_INPUT_DATA if md_info was NULL.
+ */
+int mbedtls_md_file( const mbedtls_md_info_t *md_info, const char *path,
+                     unsigned char *output );
+#endif /* MBEDTLS_FS_IO */
+
+/**
+ * \brief           Set HMAC key and prepare to authenticate a new message.
+ *                  Usually called after mbedtls_md_setup() or mbedtls_md_hmac_finish().
+ *
+ * \param ctx       HMAC context
+ * \param key       HMAC secret key
+ * \param keylen    length of the HMAC key in bytes
+ *
+ * \returns         0 on success, MBEDTLS_ERR_MD_BAD_INPUT_DATA if parameter
+ *                  verification fails.
+ */
+int mbedtls_md_hmac_starts( mbedtls_md_context_t *ctx, const unsigned char *key,
+                    size_t keylen );
+
+/**
+ * \brief           Generic HMAC process buffer.
+ *                  Called between mbedtls_md_hmac_starts() or mbedtls_md_hmac_reset()
+ *                  and mbedtls_md_hmac_finish().
+ *                  May be called repeatedly.
+ *
+ * \param ctx       HMAC context
+ * \param input     buffer holding the  data
+ * \param ilen      length of the input data
+ *
+ * \returns         0 on success, MBEDTLS_ERR_MD_BAD_INPUT_DATA if parameter
+ *                  verification fails.
+ */
+int mbedtls_md_hmac_update( mbedtls_md_context_t *ctx, const unsigned char *input,
+                    size_t ilen );
+
+/**
+ * \brief           Output HMAC.
+ *                  Called after mbedtls_md_hmac_update().
+ *                  Usually followed by mbedtls_md_hmac_reset(),
+ *                  mbedtls_md_hmac_starts(), or mbedtls_md_free().
+ *
+ * \param ctx       HMAC context
+ * \param output    Generic HMAC checksum result
+ *
+ * \returns         0 on success, MBEDTLS_ERR_MD_BAD_INPUT_DATA if parameter
+ *                  verification fails.
+ */
+int mbedtls_md_hmac_finish( mbedtls_md_context_t *ctx, unsigned char *output);
+
+/**
+ * \brief           Prepare to authenticate a new message with the same key.
+ *                  Called after mbedtls_md_hmac_finish() and before
+ *                  mbedtls_md_hmac_update().
+ *
+ * \param ctx       HMAC context to be reset
+ *
+ * \returns         0 on success, MBEDTLS_ERR_MD_BAD_INPUT_DATA if parameter
+ *                  verification fails.
+ */
+int mbedtls_md_hmac_reset( mbedtls_md_context_t *ctx );
+
+/**
+ * \brief          Output = Generic_HMAC( hmac key, input buffer )
+ *
+ * \param md_info  message digest info
+ * \param key      HMAC secret key
+ * \param keylen   length of the HMAC key in bytes
+ * \param input    buffer holding the  data
+ * \param ilen     length of the input data
+ * \param output   Generic HMAC-result
+ *
+ * \returns        0 on success, MBEDTLS_ERR_MD_BAD_INPUT_DATA if parameter
+ *                 verification fails.
+ */
+int mbedtls_md_hmac( const mbedtls_md_info_t *md_info, const unsigned char *key, size_t keylen,
+                const unsigned char *input, size_t ilen,
+                unsigned char *output );
+
+/* Internal use */
+int mbedtls_md_process( mbedtls_md_context_t *ctx, const unsigned char *data );
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* MBEDTLS_MD_H */
diff --git a/backport/compat/verification/mbedtls/md_internal.h b/backport/compat/verification/mbedtls/md_internal.h
new file mode 100644
index 000000000000..0a8600b407b0
--- /dev/null
+++ b/backport/compat/verification/mbedtls/md_internal.h
@@ -0,0 +1,116 @@
+/**
+ * \file md_internal.h
+ *
+ * \brief Message digest wrappers.
+ *
+ * \warning This in an internal header. Do not include directly.
+ *
+ * \author Adriaan de Jong <dejong@fox-it.com>
+ *
+ *  Copyright (C) 2006-2015, ARM Limited, All Rights Reserved
+ *  SPDX-License-Identifier: GPL-2.0
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ *  This file is part of mbed TLS (https://tls.mbed.org)
+ */
+#ifndef MBEDTLS_MD_WRAP_H
+#define MBEDTLS_MD_WRAP_H
+
+#if !defined(MBEDTLS_CONFIG_FILE)
+#include "config.h"
+#else
+#include MBEDTLS_CONFIG_FILE
+#endif
+
+#include "md.h"
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/**
+ * Message digest information.
+ * Allows message digest functions to be called in a generic way.
+ */
+struct mbedtls_md_info_t
+{
+    /** Digest identifier */
+    mbedtls_md_type_t type;
+
+    /** Name of the message digest */
+    const char * name;
+
+    /** Output length of the digest function in bytes */
+    int size;
+
+    /** Block length of the digest function in bytes */
+    int block_size;
+
+    /** Digest initialisation function */
+    void (*starts_func)( void *ctx );
+
+    /** Digest update function */
+    void (*update_func)( void *ctx, const unsigned char *input, size_t ilen );
+
+    /** Digest finalisation function */
+    void (*finish_func)( void *ctx, unsigned char *output );
+
+    /** Generic digest function */
+    void (*digest_func)( const unsigned char *input, size_t ilen,
+                         unsigned char *output );
+
+    /** Allocate a new context */
+    void * (*ctx_alloc_func)( void );
+
+    /** Free the given context */
+    void (*ctx_free_func)( void *ctx );
+
+    /** Clone state from a context */
+    void (*clone_func)( void *dst, const void *src );
+
+    /** Internal use only */
+    void (*process_func)( void *ctx, const unsigned char *input );
+};
+
+#if defined(MBEDTLS_MD2_C)
+extern const mbedtls_md_info_t mbedtls_md2_info;
+#endif
+#if defined(MBEDTLS_MD4_C)
+extern const mbedtls_md_info_t mbedtls_md4_info;
+#endif
+#if defined(MBEDTLS_MD5_C)
+extern const mbedtls_md_info_t mbedtls_md5_info;
+#endif
+#if defined(MBEDTLS_RIPEMD160_C)
+extern const mbedtls_md_info_t mbedtls_ripemd160_info;
+#endif
+#if defined(MBEDTLS_SHA1_C)
+extern const mbedtls_md_info_t mbedtls_sha1_info;
+#endif
+#if defined(MBEDTLS_SHA256_C)
+extern const mbedtls_md_info_t mbedtls_sha224_info;
+extern const mbedtls_md_info_t mbedtls_sha256_info;
+#endif
+#if defined(MBEDTLS_SHA512_C)
+extern const mbedtls_md_info_t mbedtls_sha384_info;
+extern const mbedtls_md_info_t mbedtls_sha512_info;
+#endif
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* MBEDTLS_MD_WRAP_H */
diff --git a/backport/compat/verification/mbedtls/oid.h b/backport/compat/verification/mbedtls/oid.h
new file mode 100644
index 000000000000..117ee47567bf
--- /dev/null
+++ b/backport/compat/verification/mbedtls/oid.h
@@ -0,0 +1,572 @@
+/**
+ * \file oid.h
+ *
+ * \brief Object Identifier (OID) database
+ *
+ *  Copyright (C) 2006-2015, ARM Limited, All Rights Reserved
+ *  SPDX-License-Identifier: GPL-2.0
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ *  This file is part of mbed TLS (https://tls.mbed.org)
+ */
+#ifndef MBEDTLS_OID_H
+#define MBEDTLS_OID_H
+
+#if !defined(MBEDTLS_CONFIG_FILE)
+#include "config.h"
+#else
+#include MBEDTLS_CONFIG_FILE
+#endif
+
+#include "asn1.h"
+#include "pk.h"
+
+#include <stddef.h>
+
+#if defined(MBEDTLS_CIPHER_C)
+#include "cipher.h"
+#endif
+
+#if defined(MBEDTLS_MD_C)
+#include "md.h"
+#endif
+
+#if defined(MBEDTLS_X509_USE_C) || defined(MBEDTLS_X509_CREATE_C)
+#include "x509.h"
+#endif
+
+#define MBEDTLS_ERR_OID_NOT_FOUND                         -0x002E  /**< OID is not found. */
+#define MBEDTLS_ERR_OID_BUF_TOO_SMALL                     -0x000B  /**< output buffer is too small */
+
+/*
+ * Top level OID tuples
+ */
+#define MBEDTLS_OID_ISO_MEMBER_BODIES           "\x2a"          /* {iso(1) member-body(2)} */
+#define MBEDTLS_OID_ISO_IDENTIFIED_ORG          "\x2b"          /* {iso(1) identified-organization(3)} */
+#define MBEDTLS_OID_ISO_CCITT_DS                "\x55"          /* {joint-iso-ccitt(2) ds(5)} */
+#define MBEDTLS_OID_ISO_ITU_COUNTRY             "\x60"          /* {joint-iso-itu-t(2) country(16)} */
+
+/*
+ * ISO Member bodies OID parts
+ */
+#define MBEDTLS_OID_COUNTRY_US                  "\x86\x48"      /* {us(840)} */
+#define MBEDTLS_OID_ORG_RSA_DATA_SECURITY       "\x86\xf7\x0d"  /* {rsadsi(113549)} */
+#define MBEDTLS_OID_RSA_COMPANY                 MBEDTLS_OID_ISO_MEMBER_BODIES MBEDTLS_OID_COUNTRY_US \
+                                        MBEDTLS_OID_ORG_RSA_DATA_SECURITY /* {iso(1) member-body(2) us(840) rsadsi(113549)} */
+#define MBEDTLS_OID_ORG_ANSI_X9_62              "\xce\x3d" /* ansi-X9-62(10045) */
+#define MBEDTLS_OID_ANSI_X9_62                  MBEDTLS_OID_ISO_MEMBER_BODIES MBEDTLS_OID_COUNTRY_US \
+                                        MBEDTLS_OID_ORG_ANSI_X9_62
+
+/*
+ * ISO Identified organization OID parts
+ */
+#define MBEDTLS_OID_ORG_DOD                     "\x06"          /* {dod(6)} */
+#define MBEDTLS_OID_ORG_OIW                     "\x0e"
+#define MBEDTLS_OID_OIW_SECSIG                  MBEDTLS_OID_ORG_OIW "\x03"
+#define MBEDTLS_OID_OIW_SECSIG_ALG              MBEDTLS_OID_OIW_SECSIG "\x02"
+#define MBEDTLS_OID_OIW_SECSIG_SHA1             MBEDTLS_OID_OIW_SECSIG_ALG "\x1a"
+#define MBEDTLS_OID_ORG_CERTICOM                "\x81\x04"  /* certicom(132) */
+#define MBEDTLS_OID_CERTICOM                    MBEDTLS_OID_ISO_IDENTIFIED_ORG MBEDTLS_OID_ORG_CERTICOM
+#define MBEDTLS_OID_ORG_TELETRUST               "\x24" /* teletrust(36) */
+#define MBEDTLS_OID_TELETRUST                   MBEDTLS_OID_ISO_IDENTIFIED_ORG MBEDTLS_OID_ORG_TELETRUST
+
+/*
+ * ISO ITU OID parts
+ */
+#define MBEDTLS_OID_ORGANIZATION                "\x01"          /* {organization(1)} */
+#define MBEDTLS_OID_ISO_ITU_US_ORG              MBEDTLS_OID_ISO_ITU_COUNTRY MBEDTLS_OID_COUNTRY_US MBEDTLS_OID_ORGANIZATION /* {joint-iso-itu-t(2) country(16) us(840) organization(1)} */
+
+#define MBEDTLS_OID_ORG_GOV                     "\x65"          /* {gov(101)} */
+#define MBEDTLS_OID_GOV                         MBEDTLS_OID_ISO_ITU_US_ORG MBEDTLS_OID_ORG_GOV /* {joint-iso-itu-t(2) country(16) us(840) organization(1) gov(101)} */
+
+#define MBEDTLS_OID_ORG_NETSCAPE                "\x86\xF8\x42"  /* {netscape(113730)} */
+#define MBEDTLS_OID_NETSCAPE                    MBEDTLS_OID_ISO_ITU_US_ORG MBEDTLS_OID_ORG_NETSCAPE /* Netscape OID {joint-iso-itu-t(2) country(16) us(840) organization(1) netscape(113730)} */
+
+/* ISO arc for standard certificate and CRL extensions */
+#define MBEDTLS_OID_ID_CE                       MBEDTLS_OID_ISO_CCITT_DS "\x1D" /**< id-ce OBJECT IDENTIFIER  ::=  {joint-iso-ccitt(2) ds(5) 29} */
+
+/**
+ * Private Internet Extensions
+ * { iso(1) identified-organization(3) dod(6) internet(1)
+ *                      security(5) mechanisms(5) pkix(7) }
+ */
+#define MBEDTLS_OID_PKIX                        MBEDTLS_OID_ISO_IDENTIFIED_ORG MBEDTLS_OID_ORG_DOD "\x01\x05\x05\x07"
+
+/*
+ * Arc for standard naming attributes
+ */
+#define MBEDTLS_OID_AT                          MBEDTLS_OID_ISO_CCITT_DS "\x04" /**< id-at OBJECT IDENTIFIER ::= {joint-iso-ccitt(2) ds(5) 4} */
+#define MBEDTLS_OID_AT_CN                       MBEDTLS_OID_AT "\x03" /**< id-at-commonName AttributeType:= {id-at 3} */
+#define MBEDTLS_OID_AT_SUR_NAME                 MBEDTLS_OID_AT "\x04" /**< id-at-surName AttributeType:= {id-at 4} */
+#define MBEDTLS_OID_AT_SERIAL_NUMBER            MBEDTLS_OID_AT "\x05" /**< id-at-serialNumber AttributeType:= {id-at 5} */
+#define MBEDTLS_OID_AT_COUNTRY                  MBEDTLS_OID_AT "\x06" /**< id-at-countryName AttributeType:= {id-at 6} */
+#define MBEDTLS_OID_AT_LOCALITY                 MBEDTLS_OID_AT "\x07" /**< id-at-locality AttributeType:= {id-at 7} */
+#define MBEDTLS_OID_AT_STATE                    MBEDTLS_OID_AT "\x08" /**< id-at-state AttributeType:= {id-at 8} */
+#define MBEDTLS_OID_AT_ORGANIZATION             MBEDTLS_OID_AT "\x0A" /**< id-at-organizationName AttributeType:= {id-at 10} */
+#define MBEDTLS_OID_AT_ORG_UNIT                 MBEDTLS_OID_AT "\x0B" /**< id-at-organizationalUnitName AttributeType:= {id-at 11} */
+#define MBEDTLS_OID_AT_TITLE                    MBEDTLS_OID_AT "\x0C" /**< id-at-title AttributeType:= {id-at 12} */
+#define MBEDTLS_OID_AT_POSTAL_ADDRESS           MBEDTLS_OID_AT "\x10" /**< id-at-postalAddress AttributeType:= {id-at 16} */
+#define MBEDTLS_OID_AT_POSTAL_CODE              MBEDTLS_OID_AT "\x11" /**< id-at-postalCode AttributeType:= {id-at 17} */
+#define MBEDTLS_OID_AT_GIVEN_NAME               MBEDTLS_OID_AT "\x2A" /**< id-at-givenName AttributeType:= {id-at 42} */
+#define MBEDTLS_OID_AT_INITIALS                 MBEDTLS_OID_AT "\x2B" /**< id-at-initials AttributeType:= {id-at 43} */
+#define MBEDTLS_OID_AT_GENERATION_QUALIFIER     MBEDTLS_OID_AT "\x2C" /**< id-at-generationQualifier AttributeType:= {id-at 44} */
+#define MBEDTLS_OID_AT_UNIQUE_IDENTIFIER        MBEDTLS_OID_AT "\x2D" /**< id-at-uniqueIdentifier AttributType:= {id-at 45} */
+#define MBEDTLS_OID_AT_DN_QUALIFIER             MBEDTLS_OID_AT "\x2E" /**< id-at-dnQualifier AttributeType:= {id-at 46} */
+#define MBEDTLS_OID_AT_PSEUDONYM                MBEDTLS_OID_AT "\x41" /**< id-at-pseudonym AttributeType:= {id-at 65} */
+
+#define MBEDTLS_OID_DOMAIN_COMPONENT            "\x09\x92\x26\x89\x93\xF2\x2C\x64\x01\x19" /** id-domainComponent AttributeType:= {itu-t(0) data(9) pss(2342) ucl(19200300) pilot(100) pilotAttributeType(1) domainComponent(25)} */
+
+/*
+ * OIDs for standard certificate extensions
+ */
+#define MBEDTLS_OID_AUTHORITY_KEY_IDENTIFIER    MBEDTLS_OID_ID_CE "\x23" /**< id-ce-authorityKeyIdentifier OBJECT IDENTIFIER ::=  { id-ce 35 } */
+#define MBEDTLS_OID_SUBJECT_KEY_IDENTIFIER      MBEDTLS_OID_ID_CE "\x0E" /**< id-ce-subjectKeyIdentifier OBJECT IDENTIFIER ::=  { id-ce 14 } */
+#define MBEDTLS_OID_KEY_USAGE                   MBEDTLS_OID_ID_CE "\x0F" /**< id-ce-keyUsage OBJECT IDENTIFIER ::=  { id-ce 15 } */
+#define MBEDTLS_OID_CERTIFICATE_POLICIES        MBEDTLS_OID_ID_CE "\x20" /**< id-ce-certificatePolicies OBJECT IDENTIFIER ::=  { id-ce 32 } */
+#define MBEDTLS_OID_POLICY_MAPPINGS             MBEDTLS_OID_ID_CE "\x21" /**< id-ce-policyMappings OBJECT IDENTIFIER ::=  { id-ce 33 } */
+#define MBEDTLS_OID_SUBJECT_ALT_NAME            MBEDTLS_OID_ID_CE "\x11" /**< id-ce-subjectAltName OBJECT IDENTIFIER ::=  { id-ce 17 } */
+#define MBEDTLS_OID_ISSUER_ALT_NAME             MBEDTLS_OID_ID_CE "\x12" /**< id-ce-issuerAltName OBJECT IDENTIFIER ::=  { id-ce 18 } */
+#define MBEDTLS_OID_SUBJECT_DIRECTORY_ATTRS     MBEDTLS_OID_ID_CE "\x09" /**< id-ce-subjectDirectoryAttributes OBJECT IDENTIFIER ::=  { id-ce 9 } */
+#define MBEDTLS_OID_BASIC_CONSTRAINTS           MBEDTLS_OID_ID_CE "\x13" /**< id-ce-basicConstraints OBJECT IDENTIFIER ::=  { id-ce 19 } */
+#define MBEDTLS_OID_NAME_CONSTRAINTS            MBEDTLS_OID_ID_CE "\x1E" /**< id-ce-nameConstraints OBJECT IDENTIFIER ::=  { id-ce 30 } */
+#define MBEDTLS_OID_POLICY_CONSTRAINTS          MBEDTLS_OID_ID_CE "\x24" /**< id-ce-policyConstraints OBJECT IDENTIFIER ::=  { id-ce 36 } */
+#define MBEDTLS_OID_EXTENDED_KEY_USAGE          MBEDTLS_OID_ID_CE "\x25" /**< id-ce-extKeyUsage OBJECT IDENTIFIER ::= { id-ce 37 } */
+#define MBEDTLS_OID_CRL_DISTRIBUTION_POINTS     MBEDTLS_OID_ID_CE "\x1F" /**< id-ce-cRLDistributionPoints OBJECT IDENTIFIER ::=  { id-ce 31 } */
+#define MBEDTLS_OID_INIHIBIT_ANYPOLICY          MBEDTLS_OID_ID_CE "\x36" /**< id-ce-inhibitAnyPolicy OBJECT IDENTIFIER ::=  { id-ce 54 } */
+#define MBEDTLS_OID_FRESHEST_CRL                MBEDTLS_OID_ID_CE "\x2E" /**< id-ce-freshestCRL OBJECT IDENTIFIER ::=  { id-ce 46 } */
+
+/*
+ * Netscape certificate extensions
+ */
+#define MBEDTLS_OID_NS_CERT                 MBEDTLS_OID_NETSCAPE "\x01"
+#define MBEDTLS_OID_NS_CERT_TYPE            MBEDTLS_OID_NS_CERT  "\x01"
+#define MBEDTLS_OID_NS_BASE_URL             MBEDTLS_OID_NS_CERT  "\x02"
+#define MBEDTLS_OID_NS_REVOCATION_URL       MBEDTLS_OID_NS_CERT  "\x03"
+#define MBEDTLS_OID_NS_CA_REVOCATION_URL    MBEDTLS_OID_NS_CERT  "\x04"
+#define MBEDTLS_OID_NS_RENEWAL_URL          MBEDTLS_OID_NS_CERT  "\x07"
+#define MBEDTLS_OID_NS_CA_POLICY_URL        MBEDTLS_OID_NS_CERT  "\x08"
+#define MBEDTLS_OID_NS_SSL_SERVER_NAME      MBEDTLS_OID_NS_CERT  "\x0C"
+#define MBEDTLS_OID_NS_COMMENT              MBEDTLS_OID_NS_CERT  "\x0D"
+#define MBEDTLS_OID_NS_DATA_TYPE            MBEDTLS_OID_NETSCAPE "\x02"
+#define MBEDTLS_OID_NS_CERT_SEQUENCE        MBEDTLS_OID_NS_DATA_TYPE "\x05"
+
+/*
+ * OIDs for CRL extensions
+ */
+#define MBEDTLS_OID_PRIVATE_KEY_USAGE_PERIOD    MBEDTLS_OID_ID_CE "\x10"
+#define MBEDTLS_OID_CRL_NUMBER                  MBEDTLS_OID_ID_CE "\x14" /**< id-ce-cRLNumber OBJECT IDENTIFIER ::= { id-ce 20 } */
+
+/*
+ * X.509 v3 Extended key usage OIDs
+ */
+#define MBEDTLS_OID_ANY_EXTENDED_KEY_USAGE      MBEDTLS_OID_EXTENDED_KEY_USAGE "\x00" /**< anyExtendedKeyUsage OBJECT IDENTIFIER ::= { id-ce-extKeyUsage 0 } */
+
+#define MBEDTLS_OID_KP                          MBEDTLS_OID_PKIX "\x03" /**< id-kp OBJECT IDENTIFIER ::= { id-pkix 3 } */
+#define MBEDTLS_OID_SERVER_AUTH                 MBEDTLS_OID_KP "\x01" /**< id-kp-serverAuth OBJECT IDENTIFIER ::= { id-kp 1 } */
+#define MBEDTLS_OID_CLIENT_AUTH                 MBEDTLS_OID_KP "\x02" /**< id-kp-clientAuth OBJECT IDENTIFIER ::= { id-kp 2 } */
+#define MBEDTLS_OID_CODE_SIGNING                MBEDTLS_OID_KP "\x03" /**< id-kp-codeSigning OBJECT IDENTIFIER ::= { id-kp 3 } */
+#define MBEDTLS_OID_EMAIL_PROTECTION            MBEDTLS_OID_KP "\x04" /**< id-kp-emailProtection OBJECT IDENTIFIER ::= { id-kp 4 } */
+#define MBEDTLS_OID_TIME_STAMPING               MBEDTLS_OID_KP "\x08" /**< id-kp-timeStamping OBJECT IDENTIFIER ::= { id-kp 8 } */
+#define MBEDTLS_OID_OCSP_SIGNING                MBEDTLS_OID_KP "\x09" /**< id-kp-OCSPSigning OBJECT IDENTIFIER ::= { id-kp 9 } */
+
+/*
+ * PKCS definition OIDs
+ */
+
+#define MBEDTLS_OID_PKCS                MBEDTLS_OID_RSA_COMPANY "\x01" /**< pkcs OBJECT IDENTIFIER ::= { iso(1) member-body(2) us(840) rsadsi(113549) 1 } */
+#define MBEDTLS_OID_PKCS1               MBEDTLS_OID_PKCS "\x01" /**< pkcs-1 OBJECT IDENTIFIER ::= { iso(1) member-body(2) us(840) rsadsi(113549) pkcs(1) 1 } */
+#define MBEDTLS_OID_PKCS5               MBEDTLS_OID_PKCS "\x05" /**< pkcs-5 OBJECT IDENTIFIER ::= { iso(1) member-body(2) us(840) rsadsi(113549) pkcs(1) 5 } */
+#define MBEDTLS_OID_PKCS9               MBEDTLS_OID_PKCS "\x09" /**< pkcs-9 OBJECT IDENTIFIER ::= { iso(1) member-body(2) us(840) rsadsi(113549) pkcs(1) 9 } */
+#define MBEDTLS_OID_PKCS12              MBEDTLS_OID_PKCS "\x0c" /**< pkcs-12 OBJECT IDENTIFIER ::= { iso(1) member-body(2) us(840) rsadsi(113549) pkcs(1) 12 } */
+
+/*
+ * PKCS#1 OIDs
+ */
+#define MBEDTLS_OID_PKCS1_RSA           MBEDTLS_OID_PKCS1 "\x01" /**< rsaEncryption OBJECT IDENTIFIER ::= { pkcs-1 1 } */
+#define MBEDTLS_OID_PKCS1_MD2           MBEDTLS_OID_PKCS1 "\x02" /**< md2WithRSAEncryption ::= { pkcs-1 2 } */
+#define MBEDTLS_OID_PKCS1_MD4           MBEDTLS_OID_PKCS1 "\x03" /**< md4WithRSAEncryption ::= { pkcs-1 3 } */
+#define MBEDTLS_OID_PKCS1_MD5           MBEDTLS_OID_PKCS1 "\x04" /**< md5WithRSAEncryption ::= { pkcs-1 4 } */
+#define MBEDTLS_OID_PKCS1_SHA1          MBEDTLS_OID_PKCS1 "\x05" /**< sha1WithRSAEncryption ::= { pkcs-1 5 } */
+#define MBEDTLS_OID_PKCS1_SHA224        MBEDTLS_OID_PKCS1 "\x0e" /**< sha224WithRSAEncryption ::= { pkcs-1 14 } */
+#define MBEDTLS_OID_PKCS1_SHA256        MBEDTLS_OID_PKCS1 "\x0b" /**< sha256WithRSAEncryption ::= { pkcs-1 11 } */
+#define MBEDTLS_OID_PKCS1_SHA384        MBEDTLS_OID_PKCS1 "\x0c" /**< sha384WithRSAEncryption ::= { pkcs-1 12 } */
+#define MBEDTLS_OID_PKCS1_SHA512        MBEDTLS_OID_PKCS1 "\x0d" /**< sha512WithRSAEncryption ::= { pkcs-1 13 } */
+
+#define MBEDTLS_OID_RSA_SHA_OBS         "\x2B\x0E\x03\x02\x1D"
+
+#define MBEDTLS_OID_PKCS9_EMAIL         MBEDTLS_OID_PKCS9 "\x01" /**< emailAddress AttributeType ::= { pkcs-9 1 } */
+
+/* RFC 4055 */
+#define MBEDTLS_OID_RSASSA_PSS          MBEDTLS_OID_PKCS1 "\x0a" /**< id-RSASSA-PSS ::= { pkcs-1 10 } */
+#define MBEDTLS_OID_MGF1                MBEDTLS_OID_PKCS1 "\x08" /**< id-mgf1 ::= { pkcs-1 8 } */
+
+/*
+ * Digest algorithms
+ */
+#define MBEDTLS_OID_DIGEST_ALG_MD2              MBEDTLS_OID_RSA_COMPANY "\x02\x02" /**< id-mbedtls_md2 OBJECT IDENTIFIER ::= { iso(1) member-body(2) us(840) rsadsi(113549) digestAlgorithm(2) 2 } */
+#define MBEDTLS_OID_DIGEST_ALG_MD4              MBEDTLS_OID_RSA_COMPANY "\x02\x04" /**< id-mbedtls_md4 OBJECT IDENTIFIER ::= { iso(1) member-body(2) us(840) rsadsi(113549) digestAlgorithm(2) 4 } */
+#define MBEDTLS_OID_DIGEST_ALG_MD5              MBEDTLS_OID_RSA_COMPANY "\x02\x05" /**< id-mbedtls_md5 OBJECT IDENTIFIER ::= { iso(1) member-body(2) us(840) rsadsi(113549) digestAlgorithm(2) 5 } */
+#define MBEDTLS_OID_DIGEST_ALG_SHA1             MBEDTLS_OID_ISO_IDENTIFIED_ORG MBEDTLS_OID_OIW_SECSIG_SHA1 /**< id-mbedtls_sha1 OBJECT IDENTIFIER ::= { iso(1) identified-organization(3) oiw(14) secsig(3) algorithms(2) 26 } */
+#define MBEDTLS_OID_DIGEST_ALG_SHA224           MBEDTLS_OID_GOV "\x03\x04\x02\x04" /**< id-sha224 OBJECT IDENTIFIER ::= { joint-iso-itu-t(2) country(16) us(840) organization(1) gov(101) csor(3) nistalgorithm(4) hashalgs(2) 4 } */
+#define MBEDTLS_OID_DIGEST_ALG_SHA256           MBEDTLS_OID_GOV "\x03\x04\x02\x01" /**< id-mbedtls_sha256 OBJECT IDENTIFIER ::= { joint-iso-itu-t(2) country(16) us(840) organization(1) gov(101) csor(3) nistalgorithm(4) hashalgs(2) 1 } */
+
+#define MBEDTLS_OID_DIGEST_ALG_SHA384           MBEDTLS_OID_GOV "\x03\x04\x02\x02" /**< id-sha384 OBJECT IDENTIFIER ::= { joint-iso-itu-t(2) country(16) us(840) organization(1) gov(101) csor(3) nistalgorithm(4) hashalgs(2) 2 } */
+
+#define MBEDTLS_OID_DIGEST_ALG_SHA512           MBEDTLS_OID_GOV "\x03\x04\x02\x03" /**< id-mbedtls_sha512 OBJECT IDENTIFIER ::= { joint-iso-itu-t(2) country(16) us(840) organization(1) gov(101) csor(3) nistalgorithm(4) hashalgs(2) 3 } */
+
+#define MBEDTLS_OID_HMAC_SHA1                   MBEDTLS_OID_RSA_COMPANY "\x02\x07" /**< id-hmacWithSHA1 OBJECT IDENTIFIER ::= { iso(1) member-body(2) us(840) rsadsi(113549) digestAlgorithm(2) 7 } */
+
+/*
+ * Encryption algorithms
+ */
+#define MBEDTLS_OID_DES_CBC                     MBEDTLS_OID_ISO_IDENTIFIED_ORG MBEDTLS_OID_OIW_SECSIG_ALG "\x07" /**< desCBC OBJECT IDENTIFIER ::= { iso(1) identified-organization(3) oiw(14) secsig(3) algorithms(2) 7 } */
+#define MBEDTLS_OID_DES_EDE3_CBC                MBEDTLS_OID_RSA_COMPANY "\x03\x07" /**< des-ede3-cbc OBJECT IDENTIFIER ::= { iso(1) member-body(2) -- us(840) rsadsi(113549) encryptionAlgorithm(3) 7 } */
+
+/*
+ * PKCS#5 OIDs
+ */
+#define MBEDTLS_OID_PKCS5_PBKDF2                MBEDTLS_OID_PKCS5 "\x0c" /**< id-PBKDF2 OBJECT IDENTIFIER ::= {pkcs-5 12} */
+#define MBEDTLS_OID_PKCS5_PBES2                 MBEDTLS_OID_PKCS5 "\x0d" /**< id-PBES2 OBJECT IDENTIFIER ::= {pkcs-5 13} */
+#define MBEDTLS_OID_PKCS5_PBMAC1                MBEDTLS_OID_PKCS5 "\x0e" /**< id-PBMAC1 OBJECT IDENTIFIER ::= {pkcs-5 14} */
+
+/*
+ * PKCS#5 PBES1 algorithms
+ */
+#define MBEDTLS_OID_PKCS5_PBE_MD2_DES_CBC       MBEDTLS_OID_PKCS5 "\x01" /**< pbeWithMD2AndDES-CBC OBJECT IDENTIFIER ::= {pkcs-5 1} */
+#define MBEDTLS_OID_PKCS5_PBE_MD2_RC2_CBC       MBEDTLS_OID_PKCS5 "\x04" /**< pbeWithMD2AndRC2-CBC OBJECT IDENTIFIER ::= {pkcs-5 4} */
+#define MBEDTLS_OID_PKCS5_PBE_MD5_DES_CBC       MBEDTLS_OID_PKCS5 "\x03" /**< pbeWithMD5AndDES-CBC OBJECT IDENTIFIER ::= {pkcs-5 3} */
+#define MBEDTLS_OID_PKCS5_PBE_MD5_RC2_CBC       MBEDTLS_OID_PKCS5 "\x06" /**< pbeWithMD5AndRC2-CBC OBJECT IDENTIFIER ::= {pkcs-5 6} */
+#define MBEDTLS_OID_PKCS5_PBE_SHA1_DES_CBC      MBEDTLS_OID_PKCS5 "\x0a" /**< pbeWithSHA1AndDES-CBC OBJECT IDENTIFIER ::= {pkcs-5 10} */
+#define MBEDTLS_OID_PKCS5_PBE_SHA1_RC2_CBC      MBEDTLS_OID_PKCS5 "\x0b" /**< pbeWithSHA1AndRC2-CBC OBJECT IDENTIFIER ::= {pkcs-5 11} */
+
+/*
+ * PKCS#8 OIDs
+ */
+#define MBEDTLS_OID_PKCS9_CSR_EXT_REQ           MBEDTLS_OID_PKCS9 "\x0e" /**< extensionRequest OBJECT IDENTIFIER ::= {pkcs-9 14} */
+
+/*
+ * PKCS#12 PBE OIDs
+ */
+#define MBEDTLS_OID_PKCS12_PBE                      MBEDTLS_OID_PKCS12 "\x01" /**< pkcs-12PbeIds OBJECT IDENTIFIER ::= {pkcs-12 1} */
+
+#define MBEDTLS_OID_PKCS12_PBE_SHA1_RC4_128         MBEDTLS_OID_PKCS12_PBE "\x01" /**< pbeWithSHAAnd128BitRC4 OBJECT IDENTIFIER ::= {pkcs-12PbeIds 1} */
+#define MBEDTLS_OID_PKCS12_PBE_SHA1_RC4_40          MBEDTLS_OID_PKCS12_PBE "\x02" /**< pbeWithSHAAnd40BitRC4 OBJECT IDENTIFIER ::= {pkcs-12PbeIds 2} */
+#define MBEDTLS_OID_PKCS12_PBE_SHA1_DES3_EDE_CBC    MBEDTLS_OID_PKCS12_PBE "\x03" /**< pbeWithSHAAnd3-KeyTripleDES-CBC OBJECT IDENTIFIER ::= {pkcs-12PbeIds 3} */
+#define MBEDTLS_OID_PKCS12_PBE_SHA1_DES2_EDE_CBC    MBEDTLS_OID_PKCS12_PBE "\x04" /**< pbeWithSHAAnd2-KeyTripleDES-CBC OBJECT IDENTIFIER ::= {pkcs-12PbeIds 4} */
+#define MBEDTLS_OID_PKCS12_PBE_SHA1_RC2_128_CBC     MBEDTLS_OID_PKCS12_PBE "\x05" /**< pbeWithSHAAnd128BitRC2-CBC OBJECT IDENTIFIER ::= {pkcs-12PbeIds 5} */
+#define MBEDTLS_OID_PKCS12_PBE_SHA1_RC2_40_CBC      MBEDTLS_OID_PKCS12_PBE "\x06" /**< pbeWithSHAAnd40BitRC2-CBC OBJECT IDENTIFIER ::= {pkcs-12PbeIds 6} */
+
+/*
+ * EC key algorithms from RFC 5480
+ */
+
+/* id-ecPublicKey OBJECT IDENTIFIER ::= {
+ *       iso(1) member-body(2) us(840) ansi-X9-62(10045) keyType(2) 1 } */
+#define MBEDTLS_OID_EC_ALG_UNRESTRICTED         MBEDTLS_OID_ANSI_X9_62 "\x02\01"
+
+/*   id-ecDH OBJECT IDENTIFIER ::= {
+ *     iso(1) identified-organization(3) certicom(132)
+ *     schemes(1) ecdh(12) } */
+#define MBEDTLS_OID_EC_ALG_ECDH                 MBEDTLS_OID_CERTICOM "\x01\x0c"
+
+/*
+ * ECParameters namedCurve identifiers, from RFC 5480, RFC 5639, and SEC2
+ */
+
+/* secp192r1 OBJECT IDENTIFIER ::= {
+ *   iso(1) member-body(2) us(840) ansi-X9-62(10045) curves(3) prime(1) 1 } */
+#define MBEDTLS_OID_EC_GRP_SECP192R1        MBEDTLS_OID_ANSI_X9_62 "\x03\x01\x01"
+
+/* secp224r1 OBJECT IDENTIFIER ::= {
+ *   iso(1) identified-organization(3) certicom(132) curve(0) 33 } */
+#define MBEDTLS_OID_EC_GRP_SECP224R1        MBEDTLS_OID_CERTICOM "\x00\x21"
+
+/* secp256r1 OBJECT IDENTIFIER ::= {
+ *   iso(1) member-body(2) us(840) ansi-X9-62(10045) curves(3) prime(1) 7 } */
+#define MBEDTLS_OID_EC_GRP_SECP256R1        MBEDTLS_OID_ANSI_X9_62 "\x03\x01\x07"
+
+/* secp384r1 OBJECT IDENTIFIER ::= {
+ *   iso(1) identified-organization(3) certicom(132) curve(0) 34 } */
+#define MBEDTLS_OID_EC_GRP_SECP384R1        MBEDTLS_OID_CERTICOM "\x00\x22"
+
+/* secp521r1 OBJECT IDENTIFIER ::= {
+ *   iso(1) identified-organization(3) certicom(132) curve(0) 35 } */
+#define MBEDTLS_OID_EC_GRP_SECP521R1        MBEDTLS_OID_CERTICOM "\x00\x23"
+
+/* secp192k1 OBJECT IDENTIFIER ::= {
+ *   iso(1) identified-organization(3) certicom(132) curve(0) 31 } */
+#define MBEDTLS_OID_EC_GRP_SECP192K1        MBEDTLS_OID_CERTICOM "\x00\x1f"
+
+/* secp224k1 OBJECT IDENTIFIER ::= {
+ *   iso(1) identified-organization(3) certicom(132) curve(0) 32 } */
+#define MBEDTLS_OID_EC_GRP_SECP224K1        MBEDTLS_OID_CERTICOM "\x00\x20"
+
+/* secp256k1 OBJECT IDENTIFIER ::= {
+ *   iso(1) identified-organization(3) certicom(132) curve(0) 10 } */
+#define MBEDTLS_OID_EC_GRP_SECP256K1        MBEDTLS_OID_CERTICOM "\x00\x0a"
+
+/* RFC 5639 4.1
+ * ecStdCurvesAndGeneration OBJECT IDENTIFIER::= {iso(1)
+ * identified-organization(3) teletrust(36) algorithm(3) signature-
+ * algorithm(3) ecSign(2) 8}
+ * ellipticCurve OBJECT IDENTIFIER ::= {ecStdCurvesAndGeneration 1}
+ * versionOne OBJECT IDENTIFIER ::= {ellipticCurve 1} */
+#define MBEDTLS_OID_EC_BRAINPOOL_V1         MBEDTLS_OID_TELETRUST "\x03\x03\x02\x08\x01\x01"
+
+/* brainpoolP256r1 OBJECT IDENTIFIER ::= {versionOne 7} */
+#define MBEDTLS_OID_EC_GRP_BP256R1          MBEDTLS_OID_EC_BRAINPOOL_V1 "\x07"
+
+/* brainpoolP384r1 OBJECT IDENTIFIER ::= {versionOne 11} */
+#define MBEDTLS_OID_EC_GRP_BP384R1          MBEDTLS_OID_EC_BRAINPOOL_V1 "\x0B"
+
+/* brainpoolP512r1 OBJECT IDENTIFIER ::= {versionOne 13} */
+#define MBEDTLS_OID_EC_GRP_BP512R1          MBEDTLS_OID_EC_BRAINPOOL_V1 "\x0D"
+
+/*
+ * SEC1 C.1
+ *
+ * prime-field OBJECT IDENTIFIER ::= { id-fieldType 1 }
+ * id-fieldType OBJECT IDENTIFIER ::= { ansi-X9-62 fieldType(1)}
+ */
+#define MBEDTLS_OID_ANSI_X9_62_FIELD_TYPE   MBEDTLS_OID_ANSI_X9_62 "\x01"
+#define MBEDTLS_OID_ANSI_X9_62_PRIME_FIELD  MBEDTLS_OID_ANSI_X9_62_FIELD_TYPE "\x01"
+
+/*
+ * ECDSA signature identifiers, from RFC 5480
+ */
+#define MBEDTLS_OID_ANSI_X9_62_SIG          MBEDTLS_OID_ANSI_X9_62 "\x04" /* signatures(4) */
+#define MBEDTLS_OID_ANSI_X9_62_SIG_SHA2     MBEDTLS_OID_ANSI_X9_62_SIG "\x03" /* ecdsa-with-SHA2(3) */
+
+/* ecdsa-with-SHA1 OBJECT IDENTIFIER ::= {
+ *   iso(1) member-body(2) us(840) ansi-X9-62(10045) signatures(4) 1 } */
+#define MBEDTLS_OID_ECDSA_SHA1              MBEDTLS_OID_ANSI_X9_62_SIG "\x01"
+
+/* ecdsa-with-SHA224 OBJECT IDENTIFIER ::= {
+ *   iso(1) member-body(2) us(840) ansi-X9-62(10045) signatures(4)
+ *   ecdsa-with-SHA2(3) 1 } */
+#define MBEDTLS_OID_ECDSA_SHA224            MBEDTLS_OID_ANSI_X9_62_SIG_SHA2 "\x01"
+
+/* ecdsa-with-SHA256 OBJECT IDENTIFIER ::= {
+ *   iso(1) member-body(2) us(840) ansi-X9-62(10045) signatures(4)
+ *   ecdsa-with-SHA2(3) 2 } */
+#define MBEDTLS_OID_ECDSA_SHA256            MBEDTLS_OID_ANSI_X9_62_SIG_SHA2 "\x02"
+
+/* ecdsa-with-SHA384 OBJECT IDENTIFIER ::= {
+ *   iso(1) member-body(2) us(840) ansi-X9-62(10045) signatures(4)
+ *   ecdsa-with-SHA2(3) 3 } */
+#define MBEDTLS_OID_ECDSA_SHA384            MBEDTLS_OID_ANSI_X9_62_SIG_SHA2 "\x03"
+
+/* ecdsa-with-SHA512 OBJECT IDENTIFIER ::= {
+ *   iso(1) member-body(2) us(840) ansi-X9-62(10045) signatures(4)
+ *   ecdsa-with-SHA2(3) 4 } */
+#define MBEDTLS_OID_ECDSA_SHA512            MBEDTLS_OID_ANSI_X9_62_SIG_SHA2 "\x04"
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/**
+ * \brief Base OID descriptor structure
+ */
+typedef struct {
+    const char *asn1;               /*!< OID ASN.1 representation       */
+    size_t asn1_len;                /*!< length of asn1                 */
+    const char *name;               /*!< official name (e.g. from RFC)  */
+    const char *description;        /*!< human friendly description     */
+} mbedtls_oid_descriptor_t;
+
+/**
+ * \brief           Translate an ASN.1 OID into its numeric representation
+ *                  (e.g. "\x2A\x86\x48\x86\xF7\x0D" into "1.2.840.113549")
+ *
+ * \param buf       buffer to put representation in
+ * \param size      size of the buffer
+ * \param oid       OID to translate
+ *
+ * \return          Length of the string written (excluding final NULL) or
+ *                  MBEDTLS_ERR_OID_BUF_TOO_SMALL in case of error
+ */
+int mbedtls_oid_get_numeric_string( char *buf, size_t size, const mbedtls_asn1_buf *oid );
+
+#if defined(MBEDTLS_X509_USE_C) || defined(MBEDTLS_X509_CREATE_C)
+/**
+ * \brief          Translate an X.509 extension OID into local values
+ *
+ * \param oid      OID to use
+ * \param ext_type place to store the extension type
+ *
+ * \return         0 if successful, or MBEDTLS_ERR_OID_NOT_FOUND
+ */
+int mbedtls_oid_get_x509_ext_type( const mbedtls_asn1_buf *oid, int *ext_type );
+#endif
+
+/**
+ * \brief          Translate an X.509 attribute type OID into the short name
+ *                 (e.g. the OID for an X520 Common Name into "CN")
+ *
+ * \param oid      OID to use
+ * \param short_name    place to store the string pointer
+ *
+ * \return         0 if successful, or MBEDTLS_ERR_OID_NOT_FOUND
+ */
+int mbedtls_oid_get_attr_short_name( const mbedtls_asn1_buf *oid, const char **short_name );
+
+/**
+ * \brief          Translate PublicKeyAlgorithm OID into pk_type
+ *
+ * \param oid      OID to use
+ * \param pk_alg   place to store public key algorithm
+ *
+ * \return         0 if successful, or MBEDTLS_ERR_OID_NOT_FOUND
+ */
+int mbedtls_oid_get_pk_alg( const mbedtls_asn1_buf *oid, mbedtls_pk_type_t *pk_alg );
+
+/**
+ * \brief          Translate pk_type into PublicKeyAlgorithm OID
+ *
+ * \param pk_alg   Public key type to look for
+ * \param oid      place to store ASN.1 OID string pointer
+ * \param olen     length of the OID
+ *
+ * \return         0 if successful, or MBEDTLS_ERR_OID_NOT_FOUND
+ */
+int mbedtls_oid_get_oid_by_pk_alg( mbedtls_pk_type_t pk_alg,
+                           const char **oid, size_t *olen );
+
+#if defined(MBEDTLS_ECP_C)
+/**
+ * \brief          Translate NamedCurve OID into an EC group identifier
+ *
+ * \param oid      OID to use
+ * \param grp_id   place to store group id
+ *
+ * \return         0 if successful, or MBEDTLS_ERR_OID_NOT_FOUND
+ */
+int mbedtls_oid_get_ec_grp( const mbedtls_asn1_buf *oid, mbedtls_ecp_group_id *grp_id );
+
+/**
+ * \brief          Translate EC group identifier into NamedCurve OID
+ *
+ * \param grp_id   EC group identifier
+ * \param oid      place to store ASN.1 OID string pointer
+ * \param olen     length of the OID
+ *
+ * \return         0 if successful, or MBEDTLS_ERR_OID_NOT_FOUND
+ */
+int mbedtls_oid_get_oid_by_ec_grp( mbedtls_ecp_group_id grp_id,
+                           const char **oid, size_t *olen );
+#endif /* MBEDTLS_ECP_C */
+
+#if defined(MBEDTLS_MD_C)
+/**
+ * \brief          Translate SignatureAlgorithm OID into md_type and pk_type
+ *
+ * \param oid      OID to use
+ * \param md_alg   place to store message digest algorithm
+ * \param pk_alg   place to store public key algorithm
+ *
+ * \return         0 if successful, or MBEDTLS_ERR_OID_NOT_FOUND
+ */
+int mbedtls_oid_get_sig_alg( const mbedtls_asn1_buf *oid,
+                     mbedtls_md_type_t *md_alg, mbedtls_pk_type_t *pk_alg );
+
+/**
+ * \brief          Translate SignatureAlgorithm OID into description
+ *
+ * \param oid      OID to use
+ * \param desc     place to store string pointer
+ *
+ * \return         0 if successful, or MBEDTLS_ERR_OID_NOT_FOUND
+ */
+int mbedtls_oid_get_sig_alg_desc( const mbedtls_asn1_buf *oid, const char **desc );
+
+/**
+ * \brief          Translate md_type and pk_type into SignatureAlgorithm OID
+ *
+ * \param md_alg   message digest algorithm
+ * \param pk_alg   public key algorithm
+ * \param oid      place to store ASN.1 OID string pointer
+ * \param olen     length of the OID
+ *
+ * \return         0 if successful, or MBEDTLS_ERR_OID_NOT_FOUND
+ */
+int mbedtls_oid_get_oid_by_sig_alg( mbedtls_pk_type_t pk_alg, mbedtls_md_type_t md_alg,
+                            const char **oid, size_t *olen );
+
+/**
+ * \brief          Translate hash algorithm OID into md_type
+ *
+ * \param oid      OID to use
+ * \param md_alg   place to store message digest algorithm
+ *
+ * \return         0 if successful, or MBEDTLS_ERR_OID_NOT_FOUND
+ */
+int mbedtls_oid_get_md_alg( const mbedtls_asn1_buf *oid, mbedtls_md_type_t *md_alg );
+#endif /* MBEDTLS_MD_C */
+
+/**
+ * \brief          Translate Extended Key Usage OID into description
+ *
+ * \param oid      OID to use
+ * \param desc     place to store string pointer
+ *
+ * \return         0 if successful, or MBEDTLS_ERR_OID_NOT_FOUND
+ */
+int mbedtls_oid_get_extended_key_usage( const mbedtls_asn1_buf *oid, const char **desc );
+
+/**
+ * \brief          Translate md_type into hash algorithm OID
+ *
+ * \param md_alg   message digest algorithm
+ * \param oid      place to store ASN.1 OID string pointer
+ * \param olen     length of the OID
+ *
+ * \return         0 if successful, or MBEDTLS_ERR_OID_NOT_FOUND
+ */
+int mbedtls_oid_get_oid_by_md( mbedtls_md_type_t md_alg, const char **oid, size_t *olen );
+
+#if defined(MBEDTLS_CIPHER_C)
+/**
+ * \brief          Translate encryption algorithm OID into cipher_type
+ *
+ * \param oid           OID to use
+ * \param cipher_alg    place to store cipher algorithm
+ *
+ * \return         0 if successful, or MBEDTLS_ERR_OID_NOT_FOUND
+ */
+int mbedtls_oid_get_cipher_alg( const mbedtls_asn1_buf *oid, mbedtls_cipher_type_t *cipher_alg );
+#endif /* MBEDTLS_CIPHER_C */
+
+#if defined(MBEDTLS_PKCS12_C)
+/**
+ * \brief          Translate PKCS#12 PBE algorithm OID into md_type and
+ *                 cipher_type
+ *
+ * \param oid           OID to use
+ * \param md_alg        place to store message digest algorithm
+ * \param cipher_alg    place to store cipher algorithm
+ *
+ * \return         0 if successful, or MBEDTLS_ERR_OID_NOT_FOUND
+ */
+int mbedtls_oid_get_pkcs12_pbe_alg( const mbedtls_asn1_buf *oid, mbedtls_md_type_t *md_alg,
+                            mbedtls_cipher_type_t *cipher_alg );
+#endif /* MBEDTLS_PKCS12_C */
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* oid.h */
diff --git a/backport/compat/verification/mbedtls/pk.h b/backport/compat/verification/mbedtls/pk.h
new file mode 100644
index 000000000000..9aac7e2a994a
--- /dev/null
+++ b/backport/compat/verification/mbedtls/pk.h
@@ -0,0 +1,618 @@
+/**
+ * \file pk.h
+ *
+ * \brief Public Key abstraction layer
+ *
+ *  Copyright (C) 2006-2015, ARM Limited, All Rights Reserved
+ *  SPDX-License-Identifier: GPL-2.0
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ *  This file is part of mbed TLS (https://tls.mbed.org)
+ */
+
+#ifndef MBEDTLS_PK_H
+#define MBEDTLS_PK_H
+
+#if !defined(MBEDTLS_CONFIG_FILE)
+#include "config.h"
+#else
+#include MBEDTLS_CONFIG_FILE
+#endif
+
+#include "md.h"
+
+#if defined(MBEDTLS_RSA_C)
+#include "rsa.h"
+#endif
+
+#if defined(MBEDTLS_ECP_C)
+#include "ecp.h"
+#endif
+
+#if defined(MBEDTLS_ECDSA_C)
+#include "ecdsa.h"
+#endif
+
+#if ( defined(__ARMCC_VERSION) || defined(_MSC_VER) ) && \
+    !defined(inline) && !defined(__cplusplus)
+#define inline __inline
+#endif
+
+#define MBEDTLS_ERR_PK_ALLOC_FAILED        -0x3F80  /**< Memory allocation failed. */
+#define MBEDTLS_ERR_PK_TYPE_MISMATCH       -0x3F00  /**< Type mismatch, eg attempt to encrypt with an ECDSA key */
+#define MBEDTLS_ERR_PK_BAD_INPUT_DATA      -0x3E80  /**< Bad input parameters to function. */
+#define MBEDTLS_ERR_PK_FILE_IO_ERROR       -0x3E00  /**< Read/write of file failed. */
+#define MBEDTLS_ERR_PK_KEY_INVALID_VERSION -0x3D80  /**< Unsupported key version */
+#define MBEDTLS_ERR_PK_KEY_INVALID_FORMAT  -0x3D00  /**< Invalid key tag or value. */
+#define MBEDTLS_ERR_PK_UNKNOWN_PK_ALG      -0x3C80  /**< Key algorithm is unsupported (only RSA and EC are supported). */
+#define MBEDTLS_ERR_PK_PASSWORD_REQUIRED   -0x3C00  /**< Private key password can't be empty. */
+#define MBEDTLS_ERR_PK_PASSWORD_MISMATCH   -0x3B80  /**< Given private key password does not allow for correct decryption. */
+#define MBEDTLS_ERR_PK_INVALID_PUBKEY      -0x3B00  /**< The pubkey tag or value is invalid (only RSA and EC are supported). */
+#define MBEDTLS_ERR_PK_INVALID_ALG         -0x3A80  /**< The algorithm tag or value is invalid. */
+#define MBEDTLS_ERR_PK_UNKNOWN_NAMED_CURVE -0x3A00  /**< Elliptic curve is unsupported (only NIST curves are supported). */
+#define MBEDTLS_ERR_PK_FEATURE_UNAVAILABLE -0x3980  /**< Unavailable feature, e.g. RSA disabled for RSA key. */
+#define MBEDTLS_ERR_PK_SIG_LEN_MISMATCH    -0x3900  /**< The signature is valid but its length is less than expected. */
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/**
+ * \brief          Public key types
+ */
+typedef enum {
+    MBEDTLS_PK_NONE=0,
+    MBEDTLS_PK_RSA,
+    MBEDTLS_PK_ECKEY,
+    MBEDTLS_PK_ECKEY_DH,
+    MBEDTLS_PK_ECDSA,
+    MBEDTLS_PK_RSA_ALT,
+    MBEDTLS_PK_RSASSA_PSS,
+} mbedtls_pk_type_t;
+
+/**
+ * \brief           Options for RSASSA-PSS signature verification.
+ *                  See \c mbedtls_rsa_rsassa_pss_verify_ext()
+ */
+typedef struct
+{
+    mbedtls_md_type_t mgf1_hash_id;
+    int expected_salt_len;
+
+} mbedtls_pk_rsassa_pss_options;
+
+/**
+ * \brief           Types for interfacing with the debug module
+ */
+typedef enum
+{
+    MBEDTLS_PK_DEBUG_NONE = 0,
+    MBEDTLS_PK_DEBUG_MPI,
+    MBEDTLS_PK_DEBUG_ECP,
+} mbedtls_pk_debug_type;
+
+/**
+ * \brief           Item to send to the debug module
+ */
+typedef struct
+{
+    mbedtls_pk_debug_type type;
+    const char *name;
+    void *value;
+} mbedtls_pk_debug_item;
+
+/** Maximum number of item send for debugging, plus 1 */
+#define MBEDTLS_PK_DEBUG_MAX_ITEMS 3
+
+/**
+ * \brief           Public key information and operations
+ */
+typedef struct mbedtls_pk_info_t mbedtls_pk_info_t;
+
+/**
+ * \brief           Public key container
+ */
+typedef struct
+{
+    const mbedtls_pk_info_t *   pk_info; /**< Public key informations        */
+    void *                      pk_ctx;  /**< Underlying public key context  */
+} mbedtls_pk_context;
+
+#if defined(MBEDTLS_RSA_C)
+/**
+ * Quick access to an RSA context inside a PK context.
+ *
+ * \warning You must make sure the PK context actually holds an RSA context
+ * before using this function!
+ */
+static inline mbedtls_rsa_context *mbedtls_pk_rsa( const mbedtls_pk_context pk )
+{
+    return( (mbedtls_rsa_context *) (pk).pk_ctx );
+}
+#endif /* MBEDTLS_RSA_C */
+
+#if defined(MBEDTLS_ECP_C)
+/**
+ * Quick access to an EC context inside a PK context.
+ *
+ * \warning You must make sure the PK context actually holds an EC context
+ * before using this function!
+ */
+static inline mbedtls_ecp_keypair *mbedtls_pk_ec( const mbedtls_pk_context pk )
+{
+    return( (mbedtls_ecp_keypair *) (pk).pk_ctx );
+}
+#endif /* MBEDTLS_ECP_C */
+
+#if defined(MBEDTLS_PK_RSA_ALT_SUPPORT)
+/**
+ * \brief           Types for RSA-alt abstraction
+ */
+typedef int (*mbedtls_pk_rsa_alt_decrypt_func)( void *ctx, int mode, size_t *olen,
+                    const unsigned char *input, unsigned char *output,
+                    size_t output_max_len );
+typedef int (*mbedtls_pk_rsa_alt_sign_func)( void *ctx,
+                    int (*f_rng)(void *, unsigned char *, size_t), void *p_rng,
+                    int mode, mbedtls_md_type_t md_alg, unsigned int hashlen,
+                    const unsigned char *hash, unsigned char *sig );
+typedef size_t (*mbedtls_pk_rsa_alt_key_len_func)( void *ctx );
+#endif /* MBEDTLS_PK_RSA_ALT_SUPPORT */
+
+/**
+ * \brief           Return information associated with the given PK type
+ *
+ * \param pk_type   PK type to search for.
+ *
+ * \return          The PK info associated with the type or NULL if not found.
+ */
+const mbedtls_pk_info_t *mbedtls_pk_info_from_type( mbedtls_pk_type_t pk_type );
+
+/**
+ * \brief           Initialize a mbedtls_pk_context (as NONE)
+ */
+void mbedtls_pk_init( mbedtls_pk_context *ctx );
+
+/**
+ * \brief           Free a mbedtls_pk_context
+ */
+void mbedtls_pk_free( mbedtls_pk_context *ctx );
+
+/**
+ * \brief           Initialize a PK context with the information given
+ *                  and allocates the type-specific PK subcontext.
+ *
+ * \param ctx       Context to initialize. Must be empty (type NONE).
+ * \param info      Information to use
+ *
+ * \return          0 on success,
+ *                  MBEDTLS_ERR_PK_BAD_INPUT_DATA on invalid input,
+ *                  MBEDTLS_ERR_PK_ALLOC_FAILED on allocation failure.
+ *
+ * \note            For contexts holding an RSA-alt key, use
+ *                  \c mbedtls_pk_setup_rsa_alt() instead.
+ */
+int mbedtls_pk_setup( mbedtls_pk_context *ctx, const mbedtls_pk_info_t *info );
+
+#if defined(MBEDTLS_PK_RSA_ALT_SUPPORT)
+/**
+ * \brief           Initialize an RSA-alt context
+ *
+ * \param ctx       Context to initialize. Must be empty (type NONE).
+ * \param key       RSA key pointer
+ * \param decrypt_func  Decryption function
+ * \param sign_func     Signing function
+ * \param key_len_func  Function returning key length in bytes
+ *
+ * \return          0 on success, or MBEDTLS_ERR_PK_BAD_INPUT_DATA if the
+ *                  context wasn't already initialized as RSA_ALT.
+ *
+ * \note            This function replaces \c mbedtls_pk_setup() for RSA-alt.
+ */
+int mbedtls_pk_setup_rsa_alt( mbedtls_pk_context *ctx, void * key,
+                         mbedtls_pk_rsa_alt_decrypt_func decrypt_func,
+                         mbedtls_pk_rsa_alt_sign_func sign_func,
+                         mbedtls_pk_rsa_alt_key_len_func key_len_func );
+#endif /* MBEDTLS_PK_RSA_ALT_SUPPORT */
+
+/**
+ * \brief           Get the size in bits of the underlying key
+ *
+ * \param ctx       Context to use
+ *
+ * \return          Key size in bits, or 0 on error
+ */
+size_t mbedtls_pk_get_bitlen( const mbedtls_pk_context *ctx );
+
+/**
+ * \brief           Get the length in bytes of the underlying key
+ * \param ctx       Context to use
+ *
+ * \return          Key length in bytes, or 0 on error
+ */
+static inline size_t mbedtls_pk_get_len( const mbedtls_pk_context *ctx )
+{
+    return( ( mbedtls_pk_get_bitlen( ctx ) + 7 ) / 8 );
+}
+
+/**
+ * \brief           Tell if a context can do the operation given by type
+ *
+ * \param ctx       Context to test
+ * \param type      Target type
+ *
+ * \return          0 if context can't do the operations,
+ *                  1 otherwise.
+ */
+int mbedtls_pk_can_do( const mbedtls_pk_context *ctx, mbedtls_pk_type_t type );
+
+/**
+ * \brief           Verify signature (including padding if relevant).
+ *
+ * \param ctx       PK context to use
+ * \param md_alg    Hash algorithm used (see notes)
+ * \param hash      Hash of the message to sign
+ * \param hash_len  Hash length or 0 (see notes)
+ * \param sig       Signature to verify
+ * \param sig_len   Signature length
+ *
+ * \return          0 on success (signature is valid),
+ *                  MBEDTLS_ERR_PK_SIG_LEN_MISMATCH if the signature is
+ *                  valid but its actual length is less than sig_len,
+ *                  or a specific error code.
+ *
+ * \note            For RSA keys, the default padding type is PKCS#1 v1.5.
+ *                  Use \c mbedtls_pk_verify_ext( MBEDTLS_PK_RSASSA_PSS, ... )
+ *                  to verify RSASSA_PSS signatures.
+ *
+ * \note            If hash_len is 0, then the length associated with md_alg
+ *                  is used instead, or an error returned if it is invalid.
+ *
+ * \note            md_alg may be MBEDTLS_MD_NONE, only if hash_len != 0
+ */
+int mbedtls_pk_verify( mbedtls_pk_context *ctx, mbedtls_md_type_t md_alg,
+               const unsigned char *hash, size_t hash_len,
+               const unsigned char *sig, size_t sig_len );
+
+/**
+ * \brief           Verify signature, with options.
+ *                  (Includes verification of the padding depending on type.)
+ *
+ * \param type      Signature type (inc. possible padding type) to verify
+ * \param options   Pointer to type-specific options, or NULL
+ * \param ctx       PK context to use
+ * \param md_alg    Hash algorithm used (see notes)
+ * \param hash      Hash of the message to sign
+ * \param hash_len  Hash length or 0 (see notes)
+ * \param sig       Signature to verify
+ * \param sig_len   Signature length
+ *
+ * \return          0 on success (signature is valid),
+ *                  MBEDTLS_ERR_PK_TYPE_MISMATCH if the PK context can't be
+ *                  used for this type of signatures,
+ *                  MBEDTLS_ERR_PK_SIG_LEN_MISMATCH if the signature is
+ *                  valid but its actual length is less than sig_len,
+ *                  or a specific error code.
+ *
+ * \note            If hash_len is 0, then the length associated with md_alg
+ *                  is used instead, or an error returned if it is invalid.
+ *
+ * \note            md_alg may be MBEDTLS_MD_NONE, only if hash_len != 0
+ *
+ * \note            If type is MBEDTLS_PK_RSASSA_PSS, then options must point
+ *                  to a mbedtls_pk_rsassa_pss_options structure,
+ *                  otherwise it must be NULL.
+ */
+int mbedtls_pk_verify_ext( mbedtls_pk_type_t type, const void *options,
+                   mbedtls_pk_context *ctx, mbedtls_md_type_t md_alg,
+                   const unsigned char *hash, size_t hash_len,
+                   const unsigned char *sig, size_t sig_len );
+
+/**
+ * \brief           Make signature, including padding if relevant.
+ *
+ * \param ctx       PK context to use - must hold a private key
+ * \param md_alg    Hash algorithm used (see notes)
+ * \param hash      Hash of the message to sign
+ * \param hash_len  Hash length or 0 (see notes)
+ * \param sig       Place to write the signature
+ * \param sig_len   Number of bytes written
+ * \param f_rng     RNG function
+ * \param p_rng     RNG parameter
+ *
+ * \return          0 on success, or a specific error code.
+ *
+ * \note            For RSA keys, the default padding type is PKCS#1 v1.5.
+ *                  There is no interface in the PK module to make RSASSA-PSS
+ *                  signatures yet.
+ *
+ * \note            If hash_len is 0, then the length associated with md_alg
+ *                  is used instead, or an error returned if it is invalid.
+ *
+ * \note            For RSA, md_alg may be MBEDTLS_MD_NONE if hash_len != 0.
+ *                  For ECDSA, md_alg may never be MBEDTLS_MD_NONE.
+ */
+int mbedtls_pk_sign( mbedtls_pk_context *ctx, mbedtls_md_type_t md_alg,
+             const unsigned char *hash, size_t hash_len,
+             unsigned char *sig, size_t *sig_len,
+             int (*f_rng)(void *, unsigned char *, size_t), void *p_rng );
+
+/**
+ * \brief           Decrypt message (including padding if relevant).
+ *
+ * \param ctx       PK context to use - must hold a private key
+ * \param input     Input to decrypt
+ * \param ilen      Input size
+ * \param output    Decrypted output
+ * \param olen      Decrypted message length
+ * \param osize     Size of the output buffer
+ * \param f_rng     RNG function
+ * \param p_rng     RNG parameter
+ *
+ * \note            For RSA keys, the default padding type is PKCS#1 v1.5.
+ *
+ * \return          0 on success, or a specific error code.
+ */
+int mbedtls_pk_decrypt( mbedtls_pk_context *ctx,
+                const unsigned char *input, size_t ilen,
+                unsigned char *output, size_t *olen, size_t osize,
+                int (*f_rng)(void *, unsigned char *, size_t), void *p_rng );
+
+/**
+ * \brief           Encrypt message (including padding if relevant).
+ *
+ * \param ctx       PK context to use
+ * \param input     Message to encrypt
+ * \param ilen      Message size
+ * \param output    Encrypted output
+ * \param olen      Encrypted output length
+ * \param osize     Size of the output buffer
+ * \param f_rng     RNG function
+ * \param p_rng     RNG parameter
+ *
+ * \note            For RSA keys, the default padding type is PKCS#1 v1.5.
+ *
+ * \return          0 on success, or a specific error code.
+ */
+int mbedtls_pk_encrypt( mbedtls_pk_context *ctx,
+                const unsigned char *input, size_t ilen,
+                unsigned char *output, size_t *olen, size_t osize,
+                int (*f_rng)(void *, unsigned char *, size_t), void *p_rng );
+
+/**
+ * \brief           Check if a public-private pair of keys matches.
+ *
+ * \param pub       Context holding a public key.
+ * \param prv       Context holding a private (and public) key.
+ *
+ * \return          0 on success or MBEDTLS_ERR_PK_BAD_INPUT_DATA
+ */
+int mbedtls_pk_check_pair( const mbedtls_pk_context *pub, const mbedtls_pk_context *prv );
+
+/**
+ * \brief           Export debug information
+ *
+ * \param ctx       Context to use
+ * \param items     Place to write debug items
+ *
+ * \return          0 on success or MBEDTLS_ERR_PK_BAD_INPUT_DATA
+ */
+int mbedtls_pk_debug( const mbedtls_pk_context *ctx, mbedtls_pk_debug_item *items );
+
+/**
+ * \brief           Access the type name
+ *
+ * \param ctx       Context to use
+ *
+ * \return          Type name on success, or "invalid PK"
+ */
+const char * mbedtls_pk_get_name( const mbedtls_pk_context *ctx );
+
+/**
+ * \brief           Get the key type
+ *
+ * \param ctx       Context to use
+ *
+ * \return          Type on success, or MBEDTLS_PK_NONE
+ */
+mbedtls_pk_type_t mbedtls_pk_get_type( const mbedtls_pk_context *ctx );
+
+#if defined(MBEDTLS_PK_PARSE_C)
+/** \ingroup pk_module */
+/**
+ * \brief           Parse a private key in PEM or DER format
+ *
+ * \param ctx       key to be initialized
+ * \param key       input buffer
+ * \param keylen    size of the buffer
+ *                  (including the terminating null byte for PEM data)
+ * \param pwd       password for decryption (optional)
+ * \param pwdlen    size of the password
+ *
+ * \note            On entry, ctx must be empty, either freshly initialised
+ *                  with mbedtls_pk_init() or reset with mbedtls_pk_free(). If you need a
+ *                  specific key type, check the result with mbedtls_pk_can_do().
+ *
+ * \note            The key is also checked for correctness.
+ *
+ * \return          0 if successful, or a specific PK or PEM error code
+ */
+int mbedtls_pk_parse_key( mbedtls_pk_context *ctx,
+                  const unsigned char *key, size_t keylen,
+                  const unsigned char *pwd, size_t pwdlen );
+
+/** \ingroup pk_module */
+/**
+ * \brief           Parse a public key in PEM or DER format
+ *
+ * \param ctx       key to be initialized
+ * \param key       input buffer
+ * \param keylen    size of the buffer
+ *                  (including the terminating null byte for PEM data)
+ *
+ * \note            On entry, ctx must be empty, either freshly initialised
+ *                  with mbedtls_pk_init() or reset with mbedtls_pk_free(). If you need a
+ *                  specific key type, check the result with mbedtls_pk_can_do().
+ *
+ * \note            The key is also checked for correctness.
+ *
+ * \return          0 if successful, or a specific PK or PEM error code
+ */
+int mbedtls_pk_parse_public_key( mbedtls_pk_context *ctx,
+                         const unsigned char *key, size_t keylen );
+
+#if defined(MBEDTLS_FS_IO)
+/** \ingroup pk_module */
+/**
+ * \brief           Load and parse a private key
+ *
+ * \param ctx       key to be initialized
+ * \param path      filename to read the private key from
+ * \param password  password to decrypt the file (can be NULL)
+ *
+ * \note            On entry, ctx must be empty, either freshly initialised
+ *                  with mbedtls_pk_init() or reset with mbedtls_pk_free(). If you need a
+ *                  specific key type, check the result with mbedtls_pk_can_do().
+ *
+ * \note            The key is also checked for correctness.
+ *
+ * \return          0 if successful, or a specific PK or PEM error code
+ */
+int mbedtls_pk_parse_keyfile( mbedtls_pk_context *ctx,
+                      const char *path, const char *password );
+
+/** \ingroup pk_module */
+/**
+ * \brief           Load and parse a public key
+ *
+ * \param ctx       key to be initialized
+ * \param path      filename to read the public key from
+ *
+ * \note            On entry, ctx must be empty, either freshly initialised
+ *                  with mbedtls_pk_init() or reset with mbedtls_pk_free(). If
+ *                  you need a specific key type, check the result with
+ *                  mbedtls_pk_can_do().
+ *
+ * \note            The key is also checked for correctness.
+ *
+ * \return          0 if successful, or a specific PK or PEM error code
+ */
+int mbedtls_pk_parse_public_keyfile( mbedtls_pk_context *ctx, const char *path );
+#endif /* MBEDTLS_FS_IO */
+#endif /* MBEDTLS_PK_PARSE_C */
+
+#if defined(MBEDTLS_PK_WRITE_C)
+/**
+ * \brief           Write a private key to a PKCS#1 or SEC1 DER structure
+ *                  Note: data is written at the end of the buffer! Use the
+ *                        return value to determine where you should start
+ *                        using the buffer
+ *
+ * \param ctx       private to write away
+ * \param buf       buffer to write to
+ * \param size      size of the buffer
+ *
+ * \return          length of data written if successful, or a specific
+ *                  error code
+ */
+int mbedtls_pk_write_key_der( mbedtls_pk_context *ctx, unsigned char *buf, size_t size );
+
+/**
+ * \brief           Write a public key to a SubjectPublicKeyInfo DER structure
+ *                  Note: data is written at the end of the buffer! Use the
+ *                        return value to determine where you should start
+ *                        using the buffer
+ *
+ * \param ctx       public key to write away
+ * \param buf       buffer to write to
+ * \param size      size of the buffer
+ *
+ * \return          length of data written if successful, or a specific
+ *                  error code
+ */
+int mbedtls_pk_write_pubkey_der( mbedtls_pk_context *ctx, unsigned char *buf, size_t size );
+
+#if defined(MBEDTLS_PEM_WRITE_C)
+/**
+ * \brief           Write a public key to a PEM string
+ *
+ * \param ctx       public key to write away
+ * \param buf       buffer to write to
+ * \param size      size of the buffer
+ *
+ * \return          0 if successful, or a specific error code
+ */
+int mbedtls_pk_write_pubkey_pem( mbedtls_pk_context *ctx, unsigned char *buf, size_t size );
+
+/**
+ * \brief           Write a private key to a PKCS#1 or SEC1 PEM string
+ *
+ * \param ctx       private to write away
+ * \param buf       buffer to write to
+ * \param size      size of the buffer
+ *
+ * \return          0 if successful, or a specific error code
+ */
+int mbedtls_pk_write_key_pem( mbedtls_pk_context *ctx, unsigned char *buf, size_t size );
+#endif /* MBEDTLS_PEM_WRITE_C */
+#endif /* MBEDTLS_PK_WRITE_C */
+
+/*
+ * WARNING: Low-level functions. You probably do not want to use these unless
+ *          you are certain you do ;)
+ */
+
+#if defined(MBEDTLS_PK_PARSE_C)
+/**
+ * \brief           Parse a SubjectPublicKeyInfo DER structure
+ *
+ * \param p         the position in the ASN.1 data
+ * \param end       end of the buffer
+ * \param pk        the key to fill
+ *
+ * \return          0 if successful, or a specific PK error code
+ */
+int mbedtls_pk_parse_subpubkey( unsigned char **p, const unsigned char *end,
+                        mbedtls_pk_context *pk );
+#endif /* MBEDTLS_PK_PARSE_C */
+
+#if defined(MBEDTLS_PK_WRITE_C)
+/**
+ * \brief           Write a subjectPublicKey to ASN.1 data
+ *                  Note: function works backwards in data buffer
+ *
+ * \param p         reference to current position pointer
+ * \param start     start of the buffer (for bounds-checking)
+ * \param key       public key to write away
+ *
+ * \return          the length written or a negative error code
+ */
+int mbedtls_pk_write_pubkey( unsigned char **p, unsigned char *start,
+                     const mbedtls_pk_context *key );
+#endif /* MBEDTLS_PK_WRITE_C */
+
+/*
+ * Internal module functions. You probably do not want to use these unless you
+ * know you do.
+ */
+#if defined(MBEDTLS_FS_IO)
+int mbedtls_pk_load_file( const char *path, unsigned char **buf, size_t *n );
+#endif
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* MBEDTLS_PK_H */
diff --git a/backport/compat/verification/mbedtls/platform.h b/backport/compat/verification/mbedtls/platform.h
new file mode 100644
index 000000000000..cf5fa56f5f17
--- /dev/null
+++ b/backport/compat/verification/mbedtls/platform.h
@@ -0,0 +1,12 @@
+#ifndef __MBEDTLS_PLATFORM_H
+#define __MBEDTLS_PLATFORM_H
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#define mbedtls_printf		pr_debug
+#define mbedtls_calloc(a, b)	kcalloc(a, b, GFP_KERNEL)
+#define mbedtls_free		kfree
+#define mbedtls_snprintf	snprintf
+
+#endif /* __MBEDTLS_PLATFORM_H */
diff --git a/backport/compat/verification/mbedtls/rsa.h b/backport/compat/verification/mbedtls/rsa.h
new file mode 100644
index 000000000000..9683520ce0b3
--- /dev/null
+++ b/backport/compat/verification/mbedtls/rsa.h
@@ -0,0 +1,672 @@
+/**
+ * \file rsa.h
+ *
+ * \brief The RSA public-key cryptosystem
+ *
+ *  Copyright (C) 2006-2015, ARM Limited, All Rights Reserved
+ *  SPDX-License-Identifier: GPL-2.0
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ *  This file is part of mbed TLS (https://tls.mbed.org)
+ */
+#ifndef MBEDTLS_RSA_H
+#define MBEDTLS_RSA_H
+
+#if !defined(MBEDTLS_CONFIG_FILE)
+#include "config.h"
+#else
+#include MBEDTLS_CONFIG_FILE
+#endif
+
+#include "bignum.h"
+#include "md.h"
+
+#if defined(MBEDTLS_THREADING_C)
+#include "threading.h"
+#endif
+
+/*
+ * RSA Error codes
+ */
+#define MBEDTLS_ERR_RSA_BAD_INPUT_DATA                    -0x4080  /**< Bad input parameters to function. */
+#define MBEDTLS_ERR_RSA_INVALID_PADDING                   -0x4100  /**< Input data contains invalid padding and is rejected. */
+#define MBEDTLS_ERR_RSA_KEY_GEN_FAILED                    -0x4180  /**< Something failed during generation of a key. */
+#define MBEDTLS_ERR_RSA_KEY_CHECK_FAILED                  -0x4200  /**< Key failed to pass the library's validity check. */
+#define MBEDTLS_ERR_RSA_PUBLIC_FAILED                     -0x4280  /**< The public key operation failed. */
+#define MBEDTLS_ERR_RSA_PRIVATE_FAILED                    -0x4300  /**< The private key operation failed. */
+#define MBEDTLS_ERR_RSA_VERIFY_FAILED                     -0x4380  /**< The PKCS#1 verification failed. */
+#define MBEDTLS_ERR_RSA_OUTPUT_TOO_LARGE                  -0x4400  /**< The output buffer for decryption is not large enough. */
+#define MBEDTLS_ERR_RSA_RNG_FAILED                        -0x4480  /**< The random generator failed to generate non-zeros. */
+
+/*
+ * RSA constants
+ */
+#define MBEDTLS_RSA_PUBLIC      0
+#define MBEDTLS_RSA_PRIVATE     1
+
+#define MBEDTLS_RSA_PKCS_V15    0
+#define MBEDTLS_RSA_PKCS_V21    1
+
+#define MBEDTLS_RSA_SIGN        1
+#define MBEDTLS_RSA_CRYPT       2
+
+#define MBEDTLS_RSA_SALT_LEN_ANY    -1
+
+/*
+ * The above constants may be used even if the RSA module is compile out,
+ * eg for alternative (PKCS#11) RSA implemenations in the PK layers.
+ */
+#if defined(MBEDTLS_RSA_C)
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/**
+ * \brief          RSA context structure
+ */
+typedef struct
+{
+    int ver;                    /*!<  always 0          */
+    size_t len;                 /*!<  size(N) in chars  */
+
+    mbedtls_mpi N;                      /*!<  public modulus    */
+    mbedtls_mpi E;                      /*!<  public exponent   */
+
+    mbedtls_mpi D;                      /*!<  private exponent  */
+    mbedtls_mpi P;                      /*!<  1st prime factor  */
+    mbedtls_mpi Q;                      /*!<  2nd prime factor  */
+    mbedtls_mpi DP;                     /*!<  D % (P - 1)       */
+    mbedtls_mpi DQ;                     /*!<  D % (Q - 1)       */
+    mbedtls_mpi QP;                     /*!<  1 / (Q % P)       */
+
+    mbedtls_mpi RN;                     /*!<  cached R^2 mod N  */
+    mbedtls_mpi RP;                     /*!<  cached R^2 mod P  */
+    mbedtls_mpi RQ;                     /*!<  cached R^2 mod Q  */
+
+    mbedtls_mpi Vi;                     /*!<  cached blinding value     */
+    mbedtls_mpi Vf;                     /*!<  cached un-blinding value  */
+
+    int padding;                /*!<  MBEDTLS_RSA_PKCS_V15 for 1.5 padding and
+                                      MBEDTLS_RSA_PKCS_v21 for OAEP/PSS         */
+    int hash_id;                /*!<  Hash identifier of mbedtls_md_type_t as
+                                      specified in the mbedtls_md.h header file
+                                      for the EME-OAEP and EMSA-PSS
+                                      encoding                          */
+#if defined(MBEDTLS_THREADING_C)
+    mbedtls_threading_mutex_t mutex;    /*!<  Thread-safety mutex       */
+#endif
+}
+mbedtls_rsa_context;
+
+/**
+ * \brief          Initialize an RSA context
+ *
+ *                 Note: Set padding to MBEDTLS_RSA_PKCS_V21 for the RSAES-OAEP
+ *                 encryption scheme and the RSASSA-PSS signature scheme.
+ *
+ * \param ctx      RSA context to be initialized
+ * \param padding  MBEDTLS_RSA_PKCS_V15 or MBEDTLS_RSA_PKCS_V21
+ * \param hash_id  MBEDTLS_RSA_PKCS_V21 hash identifier
+ *
+ * \note           The hash_id parameter is actually ignored
+ *                 when using MBEDTLS_RSA_PKCS_V15 padding.
+ *
+ * \note           Choice of padding mode is strictly enforced for private key
+ *                 operations, since there might be security concerns in
+ *                 mixing padding modes. For public key operations it's merely
+ *                 a default value, which can be overriden by calling specific
+ *                 rsa_rsaes_xxx or rsa_rsassa_xxx functions.
+ *
+ * \note           The chosen hash is always used for OEAP encryption.
+ *                 For PSS signatures, it's always used for making signatures,
+ *                 but can be overriden (and always is, if set to
+ *                 MBEDTLS_MD_NONE) for verifying them.
+ */
+void mbedtls_rsa_init( mbedtls_rsa_context *ctx,
+               int padding,
+               int hash_id);
+
+/**
+ * \brief          Set padding for an already initialized RSA context
+ *                 See \c mbedtls_rsa_init() for details.
+ *
+ * \param ctx      RSA context to be set
+ * \param padding  MBEDTLS_RSA_PKCS_V15 or MBEDTLS_RSA_PKCS_V21
+ * \param hash_id  MBEDTLS_RSA_PKCS_V21 hash identifier
+ */
+void mbedtls_rsa_set_padding( mbedtls_rsa_context *ctx, int padding, int hash_id);
+
+/**
+ * \brief          Generate an RSA keypair
+ *
+ * \param ctx      RSA context that will hold the key
+ * \param f_rng    RNG function
+ * \param p_rng    RNG parameter
+ * \param nbits    size of the public key in bits
+ * \param exponent public exponent (e.g., 65537)
+ *
+ * \note           mbedtls_rsa_init() must be called beforehand to setup
+ *                 the RSA context.
+ *
+ * \return         0 if successful, or an MBEDTLS_ERR_RSA_XXX error code
+ */
+int mbedtls_rsa_gen_key( mbedtls_rsa_context *ctx,
+                 int (*f_rng)(void *, unsigned char *, size_t),
+                 void *p_rng,
+                 unsigned int nbits, int exponent );
+
+/**
+ * \brief          Check a public RSA key
+ *
+ * \param ctx      RSA context to be checked
+ *
+ * \return         0 if successful, or an MBEDTLS_ERR_RSA_XXX error code
+ */
+int mbedtls_rsa_check_pubkey( const mbedtls_rsa_context *ctx );
+
+/**
+ * \brief          Check a private RSA key
+ *
+ * \param ctx      RSA context to be checked
+ *
+ * \return         0 if successful, or an MBEDTLS_ERR_RSA_XXX error code
+ */
+int mbedtls_rsa_check_privkey( const mbedtls_rsa_context *ctx );
+
+/**
+ * \brief          Check a public-private RSA key pair.
+ *                 Check each of the contexts, and make sure they match.
+ *
+ * \param pub      RSA context holding the public key
+ * \param prv      RSA context holding the private key
+ *
+ * \return         0 if successful, or an MBEDTLS_ERR_RSA_XXX error code
+ */
+int mbedtls_rsa_check_pub_priv( const mbedtls_rsa_context *pub, const mbedtls_rsa_context *prv );
+
+/**
+ * \brief          Do an RSA public key operation
+ *
+ * \param ctx      RSA context
+ * \param input    input buffer
+ * \param output   output buffer
+ *
+ * \return         0 if successful, or an MBEDTLS_ERR_RSA_XXX error code
+ *
+ * \note           This function does NOT take care of message
+ *                 padding. Also, be sure to set input[0] = 0 or ensure that
+ *                 input is smaller than N.
+ *
+ * \note           The input and output buffers must be large
+ *                 enough (eg. 128 bytes if RSA-1024 is used).
+ */
+int mbedtls_rsa_public( mbedtls_rsa_context *ctx,
+                const unsigned char *input,
+                unsigned char *output );
+
+/**
+ * \brief          Do an RSA private key operation
+ *
+ * \param ctx      RSA context
+ * \param f_rng    RNG function (Needed for blinding)
+ * \param p_rng    RNG parameter
+ * \param input    input buffer
+ * \param output   output buffer
+ *
+ * \return         0 if successful, or an MBEDTLS_ERR_RSA_XXX error code
+ *
+ * \note           The input and output buffers must be large
+ *                 enough (eg. 128 bytes if RSA-1024 is used).
+ */
+int mbedtls_rsa_private( mbedtls_rsa_context *ctx,
+                 int (*f_rng)(void *, unsigned char *, size_t),
+                 void *p_rng,
+                 const unsigned char *input,
+                 unsigned char *output );
+
+/**
+ * \brief          Generic wrapper to perform a PKCS#1 encryption using the
+ *                 mode from the context. Add the message padding, then do an
+ *                 RSA operation.
+ *
+ * \param ctx      RSA context
+ * \param f_rng    RNG function (Needed for padding and PKCS#1 v2.1 encoding
+ *                               and MBEDTLS_RSA_PRIVATE)
+ * \param p_rng    RNG parameter
+ * \param mode     MBEDTLS_RSA_PUBLIC or MBEDTLS_RSA_PRIVATE
+ * \param ilen     contains the plaintext length
+ * \param input    buffer holding the data to be encrypted
+ * \param output   buffer that will hold the ciphertext
+ *
+ * \return         0 if successful, or an MBEDTLS_ERR_RSA_XXX error code
+ *
+ * \note           The output buffer must be as large as the size
+ *                 of ctx->N (eg. 128 bytes if RSA-1024 is used).
+ */
+int mbedtls_rsa_pkcs1_encrypt( mbedtls_rsa_context *ctx,
+                       int (*f_rng)(void *, unsigned char *, size_t),
+                       void *p_rng,
+                       int mode, size_t ilen,
+                       const unsigned char *input,
+                       unsigned char *output );
+
+/**
+ * \brief          Perform a PKCS#1 v1.5 encryption (RSAES-PKCS1-v1_5-ENCRYPT)
+ *
+ * \param ctx      RSA context
+ * \param f_rng    RNG function (Needed for padding and MBEDTLS_RSA_PRIVATE)
+ * \param p_rng    RNG parameter
+ * \param mode     MBEDTLS_RSA_PUBLIC or MBEDTLS_RSA_PRIVATE
+ * \param ilen     contains the plaintext length
+ * \param input    buffer holding the data to be encrypted
+ * \param output   buffer that will hold the ciphertext
+ *
+ * \return         0 if successful, or an MBEDTLS_ERR_RSA_XXX error code
+ *
+ * \note           The output buffer must be as large as the size
+ *                 of ctx->N (eg. 128 bytes if RSA-1024 is used).
+ */
+int mbedtls_rsa_rsaes_pkcs1_v15_encrypt( mbedtls_rsa_context *ctx,
+                                 int (*f_rng)(void *, unsigned char *, size_t),
+                                 void *p_rng,
+                                 int mode, size_t ilen,
+                                 const unsigned char *input,
+                                 unsigned char *output );
+
+/**
+ * \brief          Perform a PKCS#1 v2.1 OAEP encryption (RSAES-OAEP-ENCRYPT)
+ *
+ * \param ctx      RSA context
+ * \param f_rng    RNG function (Needed for padding and PKCS#1 v2.1 encoding
+ *                               and MBEDTLS_RSA_PRIVATE)
+ * \param p_rng    RNG parameter
+ * \param mode     MBEDTLS_RSA_PUBLIC or MBEDTLS_RSA_PRIVATE
+ * \param label    buffer holding the custom label to use
+ * \param label_len contains the label length
+ * \param ilen     contains the plaintext length
+ * \param input    buffer holding the data to be encrypted
+ * \param output   buffer that will hold the ciphertext
+ *
+ * \return         0 if successful, or an MBEDTLS_ERR_RSA_XXX error code
+ *
+ * \note           The output buffer must be as large as the size
+ *                 of ctx->N (eg. 128 bytes if RSA-1024 is used).
+ */
+int mbedtls_rsa_rsaes_oaep_encrypt( mbedtls_rsa_context *ctx,
+                            int (*f_rng)(void *, unsigned char *, size_t),
+                            void *p_rng,
+                            int mode,
+                            const unsigned char *label, size_t label_len,
+                            size_t ilen,
+                            const unsigned char *input,
+                            unsigned char *output );
+
+/**
+ * \brief          Generic wrapper to perform a PKCS#1 decryption using the
+ *                 mode from the context. Do an RSA operation, then remove
+ *                 the message padding
+ *
+ * \param ctx      RSA context
+ * \param f_rng    RNG function (Only needed for MBEDTLS_RSA_PRIVATE)
+ * \param p_rng    RNG parameter
+ * \param mode     MBEDTLS_RSA_PUBLIC or MBEDTLS_RSA_PRIVATE
+ * \param olen     will contain the plaintext length
+ * \param input    buffer holding the encrypted data
+ * \param output   buffer that will hold the plaintext
+ * \param output_max_len    maximum length of the output buffer
+ *
+ * \return         0 if successful, or an MBEDTLS_ERR_RSA_XXX error code
+ *
+ * \note           The output buffer length \c output_max_len should be
+ *                 as large as the size ctx->len of ctx->N (eg. 128 bytes
+ *                 if RSA-1024 is used) to be able to hold an arbitrary
+ *                 decrypted message. If it is not large enough to hold
+ *                 the decryption of the particular ciphertext provided, 
+ *                 the function will return MBEDTLS_ERR_RSA_OUTPUT_TOO_LARGE.
+ *
+ * \note           The input buffer must be as large as the size
+ *                 of ctx->N (eg. 128 bytes if RSA-1024 is used).
+ */
+int mbedtls_rsa_pkcs1_decrypt( mbedtls_rsa_context *ctx,
+                       int (*f_rng)(void *, unsigned char *, size_t),
+                       void *p_rng,
+                       int mode, size_t *olen,
+                       const unsigned char *input,
+                       unsigned char *output,
+                       size_t output_max_len );
+
+/**
+ * \brief          Perform a PKCS#1 v1.5 decryption (RSAES-PKCS1-v1_5-DECRYPT)
+ *
+ * \param ctx      RSA context
+ * \param f_rng    RNG function (Only needed for MBEDTLS_RSA_PRIVATE)
+ * \param p_rng    RNG parameter
+ * \param mode     MBEDTLS_RSA_PUBLIC or MBEDTLS_RSA_PRIVATE
+ * \param olen     will contain the plaintext length
+ * \param input    buffer holding the encrypted data
+ * \param output   buffer that will hold the plaintext
+ * \param output_max_len    maximum length of the output buffer
+ *
+ * \return         0 if successful, or an MBEDTLS_ERR_RSA_XXX error code
+ *
+ * \note           The output buffer length \c output_max_len should be
+ *                 as large as the size ctx->len of ctx->N (eg. 128 bytes
+ *                 if RSA-1024 is used) to be able to hold an arbitrary
+ *                 decrypted message. If it is not large enough to hold
+ *                 the decryption of the particular ciphertext provided, 
+ *                 the function will return MBEDTLS_ERR_RSA_OUTPUT_TOO_LARGE.
+ *
+ * \note           The input buffer must be as large as the size
+ *                 of ctx->N (eg. 128 bytes if RSA-1024 is used).
+ */
+int mbedtls_rsa_rsaes_pkcs1_v15_decrypt( mbedtls_rsa_context *ctx,
+                                 int (*f_rng)(void *, unsigned char *, size_t),
+                                 void *p_rng,
+                                 int mode, size_t *olen,
+                                 const unsigned char *input,
+                                 unsigned char *output,
+                                 size_t output_max_len );
+
+/**
+ * \brief          Perform a PKCS#1 v2.1 OAEP decryption (RSAES-OAEP-DECRYPT)
+ *
+ * \param ctx      RSA context
+ * \param f_rng    RNG function (Only needed for MBEDTLS_RSA_PRIVATE)
+ * \param p_rng    RNG parameter
+ * \param mode     MBEDTLS_RSA_PUBLIC or MBEDTLS_RSA_PRIVATE
+ * \param label    buffer holding the custom label to use
+ * \param label_len contains the label length
+ * \param olen     will contain the plaintext length
+ * \param input    buffer holding the encrypted data
+ * \param output   buffer that will hold the plaintext
+ * \param output_max_len    maximum length of the output buffer
+ *
+ * \return         0 if successful, or an MBEDTLS_ERR_RSA_XXX error code
+ *
+ * \note           The output buffer length \c output_max_len should be
+ *                 as large as the size ctx->len of ctx->N (eg. 128 bytes
+ *                 if RSA-1024 is used) to be able to hold an arbitrary
+ *                 decrypted message. If it is not large enough to hold
+ *                 the decryption of the particular ciphertext provided, 
+ *                 the function will return MBEDTLS_ERR_RSA_OUTPUT_TOO_LARGE.
+ *
+ * \note           The input buffer must be as large as the size 
+ *                 of ctx->N (eg. 128 bytes if RSA-1024 is used).
+ */
+int mbedtls_rsa_rsaes_oaep_decrypt( mbedtls_rsa_context *ctx,
+                            int (*f_rng)(void *, unsigned char *, size_t),
+                            void *p_rng,
+                            int mode,
+                            const unsigned char *label, size_t label_len,
+                            size_t *olen,
+                            const unsigned char *input,
+                            unsigned char *output,
+                            size_t output_max_len );
+
+/**
+ * \brief          Generic wrapper to perform a PKCS#1 signature using the
+ *                 mode from the context. Do a private RSA operation to sign
+ *                 a message digest
+ *
+ * \param ctx      RSA context
+ * \param f_rng    RNG function (Needed for PKCS#1 v2.1 encoding and for
+ *                               MBEDTLS_RSA_PRIVATE)
+ * \param p_rng    RNG parameter
+ * \param mode     MBEDTLS_RSA_PUBLIC or MBEDTLS_RSA_PRIVATE
+ * \param md_alg   a MBEDTLS_MD_XXX (use MBEDTLS_MD_NONE for signing raw data)
+ * \param hashlen  message digest length (for MBEDTLS_MD_NONE only)
+ * \param hash     buffer holding the message digest
+ * \param sig      buffer that will hold the ciphertext
+ *
+ * \return         0 if the signing operation was successful,
+ *                 or an MBEDTLS_ERR_RSA_XXX error code
+ *
+ * \note           The "sig" buffer must be as large as the size
+ *                 of ctx->N (eg. 128 bytes if RSA-1024 is used).
+ *
+ * \note           In case of PKCS#1 v2.1 encoding, see comments on
+ * \note           \c mbedtls_rsa_rsassa_pss_sign() for details on md_alg and hash_id.
+ */
+int mbedtls_rsa_pkcs1_sign( mbedtls_rsa_context *ctx,
+                    int (*f_rng)(void *, unsigned char *, size_t),
+                    void *p_rng,
+                    int mode,
+                    mbedtls_md_type_t md_alg,
+                    unsigned int hashlen,
+                    const unsigned char *hash,
+                    unsigned char *sig );
+
+/**
+ * \brief          Perform a PKCS#1 v1.5 signature (RSASSA-PKCS1-v1_5-SIGN)
+ *
+ * \param ctx      RSA context
+ * \param f_rng    RNG function (Only needed for MBEDTLS_RSA_PRIVATE)
+ * \param p_rng    RNG parameter
+ * \param mode     MBEDTLS_RSA_PUBLIC or MBEDTLS_RSA_PRIVATE
+ * \param md_alg   a MBEDTLS_MD_XXX (use MBEDTLS_MD_NONE for signing raw data)
+ * \param hashlen  message digest length (for MBEDTLS_MD_NONE only)
+ * \param hash     buffer holding the message digest
+ * \param sig      buffer that will hold the ciphertext
+ *
+ * \return         0 if the signing operation was successful,
+ *                 or an MBEDTLS_ERR_RSA_XXX error code
+ *
+ * \note           The "sig" buffer must be as large as the size
+ *                 of ctx->N (eg. 128 bytes if RSA-1024 is used).
+ */
+int mbedtls_rsa_rsassa_pkcs1_v15_sign( mbedtls_rsa_context *ctx,
+                               int (*f_rng)(void *, unsigned char *, size_t),
+                               void *p_rng,
+                               int mode,
+                               mbedtls_md_type_t md_alg,
+                               unsigned int hashlen,
+                               const unsigned char *hash,
+                               unsigned char *sig );
+
+/**
+ * \brief          Perform a PKCS#1 v2.1 PSS signature (RSASSA-PSS-SIGN)
+ *
+ * \param ctx      RSA context
+ * \param f_rng    RNG function (Needed for PKCS#1 v2.1 encoding and for
+ *                               MBEDTLS_RSA_PRIVATE)
+ * \param p_rng    RNG parameter
+ * \param mode     MBEDTLS_RSA_PUBLIC or MBEDTLS_RSA_PRIVATE
+ * \param md_alg   a MBEDTLS_MD_XXX (use MBEDTLS_MD_NONE for signing raw data)
+ * \param hashlen  message digest length (for MBEDTLS_MD_NONE only)
+ * \param hash     buffer holding the message digest
+ * \param sig      buffer that will hold the ciphertext
+ *
+ * \return         0 if the signing operation was successful,
+ *                 or an MBEDTLS_ERR_RSA_XXX error code
+ *
+ * \note           The "sig" buffer must be as large as the size
+ *                 of ctx->N (eg. 128 bytes if RSA-1024 is used).
+ *
+ * \note           The hash_id in the RSA context is the one used for the
+ *                 encoding. md_alg in the function call is the type of hash
+ *                 that is encoded. According to RFC 3447 it is advised to
+ *                 keep both hashes the same.
+ */
+int mbedtls_rsa_rsassa_pss_sign( mbedtls_rsa_context *ctx,
+                         int (*f_rng)(void *, unsigned char *, size_t),
+                         void *p_rng,
+                         int mode,
+                         mbedtls_md_type_t md_alg,
+                         unsigned int hashlen,
+                         const unsigned char *hash,
+                         unsigned char *sig );
+
+/**
+ * \brief          Generic wrapper to perform a PKCS#1 verification using the
+ *                 mode from the context. Do a public RSA operation and check
+ *                 the message digest
+ *
+ * \param ctx      points to an RSA public key
+ * \param f_rng    RNG function (Only needed for MBEDTLS_RSA_PRIVATE)
+ * \param p_rng    RNG parameter
+ * \param mode     MBEDTLS_RSA_PUBLIC or MBEDTLS_RSA_PRIVATE
+ * \param md_alg   a MBEDTLS_MD_XXX (use MBEDTLS_MD_NONE for signing raw data)
+ * \param hashlen  message digest length (for MBEDTLS_MD_NONE only)
+ * \param hash     buffer holding the message digest
+ * \param sig      buffer holding the ciphertext
+ *
+ * \return         0 if the verify operation was successful,
+ *                 or an MBEDTLS_ERR_RSA_XXX error code
+ *
+ * \note           The "sig" buffer must be as large as the size
+ *                 of ctx->N (eg. 128 bytes if RSA-1024 is used).
+ *
+ * \note           In case of PKCS#1 v2.1 encoding, see comments on
+ *                 \c mbedtls_rsa_rsassa_pss_verify() about md_alg and hash_id.
+ */
+int mbedtls_rsa_pkcs1_verify( mbedtls_rsa_context *ctx,
+                      int (*f_rng)(void *, unsigned char *, size_t),
+                      void *p_rng,
+                      int mode,
+                      mbedtls_md_type_t md_alg,
+                      unsigned int hashlen,
+                      const unsigned char *hash,
+                      const unsigned char *sig );
+
+/**
+ * \brief          Perform a PKCS#1 v1.5 verification (RSASSA-PKCS1-v1_5-VERIFY)
+ *
+ * \param ctx      points to an RSA public key
+ * \param f_rng    RNG function (Only needed for MBEDTLS_RSA_PRIVATE)
+ * \param p_rng    RNG parameter
+ * \param mode     MBEDTLS_RSA_PUBLIC or MBEDTLS_RSA_PRIVATE
+ * \param md_alg   a MBEDTLS_MD_XXX (use MBEDTLS_MD_NONE for signing raw data)
+ * \param hashlen  message digest length (for MBEDTLS_MD_NONE only)
+ * \param hash     buffer holding the message digest
+ * \param sig      buffer holding the ciphertext
+ *
+ * \return         0 if the verify operation was successful,
+ *                 or an MBEDTLS_ERR_RSA_XXX error code
+ *
+ * \note           The "sig" buffer must be as large as the size
+ *                 of ctx->N (eg. 128 bytes if RSA-1024 is used).
+ */
+int mbedtls_rsa_rsassa_pkcs1_v15_verify( mbedtls_rsa_context *ctx,
+                                 int (*f_rng)(void *, unsigned char *, size_t),
+                                 void *p_rng,
+                                 int mode,
+                                 mbedtls_md_type_t md_alg,
+                                 unsigned int hashlen,
+                                 const unsigned char *hash,
+                                 const unsigned char *sig );
+
+/**
+ * \brief          Perform a PKCS#1 v2.1 PSS verification (RSASSA-PSS-VERIFY)
+ *                 (This is the "simple" version.)
+ *
+ * \param ctx      points to an RSA public key
+ * \param f_rng    RNG function (Only needed for MBEDTLS_RSA_PRIVATE)
+ * \param p_rng    RNG parameter
+ * \param mode     MBEDTLS_RSA_PUBLIC or MBEDTLS_RSA_PRIVATE
+ * \param md_alg   a MBEDTLS_MD_XXX (use MBEDTLS_MD_NONE for signing raw data)
+ * \param hashlen  message digest length (for MBEDTLS_MD_NONE only)
+ * \param hash     buffer holding the message digest
+ * \param sig      buffer holding the ciphertext
+ *
+ * \return         0 if the verify operation was successful,
+ *                 or an MBEDTLS_ERR_RSA_XXX error code
+ *
+ * \note           The "sig" buffer must be as large as the size
+ *                 of ctx->N (eg. 128 bytes if RSA-1024 is used).
+ *
+ * \note           The hash_id in the RSA context is the one used for the
+ *                 verification. md_alg in the function call is the type of
+ *                 hash that is verified. According to RFC 3447 it is advised to
+ *                 keep both hashes the same. If hash_id in the RSA context is
+ *                 unset, the md_alg from the function call is used.
+ */
+int mbedtls_rsa_rsassa_pss_verify( mbedtls_rsa_context *ctx,
+                           int (*f_rng)(void *, unsigned char *, size_t),
+                           void *p_rng,
+                           int mode,
+                           mbedtls_md_type_t md_alg,
+                           unsigned int hashlen,
+                           const unsigned char *hash,
+                           const unsigned char *sig );
+
+/**
+ * \brief          Perform a PKCS#1 v2.1 PSS verification (RSASSA-PSS-VERIFY)
+ *                 (This is the version with "full" options.)
+ *
+ * \param ctx      points to an RSA public key
+ * \param f_rng    RNG function (Only needed for MBEDTLS_RSA_PRIVATE)
+ * \param p_rng    RNG parameter
+ * \param mode     MBEDTLS_RSA_PUBLIC or MBEDTLS_RSA_PRIVATE
+ * \param md_alg   a MBEDTLS_MD_XXX (use MBEDTLS_MD_NONE for signing raw data)
+ * \param hashlen  message digest length (for MBEDTLS_MD_NONE only)
+ * \param hash     buffer holding the message digest
+ * \param mgf1_hash_id message digest used for mask generation
+ * \param expected_salt_len Length of the salt used in padding, use
+ *                 MBEDTLS_RSA_SALT_LEN_ANY to accept any salt length
+ * \param sig      buffer holding the ciphertext
+ *
+ * \return         0 if the verify operation was successful,
+ *                 or an MBEDTLS_ERR_RSA_XXX error code
+ *
+ * \note           The "sig" buffer must be as large as the size
+ *                 of ctx->N (eg. 128 bytes if RSA-1024 is used).
+ *
+ * \note           The hash_id in the RSA context is ignored.
+ */
+int mbedtls_rsa_rsassa_pss_verify_ext( mbedtls_rsa_context *ctx,
+                               int (*f_rng)(void *, unsigned char *, size_t),
+                               void *p_rng,
+                               int mode,
+                               mbedtls_md_type_t md_alg,
+                               unsigned int hashlen,
+                               const unsigned char *hash,
+                               mbedtls_md_type_t mgf1_hash_id,
+                               int expected_salt_len,
+                               const unsigned char *sig );
+
+/**
+ * \brief          Copy the components of an RSA context
+ *
+ * \param dst      Destination context
+ * \param src      Source context
+ *
+ * \return         0 on success,
+ *                 MBEDTLS_ERR_MPI_ALLOC_FAILED on memory allocation failure
+ */
+int mbedtls_rsa_copy( mbedtls_rsa_context *dst, const mbedtls_rsa_context *src );
+
+/**
+ * \brief          Free the components of an RSA key
+ *
+ * \param ctx      RSA Context to free
+ */
+void mbedtls_rsa_free( mbedtls_rsa_context *ctx );
+
+/**
+ * \brief          Checkup routine
+ *
+ * \return         0 if successful, or 1 if the test failed
+ */
+int mbedtls_rsa_self_test( int verbose );
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* MBEDTLS_RSA_C */
+
+#endif /* rsa.h */
diff --git a/backport/compat/verification/mbedtls/sha1.h b/backport/compat/verification/mbedtls/sha1.h
new file mode 100644
index 000000000000..b8752eddfdb5
--- /dev/null
+++ b/backport/compat/verification/mbedtls/sha1.h
@@ -0,0 +1,135 @@
+/**
+ * \file sha1.h
+ *
+ * \brief SHA-1 cryptographic hash function
+ *
+ *  Copyright (C) 2006-2015, ARM Limited, All Rights Reserved
+ *  SPDX-License-Identifier: GPL-2.0
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ *  This file is part of mbed TLS (https://tls.mbed.org)
+ */
+#ifndef MBEDTLS_SHA1_H
+#define MBEDTLS_SHA1_H
+
+#if !defined(MBEDTLS_CONFIG_FILE)
+#include "config.h"
+#else
+#include MBEDTLS_CONFIG_FILE
+#endif
+
+#if !defined(MBEDTLS_SHA1_ALT)
+// Regular implementation
+//
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/**
+ * \brief          SHA-1 context structure
+ */
+typedef struct
+{
+    uint32_t total[2];          /*!< number of bytes processed  */
+    uint32_t state[5];          /*!< intermediate digest state  */
+    unsigned char buffer[64];   /*!< data block being processed */
+}
+mbedtls_sha1_context;
+
+/**
+ * \brief          Initialize SHA-1 context
+ *
+ * \param ctx      SHA-1 context to be initialized
+ */
+void mbedtls_sha1_init( mbedtls_sha1_context *ctx );
+
+/**
+ * \brief          Clear SHA-1 context
+ *
+ * \param ctx      SHA-1 context to be cleared
+ */
+void mbedtls_sha1_free( mbedtls_sha1_context *ctx );
+
+/**
+ * \brief          Clone (the state of) a SHA-1 context
+ *
+ * \param dst      The destination context
+ * \param src      The context to be cloned
+ */
+void mbedtls_sha1_clone( mbedtls_sha1_context *dst,
+                         const mbedtls_sha1_context *src );
+
+/**
+ * \brief          SHA-1 context setup
+ *
+ * \param ctx      context to be initialized
+ */
+void mbedtls_sha1_starts( mbedtls_sha1_context *ctx );
+
+/**
+ * \brief          SHA-1 process buffer
+ *
+ * \param ctx      SHA-1 context
+ * \param input    buffer holding the  data
+ * \param ilen     length of the input data
+ */
+void mbedtls_sha1_update( mbedtls_sha1_context *ctx, const unsigned char *input, size_t ilen );
+
+/**
+ * \brief          SHA-1 final digest
+ *
+ * \param ctx      SHA-1 context
+ * \param output   SHA-1 checksum result
+ */
+void mbedtls_sha1_finish( mbedtls_sha1_context *ctx, unsigned char output[20] );
+
+/* Internal use */
+void mbedtls_sha1_process( mbedtls_sha1_context *ctx, const unsigned char data[64] );
+
+#ifdef __cplusplus
+}
+#endif
+
+#else  /* MBEDTLS_SHA1_ALT */
+#include "sha1_alt.h"
+#endif /* MBEDTLS_SHA1_ALT */
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/**
+ * \brief          Output = SHA-1( input buffer )
+ *
+ * \param input    buffer holding the  data
+ * \param ilen     length of the input data
+ * \param output   SHA-1 checksum result
+ */
+void mbedtls_sha1( const unsigned char *input, size_t ilen, unsigned char output[20] );
+
+/**
+ * \brief          Checkup routine
+ *
+ * \return         0 if successful, or 1 if the test failed
+ */
+int mbedtls_sha1_self_test( int verbose );
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* mbedtls_sha1.h */
diff --git a/backport/compat/verification/mbedtls/sha256.h b/backport/compat/verification/mbedtls/sha256.h
new file mode 100644
index 000000000000..68223f0bf5bd
--- /dev/null
+++ b/backport/compat/verification/mbedtls/sha256.h
@@ -0,0 +1,140 @@
+/**
+ * \file sha256.h
+ *
+ * \brief SHA-224 and SHA-256 cryptographic hash function
+ *
+ *  Copyright (C) 2006-2015, ARM Limited, All Rights Reserved
+ *  SPDX-License-Identifier: GPL-2.0
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ *  This file is part of mbed TLS (https://tls.mbed.org)
+ */
+#ifndef MBEDTLS_SHA256_H
+#define MBEDTLS_SHA256_H
+
+#if !defined(MBEDTLS_CONFIG_FILE)
+#include "config.h"
+#else
+#include MBEDTLS_CONFIG_FILE
+#endif
+
+#if !defined(MBEDTLS_SHA256_ALT)
+// Regular implementation
+//
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/**
+ * \brief          SHA-256 context structure
+ */
+typedef struct
+{
+    uint32_t total[2];          /*!< number of bytes processed  */
+    uint32_t state[8];          /*!< intermediate digest state  */
+    unsigned char buffer[64];   /*!< data block being processed */
+    int is224;                  /*!< 0 => SHA-256, else SHA-224 */
+}
+mbedtls_sha256_context;
+
+/**
+ * \brief          Initialize SHA-256 context
+ *
+ * \param ctx      SHA-256 context to be initialized
+ */
+void mbedtls_sha256_init( mbedtls_sha256_context *ctx );
+
+/**
+ * \brief          Clear SHA-256 context
+ *
+ * \param ctx      SHA-256 context to be cleared
+ */
+void mbedtls_sha256_free( mbedtls_sha256_context *ctx );
+
+/**
+ * \brief          Clone (the state of) a SHA-256 context
+ *
+ * \param dst      The destination context
+ * \param src      The context to be cloned
+ */
+void mbedtls_sha256_clone( mbedtls_sha256_context *dst,
+                           const mbedtls_sha256_context *src );
+
+/**
+ * \brief          SHA-256 context setup
+ *
+ * \param ctx      context to be initialized
+ * \param is224    0 = use SHA256, 1 = use SHA224
+ */
+void mbedtls_sha256_starts( mbedtls_sha256_context *ctx, int is224 );
+
+/**
+ * \brief          SHA-256 process buffer
+ *
+ * \param ctx      SHA-256 context
+ * \param input    buffer holding the  data
+ * \param ilen     length of the input data
+ */
+void mbedtls_sha256_update( mbedtls_sha256_context *ctx, const unsigned char *input,
+                    size_t ilen );
+
+/**
+ * \brief          SHA-256 final digest
+ *
+ * \param ctx      SHA-256 context
+ * \param output   SHA-224/256 checksum result
+ */
+void mbedtls_sha256_finish( mbedtls_sha256_context *ctx, unsigned char output[32] );
+
+/* Internal use */
+void mbedtls_sha256_process( mbedtls_sha256_context *ctx, const unsigned char data[64] );
+
+#ifdef __cplusplus
+}
+#endif
+
+#else  /* MBEDTLS_SHA256_ALT */
+#include "sha256_alt.h"
+#endif /* MBEDTLS_SHA256_ALT */
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/**
+ * \brief          Output = SHA-256( input buffer )
+ *
+ * \param input    buffer holding the  data
+ * \param ilen     length of the input data
+ * \param output   SHA-224/256 checksum result
+ * \param is224    0 = use SHA256, 1 = use SHA224
+ */
+void mbedtls_sha256( const unsigned char *input, size_t ilen,
+           unsigned char output[32], int is224 );
+
+/**
+ * \brief          Checkup routine
+ *
+ * \return         0 if successful, or 1 if the test failed
+ */
+int mbedtls_sha256_self_test( int verbose );
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* mbedtls_sha256.h */
diff --git a/backport/compat/verification/md.c b/backport/compat/verification/md.c
new file mode 100644
index 000000000000..cff0753435ba
--- /dev/null
+++ b/backport/compat/verification/md.c
@@ -0,0 +1,471 @@
+/**
+ * \file mbedtls_md.c
+ *
+ * \brief Generic message digest wrapper for mbed TLS
+ *
+ * \author Adriaan de Jong <dejong@fox-it.com>
+ *
+ *  Copyright (C) 2006-2015, ARM Limited, All Rights Reserved
+ *  SPDX-License-Identifier: GPL-2.0
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ *  This file is part of mbed TLS (https://tls.mbed.org)
+ */
+
+#if !defined(MBEDTLS_CONFIG_FILE)
+#include "mbedtls/config.h"
+#else
+#include MBEDTLS_CONFIG_FILE
+#endif
+
+#if defined(MBEDTLS_MD_C)
+
+#include "mbedtls/md.h"
+#include "mbedtls/md_internal.h"
+
+#if defined(MBEDTLS_PLATFORM_C)
+#include "mbedtls/platform.h"
+#else
+#include <stdlib.h>
+#define mbedtls_calloc    calloc
+#define mbedtls_free       free
+#endif
+
+#if defined(MBEDTLS_FS_IO)
+#include <stdio.h>
+#endif
+
+/* Implementation that should never be optimized out by the compiler */
+static void mbedtls_zeroize( void *v, size_t n ) {
+    volatile unsigned char *p = v; while( n-- ) *p++ = 0;
+}
+
+/*
+ * Reminder: update profiles in x509_crt.c when adding a new hash!
+ */
+static const int supported_digests[] = {
+
+#if defined(MBEDTLS_SHA512_C)
+        MBEDTLS_MD_SHA512,
+        MBEDTLS_MD_SHA384,
+#endif
+
+#if defined(MBEDTLS_SHA256_C)
+        MBEDTLS_MD_SHA256,
+        MBEDTLS_MD_SHA224,
+#endif
+
+#if defined(MBEDTLS_SHA1_C)
+        MBEDTLS_MD_SHA1,
+#endif
+
+#if defined(MBEDTLS_RIPEMD160_C)
+        MBEDTLS_MD_RIPEMD160,
+#endif
+
+#if defined(MBEDTLS_MD5_C)
+        MBEDTLS_MD_MD5,
+#endif
+
+#if defined(MBEDTLS_MD4_C)
+        MBEDTLS_MD_MD4,
+#endif
+
+#if defined(MBEDTLS_MD2_C)
+        MBEDTLS_MD_MD2,
+#endif
+
+        MBEDTLS_MD_NONE
+};
+
+const int *mbedtls_md_list( void )
+{
+    return( supported_digests );
+}
+
+const mbedtls_md_info_t *mbedtls_md_info_from_string( const char *md_name )
+{
+    if( NULL == md_name )
+        return( NULL );
+
+    /* Get the appropriate digest information */
+#if defined(MBEDTLS_MD2_C)
+    if( !strcmp( "MD2", md_name ) )
+        return mbedtls_md_info_from_type( MBEDTLS_MD_MD2 );
+#endif
+#if defined(MBEDTLS_MD4_C)
+    if( !strcmp( "MD4", md_name ) )
+        return mbedtls_md_info_from_type( MBEDTLS_MD_MD4 );
+#endif
+#if defined(MBEDTLS_MD5_C)
+    if( !strcmp( "MD5", md_name ) )
+        return mbedtls_md_info_from_type( MBEDTLS_MD_MD5 );
+#endif
+#if defined(MBEDTLS_RIPEMD160_C)
+    if( !strcmp( "RIPEMD160", md_name ) )
+        return mbedtls_md_info_from_type( MBEDTLS_MD_RIPEMD160 );
+#endif
+#if defined(MBEDTLS_SHA1_C)
+    if( !strcmp( "SHA1", md_name ) || !strcmp( "SHA", md_name ) )
+        return mbedtls_md_info_from_type( MBEDTLS_MD_SHA1 );
+#endif
+#if defined(MBEDTLS_SHA256_C)
+    if( !strcmp( "SHA224", md_name ) )
+        return mbedtls_md_info_from_type( MBEDTLS_MD_SHA224 );
+    if( !strcmp( "SHA256", md_name ) )
+        return mbedtls_md_info_from_type( MBEDTLS_MD_SHA256 );
+#endif
+#if defined(MBEDTLS_SHA512_C)
+    if( !strcmp( "SHA384", md_name ) )
+        return mbedtls_md_info_from_type( MBEDTLS_MD_SHA384 );
+    if( !strcmp( "SHA512", md_name ) )
+        return mbedtls_md_info_from_type( MBEDTLS_MD_SHA512 );
+#endif
+    return( NULL );
+}
+
+const mbedtls_md_info_t *mbedtls_md_info_from_type( mbedtls_md_type_t md_type )
+{
+    switch( md_type )
+    {
+#if defined(MBEDTLS_MD2_C)
+        case MBEDTLS_MD_MD2:
+            return( &mbedtls_md2_info );
+#endif
+#if defined(MBEDTLS_MD4_C)
+        case MBEDTLS_MD_MD4:
+            return( &mbedtls_md4_info );
+#endif
+#if defined(MBEDTLS_MD5_C)
+        case MBEDTLS_MD_MD5:
+            return( &mbedtls_md5_info );
+#endif
+#if defined(MBEDTLS_RIPEMD160_C)
+        case MBEDTLS_MD_RIPEMD160:
+            return( &mbedtls_ripemd160_info );
+#endif
+#if defined(MBEDTLS_SHA1_C)
+        case MBEDTLS_MD_SHA1:
+            return( &mbedtls_sha1_info );
+#endif
+#if defined(MBEDTLS_SHA256_C)
+        case MBEDTLS_MD_SHA224:
+            return( &mbedtls_sha224_info );
+        case MBEDTLS_MD_SHA256:
+            return( &mbedtls_sha256_info );
+#endif
+#if defined(MBEDTLS_SHA512_C)
+        case MBEDTLS_MD_SHA384:
+            return( &mbedtls_sha384_info );
+        case MBEDTLS_MD_SHA512:
+            return( &mbedtls_sha512_info );
+#endif
+        default:
+            return( NULL );
+    }
+}
+
+void mbedtls_md_init( mbedtls_md_context_t *ctx )
+{
+    memset( ctx, 0, sizeof( mbedtls_md_context_t ) );
+}
+
+void mbedtls_md_free( mbedtls_md_context_t *ctx )
+{
+    if( ctx == NULL || ctx->md_info == NULL )
+        return;
+
+    if( ctx->md_ctx != NULL )
+        ctx->md_info->ctx_free_func( ctx->md_ctx );
+
+    if( ctx->hmac_ctx != NULL )
+    {
+        mbedtls_zeroize( ctx->hmac_ctx, 2 * ctx->md_info->block_size );
+        mbedtls_free( ctx->hmac_ctx );
+    }
+
+    mbedtls_zeroize( ctx, sizeof( mbedtls_md_context_t ) );
+}
+
+int mbedtls_md_clone( mbedtls_md_context_t *dst,
+                      const mbedtls_md_context_t *src )
+{
+    if( dst == NULL || dst->md_info == NULL ||
+        src == NULL || src->md_info == NULL ||
+        dst->md_info != src->md_info )
+    {
+        return( MBEDTLS_ERR_MD_BAD_INPUT_DATA );
+    }
+
+    dst->md_info->clone_func( dst->md_ctx, src->md_ctx );
+
+    return( 0 );
+}
+
+#if ! defined(MBEDTLS_DEPRECATED_REMOVED)
+int mbedtls_md_init_ctx( mbedtls_md_context_t *ctx, const mbedtls_md_info_t *md_info )
+{
+    return mbedtls_md_setup( ctx, md_info, 1 );
+}
+#endif
+
+int mbedtls_md_setup( mbedtls_md_context_t *ctx, const mbedtls_md_info_t *md_info, int hmac )
+{
+    if( md_info == NULL || ctx == NULL )
+        return( MBEDTLS_ERR_MD_BAD_INPUT_DATA );
+
+    if( ( ctx->md_ctx = md_info->ctx_alloc_func() ) == NULL )
+        return( MBEDTLS_ERR_MD_ALLOC_FAILED );
+
+    if( hmac != 0 )
+    {
+        ctx->hmac_ctx = mbedtls_calloc( 2, md_info->block_size );
+        if( ctx->hmac_ctx == NULL )
+        {
+            md_info->ctx_free_func( ctx->md_ctx );
+            return( MBEDTLS_ERR_MD_ALLOC_FAILED );
+        }
+    }
+
+    ctx->md_info = md_info;
+
+    return( 0 );
+}
+
+int mbedtls_md_starts( mbedtls_md_context_t *ctx )
+{
+    if( ctx == NULL || ctx->md_info == NULL )
+        return( MBEDTLS_ERR_MD_BAD_INPUT_DATA );
+
+    ctx->md_info->starts_func( ctx->md_ctx );
+
+    return( 0 );
+}
+
+int mbedtls_md_update( mbedtls_md_context_t *ctx, const unsigned char *input, size_t ilen )
+{
+    if( ctx == NULL || ctx->md_info == NULL )
+        return( MBEDTLS_ERR_MD_BAD_INPUT_DATA );
+
+    ctx->md_info->update_func( ctx->md_ctx, input, ilen );
+
+    return( 0 );
+}
+
+int mbedtls_md_finish( mbedtls_md_context_t *ctx, unsigned char *output )
+{
+    if( ctx == NULL || ctx->md_info == NULL )
+        return( MBEDTLS_ERR_MD_BAD_INPUT_DATA );
+
+    ctx->md_info->finish_func( ctx->md_ctx, output );
+
+    return( 0 );
+}
+
+int mbedtls_md( const mbedtls_md_info_t *md_info, const unsigned char *input, size_t ilen,
+            unsigned char *output )
+{
+    if( md_info == NULL )
+        return( MBEDTLS_ERR_MD_BAD_INPUT_DATA );
+
+    md_info->digest_func( input, ilen, output );
+
+    return( 0 );
+}
+
+#if defined(MBEDTLS_FS_IO)
+int mbedtls_md_file( const mbedtls_md_info_t *md_info, const char *path, unsigned char *output )
+{
+    int ret;
+    FILE *f;
+    size_t n;
+    mbedtls_md_context_t ctx;
+    unsigned char buf[1024];
+
+    if( md_info == NULL )
+        return( MBEDTLS_ERR_MD_BAD_INPUT_DATA );
+
+    if( ( f = fopen( path, "rb" ) ) == NULL )
+        return( MBEDTLS_ERR_MD_FILE_IO_ERROR );
+
+    mbedtls_md_init( &ctx );
+
+    if( ( ret = mbedtls_md_setup( &ctx, md_info, 0 ) ) != 0 )
+        goto cleanup;
+
+    md_info->starts_func( ctx.md_ctx );
+
+    while( ( n = fread( buf, 1, sizeof( buf ), f ) ) > 0 )
+        md_info->update_func( ctx.md_ctx, buf, n );
+
+    if( ferror( f ) != 0 )
+    {
+        ret = MBEDTLS_ERR_MD_FILE_IO_ERROR;
+        goto cleanup;
+    }
+
+    md_info->finish_func( ctx.md_ctx, output );
+
+cleanup:
+    fclose( f );
+    mbedtls_md_free( &ctx );
+
+    return( ret );
+}
+#endif /* MBEDTLS_FS_IO */
+
+int mbedtls_md_hmac_starts( mbedtls_md_context_t *ctx, const unsigned char *key, size_t keylen )
+{
+    unsigned char sum[MBEDTLS_MD_MAX_SIZE];
+    unsigned char *ipad, *opad;
+    size_t i;
+
+    if( ctx == NULL || ctx->md_info == NULL || ctx->hmac_ctx == NULL )
+        return( MBEDTLS_ERR_MD_BAD_INPUT_DATA );
+
+    if( keylen > (size_t) ctx->md_info->block_size )
+    {
+        ctx->md_info->starts_func( ctx->md_ctx );
+        ctx->md_info->update_func( ctx->md_ctx, key, keylen );
+        ctx->md_info->finish_func( ctx->md_ctx, sum );
+
+        keylen = ctx->md_info->size;
+        key = sum;
+    }
+
+    ipad = (unsigned char *) ctx->hmac_ctx;
+    opad = (unsigned char *) ctx->hmac_ctx + ctx->md_info->block_size;
+
+    memset( ipad, 0x36, ctx->md_info->block_size );
+    memset( opad, 0x5C, ctx->md_info->block_size );
+
+    for( i = 0; i < keylen; i++ )
+    {
+        ipad[i] = (unsigned char)( ipad[i] ^ key[i] );
+        opad[i] = (unsigned char)( opad[i] ^ key[i] );
+    }
+
+    mbedtls_zeroize( sum, sizeof( sum ) );
+
+    ctx->md_info->starts_func( ctx->md_ctx );
+    ctx->md_info->update_func( ctx->md_ctx, ipad, ctx->md_info->block_size );
+
+    return( 0 );
+}
+
+int mbedtls_md_hmac_update( mbedtls_md_context_t *ctx, const unsigned char *input, size_t ilen )
+{
+    if( ctx == NULL || ctx->md_info == NULL || ctx->hmac_ctx == NULL )
+        return( MBEDTLS_ERR_MD_BAD_INPUT_DATA );
+
+    ctx->md_info->update_func( ctx->md_ctx, input, ilen );
+
+    return( 0 );
+}
+
+int mbedtls_md_hmac_finish( mbedtls_md_context_t *ctx, unsigned char *output )
+{
+    unsigned char tmp[MBEDTLS_MD_MAX_SIZE];
+    unsigned char *opad;
+
+    if( ctx == NULL || ctx->md_info == NULL || ctx->hmac_ctx == NULL )
+        return( MBEDTLS_ERR_MD_BAD_INPUT_DATA );
+
+    opad = (unsigned char *) ctx->hmac_ctx + ctx->md_info->block_size;
+
+    ctx->md_info->finish_func( ctx->md_ctx, tmp );
+    ctx->md_info->starts_func( ctx->md_ctx );
+    ctx->md_info->update_func( ctx->md_ctx, opad, ctx->md_info->block_size );
+    ctx->md_info->update_func( ctx->md_ctx, tmp, ctx->md_info->size );
+    ctx->md_info->finish_func( ctx->md_ctx, output );
+
+    return( 0 );
+}
+
+int mbedtls_md_hmac_reset( mbedtls_md_context_t *ctx )
+{
+    unsigned char *ipad;
+
+    if( ctx == NULL || ctx->md_info == NULL || ctx->hmac_ctx == NULL )
+        return( MBEDTLS_ERR_MD_BAD_INPUT_DATA );
+
+    ipad = (unsigned char *) ctx->hmac_ctx;
+
+    ctx->md_info->starts_func( ctx->md_ctx );
+    ctx->md_info->update_func( ctx->md_ctx, ipad, ctx->md_info->block_size );
+
+    return( 0 );
+}
+
+int mbedtls_md_hmac( const mbedtls_md_info_t *md_info, const unsigned char *key, size_t keylen,
+                const unsigned char *input, size_t ilen,
+                unsigned char *output )
+{
+    mbedtls_md_context_t ctx;
+    int ret;
+
+    if( md_info == NULL )
+        return( MBEDTLS_ERR_MD_BAD_INPUT_DATA );
+
+    mbedtls_md_init( &ctx );
+
+    if( ( ret = mbedtls_md_setup( &ctx, md_info, 1 ) ) != 0 )
+        return( ret );
+
+    mbedtls_md_hmac_starts( &ctx, key, keylen );
+    mbedtls_md_hmac_update( &ctx, input, ilen );
+    mbedtls_md_hmac_finish( &ctx, output );
+
+    mbedtls_md_free( &ctx );
+
+    return( 0 );
+}
+
+int mbedtls_md_process( mbedtls_md_context_t *ctx, const unsigned char *data )
+{
+    if( ctx == NULL || ctx->md_info == NULL )
+        return( MBEDTLS_ERR_MD_BAD_INPUT_DATA );
+
+    ctx->md_info->process_func( ctx->md_ctx, data );
+
+    return( 0 );
+}
+
+unsigned char mbedtls_md_get_size( const mbedtls_md_info_t *md_info )
+{
+    if( md_info == NULL )
+        return( 0 );
+
+    return md_info->size;
+}
+
+mbedtls_md_type_t mbedtls_md_get_type( const mbedtls_md_info_t *md_info )
+{
+    if( md_info == NULL )
+        return( MBEDTLS_MD_NONE );
+
+    return md_info->type;
+}
+
+const char *mbedtls_md_get_name( const mbedtls_md_info_t *md_info )
+{
+    if( md_info == NULL )
+        return( NULL );
+
+    return md_info->name;
+}
+
+#endif /* MBEDTLS_MD_C */
diff --git a/backport/compat/verification/md_wrap.c b/backport/compat/verification/md_wrap.c
new file mode 100644
index 000000000000..49c47d69d10a
--- /dev/null
+++ b/backport/compat/verification/md_wrap.c
@@ -0,0 +1,577 @@
+/**
+ * \file md_wrap.c
+ *
+ * \brief Generic message digest wrapper for mbed TLS
+ *
+ * \author Adriaan de Jong <dejong@fox-it.com>
+ *
+ *  Copyright (C) 2006-2015, ARM Limited, All Rights Reserved
+ *  SPDX-License-Identifier: GPL-2.0
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ *  This file is part of mbed TLS (https://tls.mbed.org)
+ */
+
+#if !defined(MBEDTLS_CONFIG_FILE)
+#include "mbedtls/config.h"
+#else
+#include MBEDTLS_CONFIG_FILE
+#endif
+
+#if defined(MBEDTLS_MD_C)
+
+#include "mbedtls/md_internal.h"
+
+#if defined(MBEDTLS_MD2_C)
+#include "mbedtls/md2.h"
+#endif
+
+#if defined(MBEDTLS_MD4_C)
+#include "mbedtls/md4.h"
+#endif
+
+#if defined(MBEDTLS_MD5_C)
+#include "mbedtls/md5.h"
+#endif
+
+#if defined(MBEDTLS_RIPEMD160_C)
+#include "mbedtls/ripemd160.h"
+#endif
+
+#if defined(MBEDTLS_SHA1_C)
+#include "mbedtls/sha1.h"
+#endif
+
+#if defined(MBEDTLS_SHA256_C)
+#include "mbedtls/sha256.h"
+#endif
+
+#if defined(MBEDTLS_SHA512_C)
+#include "mbedtls/sha512.h"
+#endif
+
+#if defined(MBEDTLS_PLATFORM_C)
+#include "mbedtls/platform.h"
+#else
+#include <stdlib.h>
+#define mbedtls_calloc    calloc
+#define mbedtls_free       free
+#endif
+
+#if defined(MBEDTLS_MD2_C)
+
+static void md2_starts_wrap( void *ctx )
+{
+    mbedtls_md2_starts( (mbedtls_md2_context *) ctx );
+}
+
+static void md2_update_wrap( void *ctx, const unsigned char *input,
+                             size_t ilen )
+{
+    mbedtls_md2_update( (mbedtls_md2_context *) ctx, input, ilen );
+}
+
+static void md2_finish_wrap( void *ctx, unsigned char *output )
+{
+    mbedtls_md2_finish( (mbedtls_md2_context *) ctx, output );
+}
+
+static void *md2_ctx_alloc( void )
+{
+    void *ctx = mbedtls_calloc( 1, sizeof( mbedtls_md2_context ) );
+
+    if( ctx != NULL )
+        mbedtls_md2_init( (mbedtls_md2_context *) ctx );
+
+    return( ctx );
+}
+
+static void md2_ctx_free( void *ctx )
+{
+    mbedtls_md2_free( (mbedtls_md2_context *) ctx );
+    mbedtls_free( ctx );
+}
+
+static void md2_clone_wrap( void *dst, const void *src )
+{
+    mbedtls_md2_clone( (mbedtls_md2_context *) dst,
+                 (const mbedtls_md2_context *) src );
+}
+
+static void md2_process_wrap( void *ctx, const unsigned char *data )
+{
+    ((void) data);
+
+    mbedtls_md2_process( (mbedtls_md2_context *) ctx );
+}
+
+const mbedtls_md_info_t mbedtls_md2_info = {
+    MBEDTLS_MD_MD2,
+    "MD2",
+    16,
+    16,
+    md2_starts_wrap,
+    md2_update_wrap,
+    md2_finish_wrap,
+    mbedtls_md2,
+    md2_ctx_alloc,
+    md2_ctx_free,
+    md2_clone_wrap,
+    md2_process_wrap,
+};
+
+#endif /* MBEDTLS_MD2_C */
+
+#if defined(MBEDTLS_MD4_C)
+
+static void md4_starts_wrap( void *ctx )
+{
+    mbedtls_md4_starts( (mbedtls_md4_context *) ctx );
+}
+
+static void md4_update_wrap( void *ctx, const unsigned char *input,
+                             size_t ilen )
+{
+    mbedtls_md4_update( (mbedtls_md4_context *) ctx, input, ilen );
+}
+
+static void md4_finish_wrap( void *ctx, unsigned char *output )
+{
+    mbedtls_md4_finish( (mbedtls_md4_context *) ctx, output );
+}
+
+static void *md4_ctx_alloc( void )
+{
+    void *ctx = mbedtls_calloc( 1, sizeof( mbedtls_md4_context ) );
+
+    if( ctx != NULL )
+        mbedtls_md4_init( (mbedtls_md4_context *) ctx );
+
+    return( ctx );
+}
+
+static void md4_ctx_free( void *ctx )
+{
+    mbedtls_md4_free( (mbedtls_md4_context *) ctx );
+    mbedtls_free( ctx );
+}
+
+static void md4_clone_wrap( void *dst, const void *src )
+{
+    mbedtls_md4_clone( (mbedtls_md4_context *) dst,
+                 (const mbedtls_md4_context *) src );
+}
+
+static void md4_process_wrap( void *ctx, const unsigned char *data )
+{
+    mbedtls_md4_process( (mbedtls_md4_context *) ctx, data );
+}
+
+const mbedtls_md_info_t mbedtls_md4_info = {
+    MBEDTLS_MD_MD4,
+    "MD4",
+    16,
+    64,
+    md4_starts_wrap,
+    md4_update_wrap,
+    md4_finish_wrap,
+    mbedtls_md4,
+    md4_ctx_alloc,
+    md4_ctx_free,
+    md4_clone_wrap,
+    md4_process_wrap,
+};
+
+#endif /* MBEDTLS_MD4_C */
+
+#if defined(MBEDTLS_MD5_C)
+
+static void md5_starts_wrap( void *ctx )
+{
+    mbedtls_md5_starts( (mbedtls_md5_context *) ctx );
+}
+
+static void md5_update_wrap( void *ctx, const unsigned char *input,
+                             size_t ilen )
+{
+    mbedtls_md5_update( (mbedtls_md5_context *) ctx, input, ilen );
+}
+
+static void md5_finish_wrap( void *ctx, unsigned char *output )
+{
+    mbedtls_md5_finish( (mbedtls_md5_context *) ctx, output );
+}
+
+static void *md5_ctx_alloc( void )
+{
+    void *ctx = mbedtls_calloc( 1, sizeof( mbedtls_md5_context ) );
+
+    if( ctx != NULL )
+        mbedtls_md5_init( (mbedtls_md5_context *) ctx );
+
+    return( ctx );
+}
+
+static void md5_ctx_free( void *ctx )
+{
+    mbedtls_md5_free( (mbedtls_md5_context *) ctx );
+    mbedtls_free( ctx );
+}
+
+static void md5_clone_wrap( void *dst, const void *src )
+{
+    mbedtls_md5_clone( (mbedtls_md5_context *) dst,
+                 (const mbedtls_md5_context *) src );
+}
+
+static void md5_process_wrap( void *ctx, const unsigned char *data )
+{
+    mbedtls_md5_process( (mbedtls_md5_context *) ctx, data );
+}
+
+const mbedtls_md_info_t mbedtls_md5_info = {
+    MBEDTLS_MD_MD5,
+    "MD5",
+    16,
+    64,
+    md5_starts_wrap,
+    md5_update_wrap,
+    md5_finish_wrap,
+    mbedtls_md5,
+    md5_ctx_alloc,
+    md5_ctx_free,
+    md5_clone_wrap,
+    md5_process_wrap,
+};
+
+#endif /* MBEDTLS_MD5_C */
+
+#if defined(MBEDTLS_RIPEMD160_C)
+
+static void ripemd160_starts_wrap( void *ctx )
+{
+    mbedtls_ripemd160_starts( (mbedtls_ripemd160_context *) ctx );
+}
+
+static void ripemd160_update_wrap( void *ctx, const unsigned char *input,
+                                   size_t ilen )
+{
+    mbedtls_ripemd160_update( (mbedtls_ripemd160_context *) ctx, input, ilen );
+}
+
+static void ripemd160_finish_wrap( void *ctx, unsigned char *output )
+{
+    mbedtls_ripemd160_finish( (mbedtls_ripemd160_context *) ctx, output );
+}
+
+static void *ripemd160_ctx_alloc( void )
+{
+    void *ctx = mbedtls_calloc( 1, sizeof( mbedtls_ripemd160_context ) );
+
+    if( ctx != NULL )
+        mbedtls_ripemd160_init( (mbedtls_ripemd160_context *) ctx );
+
+    return( ctx );
+}
+
+static void ripemd160_ctx_free( void *ctx )
+{
+    mbedtls_ripemd160_free( (mbedtls_ripemd160_context *) ctx );
+    mbedtls_free( ctx );
+}
+
+static void ripemd160_clone_wrap( void *dst, const void *src )
+{
+    mbedtls_ripemd160_clone( (mbedtls_ripemd160_context *) dst,
+                       (const mbedtls_ripemd160_context *) src );
+}
+
+static void ripemd160_process_wrap( void *ctx, const unsigned char *data )
+{
+    mbedtls_ripemd160_process( (mbedtls_ripemd160_context *) ctx, data );
+}
+
+const mbedtls_md_info_t mbedtls_ripemd160_info = {
+    MBEDTLS_MD_RIPEMD160,
+    "RIPEMD160",
+    20,
+    64,
+    ripemd160_starts_wrap,
+    ripemd160_update_wrap,
+    ripemd160_finish_wrap,
+    mbedtls_ripemd160,
+    ripemd160_ctx_alloc,
+    ripemd160_ctx_free,
+    ripemd160_clone_wrap,
+    ripemd160_process_wrap,
+};
+
+#endif /* MBEDTLS_RIPEMD160_C */
+
+#if defined(MBEDTLS_SHA1_C)
+
+static void sha1_starts_wrap( void *ctx )
+{
+    mbedtls_sha1_starts( (mbedtls_sha1_context *) ctx );
+}
+
+static void sha1_update_wrap( void *ctx, const unsigned char *input,
+                              size_t ilen )
+{
+    mbedtls_sha1_update( (mbedtls_sha1_context *) ctx, input, ilen );
+}
+
+static void sha1_finish_wrap( void *ctx, unsigned char *output )
+{
+    mbedtls_sha1_finish( (mbedtls_sha1_context *) ctx, output );
+}
+
+static void *sha1_ctx_alloc( void )
+{
+    void *ctx = mbedtls_calloc( 1, sizeof( mbedtls_sha1_context ) );
+
+    if( ctx != NULL )
+        mbedtls_sha1_init( (mbedtls_sha1_context *) ctx );
+
+    return( ctx );
+}
+
+static void sha1_clone_wrap( void *dst, const void *src )
+{
+    mbedtls_sha1_clone( (mbedtls_sha1_context *) dst,
+                  (const mbedtls_sha1_context *) src );
+}
+
+static void sha1_ctx_free( void *ctx )
+{
+    mbedtls_sha1_free( (mbedtls_sha1_context *) ctx );
+    mbedtls_free( ctx );
+}
+
+static void sha1_process_wrap( void *ctx, const unsigned char *data )
+{
+    mbedtls_sha1_process( (mbedtls_sha1_context *) ctx, data );
+}
+
+const mbedtls_md_info_t mbedtls_sha1_info = {
+    MBEDTLS_MD_SHA1,
+    "SHA1",
+    20,
+    64,
+    sha1_starts_wrap,
+    sha1_update_wrap,
+    sha1_finish_wrap,
+    mbedtls_sha1,
+    sha1_ctx_alloc,
+    sha1_ctx_free,
+    sha1_clone_wrap,
+    sha1_process_wrap,
+};
+
+#endif /* MBEDTLS_SHA1_C */
+
+/*
+ * Wrappers for generic message digests
+ */
+#if defined(MBEDTLS_SHA256_C)
+
+static void sha224_starts_wrap( void *ctx )
+{
+    mbedtls_sha256_starts( (mbedtls_sha256_context *) ctx, 1 );
+}
+
+static void sha224_update_wrap( void *ctx, const unsigned char *input,
+                                size_t ilen )
+{
+    mbedtls_sha256_update( (mbedtls_sha256_context *) ctx, input, ilen );
+}
+
+static void sha224_finish_wrap( void *ctx, unsigned char *output )
+{
+    mbedtls_sha256_finish( (mbedtls_sha256_context *) ctx, output );
+}
+
+static void sha224_wrap( const unsigned char *input, size_t ilen,
+                    unsigned char *output )
+{
+    mbedtls_sha256( input, ilen, output, 1 );
+}
+
+static void *sha224_ctx_alloc( void )
+{
+    void *ctx = mbedtls_calloc( 1, sizeof( mbedtls_sha256_context ) );
+
+    if( ctx != NULL )
+        mbedtls_sha256_init( (mbedtls_sha256_context *) ctx );
+
+    return( ctx );
+}
+
+static void sha224_ctx_free( void *ctx )
+{
+    mbedtls_sha256_free( (mbedtls_sha256_context *) ctx );
+    mbedtls_free( ctx );
+}
+
+static void sha224_clone_wrap( void *dst, const void *src )
+{
+    mbedtls_sha256_clone( (mbedtls_sha256_context *) dst,
+                    (const mbedtls_sha256_context *) src );
+}
+
+static void sha224_process_wrap( void *ctx, const unsigned char *data )
+{
+    mbedtls_sha256_process( (mbedtls_sha256_context *) ctx, data );
+}
+
+const mbedtls_md_info_t mbedtls_sha224_info = {
+    MBEDTLS_MD_SHA224,
+    "SHA224",
+    28,
+    64,
+    sha224_starts_wrap,
+    sha224_update_wrap,
+    sha224_finish_wrap,
+    sha224_wrap,
+    sha224_ctx_alloc,
+    sha224_ctx_free,
+    sha224_clone_wrap,
+    sha224_process_wrap,
+};
+
+static void sha256_starts_wrap( void *ctx )
+{
+    mbedtls_sha256_starts( (mbedtls_sha256_context *) ctx, 0 );
+}
+
+static void sha256_wrap( const unsigned char *input, size_t ilen,
+                    unsigned char *output )
+{
+    mbedtls_sha256( input, ilen, output, 0 );
+}
+
+const mbedtls_md_info_t mbedtls_sha256_info = {
+    MBEDTLS_MD_SHA256,
+    "SHA256",
+    32,
+    64,
+    sha256_starts_wrap,
+    sha224_update_wrap,
+    sha224_finish_wrap,
+    sha256_wrap,
+    sha224_ctx_alloc,
+    sha224_ctx_free,
+    sha224_clone_wrap,
+    sha224_process_wrap,
+};
+
+#endif /* MBEDTLS_SHA256_C */
+
+#if defined(MBEDTLS_SHA512_C)
+
+static void sha384_starts_wrap( void *ctx )
+{
+    mbedtls_sha512_starts( (mbedtls_sha512_context *) ctx, 1 );
+}
+
+static void sha384_update_wrap( void *ctx, const unsigned char *input,
+                                size_t ilen )
+{
+    mbedtls_sha512_update( (mbedtls_sha512_context *) ctx, input, ilen );
+}
+
+static void sha384_finish_wrap( void *ctx, unsigned char *output )
+{
+    mbedtls_sha512_finish( (mbedtls_sha512_context *) ctx, output );
+}
+
+static void sha384_wrap( const unsigned char *input, size_t ilen,
+                    unsigned char *output )
+{
+    mbedtls_sha512( input, ilen, output, 1 );
+}
+
+static void *sha384_ctx_alloc( void )
+{
+    void *ctx = mbedtls_calloc( 1, sizeof( mbedtls_sha512_context ) );
+
+    if( ctx != NULL )
+        mbedtls_sha512_init( (mbedtls_sha512_context *) ctx );
+
+    return( ctx );
+}
+
+static void sha384_ctx_free( void *ctx )
+{
+    mbedtls_sha512_free( (mbedtls_sha512_context *) ctx );
+    mbedtls_free( ctx );
+}
+
+static void sha384_clone_wrap( void *dst, const void *src )
+{
+    mbedtls_sha512_clone( (mbedtls_sha512_context *) dst,
+                    (const mbedtls_sha512_context *) src );
+}
+
+static void sha384_process_wrap( void *ctx, const unsigned char *data )
+{
+    mbedtls_sha512_process( (mbedtls_sha512_context *) ctx, data );
+}
+
+const mbedtls_md_info_t mbedtls_sha384_info = {
+    MBEDTLS_MD_SHA384,
+    "SHA384",
+    48,
+    128,
+    sha384_starts_wrap,
+    sha384_update_wrap,
+    sha384_finish_wrap,
+    sha384_wrap,
+    sha384_ctx_alloc,
+    sha384_ctx_free,
+    sha384_clone_wrap,
+    sha384_process_wrap,
+};
+
+static void sha512_starts_wrap( void *ctx )
+{
+    mbedtls_sha512_starts( (mbedtls_sha512_context *) ctx, 0 );
+}
+
+static void sha512_wrap( const unsigned char *input, size_t ilen,
+                    unsigned char *output )
+{
+    mbedtls_sha512( input, ilen, output, 0 );
+}
+
+const mbedtls_md_info_t mbedtls_sha512_info = {
+    MBEDTLS_MD_SHA512,
+    "SHA512",
+    64,
+    128,
+    sha512_starts_wrap,
+    sha384_update_wrap,
+    sha384_finish_wrap,
+    sha512_wrap,
+    sha384_ctx_alloc,
+    sha384_ctx_free,
+    sha384_clone_wrap,
+    sha384_process_wrap,
+};
+
+#endif /* MBEDTLS_SHA512_C */
+
+#endif /* MBEDTLS_MD_C */
diff --git a/backport/compat/verification/oid.c b/backport/compat/verification/oid.c
new file mode 100644
index 000000000000..647536902a09
--- /dev/null
+++ b/backport/compat/verification/oid.c
@@ -0,0 +1,709 @@
+/**
+ * \file oid.c
+ *
+ * \brief Object Identifier (OID) database
+ *
+ *  Copyright (C) 2006-2015, ARM Limited, All Rights Reserved
+ *  SPDX-License-Identifier: GPL-2.0
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ *  This file is part of mbed TLS (https://tls.mbed.org)
+ */
+
+#if !defined(MBEDTLS_CONFIG_FILE)
+#include "mbedtls/config.h"
+#else
+#include MBEDTLS_CONFIG_FILE
+#endif
+
+#if defined(MBEDTLS_OID_C)
+
+#include "mbedtls/oid.h"
+#include "mbedtls/rsa.h"
+
+#if defined(MBEDTLS_PLATFORM_C)
+#include "mbedtls/platform.h"
+#else
+#define mbedtls_snprintf snprintf
+#endif
+
+#if defined(MBEDTLS_X509_USE_C) || defined(MBEDTLS_X509_CREATE_C)
+#include "mbedtls/x509.h"
+#endif
+
+/*
+ * Macro to automatically add the size of #define'd OIDs
+ */
+#define ADD_LEN(s)      s, MBEDTLS_OID_SIZE(s)
+
+/*
+ * Macro to generate an internal function for oid_XXX_from_asn1() (used by
+ * the other functions)
+ */
+#define FN_OID_TYPED_FROM_ASN1( TYPE_T, NAME, LIST )                        \
+static const TYPE_T * oid_ ## NAME ## _from_asn1( const mbedtls_asn1_buf *oid )     \
+{                                                                           \
+    const TYPE_T *p = LIST;                                                 \
+    const mbedtls_oid_descriptor_t *cur = (const mbedtls_oid_descriptor_t *) p;             \
+    if( p == NULL || oid == NULL ) return( NULL );                          \
+    while( cur->asn1 != NULL ) {                                            \
+        if( cur->asn1_len == oid->len &&                                    \
+            memcmp( cur->asn1, oid->p, oid->len ) == 0 ) {                  \
+            return( p );                                                    \
+        }                                                                   \
+        p++;                                                                \
+        cur = (const mbedtls_oid_descriptor_t *) p;                                 \
+    }                                                                       \
+    return( NULL );                                                         \
+}
+
+/*
+ * Macro to generate a function for retrieving a single attribute from the
+ * descriptor of an mbedtls_oid_descriptor_t wrapper.
+ */
+#define FN_OID_GET_DESCRIPTOR_ATTR1(FN_NAME, TYPE_T, TYPE_NAME, ATTR1_TYPE, ATTR1) \
+int FN_NAME( const mbedtls_asn1_buf *oid, ATTR1_TYPE * ATTR1 )                  \
+{                                                                       \
+    const TYPE_T *data = oid_ ## TYPE_NAME ## _from_asn1( oid );        \
+    if( data == NULL ) return( MBEDTLS_ERR_OID_NOT_FOUND );            \
+    *ATTR1 = data->descriptor.ATTR1;                                    \
+    return( 0 );                                                        \
+}
+
+/*
+ * Macro to generate a function for retrieving a single attribute from an
+ * mbedtls_oid_descriptor_t wrapper.
+ */
+#define FN_OID_GET_ATTR1(FN_NAME, TYPE_T, TYPE_NAME, ATTR1_TYPE, ATTR1) \
+int FN_NAME( const mbedtls_asn1_buf *oid, ATTR1_TYPE * ATTR1 )                  \
+{                                                                       \
+    const TYPE_T *data = oid_ ## TYPE_NAME ## _from_asn1( oid );        \
+    if( data == NULL ) return( MBEDTLS_ERR_OID_NOT_FOUND );            \
+    *ATTR1 = data->ATTR1;                                               \
+    return( 0 );                                                        \
+}
+
+/*
+ * Macro to generate a function for retrieving two attributes from an
+ * mbedtls_oid_descriptor_t wrapper.
+ */
+#define FN_OID_GET_ATTR2(FN_NAME, TYPE_T, TYPE_NAME, ATTR1_TYPE, ATTR1,     \
+                         ATTR2_TYPE, ATTR2)                                 \
+int FN_NAME( const mbedtls_asn1_buf *oid, ATTR1_TYPE * ATTR1, ATTR2_TYPE * ATTR2 )  \
+{                                                                           \
+    const TYPE_T *data = oid_ ## TYPE_NAME ## _from_asn1( oid );            \
+    if( data == NULL ) return( MBEDTLS_ERR_OID_NOT_FOUND );                \
+    *ATTR1 = data->ATTR1;                                                   \
+    *ATTR2 = data->ATTR2;                                                   \
+    return( 0 );                                                            \
+}
+
+/*
+ * Macro to generate a function for retrieving the OID based on a single
+ * attribute from a mbedtls_oid_descriptor_t wrapper.
+ */
+#define FN_OID_GET_OID_BY_ATTR1(FN_NAME, TYPE_T, LIST, ATTR1_TYPE, ATTR1)   \
+int FN_NAME( ATTR1_TYPE ATTR1, const char **oid, size_t *olen )             \
+{                                                                           \
+    const TYPE_T *cur = LIST;                                               \
+    while( cur->descriptor.asn1 != NULL ) {                                 \
+        if( cur->ATTR1 == ATTR1 ) {                                         \
+            *oid = cur->descriptor.asn1;                                    \
+            *olen = cur->descriptor.asn1_len;                               \
+            return( 0 );                                                    \
+        }                                                                   \
+        cur++;                                                              \
+    }                                                                       \
+    return( MBEDTLS_ERR_OID_NOT_FOUND );                                   \
+}
+
+/*
+ * Macro to generate a function for retrieving the OID based on two
+ * attributes from a mbedtls_oid_descriptor_t wrapper.
+ */
+#define FN_OID_GET_OID_BY_ATTR2(FN_NAME, TYPE_T, LIST, ATTR1_TYPE, ATTR1,   \
+                                ATTR2_TYPE, ATTR2)                          \
+int FN_NAME( ATTR1_TYPE ATTR1, ATTR2_TYPE ATTR2, const char **oid ,         \
+             size_t *olen )                                                 \
+{                                                                           \
+    const TYPE_T *cur = LIST;                                               \
+    while( cur->descriptor.asn1 != NULL ) {                                 \
+        if( cur->ATTR1 == ATTR1 && cur->ATTR2 == ATTR2 ) {                  \
+            *oid = cur->descriptor.asn1;                                    \
+            *olen = cur->descriptor.asn1_len;                               \
+            return( 0 );                                                    \
+        }                                                                   \
+        cur++;                                                              \
+    }                                                                       \
+    return( MBEDTLS_ERR_OID_NOT_FOUND );                                   \
+}
+
+#if defined(MBEDTLS_X509_USE_C) || defined(MBEDTLS_X509_CREATE_C)
+/*
+ * For X520 attribute types
+ */
+typedef struct {
+    mbedtls_oid_descriptor_t    descriptor;
+    const char          *short_name;
+} oid_x520_attr_t;
+
+static const oid_x520_attr_t oid_x520_attr_type[] =
+{
+    {
+        { ADD_LEN( MBEDTLS_OID_AT_CN ),          "id-at-commonName",               "Common Name" },
+        "CN",
+    },
+    {
+        { ADD_LEN( MBEDTLS_OID_AT_COUNTRY ),     "id-at-countryName",              "Country" },
+        "C",
+    },
+    {
+        { ADD_LEN( MBEDTLS_OID_AT_LOCALITY ),    "id-at-locality",                 "Locality" },
+        "L",
+    },
+    {
+        { ADD_LEN( MBEDTLS_OID_AT_STATE ),       "id-at-state",                    "State" },
+        "ST",
+    },
+    {
+        { ADD_LEN( MBEDTLS_OID_AT_ORGANIZATION ),"id-at-organizationName",         "Organization" },
+        "O",
+    },
+    {
+        { ADD_LEN( MBEDTLS_OID_AT_ORG_UNIT ),    "id-at-organizationalUnitName",   "Org Unit" },
+        "OU",
+    },
+    {
+        { ADD_LEN( MBEDTLS_OID_PKCS9_EMAIL ),    "emailAddress",                   "E-mail address" },
+        "emailAddress",
+    },
+    {
+        { ADD_LEN( MBEDTLS_OID_AT_SERIAL_NUMBER ),"id-at-serialNumber",            "Serial number" },
+        "serialNumber",
+    },
+    {
+        { ADD_LEN( MBEDTLS_OID_AT_POSTAL_ADDRESS ),"id-at-postalAddress",          "Postal address" },
+        "postalAddress",
+    },
+    {
+        { ADD_LEN( MBEDTLS_OID_AT_POSTAL_CODE ), "id-at-postalCode",               "Postal code" },
+        "postalCode",
+    },
+    {
+        { ADD_LEN( MBEDTLS_OID_AT_SUR_NAME ),    "id-at-surName",                  "Surname" },
+        "SN",
+    },
+    {
+        { ADD_LEN( MBEDTLS_OID_AT_GIVEN_NAME ),  "id-at-givenName",                "Given name" },
+        "GN",
+    },
+    {
+        { ADD_LEN( MBEDTLS_OID_AT_INITIALS ),    "id-at-initials",                 "Initials" },
+        "initials",
+    },
+    {
+        { ADD_LEN( MBEDTLS_OID_AT_GENERATION_QUALIFIER ), "id-at-generationQualifier", "Generation qualifier" },
+        "generationQualifier",
+    },
+    {
+        { ADD_LEN( MBEDTLS_OID_AT_TITLE ),       "id-at-title",                    "Title" },
+        "title",
+    },
+    {
+        { ADD_LEN( MBEDTLS_OID_AT_DN_QUALIFIER ),"id-at-dnQualifier",              "Distinguished Name qualifier" },
+        "dnQualifier",
+    },
+    {
+        { ADD_LEN( MBEDTLS_OID_AT_PSEUDONYM ),   "id-at-pseudonym",                "Pseudonym" },
+        "pseudonym",
+    },
+    {
+        { ADD_LEN( MBEDTLS_OID_DOMAIN_COMPONENT ), "id-domainComponent",           "Domain component" },
+        "DC",
+    },
+    {
+        { ADD_LEN( MBEDTLS_OID_AT_UNIQUE_IDENTIFIER ), "id-at-uniqueIdentifier",    "Unique Identifier" },
+        "uniqueIdentifier",
+    },
+    {
+        { NULL, 0, NULL, NULL },
+        NULL,
+    }
+};
+
+FN_OID_TYPED_FROM_ASN1(oid_x520_attr_t, x520_attr, oid_x520_attr_type)
+FN_OID_GET_ATTR1(mbedtls_oid_get_attr_short_name, oid_x520_attr_t, x520_attr, const char *, short_name)
+
+/*
+ * For X509 extensions
+ */
+typedef struct {
+    mbedtls_oid_descriptor_t    descriptor;
+    int                 ext_type;
+} oid_x509_ext_t;
+
+static const oid_x509_ext_t oid_x509_ext[] =
+{
+    {
+        { ADD_LEN( MBEDTLS_OID_BASIC_CONSTRAINTS ),    "id-ce-basicConstraints",   "Basic Constraints" },
+        MBEDTLS_X509_EXT_BASIC_CONSTRAINTS,
+    },
+    {
+        { ADD_LEN( MBEDTLS_OID_KEY_USAGE ),            "id-ce-keyUsage",           "Key Usage" },
+        MBEDTLS_X509_EXT_KEY_USAGE,
+    },
+    {
+        { ADD_LEN( MBEDTLS_OID_EXTENDED_KEY_USAGE ),   "id-ce-extKeyUsage",        "Extended Key Usage" },
+        MBEDTLS_X509_EXT_EXTENDED_KEY_USAGE,
+    },
+    {
+        { ADD_LEN( MBEDTLS_OID_SUBJECT_ALT_NAME ),     "id-ce-subjectAltName",     "Subject Alt Name" },
+        MBEDTLS_X509_EXT_SUBJECT_ALT_NAME,
+    },
+    {
+        { ADD_LEN( MBEDTLS_OID_NS_CERT_TYPE ),         "id-netscape-certtype",     "Netscape Certificate Type" },
+        MBEDTLS_X509_EXT_NS_CERT_TYPE,
+    },
+    {
+        { NULL, 0, NULL, NULL },
+        0,
+    },
+};
+
+FN_OID_TYPED_FROM_ASN1(oid_x509_ext_t, x509_ext, oid_x509_ext)
+FN_OID_GET_ATTR1(mbedtls_oid_get_x509_ext_type, oid_x509_ext_t, x509_ext, int, ext_type)
+
+static const mbedtls_oid_descriptor_t oid_ext_key_usage[] =
+{
+    { ADD_LEN( MBEDTLS_OID_SERVER_AUTH ),      "id-kp-serverAuth",      "TLS Web Server Authentication" },
+    { ADD_LEN( MBEDTLS_OID_CLIENT_AUTH ),      "id-kp-clientAuth",      "TLS Web Client Authentication" },
+    { ADD_LEN( MBEDTLS_OID_CODE_SIGNING ),     "id-kp-codeSigning",     "Code Signing" },
+    { ADD_LEN( MBEDTLS_OID_EMAIL_PROTECTION ), "id-kp-emailProtection", "E-mail Protection" },
+    { ADD_LEN( MBEDTLS_OID_TIME_STAMPING ),    "id-kp-timeStamping",    "Time Stamping" },
+    { ADD_LEN( MBEDTLS_OID_OCSP_SIGNING ),     "id-kp-OCSPSigning",     "OCSP Signing" },
+    { NULL, 0, NULL, NULL },
+};
+
+FN_OID_TYPED_FROM_ASN1(mbedtls_oid_descriptor_t, ext_key_usage, oid_ext_key_usage)
+FN_OID_GET_ATTR1(mbedtls_oid_get_extended_key_usage, mbedtls_oid_descriptor_t, ext_key_usage, const char *, description)
+#endif /* MBEDTLS_X509_USE_C || MBEDTLS_X509_CREATE_C */
+
+#if defined(MBEDTLS_MD_C)
+/*
+ * For SignatureAlgorithmIdentifier
+ */
+typedef struct {
+    mbedtls_oid_descriptor_t    descriptor;
+    mbedtls_md_type_t           md_alg;
+    mbedtls_pk_type_t           pk_alg;
+} oid_sig_alg_t;
+
+static const oid_sig_alg_t oid_sig_alg[] =
+{
+#if defined(MBEDTLS_RSA_C)
+#if defined(MBEDTLS_MD2_C)
+    {
+        { ADD_LEN( MBEDTLS_OID_PKCS1_MD2 ),        "md2WithRSAEncryption",     "RSA with MD2" },
+        MBEDTLS_MD_MD2,      MBEDTLS_PK_RSA,
+    },
+#endif /* MBEDTLS_MD2_C */
+#if defined(MBEDTLS_MD4_C)
+    {
+        { ADD_LEN( MBEDTLS_OID_PKCS1_MD4 ),        "md4WithRSAEncryption",     "RSA with MD4" },
+        MBEDTLS_MD_MD4,      MBEDTLS_PK_RSA,
+    },
+#endif /* MBEDTLS_MD4_C */
+#if defined(MBEDTLS_MD5_C)
+    {
+        { ADD_LEN( MBEDTLS_OID_PKCS1_MD5 ),        "md5WithRSAEncryption",     "RSA with MD5" },
+        MBEDTLS_MD_MD5,      MBEDTLS_PK_RSA,
+    },
+#endif /* MBEDTLS_MD5_C */
+#if defined(MBEDTLS_SHA1_C)
+    {
+        { ADD_LEN( MBEDTLS_OID_PKCS1_SHA1 ),       "sha-1WithRSAEncryption",   "RSA with SHA1" },
+        MBEDTLS_MD_SHA1,     MBEDTLS_PK_RSA,
+    },
+#endif /* MBEDTLS_SHA1_C */
+#if defined(MBEDTLS_SHA256_C)
+    {
+        { ADD_LEN( MBEDTLS_OID_PKCS1_SHA224 ),     "sha224WithRSAEncryption",  "RSA with SHA-224" },
+        MBEDTLS_MD_SHA224,   MBEDTLS_PK_RSA,
+    },
+    {
+        { ADD_LEN( MBEDTLS_OID_PKCS1_SHA256 ),     "sha256WithRSAEncryption",  "RSA with SHA-256" },
+        MBEDTLS_MD_SHA256,   MBEDTLS_PK_RSA,
+    },
+#endif /* MBEDTLS_SHA256_C */
+#if defined(MBEDTLS_SHA512_C)
+    {
+        { ADD_LEN( MBEDTLS_OID_PKCS1_SHA384 ),     "sha384WithRSAEncryption",  "RSA with SHA-384" },
+        MBEDTLS_MD_SHA384,   MBEDTLS_PK_RSA,
+    },
+    {
+        { ADD_LEN( MBEDTLS_OID_PKCS1_SHA512 ),     "sha512WithRSAEncryption",  "RSA with SHA-512" },
+        MBEDTLS_MD_SHA512,   MBEDTLS_PK_RSA,
+    },
+#endif /* MBEDTLS_SHA512_C */
+#if defined(MBEDTLS_SHA1_C)
+    {
+        { ADD_LEN( MBEDTLS_OID_RSA_SHA_OBS ),      "sha-1WithRSAEncryption",   "RSA with SHA1" },
+        MBEDTLS_MD_SHA1,     MBEDTLS_PK_RSA,
+    },
+#endif /* MBEDTLS_SHA1_C */
+#endif /* MBEDTLS_RSA_C */
+#if defined(MBEDTLS_ECDSA_C)
+#if defined(MBEDTLS_SHA1_C)
+    {
+        { ADD_LEN( MBEDTLS_OID_ECDSA_SHA1 ),       "ecdsa-with-SHA1",      "ECDSA with SHA1" },
+        MBEDTLS_MD_SHA1,     MBEDTLS_PK_ECDSA,
+    },
+#endif /* MBEDTLS_SHA1_C */
+#if defined(MBEDTLS_SHA256_C)
+    {
+        { ADD_LEN( MBEDTLS_OID_ECDSA_SHA224 ),     "ecdsa-with-SHA224",    "ECDSA with SHA224" },
+        MBEDTLS_MD_SHA224,   MBEDTLS_PK_ECDSA,
+    },
+    {
+        { ADD_LEN( MBEDTLS_OID_ECDSA_SHA256 ),     "ecdsa-with-SHA256",    "ECDSA with SHA256" },
+        MBEDTLS_MD_SHA256,   MBEDTLS_PK_ECDSA,
+    },
+#endif /* MBEDTLS_SHA256_C */
+#if defined(MBEDTLS_SHA512_C)
+    {
+        { ADD_LEN( MBEDTLS_OID_ECDSA_SHA384 ),     "ecdsa-with-SHA384",    "ECDSA with SHA384" },
+        MBEDTLS_MD_SHA384,   MBEDTLS_PK_ECDSA,
+    },
+    {
+        { ADD_LEN( MBEDTLS_OID_ECDSA_SHA512 ),     "ecdsa-with-SHA512",    "ECDSA with SHA512" },
+        MBEDTLS_MD_SHA512,   MBEDTLS_PK_ECDSA,
+    },
+#endif /* MBEDTLS_SHA512_C */
+#endif /* MBEDTLS_ECDSA_C */
+#if defined(MBEDTLS_RSA_C)
+    {
+        { ADD_LEN( MBEDTLS_OID_RSASSA_PSS ),        "RSASSA-PSS",           "RSASSA-PSS" },
+        MBEDTLS_MD_NONE,     MBEDTLS_PK_RSASSA_PSS,
+    },
+#endif /* MBEDTLS_RSA_C */
+    {
+        { NULL, 0, NULL, NULL },
+        MBEDTLS_MD_NONE, MBEDTLS_PK_NONE,
+    },
+};
+
+FN_OID_TYPED_FROM_ASN1(oid_sig_alg_t, sig_alg, oid_sig_alg)
+FN_OID_GET_DESCRIPTOR_ATTR1(mbedtls_oid_get_sig_alg_desc, oid_sig_alg_t, sig_alg, const char *, description)
+FN_OID_GET_ATTR2(mbedtls_oid_get_sig_alg, oid_sig_alg_t, sig_alg, mbedtls_md_type_t, md_alg, mbedtls_pk_type_t, pk_alg)
+FN_OID_GET_OID_BY_ATTR2(mbedtls_oid_get_oid_by_sig_alg, oid_sig_alg_t, oid_sig_alg, mbedtls_pk_type_t, pk_alg, mbedtls_md_type_t, md_alg)
+#endif /* MBEDTLS_MD_C */
+
+/*
+ * For PublicKeyInfo (PKCS1, RFC 5480)
+ */
+typedef struct {
+    mbedtls_oid_descriptor_t    descriptor;
+    mbedtls_pk_type_t           pk_alg;
+} oid_pk_alg_t;
+
+static const oid_pk_alg_t oid_pk_alg[] =
+{
+    {
+        { ADD_LEN( MBEDTLS_OID_PKCS1_RSA ),      "rsaEncryption",   "RSA" },
+        MBEDTLS_PK_RSA,
+    },
+    {
+        { ADD_LEN( MBEDTLS_OID_EC_ALG_UNRESTRICTED ),  "id-ecPublicKey",   "Generic EC key" },
+        MBEDTLS_PK_ECKEY,
+    },
+    {
+        { ADD_LEN( MBEDTLS_OID_EC_ALG_ECDH ),          "id-ecDH",          "EC key for ECDH" },
+        MBEDTLS_PK_ECKEY_DH,
+    },
+    {
+        { NULL, 0, NULL, NULL },
+        MBEDTLS_PK_NONE,
+    },
+};
+
+FN_OID_TYPED_FROM_ASN1(oid_pk_alg_t, pk_alg, oid_pk_alg)
+FN_OID_GET_ATTR1(mbedtls_oid_get_pk_alg, oid_pk_alg_t, pk_alg, mbedtls_pk_type_t, pk_alg)
+FN_OID_GET_OID_BY_ATTR1(mbedtls_oid_get_oid_by_pk_alg, oid_pk_alg_t, oid_pk_alg, mbedtls_pk_type_t, pk_alg)
+
+#if defined(MBEDTLS_ECP_C)
+/*
+ * For namedCurve (RFC 5480)
+ */
+typedef struct {
+    mbedtls_oid_descriptor_t    descriptor;
+    mbedtls_ecp_group_id        grp_id;
+} oid_ecp_grp_t;
+
+static const oid_ecp_grp_t oid_ecp_grp[] =
+{
+#if defined(MBEDTLS_ECP_DP_SECP192R1_ENABLED)
+    {
+        { ADD_LEN( MBEDTLS_OID_EC_GRP_SECP192R1 ), "secp192r1",    "secp192r1" },
+        MBEDTLS_ECP_DP_SECP192R1,
+    },
+#endif /* MBEDTLS_ECP_DP_SECP192R1_ENABLED */
+#if defined(MBEDTLS_ECP_DP_SECP224R1_ENABLED)
+    {
+        { ADD_LEN( MBEDTLS_OID_EC_GRP_SECP224R1 ), "secp224r1",    "secp224r1" },
+        MBEDTLS_ECP_DP_SECP224R1,
+    },
+#endif /* MBEDTLS_ECP_DP_SECP224R1_ENABLED */
+#if defined(MBEDTLS_ECP_DP_SECP256R1_ENABLED)
+    {
+        { ADD_LEN( MBEDTLS_OID_EC_GRP_SECP256R1 ), "secp256r1",    "secp256r1" },
+        MBEDTLS_ECP_DP_SECP256R1,
+    },
+#endif /* MBEDTLS_ECP_DP_SECP256R1_ENABLED */
+#if defined(MBEDTLS_ECP_DP_SECP384R1_ENABLED)
+    {
+        { ADD_LEN( MBEDTLS_OID_EC_GRP_SECP384R1 ), "secp384r1",    "secp384r1" },
+        MBEDTLS_ECP_DP_SECP384R1,
+    },
+#endif /* MBEDTLS_ECP_DP_SECP384R1_ENABLED */
+#if defined(MBEDTLS_ECP_DP_SECP521R1_ENABLED)
+    {
+        { ADD_LEN( MBEDTLS_OID_EC_GRP_SECP521R1 ), "secp521r1",    "secp521r1" },
+        MBEDTLS_ECP_DP_SECP521R1,
+    },
+#endif /* MBEDTLS_ECP_DP_SECP521R1_ENABLED */
+#if defined(MBEDTLS_ECP_DP_SECP192K1_ENABLED)
+    {
+        { ADD_LEN( MBEDTLS_OID_EC_GRP_SECP192K1 ), "secp192k1",    "secp192k1" },
+        MBEDTLS_ECP_DP_SECP192K1,
+    },
+#endif /* MBEDTLS_ECP_DP_SECP192K1_ENABLED */
+#if defined(MBEDTLS_ECP_DP_SECP224K1_ENABLED)
+    {
+        { ADD_LEN( MBEDTLS_OID_EC_GRP_SECP224K1 ), "secp224k1",    "secp224k1" },
+        MBEDTLS_ECP_DP_SECP224K1,
+    },
+#endif /* MBEDTLS_ECP_DP_SECP224K1_ENABLED */
+#if defined(MBEDTLS_ECP_DP_SECP256K1_ENABLED)
+    {
+        { ADD_LEN( MBEDTLS_OID_EC_GRP_SECP256K1 ), "secp256k1",    "secp256k1" },
+        MBEDTLS_ECP_DP_SECP256K1,
+    },
+#endif /* MBEDTLS_ECP_DP_SECP256K1_ENABLED */
+#if defined(MBEDTLS_ECP_DP_BP256R1_ENABLED)
+    {
+        { ADD_LEN( MBEDTLS_OID_EC_GRP_BP256R1 ),   "brainpoolP256r1","brainpool256r1" },
+        MBEDTLS_ECP_DP_BP256R1,
+    },
+#endif /* MBEDTLS_ECP_DP_BP256R1_ENABLED */
+#if defined(MBEDTLS_ECP_DP_BP384R1_ENABLED)
+    {
+        { ADD_LEN( MBEDTLS_OID_EC_GRP_BP384R1 ),   "brainpoolP384r1","brainpool384r1" },
+        MBEDTLS_ECP_DP_BP384R1,
+    },
+#endif /* MBEDTLS_ECP_DP_BP384R1_ENABLED */
+#if defined(MBEDTLS_ECP_DP_BP512R1_ENABLED)
+    {
+        { ADD_LEN( MBEDTLS_OID_EC_GRP_BP512R1 ),   "brainpoolP512r1","brainpool512r1" },
+        MBEDTLS_ECP_DP_BP512R1,
+    },
+#endif /* MBEDTLS_ECP_DP_BP512R1_ENABLED */
+    {
+        { NULL, 0, NULL, NULL },
+        MBEDTLS_ECP_DP_NONE,
+    },
+};
+
+FN_OID_TYPED_FROM_ASN1(oid_ecp_grp_t, grp_id, oid_ecp_grp)
+FN_OID_GET_ATTR1(mbedtls_oid_get_ec_grp, oid_ecp_grp_t, grp_id, mbedtls_ecp_group_id, grp_id)
+FN_OID_GET_OID_BY_ATTR1(mbedtls_oid_get_oid_by_ec_grp, oid_ecp_grp_t, oid_ecp_grp, mbedtls_ecp_group_id, grp_id)
+#endif /* MBEDTLS_ECP_C */
+
+#if defined(MBEDTLS_CIPHER_C)
+/*
+ * For PKCS#5 PBES2 encryption algorithm
+ */
+typedef struct {
+    mbedtls_oid_descriptor_t    descriptor;
+    mbedtls_cipher_type_t       cipher_alg;
+} oid_cipher_alg_t;
+
+static const oid_cipher_alg_t oid_cipher_alg[] =
+{
+    {
+        { ADD_LEN( MBEDTLS_OID_DES_CBC ),              "desCBC",       "DES-CBC" },
+        MBEDTLS_CIPHER_DES_CBC,
+    },
+    {
+        { ADD_LEN( MBEDTLS_OID_DES_EDE3_CBC ),         "des-ede3-cbc", "DES-EDE3-CBC" },
+        MBEDTLS_CIPHER_DES_EDE3_CBC,
+    },
+    {
+        { NULL, 0, NULL, NULL },
+        MBEDTLS_CIPHER_NONE,
+    },
+};
+
+FN_OID_TYPED_FROM_ASN1(oid_cipher_alg_t, cipher_alg, oid_cipher_alg)
+FN_OID_GET_ATTR1(mbedtls_oid_get_cipher_alg, oid_cipher_alg_t, cipher_alg, mbedtls_cipher_type_t, cipher_alg)
+#endif /* MBEDTLS_CIPHER_C */
+
+#if defined(MBEDTLS_MD_C)
+/*
+ * For digestAlgorithm
+ */
+typedef struct {
+    mbedtls_oid_descriptor_t    descriptor;
+    mbedtls_md_type_t           md_alg;
+} oid_md_alg_t;
+
+static const oid_md_alg_t oid_md_alg[] =
+{
+#if defined(MBEDTLS_MD2_C)
+    {
+        { ADD_LEN( MBEDTLS_OID_DIGEST_ALG_MD2 ),       "id-md2",       "MD2" },
+        MBEDTLS_MD_MD2,
+    },
+#endif /* MBEDTLS_MD2_C */
+#if defined(MBEDTLS_MD4_C)
+    {
+        { ADD_LEN( MBEDTLS_OID_DIGEST_ALG_MD4 ),       "id-md4",       "MD4" },
+        MBEDTLS_MD_MD4,
+    },
+#endif /* MBEDTLS_MD4_C */
+#if defined(MBEDTLS_MD5_C)
+    {
+        { ADD_LEN( MBEDTLS_OID_DIGEST_ALG_MD5 ),       "id-md5",       "MD5" },
+        MBEDTLS_MD_MD5,
+    },
+#endif /* MBEDTLS_MD5_C */
+#if defined(MBEDTLS_SHA1_C)
+    {
+        { ADD_LEN( MBEDTLS_OID_DIGEST_ALG_SHA1 ),      "id-sha1",      "SHA-1" },
+        MBEDTLS_MD_SHA1,
+    },
+#endif /* MBEDTLS_SHA1_C */
+#if defined(MBEDTLS_SHA256_C)
+    {
+        { ADD_LEN( MBEDTLS_OID_DIGEST_ALG_SHA224 ),    "id-sha224",    "SHA-224" },
+        MBEDTLS_MD_SHA224,
+    },
+    {
+        { ADD_LEN( MBEDTLS_OID_DIGEST_ALG_SHA256 ),    "id-sha256",    "SHA-256" },
+        MBEDTLS_MD_SHA256,
+    },
+#endif /* MBEDTLS_SHA256_C */
+#if defined(MBEDTLS_SHA512_C)
+    {
+        { ADD_LEN( MBEDTLS_OID_DIGEST_ALG_SHA384 ),    "id-sha384",    "SHA-384" },
+        MBEDTLS_MD_SHA384,
+    },
+    {
+        { ADD_LEN( MBEDTLS_OID_DIGEST_ALG_SHA512 ),    "id-sha512",    "SHA-512" },
+        MBEDTLS_MD_SHA512,
+    },
+#endif /* MBEDTLS_SHA512_C */
+    {
+        { NULL, 0, NULL, NULL },
+        MBEDTLS_MD_NONE,
+    },
+};
+
+FN_OID_TYPED_FROM_ASN1(oid_md_alg_t, md_alg, oid_md_alg)
+FN_OID_GET_ATTR1(mbedtls_oid_get_md_alg, oid_md_alg_t, md_alg, mbedtls_md_type_t, md_alg)
+FN_OID_GET_OID_BY_ATTR1(mbedtls_oid_get_oid_by_md, oid_md_alg_t, oid_md_alg, mbedtls_md_type_t, md_alg)
+#endif /* MBEDTLS_MD_C */
+
+#if defined(MBEDTLS_PKCS12_C)
+/*
+ * For PKCS#12 PBEs
+ */
+typedef struct {
+    mbedtls_oid_descriptor_t    descriptor;
+    mbedtls_md_type_t           md_alg;
+    mbedtls_cipher_type_t       cipher_alg;
+} oid_pkcs12_pbe_alg_t;
+
+static const oid_pkcs12_pbe_alg_t oid_pkcs12_pbe_alg[] =
+{
+    {
+        { ADD_LEN( MBEDTLS_OID_PKCS12_PBE_SHA1_DES3_EDE_CBC ), "pbeWithSHAAnd3-KeyTripleDES-CBC", "PBE with SHA1 and 3-Key 3DES" },
+        MBEDTLS_MD_SHA1,      MBEDTLS_CIPHER_DES_EDE3_CBC,
+    },
+    {
+        { ADD_LEN( MBEDTLS_OID_PKCS12_PBE_SHA1_DES2_EDE_CBC ), "pbeWithSHAAnd2-KeyTripleDES-CBC", "PBE with SHA1 and 2-Key 3DES" },
+        MBEDTLS_MD_SHA1,      MBEDTLS_CIPHER_DES_EDE_CBC,
+    },
+    {
+        { NULL, 0, NULL, NULL },
+        MBEDTLS_MD_NONE, MBEDTLS_CIPHER_NONE,
+    },
+};
+
+FN_OID_TYPED_FROM_ASN1(oid_pkcs12_pbe_alg_t, pkcs12_pbe_alg, oid_pkcs12_pbe_alg)
+FN_OID_GET_ATTR2(mbedtls_oid_get_pkcs12_pbe_alg, oid_pkcs12_pbe_alg_t, pkcs12_pbe_alg, mbedtls_md_type_t, md_alg, mbedtls_cipher_type_t, cipher_alg)
+#endif /* MBEDTLS_PKCS12_C */
+
+#define OID_SAFE_SNPRINTF                               \
+    do {                                                \
+        if( ret < 0 || (size_t) ret >= n )              \
+            return( MBEDTLS_ERR_OID_BUF_TOO_SMALL );    \
+                                                        \
+        n -= (size_t) ret;                              \
+        p += (size_t) ret;                              \
+    } while( 0 )
+
+/* Return the x.y.z.... style numeric string for the given OID */
+int mbedtls_oid_get_numeric_string( char *buf, size_t size,
+                            const mbedtls_asn1_buf *oid )
+{
+    int ret;
+    size_t i, n;
+    unsigned int value;
+    char *p;
+
+    p = buf;
+    n = size;
+
+    /* First byte contains first two dots */
+    if( oid->len > 0 )
+    {
+        ret = mbedtls_snprintf( p, n, "%d.%d", oid->p[0] / 40, oid->p[0] % 40 );
+        OID_SAFE_SNPRINTF;
+    }
+
+    value = 0;
+    for( i = 1; i < oid->len; i++ )
+    {
+        /* Prevent overflow in value. */
+        if( ( ( value << 7 ) >> 7 ) != value )
+            return( MBEDTLS_ERR_OID_BUF_TOO_SMALL );
+
+        value <<= 7;
+        value += oid->p[i] & 0x7F;
+
+        if( !( oid->p[i] & 0x80 ) )
+        {
+            /* Last byte */
+            ret = mbedtls_snprintf( p, n, ".%d", value );
+            OID_SAFE_SNPRINTF;
+            value = 0;
+        }
+    }
+
+    return( (int) ( size - n ) );
+}
+
+#endif /* MBEDTLS_OID_C */
diff --git a/backport/compat/verification/pkcs7-asn1.c b/backport/compat/verification/pkcs7-asn1.c
new file mode 100644
index 000000000000..9073fd94fa92
--- /dev/null
+++ b/backport/compat/verification/pkcs7-asn1.c
@@ -0,0 +1,355 @@
+/*
+ * Automatically generated by asn1_compiler.  Do not edit
+ *
+ * ASN.1 parser for pkcs7
+ */
+#include <linux/asn1_ber_bytecode.h>
+#include "pkcs7-asn1.h"
+
+enum pkcs7_actions {
+	ACT_pkcs7_check_content_type = 0,
+	ACT_pkcs7_extract_cert = 1,
+	ACT_pkcs7_note_OID = 2,
+	ACT_pkcs7_note_certificate_list = 3,
+	ACT_pkcs7_note_content = 4,
+	ACT_pkcs7_note_data = 5,
+	ACT_pkcs7_note_signed_info = 6,
+	ACT_pkcs7_note_signeddata_version = 7,
+	ACT_pkcs7_note_signerinfo_version = 8,
+	ACT_pkcs7_sig_note_authenticated_attr = 9,
+	ACT_pkcs7_sig_note_digest_algo = 10,
+	ACT_pkcs7_sig_note_issuer = 11,
+	ACT_pkcs7_sig_note_pkey_algo = 12,
+	ACT_pkcs7_sig_note_serial = 13,
+	ACT_pkcs7_sig_note_set_of_authattrs = 14,
+	ACT_pkcs7_sig_note_signature = 15,
+	ACT_pkcs7_sig_note_skid = 16,
+	NR__pkcs7_actions = 17
+};
+
+static const asn1_action_t pkcs7_action_table[NR__pkcs7_actions] = {
+	[   0] = pkcs7_check_content_type,
+	[   1] = pkcs7_extract_cert,
+	[   2] = pkcs7_note_OID,
+	[   3] = pkcs7_note_certificate_list,
+	[   4] = pkcs7_note_content,
+	[   5] = pkcs7_note_data,
+	[   6] = pkcs7_note_signed_info,
+	[   7] = pkcs7_note_signeddata_version,
+	[   8] = pkcs7_note_signerinfo_version,
+	[   9] = pkcs7_sig_note_authenticated_attr,
+	[  10] = pkcs7_sig_note_digest_algo,
+	[  11] = pkcs7_sig_note_issuer,
+	[  12] = pkcs7_sig_note_pkey_algo,
+	[  13] = pkcs7_sig_note_serial,
+	[  14] = pkcs7_sig_note_set_of_authattrs,
+	[  15] = pkcs7_sig_note_signature,
+	[  16] = pkcs7_sig_note_skid,
+};
+
+static const unsigned char pkcs7_machine[] = {
+	// PKCS7ContentInfo
+	[   0] = ASN1_OP_MATCH,
+	[   1] = _tag(UNIV, CONS, SEQ),
+	// ContentType
+	[   2] =  ASN1_OP_MATCH_ACT,
+	[   3] =  _tag(UNIV, PRIM, OID),
+	[   4] =  _action(ACT_pkcs7_note_OID),
+	[   5] =  ASN1_OP_ACT,
+	[   6] =  _action(ACT_pkcs7_check_content_type),
+	[   7] =  ASN1_OP_MATCH_JUMP_OR_SKIP,		// content
+	[   8] =  _tagn(CONT, CONS,  0),
+	[   9] =  _jump_target(12),
+	[  10] = ASN1_OP_END_SEQ,
+	[  11] = ASN1_OP_COMPLETE,
+
+	// SignedData
+	[  12] =  ASN1_OP_MATCH,
+	[  13] =  _tag(UNIV, CONS, SEQ),
+	[  14] =   ASN1_OP_MATCH_ACT,		// version
+	[  15] =   _tag(UNIV, PRIM, INT),
+	[  16] =   _action(ACT_pkcs7_note_signeddata_version),
+	// DigestAlgorithmIdentifiers
+	[  17] =   ASN1_OP_MATCH_JUMP_OR_SKIP,		// daSet
+	[  18] =   _tag(UNIV, CONS, SET),
+	[  19] =   _jump_target(61),
+	[  20] =   ASN1_OP_COND_MATCH_JUMP_OR_SKIP,		// daSequence
+	[  21] =   _tag(UNIV, CONS, SEQ),
+	[  22] =   _jump_target(67),
+	[  23] =   ASN1_OP_COND_FAIL,
+	// ContentInfo
+	[  24] =   ASN1_OP_MATCH,
+	[  25] =   _tag(UNIV, CONS, SEQ),
+	// ContentType
+	[  26] =    ASN1_OP_MATCH_ACT,
+	[  27] =    _tag(UNIV, PRIM, OID),
+	[  28] =    _action(ACT_pkcs7_note_OID),
+	[  29] =    ASN1_OP_ACT,
+	[  30] =    _action(ACT_pkcs7_note_OID),
+	[  31] =    ASN1_OP_MATCH_JUMP_OR_SKIP,		// content
+	[  32] =    _tagn(CONT, CONS,  0),
+	[  33] =    _jump_target(73),
+	[  34] =   ASN1_OP_END_SEQ,
+	[  35] =   ASN1_OP_ACT,
+	[  36] =   _action(ACT_pkcs7_note_content),
+	// ExtendedCertificatesAndCertificates
+	[  37] =   ASN1_OP_MATCH_JUMP_OR_SKIP,		// certSet
+	[  38] =   _tagn(CONT, CONS,  0),
+	[  39] =   _jump_target(77),		// --> ExtendedCertificatesAndCertificates
+	// Certificates
+	[  40] =   ASN1_OP_COND_MATCH_JUMP_OR_SKIP,		// certSequence
+	[  41] =   _tagn(CONT, CONS,  2),
+	[  42] =   _jump_target(85),		// --> Certificates
+	[  43] =   ASN1_OP_ACT,
+	[  44] =   _action(ACT_pkcs7_note_certificate_list),
+	// CertificateRevocationLists
+	[  45] =   ASN1_OP_MATCH_JUMP_OR_SKIP,		// crlSet
+	[  46] =   _tagn(CONT, CONS,  1),
+	[  47] =   _jump_target(90),		// --> CertificateRevocationLists
+	// CRLSequence
+	[  48] =   ASN1_OP_COND_MATCH_JUMP_OR_SKIP,		// crlSequence
+	[  49] =   _tagn(CONT, CONS,  3),
+	[  50] =   _jump_target(96),		// --> CRLSequence
+	// SignerInfos
+	[  51] =   ASN1_OP_MATCH_JUMP_OR_SKIP,		// siSet
+	[  52] =   _tag(UNIV, CONS, SET),
+	[  53] =   _jump_target(102),
+	[  54] =   ASN1_OP_COND_MATCH_JUMP_OR_SKIP,		// siSequence
+	[  55] =   _tag(UNIV, CONS, SEQ),
+	[  56] =   _jump_target(108),
+	[  57] =   ASN1_OP_COND_FAIL,
+	[  58] =  ASN1_OP_END_SEQ,
+	[  59] = ASN1_OP_END_SEQ,
+	[  60] = ASN1_OP_RETURN,
+
+	// DigestAlgorithmIdentifier
+	[  61] =  ASN1_OP_MATCH_JUMP,
+	[  62] =  _tag(UNIV, CONS, SEQ),
+	[  63] =  _jump_target(114),		// --> DigestAlgorithmIdentifier
+	[  64] = ASN1_OP_END_SET_OF,
+	[  65] = _jump_target(61),
+	[  66] = ASN1_OP_RETURN,
+
+	// DigestAlgorithmIdentifier
+	[  67] =  ASN1_OP_MATCH_JUMP,
+	[  68] =  _tag(UNIV, CONS, SEQ),
+	[  69] =  _jump_target(114),		// --> DigestAlgorithmIdentifier
+	[  70] = ASN1_OP_END_SEQ_OF,
+	[  71] = _jump_target(67),
+	[  72] = ASN1_OP_RETURN,
+
+	// Data
+	[  73] =  ASN1_OP_MATCH_ANY_ACT,
+	[  74] =  _action(ACT_pkcs7_note_data),
+	[  75] = ASN1_OP_END_SEQ,
+	[  76] = ASN1_OP_RETURN,
+
+	// ExtendedCertificateOrCertificate
+	// Certificate
+	[  77] =  ASN1_OP_MATCH_ANY_ACT_OR_SKIP,
+	[  78] =  _action(ACT_pkcs7_extract_cert),
+	// ExtendedCertificate
+	// Certificate
+	[  79] =  ASN1_OP_COND_MATCH_ANY_ACT_OR_SKIP,
+	[  80] =  _action(ACT_pkcs7_extract_cert),
+	[  81] =  ASN1_OP_COND_FAIL,
+	[  82] = ASN1_OP_END_SET_OF,
+	[  83] = _jump_target(77),
+	[  84] = ASN1_OP_RETURN,
+
+	// Certificate
+	[  85] =  ASN1_OP_MATCH_ANY_ACT,
+	[  86] =  _action(ACT_pkcs7_extract_cert),
+	[  87] = ASN1_OP_END_SEQ_OF,
+	[  88] = _jump_target(85),
+	[  89] = ASN1_OP_RETURN,
+
+	// CertificateList
+	[  90] =  ASN1_OP_MATCH_JUMP,
+	[  91] =  _tag(UNIV, CONS, SEQ),
+	[  92] =  _jump_target(120),		// --> CertificateList
+	[  93] = ASN1_OP_END_SET_OF,
+	[  94] = _jump_target(90),
+	[  95] = ASN1_OP_RETURN,
+
+	// CertificateList
+	[  96] =  ASN1_OP_MATCH_JUMP,
+	[  97] =  _tag(UNIV, CONS, SEQ),
+	[  98] =  _jump_target(120),		// --> CertificateList
+	[  99] = ASN1_OP_END_SEQ_OF,
+	[ 100] = _jump_target(96),
+	[ 101] = ASN1_OP_RETURN,
+
+	// SignerInfo
+	[ 102] =  ASN1_OP_MATCH_JUMP,
+	[ 103] =  _tag(UNIV, CONS, SEQ),
+	[ 104] =  _jump_target(125),		// --> SignerInfo
+	[ 105] = ASN1_OP_END_SET_OF,
+	[ 106] = _jump_target(102),
+	[ 107] = ASN1_OP_RETURN,
+
+	// SignerInfo
+	[ 108] =  ASN1_OP_MATCH_JUMP,
+	[ 109] =  _tag(UNIV, CONS, SEQ),
+	[ 110] =  _jump_target(125),		// --> SignerInfo
+	[ 111] = ASN1_OP_END_SEQ_OF,
+	[ 112] = _jump_target(108),
+	[ 113] = ASN1_OP_RETURN,
+
+	[ 114] =  ASN1_OP_MATCH_ACT,		// algorithm
+	[ 115] =  _tag(UNIV, PRIM, OID),
+	[ 116] =  _action(ACT_pkcs7_note_OID),
+	[ 117] =  ASN1_OP_MATCH_ANY_OR_SKIP,		// parameters
+	[ 118] = ASN1_OP_END_SEQ,
+	[ 119] = ASN1_OP_RETURN,
+
+	// Certificate
+	[ 120] =  ASN1_OP_MATCH_ANY_ACT,
+	[ 121] =  _action(ACT_pkcs7_extract_cert),
+	[ 122] = ASN1_OP_END_SEQ_OF,
+	[ 123] = _jump_target(120),
+	[ 124] = ASN1_OP_RETURN,
+
+	[ 125] =  ASN1_OP_MATCH_ACT,		// version
+	[ 126] =  _tag(UNIV, PRIM, INT),
+	[ 127] =  _action(ACT_pkcs7_note_signerinfo_version),
+	// SignerIdentifier
+	// IssuerAndSerialNumber
+	[ 128] =  ASN1_OP_MATCH_JUMP_OR_SKIP,		// issuerAndSerialNumber
+	[ 129] =  _tag(UNIV, CONS, SEQ),
+	[ 130] =  _jump_target(169),		// --> IssuerAndSerialNumber
+	// SubjectKeyIdentifier
+	[ 131] =  ASN1_OP_COND_MATCH_ACT_OR_SKIP,		// subjectKeyIdentifier
+	[ 132] =  _tagn(CONT, PRIM,  0),
+	[ 133] =  _action(ACT_pkcs7_sig_note_skid),
+	[ 134] =  ASN1_OP_COND_FAIL,
+	// DigestAlgorithmIdentifier
+	[ 135] =  ASN1_OP_MATCH_JUMP,
+	[ 136] =  _tag(UNIV, CONS, SEQ),
+	[ 137] =  _jump_target(114),		// --> DigestAlgorithmIdentifier
+	[ 138] =  ASN1_OP_ACT,
+	[ 139] =  _action(ACT_pkcs7_sig_note_digest_algo),
+	// SetOfAuthenticatedAttribute
+	[ 140] =  ASN1_OP_MATCH_JUMP_OR_SKIP,		// aaSet
+	[ 141] =  _tagn(CONT, CONS,  0),
+	[ 142] =  _jump_target(192),		// --> SetOfAuthenticatedAttribute
+	[ 143] =  ASN1_OP_MAYBE_ACT,
+	[ 144] =  _action(ACT_pkcs7_sig_note_set_of_authattrs),
+	[ 145] =  ASN1_OP_COND_MATCH_JUMP_OR_SKIP,		// aaSequence
+	[ 146] =  _tagn(CONT, CONS,  2),
+	[ 147] =  _jump_target(198),
+	// DigestEncryptionAlgorithmIdentifier
+	[ 148] =  ASN1_OP_MATCH,
+	[ 149] =  _tag(UNIV, CONS, SEQ),
+	[ 150] =   ASN1_OP_MATCH_ACT,		// algorithm
+	[ 151] =   _tag(UNIV, PRIM, OID),
+	[ 152] =   _action(ACT_pkcs7_note_OID),
+	[ 153] =   ASN1_OP_MATCH_ANY_OR_SKIP,		// parameters
+	[ 154] =  ASN1_OP_END_SEQ,
+	[ 155] =  ASN1_OP_ACT,
+	[ 156] =  _action(ACT_pkcs7_sig_note_pkey_algo),
+	// EncryptedDigest
+	[ 157] =  ASN1_OP_MATCH_ACT,
+	[ 158] =  _tag(UNIV, PRIM, OTS),
+	[ 159] =  _action(ACT_pkcs7_sig_note_signature),
+	[ 160] =  ASN1_OP_MATCH_JUMP_OR_SKIP,		// uaSet
+	[ 161] =  _tagn(CONT, CONS,  1),
+	[ 162] =  _jump_target(207),
+	[ 163] =  ASN1_OP_COND_MATCH_JUMP_OR_SKIP,		// uaSequence
+	[ 164] =  _tagn(CONT, CONS,  3),
+	[ 165] =  _jump_target(213),
+	[ 166] = ASN1_OP_END_SEQ_ACT,
+	[ 167] = _action(ACT_pkcs7_note_signed_info),
+	[ 168] = ASN1_OP_RETURN,
+
+	// Name
+	[ 169] =  ASN1_OP_MATCH,
+	[ 170] =  _tag(UNIV, CONS, SEQ),
+	// RelativeDistinguishedName
+	[ 171] =   ASN1_OP_MATCH,
+	[ 172] =   _tag(UNIV, CONS, SET),
+	// AttributeValueAssertion
+	[ 173] =    ASN1_OP_MATCH,
+	[ 174] =    _tag(UNIV, CONS, SEQ),
+	[ 175] =     ASN1_OP_MATCH_ACT,		// attributeType
+	[ 176] =     _tag(UNIV, PRIM, OID),
+	[ 177] =     _action(ACT_pkcs7_note_OID),
+	[ 178] =     ASN1_OP_MATCH_ANY,		// attributeValue
+	[ 179] =    ASN1_OP_END_SEQ,
+	[ 180] =   ASN1_OP_END_SET_OF,
+	[ 181] =   _jump_target(173),
+	[ 182] =  ASN1_OP_END_SEQ_OF,
+	[ 183] =  _jump_target(171),
+	[ 184] =  ASN1_OP_ACT,
+	[ 185] =  _action(ACT_pkcs7_sig_note_issuer),
+	// CertificateSerialNumber
+	[ 186] =  ASN1_OP_MATCH,
+	[ 187] =  _tag(UNIV, PRIM, INT),
+	[ 188] =  ASN1_OP_ACT,
+	[ 189] =  _action(ACT_pkcs7_sig_note_serial),
+	[ 190] = ASN1_OP_END_SEQ,
+	[ 191] = ASN1_OP_RETURN,
+
+	// AuthenticatedAttribute
+	[ 192] =  ASN1_OP_MATCH_JUMP,
+	[ 193] =  _tag(UNIV, CONS, SEQ),
+	[ 194] =  _jump_target(219),		// --> AuthenticatedAttribute
+	[ 195] = ASN1_OP_END_SET_OF,
+	[ 196] = _jump_target(192),
+	[ 197] = ASN1_OP_RETURN,
+
+	[ 198] =  ASN1_OP_MATCH,		// aaSequence
+	[ 199] =  _tag(UNIV, CONS, SEQ),
+	// AuthenticatedAttribute
+	[ 200] =   ASN1_OP_MATCH_JUMP,
+	[ 201] =   _tag(UNIV, CONS, SEQ),
+	[ 202] =   _jump_target(219),		// --> AuthenticatedAttribute
+	[ 203] =  ASN1_OP_END_SEQ_OF,
+	[ 204] =  _jump_target(200),
+	[ 205] = ASN1_OP_END_SEQ,
+	[ 206] = ASN1_OP_RETURN,
+
+	// UnauthenticatedAttribute
+	[ 207] =  ASN1_OP_MATCH_JUMP,
+	[ 208] =  _tag(UNIV, CONS, SEQ),
+	[ 209] =  _jump_target(230),		// --> UnauthenticatedAttribute
+	[ 210] = ASN1_OP_END_SET_OF,
+	[ 211] = _jump_target(207),
+	[ 212] = ASN1_OP_RETURN,
+
+	// UnauthenticatedAttribute
+	[ 213] =  ASN1_OP_MATCH_JUMP,
+	[ 214] =  _tag(UNIV, CONS, SEQ),
+	[ 215] =  _jump_target(230),		// --> UnauthenticatedAttribute
+	[ 216] = ASN1_OP_END_SEQ_OF,
+	[ 217] = _jump_target(213),
+	[ 218] = ASN1_OP_RETURN,
+
+	[ 219] =  ASN1_OP_MATCH_ACT,		// type
+	[ 220] =  _tag(UNIV, PRIM, OID),
+	[ 221] =  _action(ACT_pkcs7_note_OID),
+	[ 222] =  ASN1_OP_MATCH,		// values
+	[ 223] =  _tag(UNIV, CONS, SET),
+	[ 224] =   ASN1_OP_MATCH_ANY_ACT,
+	[ 225] =   _action(ACT_pkcs7_sig_note_authenticated_attr),
+	[ 226] =  ASN1_OP_END_SET_OF,
+	[ 227] =  _jump_target(224),
+	[ 228] = ASN1_OP_END_SEQ,
+	[ 229] = ASN1_OP_RETURN,
+
+	[ 230] =  ASN1_OP_MATCH,		// type
+	[ 231] =  _tag(UNIV, PRIM, OID),
+	[ 232] =  ASN1_OP_MATCH,		// values
+	[ 233] =  _tag(UNIV, CONS, SET),
+	[ 234] =   ASN1_OP_MATCH_ANY,
+	[ 235] =  ASN1_OP_END_SET_OF,
+	[ 236] =  _jump_target(234),
+	[ 237] = ASN1_OP_END_SEQ,
+	[ 238] = ASN1_OP_RETURN,
+};
+
+const struct asn1_decoder pkcs7_decoder = {
+	.machine = pkcs7_machine,
+	.machlen = sizeof(pkcs7_machine),
+	.actions = pkcs7_action_table,
+};
diff --git a/backport/compat/verification/pkcs7-asn1.h b/backport/compat/verification/pkcs7-asn1.h
new file mode 100644
index 000000000000..b34e160f7263
--- /dev/null
+++ b/backport/compat/verification/pkcs7-asn1.h
@@ -0,0 +1,27 @@
+/*
+ * Automatically generated by asn1_compiler.  Do not edit
+ *
+ * ASN.1 parser for pkcs7
+ */
+#include <linux/asn1_decoder.h>
+
+extern const struct asn1_decoder pkcs7_decoder;
+
+extern int pkcs7_check_content_type(void *, size_t, unsigned char, const void *, size_t);
+extern int pkcs7_extract_cert(void *, size_t, unsigned char, const void *, size_t);
+extern int pkcs7_note_OID(void *, size_t, unsigned char, const void *, size_t);
+extern int pkcs7_note_certificate_list(void *, size_t, unsigned char, const void *, size_t);
+extern int pkcs7_note_content(void *, size_t, unsigned char, const void *, size_t);
+extern int pkcs7_note_data(void *, size_t, unsigned char, const void *, size_t);
+extern int pkcs7_note_signed_info(void *, size_t, unsigned char, const void *, size_t);
+extern int pkcs7_note_signeddata_version(void *, size_t, unsigned char, const void *, size_t);
+extern int pkcs7_note_signerinfo_version(void *, size_t, unsigned char, const void *, size_t);
+extern int pkcs7_sig_note_authenticated_attr(void *, size_t, unsigned char, const void *, size_t);
+extern int pkcs7_sig_note_digest_algo(void *, size_t, unsigned char, const void *, size_t);
+extern int pkcs7_sig_note_issuer(void *, size_t, unsigned char, const void *, size_t);
+extern int pkcs7_sig_note_pkey_algo(void *, size_t, unsigned char, const void *, size_t);
+extern int pkcs7_sig_note_serial(void *, size_t, unsigned char, const void *, size_t);
+extern int pkcs7_sig_note_set_of_authattrs(void *, size_t, unsigned char, const void *, size_t);
+extern int pkcs7_sig_note_signature(void *, size_t, unsigned char, const void *, size_t);
+extern int pkcs7_sig_note_skid(void *, size_t, unsigned char, const void *, size_t);
+
diff --git a/backport/compat/verification/public_key.c b/backport/compat/verification/public_key.c
new file mode 100644
index 000000000000..10d1672aa7ea
--- /dev/null
+++ b/backport/compat/verification/public_key.c
@@ -0,0 +1,131 @@
+/*
+ * Adapted from the kernel for simplicity in backports.
+ *
+ * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#define pr_fmt(fmt) "PKEY: "fmt
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/seq_file.h>
+#include <linux/scatterlist.h>
+#include <linux/asn1_decoder.h>
+#include <crypto/public_key.h>
+#include "rsapubkey-asn1.h"
+#include "mbedtls/rsa.h"
+#include "mbedtls/md.h"
+
+void public_key_free(struct public_key *key)
+{
+	if (key) {
+		kfree(key->key);
+		kfree(key);
+	}
+}
+
+int rsa_get_n(void *context, size_t hdrlen, unsigned char tag,
+	      const void *value, size_t vlen)
+{
+	mbedtls_rsa_context *rsa = context;
+
+	/* invalid key provided */
+	if (!value || !vlen)
+		return -EINVAL;
+
+	return mbedtls_mpi_read_binary(&rsa->N, value, vlen) ? -EINVAL : 0;
+}
+
+int rsa_get_e(void *context, size_t hdrlen, unsigned char tag,
+	      const void *value, size_t vlen)
+{
+	mbedtls_rsa_context *rsa = context;
+
+	/* invalid key provided */
+	if (!value || !vlen)
+		return -EINVAL;
+
+	return mbedtls_mpi_read_binary(&rsa->E, value, vlen) ? -EINVAL : 0;
+}
+
+int public_key_verify_signature(const struct public_key *pkey,
+				const struct public_key_signature *sig)
+{
+	mbedtls_rsa_context rsa;
+	mbedtls_md_type_t md_alg;
+	const u8 *sigdata = sig->s;
+	int s_size = sig->s_size;
+	int ret;
+
+	if (WARN_ON(!pkey))
+		return -EINVAL;
+
+	if (strcmp(sig->pkey_algo, "rsa"))
+		return -ENOTSUPP;
+
+	if (strcmp(sig->hash_algo, "sha1") == 0)
+		md_alg = MBEDTLS_MD_SHA1;
+	else if (strcmp(sig->hash_algo, "sha256") == 0)
+		md_alg = MBEDTLS_MD_SHA256;
+	else
+		return -ENOTSUPP;
+
+	mbedtls_rsa_init(&rsa, MBEDTLS_RSA_PKCS_V15, 0);
+
+	ret = asn1_ber_decoder(&rsapubkey_decoder, &rsa,
+			       pkey->key, pkey->keylen);
+	if (ret)
+		goto free;
+
+	rsa.len = (mbedtls_mpi_bitlen(&rsa.N) + 7) >> 3;
+
+	/*
+	 * In some cases (from X.509 certificates) we get here with a
+	 * BIT_STRING ASN.1 object, in which the first byte indicates
+	 * the number of unused bits in the bit string (in case the
+	 * string isn't a multiple of 8 long).
+	 * Assume here that it's always a multiple of 8, and just skip
+	 * the additional byte.
+	 */
+	if (s_size == rsa.len + 1 && sigdata[0] == 0) {
+		sigdata = sig->s + 1;
+		s_size -= 1;
+	}
+
+	if (rsa.len != s_size) {
+		ret = -EINVAL;
+		goto free;
+	}
+
+	ret = mbedtls_rsa_pkcs1_verify(&rsa, NULL, NULL, MBEDTLS_RSA_PUBLIC,
+				       md_alg, 0, sig->digest, sigdata);
+
+	if (ret)
+		ret = -EKEYREJECTED;
+	else
+		ret = 0;
+
+ free:
+	mbedtls_rsa_free(&rsa);
+
+	return ret;
+}
+
+void public_key_signature_free(struct public_key_signature *sig)
+{
+	int i;
+
+	if (sig) {
+		for (i = 0; i < ARRAY_SIZE(sig->auth_ids); i++)
+			kfree(sig->auth_ids[i]);
+		kfree(sig->s);
+		kfree(sig->digest);
+		kfree(sig);
+	}
+}
diff --git a/backport/compat/verification/rsa.c b/backport/compat/verification/rsa.c
new file mode 100644
index 000000000000..605bd8855e76
--- /dev/null
+++ b/backport/compat/verification/rsa.c
@@ -0,0 +1,1872 @@
+/*
+ *  The RSA public-key cryptosystem
+ *
+ *  Copyright (C) 2006-2015, ARM Limited, All Rights Reserved
+ *  SPDX-License-Identifier: GPL-2.0
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ *  This file is part of mbed TLS (https://tls.mbed.org)
+ */
+/*
+ *  The following sources were referenced in the design of this implementation
+ *  of the RSA algorithm:
+ *
+ *  [1] A method for obtaining digital signatures and public-key cryptosystems
+ *      R Rivest, A Shamir, and L Adleman
+ *      http://people.csail.mit.edu/rivest/pubs.html#RSA78
+ *
+ *  [2] Handbook of Applied Cryptography - 1997, Chapter 8
+ *      Menezes, van Oorschot and Vanstone
+ *
+ *  [3] Malware Guard Extension: Using SGX to Conceal Cache Attacks
+ *      Michael Schwarz, Samuel Weiser, Daniel Gruss, Clémentine Maurice and
+ *      Stefan Mangard
+ *      https://arxiv.org/abs/1702.08719v2
+ *
+ */
+
+#if !defined(MBEDTLS_CONFIG_FILE)
+#include "mbedtls/config.h"
+#else
+#include MBEDTLS_CONFIG_FILE
+#endif
+
+#if defined(MBEDTLS_RSA_C)
+
+#include "mbedtls/rsa.h"
+#include "mbedtls/oid.h"
+
+#if defined(MBEDTLS_PKCS1_V21)
+#include "mbedtls/md.h"
+#endif
+
+#if defined(MBEDTLS_PKCS1_V15) && !defined(__OpenBSD__)
+#include <stdlib.h>
+#endif
+
+#if defined(MBEDTLS_PLATFORM_C)
+#include "mbedtls/platform.h"
+#else
+#include <stdio.h>
+#define mbedtls_printf printf
+#define mbedtls_calloc calloc
+#define mbedtls_free   free
+#endif
+
+/* Implementation that should never be optimized out by the compiler */
+static void mbedtls_zeroize( void *v, size_t n ) {
+    volatile unsigned char *p = (unsigned char*)v; while( n-- ) *p++ = 0;
+}
+
+/*
+ * Initialize an RSA context
+ */
+void mbedtls_rsa_init( mbedtls_rsa_context *ctx,
+               int padding,
+               int hash_id )
+{
+    memset( ctx, 0, sizeof( mbedtls_rsa_context ) );
+
+    mbedtls_rsa_set_padding( ctx, padding, hash_id );
+
+#if defined(MBEDTLS_THREADING_C)
+    mbedtls_mutex_init( &ctx->mutex );
+#endif
+}
+
+/*
+ * Set padding for an existing RSA context
+ */
+void mbedtls_rsa_set_padding( mbedtls_rsa_context *ctx, int padding, int hash_id )
+{
+    ctx->padding = padding;
+    ctx->hash_id = hash_id;
+}
+
+#if defined(MBEDTLS_GENPRIME)
+
+/*
+ * Generate an RSA keypair
+ */
+int mbedtls_rsa_gen_key( mbedtls_rsa_context *ctx,
+                 int (*f_rng)(void *, unsigned char *, size_t),
+                 void *p_rng,
+                 unsigned int nbits, int exponent )
+{
+    int ret;
+    mbedtls_mpi P1, Q1, H, G;
+
+    if( f_rng == NULL || nbits < 128 || exponent < 3 )
+        return( MBEDTLS_ERR_RSA_BAD_INPUT_DATA );
+
+    if( nbits % 2 )
+        return( MBEDTLS_ERR_RSA_BAD_INPUT_DATA );
+
+    mbedtls_mpi_init( &P1 ); mbedtls_mpi_init( &Q1 );
+    mbedtls_mpi_init( &H ); mbedtls_mpi_init( &G );
+
+    /*
+     * find primes P and Q with Q < P so that:
+     * GCD( E, (P-1)*(Q-1) ) == 1
+     */
+    MBEDTLS_MPI_CHK( mbedtls_mpi_lset( &ctx->E, exponent ) );
+
+    do
+    {
+        MBEDTLS_MPI_CHK( mbedtls_mpi_gen_prime( &ctx->P, nbits >> 1, 0,
+                                f_rng, p_rng ) );
+
+        MBEDTLS_MPI_CHK( mbedtls_mpi_gen_prime( &ctx->Q, nbits >> 1, 0,
+                                f_rng, p_rng ) );
+
+        if( mbedtls_mpi_cmp_mpi( &ctx->P, &ctx->Q ) == 0 )
+            continue;
+
+        MBEDTLS_MPI_CHK( mbedtls_mpi_mul_mpi( &ctx->N, &ctx->P, &ctx->Q ) );
+        if( mbedtls_mpi_bitlen( &ctx->N ) != nbits )
+            continue;
+
+        if( mbedtls_mpi_cmp_mpi( &ctx->P, &ctx->Q ) < 0 )
+                                mbedtls_mpi_swap( &ctx->P, &ctx->Q );
+
+        MBEDTLS_MPI_CHK( mbedtls_mpi_sub_int( &P1, &ctx->P, 1 ) );
+        MBEDTLS_MPI_CHK( mbedtls_mpi_sub_int( &Q1, &ctx->Q, 1 ) );
+        MBEDTLS_MPI_CHK( mbedtls_mpi_mul_mpi( &H, &P1, &Q1 ) );
+        MBEDTLS_MPI_CHK( mbedtls_mpi_gcd( &G, &ctx->E, &H  ) );
+    }
+    while( mbedtls_mpi_cmp_int( &G, 1 ) != 0 );
+
+    /*
+     * D  = E^-1 mod ((P-1)*(Q-1))
+     * DP = D mod (P - 1)
+     * DQ = D mod (Q - 1)
+     * QP = Q^-1 mod P
+     */
+    MBEDTLS_MPI_CHK( mbedtls_mpi_inv_mod( &ctx->D , &ctx->E, &H  ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_mod_mpi( &ctx->DP, &ctx->D, &P1 ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_mod_mpi( &ctx->DQ, &ctx->D, &Q1 ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_inv_mod( &ctx->QP, &ctx->Q, &ctx->P ) );
+
+    ctx->len = ( mbedtls_mpi_bitlen( &ctx->N ) + 7 ) >> 3;
+
+cleanup:
+
+    mbedtls_mpi_free( &P1 ); mbedtls_mpi_free( &Q1 ); mbedtls_mpi_free( &H ); mbedtls_mpi_free( &G );
+
+    if( ret != 0 )
+    {
+        mbedtls_rsa_free( ctx );
+        return( MBEDTLS_ERR_RSA_KEY_GEN_FAILED + ret );
+    }
+
+    return( 0 );
+}
+
+#endif /* MBEDTLS_GENPRIME */
+
+/*
+ * Check a public RSA key
+ */
+int mbedtls_rsa_check_pubkey( const mbedtls_rsa_context *ctx )
+{
+    if( !ctx->N.p || !ctx->E.p )
+        return( MBEDTLS_ERR_RSA_KEY_CHECK_FAILED );
+
+    if( ( ctx->N.p[0] & 1 ) == 0 ||
+        ( ctx->E.p[0] & 1 ) == 0 )
+        return( MBEDTLS_ERR_RSA_KEY_CHECK_FAILED );
+
+    if( mbedtls_mpi_bitlen( &ctx->N ) < 128 ||
+        mbedtls_mpi_bitlen( &ctx->N ) > MBEDTLS_MPI_MAX_BITS )
+        return( MBEDTLS_ERR_RSA_KEY_CHECK_FAILED );
+
+    if( mbedtls_mpi_bitlen( &ctx->E ) < 2 ||
+        mbedtls_mpi_cmp_mpi( &ctx->E, &ctx->N ) >= 0 )
+        return( MBEDTLS_ERR_RSA_KEY_CHECK_FAILED );
+
+    return( 0 );
+}
+
+/*
+ * Check a private RSA key
+ */
+int mbedtls_rsa_check_privkey( const mbedtls_rsa_context *ctx )
+{
+    int ret;
+    mbedtls_mpi PQ, DE, P1, Q1, H, I, G, G2, L1, L2, DP, DQ, QP;
+
+    if( ( ret = mbedtls_rsa_check_pubkey( ctx ) ) != 0 )
+        return( ret );
+
+    if( !ctx->P.p || !ctx->Q.p || !ctx->D.p )
+        return( MBEDTLS_ERR_RSA_KEY_CHECK_FAILED );
+
+    mbedtls_mpi_init( &PQ ); mbedtls_mpi_init( &DE ); mbedtls_mpi_init( &P1 ); mbedtls_mpi_init( &Q1 );
+    mbedtls_mpi_init( &H  ); mbedtls_mpi_init( &I  ); mbedtls_mpi_init( &G  ); mbedtls_mpi_init( &G2 );
+    mbedtls_mpi_init( &L1 ); mbedtls_mpi_init( &L2 ); mbedtls_mpi_init( &DP ); mbedtls_mpi_init( &DQ );
+    mbedtls_mpi_init( &QP );
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_mul_mpi( &PQ, &ctx->P, &ctx->Q ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_mul_mpi( &DE, &ctx->D, &ctx->E ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_sub_int( &P1, &ctx->P, 1 ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_sub_int( &Q1, &ctx->Q, 1 ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_mul_mpi( &H, &P1, &Q1 ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_gcd( &G, &ctx->E, &H  ) );
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_gcd( &G2, &P1, &Q1 ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_div_mpi( &L1, &L2, &H, &G2 ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_mod_mpi( &I, &DE, &L1  ) );
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_mod_mpi( &DP, &ctx->D, &P1 ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_mod_mpi( &DQ, &ctx->D, &Q1 ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_inv_mod( &QP, &ctx->Q, &ctx->P ) );
+    /*
+     * Check for a valid PKCS1v2 private key
+     */
+    if( mbedtls_mpi_cmp_mpi( &PQ, &ctx->N ) != 0 ||
+        mbedtls_mpi_cmp_mpi( &DP, &ctx->DP ) != 0 ||
+        mbedtls_mpi_cmp_mpi( &DQ, &ctx->DQ ) != 0 ||
+        mbedtls_mpi_cmp_mpi( &QP, &ctx->QP ) != 0 ||
+        mbedtls_mpi_cmp_int( &L2, 0 ) != 0 ||
+        mbedtls_mpi_cmp_int( &I, 1 ) != 0 ||
+        mbedtls_mpi_cmp_int( &G, 1 ) != 0 )
+    {
+        ret = MBEDTLS_ERR_RSA_KEY_CHECK_FAILED;
+    }
+
+cleanup:
+    mbedtls_mpi_free( &PQ ); mbedtls_mpi_free( &DE ); mbedtls_mpi_free( &P1 ); mbedtls_mpi_free( &Q1 );
+    mbedtls_mpi_free( &H  ); mbedtls_mpi_free( &I  ); mbedtls_mpi_free( &G  ); mbedtls_mpi_free( &G2 );
+    mbedtls_mpi_free( &L1 ); mbedtls_mpi_free( &L2 ); mbedtls_mpi_free( &DP ); mbedtls_mpi_free( &DQ );
+    mbedtls_mpi_free( &QP );
+
+    if( ret == MBEDTLS_ERR_RSA_KEY_CHECK_FAILED )
+        return( ret );
+
+    if( ret != 0 )
+        return( MBEDTLS_ERR_RSA_KEY_CHECK_FAILED + ret );
+
+    return( 0 );
+}
+
+/*
+ * Check if contexts holding a public and private key match
+ */
+int mbedtls_rsa_check_pub_priv( const mbedtls_rsa_context *pub, const mbedtls_rsa_context *prv )
+{
+    if( mbedtls_rsa_check_pubkey( pub ) != 0 ||
+        mbedtls_rsa_check_privkey( prv ) != 0 )
+    {
+        return( MBEDTLS_ERR_RSA_KEY_CHECK_FAILED );
+    }
+
+    if( mbedtls_mpi_cmp_mpi( &pub->N, &prv->N ) != 0 ||
+        mbedtls_mpi_cmp_mpi( &pub->E, &prv->E ) != 0 )
+    {
+        return( MBEDTLS_ERR_RSA_KEY_CHECK_FAILED );
+    }
+
+    return( 0 );
+}
+
+/*
+ * Do an RSA public key operation
+ */
+int mbedtls_rsa_public( mbedtls_rsa_context *ctx,
+                const unsigned char *input,
+                unsigned char *output )
+{
+    int ret;
+    size_t olen;
+    mbedtls_mpi T;
+
+    mbedtls_mpi_init( &T );
+
+#if defined(MBEDTLS_THREADING_C)
+    if( ( ret = mbedtls_mutex_lock( &ctx->mutex ) ) != 0 )
+        return( ret );
+#endif
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_read_binary( &T, input, ctx->len ) );
+
+    if( mbedtls_mpi_cmp_mpi( &T, &ctx->N ) >= 0 )
+    {
+        ret = MBEDTLS_ERR_MPI_BAD_INPUT_DATA;
+        goto cleanup;
+    }
+
+    olen = ctx->len;
+    MBEDTLS_MPI_CHK( mbedtls_mpi_exp_mod( &T, &T, &ctx->E, &ctx->N, &ctx->RN ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_write_binary( &T, output, olen ) );
+
+cleanup:
+#if defined(MBEDTLS_THREADING_C)
+    if( mbedtls_mutex_unlock( &ctx->mutex ) != 0 )
+        return( MBEDTLS_ERR_THREADING_MUTEX_ERROR );
+#endif
+
+    mbedtls_mpi_free( &T );
+
+    if( ret != 0 )
+        return( MBEDTLS_ERR_RSA_PUBLIC_FAILED + ret );
+
+    return( 0 );
+}
+
+/*
+ * Generate or update blinding values, see section 10 of:
+ *  KOCHER, Paul C. Timing attacks on implementations of Diffie-Hellman, RSA,
+ *  DSS, and other systems. In : Advances in Cryptology-CRYPTO'96. Springer
+ *  Berlin Heidelberg, 1996. p. 104-113.
+ */
+static int rsa_prepare_blinding( mbedtls_rsa_context *ctx,
+                 int (*f_rng)(void *, unsigned char *, size_t), void *p_rng )
+{
+    int ret, count = 0;
+
+    if( ctx->Vf.p != NULL )
+    {
+        /* We already have blinding values, just update them by squaring */
+        MBEDTLS_MPI_CHK( mbedtls_mpi_mul_mpi( &ctx->Vi, &ctx->Vi, &ctx->Vi ) );
+        MBEDTLS_MPI_CHK( mbedtls_mpi_mod_mpi( &ctx->Vi, &ctx->Vi, &ctx->N ) );
+        MBEDTLS_MPI_CHK( mbedtls_mpi_mul_mpi( &ctx->Vf, &ctx->Vf, &ctx->Vf ) );
+        MBEDTLS_MPI_CHK( mbedtls_mpi_mod_mpi( &ctx->Vf, &ctx->Vf, &ctx->N ) );
+
+        goto cleanup;
+    }
+
+    /* Unblinding value: Vf = random number, invertible mod N */
+    do {
+        if( count++ > 10 )
+            return( MBEDTLS_ERR_RSA_RNG_FAILED );
+
+        MBEDTLS_MPI_CHK( mbedtls_mpi_fill_random( &ctx->Vf, ctx->len - 1, f_rng, p_rng ) );
+        MBEDTLS_MPI_CHK( mbedtls_mpi_gcd( &ctx->Vi, &ctx->Vf, &ctx->N ) );
+    } while( mbedtls_mpi_cmp_int( &ctx->Vi, 1 ) != 0 );
+
+    /* Blinding value: Vi =  Vf^(-e) mod N */
+    MBEDTLS_MPI_CHK( mbedtls_mpi_inv_mod( &ctx->Vi, &ctx->Vf, &ctx->N ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_exp_mod( &ctx->Vi, &ctx->Vi, &ctx->E, &ctx->N, &ctx->RN ) );
+
+
+cleanup:
+    return( ret );
+}
+
+/*
+ * Exponent blinding supposed to prevent side-channel attacks using multiple
+ * traces of measurements to recover the RSA key. The more collisions are there,
+ * the more bits of the key can be recovered. See [3].
+ *
+ * Collecting n collisions with m bit long blinding value requires 2^(m-m/n)
+ * observations on avarage.
+ *
+ * For example with 28 byte blinding to achieve 2 collisions the adversary has
+ * to make 2^112 observations on avarage.
+ *
+ * (With the currently (as of 2017 April) known best algorithms breaking 2048
+ * bit RSA requires approximately as much time as trying out 2^112 random keys.
+ * Thus in this sense with 28 byte blinding the security is not reduced by
+ * side-channel attacks like the one in [3])
+ *
+ * This countermeasure does not help if the key recovery is possible with a
+ * single trace.
+ */
+#define RSA_EXPONENT_BLINDING 28
+
+/*
+ * Do an RSA private key operation
+ */
+int mbedtls_rsa_private( mbedtls_rsa_context *ctx,
+                 int (*f_rng)(void *, unsigned char *, size_t),
+                 void *p_rng,
+                 const unsigned char *input,
+                 unsigned char *output )
+{
+    int ret;
+    size_t olen;
+    mbedtls_mpi T, T1, T2;
+    mbedtls_mpi P1, Q1, R;
+#if defined(MBEDTLS_RSA_NO_CRT)
+    mbedtls_mpi D_blind;
+    mbedtls_mpi *D = &ctx->D;
+#else
+    mbedtls_mpi DP_blind, DQ_blind;
+    mbedtls_mpi *DP = &ctx->DP;
+    mbedtls_mpi *DQ = &ctx->DQ;
+#endif
+
+    /* Make sure we have private key info, prevent possible misuse */
+    if( ctx->P.p == NULL || ctx->Q.p == NULL || ctx->D.p == NULL )
+        return( MBEDTLS_ERR_RSA_BAD_INPUT_DATA );
+
+    mbedtls_mpi_init( &T ); mbedtls_mpi_init( &T1 ); mbedtls_mpi_init( &T2 );
+    mbedtls_mpi_init( &P1 ); mbedtls_mpi_init( &Q1 ); mbedtls_mpi_init( &R );
+
+
+    if( f_rng != NULL )
+    {
+#if defined(MBEDTLS_RSA_NO_CRT)
+        mbedtls_mpi_init( &D_blind );
+#else
+        mbedtls_mpi_init( &DP_blind );
+        mbedtls_mpi_init( &DQ_blind );
+#endif
+    }
+
+
+#if defined(MBEDTLS_THREADING_C)
+    if( ( ret = mbedtls_mutex_lock( &ctx->mutex ) ) != 0 )
+        return( ret );
+#endif
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_read_binary( &T, input, ctx->len ) );
+    if( mbedtls_mpi_cmp_mpi( &T, &ctx->N ) >= 0 )
+    {
+        ret = MBEDTLS_ERR_MPI_BAD_INPUT_DATA;
+        goto cleanup;
+    }
+
+    if( f_rng != NULL )
+    {
+        /*
+         * Blinding
+         * T = T * Vi mod N
+         */
+        MBEDTLS_MPI_CHK( rsa_prepare_blinding( ctx, f_rng, p_rng ) );
+        MBEDTLS_MPI_CHK( mbedtls_mpi_mul_mpi( &T, &T, &ctx->Vi ) );
+        MBEDTLS_MPI_CHK( mbedtls_mpi_mod_mpi( &T, &T, &ctx->N ) );
+
+        /*
+         * Exponent blinding
+         */
+        MBEDTLS_MPI_CHK( mbedtls_mpi_sub_int( &P1, &ctx->P, 1 ) );
+        MBEDTLS_MPI_CHK( mbedtls_mpi_sub_int( &Q1, &ctx->Q, 1 ) );
+
+#if defined(MBEDTLS_RSA_NO_CRT)
+        /*
+         * D_blind = ( P - 1 ) * ( Q - 1 ) * R + D
+         */
+        MBEDTLS_MPI_CHK( mbedtls_mpi_fill_random( &R, RSA_EXPONENT_BLINDING,
+                         f_rng, p_rng ) );
+        MBEDTLS_MPI_CHK( mbedtls_mpi_mul_mpi( &D_blind, &P1, &Q1 ) );
+        MBEDTLS_MPI_CHK( mbedtls_mpi_mul_mpi( &D_blind, &D_blind, &R ) );
+        MBEDTLS_MPI_CHK( mbedtls_mpi_add_mpi( &D_blind, &D_blind, &ctx->D ) );
+
+        D = &D_blind;
+#else
+        /*
+         * DP_blind = ( P - 1 ) * R + DP
+         */
+        MBEDTLS_MPI_CHK( mbedtls_mpi_fill_random( &R, RSA_EXPONENT_BLINDING,
+                         f_rng, p_rng ) );
+        MBEDTLS_MPI_CHK( mbedtls_mpi_mul_mpi( &DP_blind, &P1, &R ) );
+        MBEDTLS_MPI_CHK( mbedtls_mpi_add_mpi( &DP_blind, &DP_blind,
+                    &ctx->DP ) );
+
+        DP = &DP_blind;
+
+        /*
+         * DQ_blind = ( Q - 1 ) * R + DQ
+         */
+        MBEDTLS_MPI_CHK( mbedtls_mpi_fill_random( &R, RSA_EXPONENT_BLINDING,
+                         f_rng, p_rng ) );
+        MBEDTLS_MPI_CHK( mbedtls_mpi_mul_mpi( &DQ_blind, &Q1, &R ) );
+        MBEDTLS_MPI_CHK( mbedtls_mpi_add_mpi( &DQ_blind, &DQ_blind,
+                    &ctx->DQ ) );
+
+        DQ = &DQ_blind;
+#endif /* MBEDTLS_RSA_NO_CRT */
+    }
+
+#if defined(MBEDTLS_RSA_NO_CRT)
+    MBEDTLS_MPI_CHK( mbedtls_mpi_exp_mod( &T, &T, D, &ctx->N, &ctx->RN ) );
+#else
+    /*
+     * Faster decryption using the CRT
+     *
+     * T1 = input ^ dP mod P
+     * T2 = input ^ dQ mod Q
+     */
+    MBEDTLS_MPI_CHK( mbedtls_mpi_exp_mod( &T1, &T, DP, &ctx->P, &ctx->RP ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_exp_mod( &T2, &T, DQ, &ctx->Q, &ctx->RQ ) );
+
+    /*
+     * T = (T1 - T2) * (Q^-1 mod P) mod P
+     */
+    MBEDTLS_MPI_CHK( mbedtls_mpi_sub_mpi( &T, &T1, &T2 ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_mul_mpi( &T1, &T, &ctx->QP ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_mod_mpi( &T, &T1, &ctx->P ) );
+
+    /*
+     * T = T2 + T * Q
+     */
+    MBEDTLS_MPI_CHK( mbedtls_mpi_mul_mpi( &T1, &T, &ctx->Q ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_add_mpi( &T, &T2, &T1 ) );
+#endif /* MBEDTLS_RSA_NO_CRT */
+
+    if( f_rng != NULL )
+    {
+        /*
+         * Unblind
+         * T = T * Vf mod N
+         */
+        MBEDTLS_MPI_CHK( mbedtls_mpi_mul_mpi( &T, &T, &ctx->Vf ) );
+        MBEDTLS_MPI_CHK( mbedtls_mpi_mod_mpi( &T, &T, &ctx->N ) );
+    }
+
+    olen = ctx->len;
+    MBEDTLS_MPI_CHK( mbedtls_mpi_write_binary( &T, output, olen ) );
+
+cleanup:
+#if defined(MBEDTLS_THREADING_C)
+    if( mbedtls_mutex_unlock( &ctx->mutex ) != 0 )
+        return( MBEDTLS_ERR_THREADING_MUTEX_ERROR );
+#endif
+
+    mbedtls_mpi_free( &T ); mbedtls_mpi_free( &T1 ); mbedtls_mpi_free( &T2 );
+    mbedtls_mpi_free( &P1 ); mbedtls_mpi_free( &Q1 ); mbedtls_mpi_free( &R );
+
+    if( f_rng != NULL )
+    {
+#if defined(MBEDTLS_RSA_NO_CRT)
+        mbedtls_mpi_free( &D_blind );
+#else
+        mbedtls_mpi_free( &DP_blind );
+        mbedtls_mpi_free( &DQ_blind );
+#endif
+    }
+
+    if( ret != 0 )
+        return( MBEDTLS_ERR_RSA_PRIVATE_FAILED + ret );
+
+    return( 0 );
+}
+
+#if defined(MBEDTLS_PKCS1_V21)
+/**
+ * Generate and apply the MGF1 operation (from PKCS#1 v2.1) to a buffer.
+ *
+ * \param dst       buffer to mask
+ * \param dlen      length of destination buffer
+ * \param src       source of the mask generation
+ * \param slen      length of the source buffer
+ * \param md_ctx    message digest context to use
+ */
+static void mgf_mask( unsigned char *dst, size_t dlen, unsigned char *src,
+                      size_t slen, mbedtls_md_context_t *md_ctx )
+{
+    unsigned char mask[MBEDTLS_MD_MAX_SIZE];
+    unsigned char counter[4];
+    unsigned char *p;
+    unsigned int hlen;
+    size_t i, use_len;
+
+    memset( mask, 0, MBEDTLS_MD_MAX_SIZE );
+    memset( counter, 0, 4 );
+
+    hlen = mbedtls_md_get_size( md_ctx->md_info );
+
+    /* Generate and apply dbMask */
+    p = dst;
+
+    while( dlen > 0 )
+    {
+        use_len = hlen;
+        if( dlen < hlen )
+            use_len = dlen;
+
+        mbedtls_md_starts( md_ctx );
+        mbedtls_md_update( md_ctx, src, slen );
+        mbedtls_md_update( md_ctx, counter, 4 );
+        mbedtls_md_finish( md_ctx, mask );
+
+        for( i = 0; i < use_len; ++i )
+            *p++ ^= mask[i];
+
+        counter[3]++;
+
+        dlen -= use_len;
+    }
+
+    mbedtls_zeroize( mask, sizeof( mask ) );
+}
+#endif /* MBEDTLS_PKCS1_V21 */
+
+#if defined(MBEDTLS_PKCS1_V21)
+/*
+ * Implementation of the PKCS#1 v2.1 RSAES-OAEP-ENCRYPT function
+ */
+int mbedtls_rsa_rsaes_oaep_encrypt( mbedtls_rsa_context *ctx,
+                            int (*f_rng)(void *, unsigned char *, size_t),
+                            void *p_rng,
+                            int mode,
+                            const unsigned char *label, size_t label_len,
+                            size_t ilen,
+                            const unsigned char *input,
+                            unsigned char *output )
+{
+    size_t olen;
+    int ret;
+    unsigned char *p = output;
+    unsigned int hlen;
+    const mbedtls_md_info_t *md_info;
+    mbedtls_md_context_t md_ctx;
+
+    if( mode == MBEDTLS_RSA_PRIVATE && ctx->padding != MBEDTLS_RSA_PKCS_V21 )
+        return( MBEDTLS_ERR_RSA_BAD_INPUT_DATA );
+
+    if( f_rng == NULL )
+        return( MBEDTLS_ERR_RSA_BAD_INPUT_DATA );
+
+    md_info = mbedtls_md_info_from_type( (mbedtls_md_type_t) ctx->hash_id );
+    if( md_info == NULL )
+        return( MBEDTLS_ERR_RSA_BAD_INPUT_DATA );
+
+    olen = ctx->len;
+    hlen = mbedtls_md_get_size( md_info );
+
+    /* first comparison checks for overflow */
+    if( ilen + 2 * hlen + 2 < ilen || olen < ilen + 2 * hlen + 2 )
+        return( MBEDTLS_ERR_RSA_BAD_INPUT_DATA );
+
+    memset( output, 0, olen );
+
+    *p++ = 0;
+
+    /* Generate a random octet string seed */
+    if( ( ret = f_rng( p_rng, p, hlen ) ) != 0 )
+        return( MBEDTLS_ERR_RSA_RNG_FAILED + ret );
+
+    p += hlen;
+
+    /* Construct DB */
+    mbedtls_md( md_info, label, label_len, p );
+    p += hlen;
+    p += olen - 2 * hlen - 2 - ilen;
+    *p++ = 1;
+    memcpy( p, input, ilen );
+
+    mbedtls_md_init( &md_ctx );
+    if( ( ret = mbedtls_md_setup( &md_ctx, md_info, 0 ) ) != 0 )
+    {
+        mbedtls_md_free( &md_ctx );
+        return( ret );
+    }
+
+    /* maskedDB: Apply dbMask to DB */
+    mgf_mask( output + hlen + 1, olen - hlen - 1, output + 1, hlen,
+               &md_ctx );
+
+    /* maskedSeed: Apply seedMask to seed */
+    mgf_mask( output + 1, hlen, output + hlen + 1, olen - hlen - 1,
+               &md_ctx );
+
+    mbedtls_md_free( &md_ctx );
+
+    return( ( mode == MBEDTLS_RSA_PUBLIC )
+            ? mbedtls_rsa_public(  ctx, output, output )
+            : mbedtls_rsa_private( ctx, f_rng, p_rng, output, output ) );
+}
+#endif /* MBEDTLS_PKCS1_V21 */
+
+#if defined(MBEDTLS_PKCS1_V15)
+/*
+ * Implementation of the PKCS#1 v2.1 RSAES-PKCS1-V1_5-ENCRYPT function
+ */
+int mbedtls_rsa_rsaes_pkcs1_v15_encrypt( mbedtls_rsa_context *ctx,
+                                 int (*f_rng)(void *, unsigned char *, size_t),
+                                 void *p_rng,
+                                 int mode, size_t ilen,
+                                 const unsigned char *input,
+                                 unsigned char *output )
+{
+    size_t nb_pad, olen;
+    int ret;
+    unsigned char *p = output;
+
+    if( mode == MBEDTLS_RSA_PRIVATE && ctx->padding != MBEDTLS_RSA_PKCS_V15 )
+        return( MBEDTLS_ERR_RSA_BAD_INPUT_DATA );
+
+    // We don't check p_rng because it won't be dereferenced here
+    if( f_rng == NULL || input == NULL || output == NULL )
+        return( MBEDTLS_ERR_RSA_BAD_INPUT_DATA );
+
+    olen = ctx->len;
+
+    /* first comparison checks for overflow */
+    if( ilen + 11 < ilen || olen < ilen + 11 )
+        return( MBEDTLS_ERR_RSA_BAD_INPUT_DATA );
+
+    nb_pad = olen - 3 - ilen;
+
+    *p++ = 0;
+    if( mode == MBEDTLS_RSA_PUBLIC )
+    {
+        *p++ = MBEDTLS_RSA_CRYPT;
+
+        while( nb_pad-- > 0 )
+        {
+            int rng_dl = 100;
+
+            do {
+                ret = f_rng( p_rng, p, 1 );
+            } while( *p == 0 && --rng_dl && ret == 0 );
+
+            /* Check if RNG failed to generate data */
+            if( rng_dl == 0 || ret != 0 )
+                return( MBEDTLS_ERR_RSA_RNG_FAILED + ret );
+
+            p++;
+        }
+    }
+    else
+    {
+        *p++ = MBEDTLS_RSA_SIGN;
+
+        while( nb_pad-- > 0 )
+            *p++ = 0xFF;
+    }
+
+    *p++ = 0;
+    memcpy( p, input, ilen );
+
+    return( ( mode == MBEDTLS_RSA_PUBLIC )
+            ? mbedtls_rsa_public(  ctx, output, output )
+            : mbedtls_rsa_private( ctx, f_rng, p_rng, output, output ) );
+}
+#endif /* MBEDTLS_PKCS1_V15 */
+
+/*
+ * Add the message padding, then do an RSA operation
+ */
+int mbedtls_rsa_pkcs1_encrypt( mbedtls_rsa_context *ctx,
+                       int (*f_rng)(void *, unsigned char *, size_t),
+                       void *p_rng,
+                       int mode, size_t ilen,
+                       const unsigned char *input,
+                       unsigned char *output )
+{
+    switch( ctx->padding )
+    {
+#if defined(MBEDTLS_PKCS1_V15)
+        case MBEDTLS_RSA_PKCS_V15:
+            return mbedtls_rsa_rsaes_pkcs1_v15_encrypt( ctx, f_rng, p_rng, mode, ilen,
+                                                input, output );
+#endif
+
+#if defined(MBEDTLS_PKCS1_V21)
+        case MBEDTLS_RSA_PKCS_V21:
+            return mbedtls_rsa_rsaes_oaep_encrypt( ctx, f_rng, p_rng, mode, NULL, 0,
+                                           ilen, input, output );
+#endif
+
+        default:
+            return( MBEDTLS_ERR_RSA_INVALID_PADDING );
+    }
+}
+
+#if defined(MBEDTLS_PKCS1_V21)
+/*
+ * Implementation of the PKCS#1 v2.1 RSAES-OAEP-DECRYPT function
+ */
+int mbedtls_rsa_rsaes_oaep_decrypt( mbedtls_rsa_context *ctx,
+                            int (*f_rng)(void *, unsigned char *, size_t),
+                            void *p_rng,
+                            int mode,
+                            const unsigned char *label, size_t label_len,
+                            size_t *olen,
+                            const unsigned char *input,
+                            unsigned char *output,
+                            size_t output_max_len )
+{
+    int ret;
+    size_t ilen, i, pad_len;
+    unsigned char *p, bad, pad_done;
+    unsigned char buf[MBEDTLS_MPI_MAX_SIZE];
+    unsigned char lhash[MBEDTLS_MD_MAX_SIZE];
+    unsigned int hlen;
+    const mbedtls_md_info_t *md_info;
+    mbedtls_md_context_t md_ctx;
+
+    /*
+     * Parameters sanity checks
+     */
+    if( mode == MBEDTLS_RSA_PRIVATE && ctx->padding != MBEDTLS_RSA_PKCS_V21 )
+        return( MBEDTLS_ERR_RSA_BAD_INPUT_DATA );
+
+    ilen = ctx->len;
+
+    if( ilen < 16 || ilen > sizeof( buf ) )
+        return( MBEDTLS_ERR_RSA_BAD_INPUT_DATA );
+
+    md_info = mbedtls_md_info_from_type( (mbedtls_md_type_t) ctx->hash_id );
+    if( md_info == NULL )
+        return( MBEDTLS_ERR_RSA_BAD_INPUT_DATA );
+
+    hlen = mbedtls_md_get_size( md_info );
+
+    // checking for integer underflow
+    if( 2 * hlen + 2 > ilen )
+        return( MBEDTLS_ERR_RSA_BAD_INPUT_DATA );
+
+    /*
+     * RSA operation
+     */
+    ret = ( mode == MBEDTLS_RSA_PUBLIC )
+          ? mbedtls_rsa_public(  ctx, input, buf )
+          : mbedtls_rsa_private( ctx, f_rng, p_rng, input, buf );
+
+    if( ret != 0 )
+        goto cleanup;
+
+    /*
+     * Unmask data and generate lHash
+     */
+    mbedtls_md_init( &md_ctx );
+    if( ( ret = mbedtls_md_setup( &md_ctx, md_info, 0 ) ) != 0 )
+    {
+        mbedtls_md_free( &md_ctx );
+        goto cleanup;
+    }
+
+
+    /* Generate lHash */
+    mbedtls_md( md_info, label, label_len, lhash );
+
+    /* seed: Apply seedMask to maskedSeed */
+    mgf_mask( buf + 1, hlen, buf + hlen + 1, ilen - hlen - 1,
+               &md_ctx );
+
+    /* DB: Apply dbMask to maskedDB */
+    mgf_mask( buf + hlen + 1, ilen - hlen - 1, buf + 1, hlen,
+               &md_ctx );
+
+    mbedtls_md_free( &md_ctx );
+
+    /*
+     * Check contents, in "constant-time"
+     */
+    p = buf;
+    bad = 0;
+
+    bad |= *p++; /* First byte must be 0 */
+
+    p += hlen; /* Skip seed */
+
+    /* Check lHash */
+    for( i = 0; i < hlen; i++ )
+        bad |= lhash[i] ^ *p++;
+
+    /* Get zero-padding len, but always read till end of buffer
+     * (minus one, for the 01 byte) */
+    pad_len = 0;
+    pad_done = 0;
+    for( i = 0; i < ilen - 2 * hlen - 2; i++ )
+    {
+        pad_done |= p[i];
+        pad_len += ((pad_done | (unsigned char)-pad_done) >> 7) ^ 1;
+    }
+
+    p += pad_len;
+    bad |= *p++ ^ 0x01;
+
+    /*
+     * The only information "leaked" is whether the padding was correct or not
+     * (eg, no data is copied if it was not correct). This meets the
+     * recommendations in PKCS#1 v2.2: an opponent cannot distinguish between
+     * the different error conditions.
+     */
+    if( bad != 0 )
+    {
+        ret = MBEDTLS_ERR_RSA_INVALID_PADDING;
+        goto cleanup;
+    }
+
+    if( ilen - ( p - buf ) > output_max_len )
+    {
+        ret = MBEDTLS_ERR_RSA_OUTPUT_TOO_LARGE;
+        goto cleanup;
+    }
+
+    *olen = ilen - (p - buf);
+    memcpy( output, p, *olen );
+    ret = 0;
+
+cleanup:
+    mbedtls_zeroize( buf, sizeof( buf ) );
+    mbedtls_zeroize( lhash, sizeof( lhash ) );
+
+    return( ret );
+}
+#endif /* MBEDTLS_PKCS1_V21 */
+
+#if defined(MBEDTLS_PKCS1_V15)
+/*
+ * Implementation of the PKCS#1 v2.1 RSAES-PKCS1-V1_5-DECRYPT function
+ */
+int mbedtls_rsa_rsaes_pkcs1_v15_decrypt( mbedtls_rsa_context *ctx,
+                                 int (*f_rng)(void *, unsigned char *, size_t),
+                                 void *p_rng,
+                                 int mode, size_t *olen,
+                                 const unsigned char *input,
+                                 unsigned char *output,
+                                 size_t output_max_len)
+{
+    int ret;
+    size_t ilen, pad_count = 0, i;
+    unsigned char *p, bad, pad_done = 0;
+    unsigned char buf[MBEDTLS_MPI_MAX_SIZE];
+
+    if( mode == MBEDTLS_RSA_PRIVATE && ctx->padding != MBEDTLS_RSA_PKCS_V15 )
+        return( MBEDTLS_ERR_RSA_BAD_INPUT_DATA );
+
+    ilen = ctx->len;
+
+    if( ilen < 16 || ilen > sizeof( buf ) )
+        return( MBEDTLS_ERR_RSA_BAD_INPUT_DATA );
+
+    ret = ( mode == MBEDTLS_RSA_PUBLIC )
+          ? mbedtls_rsa_public(  ctx, input, buf )
+          : mbedtls_rsa_private( ctx, f_rng, p_rng, input, buf );
+
+    if( ret != 0 )
+        goto cleanup;
+
+    p = buf;
+    bad = 0;
+
+    /*
+     * Check and get padding len in "constant-time"
+     */
+    bad |= *p++; /* First byte must be 0 */
+
+    /* This test does not depend on secret data */
+    if( mode == MBEDTLS_RSA_PRIVATE )
+    {
+        bad |= *p++ ^ MBEDTLS_RSA_CRYPT;
+
+        /* Get padding len, but always read till end of buffer
+         * (minus one, for the 00 byte) */
+        for( i = 0; i < ilen - 3; i++ )
+        {
+            pad_done  |= ((p[i] | (unsigned char)-p[i]) >> 7) ^ 1;
+            pad_count += ((pad_done | (unsigned char)-pad_done) >> 7) ^ 1;
+        }
+
+        p += pad_count;
+        bad |= *p++; /* Must be zero */
+    }
+    else
+    {
+        bad |= *p++ ^ MBEDTLS_RSA_SIGN;
+
+        /* Get padding len, but always read till end of buffer
+         * (minus one, for the 00 byte) */
+        for( i = 0; i < ilen - 3; i++ )
+        {
+            pad_done |= ( p[i] != 0xFF );
+            pad_count += ( pad_done == 0 );
+        }
+
+        p += pad_count;
+        bad |= *p++; /* Must be zero */
+    }
+
+    bad |= ( pad_count < 8 );
+
+    if( bad )
+    {
+        ret = MBEDTLS_ERR_RSA_INVALID_PADDING;
+        goto cleanup;
+    }
+
+    if( ilen - ( p - buf ) > output_max_len )
+    {
+        ret = MBEDTLS_ERR_RSA_OUTPUT_TOO_LARGE;
+        goto cleanup;
+    }
+
+    *olen = ilen - (p - buf);
+    memcpy( output, p, *olen );
+    ret = 0;
+
+cleanup:
+    mbedtls_zeroize( buf, sizeof( buf ) );
+
+    return( ret );
+}
+#endif /* MBEDTLS_PKCS1_V15 */
+
+/*
+ * Do an RSA operation, then remove the message padding
+ */
+int mbedtls_rsa_pkcs1_decrypt( mbedtls_rsa_context *ctx,
+                       int (*f_rng)(void *, unsigned char *, size_t),
+                       void *p_rng,
+                       int mode, size_t *olen,
+                       const unsigned char *input,
+                       unsigned char *output,
+                       size_t output_max_len)
+{
+    switch( ctx->padding )
+    {
+#if defined(MBEDTLS_PKCS1_V15)
+        case MBEDTLS_RSA_PKCS_V15:
+            return mbedtls_rsa_rsaes_pkcs1_v15_decrypt( ctx, f_rng, p_rng, mode, olen,
+                                                input, output, output_max_len );
+#endif
+
+#if defined(MBEDTLS_PKCS1_V21)
+        case MBEDTLS_RSA_PKCS_V21:
+            return mbedtls_rsa_rsaes_oaep_decrypt( ctx, f_rng, p_rng, mode, NULL, 0,
+                                           olen, input, output,
+                                           output_max_len );
+#endif
+
+        default:
+            return( MBEDTLS_ERR_RSA_INVALID_PADDING );
+    }
+}
+
+#if defined(MBEDTLS_PKCS1_V21)
+/*
+ * Implementation of the PKCS#1 v2.1 RSASSA-PSS-SIGN function
+ */
+int mbedtls_rsa_rsassa_pss_sign( mbedtls_rsa_context *ctx,
+                         int (*f_rng)(void *, unsigned char *, size_t),
+                         void *p_rng,
+                         int mode,
+                         mbedtls_md_type_t md_alg,
+                         unsigned int hashlen,
+                         const unsigned char *hash,
+                         unsigned char *sig )
+{
+    size_t olen;
+    unsigned char *p = sig;
+    unsigned char salt[MBEDTLS_MD_MAX_SIZE];
+    unsigned int slen, hlen, offset = 0;
+    int ret;
+    size_t msb;
+    const mbedtls_md_info_t *md_info;
+    mbedtls_md_context_t md_ctx;
+
+    if( mode == MBEDTLS_RSA_PRIVATE && ctx->padding != MBEDTLS_RSA_PKCS_V21 )
+        return( MBEDTLS_ERR_RSA_BAD_INPUT_DATA );
+
+    if( f_rng == NULL )
+        return( MBEDTLS_ERR_RSA_BAD_INPUT_DATA );
+
+    olen = ctx->len;
+
+    if( md_alg != MBEDTLS_MD_NONE )
+    {
+        /* Gather length of hash to sign */
+        md_info = mbedtls_md_info_from_type( md_alg );
+        if( md_info == NULL )
+            return( MBEDTLS_ERR_RSA_BAD_INPUT_DATA );
+
+        hashlen = mbedtls_md_get_size( md_info );
+    }
+
+    md_info = mbedtls_md_info_from_type( (mbedtls_md_type_t) ctx->hash_id );
+    if( md_info == NULL )
+        return( MBEDTLS_ERR_RSA_BAD_INPUT_DATA );
+
+    hlen = mbedtls_md_get_size( md_info );
+    slen = hlen;
+
+    if( olen < hlen + slen + 2 )
+        return( MBEDTLS_ERR_RSA_BAD_INPUT_DATA );
+
+    memset( sig, 0, olen );
+
+    /* Generate salt of length slen */
+    if( ( ret = f_rng( p_rng, salt, slen ) ) != 0 )
+        return( MBEDTLS_ERR_RSA_RNG_FAILED + ret );
+
+    /* Note: EMSA-PSS encoding is over the length of N - 1 bits */
+    msb = mbedtls_mpi_bitlen( &ctx->N ) - 1;
+    p += olen - hlen * 2 - 2;
+    *p++ = 0x01;
+    memcpy( p, salt, slen );
+    p += slen;
+
+    mbedtls_md_init( &md_ctx );
+    if( ( ret = mbedtls_md_setup( &md_ctx, md_info, 0 ) ) != 0 )
+    {
+        mbedtls_md_free( &md_ctx );
+        /* No need to zeroize salt: we didn't use it. */
+        return( ret );
+    }
+
+    /* Generate H = Hash( M' ) */
+    mbedtls_md_starts( &md_ctx );
+    mbedtls_md_update( &md_ctx, p, 8 );
+    mbedtls_md_update( &md_ctx, hash, hashlen );
+    mbedtls_md_update( &md_ctx, salt, slen );
+    mbedtls_md_finish( &md_ctx, p );
+    mbedtls_zeroize( salt, sizeof( salt ) );
+
+    /* Compensate for boundary condition when applying mask */
+    if( msb % 8 == 0 )
+        offset = 1;
+
+    /* maskedDB: Apply dbMask to DB */
+    mgf_mask( sig + offset, olen - hlen - 1 - offset, p, hlen, &md_ctx );
+
+    mbedtls_md_free( &md_ctx );
+
+    msb = mbedtls_mpi_bitlen( &ctx->N ) - 1;
+    sig[0] &= 0xFF >> ( olen * 8 - msb );
+
+    p += hlen;
+    *p++ = 0xBC;
+
+    return( ( mode == MBEDTLS_RSA_PUBLIC )
+            ? mbedtls_rsa_public(  ctx, sig, sig )
+            : mbedtls_rsa_private( ctx, f_rng, p_rng, sig, sig ) );
+}
+#endif /* MBEDTLS_PKCS1_V21 */
+
+#if defined(MBEDTLS_PKCS1_V15)
+/*
+ * Implementation of the PKCS#1 v2.1 RSASSA-PKCS1-V1_5-SIGN function
+ */
+/*
+ * Do an RSA operation to sign the message digest
+ */
+int mbedtls_rsa_rsassa_pkcs1_v15_sign( mbedtls_rsa_context *ctx,
+                               int (*f_rng)(void *, unsigned char *, size_t),
+                               void *p_rng,
+                               int mode,
+                               mbedtls_md_type_t md_alg,
+                               unsigned int hashlen,
+                               const unsigned char *hash,
+                               unsigned char *sig )
+{
+    size_t nb_pad, olen, oid_size = 0;
+    unsigned char *p = sig;
+    const char *oid = NULL;
+    unsigned char *sig_try = NULL, *verif = NULL;
+    size_t i;
+    unsigned char diff;
+    volatile unsigned char diff_no_optimize;
+    int ret;
+
+    if( mode == MBEDTLS_RSA_PRIVATE && ctx->padding != MBEDTLS_RSA_PKCS_V15 )
+        return( MBEDTLS_ERR_RSA_BAD_INPUT_DATA );
+
+    olen = ctx->len;
+    nb_pad = olen - 3;
+
+    if( md_alg != MBEDTLS_MD_NONE )
+    {
+        const mbedtls_md_info_t *md_info = mbedtls_md_info_from_type( md_alg );
+        if( md_info == NULL )
+            return( MBEDTLS_ERR_RSA_BAD_INPUT_DATA );
+
+        if( mbedtls_oid_get_oid_by_md( md_alg, &oid, &oid_size ) != 0 )
+            return( MBEDTLS_ERR_RSA_BAD_INPUT_DATA );
+
+        nb_pad -= 10 + oid_size;
+
+        hashlen = mbedtls_md_get_size( md_info );
+    }
+
+    nb_pad -= hashlen;
+
+    if( ( nb_pad < 8 ) || ( nb_pad > olen ) )
+        return( MBEDTLS_ERR_RSA_BAD_INPUT_DATA );
+
+    *p++ = 0;
+    *p++ = MBEDTLS_RSA_SIGN;
+    memset( p, 0xFF, nb_pad );
+    p += nb_pad;
+    *p++ = 0;
+
+    if( md_alg == MBEDTLS_MD_NONE )
+    {
+        memcpy( p, hash, hashlen );
+    }
+    else
+    {
+        /*
+         * DigestInfo ::= SEQUENCE {
+         *   digestAlgorithm DigestAlgorithmIdentifier,
+         *   digest Digest }
+         *
+         * DigestAlgorithmIdentifier ::= AlgorithmIdentifier
+         *
+         * Digest ::= OCTET STRING
+         */
+        *p++ = MBEDTLS_ASN1_SEQUENCE | MBEDTLS_ASN1_CONSTRUCTED;
+        *p++ = (unsigned char) ( 0x08 + oid_size + hashlen );
+        *p++ = MBEDTLS_ASN1_SEQUENCE | MBEDTLS_ASN1_CONSTRUCTED;
+        *p++ = (unsigned char) ( 0x04 + oid_size );
+        *p++ = MBEDTLS_ASN1_OID;
+        *p++ = oid_size & 0xFF;
+        memcpy( p, oid, oid_size );
+        p += oid_size;
+        *p++ = MBEDTLS_ASN1_NULL;
+        *p++ = 0x00;
+        *p++ = MBEDTLS_ASN1_OCTET_STRING;
+        *p++ = hashlen;
+        memcpy( p, hash, hashlen );
+    }
+
+    if( mode == MBEDTLS_RSA_PUBLIC )
+        return( mbedtls_rsa_public(  ctx, sig, sig ) );
+
+    /*
+     * In order to prevent Lenstra's attack, make the signature in a
+     * temporary buffer and check it before returning it.
+     */
+    sig_try = mbedtls_calloc( 1, ctx->len );
+    if( sig_try == NULL )
+        return( MBEDTLS_ERR_MPI_ALLOC_FAILED );
+
+    verif   = mbedtls_calloc( 1, ctx->len );
+    if( verif == NULL )
+    {
+        mbedtls_free( sig_try );
+        return( MBEDTLS_ERR_MPI_ALLOC_FAILED );
+    }
+
+    MBEDTLS_MPI_CHK( mbedtls_rsa_private( ctx, f_rng, p_rng, sig, sig_try ) );
+    MBEDTLS_MPI_CHK( mbedtls_rsa_public( ctx, sig_try, verif ) );
+
+    /* Compare in constant time just in case */
+    for( diff = 0, i = 0; i < ctx->len; i++ )
+        diff |= verif[i] ^ sig[i];
+    diff_no_optimize = diff;
+
+    if( diff_no_optimize != 0 )
+    {
+        ret = MBEDTLS_ERR_RSA_PRIVATE_FAILED;
+        goto cleanup;
+    }
+
+    memcpy( sig, sig_try, ctx->len );
+
+cleanup:
+    mbedtls_free( sig_try );
+    mbedtls_free( verif );
+
+    return( ret );
+}
+#endif /* MBEDTLS_PKCS1_V15 */
+
+/*
+ * Do an RSA operation to sign the message digest
+ */
+int mbedtls_rsa_pkcs1_sign( mbedtls_rsa_context *ctx,
+                    int (*f_rng)(void *, unsigned char *, size_t),
+                    void *p_rng,
+                    int mode,
+                    mbedtls_md_type_t md_alg,
+                    unsigned int hashlen,
+                    const unsigned char *hash,
+                    unsigned char *sig )
+{
+    switch( ctx->padding )
+    {
+#if defined(MBEDTLS_PKCS1_V15)
+        case MBEDTLS_RSA_PKCS_V15:
+            return mbedtls_rsa_rsassa_pkcs1_v15_sign( ctx, f_rng, p_rng, mode, md_alg,
+                                              hashlen, hash, sig );
+#endif
+
+#if defined(MBEDTLS_PKCS1_V21)
+        case MBEDTLS_RSA_PKCS_V21:
+            return mbedtls_rsa_rsassa_pss_sign( ctx, f_rng, p_rng, mode, md_alg,
+                                        hashlen, hash, sig );
+#endif
+
+        default:
+            return( MBEDTLS_ERR_RSA_INVALID_PADDING );
+    }
+}
+
+#if defined(MBEDTLS_PKCS1_V21)
+/*
+ * Implementation of the PKCS#1 v2.1 RSASSA-PSS-VERIFY function
+ */
+int mbedtls_rsa_rsassa_pss_verify_ext( mbedtls_rsa_context *ctx,
+                               int (*f_rng)(void *, unsigned char *, size_t),
+                               void *p_rng,
+                               int mode,
+                               mbedtls_md_type_t md_alg,
+                               unsigned int hashlen,
+                               const unsigned char *hash,
+                               mbedtls_md_type_t mgf1_hash_id,
+                               int expected_salt_len,
+                               const unsigned char *sig )
+{
+    int ret;
+    size_t siglen;
+    unsigned char *p;
+    unsigned char result[MBEDTLS_MD_MAX_SIZE];
+    unsigned char zeros[8];
+    unsigned int hlen;
+    size_t slen, msb;
+    const mbedtls_md_info_t *md_info;
+    mbedtls_md_context_t md_ctx;
+    unsigned char buf[MBEDTLS_MPI_MAX_SIZE];
+
+    if( mode == MBEDTLS_RSA_PRIVATE && ctx->padding != MBEDTLS_RSA_PKCS_V21 )
+        return( MBEDTLS_ERR_RSA_BAD_INPUT_DATA );
+
+    siglen = ctx->len;
+
+    if( siglen < 16 || siglen > sizeof( buf ) )
+        return( MBEDTLS_ERR_RSA_BAD_INPUT_DATA );
+
+    ret = ( mode == MBEDTLS_RSA_PUBLIC )
+          ? mbedtls_rsa_public(  ctx, sig, buf )
+          : mbedtls_rsa_private( ctx, f_rng, p_rng, sig, buf );
+
+    if( ret != 0 )
+        return( ret );
+
+    p = buf;
+
+    if( buf[siglen - 1] != 0xBC )
+        return( MBEDTLS_ERR_RSA_INVALID_PADDING );
+
+    if( md_alg != MBEDTLS_MD_NONE )
+    {
+        /* Gather length of hash to sign */
+        md_info = mbedtls_md_info_from_type( md_alg );
+        if( md_info == NULL )
+            return( MBEDTLS_ERR_RSA_BAD_INPUT_DATA );
+
+        hashlen = mbedtls_md_get_size( md_info );
+    }
+
+    md_info = mbedtls_md_info_from_type( mgf1_hash_id );
+    if( md_info == NULL )
+        return( MBEDTLS_ERR_RSA_BAD_INPUT_DATA );
+
+    hlen = mbedtls_md_get_size( md_info );
+    slen = siglen - hlen - 1; /* Currently length of salt + padding */
+
+    memset( zeros, 0, 8 );
+
+    /*
+     * Note: EMSA-PSS verification is over the length of N - 1 bits
+     */
+    msb = mbedtls_mpi_bitlen( &ctx->N ) - 1;
+
+    /* Compensate for boundary condition when applying mask */
+    if( msb % 8 == 0 )
+    {
+        p++;
+        siglen -= 1;
+    }
+    if( buf[0] >> ( 8 - siglen * 8 + msb ) )
+        return( MBEDTLS_ERR_RSA_BAD_INPUT_DATA );
+
+    mbedtls_md_init( &md_ctx );
+    if( ( ret = mbedtls_md_setup( &md_ctx, md_info, 0 ) ) != 0 )
+    {
+        mbedtls_md_free( &md_ctx );
+        return( ret );
+    }
+
+    mgf_mask( p, siglen - hlen - 1, p + siglen - hlen - 1, hlen, &md_ctx );
+
+    buf[0] &= 0xFF >> ( siglen * 8 - msb );
+
+    while( p < buf + siglen && *p == 0 )
+        p++;
+
+    if( p == buf + siglen ||
+        *p++ != 0x01 )
+    {
+        mbedtls_md_free( &md_ctx );
+        return( MBEDTLS_ERR_RSA_INVALID_PADDING );
+    }
+
+    /* Actual salt len */
+    slen -= p - buf;
+
+    if( expected_salt_len != MBEDTLS_RSA_SALT_LEN_ANY &&
+        slen != (size_t) expected_salt_len )
+    {
+        mbedtls_md_free( &md_ctx );
+        return( MBEDTLS_ERR_RSA_INVALID_PADDING );
+    }
+
+    /*
+     * Generate H = Hash( M' )
+     */
+    mbedtls_md_starts( &md_ctx );
+    mbedtls_md_update( &md_ctx, zeros, 8 );
+    mbedtls_md_update( &md_ctx, hash, hashlen );
+    mbedtls_md_update( &md_ctx, p, slen );
+    mbedtls_md_finish( &md_ctx, result );
+
+    mbedtls_md_free( &md_ctx );
+
+    if( memcmp( p + slen, result, hlen ) == 0 )
+        return( 0 );
+    else
+        return( MBEDTLS_ERR_RSA_VERIFY_FAILED );
+}
+
+/*
+ * Simplified PKCS#1 v2.1 RSASSA-PSS-VERIFY function
+ */
+int mbedtls_rsa_rsassa_pss_verify( mbedtls_rsa_context *ctx,
+                           int (*f_rng)(void *, unsigned char *, size_t),
+                           void *p_rng,
+                           int mode,
+                           mbedtls_md_type_t md_alg,
+                           unsigned int hashlen,
+                           const unsigned char *hash,
+                           const unsigned char *sig )
+{
+    mbedtls_md_type_t mgf1_hash_id = ( ctx->hash_id != MBEDTLS_MD_NONE )
+                             ? (mbedtls_md_type_t) ctx->hash_id
+                             : md_alg;
+
+    return( mbedtls_rsa_rsassa_pss_verify_ext( ctx, f_rng, p_rng, mode,
+                                       md_alg, hashlen, hash,
+                                       mgf1_hash_id, MBEDTLS_RSA_SALT_LEN_ANY,
+                                       sig ) );
+
+}
+#endif /* MBEDTLS_PKCS1_V21 */
+
+#if defined(MBEDTLS_PKCS1_V15)
+/*
+ * Implementation of the PKCS#1 v2.1 RSASSA-PKCS1-v1_5-VERIFY function
+ */
+int mbedtls_rsa_rsassa_pkcs1_v15_verify( mbedtls_rsa_context *ctx,
+                                 int (*f_rng)(void *, unsigned char *, size_t),
+                                 void *p_rng,
+                                 int mode,
+                                 mbedtls_md_type_t md_alg,
+                                 unsigned int hashlen,
+                                 const unsigned char *hash,
+                                 const unsigned char *sig )
+{
+    int ret;
+    size_t len, siglen, asn1_len;
+    unsigned char *p, *p0, *end;
+    mbedtls_md_type_t msg_md_alg;
+    const mbedtls_md_info_t *md_info;
+    mbedtls_asn1_buf oid;
+    unsigned char buf[MBEDTLS_MPI_MAX_SIZE];
+
+    if( mode == MBEDTLS_RSA_PRIVATE && ctx->padding != MBEDTLS_RSA_PKCS_V15 )
+        return( MBEDTLS_ERR_RSA_BAD_INPUT_DATA );
+
+    siglen = ctx->len;
+
+    if( siglen < 16 || siglen > sizeof( buf ) )
+        return( MBEDTLS_ERR_RSA_BAD_INPUT_DATA );
+
+    ret = ( mode == MBEDTLS_RSA_PUBLIC )
+          ? mbedtls_rsa_public(  ctx, sig, buf )
+          : mbedtls_rsa_private( ctx, f_rng, p_rng, sig, buf );
+
+    if( ret != 0 )
+        return( ret );
+
+    p = buf;
+
+    if( *p++ != 0 || *p++ != MBEDTLS_RSA_SIGN )
+        return( MBEDTLS_ERR_RSA_INVALID_PADDING );
+
+    while( *p != 0 )
+    {
+        if( p >= buf + siglen - 1 || *p != 0xFF )
+            return( MBEDTLS_ERR_RSA_INVALID_PADDING );
+        p++;
+    }
+    p++; /* skip 00 byte */
+
+    /* We've read: 00 01 PS 00 where PS must be at least 8 bytes */
+    if( p - buf < 11 )
+        return( MBEDTLS_ERR_RSA_INVALID_PADDING );
+
+    len = siglen - ( p - buf );
+
+    if( len == hashlen && md_alg == MBEDTLS_MD_NONE )
+    {
+        if( memcmp( p, hash, hashlen ) == 0 )
+            return( 0 );
+        else
+            return( MBEDTLS_ERR_RSA_VERIFY_FAILED );
+    }
+
+    md_info = mbedtls_md_info_from_type( md_alg );
+    if( md_info == NULL )
+        return( MBEDTLS_ERR_RSA_BAD_INPUT_DATA );
+    hashlen = mbedtls_md_get_size( md_info );
+
+    end = p + len;
+
+    /*
+     * Parse the ASN.1 structure inside the PKCS#1 v1.5 structure.
+     * Insist on 2-byte length tags, to protect against variants of
+     * Bleichenbacher's forgery attack against lax PKCS#1v1.5 verification.
+     */
+    p0 = p;
+    if( ( ret = mbedtls_asn1_get_tag( &p, end, &asn1_len,
+            MBEDTLS_ASN1_CONSTRUCTED | MBEDTLS_ASN1_SEQUENCE ) ) != 0 )
+        return( MBEDTLS_ERR_RSA_VERIFY_FAILED );
+    if( p != p0 + 2 || asn1_len + 2 != len )
+        return( MBEDTLS_ERR_RSA_VERIFY_FAILED );
+
+    p0 = p;
+    if( ( ret = mbedtls_asn1_get_tag( &p, end, &asn1_len,
+            MBEDTLS_ASN1_CONSTRUCTED | MBEDTLS_ASN1_SEQUENCE ) ) != 0 )
+        return( MBEDTLS_ERR_RSA_VERIFY_FAILED );
+    if( p != p0 + 2 || asn1_len + 6 + hashlen != len )
+        return( MBEDTLS_ERR_RSA_VERIFY_FAILED );
+
+    p0 = p;
+    if( ( ret = mbedtls_asn1_get_tag( &p, end, &oid.len, MBEDTLS_ASN1_OID ) ) != 0 )
+        return( MBEDTLS_ERR_RSA_VERIFY_FAILED );
+    if( p != p0 + 2 )
+        return( MBEDTLS_ERR_RSA_VERIFY_FAILED );
+
+    oid.p = p;
+    p += oid.len;
+
+    if( mbedtls_oid_get_md_alg( &oid, &msg_md_alg ) != 0 )
+        return( MBEDTLS_ERR_RSA_VERIFY_FAILED );
+
+    if( md_alg != msg_md_alg )
+        return( MBEDTLS_ERR_RSA_VERIFY_FAILED );
+
+    /*
+     * assume the algorithm parameters must be NULL
+     */
+    p0 = p;
+    if( ( ret = mbedtls_asn1_get_tag( &p, end, &asn1_len, MBEDTLS_ASN1_NULL ) ) != 0 )
+        return( MBEDTLS_ERR_RSA_VERIFY_FAILED );
+    if( p != p0 + 2 )
+        return( MBEDTLS_ERR_RSA_VERIFY_FAILED );
+
+    p0 = p;
+    if( ( ret = mbedtls_asn1_get_tag( &p, end, &asn1_len, MBEDTLS_ASN1_OCTET_STRING ) ) != 0 )
+        return( MBEDTLS_ERR_RSA_VERIFY_FAILED );
+    if( p != p0 + 2 || asn1_len != hashlen )
+        return( MBEDTLS_ERR_RSA_VERIFY_FAILED );
+
+    if( memcmp( p, hash, hashlen ) != 0 )
+        return( MBEDTLS_ERR_RSA_VERIFY_FAILED );
+
+    p += hashlen;
+
+    if( p != end )
+        return( MBEDTLS_ERR_RSA_VERIFY_FAILED );
+
+    return( 0 );
+}
+#endif /* MBEDTLS_PKCS1_V15 */
+
+/*
+ * Do an RSA operation and check the message digest
+ */
+int mbedtls_rsa_pkcs1_verify( mbedtls_rsa_context *ctx,
+                      int (*f_rng)(void *, unsigned char *, size_t),
+                      void *p_rng,
+                      int mode,
+                      mbedtls_md_type_t md_alg,
+                      unsigned int hashlen,
+                      const unsigned char *hash,
+                      const unsigned char *sig )
+{
+    switch( ctx->padding )
+    {
+#if defined(MBEDTLS_PKCS1_V15)
+        case MBEDTLS_RSA_PKCS_V15:
+            return mbedtls_rsa_rsassa_pkcs1_v15_verify( ctx, f_rng, p_rng, mode, md_alg,
+                                                hashlen, hash, sig );
+#endif
+
+#if defined(MBEDTLS_PKCS1_V21)
+        case MBEDTLS_RSA_PKCS_V21:
+            return mbedtls_rsa_rsassa_pss_verify( ctx, f_rng, p_rng, mode, md_alg,
+                                          hashlen, hash, sig );
+#endif
+
+        default:
+            return( MBEDTLS_ERR_RSA_INVALID_PADDING );
+    }
+}
+
+/*
+ * Copy the components of an RSA key
+ */
+int mbedtls_rsa_copy( mbedtls_rsa_context *dst, const mbedtls_rsa_context *src )
+{
+    int ret;
+
+    dst->ver = src->ver;
+    dst->len = src->len;
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_copy( &dst->N, &src->N ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_copy( &dst->E, &src->E ) );
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_copy( &dst->D, &src->D ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_copy( &dst->P, &src->P ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_copy( &dst->Q, &src->Q ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_copy( &dst->DP, &src->DP ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_copy( &dst->DQ, &src->DQ ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_copy( &dst->QP, &src->QP ) );
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_copy( &dst->RN, &src->RN ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_copy( &dst->RP, &src->RP ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_copy( &dst->RQ, &src->RQ ) );
+
+    MBEDTLS_MPI_CHK( mbedtls_mpi_copy( &dst->Vi, &src->Vi ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_copy( &dst->Vf, &src->Vf ) );
+
+    dst->padding = src->padding;
+    dst->hash_id = src->hash_id;
+
+cleanup:
+    if( ret != 0 )
+        mbedtls_rsa_free( dst );
+
+    return( ret );
+}
+
+/*
+ * Free the components of an RSA key
+ */
+void mbedtls_rsa_free( mbedtls_rsa_context *ctx )
+{
+    mbedtls_mpi_free( &ctx->Vi ); mbedtls_mpi_free( &ctx->Vf );
+    mbedtls_mpi_free( &ctx->RQ ); mbedtls_mpi_free( &ctx->RP ); mbedtls_mpi_free( &ctx->RN );
+    mbedtls_mpi_free( &ctx->QP ); mbedtls_mpi_free( &ctx->DQ ); mbedtls_mpi_free( &ctx->DP );
+    mbedtls_mpi_free( &ctx->Q  ); mbedtls_mpi_free( &ctx->P  ); mbedtls_mpi_free( &ctx->D );
+    mbedtls_mpi_free( &ctx->E  ); mbedtls_mpi_free( &ctx->N  );
+
+#if defined(MBEDTLS_THREADING_C)
+    mbedtls_mutex_free( &ctx->mutex );
+#endif
+}
+
+#if defined(MBEDTLS_SELF_TEST)
+
+#include "mbedtls/sha1.h"
+
+/*
+ * Example RSA-1024 keypair, for test purposes
+ */
+#define KEY_LEN 128
+
+#define RSA_N   "9292758453063D803DD603D5E777D788" \
+                "8ED1D5BF35786190FA2F23EBC0848AEA" \
+                "DDA92CA6C3D80B32C4D109BE0F36D6AE" \
+                "7130B9CED7ACDF54CFC7555AC14EEBAB" \
+                "93A89813FBF3C4F8066D2D800F7C38A8" \
+                "1AE31942917403FF4946B0A83D3D3E05" \
+                "EE57C6F5F5606FB5D4BC6CD34EE0801A" \
+                "5E94BB77B07507233A0BC7BAC8F90F79"
+
+#define RSA_E   "10001"
+
+#define RSA_D   "24BF6185468786FDD303083D25E64EFC" \
+                "66CA472BC44D253102F8B4A9D3BFA750" \
+                "91386C0077937FE33FA3252D28855837" \
+                "AE1B484A8A9A45F7EE8C0C634F99E8CD" \
+                "DF79C5CE07EE72C7F123142198164234" \
+                "CABB724CF78B8173B9F880FC86322407" \
+                "AF1FEDFDDE2BEB674CA15F3E81A1521E" \
+                "071513A1E85B5DFA031F21ECAE91A34D"
+
+#define RSA_P   "C36D0EB7FCD285223CFB5AABA5BDA3D8" \
+                "2C01CAD19EA484A87EA4377637E75500" \
+                "FCB2005C5C7DD6EC4AC023CDA285D796" \
+                "C3D9E75E1EFC42488BB4F1D13AC30A57"
+
+#define RSA_Q   "C000DF51A7C77AE8D7C7370C1FF55B69" \
+                "E211C2B9E5DB1ED0BF61D0D9899620F4" \
+                "910E4168387E3C30AA1E00C339A79508" \
+                "8452DD96A9A5EA5D9DCA68DA636032AF"
+
+#define RSA_DP  "C1ACF567564274FB07A0BBAD5D26E298" \
+                "3C94D22288ACD763FD8E5600ED4A702D" \
+                "F84198A5F06C2E72236AE490C93F07F8" \
+                "3CC559CD27BC2D1CA488811730BB5725"
+
+#define RSA_DQ  "4959CBF6F8FEF750AEE6977C155579C7" \
+                "D8AAEA56749EA28623272E4F7D0592AF" \
+                "7C1F1313CAC9471B5C523BFE592F517B" \
+                "407A1BD76C164B93DA2D32A383E58357"
+
+#define RSA_QP  "9AE7FBC99546432DF71896FC239EADAE" \
+                "F38D18D2B2F0E2DD275AA977E2BF4411" \
+                "F5A3B2A5D33605AEBBCCBA7FEB9F2D2F" \
+                "A74206CEC169D74BF5A8C50D6F48EA08"
+
+#define PT_LEN  24
+#define RSA_PT  "\xAA\xBB\xCC\x03\x02\x01\x00\xFF\xFF\xFF\xFF\xFF" \
+                "\x11\x22\x33\x0A\x0B\x0C\xCC\xDD\xDD\xDD\xDD\xDD"
+
+#if defined(MBEDTLS_PKCS1_V15)
+static int myrand( void *rng_state, unsigned char *output, size_t len )
+{
+#if !defined(__OpenBSD__)
+    size_t i;
+
+    if( rng_state != NULL )
+        rng_state  = NULL;
+
+    for( i = 0; i < len; ++i )
+        output[i] = rand();
+#else
+    if( rng_state != NULL )
+        rng_state = NULL;
+
+    arc4random_buf( output, len );
+#endif /* !OpenBSD */
+
+    return( 0 );
+}
+#endif /* MBEDTLS_PKCS1_V15 */
+
+/*
+ * Checkup routine
+ */
+int mbedtls_rsa_self_test( int verbose )
+{
+    int ret = 0;
+#if defined(MBEDTLS_PKCS1_V15)
+    size_t len;
+    mbedtls_rsa_context rsa;
+    unsigned char rsa_plaintext[PT_LEN];
+    unsigned char rsa_decrypted[PT_LEN];
+    unsigned char rsa_ciphertext[KEY_LEN];
+#if defined(MBEDTLS_SHA1_C)
+    unsigned char sha1sum[20];
+#endif
+
+    mbedtls_rsa_init( &rsa, MBEDTLS_RSA_PKCS_V15, 0 );
+
+    rsa.len = KEY_LEN;
+    MBEDTLS_MPI_CHK( mbedtls_mpi_read_string( &rsa.N , 16, RSA_N  ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_read_string( &rsa.E , 16, RSA_E  ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_read_string( &rsa.D , 16, RSA_D  ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_read_string( &rsa.P , 16, RSA_P  ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_read_string( &rsa.Q , 16, RSA_Q  ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_read_string( &rsa.DP, 16, RSA_DP ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_read_string( &rsa.DQ, 16, RSA_DQ ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_read_string( &rsa.QP, 16, RSA_QP ) );
+
+    if( verbose != 0 )
+        mbedtls_printf( "  RSA key validation: " );
+
+    if( mbedtls_rsa_check_pubkey(  &rsa ) != 0 ||
+        mbedtls_rsa_check_privkey( &rsa ) != 0 )
+    {
+        if( verbose != 0 )
+            mbedtls_printf( "failed\n" );
+
+        return( 1 );
+    }
+
+    if( verbose != 0 )
+        mbedtls_printf( "passed\n  PKCS#1 encryption : " );
+
+    memcpy( rsa_plaintext, RSA_PT, PT_LEN );
+
+    if( mbedtls_rsa_pkcs1_encrypt( &rsa, myrand, NULL, MBEDTLS_RSA_PUBLIC, PT_LEN,
+                           rsa_plaintext, rsa_ciphertext ) != 0 )
+    {
+        if( verbose != 0 )
+            mbedtls_printf( "failed\n" );
+
+        return( 1 );
+    }
+
+    if( verbose != 0 )
+        mbedtls_printf( "passed\n  PKCS#1 decryption : " );
+
+    if( mbedtls_rsa_pkcs1_decrypt( &rsa, myrand, NULL, MBEDTLS_RSA_PRIVATE, &len,
+                           rsa_ciphertext, rsa_decrypted,
+                           sizeof(rsa_decrypted) ) != 0 )
+    {
+        if( verbose != 0 )
+            mbedtls_printf( "failed\n" );
+
+        return( 1 );
+    }
+
+    if( memcmp( rsa_decrypted, rsa_plaintext, len ) != 0 )
+    {
+        if( verbose != 0 )
+            mbedtls_printf( "failed\n" );
+
+        return( 1 );
+    }
+
+    if( verbose != 0 )
+        mbedtls_printf( "passed\n" );
+
+#if defined(MBEDTLS_SHA1_C)
+    if( verbose != 0 )
+        mbedtls_printf( "  PKCS#1 data sign  : " );
+
+    mbedtls_sha1( rsa_plaintext, PT_LEN, sha1sum );
+
+    if( mbedtls_rsa_pkcs1_sign( &rsa, myrand, NULL, MBEDTLS_RSA_PRIVATE, MBEDTLS_MD_SHA1, 0,
+                        sha1sum, rsa_ciphertext ) != 0 )
+    {
+        if( verbose != 0 )
+            mbedtls_printf( "failed\n" );
+
+        return( 1 );
+    }
+
+    if( verbose != 0 )
+        mbedtls_printf( "passed\n  PKCS#1 sig. verify: " );
+
+    if( mbedtls_rsa_pkcs1_verify( &rsa, NULL, NULL, MBEDTLS_RSA_PUBLIC, MBEDTLS_MD_SHA1, 0,
+                          sha1sum, rsa_ciphertext ) != 0 )
+    {
+        if( verbose != 0 )
+            mbedtls_printf( "failed\n" );
+
+        return( 1 );
+    }
+
+    if( verbose != 0 )
+        mbedtls_printf( "passed\n" );
+#endif /* MBEDTLS_SHA1_C */
+
+    if( verbose != 0 )
+        mbedtls_printf( "\n" );
+
+cleanup:
+    mbedtls_rsa_free( &rsa );
+#else /* MBEDTLS_PKCS1_V15 */
+    ((void) verbose);
+#endif /* MBEDTLS_PKCS1_V15 */
+    return( ret );
+}
+
+#endif /* MBEDTLS_SELF_TEST */
+
+#endif /* MBEDTLS_RSA_C */
diff --git a/backport/compat/verification/rsapubkey-asn1.c b/backport/compat/verification/rsapubkey-asn1.c
new file mode 100644
index 000000000000..84ab7f4e47ec
--- /dev/null
+++ b/backport/compat/verification/rsapubkey-asn1.c
@@ -0,0 +1,38 @@
+/*
+ * Automatically generated by asn1_compiler.  Do not edit
+ *
+ * ASN.1 parser for rsapubkey
+ */
+#include <linux/asn1_ber_bytecode.h>
+#include "rsapubkey-asn1.h"
+
+enum rsapubkey_actions {
+	ACT_rsa_get_e = 0,
+	ACT_rsa_get_n = 1,
+	NR__rsapubkey_actions = 2
+};
+
+static const asn1_action_t rsapubkey_action_table[NR__rsapubkey_actions] = {
+	[   0] = rsa_get_e,
+	[   1] = rsa_get_n,
+};
+
+static const unsigned char rsapubkey_machine[] = {
+	// RsaPubKey
+	[   0] = ASN1_OP_MATCH,
+	[   1] = _tag(UNIV, CONS, SEQ),
+	[   2] =  ASN1_OP_MATCH_ACT,		// n
+	[   3] =  _tag(UNIV, PRIM, INT),
+	[   4] =  _action(ACT_rsa_get_n),
+	[   5] =  ASN1_OP_MATCH_ACT,		// e
+	[   6] =  _tag(UNIV, PRIM, INT),
+	[   7] =  _action(ACT_rsa_get_e),
+	[   8] = ASN1_OP_END_SEQ,
+	[   9] = ASN1_OP_COMPLETE,
+};
+
+const struct asn1_decoder rsapubkey_decoder = {
+	.machine = rsapubkey_machine,
+	.machlen = sizeof(rsapubkey_machine),
+	.actions = rsapubkey_action_table,
+};
diff --git a/backport/compat/verification/rsapubkey-asn1.h b/backport/compat/verification/rsapubkey-asn1.h
new file mode 100644
index 000000000000..81a82d40aa27
--- /dev/null
+++ b/backport/compat/verification/rsapubkey-asn1.h
@@ -0,0 +1,15 @@
+/*
+ * Automatically generated by asn1_compiler.  Do not edit
+ *
+ * ASN.1 parser for rsapubkey
+ */
+#include <linux/asn1_decoder.h>
+
+extern const struct asn1_decoder rsapubkey_decoder;
+
+#define rsa_get_e LINUX_BACKPORT(rsa_get_e)
+#define rsa_get_n LINUX_BACKPORT(rsa_get_n)
+
+extern int rsa_get_e(void *, size_t, unsigned char, const void *, size_t);
+extern int rsa_get_n(void *, size_t, unsigned char, const void *, size_t);
+
diff --git a/backport/compat/verification/sha256.c b/backport/compat/verification/sha256.c
new file mode 100644
index 000000000000..52fedf6a621a
--- /dev/null
+++ b/backport/compat/verification/sha256.c
@@ -0,0 +1,458 @@
+/*
+ *  FIPS-180-2 compliant SHA-256 implementation
+ *
+ *  Copyright (C) 2006-2015, ARM Limited, All Rights Reserved
+ *  SPDX-License-Identifier: GPL-2.0
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ *  This file is part of mbed TLS (https://tls.mbed.org)
+ */
+/*
+ *  The SHA-256 Secure Hash Standard was published by NIST in 2002.
+ *
+ *  http://csrc.nist.gov/publications/fips/fips180-2/fips180-2.pdf
+ */
+
+#if !defined(MBEDTLS_CONFIG_FILE)
+#include "mbedtls/config.h"
+#else
+#include MBEDTLS_CONFIG_FILE
+#endif
+
+#if defined(MBEDTLS_SHA256_C)
+
+#include "mbedtls/sha256.h"
+
+#if defined(MBEDTLS_SELF_TEST)
+#if defined(MBEDTLS_PLATFORM_C)
+#include "mbedtls/platform.h"
+#else
+#include <stdio.h>
+#include <stdlib.h>
+#define mbedtls_printf printf
+#define mbedtls_calloc    calloc
+#define mbedtls_free       free
+#endif /* MBEDTLS_PLATFORM_C */
+#endif /* MBEDTLS_SELF_TEST */
+
+#if !defined(MBEDTLS_SHA256_ALT)
+
+/* Implementation that should never be optimized out by the compiler */
+static void mbedtls_zeroize( void *v, size_t n ) {
+    volatile unsigned char *p = v; while( n-- ) *p++ = 0;
+}
+
+/*
+ * 32-bit integer manipulation macros (big endian)
+ */
+#ifndef GET_UINT32_BE
+#define GET_UINT32_BE(n,b,i)                            \
+do {                                                    \
+    (n) = ( (uint32_t) (b)[(i)    ] << 24 )             \
+        | ( (uint32_t) (b)[(i) + 1] << 16 )             \
+        | ( (uint32_t) (b)[(i) + 2] <<  8 )             \
+        | ( (uint32_t) (b)[(i) + 3]       );            \
+} while( 0 )
+#endif
+
+#ifndef PUT_UINT32_BE
+#define PUT_UINT32_BE(n,b,i)                            \
+do {                                                    \
+    (b)[(i)    ] = (unsigned char) ( (n) >> 24 );       \
+    (b)[(i) + 1] = (unsigned char) ( (n) >> 16 );       \
+    (b)[(i) + 2] = (unsigned char) ( (n) >>  8 );       \
+    (b)[(i) + 3] = (unsigned char) ( (n)       );       \
+} while( 0 )
+#endif
+
+void mbedtls_sha256_init( mbedtls_sha256_context *ctx )
+{
+    memset( ctx, 0, sizeof( mbedtls_sha256_context ) );
+}
+
+void mbedtls_sha256_free( mbedtls_sha256_context *ctx )
+{
+    if( ctx == NULL )
+        return;
+
+    mbedtls_zeroize( ctx, sizeof( mbedtls_sha256_context ) );
+}
+
+void mbedtls_sha256_clone( mbedtls_sha256_context *dst,
+                           const mbedtls_sha256_context *src )
+{
+    *dst = *src;
+}
+
+/*
+ * SHA-256 context setup
+ */
+void mbedtls_sha256_starts( mbedtls_sha256_context *ctx, int is224 )
+{
+    ctx->total[0] = 0;
+    ctx->total[1] = 0;
+
+    if( is224 == 0 )
+    {
+        /* SHA-256 */
+        ctx->state[0] = 0x6A09E667;
+        ctx->state[1] = 0xBB67AE85;
+        ctx->state[2] = 0x3C6EF372;
+        ctx->state[3] = 0xA54FF53A;
+        ctx->state[4] = 0x510E527F;
+        ctx->state[5] = 0x9B05688C;
+        ctx->state[6] = 0x1F83D9AB;
+        ctx->state[7] = 0x5BE0CD19;
+    }
+    else
+    {
+        /* SHA-224 */
+        ctx->state[0] = 0xC1059ED8;
+        ctx->state[1] = 0x367CD507;
+        ctx->state[2] = 0x3070DD17;
+        ctx->state[3] = 0xF70E5939;
+        ctx->state[4] = 0xFFC00B31;
+        ctx->state[5] = 0x68581511;
+        ctx->state[6] = 0x64F98FA7;
+        ctx->state[7] = 0xBEFA4FA4;
+    }
+
+    ctx->is224 = is224;
+}
+
+#if !defined(MBEDTLS_SHA256_PROCESS_ALT)
+static const uint32_t K[] =
+{
+    0x428A2F98, 0x71374491, 0xB5C0FBCF, 0xE9B5DBA5,
+    0x3956C25B, 0x59F111F1, 0x923F82A4, 0xAB1C5ED5,
+    0xD807AA98, 0x12835B01, 0x243185BE, 0x550C7DC3,
+    0x72BE5D74, 0x80DEB1FE, 0x9BDC06A7, 0xC19BF174,
+    0xE49B69C1, 0xEFBE4786, 0x0FC19DC6, 0x240CA1CC,
+    0x2DE92C6F, 0x4A7484AA, 0x5CB0A9DC, 0x76F988DA,
+    0x983E5152, 0xA831C66D, 0xB00327C8, 0xBF597FC7,
+    0xC6E00BF3, 0xD5A79147, 0x06CA6351, 0x14292967,
+    0x27B70A85, 0x2E1B2138, 0x4D2C6DFC, 0x53380D13,
+    0x650A7354, 0x766A0ABB, 0x81C2C92E, 0x92722C85,
+    0xA2BFE8A1, 0xA81A664B, 0xC24B8B70, 0xC76C51A3,
+    0xD192E819, 0xD6990624, 0xF40E3585, 0x106AA070,
+    0x19A4C116, 0x1E376C08, 0x2748774C, 0x34B0BCB5,
+    0x391C0CB3, 0x4ED8AA4A, 0x5B9CCA4F, 0x682E6FF3,
+    0x748F82EE, 0x78A5636F, 0x84C87814, 0x8CC70208,
+    0x90BEFFFA, 0xA4506CEB, 0xBEF9A3F7, 0xC67178F2,
+};
+
+#define  SHR(x,n) ((x & 0xFFFFFFFF) >> n)
+#define ROTR(x,n) (SHR(x,n) | (x << (32 - n)))
+
+#define S0(x) (ROTR(x, 7) ^ ROTR(x,18) ^  SHR(x, 3))
+#define S1(x) (ROTR(x,17) ^ ROTR(x,19) ^  SHR(x,10))
+
+#define S2(x) (ROTR(x, 2) ^ ROTR(x,13) ^ ROTR(x,22))
+#define S3(x) (ROTR(x, 6) ^ ROTR(x,11) ^ ROTR(x,25))
+
+#define F0(x,y,z) ((x & y) | (z & (x | y)))
+#define F1(x,y,z) (z ^ (x & (y ^ z)))
+
+#define R(t)                                    \
+(                                               \
+    W[t] = S1(W[t -  2]) + W[t -  7] +          \
+           S0(W[t - 15]) + W[t - 16]            \
+)
+
+#define P(a,b,c,d,e,f,g,h,x,K)                  \
+{                                               \
+    temp1 = h + S3(e) + F1(e,f,g) + K + x;      \
+    temp2 = S2(a) + F0(a,b,c);                  \
+    d += temp1; h = temp1 + temp2;              \
+}
+
+void mbedtls_sha256_process( mbedtls_sha256_context *ctx, const unsigned char data[64] )
+{
+    uint32_t temp1, temp2, W[64];
+    uint32_t A[8];
+    unsigned int i;
+
+    for( i = 0; i < 8; i++ )
+        A[i] = ctx->state[i];
+
+#if defined(MBEDTLS_SHA256_SMALLER)
+    for( i = 0; i < 64; i++ )
+    {
+        if( i < 16 )
+            GET_UINT32_BE( W[i], data, 4 * i );
+        else
+            R( i );
+
+        P( A[0], A[1], A[2], A[3], A[4], A[5], A[6], A[7], W[i], K[i] );
+
+        temp1 = A[7]; A[7] = A[6]; A[6] = A[5]; A[5] = A[4]; A[4] = A[3];
+        A[3] = A[2]; A[2] = A[1]; A[1] = A[0]; A[0] = temp1;
+    }
+#else /* MBEDTLS_SHA256_SMALLER */
+    for( i = 0; i < 16; i++ )
+        GET_UINT32_BE( W[i], data, 4 * i );
+
+    for( i = 0; i < 16; i += 8 )
+    {
+        P( A[0], A[1], A[2], A[3], A[4], A[5], A[6], A[7], W[i+0], K[i+0] );
+        P( A[7], A[0], A[1], A[2], A[3], A[4], A[5], A[6], W[i+1], K[i+1] );
+        P( A[6], A[7], A[0], A[1], A[2], A[3], A[4], A[5], W[i+2], K[i+2] );
+        P( A[5], A[6], A[7], A[0], A[1], A[2], A[3], A[4], W[i+3], K[i+3] );
+        P( A[4], A[5], A[6], A[7], A[0], A[1], A[2], A[3], W[i+4], K[i+4] );
+        P( A[3], A[4], A[5], A[6], A[7], A[0], A[1], A[2], W[i+5], K[i+5] );
+        P( A[2], A[3], A[4], A[5], A[6], A[7], A[0], A[1], W[i+6], K[i+6] );
+        P( A[1], A[2], A[3], A[4], A[5], A[6], A[7], A[0], W[i+7], K[i+7] );
+    }
+
+    for( i = 16; i < 64; i += 8 )
+    {
+        P( A[0], A[1], A[2], A[3], A[4], A[5], A[6], A[7], R(i+0), K[i+0] );
+        P( A[7], A[0], A[1], A[2], A[3], A[4], A[5], A[6], R(i+1), K[i+1] );
+        P( A[6], A[7], A[0], A[1], A[2], A[3], A[4], A[5], R(i+2), K[i+2] );
+        P( A[5], A[6], A[7], A[0], A[1], A[2], A[3], A[4], R(i+3), K[i+3] );
+        P( A[4], A[5], A[6], A[7], A[0], A[1], A[2], A[3], R(i+4), K[i+4] );
+        P( A[3], A[4], A[5], A[6], A[7], A[0], A[1], A[2], R(i+5), K[i+5] );
+        P( A[2], A[3], A[4], A[5], A[6], A[7], A[0], A[1], R(i+6), K[i+6] );
+        P( A[1], A[2], A[3], A[4], A[5], A[6], A[7], A[0], R(i+7), K[i+7] );
+    }
+#endif /* MBEDTLS_SHA256_SMALLER */
+
+    for( i = 0; i < 8; i++ )
+        ctx->state[i] += A[i];
+}
+#endif /* !MBEDTLS_SHA256_PROCESS_ALT */
+
+/*
+ * SHA-256 process buffer
+ */
+void mbedtls_sha256_update( mbedtls_sha256_context *ctx, const unsigned char *input,
+                    size_t ilen )
+{
+    size_t fill;
+    uint32_t left;
+
+    if( ilen == 0 )
+        return;
+
+    left = ctx->total[0] & 0x3F;
+    fill = 64 - left;
+
+    ctx->total[0] += (uint32_t) ilen;
+    ctx->total[0] &= 0xFFFFFFFF;
+
+    if( ctx->total[0] < (uint32_t) ilen )
+        ctx->total[1]++;
+
+    if( left && ilen >= fill )
+    {
+        memcpy( (void *) (ctx->buffer + left), input, fill );
+        mbedtls_sha256_process( ctx, ctx->buffer );
+        input += fill;
+        ilen  -= fill;
+        left = 0;
+    }
+
+    while( ilen >= 64 )
+    {
+        mbedtls_sha256_process( ctx, input );
+        input += 64;
+        ilen  -= 64;
+    }
+
+    if( ilen > 0 )
+        memcpy( (void *) (ctx->buffer + left), input, ilen );
+}
+
+static const unsigned char sha256_padding[64] =
+{
+ 0x80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
+};
+
+/*
+ * SHA-256 final digest
+ */
+void mbedtls_sha256_finish( mbedtls_sha256_context *ctx, unsigned char output[32] )
+{
+    uint32_t last, padn;
+    uint32_t high, low;
+    unsigned char msglen[8];
+
+    high = ( ctx->total[0] >> 29 )
+         | ( ctx->total[1] <<  3 );
+    low  = ( ctx->total[0] <<  3 );
+
+    PUT_UINT32_BE( high, msglen, 0 );
+    PUT_UINT32_BE( low,  msglen, 4 );
+
+    last = ctx->total[0] & 0x3F;
+    padn = ( last < 56 ) ? ( 56 - last ) : ( 120 - last );
+
+    mbedtls_sha256_update( ctx, sha256_padding, padn );
+    mbedtls_sha256_update( ctx, msglen, 8 );
+
+    PUT_UINT32_BE( ctx->state[0], output,  0 );
+    PUT_UINT32_BE( ctx->state[1], output,  4 );
+    PUT_UINT32_BE( ctx->state[2], output,  8 );
+    PUT_UINT32_BE( ctx->state[3], output, 12 );
+    PUT_UINT32_BE( ctx->state[4], output, 16 );
+    PUT_UINT32_BE( ctx->state[5], output, 20 );
+    PUT_UINT32_BE( ctx->state[6], output, 24 );
+
+    if( ctx->is224 == 0 )
+        PUT_UINT32_BE( ctx->state[7], output, 28 );
+}
+
+#endif /* !MBEDTLS_SHA256_ALT */
+
+/*
+ * output = SHA-256( input buffer )
+ */
+void mbedtls_sha256( const unsigned char *input, size_t ilen,
+             unsigned char output[32], int is224 )
+{
+    mbedtls_sha256_context ctx;
+
+    mbedtls_sha256_init( &ctx );
+    mbedtls_sha256_starts( &ctx, is224 );
+    mbedtls_sha256_update( &ctx, input, ilen );
+    mbedtls_sha256_finish( &ctx, output );
+    mbedtls_sha256_free( &ctx );
+}
+
+#if defined(MBEDTLS_SELF_TEST)
+/*
+ * FIPS-180-2 test vectors
+ */
+static const unsigned char sha256_test_buf[3][57] =
+{
+    { "abc" },
+    { "abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq" },
+    { "" }
+};
+
+static const int sha256_test_buflen[3] =
+{
+    3, 56, 1000
+};
+
+static const unsigned char sha256_test_sum[6][32] =
+{
+    /*
+     * SHA-224 test vectors
+     */
+    { 0x23, 0x09, 0x7D, 0x22, 0x34, 0x05, 0xD8, 0x22,
+      0x86, 0x42, 0xA4, 0x77, 0xBD, 0xA2, 0x55, 0xB3,
+      0x2A, 0xAD, 0xBC, 0xE4, 0xBD, 0xA0, 0xB3, 0xF7,
+      0xE3, 0x6C, 0x9D, 0xA7 },
+    { 0x75, 0x38, 0x8B, 0x16, 0x51, 0x27, 0x76, 0xCC,
+      0x5D, 0xBA, 0x5D, 0xA1, 0xFD, 0x89, 0x01, 0x50,
+      0xB0, 0xC6, 0x45, 0x5C, 0xB4, 0xF5, 0x8B, 0x19,
+      0x52, 0x52, 0x25, 0x25 },
+    { 0x20, 0x79, 0x46, 0x55, 0x98, 0x0C, 0x91, 0xD8,
+      0xBB, 0xB4, 0xC1, 0xEA, 0x97, 0x61, 0x8A, 0x4B,
+      0xF0, 0x3F, 0x42, 0x58, 0x19, 0x48, 0xB2, 0xEE,
+      0x4E, 0xE7, 0xAD, 0x67 },
+
+    /*
+     * SHA-256 test vectors
+     */
+    { 0xBA, 0x78, 0x16, 0xBF, 0x8F, 0x01, 0xCF, 0xEA,
+      0x41, 0x41, 0x40, 0xDE, 0x5D, 0xAE, 0x22, 0x23,
+      0xB0, 0x03, 0x61, 0xA3, 0x96, 0x17, 0x7A, 0x9C,
+      0xB4, 0x10, 0xFF, 0x61, 0xF2, 0x00, 0x15, 0xAD },
+    { 0x24, 0x8D, 0x6A, 0x61, 0xD2, 0x06, 0x38, 0xB8,
+      0xE5, 0xC0, 0x26, 0x93, 0x0C, 0x3E, 0x60, 0x39,
+      0xA3, 0x3C, 0xE4, 0x59, 0x64, 0xFF, 0x21, 0x67,
+      0xF6, 0xEC, 0xED, 0xD4, 0x19, 0xDB, 0x06, 0xC1 },
+    { 0xCD, 0xC7, 0x6E, 0x5C, 0x99, 0x14, 0xFB, 0x92,
+      0x81, 0xA1, 0xC7, 0xE2, 0x84, 0xD7, 0x3E, 0x67,
+      0xF1, 0x80, 0x9A, 0x48, 0xA4, 0x97, 0x20, 0x0E,
+      0x04, 0x6D, 0x39, 0xCC, 0xC7, 0x11, 0x2C, 0xD0 }
+};
+
+/*
+ * Checkup routine
+ */
+int mbedtls_sha256_self_test( int verbose )
+{
+    int i, j, k, buflen, ret = 0;
+    unsigned char *buf;
+    unsigned char sha256sum[32];
+    mbedtls_sha256_context ctx;
+
+    buf = mbedtls_calloc( 1024, sizeof(unsigned char) );
+    if( NULL == buf )
+    {
+        if( verbose != 0 )
+            mbedtls_printf( "Buffer allocation failed\n" );
+
+        return( 1 );
+    }
+
+    mbedtls_sha256_init( &ctx );
+
+    for( i = 0; i < 6; i++ )
+    {
+        j = i % 3;
+        k = i < 3;
+
+        if( verbose != 0 )
+            mbedtls_printf( "  SHA-%d test #%d: ", 256 - k * 32, j + 1 );
+
+        mbedtls_sha256_starts( &ctx, k );
+
+        if( j == 2 )
+        {
+            memset( buf, 'a', buflen = 1000 );
+
+            for( j = 0; j < 1000; j++ )
+                mbedtls_sha256_update( &ctx, buf, buflen );
+        }
+        else
+            mbedtls_sha256_update( &ctx, sha256_test_buf[j],
+                                 sha256_test_buflen[j] );
+
+        mbedtls_sha256_finish( &ctx, sha256sum );
+
+        if( memcmp( sha256sum, sha256_test_sum[i], 32 - k * 4 ) != 0 )
+        {
+            if( verbose != 0 )
+                mbedtls_printf( "failed\n" );
+
+            ret = 1;
+            goto exit;
+        }
+
+        if( verbose != 0 )
+            mbedtls_printf( "passed\n" );
+    }
+
+    if( verbose != 0 )
+        mbedtls_printf( "\n" );
+
+exit:
+    mbedtls_sha256_free( &ctx );
+    mbedtls_free( buf );
+
+    return( ret );
+}
+
+#endif /* MBEDTLS_SELF_TEST */
+
+#endif /* MBEDTLS_SHA256_C */
diff --git a/backport/compat/verification/verify.c b/backport/compat/verification/verify.c
new file mode 100644
index 000000000000..6f686a636118
--- /dev/null
+++ b/backport/compat/verification/verify.c
@@ -0,0 +1,65 @@
+#include <linux/kernel.h>
+#include <linux/bug.h>
+#include <linux/verification.h>
+#include <linux/export.h>
+#include <linux/err.h>
+#include <crypto/pkcs7.h>
+
+int verify_pkcs7_signature(const void *data, size_t len,
+			   const void *raw_pkcs7, size_t pkcs7_len,
+			   struct key *trusted_keys,
+			   enum key_being_used_for usage,
+			   int (*view_content)(void *ctx,
+					       const void *data, size_t len,
+					       size_t asn1hdrlen),
+			   void *ctx)
+{
+	struct pkcs7_message *pkcs7;
+	int ret;
+
+	pkcs7 = pkcs7_parse_message(raw_pkcs7, pkcs7_len);
+	if (IS_ERR(pkcs7))
+		return PTR_ERR(pkcs7);
+
+	/* The data should be detached - so we need to supply it. */
+	if (data && pkcs7_supply_detached_data(pkcs7, data, len) < 0) {
+		pr_err("PKCS#7 signature with non-detached data\n");
+		ret = -EBADMSG;
+		goto error;
+	}
+
+	ret = pkcs7_verify(pkcs7, usage);
+	if (ret < 0)
+		goto error;
+
+	if (WARN_ON(!trusted_keys)) {
+		ret = -EINVAL;
+		goto error;
+	}
+
+	ret = pkcs7_validate_trust(pkcs7, trusted_keys);
+	if (ret < 0) {
+		if (ret == -ENOKEY)
+			pr_err("PKCS#7 signature not signed with a trusted key\n");
+		goto error;
+	}
+
+	if (view_content) {
+		size_t asn1hdrlen;
+
+		ret = pkcs7_get_content_data(pkcs7, &data, &len, &asn1hdrlen);
+		if (ret < 0) {
+			if (ret == -ENODATA)
+				pr_devel("PKCS#7 message does not contain data\n");
+			goto error;
+		}
+
+		ret = view_content(ctx, data, len, asn1hdrlen);
+	}
+
+error:
+	pkcs7_free_message(pkcs7);
+	pr_devel("<==%s() = %d\n", __func__, ret);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(verify_pkcs7_signature);
diff --git a/backport/compat/verification/x509-asn1.c b/backport/compat/verification/x509-asn1.c
new file mode 100644
index 000000000000..89aaa6620a47
--- /dev/null
+++ b/backport/compat/verification/x509-asn1.c
@@ -0,0 +1,182 @@
+/*
+ * Automatically generated by asn1_compiler.  Do not edit
+ *
+ * ASN.1 parser for x509
+ */
+#include <linux/asn1_ber_bytecode.h>
+#include "x509-asn1.h"
+
+enum x509_actions {
+	ACT_x509_extract_key_data = 0,
+	ACT_x509_extract_name_segment = 1,
+	ACT_x509_note_OID = 2,
+	ACT_x509_note_issuer = 3,
+	ACT_x509_note_not_after = 4,
+	ACT_x509_note_not_before = 5,
+	ACT_x509_note_pkey_algo = 6,
+	ACT_x509_note_serial = 7,
+	ACT_x509_note_signature = 8,
+	ACT_x509_note_subject = 9,
+	ACT_x509_note_tbs_certificate = 10,
+	ACT_x509_process_extension = 11,
+	NR__x509_actions = 12
+};
+
+static const asn1_action_t x509_action_table[NR__x509_actions] = {
+	[   0] = x509_extract_key_data,
+	[   1] = x509_extract_name_segment,
+	[   2] = x509_note_OID,
+	[   3] = x509_note_issuer,
+	[   4] = x509_note_not_after,
+	[   5] = x509_note_not_before,
+	[   6] = x509_note_pkey_algo,
+	[   7] = x509_note_serial,
+	[   8] = x509_note_signature,
+	[   9] = x509_note_subject,
+	[  10] = x509_note_tbs_certificate,
+	[  11] = x509_process_extension,
+};
+
+static const unsigned char x509_machine[] = {
+	// Certificate
+	[   0] = ASN1_OP_MATCH,
+	[   1] = _tag(UNIV, CONS, SEQ),
+	// TBSCertificate
+	[   2] =  ASN1_OP_MATCH,
+	[   3] =  _tag(UNIV, CONS, SEQ),
+	[   4] =   ASN1_OP_MATCH_JUMP_OR_SKIP,		// version
+	[   5] =   _tagn(CONT, CONS,  0),
+	[   6] =   _jump_target(70),
+	// CertificateSerialNumber
+	[   7] =   ASN1_OP_MATCH,
+	[   8] =   _tag(UNIV, PRIM, INT),
+	[   9] =   ASN1_OP_ACT,
+	[  10] =   _action(ACT_x509_note_serial),
+	// AlgorithmIdentifier
+	[  11] =   ASN1_OP_MATCH_JUMP,
+	[  12] =   _tag(UNIV, CONS, SEQ),
+	[  13] =   _jump_target(74),		// --> AlgorithmIdentifier
+	[  14] =   ASN1_OP_ACT,
+	[  15] =   _action(ACT_x509_note_pkey_algo),
+	// Name
+	[  16] =   ASN1_OP_MATCH_JUMP,
+	[  17] =   _tag(UNIV, CONS, SEQ),
+	[  18] =   _jump_target(80),		// --> Name
+	[  19] =   ASN1_OP_ACT,
+	[  20] =   _action(ACT_x509_note_issuer),
+	// Validity
+	[  21] =   ASN1_OP_MATCH,
+	[  22] =   _tag(UNIV, CONS, SEQ),
+	// Time
+	[  23] =    ASN1_OP_MATCH_OR_SKIP,		// utcTime
+	[  24] =    _tag(UNIV, PRIM, UNITIM),
+	[  25] =    ASN1_OP_COND_MATCH_OR_SKIP,		// generalTime
+	[  26] =    _tag(UNIV, PRIM, GENTIM),
+	[  27] =    ASN1_OP_COND_FAIL,
+	[  28] =    ASN1_OP_ACT,
+	[  29] =    _action(ACT_x509_note_not_before),
+	// Time
+	[  30] =    ASN1_OP_MATCH_OR_SKIP,		// utcTime
+	[  31] =    _tag(UNIV, PRIM, UNITIM),
+	[  32] =    ASN1_OP_COND_MATCH_OR_SKIP,		// generalTime
+	[  33] =    _tag(UNIV, PRIM, GENTIM),
+	[  34] =    ASN1_OP_COND_FAIL,
+	[  35] =    ASN1_OP_ACT,
+	[  36] =    _action(ACT_x509_note_not_after),
+	[  37] =   ASN1_OP_END_SEQ,
+	// Name
+	[  38] =   ASN1_OP_MATCH_JUMP,
+	[  39] =   _tag(UNIV, CONS, SEQ),
+	[  40] =   _jump_target(80),		// --> Name
+	[  41] =   ASN1_OP_ACT,
+	[  42] =   _action(ACT_x509_note_subject),
+	// SubjectPublicKeyInfo
+	[  43] =   ASN1_OP_MATCH,
+	[  44] =   _tag(UNIV, CONS, SEQ),
+	// AlgorithmIdentifier
+	[  45] =    ASN1_OP_MATCH_JUMP,
+	[  46] =    _tag(UNIV, CONS, SEQ),
+	[  47] =    _jump_target(74),		// --> AlgorithmIdentifier
+	[  48] =    ASN1_OP_MATCH_ACT,		// subjectPublicKey
+	[  49] =    _tag(UNIV, PRIM, BTS),
+	[  50] =    _action(ACT_x509_extract_key_data),
+	[  51] =   ASN1_OP_END_SEQ,
+	// UniqueIdentifier
+	[  52] =   ASN1_OP_MATCH_OR_SKIP,		// issuerUniqueID
+	[  53] =   _tagn(CONT, PRIM,  1),
+	// UniqueIdentifier
+	[  54] =   ASN1_OP_MATCH_OR_SKIP,		// subjectUniqueID
+	[  55] =   _tagn(CONT, PRIM,  2),
+	[  56] =   ASN1_OP_MATCH_JUMP_OR_SKIP,		// extensions
+	[  57] =   _tagn(CONT, CONS,  3),
+	[  58] =   _jump_target(95),
+	[  59] =  ASN1_OP_END_SEQ,
+	[  60] =  ASN1_OP_ACT,
+	[  61] =  _action(ACT_x509_note_tbs_certificate),
+	// AlgorithmIdentifier
+	[  62] =  ASN1_OP_MATCH_JUMP,
+	[  63] =  _tag(UNIV, CONS, SEQ),
+	[  64] =  _jump_target(74),		// --> AlgorithmIdentifier
+	[  65] =  ASN1_OP_MATCH_ACT,		// signature
+	[  66] =  _tag(UNIV, PRIM, BTS),
+	[  67] =  _action(ACT_x509_note_signature),
+	[  68] = ASN1_OP_END_SEQ,
+	[  69] = ASN1_OP_COMPLETE,
+
+	// Version
+	[  70] =  ASN1_OP_MATCH,
+	[  71] =  _tag(UNIV, PRIM, INT),
+	[  72] = ASN1_OP_END_SEQ,
+	[  73] = ASN1_OP_RETURN,
+
+	[  74] =  ASN1_OP_MATCH_ACT,		// algorithm
+	[  75] =  _tag(UNIV, PRIM, OID),
+	[  76] =  _action(ACT_x509_note_OID),
+	[  77] =  ASN1_OP_MATCH_ANY_OR_SKIP,		// parameters
+	[  78] = ASN1_OP_END_SEQ,
+	[  79] = ASN1_OP_RETURN,
+
+	// RelativeDistinguishedName
+	[  80] =  ASN1_OP_MATCH,
+	[  81] =  _tag(UNIV, CONS, SET),
+	// AttributeValueAssertion
+	[  82] =   ASN1_OP_MATCH,
+	[  83] =   _tag(UNIV, CONS, SEQ),
+	[  84] =    ASN1_OP_MATCH_ACT,		// attributeType
+	[  85] =    _tag(UNIV, PRIM, OID),
+	[  86] =    _action(ACT_x509_note_OID),
+	[  87] =    ASN1_OP_MATCH_ANY_ACT,		// attributeValue
+	[  88] =    _action(ACT_x509_extract_name_segment),
+	[  89] =   ASN1_OP_END_SEQ,
+	[  90] =  ASN1_OP_END_SET_OF,
+	[  91] =  _jump_target(82),
+	[  92] = ASN1_OP_END_SEQ_OF,
+	[  93] = _jump_target(80),
+	[  94] = ASN1_OP_RETURN,
+
+	// Extensions
+	[  95] =  ASN1_OP_MATCH,
+	[  96] =  _tag(UNIV, CONS, SEQ),
+	// Extension
+	[  97] =   ASN1_OP_MATCH,
+	[  98] =   _tag(UNIV, CONS, SEQ),
+	[  99] =    ASN1_OP_MATCH_ACT,		// extnid
+	[ 100] =    _tag(UNIV, PRIM, OID),
+	[ 101] =    _action(ACT_x509_note_OID),
+	[ 102] =    ASN1_OP_MATCH_OR_SKIP,		// critical
+	[ 103] =    _tag(UNIV, PRIM, BOOL),
+	[ 104] =    ASN1_OP_MATCH_ACT,		// extnValue
+	[ 105] =    _tag(UNIV, PRIM, OTS),
+	[ 106] =    _action(ACT_x509_process_extension),
+	[ 107] =   ASN1_OP_END_SEQ,
+	[ 108] =  ASN1_OP_END_SEQ_OF,
+	[ 109] =  _jump_target(97),
+	[ 110] = ASN1_OP_END_SEQ,
+	[ 111] = ASN1_OP_RETURN,
+};
+
+const struct asn1_decoder x509_decoder = {
+	.machine = x509_machine,
+	.machlen = sizeof(x509_machine),
+	.actions = x509_action_table,
+};
diff --git a/backport/compat/verification/x509-asn1.h b/backport/compat/verification/x509-asn1.h
new file mode 100644
index 000000000000..4f32a25d6660
--- /dev/null
+++ b/backport/compat/verification/x509-asn1.h
@@ -0,0 +1,22 @@
+/*
+ * Automatically generated by asn1_compiler.  Do not edit
+ *
+ * ASN.1 parser for x509
+ */
+#include <linux/asn1_decoder.h>
+
+extern const struct asn1_decoder x509_decoder;
+
+extern int x509_extract_key_data(void *, size_t, unsigned char, const void *, size_t);
+extern int x509_extract_name_segment(void *, size_t, unsigned char, const void *, size_t);
+extern int x509_note_OID(void *, size_t, unsigned char, const void *, size_t);
+extern int x509_note_issuer(void *, size_t, unsigned char, const void *, size_t);
+extern int x509_note_not_after(void *, size_t, unsigned char, const void *, size_t);
+extern int x509_note_not_before(void *, size_t, unsigned char, const void *, size_t);
+extern int x509_note_pkey_algo(void *, size_t, unsigned char, const void *, size_t);
+extern int x509_note_serial(void *, size_t, unsigned char, const void *, size_t);
+extern int x509_note_signature(void *, size_t, unsigned char, const void *, size_t);
+extern int x509_note_subject(void *, size_t, unsigned char, const void *, size_t);
+extern int x509_note_tbs_certificate(void *, size_t, unsigned char, const void *, size_t);
+extern int x509_process_extension(void *, size_t, unsigned char, const void *, size_t);
+
diff --git a/backport/compat/verification/x509_akid-asn1.c b/backport/compat/verification/x509_akid-asn1.c
new file mode 100644
index 000000000000..dd3c6c2e76f1
--- /dev/null
+++ b/backport/compat/verification/x509_akid-asn1.c
@@ -0,0 +1,144 @@
+/*
+ * Automatically generated by asn1_compiler.  Do not edit
+ *
+ * ASN.1 parser for x509_akid
+ */
+#include <linux/asn1_ber_bytecode.h>
+#include "x509_akid-asn1.h"
+
+enum x509_akid_actions {
+	ACT_x509_akid_note_kid = 0,
+	ACT_x509_akid_note_name = 1,
+	ACT_x509_akid_note_serial = 2,
+	ACT_x509_extract_name_segment = 3,
+	ACT_x509_note_OID = 4,
+	NR__x509_akid_actions = 5
+};
+
+static const asn1_action_t x509_akid_action_table[NR__x509_akid_actions] = {
+	[   0] = x509_akid_note_kid,
+	[   1] = x509_akid_note_name,
+	[   2] = x509_akid_note_serial,
+	[   3] = x509_extract_name_segment,
+	[   4] = x509_note_OID,
+};
+
+static const unsigned char x509_akid_machine[] = {
+	// AuthorityKeyIdentifier
+	[   0] = ASN1_OP_MATCH,
+	[   1] = _tag(UNIV, CONS, SEQ),
+	// KeyIdentifier
+	[   2] =  ASN1_OP_MATCH_ACT_OR_SKIP,		// keyIdentifier
+	[   3] =  _tagn(CONT, PRIM,  0),
+	[   4] =  _action(ACT_x509_akid_note_kid),
+	// GeneralNames
+	[   5] =  ASN1_OP_MATCH_JUMP_OR_SKIP,		// authorityCertIssuer
+	[   6] =  _tagn(CONT, CONS,  1),
+	[   7] =  _jump_target(13),		// --> GeneralNames
+	// CertificateSerialNumber
+	[   8] =  ASN1_OP_MATCH_ACT_OR_SKIP,		// authorityCertSerialNumber
+	[   9] =  _tagn(CONT, PRIM,  2),
+	[  10] =  _action(ACT_x509_akid_note_serial),
+	[  11] = ASN1_OP_END_SEQ,
+	[  12] = ASN1_OP_COMPLETE,
+
+	// GeneralName
+	[  13] =  ASN1_OP_MATCH_JUMP_OR_SKIP,		// otherName
+	[  14] =  _tagn(CONT, CONS,  0),
+	[  15] =  _jump_target(44),
+	[  16] =  ASN1_OP_COND_MATCH_JUMP_OR_SKIP,		// rfc822Name
+	[  17] =  _tagn(CONT, CONS,  1),
+	[  18] =  _jump_target(47),
+	[  19] =  ASN1_OP_COND_MATCH_JUMP_OR_SKIP,		// dNSName
+	[  20] =  _tagn(CONT, CONS,  2),
+	[  21] =  _jump_target(51),
+	[  22] =  ASN1_OP_COND_MATCH_JUMP_OR_SKIP,		// x400Address
+	[  23] =  _tagn(CONT, CONS,  3),
+	[  24] =  _jump_target(55),
+	[  25] =  ASN1_OP_COND_MATCH_JUMP_OR_SKIP,		// directoryName
+	[  26] =  _tagn(CONT, CONS,  4),
+	[  27] =  _jump_target(58),
+	[  28] =  ASN1_OP_COND_MATCH_JUMP_OR_SKIP,		// ediPartyName
+	[  29] =  _tagn(CONT, CONS,  5),
+	[  30] =  _jump_target(78),
+	[  31] =  ASN1_OP_COND_MATCH_JUMP_OR_SKIP,		// uniformResourceIdentifier
+	[  32] =  _tagn(CONT, CONS,  6),
+	[  33] =  _jump_target(81),
+	[  34] =  ASN1_OP_COND_MATCH_JUMP_OR_SKIP,		// iPAddress
+	[  35] =  _tagn(CONT, CONS,  7),
+	[  36] =  _jump_target(85),
+	[  37] =  ASN1_OP_COND_MATCH_JUMP_OR_SKIP,		// registeredID
+	[  38] =  _tagn(CONT, CONS,  8),
+	[  39] =  _jump_target(89),
+	[  40] =  ASN1_OP_COND_FAIL,
+	[  41] = ASN1_OP_END_SEQ_OF,
+	[  42] = _jump_target(13),
+	[  43] = ASN1_OP_RETURN,
+
+	[  44] =  ASN1_OP_MATCH_ANY,		// otherName
+	[  45] = ASN1_OP_END_SEQ,
+	[  46] = ASN1_OP_RETURN,
+
+	[  47] =  ASN1_OP_MATCH,		// rfc822Name
+	[  48] =  _tag(UNIV, PRIM, IA5STR),
+	[  49] = ASN1_OP_END_SEQ,
+	[  50] = ASN1_OP_RETURN,
+
+	[  51] =  ASN1_OP_MATCH,		// dNSName
+	[  52] =  _tag(UNIV, PRIM, IA5STR),
+	[  53] = ASN1_OP_END_SEQ,
+	[  54] = ASN1_OP_RETURN,
+
+	[  55] =  ASN1_OP_MATCH_ANY,		// x400Address
+	[  56] = ASN1_OP_END_SEQ,
+	[  57] = ASN1_OP_RETURN,
+
+	// Name
+	[  58] =  ASN1_OP_MATCH,
+	[  59] =  _tag(UNIV, CONS, SEQ),
+	// RelativeDistinguishedName
+	[  60] =   ASN1_OP_MATCH,
+	[  61] =   _tag(UNIV, CONS, SET),
+	// AttributeValueAssertion
+	[  62] =    ASN1_OP_MATCH,
+	[  63] =    _tag(UNIV, CONS, SEQ),
+	[  64] =     ASN1_OP_MATCH_ACT,		// attributeType
+	[  65] =     _tag(UNIV, PRIM, OID),
+	[  66] =     _action(ACT_x509_note_OID),
+	[  67] =     ASN1_OP_MATCH_ANY_ACT,		// attributeValue
+	[  68] =     _action(ACT_x509_extract_name_segment),
+	[  69] =    ASN1_OP_END_SEQ,
+	[  70] =   ASN1_OP_END_SET_OF,
+	[  71] =   _jump_target(62),
+	[  72] =  ASN1_OP_END_SEQ_OF,
+	[  73] =  _jump_target(60),
+	[  74] =  ASN1_OP_ACT,
+	[  75] =  _action(ACT_x509_akid_note_name),
+	[  76] = ASN1_OP_END_SEQ,
+	[  77] = ASN1_OP_RETURN,
+
+	[  78] =  ASN1_OP_MATCH_ANY,		// ediPartyName
+	[  79] = ASN1_OP_END_SEQ,
+	[  80] = ASN1_OP_RETURN,
+
+	[  81] =  ASN1_OP_MATCH,		// uniformResourceIdentifier
+	[  82] =  _tag(UNIV, PRIM, IA5STR),
+	[  83] = ASN1_OP_END_SEQ,
+	[  84] = ASN1_OP_RETURN,
+
+	[  85] =  ASN1_OP_MATCH,		// iPAddress
+	[  86] =  _tag(UNIV, PRIM, OTS),
+	[  87] = ASN1_OP_END_SEQ,
+	[  88] = ASN1_OP_RETURN,
+
+	[  89] =  ASN1_OP_MATCH,		// registeredID
+	[  90] =  _tag(UNIV, PRIM, OID),
+	[  91] = ASN1_OP_END_SEQ,
+	[  92] = ASN1_OP_RETURN,
+};
+
+const struct asn1_decoder x509_akid_decoder = {
+	.machine = x509_akid_machine,
+	.machlen = sizeof(x509_akid_machine),
+	.actions = x509_akid_action_table,
+};
diff --git a/backport/compat/verification/x509_akid-asn1.h b/backport/compat/verification/x509_akid-asn1.h
new file mode 100644
index 000000000000..92914da56a9b
--- /dev/null
+++ b/backport/compat/verification/x509_akid-asn1.h
@@ -0,0 +1,15 @@
+/*
+ * Automatically generated by asn1_compiler.  Do not edit
+ *
+ * ASN.1 parser for x509_akid
+ */
+#include <linux/asn1_decoder.h>
+
+extern const struct asn1_decoder x509_akid_decoder;
+
+extern int x509_akid_note_kid(void *, size_t, unsigned char, const void *, size_t);
+extern int x509_akid_note_name(void *, size_t, unsigned char, const void *, size_t);
+extern int x509_akid_note_serial(void *, size_t, unsigned char, const void *, size_t);
+extern int x509_extract_name_segment(void *, size_t, unsigned char, const void *, size_t);
+extern int x509_note_OID(void *, size_t, unsigned char, const void *, size_t);
+
diff --git a/copy-list b/copy-list
index 0bd232f44b56..d36caea39f6d 100644
--- a/copy-list
+++ b/copy-list
@@ -61,6 +61,19 @@ include/net/codel_qdisc.h
 include/net/fq.h
 include/net/fq_impl.h
 
+# signature verification code
+include/linux/asn1.h
+include/linux/asn1_ber_bytecode.h
+include/linux/oid_registry.h
+lib/build_OID_registry -> compat/build_OID_registry
+crypto/asymmetric_keys/pkcs7_parser.c -> compat/verification/pkcs7_parser.c
+crypto/asymmetric_keys/pkcs7_parser.h -> compat/verification/pkcs7_parser.h
+crypto/asymmetric_keys/pkcs7_trust.c -> compat/verification/pkcs7_trust.c
+crypto/asymmetric_keys/pkcs7_verify.c -> compat/verification/pkcs7_verify.c
+crypto/asymmetric_keys/x509_cert_parser.c -> compat/verification/x509_cert_parser.c
+crypto/asymmetric_keys/x509_parser.h -> compat/verification/x509_parser.h
+crypto/asymmetric_keys/x509_public_key.c -> compat/verification/x509_public_key.c
+
 net/Makefile
 net/Kconfig
 net/wireless/
diff --git a/patches/verify.patch b/patches/verify.patch
new file mode 100644
index 000000000000..dbb5600ec74e
--- /dev/null
+++ b/patches/verify.patch
@@ -0,0 +1,86 @@
+--- a/compat/verification/pkcs7_trust.c
++++ b/compat/verification/pkcs7_trust.c
+@@ -115,7 +115,7 @@ static int pkcs7_validate_trust_one(struct pkcs7_message *pkcs7,
+ 	return -ENOKEY;
+ 
+ matched:
+-	ret = verify_signature(key, sig);
++	ret = public_key_verify_signature(key->public_key, sig);
+ 	key_put(key);
+ 	if (ret < 0) {
+ 		if (ret == -ENOMEM)
+--- a/compat/verification/x509_public_key.c
++++ b/compat/verification/x509_public_key.c
+@@ -13,11 +13,8 @@
+ #include <linux/module.h>
+ #include <linux/kernel.h>
+ #include <linux/slab.h>
+-#include <keys/asymmetric-subtype.h>
+-#include <keys/asymmetric-parser.h>
+ #include <keys/system_keyring.h>
+ #include <crypto/hash.h>
+-#include "asymmetric_keys.h"
+ #include "x509_parser.h"
+ 
+ /*
+@@ -159,6 +156,7 @@ not_self_signed:
+ 	return 0;
+ }
+ 
++#if 0
+ /*
+  * Attempt to parse a data blob for a key as an X509 certificate.
+  */
+@@ -276,3 +274,4 @@ module_exit(x509_key_exit);
+ 
+ MODULE_DESCRIPTION("X.509 certificate parser");
+ MODULE_LICENSE("GPL");
++#endif
+--- a/include/crypto/pkcs7.h
++++ b/include/crypto/pkcs7.h
+@@ -2,5 +2,10 @@
+ #ifndef CPTCFG_BPAUTO_PKCS7
+ #include_next <crypto/pkcs7.h>
+ #else
++#define pkcs7_verify LINUX_BACKPORT(pkcs7_verify)
++#define pkcs7_get_content_data LINUX_BACKPORT(pkcs7_get_content_data)
++#define pkcs7_parse_message LINUX_BACKPORT(pkcs7_parse_message)
++#define pkcs7_free_message LINUX_BACKPORT(pkcs7_free_message)
++#define pkcs7_validate_trust LINUX_BACKPORT(pkcs7_validate_trust)
+ #include <crypto/backport-pkcs7.h>
+ #endif /* CPTCFG_BPAUTO_PKCS7 */
+--- a/compat/verification/x509_parser.h
++++ b/compat/verification/x509_parser.h
+@@ -13,6 +13,10 @@
+ #include <crypto/public_key.h>
+ #include <keys/asymmetric-type.h>
+ 
++#define x509_decode_time LINUX_BACKPORT(x509_decode_time)
++#define x509_cert_parse LINUX_BACKPORT(x509_cert_parse)
++#define x509_free_certificate LINUX_BACKPORT(x509_free_certificate)
++
+ struct x509_certificate {
+ 	struct x509_certificate *next;
+ 	struct x509_certificate *signer;	/* Certificate that signed this one */
+--- a/net/wireless/Makefile
++++ b/net/wireless/Makefile
+@@ -22,7 +22,7 @@ ifneq ($(CPTCFG_CFG80211_EXTRA_REGDB_KEYDIR),)
+ cfg80211-y += extra-certs.o
+ endif
+ 
+-$(obj)/shipped-certs.c: $(wildcard $(srctree)/$(src)/certs/*.x509)
++$(obj)/shipped-certs.c: $(wildcard $(src)/certs/*.x509)
+ 	@echo "  GEN     $@"
+ 	@echo '#include "reg.h"' > $@
+ 	@echo 'const u8 shipped_regdb_certs[] = {' >> $@
+--- a/compat/verification/pkcs7_verify.c
++++ b/compat/verification/pkcs7_verify.c
+@@ -150,7 +150,7 @@
+ 		pr_devel("Sig %u: Found cert serial match X.509[%u]\n",
+ 			 sinfo->index, certix);
+ 
+-		if (x509->pub->pkey_algo != sinfo->sig->pkey_algo) {
++		if (strcmp(x509->pub->pkey_algo, sinfo->sig->pkey_algo)) {
+ 			pr_warn("Sig %u: X.509 algo and PKCS#7 sig algo don't match\n",
+ 				sinfo->index);
+ 			continue;
-- 
2.14.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
