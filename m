Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:48251 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752753Ab3KXVXf (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 24 Nov 2013 16:23:35 -0500
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/15] backports: remove some unused code
Date: Sun, 24 Nov 2013 22:23:03 +0100
Message-Id: <1385328198-28520-1-git-send-email-hauke@hauke-m.de> (sfid-20131124_222337_341743_A6B0CE37)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This removes some unused functions from the include files and removes 
some files which were manually copied from some kernel version.

1   2.6.25              [  OK  ]
2   2.6.26              [  OK  ]
3   2.6.27              [  OK  ]
4   2.6.28              [  OK  ]
5   2.6.29              [  OK  ]
6   2.6.30              [  OK  ]
7   2.6.31              [  OK  ]
8   2.6.32              [  OK  ]
9   2.6.33              [  OK  ]
10  2.6.34              [  OK  ]
11  2.6.35              [  OK  ]
12  2.6.36              [  OK  ]
13  2.6.37              [  OK  ]
14  2.6.38              [  OK  ]
15  2.6.39              [  OK  ]
16  3.0.101             [  OK  ]
17  3.1.10              [  OK  ]
18  3.10.20             [  OK  ]
19  3.11.9              [  OK  ]
20  3.12.1              [  OK  ]
21  3.13-rc1            [  OK  ]
22  3.2.52              [  OK  ]
23  3.3.8               [  OK  ]
24  3.4.70              [  OK  ]
25  3.5.7               [  OK  ]
26  3.6.11              [  OK  ]
27  3.7.10              [  OK  ]
28  3.8.13              [  OK  ]
29  3.9.11              [  OK  ]


Hauke Mehrtens (15):
  backports: remove mdio driver code
  backports: remove eeprom_93cx6.h header
  backports: remove acpi_video_register_with_quirks()
  backports: remove atomic_inc_not_zero_hint()
  backports: remove irq_set_affinity_hint()
  backports: remove efi
  backports: remove ethtool_rxfh_indir_default()
  backports: remove fb_enable_skip_vt_switch()
  backports: remove vlan_hw_offload_capable()
  backports: remove hex_byte_pack()
  backports: remove kref_get_unless_zero()
  backports: remove usb_unlink_anchored_urbs()
  backports: remove backport/backport-include/linux/vgaarb.h
  backports: remove own version of include/linux/wireless.h
  backports: remove own version of include/linux/unaligned/*.h

 backport/backport-include/acpi/video.h             |   13 -
 backport/backport-include/linux/atomic.h           |   34 -
 backport/backport-include/linux/cpumask.h          |   10 -
 backport/backport-include/linux/eeprom_93cx6.h     |   10 +
 backport/backport-include/linux/efi.h              |   66 --
 backport/backport-include/linux/ethtool.h          |    8 -
 backport/backport-include/linux/fb.h               |   48 -
 backport/backport-include/linux/if_vlan.h          |    7 -
 backport/backport-include/linux/interrupt.h        |   16 -
 backport/backport-include/linux/kernel.h           |   20 -
 backport/backport-include/linux/kref.h             |   26 -
 backport/backport-include/linux/mdio.h             |   17 -
 .../backport-include/linux/unaligned/access_ok.h   |   67 --
 .../linux/unaligned/be_byteshift.h                 |   70 --
 .../backport-include/linux/unaligned/be_memmove.h  |   36 -
 .../backport-include/linux/unaligned/be_struct.h   |   36 -
 .../backport-include/linux/unaligned/generic.h     |   68 --
 .../linux/unaligned/le_byteshift.h                 |   70 --
 .../backport-include/linux/unaligned/le_memmove.h  |   36 -
 .../backport-include/linux/unaligned/le_struct.h   |   36 -
 .../backport-include/linux/unaligned/memmove.h     |   45 -
 .../linux/unaligned/packed_struct.h                |   46 -
 backport/backport-include/linux/usb.h              |    2 -
 backport/backport-include/linux/vgaarb.h           |   10 -
 backport/backport-include/linux/wireless.h         | 1162 --------------------
 backport/compat/compat-2.6.26.c                    |    3 -
 backport/compat/compat-2.6.36.c                    |   23 -
 copy-list                                          |    7 +-
 28 files changed, 13 insertions(+), 1979 deletions(-)
 delete mode 100644 backport/backport-include/acpi/video.h
 delete mode 100644 backport/backport-include/linux/cpumask.h
 create mode 100644 backport/backport-include/linux/eeprom_93cx6.h
 delete mode 100644 backport/backport-include/linux/efi.h
 delete mode 100644 backport/backport-include/linux/fb.h
 delete mode 100644 backport/backport-include/linux/kref.h
 delete mode 100644 backport/backport-include/linux/mdio.h
 delete mode 100644 backport/backport-include/linux/unaligned/access_ok.h
 delete mode 100644 backport/backport-include/linux/unaligned/be_byteshift.h
 delete mode 100644 backport/backport-include/linux/unaligned/be_memmove.h
 delete mode 100644 backport/backport-include/linux/unaligned/be_struct.h
 delete mode 100644 backport/backport-include/linux/unaligned/generic.h
 delete mode 100644 backport/backport-include/linux/unaligned/le_byteshift.h
 delete mode 100644 backport/backport-include/linux/unaligned/le_memmove.h
 delete mode 100644 backport/backport-include/linux/unaligned/le_struct.h
 delete mode 100644 backport/backport-include/linux/unaligned/memmove.h
 delete mode 100644 backport/backport-include/linux/unaligned/packed_struct.h
 delete mode 100644 backport/backport-include/linux/vgaarb.h
 delete mode 100644 backport/backport-include/linux/wireless.h

-- 
1.7.10.4

