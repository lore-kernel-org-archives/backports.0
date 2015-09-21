Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:51937 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756538AbbIUWHb (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 21 Sep 2015 18:07:31 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 02/10] header: add spi_sync_transfer()
Date: Tue, 22 Sep 2015 00:07:15 +0200
Message-Id: <1442873243-15490-3-git-send-email-hauke@hauke-m.de> (sfid-20150922_000733_400478_A120EE10)
In-Reply-To: <1442873243-15490-1-git-send-email-hauke@hauke-m.de>
References: <1442873243-15490-1-git-send-email-hauke@hauke-m.de>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

spi_sync_transfer() and spi_message_init_with_transfers() are used by
the st-nci nfc driver.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/spi/spi.h | 49 +++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/backport/backport-include/linux/spi/spi.h b/backport/backport-include/linux/spi/spi.h
index 672cf5b..76fd8a2 100644
--- a/backport/backport-include/linux/spi/spi.h
+++ b/backport/backport-include/linux/spi/spi.h
@@ -17,4 +17,53 @@
 			spi_unregister_driver)
 #endif
 
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+/**
+ * spi_message_init_with_transfers - Initialize spi_message and append transfers
+ * @m: spi_message to be initialized
+ * @xfers: An array of spi transfers
+ * @num_xfers: Number of items in the xfer array
+ *
+ * This function initializes the given spi_message and adds each spi_transfer in
+ * the given array to the message.
+ */
+#define spi_message_init_with_transfers LINUX_BACKPORT(spi_message_init_with_transfers)
+static inline void
+spi_message_init_with_transfers(struct spi_message *m,
+struct spi_transfer *xfers, unsigned int num_xfers)
+{
+	unsigned int i;
+
+	spi_message_init(m);
+	for (i = 0; i < num_xfers; ++i)
+		spi_message_add_tail(&xfers[i], m);
+}
+
+/**
+ * spi_sync_transfer - synchronous SPI data transfer
+ * @spi: device with which data will be exchanged
+ * @xfers: An array of spi_transfers
+ * @num_xfers: Number of items in the xfer array
+ * Context: can sleep
+ *
+ * Does a synchronous SPI data transfer of the given spi_transfer array.
+ *
+ * For more specific semantics see spi_sync().
+ *
+ * It returns zero on success, else a negative error code.
+ */
+#define spi_sync_transfer LINUX_BACKPORT(spi_sync_transfer)
+static inline int
+spi_sync_transfer(struct spi_device *spi, struct spi_transfer *xfers,
+	unsigned int num_xfers)
+{
+	struct spi_message msg;
+
+	spi_message_init_with_transfers(&msg, xfers, num_xfers);
+
+	return spi_sync(spi, &msg);
+}
+#endif /* < 3.9 */
+
 #endif /* _BACKPORTS_LINUX_SPI_H */
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
