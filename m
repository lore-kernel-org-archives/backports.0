Return-Path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/8] compat-drivers: little fixes
Date: Tue,  6 Nov 2012 00:11:47 +0100
Message-Id: <1352157115-13469-1-git-send-email-hauke@hauke-m.de>
List-ID: <backports@vger.kernel.org>

Some small enhancements and missing or removed config options.

Hauke Mehrtens (8):
  compat-drivers: remove CONFIG_ATH9K_PKTLOG form config.mk
  compat-drivers: activate CONFIG_BT_HCIUART_3WIRE in config.mk
  compat-drivers: add CONFIG_BT_WILINK in config.mk
  compat-drviers: remove CONFIG_IWM from config.mk
  compat-drivers: remove CONFIG_WIL6210 from config.mk
  compat-drivers: add CONFIG_RT2800PCI_RT3290 in config.mk
  compat-drivers: add CONFIG_MWIFIEX_USB in config.mk
  compat-drivers: rename drm config symbols

 config.mk                                  |   17 ++--
 patches/drm/06-rename-config-options.patch |  122 ++++++++++++++++++++++++----
 patches/network/06-header-changes.patch    |   10 +++
 3 files changed, 121 insertions(+), 28 deletions(-)

-- 
1.7.10.4
