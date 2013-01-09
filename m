Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 5/5] compat: fix warning in usb_autopm_get_interface_no_{resume,suspend}
Date: Wed,  9 Jan 2013 17:34:23 +0100
Message-Id: <1357749263-4596-5-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1357749263-4596-1-git-send-email-hauke@hauke-m.de>
References: <1357749263-4596-1-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

This fixes the following warning on kernel version <= 2.6.31.

/compat/compat-2.6.33.c: In function ‘usb_autopm_get_interface_no_resume’:
/compat/compat-2.6.33.c:32:2: warning: passing argument 1 of ‘atomic_inc’ from incompatible pointer type [enabled by default]
/arch/x86/include/asm/atomic_64.h:85:20: note: expected ‘struct atomic_t *’ but argument is of type ‘int *’
/compat/compat-2.6.33.c: In function ‘usb_autopm_put_interface_no_suspend’:
/compat/compat-2.6.33.c:51:2: warning: passing argument 1 of ‘atomic_dec’ from incompatible pointer type [enabled by default]
/arch/x86/include/asm/atomic_64.h:98:20: note: expected ‘struct atomic_t *’ but argument is of type ‘int *’

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 compat/compat-2.6.33.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/compat/compat-2.6.33.c b/compat/compat-2.6.33.c
index 6d1c4d8..f584b85 100644
--- a/compat/compat-2.6.33.c
+++ b/compat/compat-2.6.33.c
@@ -29,7 +29,11 @@ void usb_autopm_get_interface_no_resume(struct usb_interface *intf)
 	struct usb_device       *udev = interface_to_usbdev(intf);
 
 	usb_mark_last_busy(udev);
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32))
 	atomic_inc(&intf->pm_usage_cnt);
+#else
+	intf->pm_usage_cnt++;
+#endif
 	pm_runtime_get_noresume(&intf->dev);
 }
 EXPORT_SYMBOL_GPL(usb_autopm_get_interface_no_resume);
@@ -48,7 +52,11 @@ void usb_autopm_put_interface_no_suspend(struct usb_interface *intf)
 	struct usb_device       *udev = interface_to_usbdev(intf);
 
 	usb_mark_last_busy(udev);
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,32))
 	atomic_dec(&intf->pm_usage_cnt);
+#else
+	intf->pm_usage_cnt--;
+#endif
 	pm_runtime_put_noidle(&intf->dev);
 }
 EXPORT_SYMBOL_GPL(usb_autopm_put_interface_no_suspend);
-- 
1.7.10.4
