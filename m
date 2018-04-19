Return-path: <backports-owner@vger.kernel.org>
Received: from mail-cys01nam02on0109.outbound.protection.outlook.com ([104.47.37.109]:43952
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752380AbeDSGMN (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 19 Apr 2018 02:12:13 -0400
Date: Thu, 19 Apr 2018 01:11:58 -0500
From: Winnie Chang <winnie.chang@cypress.com>
To: backports@vger.kernel.org
Cc: chln@cypress.com
Subject: [PATCH] backports: rename *-asn1.[ch] to *.asn1.[ch]
Message-ID: <20180419061146.GA22072@aremote01.aus.cypress.com> (sfid-20180419_081221_410832_BEBBCF66)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

linux-stable 4fa8bc949de11c99ee2433c602d43f87c452f4f2 renamed
*-asn1.[ch] files to *.asn1.[ch]. Make the corresponding change
for backports.
---
 backport/compat/Makefile                      |   8 +-
 backport/compat/verification/pkcs7-asn1.c     | 355 --------------------------
 backport/compat/verification/pkcs7-asn1.h     |  27 --
 backport/compat/verification/pkcs7.asn1.c     | 355 ++++++++++++++++++++++++++
 backport/compat/verification/pkcs7.asn1.h     |  27 ++
 backport/compat/verification/public_key.c     |   2 +-
 backport/compat/verification/rsapubkey-asn1.c |  38 ---
 backport/compat/verification/rsapubkey-asn1.h |  15 --
 backport/compat/verification/rsapubkey.asn1.c |  38 +++
 backport/compat/verification/rsapubkey.asn1.h |  15 ++
 backport/compat/verification/x509-asn1.c      | 182 -------------
 backport/compat/verification/x509-asn1.h      |  22 --
 backport/compat/verification/x509.asn1.c      | 182 +++++++++++++
 backport/compat/verification/x509.asn1.h      |  22 ++
 backport/compat/verification/x509_akid-asn1.c | 144 -----------
 backport/compat/verification/x509_akid-asn1.h |  15 --
 backport/compat/verification/x509_akid.asn1.c | 144 +++++++++++
 backport/compat/verification/x509_akid.asn1.h |  15 ++
 18 files changed, 803 insertions(+), 803 deletions(-)
 delete mode 100644 backport/compat/verification/pkcs7-asn1.c
 delete mode 100644 backport/compat/verification/pkcs7-asn1.h
 create mode 100644 backport/compat/verification/pkcs7.asn1.c
 create mode 100644 backport/compat/verification/pkcs7.asn1.h
 delete mode 100644 backport/compat/verification/rsapubkey-asn1.c
 delete mode 100644 backport/compat/verification/rsapubkey-asn1.h
 create mode 100644 backport/compat/verification/rsapubkey.asn1.c
 create mode 100644 backport/compat/verification/rsapubkey.asn1.h
 delete mode 100644 backport/compat/verification/x509-asn1.c
 delete mode 100644 backport/compat/verification/x509-asn1.h
 create mode 100644 backport/compat/verification/x509.asn1.c
 create mode 100644 backport/compat/verification/x509.asn1.h
 delete mode 100644 backport/compat/verification/x509_akid-asn1.c
 delete mode 100644 backport/compat/verification/x509_akid-asn1.h
 create mode 100644 backport/compat/verification/x509_akid.asn1.c
 create mode 100644 backport/compat/verification/x509_akid.asn1.h

diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index ac70aaf..12c4121 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -41,11 +41,11 @@ compat-$(CPTCFG_KERNEL_4_12) += backport-4.12.o
 compat-$(CPTCFG_BPAUTO_CRYPTO_SKCIPHER) += crypto-skcipher.o
 
 compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/verify.o
-compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/pkcs7-asn1.o
+compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/pkcs7.asn1.o
 compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/pkcs7_verify.o
 compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/pkcs7_parser.o
-compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/x509-asn1.o
-compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/x509_akid-asn1.o
+compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/x509.asn1.o
+compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/x509_akid.asn1.o
 compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/x509_cert_parser.o
 compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/x509_public_key.o
 compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/pkcs7_trust.o
@@ -58,7 +58,7 @@ compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/md_wrap.o
 compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/sha256.o
 compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/oid.o
 compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/asn1parse.o
-compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/rsapubkey-asn1.o
+compat-$(CPTCFG_BPAUTO_BUILD_SYSTEM_DATA_VERIFICATION) += verification/rsapubkey.asn1.o
 
 $(obj)/lib-oid_registry.o: $(obj)/oid_registry_data.c
 
diff --git a/backport/compat/verification/pkcs7-asn1.c b/backport/compat/verification/pkcs7-asn1.c
deleted file mode 100644
index 9073fd9..0000000
--- a/backport/compat/verification/pkcs7-asn1.c
+++ /dev/null
@@ -1,355 +0,0 @@
-/*
- * Automatically generated by asn1_compiler.  Do not edit
- *
- * ASN.1 parser for pkcs7
- */
-#include <linux/asn1_ber_bytecode.h>
-#include "pkcs7-asn1.h"
-
-enum pkcs7_actions {
-	ACT_pkcs7_check_content_type = 0,
-	ACT_pkcs7_extract_cert = 1,
-	ACT_pkcs7_note_OID = 2,
-	ACT_pkcs7_note_certificate_list = 3,
-	ACT_pkcs7_note_content = 4,
-	ACT_pkcs7_note_data = 5,
-	ACT_pkcs7_note_signed_info = 6,
-	ACT_pkcs7_note_signeddata_version = 7,
-	ACT_pkcs7_note_signerinfo_version = 8,
-	ACT_pkcs7_sig_note_authenticated_attr = 9,
-	ACT_pkcs7_sig_note_digest_algo = 10,
-	ACT_pkcs7_sig_note_issuer = 11,
-	ACT_pkcs7_sig_note_pkey_algo = 12,
-	ACT_pkcs7_sig_note_serial = 13,
-	ACT_pkcs7_sig_note_set_of_authattrs = 14,
-	ACT_pkcs7_sig_note_signature = 15,
-	ACT_pkcs7_sig_note_skid = 16,
-	NR__pkcs7_actions = 17
-};
-
-static const asn1_action_t pkcs7_action_table[NR__pkcs7_actions] = {
-	[   0] = pkcs7_check_content_type,
-	[   1] = pkcs7_extract_cert,
-	[   2] = pkcs7_note_OID,
-	[   3] = pkcs7_note_certificate_list,
-	[   4] = pkcs7_note_content,
-	[   5] = pkcs7_note_data,
-	[   6] = pkcs7_note_signed_info,
-	[   7] = pkcs7_note_signeddata_version,
-	[   8] = pkcs7_note_signerinfo_version,
-	[   9] = pkcs7_sig_note_authenticated_attr,
-	[  10] = pkcs7_sig_note_digest_algo,
-	[  11] = pkcs7_sig_note_issuer,
-	[  12] = pkcs7_sig_note_pkey_algo,
-	[  13] = pkcs7_sig_note_serial,
-	[  14] = pkcs7_sig_note_set_of_authattrs,
-	[  15] = pkcs7_sig_note_signature,
-	[  16] = pkcs7_sig_note_skid,
-};
-
-static const unsigned char pkcs7_machine[] = {
-	// PKCS7ContentInfo
-	[   0] = ASN1_OP_MATCH,
-	[   1] = _tag(UNIV, CONS, SEQ),
-	// ContentType
-	[   2] =  ASN1_OP_MATCH_ACT,
-	[   3] =  _tag(UNIV, PRIM, OID),
-	[   4] =  _action(ACT_pkcs7_note_OID),
-	[   5] =  ASN1_OP_ACT,
-	[   6] =  _action(ACT_pkcs7_check_content_type),
-	[   7] =  ASN1_OP_MATCH_JUMP_OR_SKIP,		// content
-	[   8] =  _tagn(CONT, CONS,  0),
-	[   9] =  _jump_target(12),
-	[  10] = ASN1_OP_END_SEQ,
-	[  11] = ASN1_OP_COMPLETE,
-
-	// SignedData
-	[  12] =  ASN1_OP_MATCH,
-	[  13] =  _tag(UNIV, CONS, SEQ),
-	[  14] =   ASN1_OP_MATCH_ACT,		// version
-	[  15] =   _tag(UNIV, PRIM, INT),
-	[  16] =   _action(ACT_pkcs7_note_signeddata_version),
-	// DigestAlgorithmIdentifiers
-	[  17] =   ASN1_OP_MATCH_JUMP_OR_SKIP,		// daSet
-	[  18] =   _tag(UNIV, CONS, SET),
-	[  19] =   _jump_target(61),
-	[  20] =   ASN1_OP_COND_MATCH_JUMP_OR_SKIP,		// daSequence
-	[  21] =   _tag(UNIV, CONS, SEQ),
-	[  22] =   _jump_target(67),
-	[  23] =   ASN1_OP_COND_FAIL,
-	// ContentInfo
-	[  24] =   ASN1_OP_MATCH,
-	[  25] =   _tag(UNIV, CONS, SEQ),
-	// ContentType
-	[  26] =    ASN1_OP_MATCH_ACT,
-	[  27] =    _tag(UNIV, PRIM, OID),
-	[  28] =    _action(ACT_pkcs7_note_OID),
-	[  29] =    ASN1_OP_ACT,
-	[  30] =    _action(ACT_pkcs7_note_OID),
-	[  31] =    ASN1_OP_MATCH_JUMP_OR_SKIP,		// content
-	[  32] =    _tagn(CONT, CONS,  0),
-	[  33] =    _jump_target(73),
-	[  34] =   ASN1_OP_END_SEQ,
-	[  35] =   ASN1_OP_ACT,
-	[  36] =   _action(ACT_pkcs7_note_content),
-	// ExtendedCertificatesAndCertificates
-	[  37] =   ASN1_OP_MATCH_JUMP_OR_SKIP,		// certSet
-	[  38] =   _tagn(CONT, CONS,  0),
-	[  39] =   _jump_target(77),		// --> ExtendedCertificatesAndCertificates
-	// Certificates
-	[  40] =   ASN1_OP_COND_MATCH_JUMP_OR_SKIP,		// certSequence
-	[  41] =   _tagn(CONT, CONS,  2),
-	[  42] =   _jump_target(85),		// --> Certificates
-	[  43] =   ASN1_OP_ACT,
-	[  44] =   _action(ACT_pkcs7_note_certificate_list),
-	// CertificateRevocationLists
-	[  45] =   ASN1_OP_MATCH_JUMP_OR_SKIP,		// crlSet
-	[  46] =   _tagn(CONT, CONS,  1),
-	[  47] =   _jump_target(90),		// --> CertificateRevocationLists
-	// CRLSequence
-	[  48] =   ASN1_OP_COND_MATCH_JUMP_OR_SKIP,		// crlSequence
-	[  49] =   _tagn(CONT, CONS,  3),
-	[  50] =   _jump_target(96),		// --> CRLSequence
-	// SignerInfos
-	[  51] =   ASN1_OP_MATCH_JUMP_OR_SKIP,		// siSet
-	[  52] =   _tag(UNIV, CONS, SET),
-	[  53] =   _jump_target(102),
-	[  54] =   ASN1_OP_COND_MATCH_JUMP_OR_SKIP,		// siSequence
-	[  55] =   _tag(UNIV, CONS, SEQ),
-	[  56] =   _jump_target(108),
-	[  57] =   ASN1_OP_COND_FAIL,
-	[  58] =  ASN1_OP_END_SEQ,
-	[  59] = ASN1_OP_END_SEQ,
-	[  60] = ASN1_OP_RETURN,
-
-	// DigestAlgorithmIdentifier
-	[  61] =  ASN1_OP_MATCH_JUMP,
-	[  62] =  _tag(UNIV, CONS, SEQ),
-	[  63] =  _jump_target(114),		// --> DigestAlgorithmIdentifier
-	[  64] = ASN1_OP_END_SET_OF,
-	[  65] = _jump_target(61),
-	[  66] = ASN1_OP_RETURN,
-
-	// DigestAlgorithmIdentifier
-	[  67] =  ASN1_OP_MATCH_JUMP,
-	[  68] =  _tag(UNIV, CONS, SEQ),
-	[  69] =  _jump_target(114),		// --> DigestAlgorithmIdentifier
-	[  70] = ASN1_OP_END_SEQ_OF,
-	[  71] = _jump_target(67),
-	[  72] = ASN1_OP_RETURN,
-
-	// Data
-	[  73] =  ASN1_OP_MATCH_ANY_ACT,
-	[  74] =  _action(ACT_pkcs7_note_data),
-	[  75] = ASN1_OP_END_SEQ,
-	[  76] = ASN1_OP_RETURN,
-
-	// ExtendedCertificateOrCertificate
-	// Certificate
-	[  77] =  ASN1_OP_MATCH_ANY_ACT_OR_SKIP,
-	[  78] =  _action(ACT_pkcs7_extract_cert),
-	// ExtendedCertificate
-	// Certificate
-	[  79] =  ASN1_OP_COND_MATCH_ANY_ACT_OR_SKIP,
-	[  80] =  _action(ACT_pkcs7_extract_cert),
-	[  81] =  ASN1_OP_COND_FAIL,
-	[  82] = ASN1_OP_END_SET_OF,
-	[  83] = _jump_target(77),
-	[  84] = ASN1_OP_RETURN,
-
-	// Certificate
-	[  85] =  ASN1_OP_MATCH_ANY_ACT,
-	[  86] =  _action(ACT_pkcs7_extract_cert),
-	[  87] = ASN1_OP_END_SEQ_OF,
-	[  88] = _jump_target(85),
-	[  89] = ASN1_OP_RETURN,
-
-	// CertificateList
-	[  90] =  ASN1_OP_MATCH_JUMP,
-	[  91] =  _tag(UNIV, CONS, SEQ),
-	[  92] =  _jump_target(120),		// --> CertificateList
-	[  93] = ASN1_OP_END_SET_OF,
-	[  94] = _jump_target(90),
-	[  95] = ASN1_OP_RETURN,
-
-	// CertificateList
-	[  96] =  ASN1_OP_MATCH_JUMP,
-	[  97] =  _tag(UNIV, CONS, SEQ),
-	[  98] =  _jump_target(120),		// --> CertificateList
-	[  99] = ASN1_OP_END_SEQ_OF,
-	[ 100] = _jump_target(96),
-	[ 101] = ASN1_OP_RETURN,
-
-	// SignerInfo
-	[ 102] =  ASN1_OP_MATCH_JUMP,
-	[ 103] =  _tag(UNIV, CONS, SEQ),
-	[ 104] =  _jump_target(125),		// --> SignerInfo
-	[ 105] = ASN1_OP_END_SET_OF,
-	[ 106] = _jump_target(102),
-	[ 107] = ASN1_OP_RETURN,
-
-	// SignerInfo
-	[ 108] =  ASN1_OP_MATCH_JUMP,
-	[ 109] =  _tag(UNIV, CONS, SEQ),
-	[ 110] =  _jump_target(125),		// --> SignerInfo
-	[ 111] = ASN1_OP_END_SEQ_OF,
-	[ 112] = _jump_target(108),
-	[ 113] = ASN1_OP_RETURN,
-
-	[ 114] =  ASN1_OP_MATCH_ACT,		// algorithm
-	[ 115] =  _tag(UNIV, PRIM, OID),
-	[ 116] =  _action(ACT_pkcs7_note_OID),
-	[ 117] =  ASN1_OP_MATCH_ANY_OR_SKIP,		// parameters
-	[ 118] = ASN1_OP_END_SEQ,
-	[ 119] = ASN1_OP_RETURN,
-
-	// Certificate
-	[ 120] =  ASN1_OP_MATCH_ANY_ACT,
-	[ 121] =  _action(ACT_pkcs7_extract_cert),
-	[ 122] = ASN1_OP_END_SEQ_OF,
-	[ 123] = _jump_target(120),
-	[ 124] = ASN1_OP_RETURN,
-
-	[ 125] =  ASN1_OP_MATCH_ACT,		// version
-	[ 126] =  _tag(UNIV, PRIM, INT),
-	[ 127] =  _action(ACT_pkcs7_note_signerinfo_version),
-	// SignerIdentifier
-	// IssuerAndSerialNumber
-	[ 128] =  ASN1_OP_MATCH_JUMP_OR_SKIP,		// issuerAndSerialNumber
-	[ 129] =  _tag(UNIV, CONS, SEQ),
-	[ 130] =  _jump_target(169),		// --> IssuerAndSerialNumber
-	// SubjectKeyIdentifier
-	[ 131] =  ASN1_OP_COND_MATCH_ACT_OR_SKIP,		// subjectKeyIdentifier
-	[ 132] =  _tagn(CONT, PRIM,  0),
-	[ 133] =  _action(ACT_pkcs7_sig_note_skid),
-	[ 134] =  ASN1_OP_COND_FAIL,
-	// DigestAlgorithmIdentifier
-	[ 135] =  ASN1_OP_MATCH_JUMP,
-	[ 136] =  _tag(UNIV, CONS, SEQ),
-	[ 137] =  _jump_target(114),		// --> DigestAlgorithmIdentifier
-	[ 138] =  ASN1_OP_ACT,
-	[ 139] =  _action(ACT_pkcs7_sig_note_digest_algo),
-	// SetOfAuthenticatedAttribute
-	[ 140] =  ASN1_OP_MATCH_JUMP_OR_SKIP,		// aaSet
-	[ 141] =  _tagn(CONT, CONS,  0),
-	[ 142] =  _jump_target(192),		// --> SetOfAuthenticatedAttribute
-	[ 143] =  ASN1_OP_MAYBE_ACT,
-	[ 144] =  _action(ACT_pkcs7_sig_note_set_of_authattrs),
-	[ 145] =  ASN1_OP_COND_MATCH_JUMP_OR_SKIP,		// aaSequence
-	[ 146] =  _tagn(CONT, CONS,  2),
-	[ 147] =  _jump_target(198),
-	// DigestEncryptionAlgorithmIdentifier
-	[ 148] =  ASN1_OP_MATCH,
-	[ 149] =  _tag(UNIV, CONS, SEQ),
-	[ 150] =   ASN1_OP_MATCH_ACT,		// algorithm
-	[ 151] =   _tag(UNIV, PRIM, OID),
-	[ 152] =   _action(ACT_pkcs7_note_OID),
-	[ 153] =   ASN1_OP_MATCH_ANY_OR_SKIP,		// parameters
-	[ 154] =  ASN1_OP_END_SEQ,
-	[ 155] =  ASN1_OP_ACT,
-	[ 156] =  _action(ACT_pkcs7_sig_note_pkey_algo),
-	// EncryptedDigest
-	[ 157] =  ASN1_OP_MATCH_ACT,
-	[ 158] =  _tag(UNIV, PRIM, OTS),
-	[ 159] =  _action(ACT_pkcs7_sig_note_signature),
-	[ 160] =  ASN1_OP_MATCH_JUMP_OR_SKIP,		// uaSet
-	[ 161] =  _tagn(CONT, CONS,  1),
-	[ 162] =  _jump_target(207),
-	[ 163] =  ASN1_OP_COND_MATCH_JUMP_OR_SKIP,		// uaSequence
-	[ 164] =  _tagn(CONT, CONS,  3),
-	[ 165] =  _jump_target(213),
-	[ 166] = ASN1_OP_END_SEQ_ACT,
-	[ 167] = _action(ACT_pkcs7_note_signed_info),
-	[ 168] = ASN1_OP_RETURN,
-
-	// Name
-	[ 169] =  ASN1_OP_MATCH,
-	[ 170] =  _tag(UNIV, CONS, SEQ),
-	// RelativeDistinguishedName
-	[ 171] =   ASN1_OP_MATCH,
-	[ 172] =   _tag(UNIV, CONS, SET),
-	// AttributeValueAssertion
-	[ 173] =    ASN1_OP_MATCH,
-	[ 174] =    _tag(UNIV, CONS, SEQ),
-	[ 175] =     ASN1_OP_MATCH_ACT,		// attributeType
-	[ 176] =     _tag(UNIV, PRIM, OID),
-	[ 177] =     _action(ACT_pkcs7_note_OID),
-	[ 178] =     ASN1_OP_MATCH_ANY,		// attributeValue
-	[ 179] =    ASN1_OP_END_SEQ,
-	[ 180] =   ASN1_OP_END_SET_OF,
-	[ 181] =   _jump_target(173),
-	[ 182] =  ASN1_OP_END_SEQ_OF,
-	[ 183] =  _jump_target(171),
-	[ 184] =  ASN1_OP_ACT,
-	[ 185] =  _action(ACT_pkcs7_sig_note_issuer),
-	// CertificateSerialNumber
-	[ 186] =  ASN1_OP_MATCH,
-	[ 187] =  _tag(UNIV, PRIM, INT),
-	[ 188] =  ASN1_OP_ACT,
-	[ 189] =  _action(ACT_pkcs7_sig_note_serial),
-	[ 190] = ASN1_OP_END_SEQ,
-	[ 191] = ASN1_OP_RETURN,
-
-	// AuthenticatedAttribute
-	[ 192] =  ASN1_OP_MATCH_JUMP,
-	[ 193] =  _tag(UNIV, CONS, SEQ),
-	[ 194] =  _jump_target(219),		// --> AuthenticatedAttribute
-	[ 195] = ASN1_OP_END_SET_OF,
-	[ 196] = _jump_target(192),
-	[ 197] = ASN1_OP_RETURN,
-
-	[ 198] =  ASN1_OP_MATCH,		// aaSequence
-	[ 199] =  _tag(UNIV, CONS, SEQ),
-	// AuthenticatedAttribute
-	[ 200] =   ASN1_OP_MATCH_JUMP,
-	[ 201] =   _tag(UNIV, CONS, SEQ),
-	[ 202] =   _jump_target(219),		// --> AuthenticatedAttribute
-	[ 203] =  ASN1_OP_END_SEQ_OF,
-	[ 204] =  _jump_target(200),
-	[ 205] = ASN1_OP_END_SEQ,
-	[ 206] = ASN1_OP_RETURN,
-
-	// UnauthenticatedAttribute
-	[ 207] =  ASN1_OP_MATCH_JUMP,
-	[ 208] =  _tag(UNIV, CONS, SEQ),
-	[ 209] =  _jump_target(230),		// --> UnauthenticatedAttribute
-	[ 210] = ASN1_OP_END_SET_OF,
-	[ 211] = _jump_target(207),
-	[ 212] = ASN1_OP_RETURN,
-
-	// UnauthenticatedAttribute
-	[ 213] =  ASN1_OP_MATCH_JUMP,
-	[ 214] =  _tag(UNIV, CONS, SEQ),
-	[ 215] =  _jump_target(230),		// --> UnauthenticatedAttribute
-	[ 216] = ASN1_OP_END_SEQ_OF,
-	[ 217] = _jump_target(213),
-	[ 218] = ASN1_OP_RETURN,
-
-	[ 219] =  ASN1_OP_MATCH_ACT,		// type
-	[ 220] =  _tag(UNIV, PRIM, OID),
-	[ 221] =  _action(ACT_pkcs7_note_OID),
-	[ 222] =  ASN1_OP_MATCH,		// values
-	[ 223] =  _tag(UNIV, CONS, SET),
-	[ 224] =   ASN1_OP_MATCH_ANY_ACT,
-	[ 225] =   _action(ACT_pkcs7_sig_note_authenticated_attr),
-	[ 226] =  ASN1_OP_END_SET_OF,
-	[ 227] =  _jump_target(224),
-	[ 228] = ASN1_OP_END_SEQ,
-	[ 229] = ASN1_OP_RETURN,
-
-	[ 230] =  ASN1_OP_MATCH,		// type
-	[ 231] =  _tag(UNIV, PRIM, OID),
-	[ 232] =  ASN1_OP_MATCH,		// values
-	[ 233] =  _tag(UNIV, CONS, SET),
-	[ 234] =   ASN1_OP_MATCH_ANY,
-	[ 235] =  ASN1_OP_END_SET_OF,
-	[ 236] =  _jump_target(234),
-	[ 237] = ASN1_OP_END_SEQ,
-	[ 238] = ASN1_OP_RETURN,
-};
-
-const struct asn1_decoder pkcs7_decoder = {
-	.machine = pkcs7_machine,
-	.machlen = sizeof(pkcs7_machine),
-	.actions = pkcs7_action_table,
-};
diff --git a/backport/compat/verification/pkcs7-asn1.h b/backport/compat/verification/pkcs7-asn1.h
deleted file mode 100644
index b34e160..0000000
--- a/backport/compat/verification/pkcs7-asn1.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * Automatically generated by asn1_compiler.  Do not edit
- *
- * ASN.1 parser for pkcs7
- */
-#include <linux/asn1_decoder.h>
-
-extern const struct asn1_decoder pkcs7_decoder;
-
-extern int pkcs7_check_content_type(void *, size_t, unsigned char, const void *, size_t);
-extern int pkcs7_extract_cert(void *, size_t, unsigned char, const void *, size_t);
-extern int pkcs7_note_OID(void *, size_t, unsigned char, const void *, size_t);
-extern int pkcs7_note_certificate_list(void *, size_t, unsigned char, const void *, size_t);
-extern int pkcs7_note_content(void *, size_t, unsigned char, const void *, size_t);
-extern int pkcs7_note_data(void *, size_t, unsigned char, const void *, size_t);
-extern int pkcs7_note_signed_info(void *, size_t, unsigned char, const void *, size_t);
-extern int pkcs7_note_signeddata_version(void *, size_t, unsigned char, const void *, size_t);
-extern int pkcs7_note_signerinfo_version(void *, size_t, unsigned char, const void *, size_t);
-extern int pkcs7_sig_note_authenticated_attr(void *, size_t, unsigned char, const void *, size_t);
-extern int pkcs7_sig_note_digest_algo(void *, size_t, unsigned char, const void *, size_t);
-extern int pkcs7_sig_note_issuer(void *, size_t, unsigned char, const void *, size_t);
-extern int pkcs7_sig_note_pkey_algo(void *, size_t, unsigned char, const void *, size_t);
-extern int pkcs7_sig_note_serial(void *, size_t, unsigned char, const void *, size_t);
-extern int pkcs7_sig_note_set_of_authattrs(void *, size_t, unsigned char, const void *, size_t);
-extern int pkcs7_sig_note_signature(void *, size_t, unsigned char, const void *, size_t);
-extern int pkcs7_sig_note_skid(void *, size_t, unsigned char, const void *, size_t);
-
diff --git a/backport/compat/verification/pkcs7.asn1.c b/backport/compat/verification/pkcs7.asn1.c
new file mode 100644
index 0000000..d8c91f5
--- /dev/null
+++ b/backport/compat/verification/pkcs7.asn1.c
@@ -0,0 +1,355 @@
+/*
+ * Automatically generated by asn1_compiler.  Do not edit
+ *
+ * ASN.1 parser for pkcs7
+ */
+#include <linux/asn1_ber_bytecode.h>
+#include "pkcs7.asn1.h"
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
diff --git a/backport/compat/verification/pkcs7.asn1.h b/backport/compat/verification/pkcs7.asn1.h
new file mode 100644
index 0000000..b34e160
--- /dev/null
+++ b/backport/compat/verification/pkcs7.asn1.h
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
index 10d1672..83a6935 100644
--- a/backport/compat/verification/public_key.c
+++ b/backport/compat/verification/public_key.c
@@ -18,7 +18,7 @@
 #include <linux/scatterlist.h>
 #include <linux/asn1_decoder.h>
 #include <crypto/public_key.h>
-#include "rsapubkey-asn1.h"
+#include "rsapubkey.asn1.h"
 #include "mbedtls/rsa.h"
 #include "mbedtls/md.h"
 
diff --git a/backport/compat/verification/rsapubkey-asn1.c b/backport/compat/verification/rsapubkey-asn1.c
deleted file mode 100644
index 84ab7f4..0000000
--- a/backport/compat/verification/rsapubkey-asn1.c
+++ /dev/null
@@ -1,38 +0,0 @@
-/*
- * Automatically generated by asn1_compiler.  Do not edit
- *
- * ASN.1 parser for rsapubkey
- */
-#include <linux/asn1_ber_bytecode.h>
-#include "rsapubkey-asn1.h"
-
-enum rsapubkey_actions {
-	ACT_rsa_get_e = 0,
-	ACT_rsa_get_n = 1,
-	NR__rsapubkey_actions = 2
-};
-
-static const asn1_action_t rsapubkey_action_table[NR__rsapubkey_actions] = {
-	[   0] = rsa_get_e,
-	[   1] = rsa_get_n,
-};
-
-static const unsigned char rsapubkey_machine[] = {
-	// RsaPubKey
-	[   0] = ASN1_OP_MATCH,
-	[   1] = _tag(UNIV, CONS, SEQ),
-	[   2] =  ASN1_OP_MATCH_ACT,		// n
-	[   3] =  _tag(UNIV, PRIM, INT),
-	[   4] =  _action(ACT_rsa_get_n),
-	[   5] =  ASN1_OP_MATCH_ACT,		// e
-	[   6] =  _tag(UNIV, PRIM, INT),
-	[   7] =  _action(ACT_rsa_get_e),
-	[   8] = ASN1_OP_END_SEQ,
-	[   9] = ASN1_OP_COMPLETE,
-};
-
-const struct asn1_decoder rsapubkey_decoder = {
-	.machine = rsapubkey_machine,
-	.machlen = sizeof(rsapubkey_machine),
-	.actions = rsapubkey_action_table,
-};
diff --git a/backport/compat/verification/rsapubkey-asn1.h b/backport/compat/verification/rsapubkey-asn1.h
deleted file mode 100644
index 81a82d4..0000000
--- a/backport/compat/verification/rsapubkey-asn1.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/*
- * Automatically generated by asn1_compiler.  Do not edit
- *
- * ASN.1 parser for rsapubkey
- */
-#include <linux/asn1_decoder.h>
-
-extern const struct asn1_decoder rsapubkey_decoder;
-
-#define rsa_get_e LINUX_BACKPORT(rsa_get_e)
-#define rsa_get_n LINUX_BACKPORT(rsa_get_n)
-
-extern int rsa_get_e(void *, size_t, unsigned char, const void *, size_t);
-extern int rsa_get_n(void *, size_t, unsigned char, const void *, size_t);
-
diff --git a/backport/compat/verification/rsapubkey.asn1.c b/backport/compat/verification/rsapubkey.asn1.c
new file mode 100644
index 0000000..6bb1994
--- /dev/null
+++ b/backport/compat/verification/rsapubkey.asn1.c
@@ -0,0 +1,38 @@
+/*
+ * Automatically generated by asn1_compiler.  Do not edit
+ *
+ * ASN.1 parser for rsapubkey
+ */
+#include <linux/asn1_ber_bytecode.h>
+#include "rsapubkey.asn1.h"
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
diff --git a/backport/compat/verification/rsapubkey.asn1.h b/backport/compat/verification/rsapubkey.asn1.h
new file mode 100644
index 0000000..81a82d4
--- /dev/null
+++ b/backport/compat/verification/rsapubkey.asn1.h
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
diff --git a/backport/compat/verification/x509-asn1.c b/backport/compat/verification/x509-asn1.c
deleted file mode 100644
index 89aaa66..0000000
--- a/backport/compat/verification/x509-asn1.c
+++ /dev/null
@@ -1,182 +0,0 @@
-/*
- * Automatically generated by asn1_compiler.  Do not edit
- *
- * ASN.1 parser for x509
- */
-#include <linux/asn1_ber_bytecode.h>
-#include "x509-asn1.h"
-
-enum x509_actions {
-	ACT_x509_extract_key_data = 0,
-	ACT_x509_extract_name_segment = 1,
-	ACT_x509_note_OID = 2,
-	ACT_x509_note_issuer = 3,
-	ACT_x509_note_not_after = 4,
-	ACT_x509_note_not_before = 5,
-	ACT_x509_note_pkey_algo = 6,
-	ACT_x509_note_serial = 7,
-	ACT_x509_note_signature = 8,
-	ACT_x509_note_subject = 9,
-	ACT_x509_note_tbs_certificate = 10,
-	ACT_x509_process_extension = 11,
-	NR__x509_actions = 12
-};
-
-static const asn1_action_t x509_action_table[NR__x509_actions] = {
-	[   0] = x509_extract_key_data,
-	[   1] = x509_extract_name_segment,
-	[   2] = x509_note_OID,
-	[   3] = x509_note_issuer,
-	[   4] = x509_note_not_after,
-	[   5] = x509_note_not_before,
-	[   6] = x509_note_pkey_algo,
-	[   7] = x509_note_serial,
-	[   8] = x509_note_signature,
-	[   9] = x509_note_subject,
-	[  10] = x509_note_tbs_certificate,
-	[  11] = x509_process_extension,
-};
-
-static const unsigned char x509_machine[] = {
-	// Certificate
-	[   0] = ASN1_OP_MATCH,
-	[   1] = _tag(UNIV, CONS, SEQ),
-	// TBSCertificate
-	[   2] =  ASN1_OP_MATCH,
-	[   3] =  _tag(UNIV, CONS, SEQ),
-	[   4] =   ASN1_OP_MATCH_JUMP_OR_SKIP,		// version
-	[   5] =   _tagn(CONT, CONS,  0),
-	[   6] =   _jump_target(70),
-	// CertificateSerialNumber
-	[   7] =   ASN1_OP_MATCH,
-	[   8] =   _tag(UNIV, PRIM, INT),
-	[   9] =   ASN1_OP_ACT,
-	[  10] =   _action(ACT_x509_note_serial),
-	// AlgorithmIdentifier
-	[  11] =   ASN1_OP_MATCH_JUMP,
-	[  12] =   _tag(UNIV, CONS, SEQ),
-	[  13] =   _jump_target(74),		// --> AlgorithmIdentifier
-	[  14] =   ASN1_OP_ACT,
-	[  15] =   _action(ACT_x509_note_pkey_algo),
-	// Name
-	[  16] =   ASN1_OP_MATCH_JUMP,
-	[  17] =   _tag(UNIV, CONS, SEQ),
-	[  18] =   _jump_target(80),		// --> Name
-	[  19] =   ASN1_OP_ACT,
-	[  20] =   _action(ACT_x509_note_issuer),
-	// Validity
-	[  21] =   ASN1_OP_MATCH,
-	[  22] =   _tag(UNIV, CONS, SEQ),
-	// Time
-	[  23] =    ASN1_OP_MATCH_OR_SKIP,		// utcTime
-	[  24] =    _tag(UNIV, PRIM, UNITIM),
-	[  25] =    ASN1_OP_COND_MATCH_OR_SKIP,		// generalTime
-	[  26] =    _tag(UNIV, PRIM, GENTIM),
-	[  27] =    ASN1_OP_COND_FAIL,
-	[  28] =    ASN1_OP_ACT,
-	[  29] =    _action(ACT_x509_note_not_before),
-	// Time
-	[  30] =    ASN1_OP_MATCH_OR_SKIP,		// utcTime
-	[  31] =    _tag(UNIV, PRIM, UNITIM),
-	[  32] =    ASN1_OP_COND_MATCH_OR_SKIP,		// generalTime
-	[  33] =    _tag(UNIV, PRIM, GENTIM),
-	[  34] =    ASN1_OP_COND_FAIL,
-	[  35] =    ASN1_OP_ACT,
-	[  36] =    _action(ACT_x509_note_not_after),
-	[  37] =   ASN1_OP_END_SEQ,
-	// Name
-	[  38] =   ASN1_OP_MATCH_JUMP,
-	[  39] =   _tag(UNIV, CONS, SEQ),
-	[  40] =   _jump_target(80),		// --> Name
-	[  41] =   ASN1_OP_ACT,
-	[  42] =   _action(ACT_x509_note_subject),
-	// SubjectPublicKeyInfo
-	[  43] =   ASN1_OP_MATCH,
-	[  44] =   _tag(UNIV, CONS, SEQ),
-	// AlgorithmIdentifier
-	[  45] =    ASN1_OP_MATCH_JUMP,
-	[  46] =    _tag(UNIV, CONS, SEQ),
-	[  47] =    _jump_target(74),		// --> AlgorithmIdentifier
-	[  48] =    ASN1_OP_MATCH_ACT,		// subjectPublicKey
-	[  49] =    _tag(UNIV, PRIM, BTS),
-	[  50] =    _action(ACT_x509_extract_key_data),
-	[  51] =   ASN1_OP_END_SEQ,
-	// UniqueIdentifier
-	[  52] =   ASN1_OP_MATCH_OR_SKIP,		// issuerUniqueID
-	[  53] =   _tagn(CONT, PRIM,  1),
-	// UniqueIdentifier
-	[  54] =   ASN1_OP_MATCH_OR_SKIP,		// subjectUniqueID
-	[  55] =   _tagn(CONT, PRIM,  2),
-	[  56] =   ASN1_OP_MATCH_JUMP_OR_SKIP,		// extensions
-	[  57] =   _tagn(CONT, CONS,  3),
-	[  58] =   _jump_target(95),
-	[  59] =  ASN1_OP_END_SEQ,
-	[  60] =  ASN1_OP_ACT,
-	[  61] =  _action(ACT_x509_note_tbs_certificate),
-	// AlgorithmIdentifier
-	[  62] =  ASN1_OP_MATCH_JUMP,
-	[  63] =  _tag(UNIV, CONS, SEQ),
-	[  64] =  _jump_target(74),		// --> AlgorithmIdentifier
-	[  65] =  ASN1_OP_MATCH_ACT,		// signature
-	[  66] =  _tag(UNIV, PRIM, BTS),
-	[  67] =  _action(ACT_x509_note_signature),
-	[  68] = ASN1_OP_END_SEQ,
-	[  69] = ASN1_OP_COMPLETE,
-
-	// Version
-	[  70] =  ASN1_OP_MATCH,
-	[  71] =  _tag(UNIV, PRIM, INT),
-	[  72] = ASN1_OP_END_SEQ,
-	[  73] = ASN1_OP_RETURN,
-
-	[  74] =  ASN1_OP_MATCH_ACT,		// algorithm
-	[  75] =  _tag(UNIV, PRIM, OID),
-	[  76] =  _action(ACT_x509_note_OID),
-	[  77] =  ASN1_OP_MATCH_ANY_OR_SKIP,		// parameters
-	[  78] = ASN1_OP_END_SEQ,
-	[  79] = ASN1_OP_RETURN,
-
-	// RelativeDistinguishedName
-	[  80] =  ASN1_OP_MATCH,
-	[  81] =  _tag(UNIV, CONS, SET),
-	// AttributeValueAssertion
-	[  82] =   ASN1_OP_MATCH,
-	[  83] =   _tag(UNIV, CONS, SEQ),
-	[  84] =    ASN1_OP_MATCH_ACT,		// attributeType
-	[  85] =    _tag(UNIV, PRIM, OID),
-	[  86] =    _action(ACT_x509_note_OID),
-	[  87] =    ASN1_OP_MATCH_ANY_ACT,		// attributeValue
-	[  88] =    _action(ACT_x509_extract_name_segment),
-	[  89] =   ASN1_OP_END_SEQ,
-	[  90] =  ASN1_OP_END_SET_OF,
-	[  91] =  _jump_target(82),
-	[  92] = ASN1_OP_END_SEQ_OF,
-	[  93] = _jump_target(80),
-	[  94] = ASN1_OP_RETURN,
-
-	// Extensions
-	[  95] =  ASN1_OP_MATCH,
-	[  96] =  _tag(UNIV, CONS, SEQ),
-	// Extension
-	[  97] =   ASN1_OP_MATCH,
-	[  98] =   _tag(UNIV, CONS, SEQ),
-	[  99] =    ASN1_OP_MATCH_ACT,		// extnid
-	[ 100] =    _tag(UNIV, PRIM, OID),
-	[ 101] =    _action(ACT_x509_note_OID),
-	[ 102] =    ASN1_OP_MATCH_OR_SKIP,		// critical
-	[ 103] =    _tag(UNIV, PRIM, BOOL),
-	[ 104] =    ASN1_OP_MATCH_ACT,		// extnValue
-	[ 105] =    _tag(UNIV, PRIM, OTS),
-	[ 106] =    _action(ACT_x509_process_extension),
-	[ 107] =   ASN1_OP_END_SEQ,
-	[ 108] =  ASN1_OP_END_SEQ_OF,
-	[ 109] =  _jump_target(97),
-	[ 110] = ASN1_OP_END_SEQ,
-	[ 111] = ASN1_OP_RETURN,
-};
-
-const struct asn1_decoder x509_decoder = {
-	.machine = x509_machine,
-	.machlen = sizeof(x509_machine),
-	.actions = x509_action_table,
-};
diff --git a/backport/compat/verification/x509-asn1.h b/backport/compat/verification/x509-asn1.h
deleted file mode 100644
index 4f32a25..0000000
--- a/backport/compat/verification/x509-asn1.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * Automatically generated by asn1_compiler.  Do not edit
- *
- * ASN.1 parser for x509
- */
-#include <linux/asn1_decoder.h>
-
-extern const struct asn1_decoder x509_decoder;
-
-extern int x509_extract_key_data(void *, size_t, unsigned char, const void *, size_t);
-extern int x509_extract_name_segment(void *, size_t, unsigned char, const void *, size_t);
-extern int x509_note_OID(void *, size_t, unsigned char, const void *, size_t);
-extern int x509_note_issuer(void *, size_t, unsigned char, const void *, size_t);
-extern int x509_note_not_after(void *, size_t, unsigned char, const void *, size_t);
-extern int x509_note_not_before(void *, size_t, unsigned char, const void *, size_t);
-extern int x509_note_pkey_algo(void *, size_t, unsigned char, const void *, size_t);
-extern int x509_note_serial(void *, size_t, unsigned char, const void *, size_t);
-extern int x509_note_signature(void *, size_t, unsigned char, const void *, size_t);
-extern int x509_note_subject(void *, size_t, unsigned char, const void *, size_t);
-extern int x509_note_tbs_certificate(void *, size_t, unsigned char, const void *, size_t);
-extern int x509_process_extension(void *, size_t, unsigned char, const void *, size_t);
-
diff --git a/backport/compat/verification/x509.asn1.c b/backport/compat/verification/x509.asn1.c
new file mode 100644
index 0000000..316c10e
--- /dev/null
+++ b/backport/compat/verification/x509.asn1.c
@@ -0,0 +1,182 @@
+/*
+ * Automatically generated by asn1_compiler.  Do not edit
+ *
+ * ASN.1 parser for x509
+ */
+#include <linux/asn1_ber_bytecode.h>
+#include "x509.asn1.h"
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
diff --git a/backport/compat/verification/x509.asn1.h b/backport/compat/verification/x509.asn1.h
new file mode 100644
index 0000000..4f32a25
--- /dev/null
+++ b/backport/compat/verification/x509.asn1.h
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
deleted file mode 100644
index dd3c6c2..0000000
--- a/backport/compat/verification/x509_akid-asn1.c
+++ /dev/null
@@ -1,144 +0,0 @@
-/*
- * Automatically generated by asn1_compiler.  Do not edit
- *
- * ASN.1 parser for x509_akid
- */
-#include <linux/asn1_ber_bytecode.h>
-#include "x509_akid-asn1.h"
-
-enum x509_akid_actions {
-	ACT_x509_akid_note_kid = 0,
-	ACT_x509_akid_note_name = 1,
-	ACT_x509_akid_note_serial = 2,
-	ACT_x509_extract_name_segment = 3,
-	ACT_x509_note_OID = 4,
-	NR__x509_akid_actions = 5
-};
-
-static const asn1_action_t x509_akid_action_table[NR__x509_akid_actions] = {
-	[   0] = x509_akid_note_kid,
-	[   1] = x509_akid_note_name,
-	[   2] = x509_akid_note_serial,
-	[   3] = x509_extract_name_segment,
-	[   4] = x509_note_OID,
-};
-
-static const unsigned char x509_akid_machine[] = {
-	// AuthorityKeyIdentifier
-	[   0] = ASN1_OP_MATCH,
-	[   1] = _tag(UNIV, CONS, SEQ),
-	// KeyIdentifier
-	[   2] =  ASN1_OP_MATCH_ACT_OR_SKIP,		// keyIdentifier
-	[   3] =  _tagn(CONT, PRIM,  0),
-	[   4] =  _action(ACT_x509_akid_note_kid),
-	// GeneralNames
-	[   5] =  ASN1_OP_MATCH_JUMP_OR_SKIP,		// authorityCertIssuer
-	[   6] =  _tagn(CONT, CONS,  1),
-	[   7] =  _jump_target(13),		// --> GeneralNames
-	// CertificateSerialNumber
-	[   8] =  ASN1_OP_MATCH_ACT_OR_SKIP,		// authorityCertSerialNumber
-	[   9] =  _tagn(CONT, PRIM,  2),
-	[  10] =  _action(ACT_x509_akid_note_serial),
-	[  11] = ASN1_OP_END_SEQ,
-	[  12] = ASN1_OP_COMPLETE,
-
-	// GeneralName
-	[  13] =  ASN1_OP_MATCH_JUMP_OR_SKIP,		// otherName
-	[  14] =  _tagn(CONT, CONS,  0),
-	[  15] =  _jump_target(44),
-	[  16] =  ASN1_OP_COND_MATCH_JUMP_OR_SKIP,		// rfc822Name
-	[  17] =  _tagn(CONT, CONS,  1),
-	[  18] =  _jump_target(47),
-	[  19] =  ASN1_OP_COND_MATCH_JUMP_OR_SKIP,		// dNSName
-	[  20] =  _tagn(CONT, CONS,  2),
-	[  21] =  _jump_target(51),
-	[  22] =  ASN1_OP_COND_MATCH_JUMP_OR_SKIP,		// x400Address
-	[  23] =  _tagn(CONT, CONS,  3),
-	[  24] =  _jump_target(55),
-	[  25] =  ASN1_OP_COND_MATCH_JUMP_OR_SKIP,		// directoryName
-	[  26] =  _tagn(CONT, CONS,  4),
-	[  27] =  _jump_target(58),
-	[  28] =  ASN1_OP_COND_MATCH_JUMP_OR_SKIP,		// ediPartyName
-	[  29] =  _tagn(CONT, CONS,  5),
-	[  30] =  _jump_target(78),
-	[  31] =  ASN1_OP_COND_MATCH_JUMP_OR_SKIP,		// uniformResourceIdentifier
-	[  32] =  _tagn(CONT, CONS,  6),
-	[  33] =  _jump_target(81),
-	[  34] =  ASN1_OP_COND_MATCH_JUMP_OR_SKIP,		// iPAddress
-	[  35] =  _tagn(CONT, CONS,  7),
-	[  36] =  _jump_target(85),
-	[  37] =  ASN1_OP_COND_MATCH_JUMP_OR_SKIP,		// registeredID
-	[  38] =  _tagn(CONT, CONS,  8),
-	[  39] =  _jump_target(89),
-	[  40] =  ASN1_OP_COND_FAIL,
-	[  41] = ASN1_OP_END_SEQ_OF,
-	[  42] = _jump_target(13),
-	[  43] = ASN1_OP_RETURN,
-
-	[  44] =  ASN1_OP_MATCH_ANY,		// otherName
-	[  45] = ASN1_OP_END_SEQ,
-	[  46] = ASN1_OP_RETURN,
-
-	[  47] =  ASN1_OP_MATCH,		// rfc822Name
-	[  48] =  _tag(UNIV, PRIM, IA5STR),
-	[  49] = ASN1_OP_END_SEQ,
-	[  50] = ASN1_OP_RETURN,
-
-	[  51] =  ASN1_OP_MATCH,		// dNSName
-	[  52] =  _tag(UNIV, PRIM, IA5STR),
-	[  53] = ASN1_OP_END_SEQ,
-	[  54] = ASN1_OP_RETURN,
-
-	[  55] =  ASN1_OP_MATCH_ANY,		// x400Address
-	[  56] = ASN1_OP_END_SEQ,
-	[  57] = ASN1_OP_RETURN,
-
-	// Name
-	[  58] =  ASN1_OP_MATCH,
-	[  59] =  _tag(UNIV, CONS, SEQ),
-	// RelativeDistinguishedName
-	[  60] =   ASN1_OP_MATCH,
-	[  61] =   _tag(UNIV, CONS, SET),
-	// AttributeValueAssertion
-	[  62] =    ASN1_OP_MATCH,
-	[  63] =    _tag(UNIV, CONS, SEQ),
-	[  64] =     ASN1_OP_MATCH_ACT,		// attributeType
-	[  65] =     _tag(UNIV, PRIM, OID),
-	[  66] =     _action(ACT_x509_note_OID),
-	[  67] =     ASN1_OP_MATCH_ANY_ACT,		// attributeValue
-	[  68] =     _action(ACT_x509_extract_name_segment),
-	[  69] =    ASN1_OP_END_SEQ,
-	[  70] =   ASN1_OP_END_SET_OF,
-	[  71] =   _jump_target(62),
-	[  72] =  ASN1_OP_END_SEQ_OF,
-	[  73] =  _jump_target(60),
-	[  74] =  ASN1_OP_ACT,
-	[  75] =  _action(ACT_x509_akid_note_name),
-	[  76] = ASN1_OP_END_SEQ,
-	[  77] = ASN1_OP_RETURN,
-
-	[  78] =  ASN1_OP_MATCH_ANY,		// ediPartyName
-	[  79] = ASN1_OP_END_SEQ,
-	[  80] = ASN1_OP_RETURN,
-
-	[  81] =  ASN1_OP_MATCH,		// uniformResourceIdentifier
-	[  82] =  _tag(UNIV, PRIM, IA5STR),
-	[  83] = ASN1_OP_END_SEQ,
-	[  84] = ASN1_OP_RETURN,
-
-	[  85] =  ASN1_OP_MATCH,		// iPAddress
-	[  86] =  _tag(UNIV, PRIM, OTS),
-	[  87] = ASN1_OP_END_SEQ,
-	[  88] = ASN1_OP_RETURN,
-
-	[  89] =  ASN1_OP_MATCH,		// registeredID
-	[  90] =  _tag(UNIV, PRIM, OID),
-	[  91] = ASN1_OP_END_SEQ,
-	[  92] = ASN1_OP_RETURN,
-};
-
-const struct asn1_decoder x509_akid_decoder = {
-	.machine = x509_akid_machine,
-	.machlen = sizeof(x509_akid_machine),
-	.actions = x509_akid_action_table,
-};
diff --git a/backport/compat/verification/x509_akid-asn1.h b/backport/compat/verification/x509_akid-asn1.h
deleted file mode 100644
index 92914da..0000000
--- a/backport/compat/verification/x509_akid-asn1.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/*
- * Automatically generated by asn1_compiler.  Do not edit
- *
- * ASN.1 parser for x509_akid
- */
-#include <linux/asn1_decoder.h>
-
-extern const struct asn1_decoder x509_akid_decoder;
-
-extern int x509_akid_note_kid(void *, size_t, unsigned char, const void *, size_t);
-extern int x509_akid_note_name(void *, size_t, unsigned char, const void *, size_t);
-extern int x509_akid_note_serial(void *, size_t, unsigned char, const void *, size_t);
-extern int x509_extract_name_segment(void *, size_t, unsigned char, const void *, size_t);
-extern int x509_note_OID(void *, size_t, unsigned char, const void *, size_t);
-
diff --git a/backport/compat/verification/x509_akid.asn1.c b/backport/compat/verification/x509_akid.asn1.c
new file mode 100644
index 0000000..10f4802
--- /dev/null
+++ b/backport/compat/verification/x509_akid.asn1.c
@@ -0,0 +1,144 @@
+/*
+ * Automatically generated by asn1_compiler.  Do not edit
+ *
+ * ASN.1 parser for x509_akid
+ */
+#include <linux/asn1_ber_bytecode.h>
+#include "x509_akid.asn1.h"
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
diff --git a/backport/compat/verification/x509_akid.asn1.h b/backport/compat/verification/x509_akid.asn1.h
new file mode 100644
index 0000000..92914da
--- /dev/null
+++ b/backport/compat/verification/x509_akid.asn1.h
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
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
