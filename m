Return-Path: <mcgrof@gmail.com>
Sender: "Luis R. Rodriguez" <mcgrof@gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 0/3] compat: drm updates for next-20120926
Date: Fri, 28 Sep 2012 23:38:22 -0700
Message-Id: <1348900705-12431-1-git-send-email-mcgrof@do-not-panic.com>
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

I've decided to enable DRM drivers by default starting with
i915. Turns out that to enable that there were a slew of a few
more collatera evolutions which required backporting as well
as some other changes to compat-drivers. This and the
compat-drivers series addresses those changes.

Luis R. Rodriguez (3):
  compat: backport uidgid.h kuid_t and kgid_t addition
  compat: backport definition of VM_NODUMP and VM_DONTDUMP
  compat: backport seq_file's user namespace addition

 compat/Makefile            |    3 +
 compat/compat-3.5.c        |   30 +++++++
 compat/user_namespace.c    |   68 +++++++++++++++
 include/linux/compat-2.6.h |    1 +
 include/linux/compat-3.4.h |   11 +++
 include/linux/compat-3.7.h |   30 +++++++
 include/linux/uidgid.h     |  205 ++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 348 insertions(+)
 create mode 100644 compat/compat-3.5.c
 create mode 100644 compat/user_namespace.c
 create mode 100644 include/linux/uidgid.h

-- 
1.7.10.4
