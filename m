Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:41030 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751417AbbFNO3f (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 14 Jun 2015 10:29:35 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/21] backports: bring it to next-20150612 and add mt7601u
Date: Sun, 14 Jun 2015 16:29:01 +0200
Message-Id: <1434292162-2261-1-git-send-email-hauke@hauke-m.de> (sfid-20150614_162940_858072_A27CABFA)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This adds many stuff, that is needed for next-20150612, for example the 
backport of the new crypto API. It also fixes some problems in previous 
patches and should fix tracing for some driver. In addition it adds the 
new mt7601u driver and the new functions needed by this driver.

Hauke Mehrtens (21):
  patches: fix spatch for bluetooth
  patches: deactivate tracing for ath6kl, cfg80211 and wil6210 only on
    kernel < 3.4
  patches: include linux/sched.h header in drivers/nfc/mei_phy.c
  header: fix rt6_nexthop() backport
  patches: remove additional member in struct mei_cl_device_id
  patches: rhashtable header patch not needed
  backports: add backport for new AEAD crypto API
  dependencies: add VIDEO_COBALT
  dependencies: make DVB_M88DS3103 and DVB_TS2020 depend on kernel > 3.8
  dependencies: make two media tuners depend on kernel >= 3.3
  dependencies: make VIDEO_ADV7604 depend on kernel >= 3.17
  dependencies: make VIDEO_ADP1653 depend on kernel >= 3.13
  backports: add HDMI driver
  patches: do not use vidioc_expbuf function pointer in v4l
  backports: add tty_set_termios()
  header: add dev_dbg_once() and others
  header: add devm_kcalloc()
  backports: add mediatek mt7601u driver
  patches: deactivate struct tracing in mt7601u
  patches: deactivate tracing on mt7601u for kernel < 3.4
  patches: refresh patches on next-20150612

 backport/backport-include/crypto/aead.h            |  33 ++++++
 backport/backport-include/linux/device.h           |  44 +++++++
 backport/backport-include/linux/tty.h              |   5 +
 backport/backport-include/net/ip6_fib.h            |  18 ++-
 backport/compat/Kconfig                            |  16 +++
 backport/compat/Makefile                           |   1 +
 backport/compat/backport-4.1.c                     |  65 ++++++++++
 backport/compat/backport-4.2.c                     |  67 +++++++++++
 backport/defconfigs/wifi                           |   2 +
 copy-list                                          |   3 +-
 dependencies                                       |  16 ++-
 patches/backport-adjustments/rhashtable.patch      |  10 --
 .../media/0002-no_dmabuf/v4l2.patch                | 132 +++++++++++++++------
 .../media/0005-dma-no-sync/v4l2.patch              |   8 +-
 .../0013-fix-makefile-includes/mei_phy.patch       |  10 ++
 .../network/0022-define-tracing/ath6kl.patch       |   4 +-
 .../network/0022-define-tracing/cfg80211.patch     |   8 +-
 .../network/0022-define-tracing/mt7601u.patch      |  12 ++
 .../network/0022-define-tracing/wil6210.patch      |   4 +-
 .../network/0024-led-blink-api/mac80211.patch      |   2 +-
 .../network/0028-select_queue/mac80211.patch       |   4 +-
 .../network/0028-select_queue/mwifiex.patch        |   2 +-
 .../network/0046-mmc_rescan_entered/mwifiex.patch  |   2 +-
 .../network/0050-iov_iter/bluetooth.patch          |   8 +-
 .../0053-remove_wait_on_bit_timeout/btusb.patch    |  12 +-
 .../network/0054-struct-proto_ops-sig.cocci        |   8 +-
 .../network/0059-uuid-in-mei/INFO                  |   7 ++
 .../network/0059-uuid-in-mei/nfc.patch             |  28 +++++
 .../network/0060-trace_field_struct/INFO           |  11 ++
 .../network/0060-trace_field_struct/mt7601u.patch  |  33 ++++++
 30 files changed, 494 insertions(+), 81 deletions(-)
 create mode 100644 backport/backport-include/crypto/aead.h
 create mode 100644 backport/compat/backport-4.2.c
 delete mode 100644 patches/backport-adjustments/rhashtable.patch
 create mode 100644 patches/collateral-evolutions/network/0013-fix-makefile-includes/mei_phy.patch
 create mode 100644 patches/collateral-evolutions/network/0022-define-tracing/mt7601u.patch
 create mode 100644 patches/collateral-evolutions/network/0059-uuid-in-mei/INFO
 create mode 100644 patches/collateral-evolutions/network/0059-uuid-in-mei/nfc.patch
 create mode 100644 patches/collateral-evolutions/network/0060-trace_field_struct/INFO
 create mode 100644 patches/collateral-evolutions/network/0060-trace_field_struct/mt7601u.patch

-- 
2.1.4

