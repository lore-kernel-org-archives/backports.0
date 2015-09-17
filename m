Return-path: <backports-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1998 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751702AbbIQVra (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 17 Sep 2015 17:47:30 -0400
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: backports@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH RFC 0/2] addition of audio to backports
Date: Thu, 17 Sep 2015 16:47:15 -0500
Message-Id: <1442526437-22392-1-git-send-email-pierre-louis.bossart@linux.intel.com> (sfid-20150917_234732_592144_C7860558)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

First pass (compile-tested only) to get feedback before next steps.
All drivers for PCI, USB, SPI, Firewire compile on a 3.13 kernel 
HDAudio and Asoc need more work
The first patch adds the needed dependencies and fixes.
The second patch adds the means to enable audio in a local copy

KNOWN ISSUES/LIMITATIONS:
0. the copylist has issues with bluetooth backport unrelated to audio, this 
would be fixed when the master branch works.
1. HDaudio will not work due to a dependency on DRM/i915. It's probably not
possible to support HDMI in the backport
2. ASoC drivers have issues with DMA, GPIO, DSD/OF properties
3. no default config was added.

TODO:
0. take feedback into account
1. look into known limitations
2. find a more elegant way to comment out sound/core.h and sound/pcm.h
3. implement backport for hrtimer_resolution
4. try with older kernels with ckmake (?)

Pierre-Louis Bossart (2):
  Add required changes for audio packports
  add script to enable audio backport

 backport/Kconfig.sources                           |   2 +
 backport/Makefile.kernel                           |   2 +
 backport/backport-include/linux/firewire.h         |  12 +
 backport/backport-include/linux/genalloc.h         |   9 +
 backport/backport-include/linux/hrtimer.h          |  12 +
 backport/backport-include/linux/skbuff.h           |   2 +
 backport/backport-include/linux/uio.h              | 246 +++++++++++++++++++++
 copy-list.patch                                    |  37 ++++
 dependencies                                       |   2 +
 enable-audio.sh                                    |   3 +
 .../sound/0001-pcm-native-fix-v41-changes.patch    | 128 +++++++++++
 patches/collateral-evolutions/sound/README         |   1 +
 sound_headers.patch                                |  38 ++++
 13 files changed, 494 insertions(+)
 create mode 100644 backport/backport-include/linux/firewire.h
 create mode 100644 backport/backport-include/linux/genalloc.h
 create mode 100644 backport/backport-include/linux/hrtimer.h
 create mode 100644 backport/backport-include/linux/uio.h
 create mode 100644 copy-list.patch
 create mode 100644 enable-audio.sh
 create mode 100644 patches/collateral-evolutions/sound/0001-pcm-native-fix-v41-changes.patch
 create mode 100644 patches/collateral-evolutions/sound/README
 create mode 100644 sound_headers.patch

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
