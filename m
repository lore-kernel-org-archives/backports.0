Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@do-not-panic.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 4/5] compat: firmware class, remove the compat prefix
Date: Thu, 28 Mar 2013 20:18:26 +0100
Message-Id: <1364498307-11855-4-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1364498307-11855-1-git-send-email-hauke@hauke-m.de>
References: <1364498307-11855-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

This depended on some define changing firmware_* to compat_firmware_*
and this should now be used to generate backport_firmware_*. This makes
it export the expected symbols with the backport prefix.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 compat/compat_firmware_class.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/compat/compat_firmware_class.c b/compat/compat_firmware_class.c
index 69b442b..9ea5080 100644
--- a/compat/compat_firmware_class.c
+++ b/compat/compat_firmware_class.c
@@ -21,7 +21,7 @@
 #include <linux/firmware.h>
 #include <linux/slab.h>
 
-#define compat_firmware_to_dev(obj) container_of(obj, struct device, kobj)
+#define backport_firmware_to_dev(obj) container_of(obj, struct device, kobj)
 
 MODULE_AUTHOR("Manuel Estrada Sainz");
 MODULE_DESCRIPTION("Multi purpose firmware loading support");
@@ -324,7 +324,7 @@ static ssize_t firmware_data_read(struct kobject *kobj,
 				  char *buffer, loff_t offset, size_t count)
 #endif
 {
-	struct device *dev = compat_firmware_to_dev(kobj);
+	struct device *dev = backport_firmware_to_dev(kobj);
 	struct firmware_priv *fw_priv = to_firmware_priv(dev);
 	struct firmware *fw;
 	ssize_t ret_count;
@@ -423,7 +423,7 @@ static ssize_t firmware_data_write(struct kobject *kobj,
 				   char *buffer, loff_t offset, size_t count)
 #endif
 {
-	struct device *dev = compat_firmware_to_dev(kobj);
+	struct device *dev = backport_firmware_to_dev(kobj);
 	struct firmware_priv *fw_priv = to_firmware_priv(dev);
 	struct firmware *fw;
 	ssize_t retval;
@@ -635,7 +635,7 @@ out:
  *      firmware image for this or any other device.
  **/
 int
-compat_request_firmware(const struct firmware **firmware_p, const char *name,
+request_firmware(const struct firmware **firmware_p, const char *name,
                  struct device *device)
 {
         int uevent = 1;
@@ -646,7 +646,7 @@ compat_request_firmware(const struct firmware **firmware_p, const char *name,
  * release_firmware: - release the resource associated with a firmware image
  * @fw: firmware resource to release
  **/
-void compat_release_firmware(const struct firmware *fw)
+void release_firmware(const struct firmware *fw)
 {
 	if (fw) {
 		if (!fw_is_builtin_firmware(fw))
@@ -705,7 +705,7 @@ static int request_firmware_work_func(void *arg)
  *	in atomic contexts.
  **/
 int
-compat_request_firmware_nowait(
+request_firmware_nowait(
 	struct module *module, int uevent,
 	const char *name, struct device *device, gfp_t gfp, void *context,
 	void (*cont)(const struct firmware *fw, void *context))
-- 
1.7.10.4
