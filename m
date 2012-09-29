Return-Path: <mcgrof@gmail.com>
Sender: "Luis R. Rodriguez" <mcgrof@gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Jason Baron <jbaron@redhat.com>,
	Roland McGrath <roland@hack.frob.com>,
	Chris Metcalf <cmetcalf@tilera.com>,
	Avi Kivity <avi@redhat.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Richard Henderson <rth@twiddle.net>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	Helge Deller <deller@gmx.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/3] compat: backport definition of VM_NODUMP and VM_DONTDUMP
Date: Fri, 28 Sep 2012 23:38:24 -0700
Message-Id: <1348900705-12431-3-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1348900705-12431-1-git-send-email-mcgrof@do-not-panic.com>
References: <1348900705-12431-1-git-send-email-mcgrof@do-not-panic.com>
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

Commit accb61fe defined and added VM_NODUMP so we backport that
but later VM_NODUMP was renamed to VM_DONTDUMP via commit cdaaa7003.
We backport that definition declaration as well. Note though that
commit 909af768e removed the usage of the same bit field and it
was used previously for VM_ALWAYSDUMP... given that we want to
backport support for it but we can't we make this flag now a no-op
for older kernels.

Usage of VM_NODUMP or VM_DONTDUMP on older kernels will simply yield
in a no-op for memory regions.

mcgrof@frijol ~/linux-next (git::master)$ git describe --contains \
	909af768e88867016f427264ae39d27a57b6a8ed
v3.4-rc1~109^2~7

commit 909af768e88867016f427264ae39d27a57b6a8ed
Author: Jason Baron <jbaron@redhat.com>
Date:   Fri Mar 23 15:02:51 2012 -0700

    coredump: remove VM_ALWAYSDUMP flag

    The motivation for this patchset was that I was looking at a way for a
    qemu-kvm process, to exclude the guest memory from its core dump, which
    can be quite large.  There are already a number of filter flags in
    /proc/<pid>/coredump_filter, however, these allow one to specify 'types'
    of kernel memory, not specific address ranges (which is needed in this
    case).

    Since there are no more vma flags available, the first patch eliminates
    the need for the 'VM_ALWAYSDUMP' flag.  The flag is used internally by
    the kernel to mark vdso and vsyscall pages.  However, it is simple
    enough to check if a vma covers a vdso or vsyscall page without the need
    for this flag.

    The second patch then replaces the 'VM_ALWAYSDUMP' flag with a new
    'VM_NODUMP' flag, which can be set by userspace using new madvise flags:
    'MADV_DONTDUMP', and unset via 'MADV_DODUMP'.  The core dump filters
    continue to work the same as before unless 'MADV_DONTDUMP' is set on the
    region.

    The qemu code which implements this features is at:

      http://people.redhat.com/~jbaron/qemu-dump/qemu-dump.patch

    In my testing the qemu core dump shrunk from 383MB -> 13MB with this
    patch.

    I also believe that the 'MADV_DONTDUMP' flag might be useful for
    security sensitive apps, which might want to select which areas are
    dumped.

    This patch:

    The VM_ALWAYSDUMP flag is currently used by the coredump code to
    indicate that a vma is part of a vsyscall or vdso section.  However, we
    can determine if a vma is in one these sections by checking it against
    the gate_vma and checking for a non-NULL return value from
    arch_vma_name().  Thus, freeing a valuable vma bit.

    Signed-off-by: Jason Baron <jbaron@redhat.com>
    Acked-by: Roland McGrath <roland@hack.frob.com>
    Cc: Chris Metcalf <cmetcalf@tilera.com>
    Cc: Avi Kivity <avi@redhat.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

mcgrof@frijol ~/linux-next (git::master)$ git describe --contains accb61fe
v3.4-rc1~109^2~6

commit accb61fe7bb0f5c2a4102239e4981650f9048519
Author: Jason Baron <jbaron@redhat.com>
Date:   Fri Mar 23 15:02:51 2012 -0700

    coredump: add VM_NODUMP, MADV_NODUMP, MADV_CLEAR_NODUMP

    Since we no longer need the VM_ALWAYSDUMP flag, let's use the freed bit
    for 'VM_NODUMP' flag.  The idea is is to add a new madvise() flag:
    MADV_DONTDUMP, which can be set by applications to specifically request
    memory regions which should not dump core.

    The specific application I have in mind is qemu: we can add a flag there
    that wouldn't dump all of guest memory when qemu dumps core.  This flag
    might also be useful for security sensitive apps that want to absolutely
    make sure that parts of memory are not dumped.  To clear the flag use:
    MADV_DODUMP.

    [akpm@linux-foundation.org: s/MADV_NODUMP/MADV_DONTDUMP/, s/MADV_CLEAR_NODUMP/MADV_DODUMP/, per Roland]
    [akpm@linux-foundation.org: fix up the architectures which broke]
    Signed-off-by: Jason Baron <jbaron@redhat.com>
    Acked-by: Roland McGrath <roland@hack.frob.com>
    Cc: Chris Metcalf <cmetcalf@tilera.com>
    Cc: Avi Kivity <avi@redhat.com>
    Cc: Ralf Baechle <ralf@linux-mips.org>
    Cc: Richard Henderson <rth@twiddle.net>
    Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
    Cc: Matt Turner <mattst88@gmail.com>
    Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
    Cc: Helge Deller <deller@gmx.de>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

VM_NODUMP was renamed to VM_DONTDUMP so for older kernels
just use the old declaration. This commit is not yet on
Linus' tree so in linux-next we trust it will be on v3.7-rc1.

commit cdaaa7003e855fb50be3a566ac8ef96c6ff138cd
Author: Konstantin Khlebnikov <khlebnikov@openvz.org>
Date:   Wed Sep 26 11:33:12 2012 +1000

    mm: prepare VM_DONTDUMP for using in drivers

    Rename VM_NODUMP into VM_DONTDUMP: this name matches other negative flags:
    VM_DONTEXPAND, VM_DONTCOPY.  Currently this flag used only for
    sys_madvise.  The next patch will use it for replacing the outdated flag
    VM_RESERVED.

    Also forbid madvise(MADV_DODUMP) for special kernel mappings VM_SPECIAL
    (VM_IO | VM_DONTEXPAND | VM_RESERVED | VM_PFNMAP)

    Signed-off-by: Konstantin Khlebnikov <khlebnikov@openvz.org>
    Cc: Alexander Viro <viro@zeniv.linux.org.uk>
    Cc: Carsten Otte <cotte@de.ibm.com>
    Cc: Chris Metcalf <cmetcalf@tilera.com>
    Cc: Cyrill Gorcunov <gorcunov@openvz.org>
    Cc: Eric Paris <eparis@redhat.com>
    Cc: H. Peter Anvin <hpa@zytor.com>
    Cc: Hugh Dickins <hughd@google.com>
    Cc: Ingo Molnar <mingo@redhat.com>
    Cc: James Morris <james.l.morris@oracle.com>
    Cc: Jason Baron <jbaron@redhat.com>
    Cc: Kentaro Takeda <takedakn@nttdata.co.jp>
    Cc: Matt Helsley <matthltc@us.ibm.com>
    Cc: Nick Piggin <npiggin@kernel.dk>
    Cc: Oleg Nesterov <oleg@redhat.com>
    Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
    Cc: Robert Richter <robert.richter@amd.com>
    Cc: Suresh Siddha <suresh.b.siddha@intel.com>
    Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    Cc: Venkatesh Pallipadi <venki@google.com>
    Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Cc: Jason Baron <jbaron@redhat.com>
Cc: Roland McGrath <roland@hack.frob.com>
Cc: Chris Metcalf <cmetcalf@tilera.com>
Cc: Avi Kivity <avi@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
Cc: Helge Deller <deller@gmx.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 include/linux/compat-3.4.h |   11 +++++++++++
 include/linux/compat-3.7.h |    3 +++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/compat-3.4.h b/include/linux/compat-3.4.h
index 07bfa53..887293d 100644
--- a/include/linux/compat-3.4.h
+++ b/include/linux/compat-3.4.h
@@ -5,6 +5,17 @@
 
 #if (LINUX_VERSION_CODE < KERNEL_VERSION(3,4,0))
 
+/*
+ * defined here to allow things to compile but technically
+ * using this for memory regions will yield in a no-op on newer
+ * kernels but on older kernels (v3.3 and older) this bit was used
+ * for VM_ALWAYSDUMP. The goal was to remove this bit moving forward
+ * and since we can't skip the core dump on old kernels we just make
+ * this bit name now a no-op.
+ *
+ * For details see commits: 909af7 accb61fe cdaaa7003
+ */
+#define VM_NODUMP      0x0
 
 /* This backports:
  *
diff --git a/include/linux/compat-3.7.h b/include/linux/compat-3.7.h
index e4e126c..80c2aad 100644
--- a/include/linux/compat-3.7.h
+++ b/include/linux/compat-3.7.h
@@ -9,6 +9,9 @@
 #include <linux/tty.h>
 #include <linux/pci.h>
 #include <linux/pci_regs.h>
+#include <linux/mm.h>
+
+#define VM_DONTDUMP    VM_NODUMP
 
 #define netlink_notify_portid(__notify) (__notify->pid)
 #define genl_info_snd_portid(__genl_info) (__genl_info->snd_pid)
-- 
1.7.10.4
