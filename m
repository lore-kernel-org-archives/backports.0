Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0B055C1A
	for <backports@vger.kernel.org>; Mon,  1 Apr 2024 22:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712009037; cv=none; b=ceETPLgqF93vFesLZ9IVycmF8lajIvDPtUn3SWIdaS0Lp+p11I6a0djxFY4/z+rwsTJrECblRcSgKy5tHR8l1vuRQLelSd7kY1OuRgfpGsNU5DV5TgzVblxoxiqdUwXuB1F2izr+7pvKutkJXLd9HsdIZ0qXxYs79rpaUkXXnx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712009037; c=relaxed/simple;
	bh=rq1zifcsbbf2mIJXDoYHtejJztN5+JwYon8XaddDcMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L3EY95Fyt+0BBFCkd1cq866SScClmoNN/po7OhQl/QDfBx4fCGSGYNjL3FP7MTon9xfgrimm0B+3VR/rFxq0RaUBmdqaZ3b71d9+q+mGlyiJMpDFCR7XsGldxu8B0BV7n7FoJVWOQ1DgcZb362xCJoAMD4VcVblC5EC52+Tx8nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=IYJ/3AHp; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="IYJ/3AHp"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4V7lQV5tS0z9shL;
	Tue,  2 Apr 2024 00:03:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1712009026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wUoPO5NtJc5S1hiZFrd5q0KKe9Sul+2ZLudFHzDzetQ=;
	b=IYJ/3AHpMjmdLGTiE0H1aD7f2rWvBc9QrrvyjjVCV5KZCJGiEV6kcSnsisTWloLnNiH8cE
	ekARCpFrNHIhiqn/dN6j03cVzMj9/jLk3tbok/mVxAxog3anMd0t4cwBHEew9NuCFYzuts
	Lz7IdtIDhrJwEzZcnosfwZYqICEv19lw1s2MGHmg1ITi8dClWSPK17R84y0Ifr7dCMGETE
	5qSDD6/gzP8DHxj55e1sWPEnkGJEnEAd2ycBbei8pVyAjgYMGS3La9PsPmwyPW2+CTVhDX
	aKzURyKlZPcGX0zlJf0Ufhq0mViY4G36zysAD7Tg1vAlS3VQ3xCwSgHeVDAMEA==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 00/10] backports: Remove support for kernel older than 4.14
Date: Tue,  2 Apr 2024 00:03:04 +0200
Message-ID: <20240401220314.2434455-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4V7lQV5tS0z9shL

Remove support for older kernel versions to make maintenance of backports easier in
the future.

Hauke Mehrtens (10):
  backports: Remove support for kernel smaller than 4.5
  backports: Remove support for kernel smaller than 4.6
  backports: Remove support for kernel smaller than 4.7
  backports: Remove support for kernel smaller than 4.8
  backports: Remove support for kernel smaller than 4.9
  backports: Remove support for kernel smaller than 4.10
  backports: Remove support for kernel smaller than 4.11
  backports: Remove support for kernel smaller than 4.12
  backports: Remove support for kernel smaller than 4.13
  backports: Remove support for kernel smaller than 4.14

 .github/workflows/create.yml                  |  10 -
 README                                        |   2 +-
 backport/backport-include/acpi/acpi_bus.h     |  15 -
 backport/backport-include/crypto/hash.h       |  38 ---
 backport/backport-include/linux/acpi.h        |  15 -
 backport/backport-include/linux/atomic.h      |  48 ---
 backport/backport-include/linux/bits.h        |   4 +-
 backport/backport-include/linux/build_bug.h   |   4 -
 backport/backport-include/linux/debugfs.h     |  14 -
 backport/backport-include/linux/devcoredump.h |  30 --
 backport/backport-include/linux/etherdevice.h |  41 ---
 backport/backport-include/linux/fs.h          |   5 -
 backport/backport-include/linux/gfp.h         |  25 --
 backport/backport-include/linux/interrupt.h   |  40 ---
 backport/backport-include/linux/io.h          |   5 -
 backport/backport-include/linux/kcov.h        |   2 -
 backport/backport-include/linux/kernel.h      |  44 ---
 backport/backport-include/linux/leds.h        |  29 --
 backport/backport-include/linux/mii.h         |  14 -
 backport/backport-include/linux/mm.h          |  42 ---
 backport/backport-include/linux/netdevice.h   |  73 +----
 backport/backport-include/linux/netlink.h     |  47 ---
 backport/backport-include/linux/nospec.h      |   4 +-
 backport/backport-include/linux/of_device.h   |   5 +-
 backport/backport-include/linux/page_ref.h    |  25 --
 backport/backport-include/linux/pci.h         |  50 ----
 backport/backport-include/linux/phy.h         |  65 -----
 backport/backport-include/linux/random.h      |  14 -
 backport/backport-include/linux/rbtree.h      |  59 ----
 backport/backport-include/linux/rhashtable.h  |  31 --
 backport/backport-include/linux/sched.h       |   7 -
 backport/backport-include/linux/skbuff.h      |  66 +----
 backport/backport-include/linux/string.h      |  15 -
 backport/backport-include/linux/thermal.h     |  23 --
 backport/backport-include/linux/time.h        |   8 -
 backport/backport-include/linux/usb.h         |  10 -
 backport/backport-include/linux/usb/cdc.h     |  61 ----
 backport/backport-include/linux/usb/ch9.h     |  12 -
 backport/backport-include/linux/uuid.h        |  34 ---
 .../backport-include/linux/verification.h     |   4 +-
 .../backport-include/linux/virtio_config.h    |  31 --
 backport/backport-include/linux/wait.h        |  25 --
 backport/backport-include/net/genetlink.h     |  49 ----
 backport/backport-include/net/ipv6.h          |  25 --
 backport/backport-include/net/iw_handler.h    |  11 -
 backport/backport-include/net/netlink.h       | 200 -------------
 backport/backport-include/net/sock.h          |  17 --
 backport/compat/Kconfig                       |  18 --
 backport/compat/Makefile                      |   7 -
 backport/compat/backport-4.10.c               | 274 ------------------
 backport/compat/backport-4.11.c               |  12 -
 backport/compat/backport-4.12.c               |  94 ------
 backport/compat/backport-4.5.c                | 165 -----------
 backport/compat/backport-4.6.c                | 103 -------
 backport/compat/backport-4.7.c                | 176 -----------
 backport/compat/backport-4.8.c                | 196 -------------
 backport/compat/backport-5.15.c               |   2 -
 backport/compat/backport-genetlink.c          | 170 +----------
 dependencies                                  |  14 -
 patches/0002-gpio-parent.cocci                |  25 --
 .../0013-fix-makefile-includes/brcmfmac.patch |  13 -
 patches/0013-fix-makefile-includes/mt76.patch |  22 --
 .../0013-fix-makefile-includes/wilc1000.patch |  24 +-
 patches/0067-mdio-addr.cocci                  |   5 -
 patches/0073-netdevice-mtu-range.cocci        | 100 -------
 patches/0074-netdevice-mtu-range-ifdefs.cocci |  26 --
 patches/0075-ndo-stats-64.cocci               |  32 --
 patches/0077-genl-ro-after-init/hwsim.patch   |  11 -
 patches/0077-genl-ro-after-init/nl80211.patch |  11 -
 patches/0078-genl-extack.cocci                |  12 -
 patches/0079-netdev-destructor.cocci          | 116 --------
 patches/0079-netdev-destructor/brcmfmac.patch |  38 ---
 patches/0080-i2c-proble-new.cocci             |  25 --
 patches/0082-pci_error_handlers.cocci         |  32 --
 patches/0095-spi-delay/wilc1000.patch         |   6 +-
 75 files changed, 14 insertions(+), 3113 deletions(-)
 delete mode 100644 backport/backport-include/acpi/acpi_bus.h
 delete mode 100644 backport/backport-include/crypto/hash.h
 delete mode 100644 backport/backport-include/linux/acpi.h
 delete mode 100644 backport/backport-include/linux/devcoredump.h
 delete mode 100644 backport/backport-include/linux/etherdevice.h
 delete mode 100644 backport/backport-include/linux/gfp.h
 delete mode 100644 backport/backport-include/linux/kernel.h
 delete mode 100644 backport/backport-include/linux/leds.h
 delete mode 100644 backport/backport-include/linux/mii.h
 delete mode 100644 backport/backport-include/linux/page_ref.h
 delete mode 100644 backport/backport-include/linux/phy.h
 delete mode 100644 backport/backport-include/linux/random.h
 delete mode 100644 backport/backport-include/linux/rbtree.h
 delete mode 100644 backport/backport-include/linux/rhashtable.h
 delete mode 100644 backport/backport-include/linux/string.h
 delete mode 100644 backport/backport-include/linux/usb/cdc.h
 delete mode 100644 backport/backport-include/linux/usb/ch9.h
 delete mode 100644 backport/backport-include/linux/uuid.h
 delete mode 100644 backport/backport-include/linux/virtio_config.h
 delete mode 100644 backport/backport-include/linux/wait.h
 delete mode 100644 backport/backport-include/net/ipv6.h
 delete mode 100644 backport/backport-include/net/iw_handler.h
 delete mode 100644 backport/compat/backport-4.10.c
 delete mode 100644 backport/compat/backport-4.11.c
 delete mode 100644 backport/compat/backport-4.12.c
 delete mode 100644 backport/compat/backport-4.5.c
 delete mode 100644 backport/compat/backport-4.6.c
 delete mode 100644 backport/compat/backport-4.7.c
 delete mode 100644 backport/compat/backport-4.8.c
 delete mode 100644 patches/0002-gpio-parent.cocci
 delete mode 100644 patches/0013-fix-makefile-includes/brcmfmac.patch
 delete mode 100644 patches/0067-mdio-addr.cocci
 delete mode 100644 patches/0073-netdevice-mtu-range.cocci
 delete mode 100644 patches/0074-netdevice-mtu-range-ifdefs.cocci
 delete mode 100644 patches/0075-ndo-stats-64.cocci
 delete mode 100644 patches/0077-genl-ro-after-init/hwsim.patch
 delete mode 100644 patches/0077-genl-ro-after-init/nl80211.patch
 delete mode 100644 patches/0079-netdev-destructor.cocci
 delete mode 100644 patches/0079-netdev-destructor/brcmfmac.patch
 delete mode 100644 patches/0080-i2c-proble-new.cocci
 delete mode 100644 patches/0082-pci_error_handlers.cocci

-- 
2.44.0

