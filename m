Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:34092 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932313AbdBGWHW (ORCPT <rfc822;backports@vger.kernel.org>);
        Tue, 7 Feb 2017 17:07:22 -0500
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC] backports: always use new version compare macros
Date: Tue,  7 Feb 2017 23:07:16 +0100
Message-Id: <20170207220716.7538-1-johannes@sipsolutions.net> (sfid-20170207_230730_189724_EB07AC60)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../backport-include/asm-generic/pci-dma-compat.h  |  2 +-
 backport/backport-include/asm/atomic.h             |  2 +-
 backport/backport-include/asm/barrier.h            |  2 +-
 backport/backport-include/crypto/aead.h            |  4 +-
 backport/backport-include/crypto/hash.h            |  4 +-
 backport/backport-include/crypto/skcipher.h        |  4 +-
 backport/backport-include/linux/acpi.h             |  8 ++--
 backport/backport-include/linux/bcm47xx_nvram.h    |  6 +--
 backport/backport-include/linux/bp-devcoredump.h   |  8 ++--
 backport/backport-include/linux/clk.h              |  8 ++--
 backport/backport-include/linux/compat.h           |  4 +-
 backport/backport-include/linux/completion.h       |  4 +-
 backport/backport-include/linux/crc7.h             |  2 +-
 backport/backport-include/linux/debugfs.h          |  8 ++--
 backport/backport-include/linux/device.h           | 24 +++++-----
 backport/backport-include/linux/dma-buf.h          | 12 ++---
 backport/backport-include/linux/dma-mapping.h      |  6 +--
 backport/backport-include/linux/dynamic_debug.h    |  2 +-
 backport/backport-include/linux/err.h              |  2 +-
 backport/backport-include/linux/etherdevice.h      | 32 ++++++-------
 backport/backport-include/linux/export.h           |  4 +-
 backport/backport-include/linux/firmware.h         |  2 +-
 backport/backport-include/linux/freezer.h          |  4 +-
 backport/backport-include/linux/fs.h               |  8 ++--
 backport/backport-include/linux/gpio.h             |  2 +-
 backport/backport-include/linux/hashtable.h        |  2 +-
 backport/backport-include/linux/hid.h              |  6 +--
 backport/backport-include/linux/hrtimer.h          |  2 +-
 backport/backport-include/linux/hwmon.h            |  4 +-
 backport/backport-include/linux/i2c-mux.h          |  4 +-
 backport/backport-include/linux/idr.h              |  4 +-
 backport/backport-include/linux/if_vlan.h          |  4 +-
 backport/backport-include/linux/irq.h              |  2 +-
 backport/backport-include/linux/irqdomain.h        |  2 +-
 backport/backport-include/linux/jiffies.h          |  2 +-
 backport/backport-include/linux/kconfig.h          |  2 +-
 backport/backport-include/linux/kernel.h           | 12 ++---
 backport/backport-include/linux/kfifo.h            |  2 +-
 backport/backport-include/linux/ktime.h            |  2 +-
 backport/backport-include/linux/leds.h             | 12 ++---
 backport/backport-include/linux/list.h             |  2 +-
 backport/backport-include/linux/lockdep.h          |  4 +-
 backport/backport-include/linux/math64.h           |  2 +-
 backport/backport-include/linux/mdio.h             |  4 +-
 backport/backport-include/linux/mei_cl_bus.h       |  6 +--
 backport/backport-include/linux/mii.h              |  2 +-
 backport/backport-include/linux/mm.h               | 12 ++---
 backport/backport-include/linux/mmc/host.h         |  4 +-
 backport/backport-include/linux/module.h           |  2 +-
 backport/backport-include/linux/moduleparam.h      |  6 +--
 backport/backport-include/linux/net.h              |  4 +-
 backport/backport-include/linux/netdev_features.h  |  6 +--
 backport/backport-include/linux/netdevice.h        | 54 +++++++++++-----------
 backport/backport-include/linux/netlink.h          |  2 +-
 backport/backport-include/linux/nl80211.h          |  2 +-
 backport/backport-include/linux/of.h               | 40 ++++++++--------
 backport/backport-include/linux/of_address.h       |  4 +-
 backport/backport-include/linux/of_irq.h           |  4 +-
 backport/backport-include/linux/of_platform.h      | 12 ++---
 backport/backport-include/linux/olpc-ec.h          |  4 +-
 backport/backport-include/linux/page_ref.h         |  2 +-
 backport/backport-include/linux/pci.h              | 22 ++++-----
 backport/backport-include/linux/phy.h              |  6 +--
 .../linux/platform_data/media/si4713.h             |  2 +-
 .../platform_data/media/soc_camera_platform.h      |  2 +-
 .../linux/platform_data/media/timb_radio.h         |  2 +-
 .../linux/platform_data/media/timb_video.h         |  2 +-
 backport/backport-include/linux/pm_qos.h           |  4 +-
 backport/backport-include/linux/pm_runtime.h       |  4 +-
 backport/backport-include/linux/poll.h             |  2 +-
 backport/backport-include/linux/printk.h           |  6 +--
 backport/backport-include/linux/proc_fs.h          |  4 +-
 backport/backport-include/linux/ptp_clock_kernel.h |  8 ++--
 backport/backport-include/linux/random.h           | 12 ++---
 backport/backport-include/linux/rculist.h          |  2 +-
 backport/backport-include/linux/regmap.h           |  8 ++--
 backport/backport-include/linux/regulator/driver.h |  8 ++--
 backport/backport-include/linux/rfkill.h           |  2 +-
 backport/backport-include/linux/rtnetlink.h        |  2 +-
 backport/backport-include/linux/scatterlist.h      |  8 ++--
 backport/backport-include/linux/security.h         |  2 +-
 backport/backport-include/linux/seq_file.h         |  6 +--
 backport/backport-include/linux/skbuff.h           | 50 ++++++++++----------
 backport/backport-include/linux/slab.h             |  2 +-
 backport/backport-include/linux/spi/spi.h          |  2 +-
 backport/backport-include/linux/static_key.h       |  4 +-
 backport/backport-include/linux/string.h           | 24 +++++-----
 backport/backport-include/linux/thermal.h          |  8 ++--
 backport/backport-include/linux/time64.h           |  6 +--
 backport/backport-include/linux/timecounter.h      |  2 +-
 backport/backport-include/linux/timekeeping.h      |  6 +--
 backport/backport-include/linux/tty.h              | 12 ++---
 backport/backport-include/linux/tty_flip.h         |  2 +-
 backport/backport-include/linux/types.h            |  2 +-
 backport/backport-include/linux/u64_stats_sync.h   | 12 ++---
 backport/backport-include/linux/uidgid.h           |  4 +-
 backport/backport-include/linux/usb.h              |  4 +-
 backport/backport-include/linux/usb/ch9.h          |  4 +-
 backport/backport-include/linux/version.h          |  3 +-
 backport/backport-include/linux/wait.h             | 10 ++--
 backport/backport-include/linux/watchdog.h         |  2 +-
 backport/backport-include/linux/workqueue.h        |  8 ++--
 backport/backport-include/net/addrconf.h           |  4 +-
 backport/backport-include/net/flow_keys.h          |  2 +-
 backport/backport-include/net/genetlink.h          | 12 ++---
 backport/backport-include/net/inet_frag.h          | 16 +++----
 backport/backport-include/net/ip.h                 |  2 +-
 backport/backport-include/net/ip6_fib.h            |  4 +-
 backport/backport-include/net/ipv6.h               |  8 ++--
 backport/backport-include/net/iw_handler.h         | 18 ++++----
 backport/backport-include/net/net_namespace.h      |  6 +--
 backport/backport-include/net/netlink.h            | 14 +++---
 backport/backport-include/net/sch_generic.h        |  6 +--
 backport/backport-include/net/sock.h               | 10 ++--
 backport/backport-include/net/tso.h                |  2 +-
 backport/backport-include/sound/core.h             |  2 +-
 backport/backport-include/sound/pcm.h              |  4 +-
 backport/backport-include/uapi/linux/genetlink.h   |  2 +-
 backport/backport-include/uapi/linux/sockios.h     |  4 +-
 backport/compat/backport-3.13.c                    |  8 ++--
 backport/compat/backport-3.18.c                    | 26 +++++------
 backport/compat/backport-3.19.c                    |  2 +-
 backport/compat/backport-4.1.c                     |  4 +-
 backport/compat/backport-4.3.c                     |  8 ++--
 backport/compat/backport-4.4.c                     |  2 +-
 backport/compat/backport-4.5.c                     |  6 +--
 backport/compat/compat-3.3.c                       |  6 +--
 backport/compat/compat-3.4.c                       |  8 ++--
 backport/compat/compat-3.5.c                       |  4 +-
 backport/compat/compat-3.7.c                       |  4 +-
 backport/compat/compat-3.8.c                       |  4 +-
 .../0001-group-attr/0001-group_attr_class.cocci    |  4 +-
 patches/0001-group-attr/0002-group_attr_bus.cocci  |  4 +-
 patches/0001-group-attr/0003-class_groups.cocci    |  4 +-
 patches/0001-v4l2-dma_mmap_coherent-revert.patch   |  8 ++--
 .../0002-disable-dump-adjust-on-old-kernels.patch  |  2 +-
 patches/0002-gpio-parent.cocci                     |  8 ++--
 patches/0006-ieee802154-6lowpan-namespace.patch    | 12 ++---
 patches/0007-lowpan-inet_frag_lru_move.patch       |  8 ++--
 patches/0008-net-user-ns.patch                     |  4 +-
 .../drivers_net_wireless_cw1200_sdio.patch         |  2 +-
 .../0014-netlink_seq/net_wireless_nl80211.patch    |  2 +-
 .../drivers_net_wireless_ipw2x00_ipw2100.patch     |  2 +-
 .../drivers_net_wireless_libertas_if_usb.patch     |  2 +-
 patches/0017-get_ts_info/get_ts_info.cocci         |  8 ++--
 patches/0019-usb_driver_lpm.cocci                  |  2 +-
 .../0020-tty-termios/net_bluetooth_hci_ldisc.patch |  8 ++--
 .../net_bluetooth_rfcomm_tty.patch                 |  2 +-
 patches/0021-umode_t-api-change/ath10k.patch       |  2 +-
 patches/0021-umode_t-api-change/ath9k.patch        |  2 +-
 .../drivers_net_wireless_ath_ath9k_debug.patch     |  2 +-
 patches/0022-define-tracing/ath6kl.patch           |  2 +-
 patches/0022-define-tracing/cfg80211.patch         |  2 +-
 patches/0022-define-tracing/mt7601u.patch          |  2 +-
 patches/0022-define-tracing/wil6210.patch          |  2 +-
 patches/0024-led-blink-api/mac80211.patch          |  4 +-
 patches/0025-usb-sg/usbnet.patch                   | 10 ++--
 patches/0026-ipv6_stub/cdc_mbim.patch              |  8 ++--
 patches/0028-select_queue/mac80211.patch           |  8 ++--
 patches/0028-select_queue/mwifiex.patch            |  4 +-
 .../net_bluetooth_hidp_core.patch                  |  4 +-
 patches/0030-qdisc_tx_busylock/bluetooth.patch     |  4 +-
 patches/0030-qdisc_tx_busylock/ieee802154.patch    |  4 +-
 patches/0031-sk_data_ready.cocci                   |  8 ++--
 .../0032-sriov_configure/igb_sriov_configure.patch |  4 +-
 patches/0032-sriov_configure/sriov_configure.cocci |  8 ++--
 patches/0033-ndo_vlan_rx_vid/cdc_mbim.patch        | 20 ++++----
 .../0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch | 32 ++++++-------
 .../0034-ndo_set_vf_spoofchk/set_vf_spoofchk.cocci | 12 ++---
 patches/0035-skb_no_fcs/skb_no_fcs.cocci           |  4 +-
 patches/0036-ethtool_eee/ethtool_eee.cocci         | 16 +++----
 patches/0037-ethtool_get_module/get_module.cocci   | 16 +++----
 .../0038-ethtool_rxfh_indir/igb_rxfh_indir.patch   | 26 +++++------
 patches/0039-ethtool_rxnfc/rxnfc.cocci             |  4 +-
 .../0040-ethtool_cmd_mdix/ethtool_cmd_mdix.cocci   |  8 ++--
 patches/0042-pci_error_handlers/atl1e.patch        |  4 +-
 .../igb_pci_error_handlers.cocci                   |  4 +-
 patches/0043-ndo_set_vf_rate/igb_set_vf_rate.patch |  4 +-
 patches/0043-ndo_set_vf_rate/set_vf_rate.cocci     | 12 ++---
 patches/0044-no_user_ns_in_net/ieee802154.patch    |  4 +-
 patches/0047-write_iter/bluetooth.patch            | 10 ++--
 patches/0049-no-pfmemalloc/no-pfmemalloc.cocci     |  4 +-
 patches/0050-iov_iter/bluetooth.patch              | 28 +++++------
 patches/0051-no-wakeup_path/ssb.patch              |  4 +-
 patches/0052-deactivate-ptp-pin/igb.patch          | 18 ++++----
 .../0053-remove_wait_on_bit_timeout/btusb.patch    |  8 ++--
 .../hci_intel.patch                                | 14 +++---
 patches/0054-struct-proto_ops-sig.cocci            | 36 +++++++--------
 patches/0055-name_assign_type/brcmfmac.patch       |  2 +-
 .../0056-ndo_features_check/features_check.cocci   |  8 ++--
 .../0058-ptp_getsettime64/ptp_getsettime64.cocci   | 12 ++---
 patches/0059-skb_xmit_more/skb_no_xmit_more.cocci  |  4 +-
 patches/0059-uuid-in-mei/nfc.patch                 |  8 ++--
 patches/0060-trace_field_struct/mt7601u.patch      |  4 +-
 patches/0061-termios_rwsem/nfc.patch               |  8 ++--
 patches/0062-acpi-gpio-remove/hci_bcm.patch        | 14 +++---
 patches/0062-acpi-gpio-remove/hci_intel.patch      | 12 ++---
 patches/0062-iff-no-queue.cocci                    |  2 +-
 patches/0065-ndisc_send_na-argument.cocci          |  2 +-
 .../cfg802154.patch                                |  2 +-
 patches/0068-proto-hash/ieee802154.patch           | 10 ++--
 patches/0069-iwlwifi-pd-string-fix.patch           | 10 ++--
 patches/0069-remove-of_irq/bcma.patch              |  2 +-
 patches/0070-mac80211-fils.patch                   |  6 +--
 patches/0071-skb-head_frag/wireless.patch          |  2 +-
 patches/0072-netdevice-ndo_fdb_add/igb.patch       |  2 +-
 patches/0073-netdevice-mtu-range.cocci             |  4 +-
 patches/0074-netdevice-mtu-range-ifdefs.cocci      |  4 +-
 patches/0074-skb-wifi-acked.cocci                  |  2 +-
 patches/0075-ndo-stats-64.cocci                    |  4 +-
 patches/crypto-ccm.patch                           |  2 +-
 patches/devcoredump.patch                          | 12 ++---
 patches/flow_dissector.patch                       |  2 +-
 213 files changed, 736 insertions(+), 737 deletions(-)

diff --git a/backport/backport-include/asm-generic/pci-dma-compat.h b/backport/backport-include/asm-generic/pci-dma-compat.h
index ed4877462cb9..1b1433eff8c5 100644
--- a/backport/backport-include/asm-generic/pci-dma-compat.h
+++ b/backport/backport-include/asm-generic/pci-dma-compat.h
@@ -2,7 +2,7 @@
 #define __BACKPORT_ASM_GENERIC_PCI_DMA_COMPAT_H
 #include_next <asm-generic/pci-dma-compat.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0)
+#if LINUX_VERSION_IS_LESS(3,17,0)
 #define pci_zalloc_consistent LINUX_BACKPORT(pci_zalloc_consistent)
 static inline void *pci_zalloc_consistent(struct pci_dev *hwdev, size_t size,
 					  dma_addr_t *dma_handle)
diff --git a/backport/backport-include/asm/atomic.h b/backport/backport-include/asm/atomic.h
index d5148f0e4b5d..31bddc6b8ca8 100644
--- a/backport/backport-include/asm/atomic.h
+++ b/backport/backport-include/asm/atomic.h
@@ -4,7 +4,7 @@
 #include <linux/version.h>
 #include <asm/barrier.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)
+#if LINUX_VERSION_IS_LESS(3,1,0)
 /*
  * In many versions, several architectures do not seem to include an
  * atomic64_t implementation, and do not include the software emulation from
diff --git a/backport/backport-include/asm/barrier.h b/backport/backport-include/asm/barrier.h
index 981fc76dcc56..9147fb05410f 100644
--- a/backport/backport-include/asm/barrier.h
+++ b/backport/backport-include/asm/barrier.h
@@ -2,7 +2,7 @@
 #define __BACKPORT_ASM_BARRIER_H
 
 #include <linux/version.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0) || \
+#if LINUX_VERSION_IS_GEQ(3,4,0) || \
     defined(CONFIG_ALPHA) || defined(CONFIG_MIPS)
 #include_next <asm/barrier.h>
 #endif /* >= 3.4 */
diff --git a/backport/backport-include/crypto/aead.h b/backport/backport-include/crypto/aead.h
index 97d5ce6cf827..26b135518f45 100644
--- a/backport/backport-include/crypto/aead.h
+++ b/backport/backport-include/crypto/aead.h
@@ -3,7 +3,7 @@
 #include_next <crypto/aead.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)
+#if LINUX_VERSION_IS_LESS(4,2,0)
 #define aead_request_set_ad LINUX_BACKPORT(aead_request_set_ad)
 static inline void aead_request_set_ad(struct aead_request *req,
 				       unsigned int assoclen)
@@ -28,6 +28,6 @@ static inline int backport_crypto_aead_decrypt(struct aead_request *req)
 }
 #define crypto_aead_decrypt LINUX_BACKPORT(crypto_aead_decrypt)
 
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0) */
+#endif /* LINUX_VERSION_IS_LESS(4,2,0) */
 
 #endif /* __BACKPORT_CRYPTO_AEAD_H */
diff --git a/backport/backport-include/crypto/hash.h b/backport/backport-include/crypto/hash.h
index 9c26e0c34e03..96ae799d73af 100644
--- a/backport/backport-include/crypto/hash.h
+++ b/backport/backport-include/crypto/hash.h
@@ -3,7 +3,7 @@
 #include_next <crypto/hash.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,6,0)
+#if LINUX_VERSION_IS_LESS(4,6,0)
 #define shash_desc_zero LINUX_BACKPORT(shash_desc_zero)
 static inline void shash_desc_zero(struct shash_desc *desc)
 {
@@ -12,7 +12,7 @@ static inline void shash_desc_zero(struct shash_desc *desc)
 }
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,6,0)
+#if LINUX_VERSION_IS_LESS(4,6,0)
 #define ahash_request_zero LINUX_BACKPORT(ahash_request_zero)
 static inline void ahash_request_zero(struct ahash_request *req)
 {
diff --git a/backport/backport-include/crypto/skcipher.h b/backport/backport-include/crypto/skcipher.h
index c5e50cf39ca0..73ba7830d5c0 100644
--- a/backport/backport-include/crypto/skcipher.h
+++ b/backport/backport-include/crypto/skcipher.h
@@ -3,7 +3,7 @@
 #include_next <crypto/skcipher.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,3,0)
+#if LINUX_VERSION_IS_LESS(4,3,0)
 /**
  *	struct skcipher_request - Symmetric key cipher request
  *	@cryptlen: Number of bytes to encrypt or decrypt
@@ -441,7 +441,7 @@ static inline void skcipher_request_set_crypt(
 }
 #endif /* < 4.3 */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,6,0)
+#if LINUX_VERSION_IS_LESS(4,6,0)
 #define skcipher_request_zero LINUX_BACKPORT(skcipher_request_zero)
 static inline void skcipher_request_zero(struct skcipher_request *req)
 {
diff --git a/backport/backport-include/linux/acpi.h b/backport/backport-include/linux/acpi.h
index 4c63a2619588..c63648b65423 100644
--- a/backport/backport-include/linux/acpi.h
+++ b/backport/backport-include/linux/acpi.h
@@ -3,7 +3,7 @@
 #include_next <linux/acpi.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0)
+#if LINUX_VERSION_IS_LESS(3,8,0)
 /*
  * Backports
  *
@@ -34,7 +34,7 @@
 #else
 #define ACPI_HANDLE(dev) (NULL)
 #endif /* CONFIG_ACPI */
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,8,0) */
 
 #ifndef ACPI_COMPANION
 #ifdef CONFIG_ACPI
@@ -55,9 +55,9 @@ static inline struct acpi_device *_acpi_get_companion(struct device *dev)
 #endif /* CONFIG_ACPI */
 #endif /* ACPI_COMPANION */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
+#if LINUX_VERSION_IS_LESS(3,19,0)
 #define acpi_dev_remove_driver_gpios LINUX_BACKPORT(acpi_dev_remove_driver_gpios)
 static inline void acpi_dev_remove_driver_gpios(struct acpi_device *adev) {}
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3, 19, 0) */
+#endif /* LINUX_VERSION_IS_LESS(3, 19, 0) */
 
 #endif /* __BACKPORT_LINUX_ACPI_H */
diff --git a/backport/backport-include/linux/bcm47xx_nvram.h b/backport/backport-include/linux/bcm47xx_nvram.h
index ec835f1ad928..5295a023468b 100644
--- a/backport/backport-include/linux/bcm47xx_nvram.h
+++ b/backport/backport-include/linux/bcm47xx_nvram.h
@@ -2,14 +2,14 @@
 #define __BACKPORTS_BCM47XX_NVRAM_H
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
+#if LINUX_VERSION_IS_GEQ(4,1,0)
 #include_next <linux/bcm47xx_nvram.h>
 #else
 #include <linux/types.h>
 #include <linux/kernel.h>
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)
+#if LINUX_VERSION_IS_LESS(4,2,0)
 #define bcm47xx_nvram_get_contents LINUX_BACKPORT(bcm47xx_nvram_get_contents)
 static inline char *bcm47xx_nvram_get_contents(size_t *val_len)
 {
@@ -20,6 +20,6 @@ static inline char *bcm47xx_nvram_get_contents(size_t *val_len)
 static inline void bcm47xx_nvram_release_contents(char *nvram)
 {
 }
-#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
+#endif /* LINUX_VERSION_IS_GEQ(4,1,0) */
 
 #endif /* __BACKPORTS_BCM47XX_NVRAM_H */
diff --git a/backport/backport-include/linux/bp-devcoredump.h b/backport/backport-include/linux/bp-devcoredump.h
index 56b227519cb6..1e4abf646d65 100644
--- a/backport/backport-include/linux/bp-devcoredump.h
+++ b/backport/backport-include/linux/bp-devcoredump.h
@@ -6,8 +6,8 @@
 /* We only need to add our wrapper inside the range from 3.18 until
  * 4.6, outside that we can let our BPAUTO mechanism handle it.
  */
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,18,0) &&	\
-     LINUX_VERSION_CODE < KERNEL_VERSION(4,7,0))
+#if (LINUX_VERSION_IS_GEQ(3,18,0) &&	\
+     LINUX_VERSION_IS_LESS(4,7,0))
 static inline
 void backport_dev_coredumpm(struct device *dev, struct module *owner,
 			    void *data, size_t datalen, gfp_t gfp,
@@ -26,7 +26,7 @@ void backport_dev_coredumpm(struct device *dev, struct module *owner,
 void dev_coredumpsg(struct device *dev, struct scatterlist *table,
 		    size_t datalen, gfp_t gfp);
 
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,18,0) &&	\
-	   LINUX_VERSION_CODE < KERNEL_VERSION(4,7,0)) */
+#endif /* (LINUX_VERSION_IS_GEQ(3,18,0) &&	\
+	   LINUX_VERSION_IS_LESS(4,7,0)) */
 
 #endif /* __BACKPORT_LINUX_DEVCOREDUMP_H */
diff --git a/backport/backport-include/linux/clk.h b/backport/backport-include/linux/clk.h
index c5c45705ca8b..62d9218bb55d 100644
--- a/backport/backport-include/linux/clk.h
+++ b/backport/backport-include/linux/clk.h
@@ -12,7 +12,7 @@
  * CONFIG_COMMON_CLK case. The 3.5 kernel is not supported as
  * per kernel.org so we don't send a fix upstream for that.
  */
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
+#if LINUX_VERSION_IS_LESS(3,6,0)
 
 #ifndef CONFIG_COMMON_CLK
 
@@ -84,10 +84,10 @@ static inline struct clk *clk_get_parent(struct clk *clk)
 }
 #endif /* CONFIG_COMMON_CLK */
 
-#endif /* #if LINUX_VERSION_CODE < KERNEL_VERSION(3,0,0) */
+#endif /* #if LINUX_VERSION_IS_LESS(3,0,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0) && \
-    LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
+#if LINUX_VERSION_IS_LESS(3,3,0) && \
+    LINUX_VERSION_IS_GEQ(3,2,0)
 #define clk_prepare_enable LINUX_BACKPORT(clk_prepare_enable)
 /* clk_prepare_enable helps cases using clk_enable in non-atomic context. */
 static inline int clk_prepare_enable(struct clk *clk)
diff --git a/backport/backport-include/linux/compat.h b/backport/backport-include/linux/compat.h
index 07accd2ec667..f41ee5e6d13d 100644
--- a/backport/backport-include/linux/compat.h
+++ b/backport/backport-include/linux/compat.h
@@ -4,7 +4,7 @@
 #include_next <linux/compat.h>
 #include <linux/version.h>
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0))
+#if LINUX_VERSION_IS_LESS(3,4,0)
 #ifdef CONFIG_X86_X32_ABI
 #define COMPAT_USE_64BIT_TIME \
 	(!!(task_pt_regs(current)->orig_ax & __X32_SYSCALL_BIT))
@@ -13,7 +13,7 @@
 #endif
 #endif
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0))
+#if LINUX_VERSION_IS_LESS(3,4,0)
 #define compat_put_timespec LINUX_BACKPORT(compat_put_timespec)
 extern int compat_put_timespec(const struct timespec *, void __user *);
 #endif
diff --git a/backport/backport-include/linux/completion.h b/backport/backport-include/linux/completion.h
index 477530d216f3..f8ce5b1f7801 100644
--- a/backport/backport-include/linux/completion.h
+++ b/backport/backport-include/linux/completion.h
@@ -3,7 +3,7 @@
 #include_next <linux/completion.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)
+#if LINUX_VERSION_IS_LESS(3,13,0)
 /**
  * reinit_completion - reinitialize a completion structure
  * @x:  pointer to completion structure that is to be reinitialized
@@ -16,6 +16,6 @@ static inline void reinit_completion(struct completion *x)
 {
 	x->done = 0;
 }
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,13,0) */
 
 #endif /* __BACKPORT_COMPLETION_H */
diff --git a/backport/backport-include/linux/crc7.h b/backport/backport-include/linux/crc7.h
index 12747f8cbfab..50706ea92af6 100644
--- a/backport/backport-include/linux/crc7.h
+++ b/backport/backport-include/linux/crc7.h
@@ -3,7 +3,7 @@
 #include_next <linux/crc7.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,16,0)
+#if LINUX_VERSION_IS_LESS(3,16,0)
 #define crc7_be LINUX_BACKPORT(crc7_be)
 static inline u8 crc7_be(u8 crc, const u8 *buffer, size_t len)
 {
diff --git a/backport/backport-include/linux/debugfs.h b/backport/backport-include/linux/debugfs.h
index 651a55b90aff..11670388e39b 100644
--- a/backport/backport-include/linux/debugfs.h
+++ b/backport/backport-include/linux/debugfs.h
@@ -5,7 +5,7 @@
 #include <linux/device.h>
 #include <generated/utsrelease.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
+#if LINUX_VERSION_IS_LESS(3,19,0)
 #define debugfs_create_devm_seqfile LINUX_BACKPORT(debugfs_create_devm_seqfile)
 #if defined(CONFIG_DEBUG_FS)
 struct dentry *debugfs_create_devm_seqfile(struct device *dev, const char *name,
@@ -22,9 +22,9 @@ static inline struct dentry *debugfs_create_devm_seqfile(struct device *dev,
 	return ERR_PTR(-ENODEV);
 }
 #endif /* CONFIG_DEBUG_FS */
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,19,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,4,0)
+#if LINUX_VERSION_IS_LESS(4,4,0)
 #define debugfs_create_bool LINUX_BACKPORT(debugfs_create_bool)
 #ifdef CONFIG_DEBUG_FS
 struct dentry *debugfs_create_bool(const char *name, umode_t mode,
@@ -37,7 +37,7 @@ debugfs_create_bool(const char *name, umode_t mode,
 	return ERR_PTR(-ENODEV);
 }
 #endif
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,4,0) */
+#endif /* LINUX_VERSION_IS_LESS(4,4,0) */
 
 #if LINUX_VERSION_IS_LESS(4,9,0) && \
     !LINUX_VERSION_IN_RANGE(4,8,4, 4,9,0) && \
diff --git a/backport/backport-include/linux/device.h b/backport/backport-include/linux/device.h
index 3e16a1504f98..e0886f5b3cf5 100644
--- a/backport/backport-include/linux/device.h
+++ b/backport/backport-include/linux/device.h
@@ -12,7 +12,7 @@
  */
 #include <linux/string.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+#if LINUX_VERSION_IS_LESS(3,9,0)
 /* backport
  * commit 9f3b795a626ee79574595e06d1437fe0c7d51d29
  * Author: Michał Mirosław <mirq-linux@rere.qmqm.pl>
@@ -49,19 +49,19 @@ static void __exit __driver##_exit(void) \
 module_exit(__driver##_exit);
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+#if LINUX_VERSION_IS_LESS(3,9,0)
 #define devm_ioremap_resource LINUX_BACKPORT(devm_ioremap_resource)
 void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res);
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0) && \
-    LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
+#if LINUX_VERSION_IS_LESS(3,5,0) && \
+    LINUX_VERSION_IS_GEQ(3,2,0)
 #define devres_release LINUX_BACKPORT(devres_release)
 extern int devres_release(struct device *dev, dr_release_t release,
 			  dr_match_t match, void *match_data);
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0)
+#if LINUX_VERSION_IS_LESS(3,5,0)
 #include <linux/ratelimit.h>
 
 #define dev_level_ratelimited(dev_level, dev, fmt, ...)			\
@@ -125,7 +125,7 @@ static inline struct device *kobj_to_dev(struct kobject *kobj)
 }
 #endif /* LINUX_VERSION_CODE <= KERNEL_VERSION(3,6,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0) && RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,0)
+#if LINUX_VERSION_IS_LESS(3,11,0) && RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,0)
 #ifndef DEVICE_ATTR_RO
 #define DEVICE_ATTR_RO(_name) \
 struct device_attribute dev_attr_ ## _name = __ATTR_RO(_name);
@@ -173,16 +173,16 @@ static const struct attribute_group _name##_group = {		\
 static inline void init_##_name##_attrs(void) {}		\
 __ATTRIBUTE_GROUPS(_name)
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)
+#if LINUX_VERSION_IS_LESS(3,13,0)
 #define devm_kmalloc(dev, size, flags) devm_kzalloc(dev, size, flags)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0)
+#if LINUX_VERSION_IS_LESS(3,15,0)
 #define devm_kstrdup LINUX_BACKPORT(devm_kstrdup)
 extern char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp);
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)
+#if LINUX_VERSION_IS_LESS(3,13,0)
 #define devm_kmalloc_array LINUX_BACKPORT(devm_kmalloc_array)
 static inline void *devm_kmalloc_array(struct device *dev,
 				       size_t n, size_t size, gfp_t flags)
@@ -200,7 +200,7 @@ static inline void *devm_kcalloc(struct device *dev,
 }
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,16,0)
+#if LINUX_VERSION_IS_LESS(3,16,0)
 #define devm_kmemdup LINUX_BACKPORT(devm_kmemdup)
 static inline void *devm_kmemdup(struct device *dev, const void *src,
 				 size_t len, gfp_t gfp)
@@ -252,7 +252,7 @@ do {									\
 	dev_level_once(dev_dbg, dev, fmt, ##__VA_ARGS__)
 #endif /* dev_level_once */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0)
+#if LINUX_VERSION_IS_LESS(3,17,0)
 #define devm_kvasprintf LINUX_BACKPORT(devm_kvasprintf)
 extern char *devm_kvasprintf(struct device *dev, gfp_t gfp, const char *fmt,
 			     va_list ap);
@@ -261,7 +261,7 @@ extern char *devm_kasprintf(struct device *dev, gfp_t gfp,
 			    const char *fmt, ...);
 #endif /* < 3.17 */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 1, 0)
+#if LINUX_VERSION_IS_LESS(4, 1, 0)
 #define dev_of_node LINUX_BACKPORT(dev_of_node)
 static inline struct device_node *dev_of_node(struct device *dev)
 {
diff --git a/backport/backport-include/linux/dma-buf.h b/backport/backport-include/linux/dma-buf.h
index 07ac0b4afe18..ef1d0d3d5c30 100644
--- a/backport/backport-include/linux/dma-buf.h
+++ b/backport/backport-include/linux/dma-buf.h
@@ -1,14 +1,14 @@
 #ifndef _BACKPORT_DMA_BUF_H__
 #define _BACKPORT_DMA_BUF_H__
 #include <linux/version.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
+#if LINUX_VERSION_IS_GEQ(3,3,0)
 #include_next <linux/dma-buf.h>
-#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) */
+#endif /* LINUX_VERSION_IS_GEQ(3,3,0) */
 #include <linux/dma-direction.h>
 #include <linux/dma-attrs.h>
 #include <linux/dma-mapping.h>
 
-#if !defined(DEFINE_DMA_BUF_EXPORT_INFO) && LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
+#if !defined(DEFINE_DMA_BUF_EXPORT_INFO) && LINUX_VERSION_IS_GEQ(3,3,0)
 /**
  * helper macro for exporters; zeros and fills in most common values
  */
@@ -31,14 +31,14 @@ struct dma_buf_export_info {
 static inline
 struct dma_buf *backport_dma_buf_export(const struct dma_buf_export_info *exp_info)
 {
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)
+#if LINUX_VERSION_IS_LESS(3,4,0)
 	return dma_buf_export(exp_info->priv,
 			      (struct dma_buf_ops *)exp_info->ops,
 			      exp_info->size, exp_info->flags);
-#elif LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
+#elif LINUX_VERSION_IS_LESS(3,10,0)
 	return dma_buf_export(exp_info->priv, exp_info->ops,
 			      exp_info->size, exp_info->flags);
-#elif LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0)
+#elif LINUX_VERSION_IS_LESS(3,17,0)
 	return dma_buf_export_named(exp_info->priv, exp_info->ops,
 				    exp_info->size, exp_info->flags,
 				    exp_info->exp_name);
diff --git a/backport/backport-include/linux/dma-mapping.h b/backport/backport-include/linux/dma-mapping.h
index fdc3331b63fb..16b0e3c63ea7 100644
--- a/backport/backport-include/linux/dma-mapping.h
+++ b/backport/backport-include/linux/dma-mapping.h
@@ -3,7 +3,7 @@
 #include_next <linux/dma-mapping.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0)
+#if LINUX_VERSION_IS_LESS(3,2,0)
 #define dma_zalloc_coherent LINUX_BACKPORT(dma_zalloc_coherent)
 static inline void *dma_zalloc_coherent(struct device *dev, size_t size,
 					dma_addr_t *dma_handle, gfp_t flag)
@@ -15,7 +15,7 @@ static inline void *dma_zalloc_coherent(struct device *dev, size_t size,
 }
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)
+#if LINUX_VERSION_IS_LESS(3,13,0)
 /*
  * Set both the DMA mask and the coherent DMA mask to the same thing.
  * Note that we don't check the return value from dma_set_coherent_mask()
@@ -30,6 +30,6 @@ static inline int dma_set_mask_and_coherent(struct device *dev, u64 mask)
 		dma_set_coherent_mask(dev, mask);
 	return rc;
 }
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,13,0) */
 
 #endif /* __BACKPORT_LINUX_DMA_MAPPING_H */
diff --git a/backport/backport-include/linux/dynamic_debug.h b/backport/backport-include/linux/dynamic_debug.h
index ee2a67c00776..1ff204be8fcf 100644
--- a/backport/backport-include/linux/dynamic_debug.h
+++ b/backport/backport-include/linux/dynamic_debug.h
@@ -3,7 +3,7 @@
 #include <linux/version.h>
 #include_next <linux/dynamic_debug.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0)
+#if LINUX_VERSION_IS_LESS(3,2,0)
 /* backports 07613b0b */
 #if defined(CONFIG_DYNAMIC_DEBUG)
 #if (RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(6,4))
diff --git a/backport/backport-include/linux/err.h b/backport/backport-include/linux/err.h
index 62ee1e8f2c4f..d08968e5e2d0 100644
--- a/backport/backport-include/linux/err.h
+++ b/backport/backport-include/linux/err.h
@@ -3,7 +3,7 @@
 #include_next <linux/err.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,12,0)
+#if LINUX_VERSION_IS_LESS(3,12,0)
 #define PTR_ERR_OR_ZERO(p) PTR_RET(p)
 #endif
 
diff --git a/backport/backport-include/linux/etherdevice.h b/backport/backport-include/linux/etherdevice.h
index b12a578beffa..92256e005169 100644
--- a/backport/backport-include/linux/etherdevice.h
+++ b/backport/backport-include/linux/etherdevice.h
@@ -8,7 +8,7 @@
  */
 #include <asm/unaligned.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)
+#if LINUX_VERSION_IS_LESS(3,4,0)
 #define eth_hw_addr_random LINUX_BACKPORT(eth_hw_addr_random)
 static inline void eth_hw_addr_random(struct net_device *dev)
 {
@@ -17,7 +17,7 @@ static inline void eth_hw_addr_random(struct net_device *dev)
 }
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
+#if LINUX_VERSION_IS_LESS(3,6,0)
 #include <linux/random.h>
 /**
  * eth_broadcast_addr - Assign broadcast address
@@ -45,9 +45,9 @@ static inline void eth_random_addr(u8 *addr)
 	addr[0] &= 0xfe;        /* clear multicast bit */
 	addr[0] |= 0x02;        /* set local assignment bit (IEEE802) */
 }
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,6,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
+#if LINUX_VERSION_IS_LESS(3,7,0)
 
 /* This backports:
  *
@@ -64,7 +64,7 @@ static inline void eth_zero_addr(u8 *addr)
 }
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0)
+#if LINUX_VERSION_IS_LESS(3,5,0)
 #define ether_addr_equal LINUX_BACKPORT(ether_addr_equal)
 static inline bool ether_addr_equal(const u8 *addr1, const u8 *addr2)
 {
@@ -72,7 +72,7 @@ static inline bool ether_addr_equal(const u8 *addr1, const u8 *addr2)
 }
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+#if LINUX_VERSION_IS_LESS(3,9,0)
 #define eth_prepare_mac_addr_change LINUX_BACKPORT(eth_prepare_mac_addr_change)
 extern int eth_prepare_mac_addr_change(struct net_device *dev, void *p);
 
@@ -80,7 +80,7 @@ extern int eth_prepare_mac_addr_change(struct net_device *dev, void *p);
 extern void eth_commit_mac_addr_change(struct net_device *dev, void *p);
 #endif /* < 3.9 */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,12,0)
+#if LINUX_VERSION_IS_LESS(3,12,0)
 /**
  * eth_hw_addr_inherit - Copy dev_addr from another net_device
  * @dst: pointer to net_device to copy dev_addr to
@@ -95,9 +95,9 @@ static inline void eth_hw_addr_inherit(struct net_device *dst,
 	dst->addr_assign_type = src->addr_assign_type;
 	memcpy(dst->dev_addr, src->dev_addr, ETH_ALEN);
 }
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,13,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0)
+#if LINUX_VERSION_IS_LESS(3,5,0)
 /**
  * ether_addr_equal_64bits - Compare two Ethernet addresses
  * @addr1: Pointer to an array of 8 bytes
@@ -127,9 +127,9 @@ static inline bool ether_addr_equal_64bits(const u8 addr1[6+2],
 	return ether_addr_equal(addr1, addr2);
 #endif
 }
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,5,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0)
+#if LINUX_VERSION_IS_LESS(3,14,0)
 /**
  * ether_addr_equal_unaligned - Compare two not u16 aligned Ethernet addresses
  * @addr1: Pointer to a six-byte array containing the Ethernet address
@@ -171,14 +171,14 @@ static inline void ether_addr_copy(u8 *dst, const u8 *src)
 	a[2] = b[2];
 #endif
 }
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,14,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,18,0)
+#if LINUX_VERSION_IS_LESS(3,18,0)
 #define eth_get_headlen LINUX_BACKPORT(eth_get_headlen)
 int eth_get_headlen(unsigned char *data, unsigned int max_len);
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,18,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,18,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
+#if LINUX_VERSION_IS_LESS(3,19,0)
 #define eth_skb_pad LINUX_BACKPORT(eth_skb_pad)
 /**
  * eth_skb_pad - Pad buffer to mininum number of octets for Ethernet frame
@@ -191,6 +191,6 @@ static inline int eth_skb_pad(struct sk_buff *skb)
 {
 	return skb_put_padto(skb, ETH_ZLEN);
 }
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,19,0) */
 
 #endif /* _BACKPORT_LINUX_ETHERDEVICE_H */
diff --git a/backport/backport-include/linux/export.h b/backport/backport-include/linux/export.h
index 36861976c762..6f6cb6a90cde 100644
--- a/backport/backport-include/linux/export.h
+++ b/backport/backport-include/linux/export.h
@@ -3,7 +3,7 @@
 
 #include <linux/version.h>
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
+#if LINUX_VERSION_IS_GEQ(3,2,0)
 #include_next <linux/export.h>
 #else
 #ifndef pr_fmt
@@ -14,6 +14,6 @@
 #undef pr_fmt
 #undef backport_undef_pr_fmt
 #endif
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)) */
+#endif /* LINUX_VERSION_IS_GEQ(3,2,0) */
 
 #endif	/* _COMPAT_LINUX_EXPORT_H */
diff --git a/backport/backport-include/linux/firmware.h b/backport/backport-include/linux/firmware.h
index 46355124d068..186eec3e41af 100644
--- a/backport/backport-include/linux/firmware.h
+++ b/backport/backport-include/linux/firmware.h
@@ -2,7 +2,7 @@
 #define __BACKPORT_LINUX_FIRMWARE_H
 #include_next <linux/firmware.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0)
+#if LINUX_VERSION_IS_LESS(3,14,0)
 #define request_firmware_direct(fw, name, device) request_firmware(fw, name, device)
 #endif
 
diff --git a/backport/backport-include/linux/freezer.h b/backport/backport-include/linux/freezer.h
index 6bd6985d70c9..c6053f300a83 100644
--- a/backport/backport-include/linux/freezer.h
+++ b/backport/backport-include/linux/freezer.h
@@ -3,7 +3,7 @@
 #include_next <linux/freezer.h>
 
 #ifdef CONFIG_FREEZER
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)
+#if LINUX_VERSION_IS_LESS(3,11,0)
 /*
  * Like schedule_hrtimeout_range(), but should not block the freezer.  Do not
  * call this with locks held.
@@ -18,7 +18,7 @@ static inline int freezable_schedule_hrtimeout_range(ktime_t *expires,
 	freezer_count();
 	return __retval;
 }
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,11,0) */
 
 #else /* !CONFIG_FREEZER */
 
diff --git a/backport/backport-include/linux/fs.h b/backport/backport-include/linux/fs.h
index 42fb1e968d80..6e4d4a53dfbf 100644
--- a/backport/backport-include/linux/fs.h
+++ b/backport/backport-include/linux/fs.h
@@ -8,12 +8,12 @@
  */
 #include <linux/uidgid.h>
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0))
+#if LINUX_VERSION_IS_LESS(3,4,0)
 #define simple_open LINUX_BACKPORT(simple_open)
 extern int simple_open(struct inode *inode, struct file *file);
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+#if LINUX_VERSION_IS_LESS(3,9,0)
 /**
  * backport of:
  *
@@ -43,8 +43,8 @@ static inline struct inode *file_inode(struct file *f)
 	} while(0)
 #endif /* replace_fops */
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(4,5,0) && \
-     LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
+#if (LINUX_VERSION_IS_LESS(4,5,0) && \
+     LINUX_VERSION_IS_GEQ(3,2,0))
 #define no_seek_end_llseek LINUX_BACKPORT(no_seek_end_llseek)
 extern loff_t no_seek_end_llseek(struct file *, loff_t, int);
 #endif /* < 4.5 && >= 3.2 */
diff --git a/backport/backport-include/linux/gpio.h b/backport/backport-include/linux/gpio.h
index 964f1f3683de..ef4a8f18a27b 100644
--- a/backport/backport-include/linux/gpio.h
+++ b/backport/backport-include/linux/gpio.h
@@ -2,7 +2,7 @@
 #define __BACKPORT_LINUX_GPIO_H
 #include_next <linux/gpio.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0)
+#if LINUX_VERSION_IS_LESS(3,5,0)
 #define devm_gpio_request_one LINUX_BACKPORT(devm_gpio_request_one)
 #define devm_gpio_request LINUX_BACKPORT(devm_gpio_request)
 #ifdef CONFIG_GPIOLIB
diff --git a/backport/backport-include/linux/hashtable.h b/backport/backport-include/linux/hashtable.h
index dc53e749c215..33314dc50fec 100644
--- a/backport/backport-include/linux/hashtable.h
+++ b/backport/backport-include/linux/hashtable.h
@@ -3,7 +3,7 @@
 #include_next <linux/hashtable.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+#if LINUX_VERSION_IS_LESS(3,9,0)
 /**
  * backport:
  *
diff --git a/backport/backport-include/linux/hid.h b/backport/backport-include/linux/hid.h
index 91d3de6aa9b9..887c6b152019 100644
--- a/backport/backport-include/linux/hid.h
+++ b/backport/backport-include/linux/hid.h
@@ -3,12 +3,12 @@
 #include_next <linux/hid.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0)
+#if LINUX_VERSION_IS_LESS(3,8,0)
 #define hid_ignore LINUX_BACKPORT(hid_ignore)
 extern bool hid_ignore(struct hid_device *);
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)
+#if LINUX_VERSION_IS_LESS(3,1,0)
 #define HID_TYPE_USBNONE 2
 #endif
 
@@ -79,7 +79,7 @@ extern bool hid_ignore(struct hid_device *);
 	dev_dbg(&(hid)->dev, fmt, ##arg)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,12,0)
+#if LINUX_VERSION_IS_LESS(3,12,0)
 #define hid_alloc_report_buf LINUX_BACKPORT(hid_alloc_report_buf)
 u8 *hid_alloc_report_buf(struct hid_report *report, gfp_t flags);
 #endif
diff --git a/backport/backport-include/linux/hrtimer.h b/backport/backport-include/linux/hrtimer.h
index 28fc89979ee9..bdcf106e1678 100644
--- a/backport/backport-include/linux/hrtimer.h
+++ b/backport/backport-include/linux/hrtimer.h
@@ -4,7 +4,7 @@
 #include_next <linux/hrtimer.h>
 #include <linux/interrupt.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,10,0)
+#if LINUX_VERSION_IS_LESS(4,10,0)
 static inline void backport_hrtimer_start(struct hrtimer *timer, s64 time,
 					  const enum hrtimer_mode mode)
 {
diff --git a/backport/backport-include/linux/hwmon.h b/backport/backport-include/linux/hwmon.h
index c0185f18ede8..3b61b26812e2 100644
--- a/backport/backport-include/linux/hwmon.h
+++ b/backport/backport-include/linux/hwmon.h
@@ -3,7 +3,7 @@
 #include_next <linux/hwmon.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)
+#if LINUX_VERSION_IS_LESS(3,13,0)
 /*
  * Backports
  *
@@ -29,6 +29,6 @@ struct device *
 devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
 				       void *drvdata,
 				       const struct attribute_group **groups);
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,13,0) */
 
 #endif /* __BACKPORT_LINUX_HWMON_H */
diff --git a/backport/backport-include/linux/i2c-mux.h b/backport/backport-include/linux/i2c-mux.h
index 37db84d46e5a..d12658dca2e3 100644
--- a/backport/backport-include/linux/i2c-mux.h
+++ b/backport/backport-include/linux/i2c-mux.h
@@ -3,10 +3,10 @@
 #include_next <linux/i2c-mux.h>
 #include <linux/version.h>
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0))
+#if LINUX_VERSION_IS_LESS(3,5,0)
 #define i2c_add_mux_adapter(parent, mux_dev, mux_priv, force_nr, chan_id, class, select, deselect) \
 	i2c_add_mux_adapter(parent, mux_priv, force_nr, chan_id, select, deselect)
-#elif (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0))
+#elif LINUX_VERSION_IS_LESS(3,7,0)
 #define i2c_add_mux_adapter(parent, mux_dev, mux_priv, force_nr, chan_id, class, select, deselect) \
 	i2c_add_mux_adapter(parent, mux_dev, mux_priv, force_nr, chan_id, select, deselect)
 #endif
diff --git a/backport/backport-include/linux/idr.h b/backport/backport-include/linux/idr.h
index 0d4792ee4c55..d7cf9f0f0e0e 100644
--- a/backport/backport-include/linux/idr.h
+++ b/backport/backport-include/linux/idr.h
@@ -5,7 +5,7 @@
 #include_next <linux/idr.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)
+#if LINUX_VERSION_IS_LESS(3,1,0)
 #define ida_simple_get LINUX_BACKPORT(ida_simple_get)
 int ida_simple_get(struct ida *ida, unsigned int start, unsigned int end,
 		   gfp_t gfp_mask);
@@ -14,7 +14,7 @@ int ida_simple_get(struct ida *ida, unsigned int start, unsigned int end,
 void ida_simple_remove(struct ida *ida, unsigned int id);
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+#if LINUX_VERSION_IS_LESS(3,9,0)
 #include <linux/errno.h>
 /**
  * backport of idr idr_alloc() usage
diff --git a/backport/backport-include/linux/if_vlan.h b/backport/backport-include/linux/if_vlan.h
index f9ddc806f9b3..18f63e80d214 100644
--- a/backport/backport-include/linux/if_vlan.h
+++ b/backport/backport-include/linux/if_vlan.h
@@ -2,7 +2,7 @@
 #define __BACKPORT_LINUX_IF_VLAN_H_
 #include_next <linux/if_vlan.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
+#if LINUX_VERSION_IS_LESS(3,10,0)
 #define vlan_insert_tag(__skb, __vlan_proto, __vlan_tci)	vlan_insert_tag(__skb, __vlan_tci)
 #define __vlan_put_tag(__skb, __vlan_proto, __vlan_tci)		__vlan_put_tag(__skb, __vlan_tci)
 #define vlan_put_tag(__skb, __vlan_proto, __vlan_tci)		vlan_put_tag(__skb, __vlan_tci)
@@ -20,7 +20,7 @@
 #define VLAN_PRIO_SHIFT		13
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,16,0)
+#if LINUX_VERSION_IS_LESS(3,16,0)
 #define __vlan_find_dev_deep_rcu(real_dev, vlan_proto, vlan_id) __vlan_find_dev_deep(real_dev, vlan_proto, vlan_id)
 #endif
 
diff --git a/backport/backport-include/linux/irq.h b/backport/backport-include/linux/irq.h
index 29b543bd081d..e216f4f86a94 100644
--- a/backport/backport-include/linux/irq.h
+++ b/backport/backport-include/linux/irq.h
@@ -3,7 +3,7 @@
 #include_next <linux/irq.h>
 
 #ifdef CONFIG_HAVE_GENERIC_HARDIRQS
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)
+#if LINUX_VERSION_IS_LESS(3,11,0)
 #define irq_get_trigger_type LINUX_BACKPORT(irq_get_trigger_type)
 static inline u32 irq_get_trigger_type(unsigned int irq)
 {
diff --git a/backport/backport-include/linux/irqdomain.h b/backport/backport-include/linux/irqdomain.h
index a889a2906a7f..1878a29e2b19 100644
--- a/backport/backport-include/linux/irqdomain.h
+++ b/backport/backport-include/linux/irqdomain.h
@@ -2,7 +2,7 @@
 #define __BACKPORT_LINUX_IRQDOMAIN_H
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,1,0)
+#if LINUX_VERSION_IS_GEQ(3,1,0)
 #include_next <linux/irqdomain.h>
 #endif
 
diff --git a/backport/backport-include/linux/jiffies.h b/backport/backport-include/linux/jiffies.h
index 9cff5e974b06..bbadcc8cd27e 100644
--- a/backport/backport-include/linux/jiffies.h
+++ b/backport/backport-include/linux/jiffies.h
@@ -22,7 +22,7 @@
  * This function is available, but not exported in kernel < 3.17, add
  * an own version.
  */
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0)
+#if LINUX_VERSION_IS_LESS(3,17,0)
 #define nsecs_to_jiffies LINUX_BACKPORT(nsecs_to_jiffies)
 extern unsigned long nsecs_to_jiffies(u64 n);
 #endif /* 3.17 */
diff --git a/backport/backport-include/linux/kconfig.h b/backport/backport-include/linux/kconfig.h
index e284dca1af71..d1faad9b381e 100644
--- a/backport/backport-include/linux/kconfig.h
+++ b/backport/backport-include/linux/kconfig.h
@@ -1,7 +1,7 @@
 #ifndef __BACKPORT_LINUX_KCONFIG_H
 #define __BACKPORT_LINUX_KCONFIG_H
 #include <linux/version.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,1,0)
+#if LINUX_VERSION_IS_GEQ(3,1,0)
 #include_next <linux/kconfig.h>
 #endif
 
diff --git a/backport/backport-include/linux/kernel.h b/backport/backport-include/linux/kernel.h
index c704b43b2f25..4ad000c22de5 100644
--- a/backport/backport-include/linux/kernel.h
+++ b/backport/backport-include/linux/kernel.h
@@ -150,25 +150,25 @@
 )
 #endif /* rounddown */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0)
+#if LINUX_VERSION_IS_LESS(3,2,0)
 /* kernels before 3.2 didn't have error checking for the function */
 #define hex2bin LINUX_BACKPORT(hex2bin)
 int __must_check hex2bin(u8 *dst, const char *src, size_t count);
 #endif /* < 3.2 */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,18,0)
+#if LINUX_VERSION_IS_LESS(3,18,0)
 #undef clamp
 #define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
 #endif /* < 3.18 */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,6,0)
+#if LINUX_VERSION_IS_LESS(4,6,0)
 #define kstrtobool LINUX_BACKPORT(kstrtobool)
 int __must_check kstrtobool(const char *s, bool *res);
 #define kstrtobool_from_user LINUX_BACKPORT(kstrtobool_from_user)
 int __must_check kstrtobool_from_user(const char __user *s, size_t count, bool *res);
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,5,0)
+#if LINUX_VERSION_IS_LESS(4,5,0)
 
 #undef abs
 /**
@@ -196,12 +196,12 @@ int __must_check kstrtobool_from_user(const char __user *s, size_t count, bool *
 
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0)
+#if LINUX_VERSION_IS_LESS(3,14,0)
 static inline u32 reciprocal_scale(u32 val, u32 ep_ro)
 {
 	return (u32)(((u64) val * ep_ro) >> 32);
 }
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,14,0) */
 
 #endif /* __BACKPORT_KERNEL_H */
 
diff --git a/backport/backport-include/linux/kfifo.h b/backport/backport-include/linux/kfifo.h
index b797a0e6a034..b4fda3c3e92a 100644
--- a/backport/backport-include/linux/kfifo.h
+++ b/backport/backport-include/linux/kfifo.h
@@ -4,7 +4,7 @@
 #include <linux/version.h>
 #include_next <linux/kfifo.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)
+#if LINUX_VERSION_IS_LESS(3,13,0)
 #undef kfifo_put
 /**
  * kfifo_put - put data into the fifo
diff --git a/backport/backport-include/linux/ktime.h b/backport/backport-include/linux/ktime.h
index 33ed31caf01a..942729682c42 100644
--- a/backport/backport-include/linux/ktime.h
+++ b/backport/backport-include/linux/ktime.h
@@ -4,7 +4,7 @@
 #include <linux/timekeeping.h>
 #include <linux/version.h>
 
-#if  LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0)
+#if  LINUX_VERSION_IS_LESS(3,17,0)
 #define ktime_get_raw LINUX_BACKPORT(ktime_get_raw)
 extern ktime_t ktime_get_raw(void);
 
diff --git a/backport/backport-include/linux/leds.h b/backport/backport-include/linux/leds.h
index 6cc9e1941104..b98f8a51d14e 100644
--- a/backport/backport-include/linux/leds.h
+++ b/backport/backport-include/linux/leds.h
@@ -6,7 +6,7 @@
 #include <backport/leds-disabled.h>
 
 #ifndef CPTCFG_BPAUTO_BUILD_LEDS
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
+#if LINUX_VERSION_IS_LESS(3,6,0)
 /*
  * Backports
  *
@@ -27,10 +27,10 @@
  *   Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
  */
 #define led_set_brightness(_dev, _switch) led_brightness_set(_dev, _switch)
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,6,0) */
 #endif /* CPTCFG_BPAUTO_BUILD_LEDS */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)
+#if LINUX_VERSION_IS_LESS(4,2,0)
 /*
  * There is no LINUX_BACKPORT() guard here because we want it to point to
  * the original function which is exported normally.
@@ -42,8 +42,8 @@ static inline void led_trigger_remove(struct led_classdev *led_cdev) {}
 #endif
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,5,0) && \
-    LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
+#if LINUX_VERSION_IS_LESS(4,5,0) && \
+    LINUX_VERSION_IS_GEQ(3,19,0)
 #define led_set_brightness_sync LINUX_BACKPORT(led_set_brightness_sync)
 /**
  * led_set_brightness_sync - set LED brightness synchronously
@@ -60,7 +60,7 @@ extern int led_set_brightness_sync(struct led_classdev *led_cdev,
 				   enum led_brightness value);
 #endif /* < 4.5 && >= 3.19 */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,5,0)
+#if LINUX_VERSION_IS_LESS(4,5,0)
 #define devm_led_trigger_register LINUX_BACKPORT(devm_led_trigger_register)
 extern int devm_led_trigger_register(struct device *dev,
 				     struct led_trigger *trigger);
diff --git a/backport/backport-include/linux/list.h b/backport/backport-include/linux/list.h
index 3fbc10b46931..13ab9762c35c 100644
--- a/backport/backport-include/linux/list.h
+++ b/backport/backport-include/linux/list.h
@@ -3,7 +3,7 @@
 #include_next <linux/list.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+#if LINUX_VERSION_IS_LESS(3,9,0)
 /**
  * backport:
  *
diff --git a/backport/backport-include/linux/lockdep.h b/backport/backport-include/linux/lockdep.h
index 3974b8d73d06..5a5d0d0e627f 100644
--- a/backport/backport-include/linux/lockdep.h
+++ b/backport/backport-include/linux/lockdep.h
@@ -3,7 +3,7 @@
 #include_next <linux/lockdep.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+#if LINUX_VERSION_IS_LESS(3,9,0)
 #undef lockdep_assert_held
 #ifdef CONFIG_LOCKDEP
 #define lockdep_assert_held(l)	do {				\
@@ -12,6 +12,6 @@
 #else
 #define lockdep_assert_held(l)			do { (void)(l); } while (0)
 #endif /* CONFIG_LOCKDEP */
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,9,0) */
 
 #endif /* __BACKPORT_LINUX_LOCKDEP_H */
diff --git a/backport/backport-include/linux/math64.h b/backport/backport-include/linux/math64.h
index 2fbde06ceee6..4aeb0dfbb04f 100644
--- a/backport/backport-include/linux/math64.h
+++ b/backport/backport-include/linux/math64.h
@@ -2,7 +2,7 @@
 #define __BACKPORT_LINUX_MATH64_H
 #include_next <linux/math64.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,12,0)
+#if LINUX_VERSION_IS_LESS(3,12,0)
 
 #if BITS_PER_LONG == 64
 /**
diff --git a/backport/backport-include/linux/mdio.h b/backport/backport-include/linux/mdio.h
index a1f3e95d735e..e12f4467b69c 100644
--- a/backport/backport-include/linux/mdio.h
+++ b/backport/backport-include/linux/mdio.h
@@ -24,7 +24,7 @@
 #define MDIO_EEE_10GKR		0x0040	/* 10G KR EEE cap */
 #endif /* MDIO_EEE_100TX */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
+#if LINUX_VERSION_IS_LESS(3,7,0)
 /**
  * mmd_eee_adv_to_ethtool_adv_t
  * @eee_adv: value of the MMD EEE Advertisement/Link Partner Ability registers
@@ -82,6 +82,6 @@ static inline u16 ethtool_adv_to_mmd_eee_adv_t(u32 adv)
 
 	return reg;
 }
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,7,0) */
 
 #endif /* __BACKPORT_LINUX_MDIO_H */
diff --git a/backport/backport-include/linux/mei_cl_bus.h b/backport/backport-include/linux/mei_cl_bus.h
index f4067773c7c7..c0e522f60fd3 100644
--- a/backport/backport-include/linux/mei_cl_bus.h
+++ b/backport/backport-include/linux/mei_cl_bus.h
@@ -2,15 +2,15 @@
 #define __BACKPORT_LINUX_MEI_CL_BUS_H
 #include_next <linux/mei_cl_bus.h>
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(4,3,0))
+#if LINUX_VERSION_IS_LESS(4,3,0)
 #define mei_cldev_register_event_cb(cldev, event_mask, read_cb, context) \
 	mei_cl_register_event_cb(cldev, read_cb, context)
-#elif (LINUX_VERSION_CODE < KERNEL_VERSION(4,4,0))
+#elif LINUX_VERSION_IS_LESS(4,4,0)
 #define mei_cldev_register_event_cb(cldev, event_mask, read_cb, context) \
 	mei_cl_register_event_cb(cldev, event_mask, read_cb, context)
 #endif
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(4,4,0))
+#if LINUX_VERSION_IS_LESS(4,4,0)
 #define __mei_cldev_driver_register(cldrv, owner) __mei_cl_driver_register(cldrv, owner)
 #define mei_cldev_driver_register(cldrv) mei_cl_driver_register(cldrv)
 #define mei_cldev_driver_unregister(cldrv) mei_cl_driver_unregister(cldrv)
diff --git a/backport/backport-include/linux/mii.h b/backport/backport-include/linux/mii.h
index 9ce570056692..5b0ecf971eba 100644
--- a/backport/backport-include/linux/mii.h
+++ b/backport/backport-include/linux/mii.h
@@ -3,7 +3,7 @@
 #include_next <linux/mii.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
+#if LINUX_VERSION_IS_LESS(3,3,0)
 #include <linux/ethtool.h>
 
 #define ethtool_adv_to_mii_adv_t LINUX_BACKPORT(ethtool_adv_to_mii_adv_t)
diff --git a/backport/backport-include/linux/mm.h b/backport/backport-include/linux/mm.h
index 7dda9e53a0ae..3234b37d40c1 100644
--- a/backport/backport-include/linux/mm.h
+++ b/backport/backport-include/linux/mm.h
@@ -22,19 +22,19 @@
 #define VM_DONTDUMP    VM_NODUMP
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0)
+#if LINUX_VERSION_IS_LESS(3,15,0)
 #define kvfree LINUX_BACKPORT(kvfree)
 void kvfree(const void *addr);
 #endif /* < 3.15 */
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,20,0))
+#if LINUX_VERSION_IS_LESS(3,20,0)
 #define get_user_pages_locked LINUX_BACKPORT(get_user_pages_locked)
 long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
 		    int write, int force, struct page **pages, int *locked);
 #define get_user_pages_unlocked LINUX_BACKPORT(get_user_pages_unlocked)
 long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
 		    int write, int force, struct page **pages);
-#elif (LINUX_VERSION_CODE < KERNEL_VERSION(4,6,0))
+#elif LINUX_VERSION_IS_LESS(4,6,0)
 static inline
 long backport_get_user_pages_locked(unsigned long start, unsigned long nr_pages,
 		    int write, int force, struct page **pages, int *locked)
@@ -54,7 +54,7 @@ long backport_get_user_pages_unlocked(unsigned long start, unsigned long nr_page
 #define get_user_pages_unlocked LINUX_BACKPORT(get_user_pages_unlocked)
 #endif
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(4,6,0))
+#if LINUX_VERSION_IS_LESS(4,6,0)
 static inline
 long backport_get_user_pages(unsigned long start, unsigned long nr_pages,
 			    int write, int force, struct page **pages,
@@ -114,8 +114,8 @@ static inline unsigned long *frame_vector_pfns(struct frame_vector *vec)
 }
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,9) && \
-     LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
+#if LINUX_VERSION_IS_LESS(4,1,9) && \
+     LINUX_VERSION_IS_GEQ(3,6,0)
 #define page_is_pfmemalloc LINUX_BACKPORT(page_is_pfmemalloc)
 static inline bool page_is_pfmemalloc(struct page *page)
 {
diff --git a/backport/backport-include/linux/mmc/host.h b/backport/backport-include/linux/mmc/host.h
index 49d7049b47f9..2a60cdec0c17 100644
--- a/backport/backport-include/linux/mmc/host.h
+++ b/backport/backport-include/linux/mmc/host.h
@@ -4,13 +4,13 @@
 #include <linux/version.h>
 #include <linux/mmc/card.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,16,0)
+#if LINUX_VERSION_IS_LESS(3,16,0)
 #define mmc_card_hs LINUX_BACKPORT(mmc_card_hs)
 static inline int mmc_card_hs(struct mmc_card *card)
 {
 	return card->host->ios.timing == MMC_TIMING_SD_HS ||
 		card->host->ios.timing == MMC_TIMING_MMC_HS;
 }
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,16,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,16,0) */
 
 #endif /* _BACKPORTLINUX_MMC_HOST_H */
diff --git a/backport/backport-include/linux/module.h b/backport/backport-include/linux/module.h
index 8870abb79c1e..1a2c82f45b75 100644
--- a/backport/backport-include/linux/module.h
+++ b/backport/backport-include/linux/module.h
@@ -61,7 +61,7 @@ extern void backport_dependency_symbol(void);
 	void cleanup_module(void) __attribute__((alias("__exit_compat")));
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
+#if LINUX_VERSION_IS_LESS(3,3,0)
 #undef param_check_bool
 #define param_check_bool(name, p) __param_check(name, p, bool)
 #endif
diff --git a/backport/backport-include/linux/moduleparam.h b/backport/backport-include/linux/moduleparam.h
index 787523eba95b..1c7dfad4e0ed 100644
--- a/backport/backport-include/linux/moduleparam.h
+++ b/backport/backport-include/linux/moduleparam.h
@@ -2,7 +2,7 @@
 #define __BACKPORT_LINUX_MODULEPARAM_H
 #include_next <linux/moduleparam.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)
+#if LINUX_VERSION_IS_LESS(4,2,0)
 #define kernel_param_lock LINUX_BACKPORT(kernel_param_lock)
 static inline void kernel_param_lock(struct module *mod)
 {
@@ -15,7 +15,7 @@ static inline void kernel_param_unlock(struct module *mod)
 }
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0)
+#if LINUX_VERSION_IS_LESS(3,8,0)
 #undef __MODULE_INFO
 #ifdef MODULE
 #define __MODULE_INFO(tag, name, info)					  \
@@ -29,7 +29,7 @@ static const char __UNIQUE_ID(name)[]					  \
 #endif
 #endif /* < 3.8 */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0)
+#if LINUX_VERSION_IS_LESS(3,17,0)
 extern struct kernel_param_ops param_ops_ullong;
 extern int param_set_ullong(const char *val, const struct kernel_param *kp);
 extern int param_get_ullong(char *buffer, const struct kernel_param *kp);
diff --git a/backport/backport-include/linux/net.h b/backport/backport-include/linux/net.h
index 6d2af69a8f08..738ff8b15e6e 100644
--- a/backport/backport-include/linux/net.h
+++ b/backport/backport-include/linux/net.h
@@ -64,7 +64,7 @@ do {								\
  * may affect tracing. My recommendation is that if you have a need for
  * static keys you just require at least 3.5 to remain sane.
  */
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) && !defined(net_get_random_once)
+#if LINUX_VERSION_IS_GEQ(3,5,0) && !defined(net_get_random_once)
 #define __BACKPORT_NET_GET_RANDOM_ONCE 1
 #endif
 #endif /* ___NET_RANDOM_STATIC_KEY_INIT */
@@ -97,7 +97,7 @@ bool __net_get_random_once(void *buf, int nbytes, bool *done,
 
 #endif /* __BACKPORT_NET_GET_RANDOM_ONCE */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)
+#if LINUX_VERSION_IS_LESS(4,2,0)
 #define sock_create_kern(net, family, type, proto, res) \
 	__sock_create(net, family, type, proto, res, 1)
 #endif
diff --git a/backport/backport-include/linux/netdev_features.h b/backport/backport-include/linux/netdev_features.h
index 3ca13e24fd4c..09568ce45d0a 100644
--- a/backport/backport-include/linux/netdev_features.h
+++ b/backport/backport-include/linux/netdev_features.h
@@ -3,7 +3,7 @@
 
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
+#if LINUX_VERSION_IS_LESS(3,3,0)
 #include <linux/netdevice.h>
 #include <linux/types.h>
 
@@ -20,7 +20,7 @@ typedef u32 netdev_features_t;
 #else
 #include_next <linux/netdev_features.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
+#if LINUX_VERSION_IS_LESS(3,10,0)
 /* See commit f646968f8f on next-20130423 */
 #define NETIF_F_HW_VLAN_CTAG_TX_BIT		NETIF_F_HW_VLAN_TX_BIT
 #define NETIF_F_HW_VLAN_CTAG_RX_BIT		NETIF_F_HW_VLAN_RX_BIT
@@ -31,7 +31,7 @@ typedef u32 netdev_features_t;
 #define NETIF_F_HW_VLAN_CTAG_TX			NETIF_F_HW_VLAN_TX
 #endif
 
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,3,0) */
 
 #if !defined(NETIF_F_RXCSUM)
 #define NETIF_F_RXCSUM 0
diff --git a/backport/backport-include/linux/netdevice.h b/backport/backport-include/linux/netdevice.h
index 4f64227b1122..06230b53dc45 100644
--- a/backport/backport-include/linux/netdevice.h
+++ b/backport/backport-include/linux/netdevice.h
@@ -20,7 +20,7 @@ struct inet6_dev;
  */
 #include <linux/hardirq.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0)
+#if LINUX_VERSION_IS_LESS(3,14,0)
 /*
  * Backports note: if in-kernel support is provided we could then just
  * take the kernel's implementation of __dev_kfree_skb_irq() as it requires
@@ -96,15 +96,15 @@ struct pcpu_sw_netstats {
 #else
 #define netdev_tstats(dev)	dev->tstats
 #define netdev_assign_tstats(dev, e)	dev->tstats = (e);
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,14,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,8)
+#if LINUX_VERSION_IS_LESS(3,7,8)
 #define netdev_set_default_ethtool_ops LINUX_BACKPORT(netdev_set_default_ethtool_ops)
 extern void netdev_set_default_ethtool_ops(struct net_device *dev,
 					   const struct ethtool_ops *ops);
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
+#if LINUX_VERSION_IS_LESS(3,3,0)
 /*
  * BQL was added as of v3.3 but some Linux distributions
  * have backported BQL to their v3.2 kernels or older. To
@@ -152,11 +152,11 @@ static inline void netdev_reset_queue(struct net_device *dev_queue)
 #define NETDEV_PRE_UP		0x000D
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)
+#if LINUX_VERSION_IS_LESS(3,11,0)
 #define netdev_notifier_info_to_dev(ndev) ndev
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
+#if LINUX_VERSION_IS_LESS(3,7,0)
 #define netdev_notify_peers(dev) netif_notify_peers(dev)
 #define napi_gro_flush(napi, old) napi_gro_flush(napi)
 #endif
@@ -178,7 +178,7 @@ static inline void netdev_reset_queue(struct net_device *dev_queue)
 #define __QUEUE_STATE_STACK_XOFF __QUEUE_STATE_XOFF
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0)
+#if LINUX_VERSION_IS_LESS(3,17,0)
 #ifndef NET_NAME_UNKNOWN
 #define NET_NAME_UNKNOWN	0
 #endif
@@ -206,22 +206,22 @@ static inline void netdev_reset_queue(struct net_device *dev_queue)
 #define alloc_netdev_mq(sizeof_priv, name, name_assign_type, setup, count) \
 	alloc_netdev_mqs(sizeof_priv, name, name_assign_type, setup, count, \
 			 count)
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,17,0) */
 
 /*
  * This backports this commit from upstream:
  * commit 87757a917b0b3c0787e0563c679762152be81312
  * net: force a list_del() in unregister_netdevice_many()
  */
-#if (!(LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,45) && \
-       LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)) && \
-     !(LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,23) && \
-       LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)) && \
-     !(LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,9) && \
-       LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0)) && \
-     !(LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,2) && \
-       LINUX_VERSION_CODE < KERNEL_VERSION(3,16,0)) && \
-     (LINUX_VERSION_CODE < KERNEL_VERSION(3,16,0)))
+#if (!(LINUX_VERSION_IS_GEQ(3,10,45) && \
+       LINUX_VERSION_IS_LESS(3,11,0)) && \
+     !(LINUX_VERSION_IS_GEQ(3,12,23) && \
+       LINUX_VERSION_IS_LESS(3,13,0)) && \
+     !(LINUX_VERSION_IS_GEQ(3,14,9) && \
+       LINUX_VERSION_IS_LESS(3,15,0)) && \
+     !(LINUX_VERSION_IS_GEQ(3,15,2) && \
+       LINUX_VERSION_IS_LESS(3,16,0)) && \
+     LINUX_VERSION_IS_LESS(3,16,0))
 static inline void backport_unregister_netdevice_many(struct list_head *head)
 {
 	unregister_netdevice_many(head);
@@ -232,35 +232,35 @@ static inline void backport_unregister_netdevice_many(struct list_head *head)
 #define unregister_netdevice_many LINUX_BACKPORT(unregister_netdevice_many)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
+#if LINUX_VERSION_IS_LESS(3,19,0)
 #define napi_alloc_frag(fragsz) netdev_alloc_frag(fragsz)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
+#if LINUX_VERSION_IS_LESS(3,19,0)
 /* RSS keys are 40 or 52 bytes long */
 #define NETDEV_RSS_KEY_LEN 52
 #define netdev_rss_key_fill LINUX_BACKPORT(netdev_rss_key_fill)
 void netdev_rss_key_fill(void *buffer, size_t len);
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,19,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
+#if LINUX_VERSION_IS_LESS(3,19,0)
 #define napi_alloc_skb LINUX_BACKPORT(napi_alloc_skb)
 static inline struct sk_buff *napi_alloc_skb(struct napi_struct *napi,
 					     unsigned int length)
 {
 	return netdev_alloc_skb_ip_align(napi->dev, length);
 }
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,19,0) */
 
 #ifndef IFF_TX_SKB_SHARING
 #define IFF_TX_SKB_SHARING 0
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
+#if LINUX_VERSION_IS_LESS(4,1,0)
 netdev_features_t passthru_features_check(struct sk_buff *skb,
 					  struct net_device *dev,
 					  netdev_features_t features);
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
+#endif /* LINUX_VERSION_IS_LESS(4,1,0) */
 
 #ifndef netdev_alloc_pcpu_stats
 #define netdev_alloc_pcpu_stats(type)				\
@@ -278,7 +278,7 @@ netdev_features_t passthru_features_check(struct sk_buff *skb,
 })
 #endif /* netdev_alloc_pcpu_stats */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
+#if LINUX_VERSION_IS_LESS(3,19,0)
 #define napi_complete_done LINUX_BACKPORT(napi_complete_done)
 static inline void napi_complete_done(struct napi_struct *n, int work_done)
 {
@@ -286,7 +286,7 @@ static inline void napi_complete_done(struct napi_struct *n, int work_done)
 }
 #endif /* < 3.19 */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,5,0)
+#if LINUX_VERSION_IS_LESS(4,5,0)
 #define netif_tx_napi_add LINUX_BACKPORT(netif_tx_napi_add)
 /**
  *	netif_tx_napi_add - initialize a napi context
@@ -312,7 +312,7 @@ static inline void netif_tx_napi_add(struct net_device *dev,
 #define NETIF_F_CSUM_MASK NETIF_F_ALL_CSUM
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,7,0)
+#if LINUX_VERSION_IS_LESS(4,7,0)
 #define netif_trans_update LINUX_BACKPORT(netif_trans_update)
 static inline void netif_trans_update(struct net_device *dev)
 {
diff --git a/backport/backport-include/linux/netlink.h b/backport/backport-include/linux/netlink.h
index 521b72e05496..a40cc0f7f58f 100644
--- a/backport/backport-include/linux/netlink.h
+++ b/backport/backport-include/linux/netlink.h
@@ -4,7 +4,7 @@
 #include <linux/version.h>
 
 /* this is for patches we apply */
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
+#if LINUX_VERSION_IS_LESS(3,7,0)
 #define netlink_notify_portid(__notify) (__notify->pid)
 #define NETLINK_CB_PORTID(__skb) NETLINK_CB(__skb).pid
 #else
diff --git a/backport/backport-include/linux/nl80211.h b/backport/backport-include/linux/nl80211.h
index fcb0b8bf121e..d49057a6fcfc 100644
--- a/backport/backport-include/linux/nl80211.h
+++ b/backport/backport-include/linux/nl80211.h
@@ -3,7 +3,7 @@
 #include_next <linux/nl80211.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
+#if LINUX_VERSION_IS_LESS(3,3,0)
 #define NL80211_FEATURE_SK_TX_STATUS 0
 #endif
 
diff --git a/backport/backport-include/linux/of.h b/backport/backport-include/linux/of.h
index 71900b0773f1..bbb5acd2e4c3 100644
--- a/backport/backport-include/linux/of.h
+++ b/backport/backport-include/linux/of.h
@@ -4,7 +4,7 @@
 #include <linux/version.h>
 #include_next <linux/of.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
+#if LINUX_VERSION_IS_LESS(3,7,0)
 #ifdef CONFIG_OF
 extern struct device_node *of_get_child_by_name(const struct device_node *node,
 						const char *name);
@@ -16,9 +16,9 @@ static inline struct device_node *of_get_child_by_name(
 	return NULL;
 }
 #endif /* CONFIG_OF */
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,7,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
+#if LINUX_VERSION_IS_LESS(3,7,0)
 #ifndef CONFIG_OF
 static inline struct device_node *of_find_node_by_name(struct device_node *from,
 	const char *name)
@@ -26,9 +26,9 @@ static inline struct device_node *of_find_node_by_name(struct device_node *from,
 	return NULL;
 }
 #endif /* CONFIG_OF */
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,7,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0)
+#if LINUX_VERSION_IS_LESS(3,8,0)
 #define of_property_read_u8_array LINUX_BACKPORT(of_property_read_u8_array)
 #ifdef CONFIG_OF
 extern int of_property_read_u8_array(const struct device_node *np,
@@ -40,9 +40,9 @@ static inline int of_property_read_u8_array(const struct device_node *np,
 	return -ENOSYS;
 }
 #endif /* CONFIG_OF */
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,8,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)
+#if LINUX_VERSION_IS_LESS(3,1,0)
 #define of_property_read_u32_array LINUX_BACKPORT(of_property_read_u32_array)
 #ifdef CONFIG_OF
 extern int of_property_read_u32_array(const struct device_node *np,
@@ -74,9 +74,9 @@ static inline const void *of_get_property(const struct device_node *node,
 }
 
 #endif
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,1,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
+#if LINUX_VERSION_IS_LESS(3,10,0)
 #define of_property_read_u32_index LINUX_BACKPORT(of_property_read_u32_index)
 #ifdef CONFIG_OF
 extern int of_property_read_u32_index(const struct device_node *np,
@@ -89,9 +89,9 @@ static inline int of_property_read_u32_index(const struct device_node *np,
 	return -ENOSYS;
 }
 #endif /* CONFIG_OF */
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,10,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0)
+#if LINUX_VERSION_IS_LESS(3,15,0)
 #define of_property_count_elems_of_size LINUX_BACKPORT(of_property_count_elems_of_size)
 #ifdef CONFIG_OF
 extern int of_property_count_elems_of_size(const struct device_node *np,
@@ -103,10 +103,10 @@ static inline int of_property_count_elems_of_size(const struct device_node *np,
 	return -ENOSYS;
 }
 #endif /* CONFIG_OF */
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,15,0) */
 
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0)
+#if LINUX_VERSION_IS_LESS(3,15,0)
 /**
  * of_property_count_u32_elems - Count the number of u32 elements in a property
  *
@@ -124,9 +124,9 @@ static inline int of_property_count_u32_elems(const struct device_node *np,
 {
 	return of_property_count_elems_of_size(np, propname, sizeof(u32));
 }
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,15,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
+#if LINUX_VERSION_IS_LESS(3,3,0)
 #ifndef CONFIG_OF
 #define of_node_get LINUX_BACKPORT(of_node_get)
 /* Dummy ref counting routines - to be implemented later */
@@ -136,7 +136,7 @@ static inline struct device_node *of_node_get(struct device_node *node)
 }
 static inline void of_node_put(struct device_node *node) { }
 #endif /* CONFIG_OF */
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,3,0) */
 
 #ifndef of_match_ptr
 #ifdef CONFIG_OF
@@ -152,7 +152,7 @@ static inline void of_node_put(struct device_node *node) { }
 	     dn = of_find_compatible_node(dn, type, compatible))
 #endif /* for_each_compatible_node */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
+#if LINUX_VERSION_IS_LESS(3,3,0)
 #ifndef CONFIG_OF
 static inline struct device_node *of_find_compatible_node(
 						struct device_node *from,
@@ -164,7 +164,7 @@ static inline struct device_node *of_find_compatible_node(
 #endif
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,18,0)
+#if LINUX_VERSION_IS_LESS(3,18,0)
 #define of_property_read_u64_array LINUX_BACKPORT(of_property_read_u64_array)
 #ifdef CONFIG_OF
 /* This is static in the kernel, but we need it in multiple places */
@@ -182,9 +182,9 @@ static inline int of_property_read_u64_array(const struct device_node *np,
 	return -ENOSYS;
 }
 #endif /* CONFIG_OF */
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,15,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
+#if LINUX_VERSION_IS_LESS(3,6,0)
 #define of_node_full_name LINUX_BACKPORT(of_node_full_name)
 #ifdef CONFIG_OF
 static inline const char *of_node_full_name(const struct device_node *np)
diff --git a/backport/backport-include/linux/of_address.h b/backport/backport-include/linux/of_address.h
index 63ac79dd6a7e..e3a5167ac5ca 100644
--- a/backport/backport-include/linux/of_address.h
+++ b/backport/backport-include/linux/of_address.h
@@ -3,7 +3,7 @@
 #include_next <linux/of_address.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,4,0) && !defined(CONFIG_OF_ADDRESS)
+#if LINUX_VERSION_IS_LESS(4,4,0) && !defined(CONFIG_OF_ADDRESS)
 #ifndef OF_BAD_ADDR
 #define OF_BAD_ADDR     ((u64)-1)
 #endif
@@ -13,6 +13,6 @@ static inline u64 of_translate_address(struct device_node *np,
 {
 	return OF_BAD_ADDR;
 }
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,4,0) */
+#endif /* LINUX_VERSION_IS_LESS(4,4,0) */
 
 #endif /* __BACKPORT_OF_IRQ_H */
diff --git a/backport/backport-include/linux/of_irq.h b/backport/backport-include/linux/of_irq.h
index b5cb4322fb11..58108e2c2466 100644
--- a/backport/backport-include/linux/of_irq.h
+++ b/backport/backport-include/linux/of_irq.h
@@ -3,13 +3,13 @@
 #include_next <linux/of_irq.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0) && !defined(CONFIG_OF)
+#if LINUX_VERSION_IS_LESS(3,5,0) && !defined(CONFIG_OF)
 #define irq_of_parse_and_map LINUX_BACKPORT(irq_of_parse_and_map)
 static inline unsigned int irq_of_parse_and_map(struct device_node *dev,
 						int index)
 {
 	return 0;
 }
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,5,0) */
+#endif /* LINUX_VERSION_IS_LESS(4,5,0) */
 
 #endif /* __BACKPORT_OF_IRQ_H */
diff --git a/backport/backport-include/linux/of_platform.h b/backport/backport-include/linux/of_platform.h
index 5d422b178291..625ee9ed5b2d 100644
--- a/backport/backport-include/linux/of_platform.h
+++ b/backport/backport-include/linux/of_platform.h
@@ -6,7 +6,7 @@
 /* upstream now includes this here and some people rely on it */
 #include <linux/of_device.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0) && !defined(CONFIG_OF_DEVICE)
+#if LINUX_VERSION_IS_LESS(3,4,0) && !defined(CONFIG_OF_DEVICE)
 struct of_dev_auxdata;
 #define of_platform_populate LINUX_BACKPORT(of_platform_populate)
 static inline int of_platform_populate(struct device_node *root,
@@ -16,13 +16,13 @@ static inline int of_platform_populate(struct device_node *root,
 {
 	return -ENODEV;
 }
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,4,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0) && !defined(CONFIG_OF_DEVICE)
+#if LINUX_VERSION_IS_LESS(3,11,0) && !defined(CONFIG_OF_DEVICE)
 extern const struct of_device_id of_default_bus_match_table[];
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,11,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,3,0) && !defined(CONFIG_OF_DEVICE)
+#if LINUX_VERSION_IS_LESS(4,3,0) && !defined(CONFIG_OF_DEVICE)
 struct of_dev_auxdata;
 #define of_platform_default_populate \
 	LINUX_BACKPORT(of_platform_default_populate)
@@ -33,6 +33,6 @@ of_platform_default_populate(struct device_node *root,
 {
 	return -ENODEV;
 }
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,3,0) */
+#endif /* LINUX_VERSION_IS_LESS(4,3,0) */
 
 #endif /* __BACKPORT_LINUX_OF_PLATFORM_H */
diff --git a/backport/backport-include/linux/olpc-ec.h b/backport/backport-include/linux/olpc-ec.h
index a5b932a75a29..353107f66dda 100644
--- a/backport/backport-include/linux/olpc-ec.h
+++ b/backport/backport-include/linux/olpc-ec.h
@@ -3,8 +3,8 @@
 
 #include <linux/version.h>
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0))
+#if LINUX_VERSION_IS_GEQ(3,6,0)
 #include_next <linux/olpc-ec.h>
-#endif /* (LINUX_VERSION_CODE > KERNEL_VERSION(3,6,0)) */
+#endif /* LINUX_VERSION_IS_GEQ(3,6,0) */
 
 #endif	/* _COMPAT_LINUX_OLPC_EC_H */
diff --git a/backport/backport-include/linux/page_ref.h b/backport/backport-include/linux/page_ref.h
index 0b890e9be415..55fc14f54c1b 100644
--- a/backport/backport-include/linux/page_ref.h
+++ b/backport/backport-include/linux/page_ref.h
@@ -1,7 +1,7 @@
 #ifndef __BP_PAGE_REF_H
 #define __BP_PAGE_REF_H
 #include <linux/version.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,6,0)
+#if LINUX_VERSION_IS_GEQ(4,6,0)
 #include_next <linux/page_ref.h>
 #else
 static inline void page_ref_inc(struct page *page)
diff --git a/backport/backport-include/linux/pci.h b/backport/backport-include/linux/pci.h
index 081b4c7cd00f..81c2d57a3454 100644
--- a/backport/backport-include/linux/pci.h
+++ b/backport/backport-include/linux/pci.h
@@ -17,7 +17,7 @@
 		       pci_unregister_driver)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
+#if LINUX_VERSION_IS_LESS(3,7,0)
 #define pcie_capability_read_word LINUX_BACKPORT(pcie_capability_read_word)
 int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val);
 #define pcie_capability_read_dword LINUX_BACKPORT(pcie_capability_read_dword)
@@ -78,7 +78,7 @@ static inline int pcie_capability_clear_dword(struct pci_dev *dev, int pos,
 	.subvendor = (subvend), .subdevice = (subdev)
 #endif /* PCI_DEVICE_SUB */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0)
+#if LINUX_VERSION_IS_LESS(3,2,0)
 #define pci_dev_flags LINUX_BACKPORT(pci_dev_flags)
 #define PCI_DEV_FLAGS_MSI_INTX_DISABLE_BUG LINUX_BACKPORT(PCI_DEV_FLAGS_MSI_INTX_DISABLE_BUG)
 #define PCI_DEV_FLAGS_NO_D3 LINUX_BACKPORT(PCI_DEV_FLAGS_NO_D3)
@@ -93,14 +93,14 @@ enum pci_dev_flags {
 	/* Provide indication device is assigned by a Virtual Machine Manager */
 	PCI_DEV_FLAGS_ASSIGNED = (__force pci_dev_flags_t) 4,
 };
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,2,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0)
+#if LINUX_VERSION_IS_LESS(3,8,0)
 #define pci_sriov_set_totalvfs LINUX_BACKPORT(pci_sriov_set_totalvfs)
 int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,8,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
+#if LINUX_VERSION_IS_LESS(3,10,0)
 /* Taken from drivers/pci/pci.h */
 struct pci_sriov {
 	int pos;		/* capability position */
@@ -132,9 +132,9 @@ static inline int pci_vfs_assigned(struct pci_dev *dev)
 }
 #endif
 
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,10,0) */
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0))
+#if LINUX_VERSION_IS_LESS(3,14,0)
 #define pci_enable_msi_range LINUX_BACKPORT(pci_enable_msi_range)
 #ifdef CONFIG_PCI_MSI
 int pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec);
@@ -146,7 +146,7 @@ static inline int pci_enable_msi_range(struct pci_dev *dev, int minvec,
 #endif
 
 #ifdef CONFIG_PCI
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0)
+#if LINUX_VERSION_IS_LESS(3,14,0)
 #define pci_enable_msix_range LINUX_BACKPORT(pci_enable_msix_range)
 #ifdef CONFIG_PCI_MSI
 int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
@@ -159,13 +159,13 @@ static inline int pci_enable_msix_range(struct pci_dev *dev,
 #endif
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)
+#if LINUX_VERSION_IS_LESS(3,13,0)
 #define pci_device_is_present LINUX_BACKPORT(pci_device_is_present)
 bool pci_device_is_present(struct pci_dev *pdev);
 #endif
 
 #ifdef CONFIG_PCI
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0)
+#if LINUX_VERSION_IS_LESS(3,14,0)
 #define pci_enable_msix_exact LINUX_BACKPORT(pci_enable_msix_exact)
 #ifdef CONFIG_PCI_MSI
 static inline int pci_enable_msix_exact(struct pci_dev *dev,
diff --git a/backport/backport-include/linux/phy.h b/backport/backport-include/linux/phy.h
index bf283578deec..f331428b231f 100644
--- a/backport/backport-include/linux/phy.h
+++ b/backport/backport-include/linux/phy.h
@@ -4,12 +4,12 @@
 #include <linux/compiler.h>
 #include <linux/version.h>
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0))
+#if LINUX_VERSION_IS_LESS(3,9,0)
 #define phy_connect(dev, bus_id, handler, interface) \
 	phy_connect(dev, bus_id, handler, 0, interface)
 #endif
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(4,5,0))
+#if LINUX_VERSION_IS_LESS(4,5,0)
 #define phydev_name LINUX_BACKPORT(phydev_name)
 static inline const char *phydev_name(const struct phy_device *phydev)
 {
@@ -58,7 +58,7 @@ static inline void backport_mdiobus_unregister(struct mii_bus *bus)
 #define mdiobus_unregister LINUX_BACKPORT(mdiobus_unregister)
 #endif /* < 4.5 */
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(4,5,0))
+#if LINUX_VERSION_IS_LESS(4,5,0)
 #define phydev_get_addr LINUX_BACKPORT(phydev_get_addr)
 static inline int phydev_get_addr(struct phy_device *phydev)
 {
diff --git a/backport/backport-include/linux/platform_data/media/si4713.h b/backport/backport-include/linux/platform_data/media/si4713.h
index 7a000189743c..3d49c32f492f 100644
--- a/backport/backport-include/linux/platform_data/media/si4713.h
+++ b/backport/backport-include/linux/platform_data/media/si4713.h
@@ -1,7 +1,7 @@
 #ifndef __BACKPORT_SI4713_H
 #define __BACKPORT_SI4713_H
 #include <linux/version.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,5,0)
+#if LINUX_VERSION_IS_GEQ(4,5,0)
 #include_next <linux/platform_data/media/si4713.h>
 #else
 #include <media/si4713.h>
diff --git a/backport/backport-include/linux/platform_data/media/soc_camera_platform.h b/backport/backport-include/linux/platform_data/media/soc_camera_platform.h
index 9367202e0818..927bf8fa8921 100644
--- a/backport/backport-include/linux/platform_data/media/soc_camera_platform.h
+++ b/backport/backport-include/linux/platform_data/media/soc_camera_platform.h
@@ -1,7 +1,7 @@
 #ifndef __BACKPORT_SOC_CAMERA_H__
 #define __BACKPORT_SOC_CAMERA_H__
 #include <linux/version.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,5,0)
+#if LINUX_VERSION_IS_GEQ(4,5,0)
 #include_next <linux/platform_data/media/soc_camera_platform.h>
 #else
 #include <media/soc_camera_platform.h>
diff --git a/backport/backport-include/linux/platform_data/media/timb_radio.h b/backport/backport-include/linux/platform_data/media/timb_radio.h
index 91923fd32fe1..f1fb47a2af0c 100644
--- a/backport/backport-include/linux/platform_data/media/timb_radio.h
+++ b/backport/backport-include/linux/platform_data/media/timb_radio.h
@@ -1,7 +1,7 @@
 #ifndef __BACKPORT_TIMB_RADIO_
 #define __BACKPORT_TIMB_RADIO_
 #include <linux/version.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,5,0)
+#if LINUX_VERSION_IS_GEQ(4,5,0)
 #include_next <linux/platform_data/media/timb_radio.h>
 #else
 #include <media/timb_radio.h>
diff --git a/backport/backport-include/linux/platform_data/media/timb_video.h b/backport/backport-include/linux/platform_data/media/timb_video.h
index f714b83d56d9..82ff78875495 100644
--- a/backport/backport-include/linux/platform_data/media/timb_video.h
+++ b/backport/backport-include/linux/platform_data/media/timb_video.h
@@ -1,7 +1,7 @@
 #ifndef __BACKPORT_TIMB_VIDEO_
 #define __BACKPORT_TIMB_VIDEO_
 #include <linux/version.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,5,0)
+#if LINUX_VERSION_IS_GEQ(4,5,0)
 #include_next <linux/platform_data/media/timb_video.h>
 #else
 #include <media/timb_video.h>
diff --git a/backport/backport-include/linux/pm_qos.h b/backport/backport-include/linux/pm_qos.h
index 1da2b2020dac..d5bfc9bcfd07 100644
--- a/backport/backport-include/linux/pm_qos.h
+++ b/backport/backport-include/linux/pm_qos.h
@@ -3,11 +3,11 @@
 
 #include <linux/version.h>
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
+#if LINUX_VERSION_IS_GEQ(3,2,0)
 #include_next <linux/pm_qos.h>
 #else
 #include <linux/pm_qos_params.h>
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)) */
+#endif /* LINUX_VERSION_IS_GEQ(3,2,0) */
 
 #ifndef PM_QOS_DEFAULT_VALUE
 #define PM_QOS_DEFAULT_VALUE -1
diff --git a/backport/backport-include/linux/pm_runtime.h b/backport/backport-include/linux/pm_runtime.h
index 16d2a8094fd0..d9163eea849a 100644
--- a/backport/backport-include/linux/pm_runtime.h
+++ b/backport/backport-include/linux/pm_runtime.h
@@ -2,7 +2,7 @@
 #define __BACKPORT_PM_RUNTIME_H
 #include_next <linux/pm_runtime.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+#if LINUX_VERSION_IS_LESS(3,9,0)
 #define pm_runtime_active LINUX_BACKPORT(pm_runtime_active)
 #ifdef CONFIG_PM
 static inline bool pm_runtime_active(struct device *dev)
@@ -14,6 +14,6 @@ static inline bool pm_runtime_active(struct device *dev)
 static inline bool pm_runtime_active(struct device *dev) { return true; }
 #endif /* CONFIG_PM */
 
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,9,0) */
 
 #endif /* __BACKPORT_PM_RUNTIME_H */
diff --git a/backport/backport-include/linux/poll.h b/backport/backport-include/linux/poll.h
index 8e961afbf3be..3eecd81fe640 100644
--- a/backport/backport-include/linux/poll.h
+++ b/backport/backport-include/linux/poll.h
@@ -3,7 +3,7 @@
 #include_next <linux/poll.h>
 #include <linux/version.h>
 
-#if  LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)
+#if  LINUX_VERSION_IS_LESS(3,4,0)
 #define poll_does_not_wait LINUX_BACKPORT(poll_does_not_wait)
 static inline bool poll_does_not_wait(const poll_table *p)
 {
diff --git a/backport/backport-include/linux/printk.h b/backport/backport-include/linux/printk.h
index d8083ac68821..22851d7f6868 100644
--- a/backport/backport-include/linux/printk.h
+++ b/backport/backport-include/linux/printk.h
@@ -6,7 +6,7 @@
 
 /* see pr_fmt at end of file */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+#if LINUX_VERSION_IS_LESS(3,9,0)
 /* backports 7a555613 */
 #if defined(CONFIG_DYNAMIC_DEBUG)
 #define dynamic_hex_dump(prefix_str, prefix_type, rowsize,     \
@@ -30,7 +30,7 @@ do {                                                           \
 		       groupsize, buf, len, ascii)
 #endif /* defined(CONFIG_DYNAMIC_DEBUG) */
 
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,9,0) */
 
 #ifndef pr_warn
 #define pr_warn pr_warning
@@ -139,7 +139,7 @@ do {									\
 #endif /* pr_debug_ratelimited */
 
 /* replace hex_dump_to_buffer() with a version which returns the length */
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,0,0)
+#if LINUX_VERSION_IS_LESS(4,0,0)
 #define hex_dump_to_buffer LINUX_BACKPORT(hex_dump_to_buffer)
 extern int hex_dump_to_buffer(const void *buf, size_t len, int rowsize,
 			      int groupsize, char *linebuf, size_t linebuflen,
diff --git a/backport/backport-include/linux/proc_fs.h b/backport/backport-include/linux/proc_fs.h
index 16b25645b1e4..be239bf87882 100644
--- a/backport/backport-include/linux/proc_fs.h
+++ b/backport/backport-include/linux/proc_fs.h
@@ -3,7 +3,7 @@
 #include_next <linux/proc_fs.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
+#if LINUX_VERSION_IS_LESS(3,10,0)
 
 #ifdef CONFIG_PROC_FS
 /*
@@ -24,6 +24,6 @@ static inline void proc_set_size(struct proc_dir_entry *de, loff_t size) {}
 static inline void proc_set_user(struct proc_dir_entry *de, kuid_t uid, kgid_t gid) {}
 #endif /* CONFIG_PROC_FS */
 
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,10,0) */
 
 #endif /* __BACKPORT_PROC_FS_H */
diff --git a/backport/backport-include/linux/ptp_clock_kernel.h b/backport/backport-include/linux/ptp_clock_kernel.h
index 869dfdcd0661..e4483c0e17f5 100644
--- a/backport/backport-include/linux/ptp_clock_kernel.h
+++ b/backport/backport-include/linux/ptp_clock_kernel.h
@@ -4,7 +4,7 @@
 #include <linux/version.h>
 #include_next <linux/ptp_clock_kernel.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0)
+#if LINUX_VERSION_IS_LESS(3,5,0)
 #include <linux/posix-clock.h>
 
 #define PTP_MAX_TIMESTAMPS 128
@@ -31,10 +31,10 @@ struct ptp_clock {
 };
 
 extern int ptp_clock_index(struct ptp_clock *ptp);
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,5,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0) && !defined(CONFIG_SUSE_KERNEL)
+#if LINUX_VERSION_IS_LESS(3,7,0) && !defined(CONFIG_SUSE_KERNEL)
 #define ptp_clock_register(info,parent) ptp_clock_register(info)
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,7,0) */
 
 #endif /* __BACKPORT_PTP_CLOCK_KERNEL_H */
diff --git a/backport/backport-include/linux/random.h b/backport/backport-include/linux/random.h
index f1cd26ad74ca..a9dda73bda81 100644
--- a/backport/backport-include/linux/random.h
+++ b/backport/backport-include/linux/random.h
@@ -3,16 +3,16 @@
 #include_next <linux/random.h>
 #include <linux/version.h>
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) && LINUX_VERSION_CODE < KERNEL_VERSION(3,4,10)) || \
-    (LINUX_VERSION_CODE >= KERNEL_VERSION(3,1,0) && LINUX_VERSION_CODE < KERNEL_VERSION(3,2,27)) || \
-    LINUX_VERSION_CODE < KERNEL_VERSION(3,0,41)
+#if (LINUX_VERSION_IS_GEQ(3,3,0) && LINUX_VERSION_IS_LESS(3,4,10)) || \
+    (LINUX_VERSION_IS_GEQ(3,1,0) && LINUX_VERSION_IS_LESS(3,2,27)) || \
+    LINUX_VERSION_IS_LESS(3,0,41)
 #define add_device_randomness LINUX_BACKPORT(add_device_randomness)
 static inline void add_device_randomness(const void *buf, unsigned int size)
 {
 }
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,8,0)
+#if LINUX_VERSION_IS_LESS(3,8,0)
 /* backports 496f2f9 */
 #define prandom_seed(_seed)		srandom32(_seed)
 #define prandom_u32()			random32()
@@ -22,7 +22,7 @@ static inline void add_device_randomness(const void *buf, unsigned int size)
 void prandom_bytes(void *buf, int bytes);
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0)
+#if LINUX_VERSION_IS_LESS(3,14,0)
 /**
  * prandom_u32_max - returns a pseudo-random number in interval [0, ep_ro)
  * @ep_ro: right open interval endpoint
@@ -40,6 +40,6 @@ static inline u32 prandom_u32_max(u32 ep_ro)
 {
 	return (u32)(((u64) prandom_u32() * ep_ro) >> 32);
 }
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,14,0) */
 
 #endif /* __BACKPORT_RANDOM_H */
diff --git a/backport/backport-include/linux/rculist.h b/backport/backport-include/linux/rculist.h
index 74009abd7760..9671e7c4ef0c 100644
--- a/backport/backport-include/linux/rculist.h
+++ b/backport/backport-include/linux/rculist.h
@@ -2,7 +2,7 @@
 #define __BACKPORT_RCULIST_H
 #include_next <linux/rculist.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+#if LINUX_VERSION_IS_LESS(3,9,0)
 #include <backport/magic.h>
 #define hlist_for_each_entry_rcu4(tpos, pos, head, member)		\
 	for (pos = rcu_dereference_raw(hlist_first_rcu(head));		\
diff --git a/backport/backport-include/linux/regmap.h b/backport/backport-include/linux/regmap.h
index 870ea2c2d4c5..4b73c46b0fc3 100644
--- a/backport/backport-include/linux/regmap.h
+++ b/backport/backport-include/linux/regmap.h
@@ -3,8 +3,8 @@
 #include_next <linux/regmap.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0) && \
-    LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
+#if LINUX_VERSION_IS_LESS(3,5,0) && \
+    LINUX_VERSION_IS_GEQ(3,2,0)
 #define dev_get_regmap LINUX_BACKPORT(dev_get_regmap)
 static inline
 struct regmap *dev_get_regmap(struct device *dev, const char *name)
@@ -13,8 +13,8 @@ struct regmap *dev_get_regmap(struct device *dev, const char *name)
 }
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0) && \
-    LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
+#if LINUX_VERSION_IS_LESS(3,4,0) && \
+    LINUX_VERSION_IS_GEQ(3,2,0)
 #if defined(CONFIG_REGMAP)
 #define devm_regmap_init LINUX_BACKPORT(devm_regmap_init)
 struct regmap *devm_regmap_init(struct device *dev,
diff --git a/backport/backport-include/linux/regulator/driver.h b/backport/backport-include/linux/regulator/driver.h
index ce5bbdfb727c..f88d9bef9f65 100644
--- a/backport/backport-include/linux/regulator/driver.h
+++ b/backport/backport-include/linux/regulator/driver.h
@@ -18,8 +18,8 @@
 #include <linux/version.h>
 #include_next <linux/regulator/driver.h>
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)) && \
-    (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
+#if LINUX_VERSION_IS_LESS(3,13,0) && \
+    LINUX_VERSION_IS_GEQ(3,5,0)
 #define devm_regulator_register LINUX_BACKPORT(devm_regulator_register)
 struct regulator_dev *
 devm_regulator_register(struct device *dev,
@@ -27,7 +27,7 @@ devm_regulator_register(struct device *dev,
 			const struct regulator_config *config);
 #define devm_regulator_unregister LINUX_BACKPORT(devm_regulator_unregister)
 void devm_regulator_unregister(struct device *dev, struct regulator_dev *rdev);
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)) &&
-	  (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)) */
+#endif /* LINUX_VERSION_IS_LESS(3,13,0) &&
+	  LINUX_VERSION_IS_GEQ(3,5,0) */
 
 #endif /* __BACKPORT_LINUX_REGULATOR_DRIVER_H_ */
diff --git a/backport/backport-include/linux/rfkill.h b/backport/backport-include/linux/rfkill.h
index 44ff2e82bd95..99015af704b1 100644
--- a/backport/backport-include/linux/rfkill.h
+++ b/backport/backport-include/linux/rfkill.h
@@ -2,7 +2,7 @@
 #define __COMPAT_RFKILL_H
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
+#if LINUX_VERSION_IS_GEQ(3,10,0)
 #include_next <linux/rfkill.h>
 #else
 /* API only slightly changed since then */
diff --git a/backport/backport-include/linux/rtnetlink.h b/backport/backport-include/linux/rtnetlink.h
index 69ac122833f5..9b68be820049 100644
--- a/backport/backport-include/linux/rtnetlink.h
+++ b/backport/backport-include/linux/rtnetlink.h
@@ -13,7 +13,7 @@
 				 lockdep_rtnl_is_held())
 #endif
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0))
+#if LINUX_VERSION_IS_LESS(3,19,0)
 #define ndo_dflt_fdb_add(ndm, tb, dev, addr, vid, flags) \
 	ndo_dflt_fdb_add(ndm, tb, dev, addr, flags)
 #endif
diff --git a/backport/backport-include/linux/scatterlist.h b/backport/backport-include/linux/scatterlist.h
index 6a264ed4e769..bfc744940904 100644
--- a/backport/backport-include/linux/scatterlist.h
+++ b/backport/backport-include/linux/scatterlist.h
@@ -6,7 +6,7 @@
 int sg_nents(struct scatterlist *sg);
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 9, 0)
+#if LINUX_VERSION_IS_LESS(3, 9, 0)
 
 /*
  * sg page iterator
@@ -76,9 +76,9 @@ void backport_sg_miter_stop(struct sg_mapping_iter *miter);
 	for (__sg_page_iter_start((piter), (sglist), (nents), (pgoffset)); \
 	     __sg_page_iter_next(piter);)
 
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3, 9, 0) */
+#endif /* LINUX_VERSION_IS_LESS(3, 9, 0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 11, 0)
+#if LINUX_VERSION_IS_LESS(3, 11, 0)
 size_t sg_copy_buffer(struct scatterlist *sgl, unsigned int nents, void *buf,
 		      size_t buflen, off_t skip, bool to_buffer);
 
@@ -100,6 +100,6 @@ size_t sg_pcopy_from_buffer(struct scatterlist *sgl, unsigned int nents,
 	return sg_copy_buffer(sgl, nents, buf, buflen, skip, false);
 }
 
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3, 11, 0) */
+#endif /* LINUX_VERSION_IS_LESS(3, 11, 0) */
 
 #endif /* __BACKPORT_SCATTERLIST_H */
diff --git a/backport/backport-include/linux/security.h b/backport/backport-include/linux/security.h
index af95e25eb3db..2dfb964b687a 100644
--- a/backport/backport-include/linux/security.h
+++ b/backport/backport-include/linux/security.h
@@ -2,7 +2,7 @@
 #define __BACKPORT_LINUX_SECURITY_H
 #include_next <linux/security.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)
+#if LINUX_VERSION_IS_LESS(3,1,0)
 /*
  * This has been defined in include/linux/security.h for some time, but was
  * only given an EXPORT_SYMBOL for 3.1.  Add a compat_* definition to avoid
diff --git a/backport/backport-include/linux/seq_file.h b/backport/backport-include/linux/seq_file.h
index 8cc67a52ffe9..ad1bded51de7 100644
--- a/backport/backport-include/linux/seq_file.h
+++ b/backport/backport-include/linux/seq_file.h
@@ -3,7 +3,7 @@
 #include_next <linux/seq_file.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
+#if LINUX_VERSION_IS_LESS(3,7,0)
 #include <linux/user_namespace.h>
 #include <linux/file.h>
 #include <linux/fs.h>
@@ -23,7 +23,7 @@ static inline struct user_namespace *seq_user_ns(struct seq_file *seq)
 #endif /* CONFIG_USER_NS */
 #endif /* < 3.7 */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
+#if LINUX_VERSION_IS_LESS(3,19,0)
 #define seq_has_overflowed LINUX_BACKPORT(seq_has_overflowed)
 /**
  * seq_has_overflowed - check if the buffer has overflowed
@@ -41,7 +41,7 @@ static inline bool seq_has_overflowed(struct seq_file *m)
 }
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,3,0)
+#if LINUX_VERSION_IS_LESS(4,3,0)
 #define seq_hex_dump LINUX_BACKPORT(seq_hex_dump)
 void seq_hex_dump(struct seq_file *m, const char *prefix_str, int prefix_type,
 		  int rowsize, int groupsize, const void *buf, size_t len,
diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index cd10b427c097..dc957487d39c 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -4,14 +4,14 @@
 #include <linux/version.h>
 #include <generated/utsrelease.h>
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)) && \
+#if LINUX_VERSION_IS_LESS(3,4,0) && \
       (RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(6,4)) && \
-      !(defined(CONFIG_SUSE_KERNEL) && (LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,0)))
+      !(defined(CONFIG_SUSE_KERNEL) && LINUX_VERSION_IS_GEQ(3,0,0))
 #define skb_add_rx_frag(skb, i, page, off, size, truesize) \
 	skb_add_rx_frag(skb, i, page, off, size)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
+#if LINUX_VERSION_IS_LESS(3,3,0)
 #define __pskb_copy LINUX_BACKPORT(__pskb_copy)
 extern struct sk_buff *__pskb_copy(struct sk_buff *skb,
 				   int headroom, gfp_t gfp_mask);
@@ -24,12 +24,12 @@ static inline void skb_complete_wifi_ack(struct sk_buff *skb, bool acked)
 
 /* define to 0 so checks for it are always false */
 #define SKBTX_WIFI_STATUS 0
-#elif LINUX_VERSION_CODE < KERNEL_VERSION(3,18,0)
+#elif LINUX_VERSION_IS_LESS(3,18,0)
 #define skb_complete_wifi_ack LINUX_BACKPORT(skb_complete_wifi_ack)
 void skb_complete_wifi_ack(struct sk_buff *skb, bool acked);
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0)
+#if LINUX_VERSION_IS_LESS(3,2,0)
 #include <linux/dma-mapping.h>
 
 /* mask skb_frag_page as RHEL6 backports this */
@@ -57,7 +57,7 @@ static inline dma_addr_t skb_frag_dma_map(struct device *dev,
 }
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)
+#if LINUX_VERSION_IS_LESS(3,1,0)
 /* mask __netdev_alloc_skb_ip_align as RHEL6 backports this */
 #define __netdev_alloc_skb_ip_align(a,b,c) compat__netdev_alloc_skb_ip_align(a,b,c)
 static inline struct sk_buff *__netdev_alloc_skb_ip_align(struct net_device *dev,
@@ -76,7 +76,7 @@ static inline struct sk_buff *__netdev_alloc_skb_ip_align(struct net_device *dev
 	for (iter = skb_shinfo(skb)->frag_list; iter; iter = iter->next)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0)
+#if LINUX_VERSION_IS_LESS(3,2,0)
 #define skb_frag_size_sub LINUX_BACKPORT(skb_frag_size_sub)
 static inline void skb_frag_size_sub(skb_frag_t *frag, int delta)
 {
@@ -95,18 +95,18 @@ static inline void *skb_frag_address(const skb_frag_t *frag)
 {
 	return page_address(skb_frag_page(frag)) + frag->page_offset;
 }
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,2,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+#if LINUX_VERSION_IS_LESS(3,9,0)
 #ifndef NETDEV_FRAG_PAGE_MAX_ORDER
 #define NETDEV_FRAG_PAGE_MAX_ORDER get_order(32768)
 #endif
 #ifndef NETDEV_FRAG_PAGE_MAX_SIZE
 #define NETDEV_FRAG_PAGE_MAX_SIZE  (PAGE_SIZE << NETDEV_FRAG_PAGE_MAX_ORDER)
 #endif
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,9,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+#if LINUX_VERSION_IS_LESS(3,9,0)
 #define skb_unclone LINUX_BACKPORT(skb_unclone)
 static inline int skb_unclone(struct sk_buff *skb, gfp_t pri)
 {
@@ -117,7 +117,7 @@ static inline int skb_unclone(struct sk_buff *skb, gfp_t pri)
 }
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0)
+#if LINUX_VERSION_IS_LESS(3,2,0)
 
 #define skb_frag_address_safe LINUX_BACKPORT(skb_frag_address_safe)
 /**
@@ -135,9 +135,9 @@ static inline void *skb_frag_address_safe(const skb_frag_t *frag)
 
 	return ptr + frag->page_offset;
 }
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,2,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0) && \
+#if LINUX_VERSION_IS_LESS(3,14,0) && \
     RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,0) && \
     !(LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI > 30)
 /*
@@ -176,16 +176,16 @@ enum pkt_hash_types {
 static inline void
 skb_set_hash(struct sk_buff *skb, __u32 hash, enum pkt_hash_types type)
 {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) /* 4031ae6edb */
+#if LINUX_VERSION_IS_GEQ(3,2,0) /* 4031ae6edb */
 	skb->l4_rxhash = (type == PKT_HASH_TYPE_L4);
 #endif
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0) /* bdeab99191 */
+#if LINUX_VERSION_IS_GEQ(3,4,0) /* bdeab99191 */
 	skb->rxhash = hash;
 #endif
 }
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,14,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,16,0)
+#if LINUX_VERSION_IS_LESS(3,16,0)
 #define __pskb_copy_fclone LINUX_BACKPORT(__pskb_copy_fclone)
 static inline struct sk_buff *__pskb_copy_fclone(struct sk_buff *skb,
 						 int headroom, gfp_t gfp_mask,
@@ -195,12 +195,12 @@ static inline struct sk_buff *__pskb_copy_fclone(struct sk_buff *skb,
 }
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,18,0)
+#if LINUX_VERSION_IS_LESS(3,18,0)
 #define skb_clone_sk LINUX_BACKPORT(skb_clone_sk)
 struct sk_buff *skb_clone_sk(struct sk_buff *skb);
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
+#if LINUX_VERSION_IS_LESS(3,19,0)
 /**
  * __dev_alloc_pages - allocate page for network Rx
  * @gfp_mask: allocation priority. Set __GFP_NOMEMALLOC if not for network Rx
@@ -223,7 +223,7 @@ static inline struct page *__dev_alloc_pages(gfp_t gfp_mask,
 	 *     code in gfp_to_alloc_flags that should be enforcing this.
 	 */
 	gfp_mask |= __GFP_COLD | __GFP_COMP;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
+#if LINUX_VERSION_IS_GEQ(3,6,0)
 	gfp_mask |= __GFP_MEMALLOC;
 #endif
 
@@ -255,9 +255,9 @@ static inline struct page *dev_alloc_page(void)
 {
 	return __dev_alloc_page(GFP_ATOMIC);
 }
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,19,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
+#if LINUX_VERSION_IS_LESS(3,19,0)
 #define skb_copy_datagram_msg LINUX_BACKPORT(skb_copy_datagram_msg)
 static inline int skb_copy_datagram_msg(const struct sk_buff *from, int offset,
 					struct msghdr *msg, int size)
@@ -298,9 +298,9 @@ static inline int skb_put_padto(struct sk_buff *skb, unsigned int len)
 #define skb_ensure_writable LINUX_BACKPORT(skb_ensure_writable)
 int skb_ensure_writable(struct sk_buff *skb, int write_len);
 
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,19,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)
+#if LINUX_VERSION_IS_LESS(4,2,0)
 static inline void skb_free_frag(void *data)
 {
 	put_page(virt_to_head_page(data));
diff --git a/backport/backport-include/linux/slab.h b/backport/backport-include/linux/slab.h
index 850020b6bcbd..66f0cc0d5577 100644
--- a/backport/backport-include/linux/slab.h
+++ b/backport/backport-include/linux/slab.h
@@ -3,7 +3,7 @@
 #include_next <linux/slab.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)
+#if LINUX_VERSION_IS_LESS(3,4,0)
 /* This backports:
  *
  * commit a8203725dfded5c1f79dca3368a4a273e24b59bb
diff --git a/backport/backport-include/linux/spi/spi.h b/backport/backport-include/linux/spi/spi.h
index 76fd8a281980..6d2de15f15fb 100644
--- a/backport/backport-include/linux/spi/spi.h
+++ b/backport/backport-include/linux/spi/spi.h
@@ -18,7 +18,7 @@
 #endif
 
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+#if LINUX_VERSION_IS_LESS(3,9,0)
 /**
  * spi_message_init_with_transfers - Initialize spi_message and append transfers
  * @m: spi_message to be initialized
diff --git a/backport/backport-include/linux/static_key.h b/backport/backport-include/linux/static_key.h
index d301a75d3464..4b82eec2432f 100644
--- a/backport/backport-include/linux/static_key.h
+++ b/backport/backport-include/linux/static_key.h
@@ -3,7 +3,7 @@
 
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) /* kernels >= 3.3 */
+#if LINUX_VERSION_IS_GEQ(3,3,0) /* kernels >= 3.3 */
 /*
  * XXX: NOTE!
  *
@@ -13,7 +13,7 @@
  * kernels 3.3..3.4 don't have it and include <linux/jump_label.h> instead,
  * and for newer kernels include <linux/static_key.h>.
  */
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
+#if LINUX_VERSION_IS_GEQ(3,5,0)
 #include_next <linux/static_key.h>
 #else
 #include <linux/jump_label.h>
diff --git a/backport/backport-include/linux/string.h b/backport/backport-include/linux/string.h
index 1fdf4cc34566..b85d9c73dc27 100644
--- a/backport/backport-include/linux/string.h
+++ b/backport/backport-include/linux/string.h
@@ -3,24 +3,24 @@
 #include_next <linux/string.h>
 #include <linux/version.h>
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(4,5,0))
+#if LINUX_VERSION_IS_LESS(4,5,0)
 #define memdup_user_nul LINUX_BACKPORT(memdup_user_nul)
 extern void *memdup_user_nul(const void __user *, size_t);
 #endif
 
 /* this was added in v3.2.65, v3.4.106, v3.10.60, v3.12.33, v3.14.24,
  * v3.17.3 and v3.18 */
-#if !(LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,3) || \
-      (LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,24) && \
-      LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0)) || \
-      (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,33) && \
-      LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)) || \
-      (LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,60) && \
-      LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)) || \
-      (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,106) && \
-      LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0)) || \
-      (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,65) && \
-      LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)))
+#if !(LINUX_VERSION_IS_GEQ(3,17,3) || \
+      (LINUX_VERSION_IS_GEQ(3,14,24) && \
+      LINUX_VERSION_IS_LESS(3,15,0)) || \
+      (LINUX_VERSION_IS_GEQ(3,12,33) && \
+      LINUX_VERSION_IS_LESS(3,13,0)) || \
+      (LINUX_VERSION_IS_GEQ(3,10,60) && \
+      LINUX_VERSION_IS_LESS(3,11,0)) || \
+      (LINUX_VERSION_IS_GEQ(3,4,106) && \
+      LINUX_VERSION_IS_LESS(3,5,0)) || \
+      (LINUX_VERSION_IS_GEQ(3,2,65) && \
+      LINUX_VERSION_IS_LESS(3,3,0)))
 #define memzero_explicit LINUX_BACKPORT(memzero_explicit)
 void memzero_explicit(void *s, size_t count);
 #endif
diff --git a/backport/backport-include/linux/thermal.h b/backport/backport-include/linux/thermal.h
index 767053735e9e..108a8cfee44f 100644
--- a/backport/backport-include/linux/thermal.h
+++ b/backport/backport-include/linux/thermal.h
@@ -35,11 +35,11 @@ static inline void thermal_notify_framework(struct thermal_zone_device *tz,
 { }
 #else /* < 3.8.0 */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
+#if LINUX_VERSION_IS_LESS(3,10,0)
 #define thermal_notify_framework notify_thermal_framework
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,10,0) */
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(4,3,0))
+#if LINUX_VERSION_IS_LESS(4,3,0)
 
 typedef struct thermal_zone_device_ops old_thermal_zone_device_ops_t;
 
@@ -108,7 +108,7 @@ void backport_thermal_zone_device_unregister(struct thermal_zone_device *);
 #define thermal_zone_device_unregister			\
 	LINUX_BACKPORT(thermal_zone_device_unregister)
 
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,3,0) */
+#endif /* LINUX_VERSION_IS_LESS(4,3,0) */
 #endif /* ! < 3.8.0 */
 
 #endif /* __BACKPORT_LINUX_THERMAL_H */
diff --git a/backport/backport-include/linux/time64.h b/backport/backport-include/linux/time64.h
index 31a7f1be913f..609b8904e40d 100644
--- a/backport/backport-include/linux/time64.h
+++ b/backport/backport-include/linux/time64.h
@@ -1,12 +1,12 @@
 #ifndef __BACKPORT_LINUX_TIME64_H
 #define __BACKPORT_LINUX_TIME64_H
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
+#if LINUX_VERSION_IS_GEQ(3,17,0)
 #include_next <linux/time64.h>
 #else
 #include <linux/time.h>
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0)
+#if LINUX_VERSION_IS_LESS(3,17,0)
 #define timespec64_equal		timespec_equal
 #define timespec64_compare		timespec_compare
 #define set_normalized_timespec64	set_normalized_timespec
@@ -19,6 +19,6 @@
 #define ns_to_timespec64		ns_to_timespec
 #define timespec64_add_ns		timespec_add_ns
 #define timespec64			timespec
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,17,0) */
 
 #endif /* __BACKPORT_LINUX_TIME64_H */
diff --git a/backport/backport-include/linux/timecounter.h b/backport/backport-include/linux/timecounter.h
index 92fafb9ff6d8..596015b1a502 100644
--- a/backport/backport-include/linux/timecounter.h
+++ b/backport/backport-include/linux/timecounter.h
@@ -1,7 +1,7 @@
 #ifndef __BACKPORT_LINUX_TIMECOUNTER_H
 #define __BACKPORT_LINUX_TIMECOUNTER_H
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,20,0)
+#if LINUX_VERSION_IS_GEQ(3,20,0)
 #include_next <linux/timecounter.h>
 #else
 #include <linux/clocksource.h>
diff --git a/backport/backport-include/linux/timekeeping.h b/backport/backport-include/linux/timekeeping.h
index 0a3095e0f8fa..b683d1298336 100644
--- a/backport/backport-include/linux/timekeeping.h
+++ b/backport/backport-include/linux/timekeeping.h
@@ -3,11 +3,11 @@
 #include <linux/version.h>
 #include <linux/types.h>
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
+#if LINUX_VERSION_IS_GEQ(3,17,0)
 #include_next <linux/timekeeping.h>
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0)
+#if LINUX_VERSION_IS_LESS(3,17,0)
 #define ktime_get_ns LINUX_BACKPORT(ktime_get_ns)
 extern ktime_t ktime_get(void);
 #define ktime_get_ns LINUX_BACKPORT(ktime_get_ns)
@@ -24,7 +24,7 @@ static inline u64 ktime_get_boot_ns(void)
 }
 #endif /* < 3.17 */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
+#if LINUX_VERSION_IS_LESS(3,19,0)
 static inline time64_t ktime_get_seconds(void)
 {
 	struct timespec t;
diff --git a/backport/backport-include/linux/tty.h b/backport/backport-include/linux/tty.h
index 7462ac332d27..987a1157d5f7 100644
--- a/backport/backport-include/linux/tty.h
+++ b/backport/backport-include/linux/tty.h
@@ -10,7 +10,7 @@
 #define EXTPROC	0200000
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
+#if LINUX_VERSION_IS_LESS(3,7,0)
 /* Backports tty_lock: Localise the lock */
 #define tty_lock(__tty) tty_lock()
 #define tty_unlock(__tty) tty_unlock()
@@ -19,15 +19,15 @@
 	tty_register_device(driver, index, device)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
+#if LINUX_VERSION_IS_LESS(3,10,0)
 extern void tty_port_tty_wakeup(struct tty_port *port);
 extern void tty_port_tty_hangup(struct tty_port *port, bool check_clocal);
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,10,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) && \
-    LINUX_VERSION_CODE >= KERNEL_VERSION(4,0,0)
+#if LINUX_VERSION_IS_LESS(4,1,0) && \
+    LINUX_VERSION_IS_GEQ(4,0,0)
 extern int tty_set_termios(struct tty_struct *tty, struct ktermios *kt);
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
+#endif /* LINUX_VERSION_IS_LESS(4,1,0) */
 
 #ifndef N_NCI
 #define N_NCI		25	/* NFC NCI UART */
diff --git a/backport/backport-include/linux/tty_flip.h b/backport/backport-include/linux/tty_flip.h
index 67ecd61a3bdf..e6c0684e4c34 100644
--- a/backport/backport-include/linux/tty_flip.h
+++ b/backport/backport-include/linux/tty_flip.h
@@ -3,7 +3,7 @@
 #include_next <linux/tty_flip.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+#if LINUX_VERSION_IS_LESS(3,9,0)
 #define tty_flip_buffer_push(port) tty_flip_buffer_push((port)->tty)
 #define tty_insert_flip_string(port, chars, size) tty_insert_flip_string((port)->tty, chars, size)
 #endif
diff --git a/backport/backport-include/linux/types.h b/backport/backport-include/linux/types.h
index d68e39c54325..160570b4d1bf 100644
--- a/backport/backport-include/linux/types.h
+++ b/backport/backport-include/linux/types.h
@@ -3,7 +3,7 @@
 #include <linux/version.h>
 #include_next <linux/types.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0)
+#if LINUX_VERSION_IS_LESS(3,17,0)
 typedef __s64 time64_t;
 #endif
 
diff --git a/backport/backport-include/linux/u64_stats_sync.h b/backport/backport-include/linux/u64_stats_sync.h
index 2c68d41e8ace..112a4094c704 100644
--- a/backport/backport-include/linux/u64_stats_sync.h
+++ b/backport/backport-include/linux/u64_stats_sync.h
@@ -3,7 +3,7 @@
 
 #include <linux/version.h>
 #include <generated/utsrelease.h>
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0))
+#if LINUX_VERSION_IS_GEQ(3,6,0)
 #include_next <linux/u64_stats_sync.h>
 #else
 
@@ -112,9 +112,9 @@ static inline bool u64_stats_fetch_retry(const struct u64_stats_sync *syncp,
 #endif
 }
 
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)) */
+#endif /* LINUX_VERSION_IS_GEQ(3,6,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0) && \
+#if LINUX_VERSION_IS_LESS(3,15,0) && \
     !(LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI > 30)
 static inline unsigned int u64_stats_fetch_begin_irq(const struct u64_stats_sync *syncp)
 {
@@ -141,14 +141,14 @@ static inline bool u64_stats_fetch_retry_irq(const struct u64_stats_sync *syncp,
 #endif
 }
 
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)) */
+#endif /* LINUX_VERSION_IS_GEQ(3,15,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)
+#if LINUX_VERSION_IS_LESS(3,13,0)
 #if BITS_PER_LONG == 32 && defined(CONFIG_SMP)
 # define u64_stats_init(syncp)	seqcount_init(syncp.seq)
 #else
 # define u64_stats_init(syncp)	do { } while (0)
 #endif
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,13,0) */
 
 #endif /* __BACKPORT_LINUX_U64_STATS_SYNC_H */
diff --git a/backport/backport-include/linux/uidgid.h b/backport/backport-include/linux/uidgid.h
index ae1ed808cfd6..c2f3faa06600 100644
--- a/backport/backport-include/linux/uidgid.h
+++ b/backport/backport-include/linux/uidgid.h
@@ -1,4 +1,4 @@
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
+#if LINUX_VERSION_IS_GEQ(3,5,0)
 #include_next <linux/uidgid.h>
 #else
 
@@ -218,4 +218,4 @@ static inline bool kgid_has_mapping(struct user_namespace *ns, kgid_t gid)
 #endif /* CONFIG_USER_NS */
 
 #endif /* _LINUX_UIDGID_H */
-#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
+#endif /* LINUX_VERSION_IS_GEQ(3,5,0) */
diff --git a/backport/backport-include/linux/usb.h b/backport/backport-include/linux/usb.h
index 4acbce5eb1ca..1873a33685bf 100644
--- a/backport/backport-include/linux/usb.h
+++ b/backport/backport-include/linux/usb.h
@@ -76,7 +76,7 @@
 #define USB_SUBCLASS_VENDOR_SPEC	0xff
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0)
+#if LINUX_VERSION_IS_LESS(3,2,0)
 #define usb_translate_errors LINUX_BACKPORT(usb_translate_errors)
 static inline int usb_translate_errors(int error_code)
 {
@@ -90,6 +90,6 @@ static inline int usb_translate_errors(int error_code)
 		return -EIO;
 	}
 }
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,2,0) */
 
 #endif /* __BACKPORT_USB_H */
diff --git a/backport/backport-include/linux/usb/ch9.h b/backport/backport-include/linux/usb/ch9.h
index c343f66a6ab8..c2f0120cb919 100644
--- a/backport/backport-include/linux/usb/ch9.h
+++ b/backport/backport-include/linux/usb/ch9.h
@@ -4,7 +4,7 @@
 #include <linux/version.h>
 #include_next <linux/usb/ch9.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0)
+#if LINUX_VERSION_IS_LESS(3,2,0)
 #include <linux/types.h>    /* __u8 etc */
 #include <asm/byteorder.h>  /* le16_to_cpu */
 
@@ -21,7 +21,7 @@ static inline int usb_endpoint_maxp(const struct usb_endpoint_descriptor *epd)
 }
 #endif /* < 3.2 */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,6,0)
+#if LINUX_VERSION_IS_LESS(4,6,0)
 #define USB_SPEED_SUPER_PLUS	6
 #endif
 
diff --git a/backport/backport-include/linux/version.h b/backport/backport-include/linux/version.h
index 9d389f4e1f13..2cb601ad4293 100644
--- a/backport/backport-include/linux/version.h
+++ b/backport/backport-include/linux/version.h
@@ -13,6 +13,5 @@
 #define LINUX_VERSION_IS_LESS(x1,x2,x3)	(LINUX_VERSION_CODE < KERNEL_VERSION(x1,x2,x3))
 #define LINUX_VERSION_IS_GEQ(x1,x2,x3)	(LINUX_VERSION_CODE >= KERNEL_VERSION(x1,x2,x3))
 #define LINUX_VERSION_IN_RANGE(x1,x2,x3, y1,y2,y3) \
-	(LINUX_VERSION_CODE >= KERNEL_VERSION(x1,x2,x3) && \
-	 LINUX_VERSION_CODE < KERNEL_VERSION(y1,y2,y3))
+	(LINUX_VERSION_IS_GEQ(x1,x2,x3) && LINUX_VERSION_IS_LESS(y1,y2,y3))
 #endif /* _BP_LINUX_VERSION_H */
diff --git a/backport/backport-include/linux/wait.h b/backport/backport-include/linux/wait.h
index 4b02f52dfba3..3059ff1da60e 100644
--- a/backport/backport-include/linux/wait.h
+++ b/backport/backport-include/linux/wait.h
@@ -2,7 +2,7 @@
 #define __BACKPORT_LINUX_WAIT_H
 #include_next <linux/wait.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,17,0)
+#if LINUX_VERSION_IS_LESS(3,17,0)
 extern int bit_wait(void *);
 extern int bit_wait_io(void *);
 
@@ -23,7 +23,7 @@ backport_wait_on_bit_io(void *word, int bit, unsigned mode)
 
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,18,12)
+#if LINUX_VERSION_IS_LESS(3,18,12)
 #define WQ_FLAG_WOKEN		0x02
 
 #define wait_woken LINUX_BACKPORT(wait_woken)
@@ -37,8 +37,8 @@ int woken_wake_function(wait_queue_t *wait, unsigned mode, int sync, void *key);
  * This was introuced in kernel 3.17 and we are only able to backport this
  * function on these kernel versions.
  */
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,18,0)
+#if LINUX_VERSION_IS_GEQ(3,17,0)
+#if LINUX_VERSION_IS_LESS(3,18,0)
 #define out_of_line_wait_on_bit_timeout LINUX_BACKPORT(out_of_line_wait_on_bit_timeout)
 int out_of_line_wait_on_bit_timeout(void *, int, wait_bit_action_f *, unsigned, unsigned long);
 
@@ -46,7 +46,7 @@ int out_of_line_wait_on_bit_timeout(void *, int, wait_bit_action_f *, unsigned,
 extern int bit_wait_timeout(struct wait_bit_key *);
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,20,0)
+#if LINUX_VERSION_IS_LESS(3,20,0)
 #define wait_on_bit_timeout LINUX_BACKPORT(wait_on_bit_timeout)
 /**
  * wait_on_bit_timeout - wait for a bit to be cleared or a timeout elapses
diff --git a/backport/backport-include/linux/watchdog.h b/backport/backport-include/linux/watchdog.h
index 380762c70dc1..598c8c48a921 100644
--- a/backport/backport-include/linux/watchdog.h
+++ b/backport/backport-include/linux/watchdog.h
@@ -2,7 +2,7 @@
 #define __BACKPORT_WATCHDOG_H
 #include_next <linux/watchdog.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)
+#if LINUX_VERSION_IS_LESS(3,1,0)
 #define watchdog_device LINUX_BACKPORT(watchdog_device)
 struct watchdog_device {
 };
diff --git a/backport/backport-include/linux/workqueue.h b/backport/backport-include/linux/workqueue.h
index 078ed59e1bd0..ab68d21725ef 100644
--- a/backport/backport-include/linux/workqueue.h
+++ b/backport/backport-include/linux/workqueue.h
@@ -3,7 +3,7 @@
 #include_next <linux/workqueue.h>
 #include <linux/version.h>
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0))
+#if LINUX_VERSION_IS_LESS(3,7,0)
 #define mod_delayed_work LINUX_BACKPORT(mod_delayed_work)
 bool mod_delayed_work(struct workqueue_struct *wq, struct delayed_work *dwork,
 		      unsigned long delay);
@@ -14,7 +14,7 @@ bool mod_delayed_work(struct workqueue_struct *wq, struct delayed_work *dwork,
 #define create_freezable_workqueue create_freezeable_workqueue
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
+#if LINUX_VERSION_IS_LESS(3,3,0)
 #define __WQ_ORDERED	0
 /*
  * commit b196be89cdc14a88cc637cdad845a75c5886c82d
@@ -54,13 +54,13 @@ backport_alloc_workqueue(const char *fmt, unsigned int flags,
 void backport_destroy_workqueue(struct workqueue_struct *wq);
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)
+#if LINUX_VERSION_IS_LESS(3,11,0)
 /* power efficient workqueues were added in commit 0668106ca386. */
 #define system_power_efficient_wq system_wq
 #define system_freezable_power_efficient_wq system_freezable_wq
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)
+#if LINUX_VERSION_IS_LESS(3,1,0)
 #define drain_workqueue(wq) flush_workqueue(wq)
 #endif
 
diff --git a/backport/backport-include/net/addrconf.h b/backport/backport-include/net/addrconf.h
index c4caa99abcc1..f1e8e62781c8 100644
--- a/backport/backport-include/net/addrconf.h
+++ b/backport/backport-include/net/addrconf.h
@@ -5,7 +5,7 @@
 
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+#if LINUX_VERSION_IS_LESS(3,9,0)
 static inline bool ipv6_addr_is_solict_mult(const struct in6_addr *addr)
 {
 #if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) && BITS_PER_LONG == 64
@@ -20,6 +20,6 @@ static inline bool ipv6_addr_is_solict_mult(const struct in6_addr *addr)
 		(addr->s6_addr[12] ^ 0xff)) == 0;
 #endif
 }
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,9,0) */
 
 #endif	/* _BACKPORT_NET_ADDRCONF_H */
diff --git a/backport/backport-include/net/flow_keys.h b/backport/backport-include/net/flow_keys.h
index a875ee6eeb3b..093bc80ab4bb 100644
--- a/backport/backport-include/net/flow_keys.h
+++ b/backport/backport-include/net/flow_keys.h
@@ -1,4 +1,4 @@
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0))
+#if LINUX_VERSION_IS_GEQ(3,3,0)
 #include_next <net/flow_keys.h>
 #else
 
diff --git a/backport/backport-include/net/genetlink.h b/backport/backport-include/net/genetlink.h
index 0a1ff6edb395..8b06985ed561 100644
--- a/backport/backport-include/net/genetlink.h
+++ b/backport/backport-include/net/genetlink.h
@@ -4,7 +4,7 @@
 #include <linux/version.h>
 
 /* this is for patches we apply */
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
+#if LINUX_VERSION_IS_LESS(3,7,0)
 #define genl_info_snd_portid(__genl_info) (__genl_info->snd_pid)
 #else
 #define genl_info_snd_portid(__genl_info) (__genl_info->snd_portid)
@@ -14,11 +14,11 @@
 #define GENLMSG_DEFAULT_SIZE (NLMSG_DEFAULT_SIZE - GENL_HDRLEN)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)
+#if LINUX_VERSION_IS_LESS(3,1,0)
 #define genl_dump_check_consistent(cb, user_hdr, family)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0) && RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,0)
+#if LINUX_VERSION_IS_LESS(3,13,0) && RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,0)
 static inline int __real_genl_register_family(struct genl_family *family)
 {
 	return genl_register_family(family);
@@ -86,7 +86,7 @@ _genl_register_family_with_ops_grps(struct genl_family *family,
 #define genl_unregister_family backport_genl_unregister_family
 int genl_unregister_family(struct genl_family *family);
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
+#if LINUX_VERSION_IS_LESS(3,3,0)
 extern void genl_notify(struct sk_buff *skb, struct net *net, u32 pid,
 			u32 group, struct nlmsghdr *nlh, gfp_t flags);
 #endif
@@ -146,7 +146,7 @@ backport_genlmsg_multicast_allns(struct genl_family *family,
 #define __genl_const
 #else /* < 3.13 */
 #define __genl_const const
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,4,0)
+#if LINUX_VERSION_IS_LESS(4,4,0)
 #define genl_notify(_fam, _skb, _info, _group, _flags)			\
 	genl_notify(_fam, _skb, genl_info_net(_info),			\
 		    genl_info_snd_portid(_info),			\
@@ -154,7 +154,7 @@ backport_genlmsg_multicast_allns(struct genl_family *family,
 #endif /* < 4.4 */
 #endif /* < 3.13 */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,10,0)
+#if LINUX_VERSION_IS_LESS(4,10,0)
 /**
  * genl_family_attrbuf - return family's attrbuf
  * @family: the family
diff --git a/backport/backport-include/net/inet_frag.h b/backport/backport-include/net/inet_frag.h
index 055dae144592..e95eac33043c 100644
--- a/backport/backport-include/net/inet_frag.h
+++ b/backport/backport-include/net/inet_frag.h
@@ -3,7 +3,7 @@
 #include_next <net/inet_frag.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+#if LINUX_VERSION_IS_LESS(3,9,0)
 /* Memory Tracking Functions. */
 #define frag_mem_limit LINUX_BACKPORT(frag_mem_limit)
 static inline int frag_mem_limit(struct netns_frags *nf)
@@ -26,10 +26,10 @@ static inline int sum_frag_mem_limit(struct netns_frags *nf)
 #define inet_frag_maybe_warn_overflow LINUX_BACKPORT(inet_frag_maybe_warn_overflow)
 void inet_frag_maybe_warn_overflow(struct inet_frag_queue *q,
 				   const char *prefix);
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,9,0) */
 
 /* the type of the paramater changed with kernel 4.3 */
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+#if LINUX_VERSION_IS_LESS(3,9,0)
 #define sub_frag_mem_limit LINUX_BACKPORT(sub_frag_mem_limit)
 static inline void sub_frag_mem_limit(struct netns_frags *nf, int i)
 {
@@ -41,7 +41,7 @@ static inline void add_frag_mem_limit(struct netns_frags *nf, int i)
 {
 	atomic_add(i, &nf->mem);
 }
-#elif LINUX_VERSION_CODE < KERNEL_VERSION(4,3,0)
+#elif LINUX_VERSION_IS_LESS(4,3,0)
 #define sub_frag_mem_limit LINUX_BACKPORT(sub_frag_mem_limit)
 static inline void sub_frag_mem_limit(struct netns_frags *nf, int i)
 {
@@ -53,10 +53,10 @@ static inline void add_frag_mem_limit(struct netns_frags *nf, int i)
 {
 	__percpu_counter_add(&nf->mem, i, frag_percpu_counter_batch);
 }
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,3,0) */
+#endif /* LINUX_VERSION_IS_LESS(4,3,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,4,0) && \
-    LINUX_VERSION_CODE >= KERNEL_VERSION(3,9,0)
+#if LINUX_VERSION_IS_LESS(4,4,0) && \
+    LINUX_VERSION_IS_GEQ(3,9,0)
 #define inet_frags_uninit_net LINUX_BACKPORT(inet_frags_uninit_net)
 static inline void inet_frags_uninit_net(struct netns_frags *nf)
 {
@@ -64,7 +64,7 @@ static inline void inet_frags_uninit_net(struct netns_frags *nf)
 }
 #endif /* < 4.4 && >= 3.9 */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,4,0)
+#if LINUX_VERSION_IS_LESS(4,4,0)
 static inline int backport_inet_frags_init_net(struct netns_frags *nf)
 {
 	inet_frags_init_net(nf);
diff --git a/backport/backport-include/net/ip.h b/backport/backport-include/net/ip.h
index 909e60392eab..6893ba51f3a5 100644
--- a/backport/backport-include/net/ip.h
+++ b/backport/backport-include/net/ip.h
@@ -3,7 +3,7 @@
 #include_next <net/ip.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)
+#if LINUX_VERSION_IS_LESS(3,1,0)
 /* Backports 56f8a75c */
 static inline bool ip_is_fragment(const struct iphdr *iph)
 {
diff --git a/backport/backport-include/net/ip6_fib.h b/backport/backport-include/net/ip6_fib.h
index ebdc94c771a8..2f21163de413 100644
--- a/backport/backport-include/net/ip6_fib.h
+++ b/backport/backport-include/net/ip6_fib.h
@@ -9,7 +9,7 @@
  * This function is avaliable with one argument since kernel 3.10, but the
  * secound one was added in 4.2.
  */
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)
+#if LINUX_VERSION_IS_LESS(4,2,0)
 #define rt6_nexthop LINUX_BACKPORT(rt6_nexthop)
 static inline struct in6_addr *rt6_nexthop(struct rt6_info *rt,
 					   struct in6_addr *daddr)
@@ -21,6 +21,6 @@ static inline struct in6_addr *rt6_nexthop(struct rt6_info *rt,
 	else
 		return daddr;
 }
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0) */
+#endif /* LINUX_VERSION_IS_LESS(4,2,0) */
 
 #endif /* __BACKPORT_NET_IP6_ROUTE_H */
diff --git a/backport/backport-include/net/ipv6.h b/backport/backport-include/net/ipv6.h
index 762ad781291d..7416d6b0bb61 100644
--- a/backport/backport-include/net/ipv6.h
+++ b/backport/backport-include/net/ipv6.h
@@ -5,7 +5,7 @@
 #include <net/addrconf.h>
 #include <net/inet_frag.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
+#if LINUX_VERSION_IS_LESS(3,7,0)
 /*
  *	Equivalent of ipv4 struct ip
  */
@@ -21,9 +21,9 @@ struct frag_queue {
 	unsigned int            csum;
 	__u16                   nhoffset;
 };
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,7,0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,6,0)
+#if LINUX_VERSION_IS_LESS(3,6,0)
 #define ipv6_addr_hash LINUX_BACKPORT(ipv6_addr_hash)
 static inline u32 ipv6_addr_hash(const struct in6_addr *a)
 {
@@ -39,7 +39,7 @@ static inline u32 ipv6_addr_hash(const struct in6_addr *a)
 }
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,5,0)
+#if LINUX_VERSION_IS_LESS(4,5,0)
 #define ipv6_addr_prefix_copy LINUX_BACKPORT(ipv6_addr_prefix_copy)
 static inline void ipv6_addr_prefix_copy(struct in6_addr *addr,
 					 const struct in6_addr *pfx,
diff --git a/backport/backport-include/net/iw_handler.h b/backport/backport-include/net/iw_handler.h
index b4571016463f..84d63b30953e 100644
--- a/backport/backport-include/net/iw_handler.h
+++ b/backport/backport-include/net/iw_handler.h
@@ -2,7 +2,7 @@
 #define __BACKPORT_IW_HANDLER_H
 #include_next <net/iw_handler.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
+#if LINUX_VERSION_IS_LESS(4,1,0)
 static inline char *
 iwe_stream_add_event_check(struct iw_request_info *info, char *stream,
 			   char *ends, struct iw_event *iwe, int event_len)
@@ -24,16 +24,16 @@ iwe_stream_add_point_check(struct iw_request_info *info, char *stream,
 		return ERR_PTR(-E2BIG);
 	return res;
 }
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
+#endif /* LINUX_VERSION_IS_LESS(4,1,0) */
 
 /* this was added in v3.2.79, v3.18.30, v4.1.21, v4.4.6 and 4.5 */
-#if !(LINUX_VERSION_CODE >= KERNEL_VERSION(4,4,6) || \
-      (LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,21) && \
-       LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)) || \
-      (LINUX_VERSION_CODE >= KERNEL_VERSION(3,18,30) && \
-       LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)) || \
-      (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,79) && \
-       LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)))
+#if !(LINUX_VERSION_IS_GEQ(4,4,6) || \
+      (LINUX_VERSION_IS_GEQ(4,1,21) && \
+       LINUX_VERSION_IS_LESS(4,2,0)) || \
+      (LINUX_VERSION_IS_GEQ(3,18,30) && \
+       LINUX_VERSION_IS_LESS(3,19,0)) || \
+      (LINUX_VERSION_IS_GEQ(3,2,79) && \
+       LINUX_VERSION_IS_LESS(3,3,0)))
 #define wireless_nlevent_flush LINUX_BACKPORT(wireless_nlevent_flush)
 static inline void wireless_nlevent_flush(void) {}
 #endif
diff --git a/backport/backport-include/net/net_namespace.h b/backport/backport-include/net/net_namespace.h
index b4c6b9909bdb..1e84297c9476 100644
--- a/backport/backport-include/net/net_namespace.h
+++ b/backport/backport-include/net/net_namespace.h
@@ -3,7 +3,7 @@
 
 #include_next <net/net_namespace.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,20,0)
+#if LINUX_VERSION_IS_LESS(3,20,0)
 /*
  * In older kernels we simply fail this function.
  */
@@ -14,7 +14,7 @@ static inline struct net *get_net_ns_by_fd(int fd)
 }
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
+#if LINUX_VERSION_IS_LESS(4,1,0)
 typedef struct {
 #ifdef CONFIG_NET_NS
 	struct net *net;
@@ -39,6 +39,6 @@ static inline struct net *possible_read_pnet(const possible_net_t *pnet)
 #else
 #define possible_write_pnet(pnet, net) write_pnet(pnet, net)
 #define possible_read_pnet(pnet) read_pnet(pnet)
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
+#endif /* LINUX_VERSION_IS_LESS(4,1,0) */
 
 #endif	/* _COMPAT_NET_NET_NAMESPACE_H */
diff --git a/backport/backport-include/net/netlink.h b/backport/backport-include/net/netlink.h
index 3cc1a365b216..9a3def77edb9 100644
--- a/backport/backport-include/net/netlink.h
+++ b/backport/backport-include/net/netlink.h
@@ -4,7 +4,7 @@
 #include <linux/version.h>
 #include <linux/in6.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)
+#if LINUX_VERSION_IS_LESS(3,7,0)
 /**
  * nla_put_s8 - Add a s8 netlink attribute to a socket buffer
  * @skb: socket buffer to add attribute to
@@ -86,7 +86,7 @@ static inline s64 nla_get_s64(const struct nlattr *nla)
 }
 #endif /* < 3.7.0 */
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0))
+#if LINUX_VERSION_IS_LESS(3,5,0)
 /*
  * This backports:
  * commit 569a8fc38367dfafd87454f27ac646c8e6b54bca
@@ -115,7 +115,7 @@ static inline int nla_put_be64(struct sk_buff *skb, int attrtype, __be64 value)
 }
 #endif /* < 3.5 */
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0))
+#if LINUX_VERSION_IS_LESS(3,7,0)
 #define NLA_S8 (NLA_BINARY + 1)
 #define NLA_S16 (NLA_BINARY + 2)
 #define NLA_S32 (NLA_BINARY + 3)
@@ -126,7 +126,7 @@ static inline int nla_put_be64(struct sk_buff *skb, int attrtype, __be64 value)
 #define NLA_TYPE_MAX (__NLA_TYPE_MAX - 1)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
+#if LINUX_VERSION_IS_LESS(4,1,0)
 #define nla_put_in_addr LINUX_BACKPORT(nla_put_in_addr)
 static inline int nla_put_in_addr(struct sk_buff *skb, int attrtype,
 				  __be32 addr)
@@ -155,7 +155,7 @@ static inline struct in6_addr nla_get_in6_addr(const struct nlattr *nla)
 }
 #endif /* < 4.1 */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,4,0)
+#if LINUX_VERSION_IS_LESS(4,4,0)
 /**
  * nla_get_le32 - return payload of __le32 attribute
  * @nla: __le32 netlink attribute
@@ -177,7 +177,7 @@ static inline __le64 nla_get_le64(const struct nlattr *nla)
 }
 #endif /* < 4.4 */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,7,0)
+#if LINUX_VERSION_IS_LESS(4,7,0)
 /**
  * nla_need_padding_for_64bit - test 64-bit alignment of the next attribute
  * @skb: socket buffer the message is stored in
@@ -275,7 +275,7 @@ static inline int nla_put_s64(struct sk_buff *skb, int attrtype, s64 value,
 }
 #endif /* < 4.7 */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,10,0)
+#if LINUX_VERSION_IS_LESS(4,10,0)
 /**
  * nla_memdup - duplicate attribute memory (kmemdup)
  * @src: netlink attribute to duplicate from
diff --git a/backport/backport-include/net/sch_generic.h b/backport/backport-include/net/sch_generic.h
index a8637976acfa..cabc6012817b 100644
--- a/backport/backport-include/net/sch_generic.h
+++ b/backport/backport-include/net/sch_generic.h
@@ -2,8 +2,8 @@
 #define __BACKPORT_NET_SCH_GENERIC_H
 #include_next <net/sch_generic.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
-#if !((LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,9) && LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)) || (LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,23) && LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)))
+#if LINUX_VERSION_IS_LESS(3,3,0)
+#if !((LINUX_VERSION_IS_GEQ(3,2,9) && LINUX_VERSION_IS_LESS(3,3,0)) || (LINUX_VERSION_IS_GEQ(3,0,23) && LINUX_VERSION_IS_LESS(3,1,0)))
 /* mask qdisc_cb_private_validate as RHEL6 backports this */
 #define qdisc_cb_private_validate(a,b) compat_qdisc_cb_private_validate(a,b)
 static inline void qdisc_cb_private_validate(const struct sk_buff *skb, int sz)
@@ -11,7 +11,7 @@ static inline void qdisc_cb_private_validate(const struct sk_buff *skb, int sz)
 	BUILD_BUG_ON(sizeof(skb->cb) < sizeof(struct qdisc_skb_cb) + sz);
 }
 #endif
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,3,0) */
 
 #ifndef TCQ_F_CAN_BYPASS
 #define TCQ_F_CAN_BYPASS        4
diff --git a/backport/backport-include/net/sock.h b/backport/backport-include/net/sock.h
index 490b68cc1374..89191f3751b1 100644
--- a/backport/backport-include/net/sock.h
+++ b/backport/backport-include/net/sock.h
@@ -3,7 +3,7 @@
 #include_next <net/sock.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
+#if LINUX_VERSION_IS_LESS(3,9,0)
 #include <backport/magic.h>
 
 #define sk_for_each3(__sk, node, list) \
@@ -27,7 +27,7 @@
 
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,10,0)
+#if LINUX_VERSION_IS_LESS(3,10,0)
 /*
  * backport SOCK_SELECT_ERR_QUEUE -- see commit
  * "net: add option to enable error queue packets waking select"
@@ -43,11 +43,11 @@
 	BUILD_BUG_ON((size) > FIELD_SIZEOF(struct sk_buff, cb))
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,2,0)
+#if LINUX_VERSION_IS_LESS(4,2,0)
 #define sk_alloc(net, family, priority, prot, kern) sk_alloc(net, family, priority, prot)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,5,0)
+#if LINUX_VERSION_IS_LESS(4,5,0)
 #define sk_set_bit LINUX_BACKPORT(sk_set_bit)
 static inline void sk_set_bit(int nr, struct sock *sk)
 {
@@ -55,7 +55,7 @@ static inline void sk_set_bit(int nr, struct sock *sk)
 }
 #endif /* < 4.5 */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,5,0)
+#if LINUX_VERSION_IS_LESS(4,5,0)
 #define sk_clear_bit LINUX_BACKPORT(sk_clear_bit)
 static inline void sk_clear_bit(int nr, struct sock *sk)
 {
diff --git a/backport/backport-include/net/tso.h b/backport/backport-include/net/tso.h
index 816928c301a8..3a3f50b3e124 100644
--- a/backport/backport-include/net/tso.h
+++ b/backport/backport-include/net/tso.h
@@ -3,7 +3,7 @@
 
 #include <net/ip.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,4,0)
+#if LINUX_VERSION_IS_LESS(4,4,0)
 
 #define tso_t LINUX_BACKPORT(tso_t)
 struct tso_t {
diff --git a/backport/backport-include/sound/core.h b/backport/backport-include/sound/core.h
index beb89353538e..79f8b319277c 100644
--- a/backport/backport-include/sound/core.h
+++ b/backport/backport-include/sound/core.h
@@ -2,7 +2,7 @@
 #define _BACKPORT_SOUND_CORE_H
 #include_next <sound/core.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0)
+#if LINUX_VERSION_IS_LESS(3,15,0)
 #define snd_card_new LINUX_BACKPORT(snd_card_new)
 static inline
 int snd_card_new(struct device *parent, int idx, const char *xid,
diff --git a/backport/backport-include/sound/pcm.h b/backport/backport-include/sound/pcm.h
index 469e871b3c9a..d5794ef97aff 100644
--- a/backport/backport-include/sound/pcm.h
+++ b/backport/backport-include/sound/pcm.h
@@ -3,7 +3,7 @@
 #include_next <sound/pcm.h>
 #include <linux/version.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
+#if LINUX_VERSION_IS_LESS(3,19,0)
 /**
  * snd_pcm_stop_xrun - stop the running streams as XRUN
  * @substream: the PCM substream instance
@@ -24,6 +24,6 @@ static inline int snd_pcm_stop_xrun(struct snd_pcm_substream *substream)
 	snd_pcm_stream_unlock_irqrestore(substream, flags);
 	return ret;
 }
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,19,0) */
 
 #endif /* __BACKPORT_SOUND_PCM_H */
diff --git a/backport/backport-include/uapi/linux/genetlink.h b/backport/backport-include/uapi/linux/genetlink.h
index 8900f0270c96..620626aee972 100644
--- a/backport/backport-include/uapi/linux/genetlink.h
+++ b/backport/backport-include/uapi/linux/genetlink.h
@@ -1,7 +1,7 @@
 #ifndef __BACKPORT_UAPI_LINUX_GENETLINK_H
 #define __BACKPORT_UAPI_LINUX_GENETLINK_H
 #include <linux/version.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
+#if LINUX_VERSION_IS_GEQ(3,7,0)
 #include_next <uapi/linux/genetlink.h>
 #else
 #include_next <linux/genetlink.h>
diff --git a/backport/backport-include/uapi/linux/sockios.h b/backport/backport-include/uapi/linux/sockios.h
index 6c4febe9b1cc..12a7dd6cd4af 100644
--- a/backport/backport-include/uapi/linux/sockios.h
+++ b/backport/backport-include/uapi/linux/sockios.h
@@ -25,7 +25,7 @@
  * supported and meats the expected form.
  */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0)
+#if LINUX_VERSION_IS_LESS(3,14,0)
 #define SIOCGHWTSTAMP	0x89b1		/* get config			*/
-#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,14,0) */
+#endif /* LINUX_VERSION_IS_LESS(3,14,0) */
 #endif /* __BACKPORT_LINUX_SOCKIOS_H */
diff --git a/backport/compat/backport-3.13.c b/backport/compat/backport-3.13.c
index 6ce72b2c79fb..496bee60e5ad 100644
--- a/backport/compat/backport-3.13.c
+++ b/backport/compat/backport-3.13.c
@@ -17,7 +17,7 @@
 #include <linux/device.h>
 #include <linux/hwmon.h>
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
+#if LINUX_VERSION_IS_GEQ(3,5,0)
 #ifdef CONFIG_REGULATOR
 #include <linux/module.h>
 #include <linux/regulator/driver.h>
@@ -90,7 +90,7 @@ void devm_regulator_unregister(struct device *dev, struct regulator_dev *rdev)
 }
 EXPORT_SYMBOL_GPL(devm_regulator_unregister);
 #endif /* CONFIG_REGULATOR */
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)) */
+#endif /* LINUX_VERSION_IS_GEQ(3,5,0) */
 
 /************* generic netlink backport *****************/
 #if RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,0)
@@ -111,10 +111,10 @@ int __backport_genl_register_family(struct genl_family *family)
 	__copy(netnsok);
 	__copy(pre_doit);
 	__copy(post_doit);
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
+#if LINUX_VERSION_IS_GEQ(3,10,0)
 	__copy(parallel_ops);
 #endif
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
+#if LINUX_VERSION_IS_GEQ(3,11,0)
 	__copy(module);
 #endif
 #undef __copy
diff --git a/backport/compat/backport-3.18.c b/backport/compat/backport-3.18.c
index 5c3e751ebb96..73db233cb22b 100644
--- a/backport/compat/backport-3.18.c
+++ b/backport/compat/backport-3.18.c
@@ -167,7 +167,7 @@ struct sk_buff *skb_clone_sk(struct sk_buff *skb)
 }
 EXPORT_SYMBOL_GPL(skb_clone_sk);
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
+#if LINUX_VERSION_IS_GEQ(3,3,0)
 /*
  * skb_complete_wifi_ack() needs to get backported, because the version from
  * 3.18 added the sock_hold() and sock_put() calles missing in older versions.
@@ -198,7 +198,7 @@ void skb_complete_wifi_ack(struct sk_buff *skb, bool acked)
 EXPORT_SYMBOL_GPL(skb_complete_wifi_ack);
 #endif
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
+#if LINUX_VERSION_IS_GEQ(3,17,0)
 int __sched out_of_line_wait_on_bit_timeout(
 	void *word, int bit, wait_bit_action_f *action,
 	unsigned mode, unsigned long timeout)
@@ -288,17 +288,17 @@ int of_property_read_u64_array(const struct device_node *np,
 EXPORT_SYMBOL_GPL(of_property_read_u64_array);
 #endif /* CONFIG_OF */
 
-#if !(LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,3) || \
-      (LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,24) && \
-      LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0)) || \
-      (LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,33) && \
-      LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)) || \
-      (LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,60) && \
-      LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)) || \
-      (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,106) && \
-      LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0)) || \
-      (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,65) && \
-      LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)))
+#if !(LINUX_VERSION_IS_GEQ(3,17,3) || \
+      (LINUX_VERSION_IS_GEQ(3,14,24) && \
+      LINUX_VERSION_IS_LESS(3,15,0)) || \
+      (LINUX_VERSION_IS_GEQ(3,12,33) && \
+      LINUX_VERSION_IS_LESS(3,13,0)) || \
+      (LINUX_VERSION_IS_GEQ(3,10,60) && \
+      LINUX_VERSION_IS_LESS(3,11,0)) || \
+      (LINUX_VERSION_IS_GEQ(3,4,106) && \
+      LINUX_VERSION_IS_LESS(3,5,0)) || \
+      (LINUX_VERSION_IS_GEQ(3,2,65) && \
+      LINUX_VERSION_IS_LESS(3,3,0)))
 /**
  * memzero_explicit - Fill a region of memory (e.g. sensitive
  *		      keying data) with 0s.
diff --git a/backport/compat/backport-3.19.c b/backport/compat/backport-3.19.c
index b2db990886dd..019644dfab42 100644
--- a/backport/compat/backport-3.19.c
+++ b/backport/compat/backport-3.19.c
@@ -16,7 +16,7 @@
 #include <linux/skbuff.h>
 #include <linux/debugfs.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3,18,12)
+#if LINUX_VERSION_IS_LESS(3,18,12)
 static inline bool is_kthread_should_stop(void)
 {
 	return (current->flags & PF_KTHREAD) && kthread_should_stop();
diff --git a/backport/compat/backport-4.1.c b/backport/compat/backport-4.1.c
index f367e3b8c658..e0a3ec63fdc2 100644
--- a/backport/compat/backport-4.1.c
+++ b/backport/compat/backport-4.1.c
@@ -21,7 +21,7 @@ netdev_features_t passthru_features_check(struct sk_buff *skb,
 EXPORT_SYMBOL_GPL(passthru_features_check);
 
 #ifdef CONFIG_TTY
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,0,0)
+#if LINUX_VERSION_IS_GEQ(4,0,0)
 static void unset_locked_termios(struct ktermios *termios,
 				 struct ktermios *old,
 				 struct ktermios *locked)
@@ -80,5 +80,5 @@ int tty_set_termios(struct tty_struct *tty, struct ktermios *new_termios)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tty_set_termios);
-#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,0,0) */
+#endif /* LINUX_VERSION_IS_GEQ(4,0,0) */
 #endif /* CONFIG_TTY */
diff --git a/backport/compat/backport-4.3.c b/backport/compat/backport-4.3.c
index 6f4fc3b1a39a..2d8a5e5b19aa 100644
--- a/backport/compat/backport-4.3.c
+++ b/backport/compat/backport-4.3.c
@@ -96,7 +96,7 @@ static int backport_thermal_get_crit_temp(struct thermal_zone_device *dev,
 	return ret;
 }
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 19, 0)
+#if LINUX_VERSION_IS_GEQ(3, 19, 0)
 static int backport_thermal_set_emul_temp(struct thermal_zone_device *dev,
 					  unsigned long temp)
 {
@@ -105,7 +105,7 @@ static int backport_thermal_set_emul_temp(struct thermal_zone_device *dev,
 
 	return wrapper->driver_ops->set_emul_temp(dev, (int)temp);
 }
-#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3, 19, 0) */
+#endif /* LINUX_VERSION_IS_GEQ(3, 19, 0) */
 
 struct thermal_zone_device *backport_thermal_zone_device_register(
 	const char *type, int trips, int mask, void *devdata,
@@ -146,9 +146,9 @@ struct thermal_zone_device *backport_thermal_zone_device_register(
 	assign_ops(get_trip_hyst);
 	assign_ops(set_trip_hyst);
 	assign_ops(get_crit_temp);
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 19, 0)
+#if LINUX_VERSION_IS_GEQ(3, 19, 0)
 	assign_ops(set_emul_temp);
-#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3, 19, 0) */
+#endif /* LINUX_VERSION_IS_GEQ(3, 19, 0) */
 #undef assign_ops
 
 	ret = old_thermal_zone_device_register(type, trips, mask, devdata,
diff --git a/backport/compat/backport-4.4.c b/backport/compat/backport-4.4.c
index 885438592531..1c11a2064e53 100644
--- a/backport/compat/backport-4.4.c
+++ b/backport/compat/backport-4.4.c
@@ -20,7 +20,7 @@
 #include <asm/unaligned.h>
 
 #ifdef CONFIG_DEBUG_FS
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4,3,0)
+#if LINUX_VERSION_IS_LESS(4,3,0)
 static ssize_t debugfs_read_file_bool(struct file *file, char __user *user_buf,
 				      size_t count, loff_t *ppos)
 {
diff --git a/backport/compat/backport-4.5.c b/backport/compat/backport-4.5.c
index bbf4f3bb5ff8..69751d515234 100644
--- a/backport/compat/backport-4.5.c
+++ b/backport/compat/backport-4.5.c
@@ -20,7 +20,7 @@
 #include <linux/string.h>
 #include <asm/uaccess.h>
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
+#if LINUX_VERSION_IS_GEQ(3,19,0)
 int led_set_brightness_sync(struct led_classdev *led_cdev,
 			    enum led_brightness value)
 {
@@ -40,7 +40,7 @@ int led_set_brightness_sync(struct led_classdev *led_cdev,
 EXPORT_SYMBOL_GPL(led_set_brightness_sync);
 #endif /* >= 3.19 */
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
+#if LINUX_VERSION_IS_GEQ(3,2,0)
 /**
  * no_seek_end_llseek - llseek implementation for fixed-sized devices
  * @file:	file structure to seek on
@@ -52,7 +52,7 @@ loff_t no_seek_end_llseek(struct file *file, loff_t offset, int whence)
 {
 	switch (whence) {
 	case SEEK_SET: case SEEK_CUR:
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
+#if LINUX_VERSION_IS_GEQ(3,6,0)
 		return generic_file_llseek_size(file, offset, whence,
 						~0ULL, 0);
 #else
diff --git a/backport/compat/compat-3.3.c b/backport/compat/compat-3.3.c
index 490c29bdf757..c064f09d9abe 100644
--- a/backport/compat/compat-3.3.c
+++ b/backport/compat/compat-3.3.c
@@ -25,10 +25,10 @@ static void __copy_skb_header(struct sk_buff *new, const struct sk_buff *old)
 	new->mac_header		= old->mac_header;
 	skb_dst_copy(new, old);
 	new->rxhash		= old->rxhash;
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,1,0))
+#if LINUX_VERSION_IS_GEQ(3,1,0)
 	new->ooo_okay		= old->ooo_okay;
 #endif
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
+#if LINUX_VERSION_IS_GEQ(3,2,0)
 	new->l4_rxhash		= old->l4_rxhash;
 #endif
 #ifdef CONFIG_XFRM
@@ -145,7 +145,7 @@ struct sk_buff *__pskb_copy(struct sk_buff *skb, int headroom, gfp_t gfp_mask)
 #endif
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 			skb_shinfo(n)->frags[i] = skb_shinfo(skb)->frags[i];
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
+#if LINUX_VERSION_IS_GEQ(3,2,0)
 			skb_frag_ref(skb, i);
 #else
 			get_page(skb_shinfo(skb)->frags[i].page);
diff --git a/backport/compat/compat-3.4.c b/backport/compat/compat-3.4.c
index bc090b7830d6..527537255e64 100644
--- a/backport/compat/compat-3.4.c
+++ b/backport/compat/compat-3.4.c
@@ -14,13 +14,13 @@
 #include <linux/compat.h>
 #include <asm/uaccess.h>
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
+#if LINUX_VERSION_IS_GEQ(3,2,0)
 #include <linux/regmap.h>
 #include <linux/i2c.h>
 #include <linux/spi/spi.h>
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)) */
+#endif /* LINUX_VERSION_IS_GEQ(3,2,0) */
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
+#if LINUX_VERSION_IS_GEQ(3,2,0)
 
 #if defined(CONFIG_REGMAP)
 static void devm_regmap_release(struct device *dev, void *res)
@@ -172,7 +172,7 @@ EXPORT_SYMBOL_GPL(devm_regmap_init_i2c);
 #endif /* defined(CONFIG_REGMAP_I2C) */
 
 #endif /* defined(CONFIG_REGMAP) */
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)) */
+#endif /* LINUX_VERSION_IS_GEQ(3,2,0) */
 
 int simple_open(struct inode *inode, struct file *file)
 {
diff --git a/backport/compat/compat-3.5.c b/backport/compat/compat-3.5.c
index 1b8f7874db13..de3122839182 100644
--- a/backport/compat/compat-3.5.c
+++ b/backport/compat/compat-3.5.c
@@ -15,7 +15,7 @@
 #include <linux/gpio.h>
 #include <linux/ptp_clock_kernel.h>
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
+#if LINUX_VERSION_IS_GEQ(3,2,0)
 #include <linux/device.h>
 
 /**
@@ -47,7 +47,7 @@ int devres_release(struct device *dev, dr_release_t release,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(devres_release);
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)) */
+#endif /* LINUX_VERSION_IS_GEQ(3,2,0) */
 
 /*
  * Commit 7a4e7408c5cadb240e068a662251754a562355e3
diff --git a/backport/compat/compat-3.7.c b/backport/compat/compat-3.7.c
index e3721676a423..a70709c99061 100644
--- a/backport/compat/compat-3.7.c
+++ b/backport/compat/compat-3.7.c
@@ -254,7 +254,7 @@ EXPORT_SYMBOL_GPL(pcie_capability_clear_and_set_dword);
 #endif
 
 #ifdef CONFIG_OF
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0))
+#if LINUX_VERSION_IS_LESS(3,7,0)
 /**
  *	of_get_child_by_name - Find the child node by name for a given parent
  *	@node:	parent node
@@ -277,7 +277,7 @@ struct device_node *of_get_child_by_name(const struct device_node *node,
 	return child;
 }
 EXPORT_SYMBOL_GPL(of_get_child_by_name);
-#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,0)) */
+#endif /* LINUX_VERSION_IS_LESS(3,7,0) */
 #endif /* CONFIG_OF */
 
 int sg_nents(struct scatterlist *sg)
diff --git a/backport/compat/compat-3.8.c b/backport/compat/compat-3.8.c
index 7e1b979791f2..ff9cd49300d9 100644
--- a/backport/compat/compat-3.8.c
+++ b/backport/compat/compat-3.8.c
@@ -22,7 +22,7 @@
 #include <linux/pci.h>
 #include <linux/pci_regs.h>
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,7,8))
+#if LINUX_VERSION_IS_LESS(3,7,8)
 void netdev_set_default_ethtool_ops(struct net_device *dev,
 				    const struct ethtool_ops *ops)
 {
@@ -275,7 +275,7 @@ static bool hid_match_one_id(struct hid_device *hdev,
 		const struct hid_device_id *id)
 {
 	return (id->bus == HID_BUS_ANY || id->bus == hdev->bus) &&
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0))
+#if LINUX_VERSION_IS_GEQ(3,8,0)
 		(id->group == HID_GROUP_ANY || id->group == hdev->group) &&
 #endif
 		(id->vendor == HID_ANY_ID || id->vendor == hdev->vendor) &&
diff --git a/patches/0001-group-attr/0001-group_attr_class.cocci b/patches/0001-group-attr/0001-group_attr_class.cocci
index a9c84651eedc..b08cb3cdca07 100644
--- a/patches/0001-group-attr/0001-group_attr_class.cocci
+++ b/patches/0001-group-attr/0001-group_attr_class.cocci
@@ -46,7 +46,7 @@ fresh identifier group_dev_attr = attribute_group.group ## "_dev_attrs";
 @@
 
 struct class group_class = {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
++#if LINUX_VERSION_IS_GEQ(3,11,0)
 	.dev_groups = groups,
 +#else
 +	.dev_attrs = group_dev_attr,
@@ -58,7 +58,7 @@ declarer name ATTRIBUTE_GROUPS_BACKPORT;
 identifier attribute_group.group;
 @@
 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
++#if LINUX_VERSION_IS_GEQ(3,11,0)
 ATTRIBUTE_GROUPS(group);
 +#else
 +#define BP_ATTR_GRP_STRUCT device_attribute
diff --git a/patches/0001-group-attr/0002-group_attr_bus.cocci b/patches/0001-group-attr/0002-group_attr_bus.cocci
index c19e9d7f3eda..5d75144d6137 100644
--- a/patches/0001-group-attr/0002-group_attr_bus.cocci
+++ b/patches/0001-group-attr/0002-group_attr_bus.cocci
@@ -44,7 +44,7 @@ fresh identifier group_dev_attr = attribute_group.group ## "_dev_attrs";
 @@
 
 struct bus_type group_bus = {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0)
++#if LINUX_VERSION_IS_GEQ(3,12,0)
 	.dev_groups = groups,
 +#else
 +	.dev_attrs = group_dev_attr,
@@ -56,7 +56,7 @@ declarer name ATTRIBUTE_GROUPS_BACKPORT;
 identifier attribute_group.group;
 @@
 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0)
++#if LINUX_VERSION_IS_GEQ(3,12,0)
 ATTRIBUTE_GROUPS(group);
 +#else
 +#define BP_ATTR_GRP_STRUCT device_attribute
diff --git a/patches/0001-group-attr/0003-class_groups.cocci b/patches/0001-group-attr/0003-class_groups.cocci
index a4694dd75763..781f6c2b96de 100644
--- a/patches/0001-group-attr/0003-class_groups.cocci
+++ b/patches/0001-group-attr/0003-class_groups.cocci
@@ -20,7 +20,7 @@ fresh identifier group_dev_attr = attribute_group.group ## "_dev_attrs";
 @@
 
 struct class group_class = {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,10,0)
++#if LINUX_VERSION_IS_GEQ(4,10,0)
 	.class_groups = groups,
 +#else
 +	.class_attrs = group_dev_attr,
@@ -32,7 +32,7 @@ declarer name ATTRIBUTE_GROUPS_BACKPORT;
 identifier attribute_group.group;
 @@
 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,10,0)
++#if LINUX_VERSION_IS_GEQ(4,10,0)
 ATTRIBUTE_GROUPS(group);
 +#else
 +#define BP_ATTR_GRP_STRUCT class_attribute
diff --git a/patches/0001-v4l2-dma_mmap_coherent-revert.patch b/patches/0001-v4l2-dma_mmap_coherent-revert.patch
index 352a54224038..85c1bb017357 100644
--- a/patches/0001-v4l2-dma_mmap_coherent-revert.patch
+++ b/patches/0001-v4l2-dma_mmap_coherent-revert.patch
@@ -29,8 +29,8 @@ Date:   Thu Jun 14 11:32:21 2012 -0300
  	return buf;
  }
  
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0))
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0))
++#if LINUX_VERSION_IS_LESS(3,9,0)
++#if LINUX_VERSION_IS_GEQ(3,2,0)
 +static int
 +backport_vb2_mmap_pfn_range(struct vm_area_struct *vma, unsigned long paddr,
 +			    unsigned long size,
@@ -73,7 +73,7 @@ Date:   Thu Jun 14 11:32:21 2012 -0300
 +	return backport_vb2_mmap_pfn_range(vma, buf->dma_addr, buf->size,
 +					   &vb2_common_vm_ops, &buf->handler);
 +}
-+#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)) */
++#endif /* LINUX_VERSION_IS_GEQ(3,2,0) */
 +#else
  static int vb2_dc_mmap(void *buf_priv, struct vm_area_struct *vma)
  {
@@ -82,7 +82,7 @@ Date:   Thu Jun 14 11:32:21 2012 -0300
  
  	return 0;
  }
-+#endif /* (LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)) */
++#endif /* LINUX_VERSION_IS_LESS(3,9,0) */
  
  /*********************************************/
  /*         DMABUF ops for exporters          */
diff --git a/patches/0002-disable-dump-adjust-on-old-kernels.patch b/patches/0002-disable-dump-adjust-on-old-kernels.patch
index 64e4f91f97dc..4b9fdcd32c50 100644
--- a/patches/0002-disable-dump-adjust-on-old-kernels.patch
+++ b/patches/0002-disable-dump-adjust-on-old-kernels.patch
@@ -32,7 +32,7 @@ Date:   Fri Mar 1 14:03:49 2013 +0100
  						 cb->nlh->nlmsg_seq,
  						 NLM_F_MULTI, state);
  			if (ret < 0) {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,1,0)
++#if LINUX_VERSION_IS_GEQ(3,1,0)
  				/*
  				 * If sending the wiphy data didn't fit (ENOBUFS
  				 * or EMSGSIZE returned), this SKB is still
diff --git a/patches/0002-gpio-parent.cocci b/patches/0002-gpio-parent.cocci
index b266facce07c..fd953447b5a2 100644
--- a/patches/0002-gpio-parent.cocci
+++ b/patches/0002-gpio-parent.cocci
@@ -9,17 +9,17 @@
 struct gpio_chip *chip;
 expression E1;
 @@
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,5,0)
++#if LINUX_VERSION_IS_GEQ(4,5,0)
  chip->parent = E1;
 +#else
 +chip->dev = E1;
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,5,0) */
++#endif /* LINUX_VERSION_IS_GEQ(4,5,0) */
 @r2@
 struct gpio_chip chip;
 expression E2;
 @@
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,5,0)
++#if LINUX_VERSION_IS_GEQ(4,5,0)
  chip.parent = E2;
 +#else
 +chip.dev = E2;
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,5,0) */
++#endif /* LINUX_VERSION_IS_GEQ(4,5,0) */
diff --git a/patches/0006-ieee802154-6lowpan-namespace.patch b/patches/0006-ieee802154-6lowpan-namespace.patch
index 7e1fef305c8d..2412a45000bb 100644
--- a/patches/0006-ieee802154-6lowpan-namespace.patch
+++ b/patches/0006-ieee802154-6lowpan-namespace.patch
@@ -8,7 +8,7 @@ idea yet.
  	struct net *net;
  
  	fq = container_of((struct inet_frag_queue *)data, struct frag_queue, q);
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0))
++#if LINUX_VERSION_IS_GEQ(3,15,0)
  	net = container_of(fq->q.net, struct net, ieee802154_lowpan.frags);
 +#else
 +	net = &init_net;
@@ -20,7 +20,7 @@ idea yet.
  static struct ctl_table lowpan_frags_ns_ctl_table[] = {
  	{
  		.procname	= "6lowpanfrag_high_thresh",
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0))
++#if LINUX_VERSION_IS_GEQ(3,15,0)
  		.data		= &init_net.ieee802154_lowpan.frags.high_thresh,
 +#else
 +		.data		= &ieee802154_lowpan.frags.high_thresh,
@@ -28,7 +28,7 @@ idea yet.
  		.maxlen		= sizeof(int),
  		.mode		= 0644,
  		.proc_handler	= proc_dointvec_minmax,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0))
++#if LINUX_VERSION_IS_GEQ(3,15,0)
  		.extra1		= &init_net.ieee802154_lowpan.frags.low_thresh
 +#else
 +		.extra1		= &ieee802154_lowpan.frags.low_thresh
@@ -36,7 +36,7 @@ idea yet.
  	},
  	{
  		.procname	= "6lowpanfrag_low_thresh",
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0))
++#if LINUX_VERSION_IS_GEQ(3,15,0)
  		.data		= &init_net.ieee802154_lowpan.frags.low_thresh,
 +#else
 +		.data		= &ieee802154_lowpan.frags.low_thresh,
@@ -45,7 +45,7 @@ idea yet.
  		.mode		= 0644,
  		.proc_handler	= proc_dointvec_minmax,
  		.extra1		= &zero,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0))
++#if LINUX_VERSION_IS_GEQ(3,15,0)
  		.extra2		= &init_net.ieee802154_lowpan.frags.high_thresh
 +#else
 +		.extra2		= &ieee802154_lowpan.frags.high_thresh
@@ -53,7 +53,7 @@ idea yet.
  	},
  	{
  		.procname	= "6lowpanfrag_time",
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0))
++#if LINUX_VERSION_IS_GEQ(3,15,0)
  		.data		= &init_net.ieee802154_lowpan.frags.timeout,
 +#else
 +		.data		= &ieee802154_lowpan.frags.timeout,
diff --git a/patches/0007-lowpan-inet_frag_lru_move.patch b/patches/0007-lowpan-inet_frag_lru_move.patch
index d0b2c67c09e8..ef52414898a2 100644
--- a/patches/0007-lowpan-inet_frag_lru_move.patch
+++ b/patches/0007-lowpan-inet_frag_lru_move.patch
@@ -8,7 +8,7 @@ and then domain specific inet_frag_lru_move() define.
  	fq->d_size = arg->d_size;
  	fq->saddr = *arg->src;
  	fq->daddr = *arg->dst;
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
++#if LINUX_VERSION_IS_LESS(3,9,0)
 +	spin_lock_init(&fq->lru_lock);
 +#endif
  }
@@ -28,12 +28,12 @@ and then domain specific inet_frag_lru_move() define.
  	u16			d_size;
  	struct ieee802154_addr	saddr;
  	struct ieee802154_addr	daddr;
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
++#if LINUX_VERSION_IS_LESS(3,9,0)
 +	spinlock_t		lru_lock;
 +#endif
  };
  
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0)
++#if LINUX_VERSION_IS_LESS(3,9,0)
 +/*
 + * XXX: this is a *domain* specific inet_frag_lru_move backport,
 + * note the added lowpan_ prefix, this requires a respective patch
@@ -52,7 +52,7 @@ and then domain specific inet_frag_lru_move() define.
 +	list_move_tail(&q->lru_list, &q->net->lru_list);
 +	spin_unlock(&fq->lru_lock);
 +}
-+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(3,9,0) */
++#endif /* LINUX_VERSION_IS_LESS(3,9,0) */
 +
  static inline u32 ieee802154_addr_hash(const struct ieee802154_addr *a)
  {
diff --git a/patches/0008-net-user-ns.patch b/patches/0008-net-user-ns.patch
index f2a7e5dcad26..79605c05e567 100644
--- a/patches/0008-net-user-ns.patch
+++ b/patches/0008-net-user-ns.patch
@@ -7,11 +7,11 @@ via commit 038e7332b8.
  		table[1].extra2 = &ieee802154_lowpan->frags.high_thresh;
  		table[2].data = &ieee802154_lowpan->frags.timeout;
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0)
++#if LINUX_VERSION_IS_GEQ(3,8,0)
  		/* Don't export sysctls to unprivileged users */
  		if (net->user_ns != &init_user_ns)
  			table[0].procname = NULL;
-+#endif /* LINUX_VERSION_CODE <= KERNEL_VERSION(3,8,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,8,0) */
  	}
  
  	hdr = register_net_sysctl(net, "net/ieee802154/6lowpan", table);
diff --git a/patches/0012-driver-quirks/drivers_net_wireless_cw1200_sdio.patch b/patches/0012-driver-quirks/drivers_net_wireless_cw1200_sdio.patch
index b7447c591089..acac79c92849 100644
--- a/patches/0012-driver-quirks/drivers_net_wireless_cw1200_sdio.patch
+++ b/patches/0012-driver-quirks/drivers_net_wireless_cw1200_sdio.patch
@@ -4,7 +4,7 @@
  	else
  		size = sdio_align_size(self->func, size);
  
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3, 2, 0))
++#if LINUX_VERSION_IS_LESS(3, 2, 0)
 +	/* A quirk to handle this was committed in 3.2-rc */
 +	if (size == SDIO_BLOCK_SIZE)
 +		size += SDIO_BLOCK_SIZE;  /* HW bug; force use of block mode */
diff --git a/patches/0014-netlink_seq/net_wireless_nl80211.patch b/patches/0014-netlink_seq/net_wireless_nl80211.patch
index d51f9110eeb2..5bab6282f227 100644
--- a/patches/0014-netlink_seq/net_wireless_nl80211.patch
+++ b/patches/0014-netlink_seq/net_wireless_nl80211.patch
@@ -4,7 +4,7 @@
  	spin_lock_bh(&rdev->bss_lock);
  	cfg80211_bss_expire(rdev);
  
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,1,0))
++#if LINUX_VERSION_IS_GEQ(3,1,0)
  	cb->seq = rdev->bss_generation;
 +#endif
  
diff --git a/patches/0015-rename_pm_qos_request/drivers_net_wireless_ipw2x00_ipw2100.patch b/patches/0015-rename_pm_qos_request/drivers_net_wireless_ipw2x00_ipw2100.patch
index 922e1a0320dd..d3dc0a0d68b5 100644
--- a/patches/0015-rename_pm_qos_request/drivers_net_wireless_ipw2x00_ipw2100.patch
+++ b/patches/0015-rename_pm_qos_request/drivers_net_wireless_ipw2x00_ipw2100.patch
@@ -4,7 +4,7 @@
  #define DRV_DESCRIPTION	"Intel(R) PRO/Wireless 2100 Network Driver"
  #define DRV_COPYRIGHT	"Copyright(c) 2003-2006 Intel Corporation"
  
-+#if (LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0))
++#if LINUX_VERSION_IS_LESS(3,2,0)
 +static struct pm_qos_request_list ipw2100_pm_qos_req;
 +#else
  static struct pm_qos_request ipw2100_pm_qos_req;
diff --git a/patches/0016-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch b/patches/0016-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch
index 10f5943ceb65..6f3e4244f89d 100644
--- a/patches/0016-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch
+++ b/patches/0016-libertas-olpc-ec-wakeup/drivers_net_wireless_libertas_if_usb.patch
@@ -4,7 +4,7 @@
  		goto out;
  	}
  
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,1,0))
++#if LINUX_VERSION_IS_GEQ(3,1,0)
  #ifdef CONFIG_OLPC
  	if (machine_is_olpc()) {
  		if (priv->wol_criteria == EHS_REMOVE_WAKEUP)
diff --git a/patches/0017-get_ts_info/get_ts_info.cocci b/patches/0017-get_ts_info/get_ts_info.cocci
index 3e023a323aae..43f4339ffdc9 100644
--- a/patches/0017-get_ts_info/get_ts_info.cocci
+++ b/patches/0017-get_ts_info/get_ts_info.cocci
@@ -3,9 +3,9 @@ identifier s, func;
 @@
 
 struct ethtool_ops s = {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
++#if LINUX_VERSION_IS_GEQ(3,5,0)
 .get_ts_info = func,
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,5,0) */
 };
 
 // ----------------------------------------------------------------------
@@ -14,6 +14,6 @@ struct ethtool_ops s = {
 identifier r1.func;
 @@
 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
++#if LINUX_VERSION_IS_GEQ(3,5,0)
 func(...) { ... }
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,5,0) */
diff --git a/patches/0019-usb_driver_lpm.cocci b/patches/0019-usb_driver_lpm.cocci
index 60712dceabb0..793ca4e69ce5 100644
--- a/patches/0019-usb_driver_lpm.cocci
+++ b/patches/0019-usb_driver_lpm.cocci
@@ -2,7 +2,7 @@
 identifier backport_driver;
 @@
 struct usb_driver backport_driver = {
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
++#if LINUX_VERSION_IS_GEQ(3,5,0)
 	.disable_hub_initiated_lpm = 1,
 +#endif
 ...
diff --git a/patches/0020-tty-termios/net_bluetooth_hci_ldisc.patch b/patches/0020-tty-termios/net_bluetooth_hci_ldisc.patch
index d1c6b64f80eb..81371523aa29 100644
--- a/patches/0020-tty-termios/net_bluetooth_hci_ldisc.patch
+++ b/patches/0020-tty-termios/net_bluetooth_hci_ldisc.patch
@@ -12,7 +12,7 @@
  
  	if (enable) {
  		/* Disable hardware flow control */
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0))
++#if LINUX_VERSION_IS_GEQ(3,7,0)
  		ktermios = tty->termios;
 +#else
 +		ktermios = *tty->termios;
@@ -24,7 +24,7 @@
  		BT_DBG("Setting RTS: %s", status ? "failed" : "success");
  
  		/* Re-enable hardware flow control */
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0))
++#if LINUX_VERSION_IS_GEQ(3,7,0)
  		ktermios = tty->termios;
 +#else
 +		ktermios = *tty->termios;
@@ -36,7 +36,7 @@
  	struct ktermios ktermios;
  
  	/* Bring the UART into a known 8 bits no parity hw fc state */
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0))
++#if LINUX_VERSION_IS_GEQ(3,7,0)
  	ktermios = tty->termios;
 +#else
 +	ktermios = *tty->termios;
@@ -48,7 +48,7 @@
  	struct tty_struct *tty = hu->tty;
  	struct ktermios ktermios;
  
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0))
++#if LINUX_VERSION_IS_GEQ(3,7,0)
  	ktermios = tty->termios;
 +#else
 +	ktermios = *tty->termios;
diff --git a/patches/0020-tty-termios/net_bluetooth_rfcomm_tty.patch b/patches/0020-tty-termios/net_bluetooth_rfcomm_tty.patch
index 780d0b97ea83..71aa75ddbe76 100644
--- a/patches/0020-tty-termios/net_bluetooth_rfcomm_tty.patch
+++ b/patches/0020-tty-termios/net_bluetooth_rfcomm_tty.patch
@@ -4,7 +4,7 @@
  
  static void rfcomm_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
  {
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0))
++#if LINUX_VERSION_IS_GEQ(3,7,0)
  	struct ktermios *new = &tty->termios;
 +#else
 +	struct ktermios *new = tty->termios;
diff --git a/patches/0021-umode_t-api-change/ath10k.patch b/patches/0021-umode_t-api-change/ath10k.patch
index 0d02657a8ae9..b72c9297e885 100644
--- a/patches/0021-umode_t-api-change/ath10k.patch
+++ b/patches/0021-umode_t-api-change/ath10k.patch
@@ -4,7 +4,7 @@
  
  static struct dentry *create_buf_file_handler(const char *filename,
  					      struct dentry *parent,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0))
++#if LINUX_VERSION_IS_GEQ(3,3,0)
  					      umode_t mode,
 +#else
 +					      int mode,
diff --git a/patches/0021-umode_t-api-change/ath9k.patch b/patches/0021-umode_t-api-change/ath9k.patch
index 401bf196645e..a2ac14f346a3 100644
--- a/patches/0021-umode_t-api-change/ath9k.patch
+++ b/patches/0021-umode_t-api-change/ath9k.patch
@@ -4,7 +4,7 @@
  
  static struct dentry *create_buf_file_handler(const char *filename,
  					      struct dentry *parent,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0))
++#if LINUX_VERSION_IS_GEQ(3,3,0)
  					      umode_t mode,
 +#else
 +					      int mode,
diff --git a/patches/0021-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch b/patches/0021-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch
index 7f85a49bed84..a64c02906e3f 100644
--- a/patches/0021-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch
+++ b/patches/0021-umode_t-api-change/drivers_net_wireless_ath_ath9k_debug.patch
@@ -4,7 +4,7 @@
  
  static struct dentry *create_buf_file_handler(const char *filename,
  					      struct dentry *parent,
-+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0))
++#if LINUX_VERSION_IS_GEQ(3,3,0)
  					      umode_t mode,
 +#else
 +					      int mode,
diff --git a/patches/0022-define-tracing/ath6kl.patch b/patches/0022-define-tracing/ath6kl.patch
index bdf455aae6b3..d0bf89446297 100644
--- a/patches/0022-define-tracing/ath6kl.patch
+++ b/patches/0022-define-tracing/ath6kl.patch
@@ -4,7 +4,7 @@
   */
  
  #include <linux/module.h>
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)
++#if LINUX_VERSION_IS_LESS(3,1,0)
 +#include <linux/interrupt.h>
 +#endif
  
diff --git a/patches/0022-define-tracing/cfg80211.patch b/patches/0022-define-tracing/cfg80211.patch
index 95a0d6a81b6d..e2b57a8c74fd 100644
--- a/patches/0022-define-tracing/cfg80211.patch
+++ b/patches/0022-define-tracing/cfg80211.patch
@@ -2,7 +2,7 @@
 +++ b/net/wireless/trace.c
 @@ -1,4 +1,7 @@
  #include <linux/module.h>
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)
++#if LINUX_VERSION_IS_LESS(3,1,0)
 +#include <linux/interrupt.h>
 +#endif
  
diff --git a/patches/0022-define-tracing/mt7601u.patch b/patches/0022-define-tracing/mt7601u.patch
index ea7bc809658e..1682a7634178 100644
--- a/patches/0022-define-tracing/mt7601u.patch
+++ b/patches/0022-define-tracing/mt7601u.patch
@@ -4,7 +4,7 @@
   */
  
  #include <linux/module.h>
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0)
++#if LINUX_VERSION_IS_LESS(3,4,0)
 +#include <linux/interrupt.h>
 +#endif
  
diff --git a/patches/0022-define-tracing/wil6210.patch b/patches/0022-define-tracing/wil6210.patch
index 5f4b43b9d2a3..2e51beb17dc4 100644
--- a/patches/0022-define-tracing/wil6210.patch
+++ b/patches/0022-define-tracing/wil6210.patch
@@ -4,7 +4,7 @@
   */
  
  #include <linux/module.h>
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,1,0)
++#if LINUX_VERSION_IS_LESS(3,1,0)
 +#include <linux/interrupt.h>
 +#endif
  
diff --git a/patches/0024-led-blink-api/mac80211.patch b/patches/0024-led-blink-api/mac80211.patch
index 46b919b59a34..dcf151e0097d 100644
--- a/patches/0024-led-blink-api/mac80211.patch
+++ b/patches/0024-led-blink-api/mac80211.patch
@@ -19,7 +19,7 @@
  
  	if (!atomic_read(&local->rx_led_active))
  		return;
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
++#if LINUX_VERSION_IS_GEQ(3,6,0)
  	led_trigger_blink_oneshot(&local->rx_led, &led_delay, &led_delay, 0);
 +#else
 +	if (local->rx_led_counter++ % 2 == 0)
@@ -38,7 +38,7 @@
  
  	if (!atomic_read(&local->tx_led_active))
  		return;
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
++#if LINUX_VERSION_IS_GEQ(3,6,0)
  	led_trigger_blink_oneshot(&local->tx_led, &led_delay, &led_delay, 0);
 +#else
 +	if (local->tx_led_counter++ % 2 == 0)
diff --git a/patches/0025-usb-sg/usbnet.patch b/patches/0025-usb-sg/usbnet.patch
index e9c204d9fc07..1a1017c3992a 100644
--- a/patches/0025-usb-sg/usbnet.patch
+++ b/patches/0025-usb-sg/usbnet.patch
@@ -4,7 +4,7 @@
  
  /*-------------------------------------------------------------------------*/
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,35,0)
++#if LINUX_VERSION_IS_GEQ(3,35,0)
  static int build_dma_sg(const struct sk_buff *skb, struct urb *urb)
  {
  	unsigned num_sgs, total_len = 0;
@@ -25,7 +25,7 @@
  		if (!(info->flags & FLAG_SEND_ZLP)) {
  			if (!(info->flags & FLAG_MULTI_PACKET)) {
  				length++;
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,35,0)
++#if LINUX_VERSION_IS_GEQ(3,35,0)
  				if (skb_tailroom(skb) && !urb->num_sgs) {
  					skb->data[skb->len] = 0;
  					__skb_put(skb, 1);
@@ -45,7 +45,7 @@
  		if (skb)
  			dev_kfree_skb_any (skb);
  		if (urb) {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,35,0)
++#if LINUX_VERSION_IS_GEQ(3,35,0)
  			kfree(urb->sg);
 +#endif
  			usb_free_urb(urb);
@@ -55,7 +55,7 @@
  			rx_process (dev, skb);
  			continue;
  		case tx_done:
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,35,0)
++#if LINUX_VERSION_IS_GEQ(3,35,0)
  			kfree(entry->urb->sg);
 +#endif
  		case rx_cleanup:
@@ -65,7 +65,7 @@
  			retval = usb_submit_urb(res, GFP_ATOMIC);
  			if (retval < 0) {
  				dev_kfree_skb_any(skb);
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,35,0)
++#if LINUX_VERSION_IS_GEQ(3,35,0)
  				kfree(res->sg);
 +#endif
  				usb_free_urb(res);
diff --git a/patches/0026-ipv6_stub/cdc_mbim.patch b/patches/0026-ipv6_stub/cdc_mbim.patch
index bece5b083063..f75d64ca2c15 100644
--- a/patches/0026-ipv6_stub/cdc_mbim.patch
+++ b/patches/0026-ipv6_stub/cdc_mbim.patch
@@ -4,7 +4,7 @@
  	return NULL;
  }
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0)
++#if LINUX_VERSION_IS_GEQ(3,12,0)
  /* Some devices are known to send Neigbor Solicitation messages and
   * require Neigbor Advertisement replies.  The IPv6 core will not
   * respond since IFF_NOARP is set, so we must handle them ourselves.
@@ -12,7 +12,7 @@
  		msg->icmph.icmp6_code == 0 &&
  		msg->icmph.icmp6_type == NDISC_NEIGHBOUR_SOLICITATION);
  }
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,12,0) */
  
  
  static struct sk_buff *cdc_mbim_process_dgram(struct usbnet *dev, u8 *buf, size_t len, u16 tci)
@@ -20,10 +20,10 @@
  			proto = htons(ETH_P_IP);
  			break;
  		case 0x60:
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0)
++#if LINUX_VERSION_IS_GEQ(3,12,0)
  			if (is_neigh_solicit(buf, len))
  				do_neigh_solicit(dev, buf, tci);
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,12,0) */
  			proto = htons(ETH_P_IPV6);
  			break;
  		default:
diff --git a/patches/0028-select_queue/mac80211.patch b/patches/0028-select_queue/mac80211.patch
index 39a9d4aa6737..cc8b300e7213 100644
--- a/patches/0028-select_queue/mac80211.patch
+++ b/patches/0028-select_queue/mac80211.patch
@@ -4,13 +4,13 @@
  	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
  }
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0) || \
++#if LINUX_VERSION_IS_GEQ(3,14,0) || \
 +    (LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI > 30)
  static u16 ieee80211_netdev_select_queue(struct net_device *dev,
  					 struct sk_buff *skb,
  					 void *accel_priv,
  					 select_queue_fallback_t fallback)
-+#elif LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
++#elif LINUX_VERSION_IS_GEQ(3,13,0)
 +static u16 ieee80211_netdev_select_queue(struct net_device *dev,
 +					 struct sk_buff *skb,
 +					 void *accel_priv)
@@ -25,13 +25,13 @@
  	.ndo_get_stats64	= ieee80211_get_stats64,
  };
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0) || \
++#if LINUX_VERSION_IS_GEQ(3,14,0) || \
 +    (LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI > 30)
  static u16 ieee80211_monitor_select_queue(struct net_device *dev,
  					  struct sk_buff *skb,
  					  void *accel_priv,
  					  select_queue_fallback_t fallback)
-+#elif LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
++#elif LINUX_VERSION_IS_GEQ(3,13,0)
 +static u16 ieee80211_monitor_select_queue(struct net_device *dev,
 +					  struct sk_buff *skb,
 +					  void *accel_priv)
diff --git a/patches/0028-select_queue/mwifiex.patch b/patches/0028-select_queue/mwifiex.patch
index 61a091b5c606..17aeb91212e5 100644
--- a/patches/0028-select_queue/mwifiex.patch
+++ b/patches/0028-select_queue/mwifiex.patch
@@ -4,12 +4,12 @@
  	return &priv->stats;
  }
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,14,0) || \
++#if LINUX_VERSION_IS_GEQ(3,14,0) || \
 +    (LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI > 30)
  static u16
  mwifiex_netdev_select_wmm_queue(struct net_device *dev, struct sk_buff *skb,
  				void *accel_priv, select_queue_fallback_t fallback)
-+#elif LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
++#elif LINUX_VERSION_IS_GEQ(3,13,0)
 +static u16
 +mwifiex_netdev_select_wmm_queue(struct net_device *dev, struct sk_buff *skb,
 +				void *accel_priv)
diff --git a/patches/0029-struct_hid_ll_driver-extensions/net_bluetooth_hidp_core.patch b/patches/0029-struct_hid_ll_driver-extensions/net_bluetooth_hidp_core.patch
index 4fa4df6e50be..6cccf460b837 100644
--- a/patches/0029-struct_hid_ll_driver-extensions/net_bluetooth_hidp_core.patch
+++ b/patches/0029-struct_hid_ll_driver-extensions/net_bluetooth_hidp_core.patch
@@ -4,7 +4,7 @@
  	input_sync(dev);
  }
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
++#if LINUX_VERSION_IS_GEQ(3,15,0)
  static int hidp_get_raw_report(struct hid_device *hid,
  		unsigned char report_number,
  		unsigned char *data, size_t count,
@@ -20,7 +20,7 @@
  	.stop = hidp_stop,
  	.open  = hidp_open,
  	.close = hidp_close,
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
++#if LINUX_VERSION_IS_GEQ(3,15,0)
  	.raw_request = hidp_raw_request,
  	.output_report = hidp_output_report,
 +#endif
diff --git a/patches/0030-qdisc_tx_busylock/bluetooth.patch b/patches/0030-qdisc_tx_busylock/bluetooth.patch
index 0b88b613bd15..1025f03b72e4 100644
--- a/patches/0030-qdisc_tx_busylock/bluetooth.patch
+++ b/patches/0030-qdisc_tx_busylock/bluetooth.patch
@@ -4,7 +4,7 @@
  	return err < 0 ? NET_XMIT_DROP : err;
  }
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
++#if LINUX_VERSION_IS_GEQ(3,7,0)
  static struct lock_class_key bt_tx_busylock;
 +#endif
  static struct lock_class_key bt_netdev_xmit_lock_key;
@@ -14,7 +14,7 @@
  static int bt_dev_init(struct net_device *dev)
  {
  	netdev_for_each_tx_queue(dev, bt_set_lockdep_class_one, NULL);
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
++#if LINUX_VERSION_IS_GEQ(3,7,0)
  	dev->qdisc_tx_busylock = &bt_tx_busylock;
 +#endif
  
diff --git a/patches/0030-qdisc_tx_busylock/ieee802154.patch b/patches/0030-qdisc_tx_busylock/ieee802154.patch
index b905b050a241..3794a02539b4 100644
--- a/patches/0030-qdisc_tx_busylock/ieee802154.patch
+++ b/patches/0030-qdisc_tx_busylock/ieee802154.patch
@@ -4,7 +4,7 @@
  	.create	= lowpan_header_create,
  };
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
++#if LINUX_VERSION_IS_GEQ(3,7,0)
  static struct lock_class_key lowpan_tx_busylock;
 +#endif
  static struct lock_class_key lowpan_netdev_xmit_lock_key;
@@ -14,7 +14,7 @@
  static int lowpan_dev_init(struct net_device *dev)
  {
  	netdev_for_each_tx_queue(dev, lowpan_set_lockdep_class_one, NULL);
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
++#if LINUX_VERSION_IS_GEQ(3,7,0)
  	dev->qdisc_tx_busylock = &lowpan_tx_busylock;
 +#endif
  	return 0;
diff --git a/patches/0031-sk_data_ready.cocci b/patches/0031-sk_data_ready.cocci
index 2716eddd13d8..44a41c96962c 100644
--- a/patches/0031-sk_data_ready.cocci
+++ b/patches/0031-sk_data_ready.cocci
@@ -68,7 +68,7 @@ drv_data_ready(struct sock *sk)
 	...
 }
 
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,15,0)
++#if LINUX_VERSION_IS_LESS(3,15,0)
 +static void backport_drv_data_ready(struct sock *sk, int unused)
 +{
 +	drv_data_ready(sk);
@@ -81,7 +81,7 @@ identifier sk_data_ready_assigned.drv_data_ready;
 fresh identifier backport_drv_data_ready = "backport_" ## drv_data_ready;
 @@
 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
++#if LINUX_VERSION_IS_GEQ(3,15,0)
 	E->sk_data_ready = drv_data_ready;
 +#else
 +	E->sk_data_ready = backport_drv_data_ready;
@@ -98,7 +98,7 @@ struct sock *sk;
 expression E;
 @@
 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
++#if LINUX_VERSION_IS_GEQ(3,15,0)
 	E->sk_data_ready(E);
 +#else
 +	E->sk_data_ready(E, 0);
@@ -111,7 +111,7 @@ identifier sk_data_ready;
 @@
 
 	skb_queue_tail(&sk->sk_receive_queue, skb);
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
++#if LINUX_VERSION_IS_GEQ(3,15,0)
 	sk->sk_data_ready(sk);
 +#else
 +	sk->sk_data_ready(sk, skb->len);
diff --git a/patches/0032-sriov_configure/igb_sriov_configure.patch b/patches/0032-sriov_configure/igb_sriov_configure.patch
index 2167b7c26d58..77e5eac94099 100644
--- a/patches/0032-sriov_configure/igb_sriov_configure.patch
+++ b/patches/0032-sriov_configure/igb_sriov_configure.patch
@@ -4,7 +4,7 @@
  	return 0;
  }
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0)
++#if LINUX_VERSION_IS_GEQ(3,8,0)
  static int igb_pci_disable_sriov(struct pci_dev *dev)
  {
  	int err = igb_disable_sriov(dev);
@@ -12,7 +12,7 @@
  
  	return err;
  }
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,8,0) */
  
  static int igb_pci_enable_sriov(struct pci_dev *dev, int num_vfs)
  {
diff --git a/patches/0032-sriov_configure/sriov_configure.cocci b/patches/0032-sriov_configure/sriov_configure.cocci
index 52920b8488f2..9f9f179428a9 100644
--- a/patches/0032-sriov_configure/sriov_configure.cocci
+++ b/patches/0032-sriov_configure/sriov_configure.cocci
@@ -3,9 +3,9 @@ identifier s, func;
 @@
 
 struct pci_driver s = {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0)
++#if LINUX_VERSION_IS_GEQ(3,8,0)
 .sriov_configure = func,
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,8,0) */
 };
 
 // ----------------------------------------------------------------------
@@ -14,6 +14,6 @@ struct pci_driver s = {
 identifier r1.func;
 @@
 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0)
++#if LINUX_VERSION_IS_GEQ(3,8,0)
 func(...) { ... }
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,8,0) */
diff --git a/patches/0033-ndo_vlan_rx_vid/cdc_mbim.patch b/patches/0033-ndo_vlan_rx_vid/cdc_mbim.patch
index 362b544be0c5..2441af6e7391 100644
--- a/patches/0033-ndo_vlan_rx_vid/cdc_mbim.patch
+++ b/patches/0033-ndo_vlan_rx_vid/cdc_mbim.patch
@@ -4,13 +4,13 @@
  	return cdc_mbim_manage_power(dev, status);
  }
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
++#if LINUX_VERSION_IS_GEQ(3,10,0)
  static int cdc_mbim_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid)
-+#elif LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
++#elif LINUX_VERSION_IS_GEQ(3,3,0)
 +static int cdc_mbim_rx_add_vid(struct net_device *netdev, u16 vid)
 +#else
 +static void cdc_mbim_rx_add_vid(struct net_device *netdev, u16 vid)
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,10,0) */
  {
  	struct usbnet *dev = netdev_priv(netdev);
  	struct cdc_mbim_state *info = (void *)&dev->data;
@@ -18,21 +18,21 @@
  	/* creation of this VLAN is a request to tag IP session 0 */
  	if (vid == MBIM_IPS0_VID)
  		info->flags |= FLAG_IPS0_VLAN;
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
++#if LINUX_VERSION_IS_GEQ(3,3,0)
  	else
  		if (vid >= 512)	/* we don't map these to MBIM session */
  			return -EINVAL;
  	return 0;
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,3,0) */
  }
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
++#if LINUX_VERSION_IS_GEQ(3,10,0)
  static int cdc_mbim_rx_kill_vid(struct net_device *netdev, __be16 proto, u16 vid)
-+#elif LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
++#elif LINUX_VERSION_IS_GEQ(3,3,0)
 +static int cdc_mbim_rx_kill_vid(struct net_device *netdev, u16 vid)
 +#else
 +static void cdc_mbim_rx_kill_vid(struct net_device *netdev, u16 vid)
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,10,0) */
  {
  	struct usbnet *dev = netdev_priv(netdev);
  	struct cdc_mbim_state *info = (void *)&dev->data;
@@ -40,9 +40,9 @@
  	/* this is a request for an untagged IP session 0 */
  	if (vid == MBIM_IPS0_VID)
  		info->flags &= ~FLAG_IPS0_VLAN;
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
++#if LINUX_VERSION_IS_GEQ(3,3,0)
  	return 0;
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,3,0) */
  }
  
  static const struct net_device_ops cdc_mbim_netdev_ops = {
diff --git a/patches/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch b/patches/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
index 5d174c29c689..093af64717ca 100644
--- a/patches/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
+++ b/patches/0033-ndo_vlan_rx_vid/igb_ndo_vlan_rx_vid.patch
@@ -4,16 +4,16 @@
  static void igb_reset_task(struct work_struct *);
  static void igb_vlan_mode(struct net_device *netdev,
  			  netdev_features_t features);
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
++#if LINUX_VERSION_IS_GEQ(3,10,0)
  static int igb_vlan_rx_add_vid(struct net_device *, __be16, u16);
  static int igb_vlan_rx_kill_vid(struct net_device *, __be16, u16);
-+#elif LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
++#elif LINUX_VERSION_IS_GEQ(3,3,0)
 +static int igb_vlan_rx_add_vid(struct net_device *, u16);
 +static int igb_vlan_rx_kill_vid(struct net_device *, u16);
 +#else
 +static void igb_vlan_rx_add_vid(struct net_device *, u16);
 +static void igb_vlan_rx_kill_vid(struct net_device *, u16);
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,10,0) */
  static void igb_restore_vlan(struct igb_adapter *);
  static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
  static void igb_ping_all_vfs(struct igb_adapter *);
@@ -21,10 +21,10 @@
  	igb_set_vf_vlan_strip(adapter, adapter->vfs_allocated_count, enable);
  }
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
++#if LINUX_VERSION_IS_GEQ(3,10,0)
  static int igb_vlan_rx_add_vid(struct net_device *netdev,
  			       __be16 proto, u16 vid)
-+#elif LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
++#elif LINUX_VERSION_IS_GEQ(3,3,0)
 +static int igb_vlan_rx_add_vid(struct net_device *netdev, u16 vid)
 +#else
 +static void igb_vlan_rx_add_vid(struct net_device *netdev, u16 vid)
@@ -36,19 +36,19 @@
  
  	set_bit(vid, adapter->active_vlans);
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
++#if LINUX_VERSION_IS_GEQ(3,3,0)
  	return 0;
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,3,0) */
  }
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
++#if LINUX_VERSION_IS_GEQ(3,10,0)
  static int igb_vlan_rx_kill_vid(struct net_device *netdev,
  				__be16 proto, u16 vid)
-+#elif LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
++#elif LINUX_VERSION_IS_GEQ(3,3,0)
 +static int igb_vlan_rx_kill_vid(struct net_device *netdev, u16 vid)
 +#else
 +static void igb_vlan_rx_kill_vid(struct net_device *netdev, u16 vid)
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,10,0) */
  {
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	int pf_id = adapter->vfs_allocated_count;
@@ -56,9 +56,9 @@
  
  	clear_bit(vid, adapter->active_vlans);
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
++#if LINUX_VERSION_IS_GEQ(3,3,0)
  	return 0;
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,3,0) */
  }
  
  static void igb_restore_vlan(struct igb_adapter *adapter)
@@ -66,18 +66,18 @@
  	u16 vid = 1;
  
  	igb_vlan_mode(adapter->netdev, adapter->netdev->features);
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
++#if LINUX_VERSION_IS_GEQ(3,10,0)
  	igb_vlan_rx_add_vid(adapter->netdev, htons(ETH_P_8021Q), 0);
 +#else
 +	igb_vlan_rx_add_vid(adapter->netdev, 0);
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,10,0) */
  
  	for_each_set_bit_from(vid, adapter->active_vlans, VLAN_N_VID)
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0)
++#if LINUX_VERSION_IS_GEQ(3,10,0)
  		igb_vlan_rx_add_vid(adapter->netdev, htons(ETH_P_8021Q), vid);
 +#else
 +		igb_vlan_rx_add_vid(adapter->netdev, vid);
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,10,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,10,0) */
  }
  
  int igb_set_spd_dplx(struct igb_adapter *adapter, u32 spd, u8 dplx)
diff --git a/patches/0034-ndo_set_vf_spoofchk/set_vf_spoofchk.cocci b/patches/0034-ndo_set_vf_spoofchk/set_vf_spoofchk.cocci
index 7be32c0b0e33..de3e6e7d8d30 100644
--- a/patches/0034-ndo_set_vf_spoofchk/set_vf_spoofchk.cocci
+++ b/patches/0034-ndo_set_vf_spoofchk/set_vf_spoofchk.cocci
@@ -3,9 +3,9 @@ identifier s, func;
 @@
 
 struct net_device_ops s = {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
++#if LINUX_VERSION_IS_GEQ(3,2,0)
 .ndo_set_vf_spoofchk = func,
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,2,0) */
 };
 
 @r2@
@@ -22,9 +22,9 @@ struct net_device_ops s = {
 identifier r1.func;
 @@
 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
++#if LINUX_VERSION_IS_GEQ(3,2,0)
 func(...) { ... }
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,2,0) */
 
 @@
 identifier r2.func2, ivi;
@@ -34,8 +34,8 @@ expression assign;
 func2(...  ,struct ifla_vf_info *ivi)
 {
  <...
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
++#if LINUX_VERSION_IS_GEQ(3,2,0)
  ivi->spoofchk = assign;
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,2,0) */
  ...>
 }
diff --git a/patches/0035-skb_no_fcs/skb_no_fcs.cocci b/patches/0035-skb_no_fcs/skb_no_fcs.cocci
index 703c227e62c0..12eaf6d75032 100644
--- a/patches/0035-skb_no_fcs/skb_no_fcs.cocci
+++ b/patches/0035-skb_no_fcs/skb_no_fcs.cocci
@@ -2,6 +2,6 @@
 expression E1,E2;
 struct sk_buff *skb;
 @@
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,18,0)
++#if LINUX_VERSION_IS_GEQ(3,18,0)
  E1 ^= E2(..., skb->no_fcs, ...)
-+#endif /* if LINUX_VERSION_CODE >= KERNEL_VERSION(3,18,0) */
++#endif /* if LINUX_VERSION_IS_GEQ(3,18,0) */
diff --git a/patches/0036-ethtool_eee/ethtool_eee.cocci b/patches/0036-ethtool_eee/ethtool_eee.cocci
index 7c2d2fe059a0..48b0467eba39 100644
--- a/patches/0036-ethtool_eee/ethtool_eee.cocci
+++ b/patches/0036-ethtool_eee/ethtool_eee.cocci
@@ -3,9 +3,9 @@ identifier s, func;
 @@
 
 struct ethtool_ops s = {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
++#if LINUX_VERSION_IS_GEQ(3,6,0)
 .get_eee = func,
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,6,0) */
 };
 
 @r2@
@@ -13,9 +13,9 @@ identifier s, func;
 @@
 
 struct ethtool_ops s = {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
++#if LINUX_VERSION_IS_GEQ(3,6,0)
 .set_eee = func,
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,6,0) */
 };
 
 // ----------------------------------------------------------------------
@@ -24,14 +24,14 @@ struct ethtool_ops s = {
 identifier r1.func;
 @@
 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
++#if LINUX_VERSION_IS_GEQ(3,6,0)
 func(...) { ... }
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,6,0) */
 
 @@
 identifier r2.func;
 @@
 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
++#if LINUX_VERSION_IS_GEQ(3,6,0)
 func(...) { ... }
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,6,0) */
diff --git a/patches/0037-ethtool_get_module/get_module.cocci b/patches/0037-ethtool_get_module/get_module.cocci
index c04ccc4135ef..eead7904f6c0 100644
--- a/patches/0037-ethtool_get_module/get_module.cocci
+++ b/patches/0037-ethtool_get_module/get_module.cocci
@@ -3,9 +3,9 @@ identifier s, func;
 @@
 
 struct ethtool_ops s = {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
++#if LINUX_VERSION_IS_GEQ(3,5,0)
 .get_module_info = func,
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,5,0) */
 };
 
 @r2@
@@ -13,9 +13,9 @@ identifier s, func;
 @@
 
 struct ethtool_ops s = {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
++#if LINUX_VERSION_IS_GEQ(3,5,0)
 .get_module_eeprom = func,
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,5,0) */
 };
 
 // ----------------------------------------------------------------------
@@ -24,14 +24,14 @@ struct ethtool_ops s = {
 identifier r1.func;
 @@
 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
++#if LINUX_VERSION_IS_GEQ(3,5,0)
 func(...) { ... }
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,5,0) */
 
 @@
 identifier r2.func;
 @@
 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0)
++#if LINUX_VERSION_IS_GEQ(3,5,0)
 func(...) { ... }
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,5,0) */
diff --git a/patches/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch b/patches/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
index cef5ce3be782..736666304cb7 100644
--- a/patches/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
+++ b/patches/0038-ethtool_rxfh_indir/igb_rxfh_indir.patch
@@ -4,16 +4,16 @@
  	pm_runtime_put(&adapter->pdev->dev);
  }
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
++#if LINUX_VERSION_IS_GEQ(3,3,0)
  static u32 igb_get_rxfh_indir_size(struct net_device *netdev)
  {
  	return IGB_RETA_SIZE;
  }
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
++#if LINUX_VERSION_IS_GEQ(3,19,0)
  static int igb_get_rxfh(struct net_device *netdev, u32 *indir, u8 *key,
  			u8 *hfunc)
-+#elif LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0)
++#elif LINUX_VERSION_IS_GEQ(3,16,0)
 +static int igb_get_rxfh(struct net_device *netdev, u32 *indir, u8 *key)
 +#else
 +static int igb_get_rxfh(struct net_device *netdev, u32 *indir)
@@ -22,7 +22,7 @@
  	struct igb_adapter *adapter = netdev_priv(netdev);
  	int i;
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
++#if LINUX_VERSION_IS_GEQ(3,19,0)
  	if (hfunc)
  		*hfunc = ETH_RSS_HASH_TOP;
 +#endif
@@ -33,7 +33,7 @@
  
  	return 0;
  }
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,3,0) */
  
  void igb_write_rss_indir_tbl(struct igb_adapter *adapter)
  {
@@ -41,11 +41,11 @@
  	}
  }
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
++#if LINUX_VERSION_IS_GEQ(3,3,0)
++#if LINUX_VERSION_IS_GEQ(3,19,0)
  static int igb_set_rxfh(struct net_device *netdev, const u32 *indir,
  			const u8 *key, const u8 hfunc)
-+#elif LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0)
++#elif LINUX_VERSION_IS_GEQ(3,16,0)
 +static int igb_set_rxfh(struct net_device *netdev, const u32 *indir,
 +			const u8 *key)
 +#else
@@ -57,7 +57,7 @@
  	int i;
  	u32 num_queues;
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
++#if LINUX_VERSION_IS_GEQ(3,19,0)
  	/* We do not allow change in unsupported parameters */
  	if (key ||
  	    (hfunc != ETH_RSS_HASH_NO_CHANGE && hfunc != ETH_RSS_HASH_TOP))
@@ -70,7 +70,7 @@
  
  	return 0;
  }
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,3,0) */
  
  static unsigned int igb_max_channels(struct igb_adapter *adapter)
  {
@@ -78,15 +78,15 @@
  	.set_eee		= igb_set_eee,
  	.get_module_info	= igb_get_module_info,
  	.get_module_eeprom	= igb_get_module_eeprom,
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0)
++#if LINUX_VERSION_IS_GEQ(3,16,0)
  	.get_rxfh_indir_size	= igb_get_rxfh_indir_size,
  	.get_rxfh		= igb_get_rxfh,
  	.set_rxfh		= igb_set_rxfh,
-+#elif LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
++#elif LINUX_VERSION_IS_GEQ(3,3,0)
 +	.get_rxfh_indir_size	= igb_get_rxfh_indir_size,
 +	.get_rxfh_indir		= igb_get_rxfh,
 +	.set_rxfh_indir		= igb_set_rxfh,
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,3,0) */
  	.get_channels		= igb_get_channels,
  	.set_channels		= igb_set_channels,
  	.begin			= igb_ethtool_begin,
diff --git a/patches/0039-ethtool_rxnfc/rxnfc.cocci b/patches/0039-ethtool_rxnfc/rxnfc.cocci
index e546f4d5457a..72920439fb17 100644
--- a/patches/0039-ethtool_rxnfc/rxnfc.cocci
+++ b/patches/0039-ethtool_rxnfc/rxnfc.cocci
@@ -14,9 +14,9 @@ typedef u32;
 // ----------------------------------------------------------------------
 
 func(...
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
++#if LINUX_VERSION_IS_GEQ(3,2,0)
 ,u32 *rule_locs
 +#else
 +,void *rule_locs
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,2,0) */
  ) { ... }
diff --git a/patches/0040-ethtool_cmd_mdix/ethtool_cmd_mdix.cocci b/patches/0040-ethtool_cmd_mdix/ethtool_cmd_mdix.cocci
index b32973bfa30e..479821e5bad1 100644
--- a/patches/0040-ethtool_cmd_mdix/ethtool_cmd_mdix.cocci
+++ b/patches/0040-ethtool_cmd_mdix/ethtool_cmd_mdix.cocci
@@ -2,13 +2,13 @@
 expression E1;
 struct ethtool_cmd *ecmd;
 @@
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
++#if LINUX_VERSION_IS_GEQ(3,7,0)
  ecmd->eth_tp_mdix_ctrl = E1;
-+#endif /* if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0) */
++#endif /* if LINUX_VERSION_IS_GEQ(3,7,0) */
 
 @r2@
 struct ethtool_cmd *ecmd;
 @@
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
++#if LINUX_VERSION_IS_GEQ(3,7,0)
  if (ecmd->eth_tp_mdix_ctrl) {...}
-+#endif /* if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0) */
++#endif /* if LINUX_VERSION_IS_GEQ(3,7,0) */
diff --git a/patches/0042-pci_error_handlers/atl1e.patch b/patches/0042-pci_error_handlers/atl1e.patch
index 2e83131fda64..2bfc1d5eedc6 100644
--- a/patches/0042-pci_error_handlers/atl1e.patch
+++ b/patches/0042-pci_error_handlers/atl1e.patch
@@ -4,11 +4,11 @@
  	netif_device_attach(netdev);
  }
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
++#if LINUX_VERSION_IS_GEQ(3,7,0)
  static const struct pci_error_handlers atl1e_err_handler = {
 +#else
 +static struct pci_error_handlers atl1e_err_handler = {
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,7,0) */
  	.error_detected = atl1e_io_error_detected,
  	.slot_reset = atl1e_io_slot_reset,
  	.resume = atl1e_io_resume,
diff --git a/patches/0042-pci_error_handlers/igb_pci_error_handlers.cocci b/patches/0042-pci_error_handlers/igb_pci_error_handlers.cocci
index 19147e95a0a0..4c8ba748f942 100644
--- a/patches/0042-pci_error_handlers/igb_pci_error_handlers.cocci
+++ b/patches/0042-pci_error_handlers/igb_pci_error_handlers.cocci
@@ -3,7 +3,7 @@ identifier s;
 @@
 
 static
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0)
++#if LINUX_VERSION_IS_GEQ(3,7,0)
 const
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,7,0) */
 struct pci_error_handlers s = { ... };
diff --git a/patches/0043-ndo_set_vf_rate/igb_set_vf_rate.patch b/patches/0043-ndo_set_vf_rate/igb_set_vf_rate.patch
index 6dea4e1e27d8..5e086bff49da 100644
--- a/patches/0043-ndo_set_vf_rate/igb_set_vf_rate.patch
+++ b/patches/0043-ndo_set_vf_rate/igb_set_vf_rate.patch
@@ -4,7 +4,7 @@
  	if (hw->mac.type != e1000_82576)
  		return -EOPNOTSUPP;
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0)
++#if LINUX_VERSION_IS_GEQ(3,16,0)
  	if (min_tx_rate)
  		return -EINVAL;
  
@@ -22,7 +22,7 @@
 +	adapter->vf_rate_link_speed = actual_link_speed;
 +	adapter->vf_data[vf].tx_rate = (u16)tx_rate;
 +	igb_set_vf_rate_limit(hw, vf, tx_rate, actual_link_speed);
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,16,0) */
  	return 0;
  }
  
diff --git a/patches/0043-ndo_set_vf_rate/set_vf_rate.cocci b/patches/0043-ndo_set_vf_rate/set_vf_rate.cocci
index c8c3af0af39e..d322185be262 100644
--- a/patches/0043-ndo_set_vf_rate/set_vf_rate.cocci
+++ b/patches/0043-ndo_set_vf_rate/set_vf_rate.cocci
@@ -3,11 +3,11 @@ identifier s, func;
 @@
 
 struct net_device_ops s = {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0)
++#if LINUX_VERSION_IS_GEQ(3,16,0)
 .ndo_set_vf_rate = func,
 +#else
 +.ndo_set_vf_tx_rate = func,
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,16,0) */
 };
 
 @r2@
@@ -25,11 +25,11 @@ identifier r1.func, min_tx_rate, max_tx_rate;
 @@
 
 func(...
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0)
++#if LINUX_VERSION_IS_GEQ(3,16,0)
  ,int min_tx_rate, int max_tx_rate
 +#else
 +,int tx_rate
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,16,0) */
  ) { ... }
 
 @@
@@ -40,11 +40,11 @@ expression assign, assign2;
 func2(...  ,struct ifla_vf_info *ivi)
 {
  <...
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0)
++#if LINUX_VERSION_IS_GEQ(3,16,0)
  ivi->max_tx_rate = assign;
  ivi->min_tx_rate = assign2;
 +#else
 +ivi->tx_rate = assign;
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,16,0) */
  ...>
 }
diff --git a/patches/0044-no_user_ns_in_net/ieee802154.patch b/patches/0044-no_user_ns_in_net/ieee802154.patch
index 79d1c4a4c8a4..6c3cd21066d2 100644
--- a/patches/0044-no_user_ns_in_net/ieee802154.patch
+++ b/patches/0044-no_user_ns_in_net/ieee802154.patch
@@ -4,7 +4,7 @@
  		ro->want_ack = !!val;
  		break;
  	case WPAN_SECURITY:
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0)
++#if LINUX_VERSION_IS_GEQ(3,8,0)
  		if (!ns_capable(net->user_ns, CAP_NET_ADMIN) &&
  		    !ns_capable(net->user_ns, CAP_NET_RAW)) {
 +#else
@@ -18,7 +18,7 @@
  		}
  		break;
  	case WPAN_SECURITY_LEVEL:
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0)
++#if LINUX_VERSION_IS_GEQ(3,8,0)
  		if (!ns_capable(net->user_ns, CAP_NET_ADMIN) &&
  		    !ns_capable(net->user_ns, CAP_NET_RAW)) {
 +#else
diff --git a/patches/0047-write_iter/bluetooth.patch b/patches/0047-write_iter/bluetooth.patch
index aa888d70eb62..093b526cc3bc 100644
--- a/patches/0047-write_iter/bluetooth.patch
+++ b/patches/0047-write_iter/bluetooth.patch
@@ -4,7 +4,7 @@
  	return 0;
  }
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,18,0)
++#if LINUX_VERSION_IS_GEQ(3,18,0)
  static inline ssize_t vhci_get_user(struct vhci_data *data,
  				    struct iov_iter *from)
  {
@@ -30,7 +30,7 @@
  	if (!skb)
  		return -ENOMEM;
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,18,0)
++#if LINUX_VERSION_IS_GEQ(3,18,0)
  	if (copy_from_iter(skb_put(skb, len), len, from) != len) {
  		kfree_skb(skb);
  		return -EFAULT;
@@ -51,7 +51,7 @@
  	return ret;
  }
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,18,0)
++#if LINUX_VERSION_IS_GEQ(3,18,0)
  static ssize_t vhci_write(struct kiocb *iocb, struct iov_iter *from)
 +#else
 +static ssize_t vhci_write(struct kiocb *iocb, const struct iovec *iov,
@@ -61,7 +61,7 @@
  	struct file *file = iocb->ki_filp;
  	struct vhci_data *data = file->private_data;
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,18,0)
++#if LINUX_VERSION_IS_GEQ(3,18,0)
  	return vhci_get_user(data, from);
 +#else
 +	return vhci_get_user(data, iov, count);
@@ -73,7 +73,7 @@
  static const struct file_operations vhci_fops = {
  	.owner		= THIS_MODULE,
  	.read		= vhci_read,
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,18,0)
++#if LINUX_VERSION_IS_GEQ(3,18,0)
  	.write_iter	= vhci_write,
 +#else
 +	.aio_write	= vhci_write,
diff --git a/patches/0049-no-pfmemalloc/no-pfmemalloc.cocci b/patches/0049-no-pfmemalloc/no-pfmemalloc.cocci
index 5c6dd2422565..7a4945489a55 100644
--- a/patches/0049-no-pfmemalloc/no-pfmemalloc.cocci
+++ b/patches/0049-no-pfmemalloc/no-pfmemalloc.cocci
@@ -3,7 +3,7 @@ struct page *page;
 expression E1;
 @@
  return E1
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0)
++#if LINUX_VERSION_IS_GEQ(3,6,0)
  || page_is_pfmemalloc(page)
-+#endif /* if LINUX_VERSION_CODE >= KERNEL_VERSION(3,6,0) */
++#endif /* if LINUX_VERSION_IS_GEQ(3,6,0) */
  ;
diff --git a/patches/0050-iov_iter/bluetooth.patch b/patches/0050-iov_iter/bluetooth.patch
index ef5bd6a74689..87506ff1830a 100644
--- a/patches/0050-iov_iter/bluetooth.patch
+++ b/patches/0050-iov_iter/bluetooth.patch
@@ -4,7 +4,7 @@
  	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
  					       unsigned long hdr_len,
  					       unsigned long len, int nb);
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
++#if LINUX_VERSION_IS_LESS(3,19,0)
 +	int			(*memcpy_fromiovec) (struct l2cap_chan *chan,
 +						     unsigned char *kdata,
 +						     struct iovec *iov,
@@ -17,7 +17,7 @@
  	return 0;
  }
  
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
++#if LINUX_VERSION_IS_LESS(3,19,0)
 +static inline int l2cap_chan_no_memcpy_fromiovec(struct l2cap_chan *chan,
 +						 unsigned char *kdata,
 +						 struct iovec *iov,
@@ -53,7 +53,7 @@
  	 */
  	chan->data = skb;
  
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
++#if LINUX_VERSION_IS_LESS(3,19,0)
 +	memset(&msg, 0, sizeof(msg));
 +	msg.msg_iov = (struct iovec *) &iv;
 +	msg.msg_iovlen = 1;
@@ -61,7 +61,7 @@
  	iv.iov_base = skb->data;
  	iv.iov_len = skb->len;
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
++#if LINUX_VERSION_IS_GEQ(3,19,0)
  	memset(&msg, 0, sizeof(msg));
  	iov_iter_kvec(&msg.msg_iter, WRITE | ITER_KVEC, &iv, 1, skb->len);
 +#endif
@@ -72,7 +72,7 @@
  	.suspend		= chan_suspend_cb,
  	.get_sndtimeo		= chan_get_sndtimeo_cb,
  	.alloc_skb		= chan_alloc_skb_cb,
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
++#if LINUX_VERSION_IS_LESS(3,19,0)
 +	.memcpy_fromiovec	= l2cap_chan_no_memcpy_fromiovec,
 +#endif
  
@@ -84,7 +84,7 @@
  
  	memset(&msg, 0, sizeof(msg));
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
++#if LINUX_VERSION_IS_GEQ(3,19,0)
  	iov_iter_kvec(&msg.msg_iter, WRITE | ITER_KVEC, &iv, 1, total_len);
 +#else
 +	msg.msg_iov = (struct iovec *) &iv;
@@ -97,7 +97,7 @@
  	.resume = l2cap_chan_no_resume,
  	.set_shutdown = l2cap_chan_no_set_shutdown,
  	.get_sndtimeo = l2cap_chan_no_get_sndtimeo,
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
++#if LINUX_VERSION_IS_LESS(3,19,0)
 +	.memcpy_fromiovec = l2cap_chan_no_memcpy_fromiovec,
 +#endif
  };
@@ -109,7 +109,7 @@
  	struct sk_buff **frag;
  	int sent = 0;
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
++#if LINUX_VERSION_IS_GEQ(3,19,0)
  	if (copy_from_iter(skb_put(skb, count), count, &msg->msg_iter) != count)
 +#else
 +	if (chan->ops->memcpy_fromiovec(chan, skb_put(skb, count),
@@ -122,7 +122,7 @@
  
  		*frag = tmp;
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
++#if LINUX_VERSION_IS_GEQ(3,19,0)
  		if (copy_from_iter(skb_put(*frag, count), count,
  				   &msg->msg_iter) != count)
 +#else
@@ -138,7 +138,7 @@
  	return skb;
  }
  
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
++#if LINUX_VERSION_IS_LESS(3,19,0)
 +static int l2cap_sock_memcpy_fromiovec_cb(struct l2cap_chan *chan,
 +					  unsigned char *kdata,
 +					  struct iovec *iov, int len)
@@ -154,7 +154,7 @@
  	.set_shutdown		= l2cap_sock_set_shutdown_cb,
  	.get_sndtimeo		= l2cap_sock_get_sndtimeo_cb,
  	.alloc_skb		= l2cap_sock_alloc_skb_cb,
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
++#if LINUX_VERSION_IS_LESS(3,19,0)
 +	.memcpy_fromiovec	= l2cap_sock_memcpy_fromiovec_cb,
 +#endif
  };
@@ -166,7 +166,7 @@
  
  	memset(&msg, 0, sizeof(msg));
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
++#if LINUX_VERSION_IS_GEQ(3,19,0)
  	iov_iter_kvec(&msg.msg_iter, WRITE | ITER_KVEC, iv, 2, 1 + len);
 +#else
 +	msg.msg_iov = (struct iovec *) &iv;
@@ -179,7 +179,7 @@
  	.suspend		= l2cap_chan_no_suspend,
  	.set_shutdown		= l2cap_chan_no_set_shutdown,
  	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
++#if LINUX_VERSION_IS_LESS(3,19,0)
 +	.memcpy_fromiovec	= l2cap_chan_no_memcpy_fromiovec,
 +#endif
  };
@@ -189,7 +189,7 @@
  	.resume			= l2cap_chan_no_resume,
  	.set_shutdown		= l2cap_chan_no_set_shutdown,
  	.get_sndtimeo		= l2cap_chan_no_get_sndtimeo,
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
++#if LINUX_VERSION_IS_LESS(3,19,0)
 +	.memcpy_fromiovec	= l2cap_chan_no_memcpy_fromiovec,
 +#endif
  };
diff --git a/patches/0051-no-wakeup_path/ssb.patch b/patches/0051-no-wakeup_path/ssb.patch
index 23bab03bd365..dcebbcdf2a82 100644
--- a/patches/0051-no-wakeup_path/ssb.patch
+++ b/patches/0051-no-wakeup_path/ssb.patch
@@ -4,9 +4,9 @@
  
  	/* if there is a wakeup enabled child device on ssb bus,
  	   enable pci wakeup posibility. */
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0)
++#if LINUX_VERSION_IS_GEQ(3,2,0)
  	device_set_wakeup_enable(d, d->power.wakeup_path);
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,2,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,2,0) */
  
  	pci_prepare_to_sleep(dev);
  
diff --git a/patches/0052-deactivate-ptp-pin/igb.patch b/patches/0052-deactivate-ptp-pin/igb.patch
index 4e09f6f504d7..a82dd7548fb8 100644
--- a/patches/0052-deactivate-ptp-pin/igb.patch
+++ b/patches/0052-deactivate-ptp-pin/igb.patch
@@ -4,7 +4,7 @@
  	u32 tx_hwtstamp_timeouts;
  	u32 rx_hwtstamp_cleared;
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
++#if LINUX_VERSION_IS_GEQ(3,15,0)
  	struct ptp_pin_desc sdp_config[IGB_N_SDP];
 +#endif
  	struct {
@@ -16,7 +16,7 @@
  	return val;
  }
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
++#if LINUX_VERSION_IS_GEQ(3,15,0)
  /* SYSTIM read access for I210/I211 */
  static void igb_ptp_read_i210(struct igb_adapter *adapter,
  			      struct timespec64 *ts)
@@ -32,7 +32,7 @@
  	return 0;
  }
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
++#if LINUX_VERSION_IS_GEQ(3,15,0)
  static int igb_ptp_adjtime_i210(struct ptp_clock_info *ptp, s64 delta)
  {
  	struct igb_adapter *igb = container_of(ptp, struct igb_adapter,
@@ -48,7 +48,7 @@
  	return 0;
  }
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
++#if LINUX_VERSION_IS_GEQ(3,15,0)
  static int igb_ptp_gettime_i210(struct ptp_clock_info *ptp,
  				struct timespec64 *ts)
  {
@@ -64,7 +64,7 @@
  	return 0;
  }
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
++#if LINUX_VERSION_IS_GEQ(3,15,0)
  static int igb_ptp_settime_i210(struct ptp_clock_info *ptp,
  				const struct timespec64 *ts)
  {
@@ -80,7 +80,7 @@
  	return -EOPNOTSUPP;
  }
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
++#if LINUX_VERSION_IS_GEQ(3,15,0)
  static int igb_ptp_verify_pin(struct ptp_clock_info *ptp, unsigned int pin,
  			      enum ptp_pin_function func, unsigned int chan)
  {
@@ -96,7 +96,7 @@
  {
  	struct e1000_hw *hw = &adapter->hw;
  	struct net_device *netdev = adapter->netdev;
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
++#if LINUX_VERSION_IS_GEQ(3,15,0)
  	int i;
 +#endif
  
@@ -106,7 +106,7 @@
  		/* Enable the timer functions by clearing bit 31. */
  		wr32(E1000_TSAUXC, 0x0);
  		break;
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
++#if LINUX_VERSION_IS_GEQ(3,15,0)
  	case e1000_i210:
  	case e1000_i211:
  		for (i = 0; i < IGB_N_SDP; i++) {
@@ -122,7 +122,7 @@
  	INIT_WORK(&adapter->ptp_tx_work, igb_ptp_tx_work);
  
  	/* Initialize the clock and overflow work for devices that need it. */
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,15,0)
++#if LINUX_VERSION_IS_GEQ(3,15,0)
  	if ((hw->mac.type == e1000_i210) || (hw->mac.type == e1000_i211)) {
  		struct timespec64 ts = ktime_to_timespec64(ktime_get_real());
  
diff --git a/patches/0053-remove_wait_on_bit_timeout/btusb.patch b/patches/0053-remove_wait_on_bit_timeout/btusb.patch
index 3c4e87b1a96b..52ed8b12b828 100644
--- a/patches/0053-remove_wait_on_bit_timeout/btusb.patch
+++ b/patches/0053-remove_wait_on_bit_timeout/btusb.patch
@@ -4,7 +4,7 @@
  		return;
  
  	if (test_and_clear_bit(BTUSB_BOOTING, &data->flags)) {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
++#if LINUX_VERSION_IS_GEQ(3,17,0)
  		smp_mb__after_atomic();
  		wake_up_bit(&data->flags, BTUSB_BOOTING);
 +#else
@@ -17,7 +17,7 @@
  
  	if (test_and_clear_bit(BTUSB_DOWNLOADING, &data->flags) &&
  	    test_bit(BTUSB_FIRMWARE_LOADED, &data->flags)) {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
++#if LINUX_VERSION_IS_GEQ(3,17,0)
  		smp_mb__after_atomic();
  		wake_up_bit(&data->flags, BTUSB_DOWNLOADING);
 +#else
@@ -30,7 +30,7 @@
  	 * and thus just timeout if that happens and fail the setup
  	 * of this device.
  	 */
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
++#if LINUX_VERSION_IS_GEQ(3,17,0)
  	err = wait_on_bit_timeout(&data->flags, BTUSB_DOWNLOADING,
  				  TASK_INTERRUPTIBLE,
  				  msecs_to_jiffies(5000));
@@ -70,7 +70,7 @@
  	 */
  	BT_INFO("%s: Waiting for device to boot", hdev->name);
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
++#if LINUX_VERSION_IS_GEQ(3,17,0)
  	err = wait_on_bit_timeout(&data->flags, BTUSB_BOOTING,
  				  TASK_INTERRUPTIBLE,
  				  msecs_to_jiffies(1000));
diff --git a/patches/0053-remove_wait_on_bit_timeout/hci_intel.patch b/patches/0053-remove_wait_on_bit_timeout/hci_intel.patch
index f53cd0471af2..c32df12ce94b 100644
--- a/patches/0053-remove_wait_on_bit_timeout/hci_intel.patch
+++ b/patches/0053-remove_wait_on_bit_timeout/hci_intel.patch
@@ -7,7 +7,7 @@
 -	int err;
 +	int err = 0;
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
++#if LINUX_VERSION_IS_GEQ(3,17,0)
  	err = wait_on_bit_timeout(&intel->flags, STATE_BOOTING,
  				  TASK_INTERRUPTIBLE,
  				  msecs_to_jiffies(1000));
@@ -52,7 +52,7 @@
 -	int err;
 +	int err = 0;
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
++#if LINUX_VERSION_IS_GEQ(3,17,0)
  	err = wait_on_bit_timeout(&intel->flags, STATE_LPM_TRANSACTION,
  				  TASK_INTERRUPTIBLE,
  				  msecs_to_jiffies(1000));
@@ -90,7 +90,7 @@
  	 * and thus just timeout if that happens and fail the setup
  	 * of this device.
  	 */
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
++#if LINUX_VERSION_IS_GEQ(3,17,0)
  	err = wait_on_bit_timeout(&intel->flags, STATE_DOWNLOADING,
  				  TASK_INTERRUPTIBLE,
  				  msecs_to_jiffies(5000));
@@ -132,7 +132,7 @@
  
  		if (test_and_clear_bit(STATE_DOWNLOADING, &intel->flags) &&
  		    test_bit(STATE_FIRMWARE_LOADED, &intel->flags)) {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
++#if LINUX_VERSION_IS_GEQ(3,17,0)
  			smp_mb__after_atomic();
  			wake_up_bit(&intel->flags, STATE_DOWNLOADING);
 +#else
@@ -145,7 +145,7 @@
  	} else if (skb->len == 9 && hdr->evt == 0xff && hdr->plen == 0x07 &&
  		   skb->data[2] == 0x02) {
  		if (test_and_clear_bit(STATE_BOOTING, &intel->flags)) {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
++#if LINUX_VERSION_IS_GEQ(3,17,0)
  			smp_mb__after_atomic();
  			wake_up_bit(&intel->flags, STATE_BOOTING);
 +#else
@@ -158,7 +158,7 @@
  	case LPM_OP_SUSPEND_ACK:
  		set_bit(STATE_SUSPENDED, &intel->flags);
  		if (test_and_clear_bit(STATE_LPM_TRANSACTION, &intel->flags)) {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
++#if LINUX_VERSION_IS_GEQ(3,17,0)
  			smp_mb__after_atomic();
  			wake_up_bit(&intel->flags, STATE_LPM_TRANSACTION);
 +#else
@@ -169,7 +169,7 @@
  	case LPM_OP_RESUME_ACK:
  		clear_bit(STATE_SUSPENDED, &intel->flags);
  		if (test_and_clear_bit(STATE_LPM_TRANSACTION, &intel->flags)) {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
++#if LINUX_VERSION_IS_GEQ(3,17,0)
  			smp_mb__after_atomic();
  			wake_up_bit(&intel->flags, STATE_LPM_TRANSACTION);
 +#else
diff --git a/patches/0054-struct-proto_ops-sig.cocci b/patches/0054-struct-proto_ops-sig.cocci
index 64df8ab5656b..1d190dcd7a34 100644
--- a/patches/0054-struct-proto_ops-sig.cocci
+++ b/patches/0054-struct-proto_ops-sig.cocci
@@ -42,12 +42,12 @@ send_func(...)
 	...
 }
 
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
++#if LINUX_VERSION_IS_LESS(4,1,0)
 +static int backport_send(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len)
 +{
 +	return send_func(sock, msg, len);
 +}
-+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
++#endif /* LINUX_VERSION_IS_LESS(4,1,0) */
 
 @ mod_recv depends on proto_ops @
 identifier proto_ops.recv_func;
@@ -59,24 +59,24 @@ recv_func(...)
 	...
 }
 
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
++#if LINUX_VERSION_IS_LESS(4,1,0)
 +static int backport_recv(struct kiocb *iocb, struct socket *sock,
 +			  struct msghdr *msg, size_t len, int flags)
 +{
 +	return recv_func(sock, msg, len, flags);
 +}
-+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
++#endif /* LINUX_VERSION_IS_LESS(4,1,0) */
 
 @ mod_proto_ops_tx depends on proto_ops && mod_send @
 identifier s, proto_ops.send_func, mod_send.backport_send;
 @@
 
  struct proto_ops s = {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
++#if LINUX_VERSION_IS_GEQ(4,1,0)
  	.sendmsg = send_func,
 +#else
 +	.sendmsg = backport_send,
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
++#endif /* LINUX_VERSION_IS_GEQ(4,1,0) */
 };
 
 @ mod_proto_ops_rx depends on proto_ops && mod_recv @
@@ -84,11 +84,11 @@ identifier s, proto_ops.recv_func, mod_recv.backport_recv;
 @@
 
  struct proto_ops s = {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
++#if LINUX_VERSION_IS_GEQ(4,1,0)
  	.recvmsg = recv_func,
 +#else
 +	.recvmsg = backport_recv,
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
++#endif /* LINUX_VERSION_IS_GEQ(4,1,0) */
 };
 
 @ mod_sock_send_callers depends on proto_ops@
@@ -99,11 +99,11 @@ identifier sock, msg, len, sk;
 send_func(struct socket *sock, struct msghdr *msg, size_t len)
 {
 	...
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
++#if LINUX_VERSION_IS_GEQ(4,1,0)
 	return sk->sk_prot->sendmsg(sk, msg, len);
 +#else
 +	return sk->sk_prot->sendmsg(NULL, sk, msg, len);
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
++#endif /* LINUX_VERSION_IS_GEQ(4,1,0) */
 }
 
 @ proto @
@@ -125,13 +125,13 @@ send_func(...)
 	...
 }
 
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
++#if LINUX_VERSION_IS_LESS(4,1,0)
 +static int backport_send(struct kiocb *iocb, struct sock *sk,
 +			  struct msghdr *msg, size_t len)
 +{
 +	return send_func(sk, msg, len);
 +}
-+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
++#endif /* LINUX_VERSION_IS_LESS(4,1,0) */
 
 @ proto_mod_recv depends on proto @
 identifier proto.recv_func;
@@ -143,25 +143,25 @@ recv_func(...)
 	...
 }
 
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0)
++#if LINUX_VERSION_IS_LESS(4,1,0)
 +static int backport_recv(struct kiocb *iocb, struct sock *sk,
 +			  struct msghdr *msg, size_t len,
 +			  int noblock, int flags, int *addr_len)
 +{
 +	return recv_func(sk, msg, len, noblock, flags, addr_len);
 +}
-+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(4,1,0) */
++#endif /* LINUX_VERSION_IS_LESS(4,1,0) */
 
 @ mod_proto_tx depends on proto && proto_mod_send @
 identifier s, proto.send_func, proto_mod_send.backport_send;
 @@
 
  struct proto s = {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
++#if LINUX_VERSION_IS_GEQ(4,1,0)
  	.sendmsg = send_func,
 +#else
 +	.sendmsg = backport_send,
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
++#endif /* LINUX_VERSION_IS_GEQ(4,1,0) */
 };
 
 @ mod_proto_rx depends on proto && proto_mod_recv @
@@ -169,9 +169,9 @@ identifier s, proto.recv_func, proto_mod_recv.backport_recv;
 @@
 
  struct proto s = {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
++#if LINUX_VERSION_IS_GEQ(4,1,0)
  	.recvmsg = recv_func,
 +#else
 +	.recvmsg = backport_recv,
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
++#endif /* LINUX_VERSION_IS_GEQ(4,1,0) */
 };
diff --git a/patches/0055-name_assign_type/brcmfmac.patch b/patches/0055-name_assign_type/brcmfmac.patch
index 9915786668db..9e2d76347554 100644
--- a/patches/0055-name_assign_type/brcmfmac.patch
+++ b/patches/0055-name_assign_type/brcmfmac.patch
@@ -4,7 +4,7 @@
  	}
  
  	strncpy(ifp->ndev->name, name, sizeof(ifp->ndev->name) - 1);
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
++#if LINUX_VERSION_IS_GEQ(3,17,0)
  	ifp->ndev->name_assign_type = name_assign_type;
 +#endif /* >= 3.17.0 */
  	err = brcmf_net_attach(ifp, true);
diff --git a/patches/0056-ndo_features_check/features_check.cocci b/patches/0056-ndo_features_check/features_check.cocci
index 1fee8d189c00..ca15d3a0227c 100644
--- a/patches/0056-ndo_features_check/features_check.cocci
+++ b/patches/0056-ndo_features_check/features_check.cocci
@@ -3,9 +3,9 @@ identifier s, func;
 @@
 
 struct net_device_ops s = {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
++#if LINUX_VERSION_IS_GEQ(3,19,0)
 .ndo_features_check = func,
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,19,0) */
 };
 
 // ----------------------------------------------------------------------
@@ -14,6 +14,6 @@ struct net_device_ops s = {
 identifier r1.func;
 @@
 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
++#if LINUX_VERSION_IS_GEQ(3,19,0)
 func(...) { ... }
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,19,0) */
diff --git a/patches/0058-ptp_getsettime64/ptp_getsettime64.cocci b/patches/0058-ptp_getsettime64/ptp_getsettime64.cocci
index 3f85c2a404e3..ff17ebdee97a 100644
--- a/patches/0058-ptp_getsettime64/ptp_getsettime64.cocci
+++ b/patches/0058-ptp_getsettime64/ptp_getsettime64.cocci
@@ -3,31 +3,31 @@
 @r1@
 expression E1, E2;
 @@
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
++#if LINUX_VERSION_IS_GEQ(4,1,0)
  E1.gettime64 = E2;
 +#else
 +E1.gettime = E2;
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
++#endif /* LINUX_VERSION_IS_GEQ(4,1,0) */
 
 // ----------------------------------------------------------------------------
 // handle calls to gettime64 as calls to gettime
 @r2@
 expression E1, E2, E3;
 @@
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
++#if LINUX_VERSION_IS_GEQ(4,1,0)
  E1.gettime64(E2, E3);
 +#else
 +E1.gettime(E2, E3);
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
++#endif /* LINUX_VERSION_IS_GEQ(4,1,0) */
 
 // ----------------------------------------------------------------------------
 // handle settime64 to settime function assignments
 @r3@
 expression E1, E2;
 @@
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0)
++#if LINUX_VERSION_IS_GEQ(4,1,0)
  E1.settime64 = E2;
 +#else
 +E1.settime = E2;
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(4,1,0) */
++#endif /* LINUX_VERSION_IS_GEQ(4,1,0) */
 
diff --git a/patches/0059-skb_xmit_more/skb_no_xmit_more.cocci b/patches/0059-skb_xmit_more/skb_no_xmit_more.cocci
index ab207bdaaa5b..ab20c833af40 100644
--- a/patches/0059-skb_xmit_more/skb_no_xmit_more.cocci
+++ b/patches/0059-skb_xmit_more/skb_no_xmit_more.cocci
@@ -3,7 +3,7 @@ struct sk_buff *skb;
 expression E1;
 @@
  if (E1
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,18,0)
++#if LINUX_VERSION_IS_GEQ(3,18,0)
  || !skb->xmit_more
-+#endif /* if LINUX_VERSION_CODE >= KERNEL_VERSION(3,18,0) */
++#endif /* if LINUX_VERSION_IS_GEQ(3,18,0) */
  ) {...}
diff --git a/patches/0059-uuid-in-mei/nfc.patch b/patches/0059-uuid-in-mei/nfc.patch
index 903cac3086fb..9953c8199648 100644
--- a/patches/0059-uuid-in-mei/nfc.patch
+++ b/patches/0059-uuid-in-mei/nfc.patch
@@ -4,9 +4,9 @@
  }
  
  static struct mei_cl_device_id microread_mei_tbl[] = {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,4,0)
++#if LINUX_VERSION_IS_GEQ(4,4,0)
  	{ MICROREAD_DRIVER_NAME, MEI_NFC_UUID, MEI_CL_VERSION_ANY},
-+#elif LINUX_VERSION_CODE >= KERNEL_VERSION(4,2,0)
++#elif LINUX_VERSION_IS_GEQ(4,2,0)
 +	{ MICROREAD_DRIVER_NAME, MEI_NFC_UUID},
 +#else
 +	{ MICROREAD_DRIVER_NAME},
@@ -20,9 +20,9 @@
  }
  
  static struct mei_cl_device_id pn544_mei_tbl[] = {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,4,0)
++#if LINUX_VERSION_IS_GEQ(4,4,0)
  	{ PN544_DRIVER_NAME, MEI_NFC_UUID, MEI_CL_VERSION_ANY},
-+#elif LINUX_VERSION_CODE >= KERNEL_VERSION(4,2,0)
++#elif LINUX_VERSION_IS_GEQ(4,2,0)
 +	{ PN544_DRIVER_NAME, MEI_NFC_UUID},
 +#else
 +	{ PN544_DRIVER_NAME},
diff --git a/patches/0060-trace_field_struct/mt7601u.patch b/patches/0060-trace_field_struct/mt7601u.patch
index 4e29b2c617fb..8b4af1f330f9 100644
--- a/patches/0060-trace_field_struct/mt7601u.patch
+++ b/patches/0060-trace_field_struct/mt7601u.patch
@@ -6,7 +6,7 @@ index 2898973..7fa1b96 100644
  		  DEV_PR_ARG, __entry->phy_mode, __entry->freq_off)
  );
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0)
++#if LINUX_VERSION_IS_GEQ(3,16,0)
  TRACE_EVENT(mt_rx,
  	TP_PROTO(struct mt7601u_dev *dev, struct mt7601u_rxwi *rxwi, u32 f),
  	TP_ARGS(dev, rxwi, f),
@@ -27,7 +27,7 @@ index 2898973..7fa1b96 100644
 +{
 +}
 +#endif /* __BACKPORT_MT7601U_TRACE_H_EXTRA */
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,16,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,16,0) */
  
  TRACE_EVENT(mt_tx_dma_done,
  	TP_PROTO(struct mt7601u_dev *dev, struct sk_buff *skb),
diff --git a/patches/0061-termios_rwsem/nfc.patch b/patches/0061-termios_rwsem/nfc.patch
index 73714151a2f8..c8ad8b464e74 100644
--- a/patches/0061-termios_rwsem/nfc.patch
+++ b/patches/0061-termios_rwsem/nfc.patch
@@ -4,17 +4,17 @@
  	if (!nu->tty)
  		return;
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0)
++#if LINUX_VERSION_IS_GEQ(3,12,0)
  	down_read(&nu->tty->termios_rwsem);
 +#else
 +	mutex_lock(&nu->tty->termios_mutex);
-+#endif /* if LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0) */
++#endif /* if LINUX_VERSION_IS_GEQ(3,12,0) */
  	new_termios = nu->tty->termios;
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0)
++#if LINUX_VERSION_IS_GEQ(3,12,0)
  	up_read(&nu->tty->termios_rwsem);
 +#else
 +	mutex_unlock(&nu->tty->termios_mutex);
-+#endif /* if LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0) */
++#endif /* if LINUX_VERSION_IS_GEQ(3,12,0) */
  	tty_termios_encode_baud_rate(&new_termios, baudrate, baudrate);
  
  	if (flow_ctrl)
diff --git a/patches/0062-acpi-gpio-remove/hci_bcm.patch b/patches/0062-acpi-gpio-remove/hci_bcm.patch
index db98d4be3dfd..77e343ee4dee 100644
--- a/patches/0062-acpi-gpio-remove/hci_bcm.patch
+++ b/patches/0062-acpi-gpio-remove/hci_bcm.patch
@@ -4,7 +4,7 @@
  #include <linux/acpi.h>
  #include <linux/platform_device.h>
  #include <linux/clk.h>
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
++#if LINUX_VERSION_IS_GEQ(3,13,0)
  #include <linux/gpio/consumer.h>
 +#endif
  #include <linux/tty.h>
@@ -14,7 +14,7 @@
  	if (powered && !IS_ERR(dev->clk) && !dev->clk_enabled)
  		clk_enable(dev->clk);
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
++#if LINUX_VERSION_IS_GEQ(3,13,0)
  	gpiod_set_value(dev->shutdown, powered);
  	gpiod_set_value(dev->device_wakeup, powered);
 +#endif
@@ -25,7 +25,7 @@
  
  	/* Suspend the device */
  	if (bdev->device_wakeup) {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
++#if LINUX_VERSION_IS_GEQ(3,13,0)
  		gpiod_set_value(bdev->device_wakeup, false);
 +#endif
  		bt_dev_dbg(bdev, "suspend, delaying 15 ms");
@@ -35,7 +35,7 @@
  	bt_dev_dbg(bdev, "");
  
  	if (bdev->device_wakeup) {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
++#if LINUX_VERSION_IS_GEQ(3,13,0)
  		gpiod_set_value(bdev->device_wakeup, true);
 +#endif
  		bt_dev_dbg(bdev, "resume, delaying 15 ms");
@@ -45,7 +45,7 @@
  }
  #endif
  
-+#if defined(CONFIG_ACPI) && LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
++#if defined(CONFIG_ACPI) && LINUX_VERSION_IS_GEQ(3,19,0)
  static const struct acpi_gpio_params device_wakeup_gpios = { 0, 0, false };
  static const struct acpi_gpio_params shutdown_gpios = { 1, 0, false };
  static const struct acpi_gpio_params host_wakeup_gpios = { 2, 0, false };
@@ -62,7 +62,7 @@
  };
  
 -#ifdef CONFIG_ACPI
-+#if defined(CONFIG_ACPI) && LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
++#if defined(CONFIG_ACPI) && LINUX_VERSION_IS_GEQ(3,19,0)
  static const struct acpi_device_id bcm_acpi_match[] = {
  	{ "BCM2E1A", 0 },
  	{ "BCM2E39", 0 },
@@ -70,7 +70,7 @@
  	.remove = bcm_remove,
  	.driver = {
  		.name = "hci_bcm",
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
++#if LINUX_VERSION_IS_GEQ(3,19,0)
  		.acpi_match_table = ACPI_PTR(bcm_acpi_match),
 +#endif
  		.pm = &bcm_pm_ops,
diff --git a/patches/0062-acpi-gpio-remove/hci_intel.patch b/patches/0062-acpi-gpio-remove/hci_intel.patch
index f80b6388a765..9237ce97576f 100644
--- a/patches/0062-acpi-gpio-remove/hci_intel.patch
+++ b/patches/0062-acpi-gpio-remove/hci_intel.patch
@@ -4,7 +4,7 @@
  #include <linux/wait.h>
  #include <linux/tty.h>
  #include <linux/platform_device.h>
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
++#if LINUX_VERSION_IS_GEQ(3,13,0)
  #include <linux/gpio/consumer.h>
 +#endif
  #include <linux/acpi.h>
@@ -14,7 +14,7 @@
  		BT_INFO("hu %p, Switching compatible pm device (%s) to %u",
  			hu, dev_name(&idev->pdev->dev), powered);
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
++#if LINUX_VERSION_IS_GEQ(3,13,0)
  		gpiod_set_value(idev->reset, powered);
 +#endif
  
@@ -24,7 +24,7 @@
  
  	idev->pdev = pdev;
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
++#if LINUX_VERSION_IS_GEQ(3,17,0)
  	idev->reset = devm_gpiod_get_optional(&pdev->dev, "reset",
  					      GPIOD_OUT_LOW);
  	if (IS_ERR(idev->reset)) {
@@ -34,7 +34,7 @@
 +#endif
  
  	idev->irq = platform_get_irq(pdev, 0);
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
++#if LINUX_VERSION_IS_GEQ(3,17,0)
  	if (idev->irq < 0) {
  		struct gpio_desc *host_wake;
  
@@ -48,7 +48,7 @@
  	device_set_wakeup_capable(&pdev->dev, true);
  	device_wakeup_disable(&pdev->dev);
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,17,0)
++#if LINUX_VERSION_IS_GEQ(3,17,0)
  no_irq:
 +#endif
  	platform_set_drvdata(pdev, idev);
@@ -58,7 +58,7 @@
  	list_add_tail(&idev->list, &intel_device_list);
  	mutex_unlock(&intel_device_list_lock);
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
++#if LINUX_VERSION_IS_GEQ(3,13,0)
  	dev_info(&pdev->dev, "registered, gpio(%d)/irq(%d).\n",
  		 desc_to_gpio(idev->reset), idev->irq);
 +#endif
diff --git a/patches/0062-iff-no-queue.cocci b/patches/0062-iff-no-queue.cocci
index 9c95b853df18..237985c538d2 100644
--- a/patches/0062-iff-no-queue.cocci
+++ b/patches/0062-iff-no-queue.cocci
@@ -2,7 +2,7 @@
 expression E;
 @@
 
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,3,0)
++#if LINUX_VERSION_IS_GEQ(4,3,0)
  E->priv_flags |= IFF_NO_QUEUE;
 +#else
 +E->tx_queue_len = 0;
diff --git a/patches/0065-ndisc_send_na-argument.cocci b/patches/0065-ndisc_send_na-argument.cocci
index 84c42091b2d5..a3d00f3cf7b6 100644
--- a/patches/0065-ndisc_send_na-argument.cocci
+++ b/patches/0065-ndisc_send_na-argument.cocci
@@ -2,7 +2,7 @@
 identifier ndisc_send_na;
 expression netdev, saddr, target, router, solicited, override, inc_opt;
 @@
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,4,0)
++#if LINUX_VERSION_IS_GEQ(4,4,0)
  ipv6_stub->ndisc_send_na(netdev, saddr, target, router, solicited, override, inc_opt);
 +#else
 +ipv6_stub->ndisc_send_na(netdev, NULL, saddr, target, router, solicited, override, inc_opt);
diff --git a/patches/0066-remove-netdev_ieee802154_ptr/cfg802154.patch b/patches/0066-remove-netdev_ieee802154_ptr/cfg802154.patch
index 25bf812fa60c..04fd2394a0fc 100644
--- a/patches/0066-remove-netdev_ieee802154_ptr/cfg802154.patch
+++ b/patches/0066-remove-netdev_ieee802154_ptr/cfg802154.patch
@@ -4,7 +4,7 @@
  
  #define to_phy(_dev)	container_of(_dev, struct wpan_phy, dev)
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0)
++#if LINUX_VERSION_IS_GEQ(3,19,0)
  static inline int
  wpan_dev_hard_header(struct sk_buff *skb, struct net_device *dev,
  		     const struct ieee802154_addr *daddr,
diff --git a/patches/0068-proto-hash/ieee802154.patch b/patches/0068-proto-hash/ieee802154.patch
index e60ba5645434..9b5a97121c38 100644
--- a/patches/0068-proto-hash/ieee802154.patch
+++ b/patches/0068-proto-hash/ieee802154.patch
@@ -6,7 +6,7 @@ index e0bd013..9e78921 100644
  static HLIST_HEAD(raw_head);
  static DEFINE_RWLOCK(raw_lock);
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,6,0)
++#if LINUX_VERSION_IS_GEQ(4,6,0)
  static int raw_hash(struct sock *sk)
 +#else
 +static void raw_hash(struct sock *sk)
@@ -17,7 +17,7 @@ index e0bd013..9e78921 100644
  	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
  	write_unlock_bh(&raw_lock);
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,6,0)
++#if LINUX_VERSION_IS_GEQ(4,6,0)
  	return 0;
 +#endif
  }
@@ -27,7 +27,7 @@ index e0bd013..9e78921 100644
  	return container_of(sk, struct dgram_sock, sk);
  }
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,6,0)
++#if LINUX_VERSION_IS_GEQ(4,6,0)
  static int dgram_hash(struct sock *sk)
 +#else
 +static void dgram_hash(struct sock *sk)
@@ -38,7 +38,7 @@ index e0bd013..9e78921 100644
  	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
  	write_unlock_bh(&dgram_lock);
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,6,0)
++#if LINUX_VERSION_IS_GEQ(4,6,0)
  	return 0;
 +#endif
  }
@@ -48,7 +48,7 @@ index e0bd013..9e78921 100644
  	sock_set_flag(sk, SOCK_ZAPPED);
  
  	if (sk->sk_prot->hash) {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,6,0)
++#if LINUX_VERSION_IS_GEQ(4,6,0)
  		rc = sk->sk_prot->hash(sk);
  		if (rc) {
  			sk_common_release(sk);
diff --git a/patches/0069-iwlwifi-pd-string-fix.patch b/patches/0069-iwlwifi-pd-string-fix.patch
index e1fe84bb6435..f8c5766a0325 100644
--- a/patches/0069-iwlwifi-pd-string-fix.patch
+++ b/patches/0069-iwlwifi-pd-string-fix.patch
@@ -4,7 +4,7 @@
  	 */
  	if (priv->mac80211_registered) {
  		char buf[100];
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0)
++#if LINUX_VERSION_IS_GEQ(3,12,0)
  		struct dentry *mac80211_dir, *dev_dir;
  
  		dev_dir = dbgfs_dir->d_parent;
@@ -30,7 +30,7 @@
  	mvmvif->dbgfs_dir = debugfs_create_dir("iwlmvm", dbgfs_dir);
  
  	if (!mvmvif->dbgfs_dir) {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0)
++#if LINUX_VERSION_IS_GEQ(3,12,0)
  		IWL_ERR(mvm, "Failed to create debugfs directory under %pd\n",
  			dbgfs_dir);
 +#else
@@ -44,7 +44,7 @@
  	 * find
  	 * netdev:wlan0 -> ../../../ieee80211/phy0/netdev:wlan0/iwlmvm/
  	 */
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0)
++#if LINUX_VERSION_IS_GEQ(3,12,0)
  	snprintf(buf, 100, "../../../%pd3/%pd",
  		 dbgfs_dir,
  		 mvmvif->dbgfs_dir);
@@ -59,7 +59,7 @@
  	mvmvif->dbgfs_slink = debugfs_create_symlink(dbgfs_dir->d_name.name,
  						     mvm->debugfs_dir, buf);
  	if (!mvmvif->dbgfs_slink)
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0)
++#if LINUX_VERSION_IS_GEQ(3,12,0)
  		IWL_ERR(mvm, "Can't create debugfs symbolic link under %pd\n",
  			dbgfs_dir);
 +#else
@@ -75,7 +75,7 @@
  	 * Create a symlink with mac80211. It will be removed when mac80211
  	 * exists (before the opmode exists which removes the target.)
  	 */
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,12,0)
++#if LINUX_VERSION_IS_GEQ(3,12,0)
  	snprintf(buf, 100, "../../%pd2", dbgfs_dir->d_parent);
 +#else
 +	snprintf(buf, 100, "../../%s/%s",
diff --git a/patches/0069-remove-of_irq/bcma.patch b/patches/0069-remove-of_irq/bcma.patch
index 71cab1707dbe..2c8c7cac2d95 100644
--- a/patches/0069-remove-of_irq/bcma.patch
+++ b/patches/0069-remove-of_irq/bcma.patch
@@ -4,7 +4,7 @@
  	return NULL;
  }
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,13,0)
++#if LINUX_VERSION_IS_GEQ(3,13,0)
  static int bcma_of_irq_parse(struct device *parent,
  			     struct bcma_device *core,
  			     struct of_phandle_args *out_irq, int num)
diff --git a/patches/0070-mac80211-fils.patch b/patches/0070-mac80211-fils.patch
index 0e8747f93630..c45aa2bd8c82 100644
--- a/patches/0070-mac80211-fils.patch
+++ b/patches/0070-mac80211-fils.patch
@@ -3,7 +3,7 @@ index ecfdd97758a3..95fc9669ea4f 100644
 --- a/net/mac80211/fils_aead.c
 +++ b/net/mac80211/fils_aead.c
 @@ -1,3 +1,4 @@
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,3,0)
++#if LINUX_VERSION_IS_GEQ(4,3,0)
  /*
   * FILS AEAD for (Re)Association Request/Response frames
   * Copyright 2016, Qualcomm Atheros, Inc.
@@ -20,7 +20,7 @@ index fbc65232f0b3..482bc5fcdd18 100644
  #ifndef FILS_AEAD_H
  #define FILS_AEAD_H
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,3,0)
++#if LINUX_VERSION_IS_GEQ(4,3,0)
  int fils_encrypt_assoc_req(struct sk_buff *skb,
  			   struct ieee80211_mgd_assoc_data *assoc_data);
  int fils_decrypt_assoc_resp(struct ieee80211_sub_if_data *sdata,
@@ -52,7 +52,7 @@ index a6ecbbf0f47f..afc1517e9729 100644
  			   NL80211_FEATURE_MAC_ON_CREATE |
  			   NL80211_FEATURE_USERSPACE_MPM |
  			   NL80211_FEATURE_FULL_AP_CLIENT_STATE;
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,3,0)
++#if LINUX_VERSION_IS_GEQ(4,3,0)
  	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_FILS_STA);
 +#endif
  
diff --git a/patches/0071-skb-head_frag/wireless.patch b/patches/0071-skb-head_frag/wireless.patch
index 1d6d8bb28a56..b314cd752bbb 100644
--- a/patches/0071-skb-head_frag/wireless.patch
+++ b/patches/0071-skb-head_frag/wireless.patch
@@ -4,7 +4,7 @@
  	u8 *payload;
  	int offset = 0, remaining, err;
  	struct ethhdr eth;
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,5,0)
++#if LINUX_VERSION_IS_LESS(3,5,0)
 +	bool reuse_frag = 0;
 +#else
  	bool reuse_frag = skb->head_frag && !skb_has_frag_list(skb);
diff --git a/patches/0072-netdevice-ndo_fdb_add/igb.patch b/patches/0072-netdevice-ndo_fdb_add/igb.patch
index e068ea3b4abf..9dcac3d2ef43 100644
--- a/patches/0072-netdevice-ndo_fdb_add/igb.patch
+++ b/patches/0072-netdevice-ndo_fdb_add/igb.patch
@@ -4,7 +4,7 @@
  
  static int igb_ndo_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
  			   struct net_device *dev,
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,19,0)
++#if LINUX_VERSION_IS_LESS(3,19,0)
 +			   const unsigned char *addr,
 +#else
  			   const unsigned char *addr, u16 vid,
diff --git a/patches/0073-netdevice-mtu-range.cocci b/patches/0073-netdevice-mtu-range.cocci
index 3e1e7708a700..7a4b65322803 100644
--- a/patches/0073-netdevice-mtu-range.cocci
+++ b/patches/0073-netdevice-mtu-range.cocci
@@ -73,7 +73,7 @@ func(...) {
 constant r1.e1,r1.e2;
 identifier r.OPS;
 @@
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,10,0)
++#if LINUX_VERSION_IS_LESS(4,10,0)
 + static int __change_mtu(struct net_device *ndev, int new_mtu)
 + {
 + if (new_mtu < e1 || new_mtu > e2)
@@ -92,7 +92,7 @@ identifier OPS;
 @@
 
 struct net_device_ops OPS = {
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,10,0)
++#if LINUX_VERSION_IS_LESS(4,10,0)
 +      .ndo_change_mtu = __change_mtu,
 +#endif
        ...
diff --git a/patches/0074-netdevice-mtu-range-ifdefs.cocci b/patches/0074-netdevice-mtu-range-ifdefs.cocci
index ffa7082b01e2..5689f4382714 100644
--- a/patches/0074-netdevice-mtu-range-ifdefs.cocci
+++ b/patches/0074-netdevice-mtu-range-ifdefs.cocci
@@ -5,7 +5,7 @@ identifier func;
 @@
 func(...) {
 	<+...
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,10,0)
++#if LINUX_VERSION_IS_GEQ(4,10,0)
 	ndevexp->min_mtu = E;
 +#endif
 	...+>
@@ -18,7 +18,7 @@ identifier func;
 @@
 func(...) {
 	<+...
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,10,0)
++#if LINUX_VERSION_IS_GEQ(4,10,0)
 	ndevexp->max_mtu = E;
 +#endif
 	...+>
diff --git a/patches/0074-skb-wifi-acked.cocci b/patches/0074-skb-wifi-acked.cocci
index f758ac31e76e..79366df7988d 100644
--- a/patches/0074-skb-wifi-acked.cocci
+++ b/patches/0074-skb-wifi-acked.cocci
@@ -2,7 +2,7 @@
 expression SKB;
 expression A, V;
 @@
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,3,0)
++#if LINUX_VERSION_IS_GEQ(3,3,0)
 SKB->wifi_acked_valid = V;
 SKB->wifi_acked = A;
 +#endif
diff --git a/patches/0075-ndo-stats-64.cocci b/patches/0075-ndo-stats-64.cocci
index ac449de26970..a8766492f410 100644
--- a/patches/0075-ndo-stats-64.cocci
+++ b/patches/0075-ndo-stats-64.cocci
@@ -5,7 +5,7 @@ fresh identifier stats64_fn_wrap = "bp_" ## stats64_fn;
 position p;
 @@
 struct net_device_ops OPS@p = {
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,10,0)
++#if LINUX_VERSION_IS_GEQ(4,10,0)
 	.ndo_get_stats64 = stats64_fn,
 +#else
 +	.ndo_get_stats64 = stats64_fn_wrap,
@@ -17,7 +17,7 @@ identifier r.stats64_fn_wrap;
 identifier r.stats64_fn;
 @@
 void stats64_fn(...) {...}
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,10,0)
++#if LINUX_VERSION_IS_LESS(4,10,0)
 +static struct rtnl_link_stats64 *
 +stats64_fn_wrap(struct net_device *dev,
 +		 struct rtnl_link_stats64 *stats)
diff --git a/patches/crypto-ccm.patch b/patches/crypto-ccm.patch
index fe7500056ba7..8bdea3db5f3e 100644
--- a/patches/crypto-ccm.patch
+++ b/patches/crypto-ccm.patch
@@ -13,7 +13,7 @@
 +#include <linux/version.h>
  
 -#include "internal.h"
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,13,0)
++#if LINUX_VERSION_IS_LESS(3,13,0)
 +/* consider properly backporting this? */
 +static int crypto_memneq(const void *a, const void *b, size_t size)
 +{
diff --git a/patches/devcoredump.patch b/patches/devcoredump.patch
index 9d5454ce3c7b..728e10434cec 100644
--- a/patches/devcoredump.patch
+++ b/patches/devcoredump.patch
@@ -12,7 +12,7 @@
  /* if data isn't read by userspace after 5 minutes then delete it */
  #define DEVCD_TIMEOUT	(HZ * 60 * 5)
  
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)
++#if LINUX_VERSION_IS_LESS(3,11,0)
 +static struct bin_attribute devcd_attr_data;
 +#endif
 +
@@ -33,7 +33,7 @@
  
  	devcd = container_of(wk, struct devcd_entry, del_wk.work);
  
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)
++#if LINUX_VERSION_IS_LESS(3,11,0)
 +	device_remove_bin_file(&devcd->devcd_dev, &devcd_attr_data);
 +#endif
  	device_del(&devcd->devcd_dev);
@@ -43,7 +43,7 @@
  	.write = devcd_data_write,
  };
  
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
++#if LINUX_VERSION_IS_GEQ(3,11,0)
  static struct bin_attribute *devcd_dev_bin_attrs[] = {
  	&devcd_attr_data, NULL,
  };
@@ -51,7 +51,7 @@
  static const struct attribute_group *devcd_dev_groups[] = {
  	&devcd_dev_group, NULL,
  };
-+#endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0) */
++#endif /* LINUX_VERSION_IS_GEQ(3,11,0) */
  
  static int devcd_free(struct device *dev, void *data)
  {
@@ -59,7 +59,7 @@
  	.name		= "devcoredump",
  	.owner		= THIS_MODULE,
  	.dev_release	= devcd_dev_release,
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
++#if LINUX_VERSION_IS_GEQ(3,11,0)
  	.dev_groups	= devcd_dev_groups,
 +#endif
  	.class_groups	= devcd_class_groups,
@@ -69,7 +69,7 @@
  	if (device_add(&devcd->devcd_dev))
  		goto put_device;
  
-+#if LINUX_VERSION_CODE < KERNEL_VERSION(3,11,0)
++#if LINUX_VERSION_IS_LESS(3,11,0)
 +	if (device_create_bin_file(&devcd->devcd_dev, &devcd_attr_data))
 +		goto put_device;
 +#endif
diff --git a/patches/flow_dissector.patch b/patches/flow_dissector.patch
index 68434bdbc571..189a5c7aa87d 100644
--- a/patches/flow_dissector.patch
+++ b/patches/flow_dissector.patch
@@ -4,7 +4,7 @@
  
  	flow->ip_proto = ip_proto;
  	flow->ports = skb_flow_get_ports(skb, nhoff, ip_proto);
-+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,9,0)
++#if LINUX_VERSION_IS_GEQ(3,9,0)
  	flow->thoff = (u16) nhoff;
 +#endif
  
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
