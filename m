Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3679847F6F
	for <backports@vger.kernel.org>; Thu, 27 Jun 2024 23:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532131; cv=none; b=kX/B0nr0ylh+7GMHCSccA/6T051J6piLHG/T4P6ssvy3Y4MUWVOLygcuF+4vzwX0WW02o66ghmT1mQh6WUMhOordYj7IoEtkA7uQELTSyTjBbhhbrwJiwUmN2Uf6AgnLavYyFqT07Ghv8DhIrEJU9iK9kOreDg3P9hIiaAb3e2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532131; c=relaxed/simple;
	bh=DNeHTNJPbhOxSZVGEOKTw4VpU0Siu8kY8xAxL+aRli8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iUDQSa5+vYmHVAoc7ohMSl35CCnr5PPyOxIDthJi/6T5UNb0bBo4Ne+pc1xf6KFMJKQHnRDRYkmmNlmKo37X/T61HFRtY2TO3qUR/0W+eyvT79Q6b++FYhoh2ReKFm3wiz6vJ/6MqMRQYjq8SuDpuzsn1+Xfs7lA+kyzOJDxKZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=iDyh0H/T; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="iDyh0H/T"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W9FdL470Bz9spZ;
	Fri, 28 Jun 2024 01:48:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1719532118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xn5GdkYhTc/MAw6/VglRVHKTUvmPMY0EHVq15TFFjnc=;
	b=iDyh0H/TydJhqxHwD+kIXMgeaZQZBQFyIEACunoaY5SvCKxF/jZGYKiv0omOUSb7NfJOWP
	5VEGNM1MHY2EQ4H2jMaFWs0Qty4YHhpCbnLNY72tPnhPpHYjqIfPNNv+pBprXyk4soA1nK
	pDTZSRDDuN77evaHyrSDW4ppXvkFy36dw31oJ/RIVSoccjQQglvib4Cz/GT4djBMkVN2le
	+HZjycIAVxC4f16AVQdOwoaoe7eOyJ0tA7skDN3kR9q+SURUAjih5LLuH6ggBryOudH1z6
	+YGRMxF/JQUdzUB4KCLCg9hdXO8W0ozAJfcY7SO2fBtHISOxu7tj7SXYtjZ7IA==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/75] backports: Update to kernel 6.1.95
Date: Fri, 28 Jun 2024 01:46:46 +0200
Message-ID: <20240627234808.1253337-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I took many patches from Johannes, Felix, Gregory and Luca and added 
some own patches on top. This brings backports to version 6.1. I will 
look into the patches needed for kernel 6.9 from Johannes next. This 
only got very little testing till now. 

This also removes the verification subsystem and some other left overs.

This code is also available in my github repository:
https://github.com/hauke/backports/tree/testing-6.1-rebase

Felix Fietkau (11):
  headers: backport napi add functions
  headers: backport usb_maxpacket api change
  headers: add txq_trans_cond_update
  headers: add __vstring and __assign_vstr
  headers: backport mmc_sw_reset and mmc_hw_reset API changes
  headers: add DEFINE_SIMPLE_DEV_PM_OPS
  headers: backport device_get_mac_address api change
  headers: add skb_tcp_all_headers
  headers: backport get_random_u16, get_random_u8
  headers: backport hwrng_msleep
  headers: backport napi_build_skb

Gregory Greenman (3):
  backport: update 0099-netlink-range patch to apply on v5.18-rc1
  backports: define __is_constexpr() for older kernels
  backports: update mac80211-status.patch to v6.0-rc1

Hauke Mehrtens (39):
  backports: Remove no-pointer-sign option
  backports: Remove BPAUTO_REFCOUNT
  backports: Remove verification backport
  backports: Remove compat/memneq.c
  backports: Remove mpls.h
  backports: Remove driver headers
  Makefile: Generate new CPTCFG_KERNEL_
  patches: Refresh on 6.1.95
  headers: Add linux/soc/mediatek/mtk_wed.h
  header: Add linux/platform_data/brcmnand.h
  patches: Handle changed spi_driver->remove signature
  headers: Handle skb_recv_datagram() signature change.
  dependencies: Make MHI_BUS_EP depend on 5.19
  headere: add netif_napi_add_weight()
  backports: Use compile using GNU11
  patches: Remove genl_family.resv_start_op
  patches: Adapt struct msi_desc reorganization
  patch: Adapt struct pcpu_sw_netstats change to u64_stats_t
  patch: bcma: Fill of_node instead of fwnode on older kernel
  header: Add dev_addr_mod()
  backports: Add devm_bitmap_zalloc()
  headr: Add empty dev_set_threaded()
  header: Add empty request_partial_firmware_into_buf()
  header: Add DEVICE_ATTR_ADMIN_RO
  backports: Add sysfs_emit_at()
  dependencies: Make CONFIG_R8188EU depend on 5.10
  header: Add linux/minmax.h
  header: Add pm_runtime_resume_and_get
  header: Add module.h include to firmware.h
  header Add SENSOR_DEVICE_ATTR_RO
  backports Add bitmap_alloc and bitmap_alloc
  dependencies: Deactivate mt76 driver on kernel < 4.19
  dependencies: MAC80211_HWSIM depends on 4.19
  patches: Remove additional DMI match in brcmfmac
  backports: Move  usb_check_bulk_endpoints to 6.4
  backports: Add usb_check_int_endpoints()
  github: Use kernel 6.1 in github action
  headers: Add timer_delete_sync()
  CI: Add gcc-12 to devcontainer

Johannes Berg (20):
  gentree: fix python quoting errors
  backports: bpgit: handle copied files properly in status()
  backports: add kthread.h
  backports: stub structs but remove ndo_fill_forward_path
  backports: add memset_after/memset_startat
  patches: add spatch to adjust to changed ethtool ringparam API
  backports: add linux/efi.h
  backports: add eth_hw_addr_set()
  backports: add module namespace support
  backports: add lockdep_is_held() when needed
  backports: add netif_rx()
  backports: add rfkill_soft_blocked()
  backports: add skb_list_del_init()
  backports: add skb_get_dsfield()
  backports: add NLA_POLICY_MIN_LEN()
  backports: add netlink length validation for 13
  backports: add mul_u64_u64_div_u64()
  backports: add thermal_zone_device_enable()
  backports: add virtio_reset_device
  patches: add build system workaround for pre 5.17

Luca Coelho (2):
  backport: implement NLA_POLICY_RANGE for NLA_BINARY
  backport: add dev_sw_netstats_tx/rx_add() functions

 .devcontainer/Dockerfile                      |    2 +-
 .github/workflows/create.yml                  |   12 +-
 backport/Makefile                             |    7 +-
 backport/Makefile.kernel                      |    5 +-
 .../backport-include/keys/asymmetric-type.h   |   35 -
 .../backport-include/keys/system_keyring.h    |   10 -
 backport/backport-include/linux/bitmap.h      |   28 +
 backport/backport-include/linux/device.h      |    5 +
 backport/backport-include/linux/efi.h         |   13 +
 backport/backport-include/linux/etherdevice.h |   35 +
 backport/backport-include/linux/export.h      |   12 +
 backport/backport-include/linux/firmware.h    |   16 +
 backport/backport-include/linux/hw_random.h   |   18 +
 backport/backport-include/linux/hwmon-sysfs.h |   15 +
 backport/backport-include/linux/kernel.h      |   18 +
 backport/backport-include/linux/key.h         |   66 -
 backport/backport-include/linux/kthread.h     |   13 +
 backport/backport-include/linux/lockdep.h     |    7 +
 backport/backport-include/linux/math64.h      |   11 +
 backport/backport-include/linux/minmax.h      |    7 +
 backport/backport-include/linux/mmc/core.h    |   26 +
 backport/backport-include/linux/module.h      |    4 +
 backport/backport-include/linux/netdevice.h   |  155 ++
 .../linux/platform_data/brcmnand.h            |    9 +
 backport/backport-include/linux/pm.h          |   30 +
 backport/backport-include/linux/pm_runtime.h  |   31 +
 backport/backport-include/linux/random.h      |   18 +
 backport/backport-include/linux/rfkill.h      |    9 +
 backport/backport-include/linux/skbuff.h      |   22 +-
 .../linux/soc/mediatek/mtk_wed.h              |   58 +
 backport/backport-include/linux/string.h      |   25 +
 backport/backport-include/linux/sysfs.h       |    9 +
 backport/backport-include/linux/tcp.h         |   14 +
 backport/backport-include/linux/thermal.h     |   12 +
 backport/backport-include/linux/timer.h       |   12 +
 backport/backport-include/linux/usb.h         |   16 +-
 .../backport-include/linux/verification.h     |   29 -
 backport/backport-include/linux/virtio.h      |   13 +
 backport/backport-include/net/inet_ecn.h      |   66 +
 backport/backport-include/net/netlink.h       |   34 +-
 .../backport-include/trace/trace_events.h     |   16 +
 backport/compat/Kconfig                       |   33 -
 backport/compat/Makefile                      |   31 +-
 backport/compat/backport-4.19.c               |   21 +
 backport/compat/backport-5.10.c               |   28 +
 backport/compat/backport-5.13.c               |   34 +
 backport/compat/backport-5.15.c               |   52 -
 backport/compat/backport-5.9.c                |   45 +
 backport/compat/backport-6.4.c                |   87 +
 backport/compat/verification/asn1parse.c      |  393 ---
 backport/compat/verification/bignum.c         | 2458 -----------------
 backport/compat/verification/key.c            |  172 --
 backport/compat/verification/mbedtls/asn1.h   |  342 ---
 backport/compat/verification/mbedtls/bignum.h |  760 -----
 backport/compat/verification/mbedtls/bn_mul.h |  887 ------
 backport/compat/verification/mbedtls/config.h |   15 -
 backport/compat/verification/mbedtls/md.h     |  354 ---
 .../compat/verification/mbedtls/md_internal.h |  116 -
 backport/compat/verification/mbedtls/oid.h    |  570 ----
 backport/compat/verification/mbedtls/pk.h     |  618 -----
 .../compat/verification/mbedtls/platform.h    |   12 -
 backport/compat/verification/mbedtls/rsa.h    |  672 -----
 backport/compat/verification/mbedtls/sha1.h   |  135 -
 backport/compat/verification/mbedtls/sha256.h |  140 -
 backport/compat/verification/md.c             |  471 ----
 backport/compat/verification/md_wrap.c        |  577 ----
 backport/compat/verification/oid.c            |  709 -----
 backport/compat/verification/pkcs7.asn1.c     |  355 ---
 backport/compat/verification/pkcs7.asn1.h     |   27 -
 backport/compat/verification/public_key.c     |  131 -
 backport/compat/verification/rsa.c            | 1872 -------------
 backport/compat/verification/rsapubkey.asn1.c |   38 -
 backport/compat/verification/rsapubkey.asn1.h |   15 -
 backport/compat/verification/sha256.c         |  458 ---
 backport/compat/verification/verify.c         |   65 -
 backport/compat/verification/x509.asn1.c      |  185 --
 backport/compat/verification/x509.asn1.h      |   23 -
 backport/compat/verification/x509_akid.asn1.c |  144 -
 backport/compat/verification/x509_akid.asn1.h |   15 -
 copy-list                                     |   27 -
 copy-list.hwsim                               |   27 -
 dependencies                                  |   23 +
 gentree.py                                    |   24 +-
 lib/bpgit.py                                  |    4 +-
 .../include_net_cfg80211.patch                |    2 +-
 .../net_wireless_core.patch                   |    2 +-
 .../net_wireless_core.patch                   |    4 +-
 patches/0013-fix-makefile-includes/mt76.patch |   10 -
 .../0013-fix-makefile-includes/rtw88.patch    |   22 -
 patches/0028-select_queue/mac80211.patch      |    4 +-
 patches/0028-select_queue/mwifiex.patch       |    2 +-
 patches/0028-select_queue/r8188eu.patch       |    2 +-
 patches/0089-unknown-dmi/brcmfmac.patch       |   16 +-
 patches/0089-unknown-dmi/mwifiex.patch        |    4 +-
 patches/0094-ndo-tx-timeout/usbnet.patch      |    2 +-
 patches/0095-spi-delay/wilc1000.patch         |    6 +-
 patches/0097-nla_policy_binary_range.cocci    |    5 +
 patches/0097-skb-list/mac80211-rx.patch       |   20 +-
 patches/0097-skb-list/mac80211-status.patch   |   14 +-
 patches/0097-skb-list/mt76.patch              |  150 -
 patches/0099-netlink-range/mac80211.patch     |   22 +-
 patches/0100-revert-small_ops/mac80211.patch  |    8 +-
 .../mac80211_hwsim.patch                      |    6 +-
 patches/0101-net_device-threaded/mt76.patch   |    6 +-
 patches/0104-mhi-reg-len.patch                |    2 +-
 ...05-remove-const-from-rchan_callbacks.patch |    2 +-
 patches/0106-ethtool-ringparam.cocci          |   45 +
 patches/0107-net-forward-path.cocci           |   19 +
 patches/0108-spi-probe.cocci                  |   27 +
 patches/0109-resv_start_op.cocci              |   10 +
 patches/0110-msi-pci.patch                    |   14 +
 patches/0111-pcpu_sw_netstats.patch           |   30 +
 patches/0111-wireless-build-unquote.patch     |   17 +
 patches/0112-gpio-fwnode.patch                |   14 +
 patches/lib-refcount.patch                    |    2 -
 patches/verify.patch                          |  101 -
 116 files changed, 1281 insertions(+), 13417 deletions(-)
 delete mode 100644 backport/backport-include/keys/asymmetric-type.h
 delete mode 100644 backport/backport-include/keys/system_keyring.h
 create mode 100644 backport/backport-include/linux/bitmap.h
 create mode 100644 backport/backport-include/linux/efi.h
 create mode 100644 backport/backport-include/linux/etherdevice.h
 create mode 100644 backport/backport-include/linux/export.h
 create mode 100644 backport/backport-include/linux/hw_random.h
 create mode 100644 backport/backport-include/linux/hwmon-sysfs.h
 create mode 100644 backport/backport-include/linux/kernel.h
 delete mode 100644 backport/backport-include/linux/key.h
 create mode 100644 backport/backport-include/linux/kthread.h
 create mode 100644 backport/backport-include/linux/math64.h
 create mode 100644 backport/backport-include/linux/minmax.h
 create mode 100644 backport/backport-include/linux/mmc/core.h
 create mode 100644 backport/backport-include/linux/platform_data/brcmnand.h
 create mode 100644 backport/backport-include/linux/pm_runtime.h
 create mode 100644 backport/backport-include/linux/random.h
 create mode 100644 backport/backport-include/linux/soc/mediatek/mtk_wed.h
 create mode 100644 backport/backport-include/linux/string.h
 create mode 100644 backport/backport-include/linux/tcp.h
 delete mode 100644 backport/backport-include/linux/verification.h
 create mode 100644 backport/backport-include/linux/virtio.h
 create mode 100644 backport/backport-include/net/inet_ecn.h
 create mode 100644 backport/backport-include/trace/trace_events.h
 create mode 100644 backport/compat/backport-4.19.c
 create mode 100644 backport/compat/backport-5.9.c
 create mode 100644 backport/compat/backport-6.4.c
 delete mode 100644 backport/compat/verification/asn1parse.c
 delete mode 100644 backport/compat/verification/bignum.c
 delete mode 100644 backport/compat/verification/key.c
 delete mode 100644 backport/compat/verification/mbedtls/asn1.h
 delete mode 100644 backport/compat/verification/mbedtls/bignum.h
 delete mode 100644 backport/compat/verification/mbedtls/bn_mul.h
 delete mode 100644 backport/compat/verification/mbedtls/config.h
 delete mode 100644 backport/compat/verification/mbedtls/md.h
 delete mode 100644 backport/compat/verification/mbedtls/md_internal.h
 delete mode 100644 backport/compat/verification/mbedtls/oid.h
 delete mode 100644 backport/compat/verification/mbedtls/pk.h
 delete mode 100644 backport/compat/verification/mbedtls/platform.h
 delete mode 100644 backport/compat/verification/mbedtls/rsa.h
 delete mode 100644 backport/compat/verification/mbedtls/sha1.h
 delete mode 100644 backport/compat/verification/mbedtls/sha256.h
 delete mode 100644 backport/compat/verification/md.c
 delete mode 100644 backport/compat/verification/md_wrap.c
 delete mode 100644 backport/compat/verification/oid.c
 delete mode 100644 backport/compat/verification/pkcs7.asn1.c
 delete mode 100644 backport/compat/verification/pkcs7.asn1.h
 delete mode 100644 backport/compat/verification/public_key.c
 delete mode 100644 backport/compat/verification/rsa.c
 delete mode 100644 backport/compat/verification/rsapubkey.asn1.c
 delete mode 100644 backport/compat/verification/rsapubkey.asn1.h
 delete mode 100644 backport/compat/verification/sha256.c
 delete mode 100644 backport/compat/verification/verify.c
 delete mode 100644 backport/compat/verification/x509.asn1.c
 delete mode 100644 backport/compat/verification/x509.asn1.h
 delete mode 100644 backport/compat/verification/x509_akid.asn1.c
 delete mode 100644 backport/compat/verification/x509_akid.asn1.h
 delete mode 100644 patches/0013-fix-makefile-includes/rtw88.patch
 create mode 100644 patches/0097-nla_policy_binary_range.cocci
 delete mode 100644 patches/0097-skb-list/mt76.patch
 create mode 100644 patches/0106-ethtool-ringparam.cocci
 create mode 100644 patches/0107-net-forward-path.cocci
 create mode 100644 patches/0108-spi-probe.cocci
 create mode 100644 patches/0109-resv_start_op.cocci
 create mode 100644 patches/0110-msi-pci.patch
 create mode 100644 patches/0111-pcpu_sw_netstats.patch
 create mode 100644 patches/0111-wireless-build-unquote.patch
 create mode 100644 patches/0112-gpio-fwnode.patch
 delete mode 100644 patches/verify.patch

-- 
2.45.2

