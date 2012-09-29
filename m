Return-Path: <mcgrof@gmail.com>
Sender: "Luis R. Rodriguez" <mcgrof@gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 0/5] compat-drivers: drm driver updates - enable i915
Date: Fri, 28 Sep 2012 23:54:41 -0700
Message-Id: <1348901686-15036-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

This series addresses enabling the i915 driver by default.
This is now run time tested against the Debian 3.2.0-3-amd64
kernel. Direct rendering work and glxgears gives me:

 3274 frames in 5.0 seconds = 654.724 FPS

I've also tesed suspend / resume and it is alive and well
still.

mcgrof@frijol ~/devel/compat-drivers (git::master)$ glxinfo | grep direct
direct rendering: Yes

If you want to disable drm you can just specify "network" to
admin-update.sh as follows:

./scripts/admin-update.sh network

This will skip pulling in drm code from the $GIT_TREE.

It would be great for other users to enabe other DRM driver
to test and if it succeeds we can start enabling them. For
now we only enable i915 as that is the only one that has
been run time tested. I should note that this should work
against 3.0 but I've only run time tested this against 3.2
so far. Testers wishing to help test this on 3.1 and 3.0 are
welcomed.

If you only want to test building drm drivers you can specify:

./scripts/driver-select drm

before compiling. This has all been tested against cmake.

mcgrof@garbanzo ~/staging/drm/compat-drivers-2012-09-26 $ time ckmake
Trying kernel 3.5.0-030500-generic [OK]
Trying kernel 3.4.4-030404-generic [OK]
Trying kernel 3.3.7-030307-generic [OK]
Trying kernel 3.2.2-030202-generic [OK]
Trying kernel 3.1.10-030110-generic [OK]
Trying kernel 3.0.18-030018-generic [OK]
Trying kernel 2.6.39-02063904-generic [OK]
Trying kernel 2.6.38-02063808-generic [OK]
Trying kernel 2.6.37-02063706-generic [OK]
Trying kernel 2.6.36-02063604-generic [OK]
Trying kernel 2.6.35-02063512-generic [OK]
Trying kernel 2.6.34-02063410-generic [OK]
Trying kernel 2.6.33-02063305-generic [OK]
Trying kernel 2.6.32-02063255-generic [OK]
Trying kernel 2.6.31-02063113-generic [OK]
Trying kernel 2.6.30-02063010-generic [OK]
Trying kernel 2.6.29-02062906-generic [OK]
Trying kernel 2.6.28-02062810-generic [OK]
Trying kernel 2.6.27-020627-generic [OK]
Trying kernel 2.6.26-020626-generic [OK]
Trying kernel 2.6.25-020625-generic [OK]
Trying kernel 2.6.24-020624-generic [OK]

real    27m41.522s
user    145m17.725s
sys     14m13.617s

Luis R. Rodriguez (5):
  compat-drivers: separate NOSTDINC_FLAGS include dir lines
  compat-drivers: force using include/drm for header namespace
  compat-drivers: address usage of intel_enable_gtt() for i915
  compat-drivers: backport usage of shmem_truncate_range() on i915
  compat-drivers: enable DRM drivers compilation

 Makefile                                   |    5 +-
 config.mk                                  |    9 +++-
 patches/drm/06-rename-config-options.patch |   77 ++++++++++++++++++++++++++++
 patches/drm/07-intel-gtt.patch             |   37 +++++++++++++
 patches/drm/08-shmem_truncate_range.patch  |   44 ++++++++++++++++
 patches/drm/99-change-makefile.patch       |   44 ++++++++--------
 scripts/admin-update.sh                    |    3 +-
 scripts/driver-select                      |   28 ++++++++++
 8 files changed, 222 insertions(+), 25 deletions(-)
 create mode 100644 patches/drm/06-rename-config-options.patch
 create mode 100644 patches/drm/07-intel-gtt.patch
 create mode 100644 patches/drm/08-shmem_truncate_range.patch

-- 
1.7.10.4
