Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:42964 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754388AbdHUW2u (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 21 Aug 2017 18:28:50 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/21] backports: multiple changes for kernel 3.13-rc6
Date: Tue, 22 Aug 2017 00:27:56 +0200
Message-Id: <20170821222817.17376-1-hauke@hauke-m.de> (sfid-20170822_002853_183210_AA20A23A)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This brings backports to kernel 4.13-rc6.

This was build tested with kernel 3.18, 4.4 and 4.9. and runtime tested 
with iwlwifi on kernel 4.9.

Are you planing to to releases in a tar?
Which kernel versions are currently support by backports?
patches/0079-netdev-destructor.cocci takes very long to apply, about 3 
times longer all others together.
Should we remove ssb and bcma from backports and use the in kernel 
versions instead? I do not expect so many changes any more affecting the 
wifi drivers.

Is the compat wireless build server still being used?

Hauke Mehrtens (21):
  copy: do not copy files removed in kernel 4.13
  patches: header fix for st-nci not needed any more
  header: skbuff: add skb_put_zero(), skb_put_data() and skb_put_u8()
  header: skbuff: fix signature of skb_put(), skb_push() and ()
  header: backport mii_ethtool_{get,set}_link_ksettings()
  patches: adapt the stat64 usage for usbnet
  header: add module_param_hw_array()
  header: backport devm_acpi_dev_add_driver_gpios()
  header: add get_random_u32()
  header: rename wait_queue_entry_t to wait_queue_t
  backport: add __print_array()
  compat: avoid usage of kvzalloc() in rhashtable.c
  patch: Allow usage of pci_error_handlers->reset_notify
  header: add offsetofend()
  dependencies: add deps for struct acpi_gpio_mapping
  patches: brcmfmac: fix netdev destructor
  patches: backport the probe_new for i2c drivers
  patches: adapt signature of proto_ops->accept
  header: add linux/refcount.h
  header: add dma_wmb()
  copy-list: add quantenna qtnfmac driver

 backport/backport-include/asm/barrier.h            |   4 +
 backport/backport-include/linux/acpi.h             |   9 +
 backport/backport-include/linux/ftrace_event.h     |  10 +
 backport/backport-include/linux/mii.h              |   7 +
 backport/backport-include/linux/moduleparam.h      |   5 +
 backport/backport-include/linux/random.h           |   7 +
 backport/backport-include/linux/refcount.h         |  47 +++++
 backport/backport-include/linux/skbuff.h           |  44 ++++
 backport/backport-include/linux/stddef.h           |  16 ++
 backport/backport-include/linux/wait.h             |   4 +
 backport/backport-include/trace/ftrace.h           |   9 +
 backport/compat/Makefile                           |   1 +
 backport/compat/backport-4.0.c                     |  46 +++++
 backport/compat/backport-4.10.c                    | 223 +++++++++++++++++++++
 copy-list                                          |   3 +-
 dependencies                                       |  15 +-
 .../0013-fix-makefile-includes/st-nci-spi.patch    |  10 -
 patches/0075-ndo-stats-64.cocci                    |   2 +-
 patches/0075-ndo-stats-64/usbnet.patch             |  26 +++
 patches/0079-netdev-destructor/brcmfmac.patch      |  35 ++++
 patches/0080-i2c-proble-new.cocci                  |  25 +++
 patches/0081-proto_ops-accept/nfc.patch            |  16 ++
 patches/0082-pci_error_handlers.cocci              |  32 +++
 patches/lib-rhashtable.patch                       |  17 +-
 24 files changed, 593 insertions(+), 20 deletions(-)
 create mode 100644 backport/backport-include/linux/ftrace_event.h
 create mode 100644 backport/backport-include/linux/refcount.h
 create mode 100644 backport/backport-include/linux/stddef.h
 create mode 100644 backport/backport-include/trace/ftrace.h
 create mode 100644 backport/compat/backport-4.10.c
 delete mode 100644 patches/0013-fix-makefile-includes/st-nci-spi.patch
 create mode 100644 patches/0075-ndo-stats-64/usbnet.patch
 create mode 100644 patches/0079-netdev-destructor/brcmfmac.patch
 create mode 100644 patches/0080-i2c-proble-new.cocci
 create mode 100644 patches/0081-proto_ops-accept/nfc.patch
 create mode 100644 patches/0082-pci_error_handlers.cocci

-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe backports" in
