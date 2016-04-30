Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49600 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752301AbcD3VBG (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 30 Apr 2016 17:01:06 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 07/16] backport: add crypto skcipher interface
Date: Sat, 30 Apr 2016 23:00:39 +0200
Message-Id: <1462050048-8953-8-git-send-email-hauke@hauke-m.de> (sfid-20160430_230113_095981_AED1ADAB)
In-Reply-To: <1462050048-8953-1-git-send-email-hauke@hauke-m.de>
References: <1462050048-8953-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds the crypto skcipher interface which was added in Linux commit
7a7ffe65c8c5f "crypto: skcipher - Add top-level skcipher interface" to
backports.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/crypto/skcipher.h        | 454 +++++++++++++++++++++
 backport/compat/Kconfig                            |  10 +
 backport/compat/Makefile                           |   1 +
 patches/backport-adjustments/crypto-skcipher.patch |  32 ++
 4 files changed, 497 insertions(+)
 create mode 100644 backport/backport-include/crypto/skcipher.h
 create mode 100644 patches/backport-adjustments/crypto-skcipher.patch

diff --git a/backport/backport-include/crypto/skcipher.h b/backport/backport-include/crypto/skcipher.h
new file mode 100644
index 0000000..c5e50cf
--- /dev/null
+++ b/backport/backport-include/crypto/skcipher.h
@@ -0,0 +1,454 @@
+#ifndef _BACKPORT_CRYPTO_SKCIPHER_H
+#define _BACKPORT_CRYPTO_SKCIPHER_H
+#include_next <crypto/skcipher.h>
+#include <linux/version.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,3,0)
+/**
+ *	struct skcipher_request - Symmetric key cipher request
+ *	@cryptlen: Number of bytes to encrypt or decrypt
+ *	@iv: Initialisation Vector
+ *	@src: Source SG list
+ *	@dst: Destination SG list
+ *	@base: Underlying async request request
+ *	@__ctx: Start of private context data
+ */
+#define skcipher_request LINUX_BACKPORT(skcipher_request)
+struct skcipher_request {
+	unsigned int cryptlen;
+
+	u8 *iv;
+
+	struct scatterlist *src;
+	struct scatterlist *dst;
+
+	struct crypto_async_request base;
+
+	void *__ctx[] CRYPTO_MINALIGN_ATTR;
+};
+
+#define crypto_skcipher LINUX_BACKPORT(crypto_skcipher)
+struct crypto_skcipher {
+	int (*setkey)(struct crypto_skcipher *tfm, const u8 *key,
+	              unsigned int keylen);
+	int (*encrypt)(struct skcipher_request *req);
+	int (*decrypt)(struct skcipher_request *req);
+
+	unsigned int ivsize;
+	unsigned int reqsize;
+	unsigned int keysize;
+
+	struct crypto_tfm base;
+};
+
+#ifndef SKCIPHER_REQUEST_ON_STACK
+#define SKCIPHER_REQUEST_ON_STACK(name, tfm) \
+	char __##name##_desc[sizeof(struct skcipher_request) + \
+		crypto_skcipher_reqsize(tfm)] CRYPTO_MINALIGN_ATTR; \
+	struct skcipher_request *name = (void *)__##name##_desc
+#endif
+
+/**
+ * DOC: Symmetric Key Cipher API
+ *
+ * Symmetric key cipher API is used with the ciphers of type
+ * CRYPTO_ALG_TYPE_SKCIPHER (listed as type "skcipher" in /proc/crypto).
+ *
+ * Asynchronous cipher operations imply that the function invocation for a
+ * cipher request returns immediately before the completion of the operation.
+ * The cipher request is scheduled as a separate kernel thread and therefore
+ * load-balanced on the different CPUs via the process scheduler. To allow
+ * the kernel crypto API to inform the caller about the completion of a cipher
+ * request, the caller must provide a callback function. That function is
+ * invoked with the cipher handle when the request completes.
+ *
+ * To support the asynchronous operation, additional information than just the
+ * cipher handle must be supplied to the kernel crypto API. That additional
+ * information is given by filling in the skcipher_request data structure.
+ *
+ * For the symmetric key cipher API, the state is maintained with the tfm
+ * cipher handle. A single tfm can be used across multiple calls and in
+ * parallel. For asynchronous block cipher calls, context data supplied and
+ * only used by the caller can be referenced the request data structure in
+ * addition to the IV used for the cipher request. The maintenance of such
+ * state information would be important for a crypto driver implementer to
+ * have, because when calling the callback function upon completion of the
+ * cipher operation, that callback function may need some information about
+ * which operation just finished if it invoked multiple in parallel. This
+ * state information is unused by the kernel crypto API.
+ */
+
+#define __crypto_skcipher_cast LINUX_BACKPORT(__crypto_skcipher_cast)
+static inline struct crypto_skcipher *__crypto_skcipher_cast(
+	struct crypto_tfm *tfm)
+{
+	return container_of(tfm, struct crypto_skcipher, base);
+}
+
+/**
+ * crypto_alloc_skcipher() - allocate symmetric key cipher handle
+ * @alg_name: is the cra_name / name or cra_driver_name / driver name of the
+ *	      skcipher cipher
+ * @type: specifies the type of the cipher
+ * @mask: specifies the mask for the cipher
+ *
+ * Allocate a cipher handle for an skcipher. The returned struct
+ * crypto_skcipher is the cipher handle that is required for any subsequent
+ * API invocation for that skcipher.
+ *
+ * Return: allocated cipher handle in case of success; IS_ERR() is true in case
+ *	   of an error, PTR_ERR() returns the error code.
+ */
+#define crypto_alloc_skcipher LINUX_BACKPORT(crypto_alloc_skcipher)
+struct crypto_skcipher *crypto_alloc_skcipher(const char *alg_name,
+					      u32 type, u32 mask);
+
+#define crypto_skcipher_tfm LINUX_BACKPORT(crypto_skcipher_tfm)
+static inline struct crypto_tfm *crypto_skcipher_tfm(
+	struct crypto_skcipher *tfm)
+{
+	return &tfm->base;
+}
+
+/**
+ * crypto_free_skcipher() - zeroize and free cipher handle
+ * @tfm: cipher handle to be freed
+ */
+#define crypto_free_skcipher LINUX_BACKPORT(crypto_free_skcipher)
+static inline void crypto_free_skcipher(struct crypto_skcipher *tfm)
+{
+	crypto_destroy_tfm(tfm, crypto_skcipher_tfm(tfm));
+}
+
+/**
+ * crypto_has_skcipher() - Search for the availability of an skcipher.
+ * @alg_name: is the cra_name / name or cra_driver_name / driver name of the
+ *	      skcipher
+ * @type: specifies the type of the cipher
+ * @mask: specifies the mask for the cipher
+ *
+ * Return: true when the skcipher is known to the kernel crypto API; false
+ *	   otherwise
+ */
+#define crypto_has_skcipher LINUX_BACKPORT(crypto_has_skcipher)
+static inline int crypto_has_skcipher(const char *alg_name, u32 type,
+					u32 mask)
+{
+	return crypto_has_alg(alg_name, crypto_skcipher_type(type),
+			      crypto_skcipher_mask(mask));
+}
+
+#define crypto_skcipher_driver_name LINUX_BACKPORT(crypto_skcipher_driver_name)
+static inline const char *crypto_skcipher_driver_name(
+	struct crypto_skcipher *tfm)
+{
+	return crypto_tfm_alg_driver_name(crypto_skcipher_tfm(tfm));
+}
+
+/**
+ * crypto_skcipher_ivsize() - obtain IV size
+ * @tfm: cipher handle
+ *
+ * The size of the IV for the skcipher referenced by the cipher handle is
+ * returned. This IV size may be zero if the cipher does not need an IV.
+ *
+ * Return: IV size in bytes
+ */
+#define crypto_skcipher_ivsize LINUX_BACKPORT(crypto_skcipher_ivsize)
+static inline unsigned int crypto_skcipher_ivsize(struct crypto_skcipher *tfm)
+{
+	return tfm->ivsize;
+}
+
+/**
+ * crypto_skcipher_blocksize() - obtain block size of cipher
+ * @tfm: cipher handle
+ *
+ * The block size for the skcipher referenced with the cipher handle is
+ * returned. The caller may use that information to allocate appropriate
+ * memory for the data returned by the encryption or decryption operation
+ *
+ * Return: block size of cipher
+ */
+#define crypto_skcipher_blocksize LINUX_BACKPORT(crypto_skcipher_blocksize)
+static inline unsigned int crypto_skcipher_blocksize(
+	struct crypto_skcipher *tfm)
+{
+	return crypto_tfm_alg_blocksize(crypto_skcipher_tfm(tfm));
+}
+
+#define crypto_skcipher_alignmask LINUX_BACKPORT(crypto_skcipher_alignmask)
+static inline unsigned int crypto_skcipher_alignmask(
+	struct crypto_skcipher *tfm)
+{
+	return crypto_tfm_alg_alignmask(crypto_skcipher_tfm(tfm));
+}
+
+#define crypto_skcipher_get_flags LINUX_BACKPORT(crypto_skcipher_get_flags)
+static inline u32 crypto_skcipher_get_flags(struct crypto_skcipher *tfm)
+{
+	return crypto_tfm_get_flags(crypto_skcipher_tfm(tfm));
+}
+
+#define crypto_skcipher_set_flags LINUX_BACKPORT(crypto_skcipher_set_flags)
+static inline void crypto_skcipher_set_flags(struct crypto_skcipher *tfm,
+					       u32 flags)
+{
+	crypto_tfm_set_flags(crypto_skcipher_tfm(tfm), flags);
+}
+
+#define crypto_skcipher_clear_flags LINUX_BACKPORT(crypto_skcipher_clear_flags)
+static inline void crypto_skcipher_clear_flags(struct crypto_skcipher *tfm,
+						 u32 flags)
+{
+	crypto_tfm_clear_flags(crypto_skcipher_tfm(tfm), flags);
+}
+
+/**
+ * crypto_skcipher_setkey() - set key for cipher
+ * @tfm: cipher handle
+ * @key: buffer holding the key
+ * @keylen: length of the key in bytes
+ *
+ * The caller provided key is set for the skcipher referenced by the cipher
+ * handle.
+ *
+ * Note, the key length determines the cipher type. Many block ciphers implement
+ * different cipher modes depending on the key size, such as AES-128 vs AES-192
+ * vs. AES-256. When providing a 16 byte key for an AES cipher handle, AES-128
+ * is performed.
+ *
+ * Return: 0 if the setting of the key was successful; < 0 if an error occurred
+ */
+#define crypto_skcipher_setkey LINUX_BACKPORT(crypto_skcipher_setkey)
+static inline int crypto_skcipher_setkey(struct crypto_skcipher *tfm,
+					 const u8 *key, unsigned int keylen)
+{
+	return tfm->setkey(tfm, key, keylen);
+}
+
+#define crypto_skcipher_has_setkey LINUX_BACKPORT(crypto_skcipher_has_setkey)
+static inline bool crypto_skcipher_has_setkey(struct crypto_skcipher *tfm)
+{
+	return tfm->keysize;
+}
+
+#define crypto_skcipher_default_keysize LINUX_BACKPORT(crypto_skcipher_default_keysize)
+static inline unsigned int crypto_skcipher_default_keysize(
+	struct crypto_skcipher *tfm)
+{
+	return tfm->keysize;
+}
+
+/**
+ * crypto_skcipher_reqtfm() - obtain cipher handle from request
+ * @req: skcipher_request out of which the cipher handle is to be obtained
+ *
+ * Return the crypto_skcipher handle when furnishing an skcipher_request
+ * data structure.
+ *
+ * Return: crypto_skcipher handle
+ */
+#define crypto_skcipher_reqtfm LINUX_BACKPORT(crypto_skcipher_reqtfm)
+static inline struct crypto_skcipher *crypto_skcipher_reqtfm(
+	struct skcipher_request *req)
+{
+	return __crypto_skcipher_cast(req->base.tfm);
+}
+
+/**
+ * crypto_skcipher_encrypt() - encrypt plaintext
+ * @req: reference to the skcipher_request handle that holds all information
+ *	 needed to perform the cipher operation
+ *
+ * Encrypt plaintext data using the skcipher_request handle. That data
+ * structure and how it is filled with data is discussed with the
+ * skcipher_request_* functions.
+ *
+ * Return: 0 if the cipher operation was successful; < 0 if an error occurred
+ */
+#define crypto_skcipher_encrypt LINUX_BACKPORT(crypto_skcipher_encrypt)
+static inline int crypto_skcipher_encrypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+
+	return tfm->encrypt(req);
+}
+
+/**
+ * crypto_skcipher_decrypt() - decrypt ciphertext
+ * @req: reference to the skcipher_request handle that holds all information
+ *	 needed to perform the cipher operation
+ *
+ * Decrypt ciphertext data using the skcipher_request handle. That data
+ * structure and how it is filled with data is discussed with the
+ * skcipher_request_* functions.
+ *
+ * Return: 0 if the cipher operation was successful; < 0 if an error occurred
+ */
+#define crypto_skcipher_decrypt LINUX_BACKPORT(crypto_skcipher_decrypt)
+static inline int crypto_skcipher_decrypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+
+	return tfm->decrypt(req);
+}
+
+/**
+ * DOC: Symmetric Key Cipher Request Handle
+ *
+ * The skcipher_request data structure contains all pointers to data
+ * required for the symmetric key cipher operation. This includes the cipher
+ * handle (which can be used by multiple skcipher_request instances), pointer
+ * to plaintext and ciphertext, asynchronous callback function, etc. It acts
+ * as a handle to the skcipher_request_* API calls in a similar way as
+ * skcipher handle to the crypto_skcipher_* API calls.
+ */
+
+/**
+ * crypto_skcipher_reqsize() - obtain size of the request data structure
+ * @tfm: cipher handle
+ *
+ * Return: number of bytes
+ */
+#define crypto_skcipher_reqsize LINUX_BACKPORT(crypto_skcipher_reqsize)
+static inline unsigned int crypto_skcipher_reqsize(struct crypto_skcipher *tfm)
+{
+	return tfm->reqsize;
+}
+
+/**
+ * skcipher_request_set_tfm() - update cipher handle reference in request
+ * @req: request handle to be modified
+ * @tfm: cipher handle that shall be added to the request handle
+ *
+ * Allow the caller to replace the existing skcipher handle in the request
+ * data structure with a different one.
+ */
+#define skcipher_request_set_tfm LINUX_BACKPORT(skcipher_request_set_tfm)
+static inline void skcipher_request_set_tfm(struct skcipher_request *req,
+					    struct crypto_skcipher *tfm)
+{
+	req->base.tfm = crypto_skcipher_tfm(tfm);
+}
+
+#define skcipher_request_cast LINUX_BACKPORT(skcipher_request_cast)
+static inline struct skcipher_request *skcipher_request_cast(
+	struct crypto_async_request *req)
+{
+	return container_of(req, struct skcipher_request, base);
+}
+
+/**
+ * skcipher_request_alloc() - allocate request data structure
+ * @tfm: cipher handle to be registered with the request
+ * @gfp: memory allocation flag that is handed to kmalloc by the API call.
+ *
+ * Allocate the request data structure that must be used with the skcipher
+ * encrypt and decrypt API calls. During the allocation, the provided skcipher
+ * handle is registered in the request data structure.
+ *
+ * Return: allocated request handle in case of success; IS_ERR() is true in case
+ *	   of an error, PTR_ERR() returns the error code.
+ */
+#define skcipher_request LINUX_BACKPORT(skcipher_request)
+static inline struct skcipher_request *skcipher_request_alloc(
+	struct crypto_skcipher *tfm, gfp_t gfp)
+{
+	struct skcipher_request *req;
+
+	req = kmalloc(sizeof(struct skcipher_request) +
+		      crypto_skcipher_reqsize(tfm), gfp);
+
+	if (likely(req))
+		skcipher_request_set_tfm(req, tfm);
+
+	return req;
+}
+
+/**
+ * skcipher_request_free() - zeroize and free request data structure
+ * @req: request data structure cipher handle to be freed
+ */
+#define skcipher_request_free LINUX_BACKPORT(skcipher_request_free)
+static inline void skcipher_request_free(struct skcipher_request *req)
+{
+	kzfree(req);
+}
+
+/**
+ * skcipher_request_set_callback() - set asynchronous callback function
+ * @req: request handle
+ * @flags: specify zero or an ORing of the flags
+ *         CRYPTO_TFM_REQ_MAY_BACKLOG the request queue may back log and
+ *	   increase the wait queue beyond the initial maximum size;
+ *	   CRYPTO_TFM_REQ_MAY_SLEEP the request processing may sleep
+ * @compl: callback function pointer to be registered with the request handle
+ * @data: The data pointer refers to memory that is not used by the kernel
+ *	  crypto API, but provided to the callback function for it to use. Here,
+ *	  the caller can provide a reference to memory the callback function can
+ *	  operate on. As the callback function is invoked asynchronously to the
+ *	  related functionality, it may need to access data structures of the
+ *	  related functionality which can be referenced using this pointer. The
+ *	  callback function can access the memory via the "data" field in the
+ *	  crypto_async_request data structure provided to the callback function.
+ *
+ * This function allows setting the callback function that is triggered once the
+ * cipher operation completes.
+ *
+ * The callback function is registered with the skcipher_request handle and
+ * must comply with the following template
+ *
+ *	void callback_function(struct crypto_async_request *req, int error)
+ */
+#define skcipher_request_set_callback LINUX_BACKPORT(skcipher_request_set_callback)
+static inline void skcipher_request_set_callback(struct skcipher_request *req,
+						 u32 flags,
+						 crypto_completion_t compl,
+						 void *data)
+{
+	req->base.complete = compl;
+	req->base.data = data;
+	req->base.flags = flags;
+}
+
+/**
+ * skcipher_request_set_crypt() - set data buffers
+ * @req: request handle
+ * @src: source scatter / gather list
+ * @dst: destination scatter / gather list
+ * @cryptlen: number of bytes to process from @src
+ * @iv: IV for the cipher operation which must comply with the IV size defined
+ *      by crypto_skcipher_ivsize
+ *
+ * This function allows setting of the source data and destination data
+ * scatter / gather lists.
+ *
+ * For encryption, the source is treated as the plaintext and the
+ * destination is the ciphertext. For a decryption operation, the use is
+ * reversed - the source is the ciphertext and the destination is the plaintext.
+ */
+#define skcipher_request_set_crypt LINUX_BACKPORT(skcipher_request_set_crypt)
+static inline void skcipher_request_set_crypt(
+	struct skcipher_request *req,
+	struct scatterlist *src, struct scatterlist *dst,
+	unsigned int cryptlen, void *iv)
+{
+	req->src = src;
+	req->dst = dst;
+	req->cryptlen = cryptlen;
+	req->iv = iv;
+}
+#endif /* < 4.3 */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,6,0)
+#define skcipher_request_zero LINUX_BACKPORT(skcipher_request_zero)
+static inline void skcipher_request_zero(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+
+	memzero_explicit(req, sizeof(*req) + crypto_skcipher_reqsize(tfm));
+}
+#endif /* < 4.6 */
+
+#endif /* _BACKPORT_CRYPTO_SKCIPHER_H */
diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index b5b9100..710f626 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -113,6 +113,16 @@ config BPAUTO_BUILD_CRYPTO_CCM
 	default y if BPAUTO_CRYPTO_CCM
 	#c-file crypto/ccm.c
 
+config BPAUTO_CRYPTO_SKCIPHER
+	tristate
+	depends on KERNEL_4_3
+	default y if MAC802154
+	default y if LIB80211_CRYPT_WEP
+	default y if LIB80211_CRYPT_TKIP
+	default y if BT
+	#c-file crypto/skcipher.c
+	#module-name skcipher
+
 config BPAUTO_WANT_DEV_COREDUMP
 	bool
 
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 7cbb881..76d71e7 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -33,3 +33,4 @@ compat-$(CPTCFG_KERNEL_4_4) += backport-4.4.o
 compat-$(CPTCFG_KERNEL_4_5) += backport-4.5.o
 
 compat-$(CPTCFG_BPAUTO_BUILD_CRYPTO_CCM) += crypto-ccm.o
+compat-$(CPTCFG_BPAUTO_CRYPTO_SKCIPHER) += crypto-skcipher.o
diff --git a/patches/backport-adjustments/crypto-skcipher.patch b/patches/backport-adjustments/crypto-skcipher.patch
new file mode 100644
index 0000000..c7584c6
--- /dev/null
+++ b/patches/backport-adjustments/crypto-skcipher.patch
@@ -0,0 +1,32 @@
+--- a/compat/crypto-skcipher.c
++++ b/compat/crypto-skcipher.c
+@@ -18,7 +18,28 @@
+ #include <linux/bug.h>
+ #include <linux/module.h>
+ 
+-#include "internal.h"
++struct crypto_tfm *__crypto_alloc_tfm(struct crypto_alg *alg, u32 type,
++				      u32 mask);
++
++void *crypto_alloc_tfm(const char *alg_name,
++		       const struct crypto_type *frontend, u32 type, u32 mask);
++
++struct crypto_alg *crypto_mod_get(struct crypto_alg *alg);
++
++static inline void *crypto_skcipher_ctx(struct crypto_skcipher *tfm)
++{
++	return crypto_tfm_ctx(&tfm->base);
++}
++
++static inline void *skcipher_request_ctx(struct skcipher_request *req)
++{
++	return req->__ctx;
++}
++
++static inline u32 skcipher_request_flags(struct skcipher_request *req)
++{
++	return req->base.flags;
++}
+ 
+ static unsigned int crypto_skcipher_extsize(struct crypto_alg *alg)
+ {
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
