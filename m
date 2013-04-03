Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:43734 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755729Ab3DCEdA (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 3 Apr 2013 00:33:00 -0400
Received: by mail-pa0-f48.google.com with SMTP id lj1so673645pab.35
        for <backports@vger.kernel.org>; Tue, 02 Apr 2013 21:32:59 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 1/2] compat: backport dma-buf
Date: Tue,  2 Apr 2013 21:32:45 -0700
Message-Id: <1364963566-31377-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20130403_063303_416032_D8770E9E)
In-Reply-To: <1364963566-31377-1-git-send-email-mcgrof@do-not-panic.com>
References: <1364963566-31377-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

dma-buf was added via commit d15bd7ee on v3.3 but completed
in a more sound fassion in later kernels, you should preferably
be at v3.5 a least, so we take the latest dma-buf implementation
and port it for usage on kernels [3.0-3.4]. We take the
implementation as of next-20130328.

This is implemented as a non modular solution upstream but
we can carry the implementation into our compat module.

Note that although commit f23513e8d was added on v2.6.23
that allowed the kernel to call get_unused_fd_flags(flags)
for O_CLOEXEC setting, this routine was not exported until
v3.7. dma-buf makes use of it, and since our backported
dma-buf implementation is modular it means we have to work
around the lack of get_unused_fd_flags() exported symbol
on older kernels. Due to the security concerns noted by
Ulrich on f23513e8 we need to ensure the operatin is
atomic so we fix this on our port of dma-buf for older
kernels by adding our own dma_buf_fd_set_flag() to be called
when dma_buf_fd() is used. This implementation is available
for usage on kernels >= 3.0. We disable it for v3.5 as
we're happy with that implementation.

mcgrof@frijol ~/linux-next (git::master)$ git describe --contains \
	d15bd7ee445d0702ad801fdaece348fdb79e6581
v3.3-rc1~161^2~2

mcgrof@frijol ~/linux-next (git::master)$ git describe --contains \
	f23513e8d96cf5e6cf8d2ff0cb5dd6bbc33995e4
v2.6.23-rc1~894

mcgrof@frijol ~/linux-stable (git::linux-3.2.y)$ git describe --contains \
	1a7bd226
v3.7-rc1~134^2~69

Carried over the implementation from linux-next next-20130328

commit d15bd7ee445d0702ad801fdaece348fdb79e6581
Author: Sumit Semwal <sumit.semwal@ti.com>
Date:   Mon Dec 26 14:53:15 2011 +0530

    dma-buf: Introduce dma buffer sharing mechanism

    This is the first step in defining a dma buffer sharing mechanism.

    A new buffer object dma_buf is added, with operations and API to allow easy
    sharing of this buffer object across devices.

    The framework allows:
    - creation of a buffer object, its association with a file pointer, and
       associated allocator-defined operations on that buffer. This operation is
       called the 'export' operation.
    - different devices to 'attach' themselves to this exported buffer object, to
      facilitate backing storage negotiation, using dma_buf_attach() API.
    - the exported buffer object to be shared with the other entity by asking for
       its 'file-descriptor (fd)', and sharing the fd across.
    - a received fd to get the buffer object back, where it can be accessed using
       the associated exporter-defined operations.
    - the exporter and user to share the scatterlist associated with this buffer
       object using map_dma_buf and unmap_dma_buf operations.

    Atleast one 'attach()' call is required to be made prior to calling the
    map_dma_buf() operation.

    Couple of building blocks in map_dma_buf() are added to ease introduction
    of sync'ing across exporter and users, and late allocation by the exporter.

    For this first version, this framework will work with certain conditions:
    - *ONLY* exporter will be allowed to mmap to userspace (outside of this
       framework - mmap is not a buffer object operation),
    - currently, *ONLY* users that do not need CPU access to the buffer are
       allowed.

    More details are there in the documentation patch.

    This is based on design suggestions from many people at the mini-summits[1],
    most notably from Arnd Bergmann <arnd@arndb.de>, Rob Clark <rob@ti.com> and
    Daniel Vetter <daniel@ffwll.ch>.

    The implementation is inspired from proof-of-concept patch-set from
    Tomasz Stanislawski <t.stanislaws@samsung.com>, who demonstrated buffer sharing
    between two v4l2 devices. [2]

    [1]: https://wiki.linaro.org/OfficeofCTO/MemoryManagement
    [2]: http://lwn.net/Articles/454389

    Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
    Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
    Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
    Reviewed-by: Dave Airlie <airlied@redhat.com>
    Reviewed-and-Tested-by: Rob Clark <rob.clark@linaro.org>
    Signed-off-by: Dave Airlie <airlied@redhat.com>

Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/compat/Kconfig          |    9 +
 backport/compat/Makefile         |    1 +
 backport/compat/dma-buf.c        |  575 ++++++++++++++++++++++++++++++++++++++
 backport/include/linux/dma-buf.h |  211 ++++++++++++++
 4 files changed, 796 insertions(+)
 create mode 100644 backport/compat/dma-buf.c
 create mode 100644 backport/include/linux/dma-buf.h

diff --git a/backport/compat/Kconfig b/backport/compat/Kconfig
index 5a9b303..d1610b5 100644
--- a/backport/compat/Kconfig
+++ b/backport/compat/Kconfig
@@ -107,7 +107,16 @@ config BACKPORT_OPTION_USB_URB_THREAD_FIX
 config BACKPORT_MII
 	bool
 
+config BACKPORT_BUILD_DMA_SHARED_BUFFER
+	bool
+	depends on ANON_INODES
+	depends on !BACKPORT_KERNEL_3_0
+	depends on !DMA_SHARED_BUFFER || BACKPORT_KERNEL_3_5
+	default y if BACKPORT_DMA_SHARED_BUFFER
+	default y if BACKPORT_USERSEL_BUILD_ALL
 
+config BACKPORT_DMA_SHARED_BUFFER
+	bool
 
 config BACKPORT_USERSEL_BUILD_ALL
 	bool "Build all compat code"
diff --git a/backport/compat/Makefile b/backport/compat/Makefile
index 62dd531..e738e2f 100644
--- a/backport/compat/Makefile
+++ b/backport/compat/Makefile
@@ -4,6 +4,7 @@ ccflags-y += -DBACKPORTED_KERNEL_VERSION=\"$(BACKPORTED_KERNEL_VERSION)\"
 ccflags-y += -DBACKPORTED_KERNEL_NAME=\"$(BACKPORTED_KERNEL_NAME)\"
 obj-m += compat.o
 compat-y += main.o
+compat-$(CPTCFG_BACKPORT_BUILD_DMA_SHARED_BUFFER) += dma-buf.o
 
 obj-$(CPTCFG_BACKPORT_BUILD_FW_LOADER) += compat_firmware_class.o
 
diff --git a/backport/compat/dma-buf.c b/backport/compat/dma-buf.c
new file mode 100644
index 0000000..c7f7356
--- /dev/null
+++ b/backport/compat/dma-buf.c
@@ -0,0 +1,575 @@
+/*
+ * Framework for buffer objects that can be shared across devices/subsystems.
+ *
+ * Copyright(C) 2011 Linaro Limited. All rights reserved.
+ * Author: Sumit Semwal <sumit.semwal@ti.com>
+ *
+ * Many thanks to linaro-mm-sig list, and specially
+ * Arnd Bergmann <arnd@arndb.de>, Rob Clark <rob@ti.com> and
+ * Daniel Vetter <daniel@ffwll.ch> for their support in creation and
+ * refining of this idea.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/dma-buf.h>
+#include <linux/anon_inodes.h>
+#include <linux/export.h>
+#include <linux/file.h>
+#include <linux/fdtable.h>
+#include <linux/bitops.h>
+
+static inline int is_dma_buf_file(struct file *);
+
+static int dma_buf_release(struct inode *inode, struct file *file)
+{
+	struct dma_buf *dmabuf;
+
+	if (!is_dma_buf_file(file))
+		return -EINVAL;
+
+	dmabuf = file->private_data;
+
+	BUG_ON(dmabuf->vmapping_counter);
+
+	dmabuf->ops->release(dmabuf);
+	kfree(dmabuf);
+	return 0;
+}
+
+static int dma_buf_mmap_internal(struct file *file, struct vm_area_struct *vma)
+{
+	struct dma_buf *dmabuf;
+
+	if (!is_dma_buf_file(file))
+		return -EINVAL;
+
+	dmabuf = file->private_data;
+
+	/* check for overflowing the buffer's size */
+	if (vma->vm_pgoff + ((vma->vm_end - vma->vm_start) >> PAGE_SHIFT) >
+	    dmabuf->size >> PAGE_SHIFT)
+		return -EINVAL;
+
+	return dmabuf->ops->mmap(dmabuf, vma);
+}
+
+static const struct file_operations dma_buf_fops = {
+	.release	= dma_buf_release,
+	.mmap		= dma_buf_mmap_internal,
+};
+
+/*
+ * is_dma_buf_file - Check if struct file* is associated with dma_buf
+ */
+static inline int is_dma_buf_file(struct file *file)
+{
+	return file->f_op == &dma_buf_fops;
+}
+
+/**
+ * dma_buf_export - Creates a new dma_buf, and associates an anon file
+ * with this buffer, so it can be exported.
+ * Also connect the allocator specific data and ops to the buffer.
+ *
+ * @priv:	[in]	Attach private data of allocator to this buffer
+ * @ops:	[in]	Attach allocator-defined dma buf ops to the new buffer.
+ * @size:	[in]	Size of the buffer
+ * @flags:	[in]	mode flags for the file.
+ *
+ * Returns, on success, a newly created dma_buf object, which wraps the
+ * supplied private data and operations for dma_buf_ops. On either missing
+ * ops, or error in allocating struct dma_buf, will return negative error.
+ *
+ */
+struct dma_buf *dma_buf_export(void *priv, const struct dma_buf_ops *ops,
+				size_t size, int flags)
+{
+	struct dma_buf *dmabuf;
+	struct file *file;
+
+	if (WARN_ON(!priv || !ops
+			  || !ops->map_dma_buf
+			  || !ops->unmap_dma_buf
+			  || !ops->release
+			  || !ops->kmap_atomic
+			  || !ops->kmap
+			  || !ops->mmap)) {
+		return ERR_PTR(-EINVAL);
+	}
+
+	dmabuf = kzalloc(sizeof(struct dma_buf), GFP_KERNEL);
+	if (dmabuf == NULL)
+		return ERR_PTR(-ENOMEM);
+
+	dmabuf->priv = priv;
+	dmabuf->ops = ops;
+	dmabuf->size = size;
+
+	file = anon_inode_getfile("dmabuf", &dma_buf_fops, dmabuf, flags);
+
+	dmabuf->file = file;
+
+	mutex_init(&dmabuf->lock);
+	INIT_LIST_HEAD(&dmabuf->attachments);
+
+	return dmabuf;
+}
+EXPORT_SYMBOL_GPL(dma_buf_export);
+
+static void dma_buf_fd_set_flag(int fd, int flags)
+{
+	struct fdtable *fdt;
+	struct files_struct *files = current->files;
+
+	spin_lock(&files->file_lock);
+	fdt = files_fdtable(files);
+	if (flags & O_CLOEXEC)
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
+		__set_bit(fd, fdt->close_on_exec);
+#else
+		FD_SET(fd, fdt->close_on_exec);
+#endif
+	else
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,4,0))
+		__clear_bit(fd, fdt->close_on_exec);
+#else
+		FD_CLR(fd, fdt->close_on_exec);
+#endif
+	spin_unlock(&files->file_lock);
+}
+
+/**
+ * dma_buf_fd - returns a file descriptor for the given dma_buf
+ * @dmabuf:	[in]	pointer to dma_buf for which fd is required.
+ * @flags:      [in]    flags to give to fd
+ *
+ * On success, returns an associated 'fd'. Else, returns error.
+ */
+int dma_buf_fd(struct dma_buf *dmabuf, int flags)
+{
+	int fd;
+
+	if (!dmabuf || !dmabuf->file)
+		return -EINVAL;
+
+	fd = get_unused_fd();
+	if (fd < 0)
+		return fd;
+	dma_buf_fd_set_flag(fd, flags);
+
+	fd_install(fd, dmabuf->file);
+
+	return fd;
+}
+EXPORT_SYMBOL_GPL(dma_buf_fd);
+
+/**
+ * dma_buf_get - returns the dma_buf structure related to an fd
+ * @fd:	[in]	fd associated with the dma_buf to be returned
+ *
+ * On success, returns the dma_buf structure associated with an fd; uses
+ * file's refcounting done by fget to increase refcount. returns ERR_PTR
+ * otherwise.
+ */
+struct dma_buf *dma_buf_get(int fd)
+{
+	struct file *file;
+
+	file = fget(fd);
+
+	if (!file)
+		return ERR_PTR(-EBADF);
+
+	if (!is_dma_buf_file(file)) {
+		fput(file);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return file->private_data;
+}
+EXPORT_SYMBOL_GPL(dma_buf_get);
+
+/**
+ * dma_buf_put - decreases refcount of the buffer
+ * @dmabuf:	[in]	buffer to reduce refcount of
+ *
+ * Uses file's refcounting done implicitly by fput()
+ */
+void dma_buf_put(struct dma_buf *dmabuf)
+{
+	if (WARN_ON(!dmabuf || !dmabuf->file))
+		return;
+
+	fput(dmabuf->file);
+}
+EXPORT_SYMBOL_GPL(dma_buf_put);
+
+/**
+ * dma_buf_attach - Add the device to dma_buf's attachments list; optionally,
+ * calls attach() of dma_buf_ops to allow device-specific attach functionality
+ * @dmabuf:	[in]	buffer to attach device to.
+ * @dev:	[in]	device to be attached.
+ *
+ * Returns struct dma_buf_attachment * for this attachment; may return negative
+ * error codes.
+ *
+ */
+struct dma_buf_attachment *dma_buf_attach(struct dma_buf *dmabuf,
+					  struct device *dev)
+{
+	struct dma_buf_attachment *attach;
+	int ret;
+
+	if (WARN_ON(!dmabuf || !dev))
+		return ERR_PTR(-EINVAL);
+
+	attach = kzalloc(sizeof(struct dma_buf_attachment), GFP_KERNEL);
+	if (attach == NULL)
+		return ERR_PTR(-ENOMEM);
+
+	attach->dev = dev;
+	attach->dmabuf = dmabuf;
+
+	mutex_lock(&dmabuf->lock);
+
+	if (dmabuf->ops->attach) {
+		ret = dmabuf->ops->attach(dmabuf, dev, attach);
+		if (ret)
+			goto err_attach;
+	}
+	list_add(&attach->node, &dmabuf->attachments);
+
+	mutex_unlock(&dmabuf->lock);
+	return attach;
+
+err_attach:
+	kfree(attach);
+	mutex_unlock(&dmabuf->lock);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(dma_buf_attach);
+
+/**
+ * dma_buf_detach - Remove the given attachment from dmabuf's attachments list;
+ * optionally calls detach() of dma_buf_ops for device-specific detach
+ * @dmabuf:	[in]	buffer to detach from.
+ * @attach:	[in]	attachment to be detached; is free'd after this call.
+ *
+ */
+void dma_buf_detach(struct dma_buf *dmabuf, struct dma_buf_attachment *attach)
+{
+	if (WARN_ON(!dmabuf || !attach))
+		return;
+
+	mutex_lock(&dmabuf->lock);
+	list_del(&attach->node);
+	if (dmabuf->ops->detach)
+		dmabuf->ops->detach(dmabuf, attach);
+
+	mutex_unlock(&dmabuf->lock);
+	kfree(attach);
+}
+EXPORT_SYMBOL_GPL(dma_buf_detach);
+
+/**
+ * dma_buf_map_attachment - Returns the scatterlist table of the attachment;
+ * mapped into _device_ address space. Is a wrapper for map_dma_buf() of the
+ * dma_buf_ops.
+ * @attach:	[in]	attachment whose scatterlist is to be returned
+ * @direction:	[in]	direction of DMA transfer
+ *
+ * Returns sg_table containing the scatterlist to be returned; may return NULL
+ * or ERR_PTR.
+ *
+ */
+struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *attach,
+					enum dma_data_direction direction)
+{
+	struct sg_table *sg_table = ERR_PTR(-EINVAL);
+
+	might_sleep();
+
+	if (WARN_ON(!attach || !attach->dmabuf))
+		return ERR_PTR(-EINVAL);
+
+	sg_table = attach->dmabuf->ops->map_dma_buf(attach, direction);
+
+	return sg_table;
+}
+EXPORT_SYMBOL_GPL(dma_buf_map_attachment);
+
+/**
+ * dma_buf_unmap_attachment - unmaps and decreases usecount of the buffer;might
+ * deallocate the scatterlist associated. Is a wrapper for unmap_dma_buf() of
+ * dma_buf_ops.
+ * @attach:	[in]	attachment to unmap buffer from
+ * @sg_table:	[in]	scatterlist info of the buffer to unmap
+ * @direction:  [in]    direction of DMA transfer
+ *
+ */
+void dma_buf_unmap_attachment(struct dma_buf_attachment *attach,
+				struct sg_table *sg_table,
+				enum dma_data_direction direction)
+{
+	might_sleep();
+
+	if (WARN_ON(!attach || !attach->dmabuf || !sg_table))
+		return;
+
+	attach->dmabuf->ops->unmap_dma_buf(attach, sg_table,
+						direction);
+}
+EXPORT_SYMBOL_GPL(dma_buf_unmap_attachment);
+
+
+/**
+ * dma_buf_begin_cpu_access - Must be called before accessing a dma_buf from the
+ * cpu in the kernel context. Calls begin_cpu_access to allow exporter-specific
+ * preparations. Coherency is only guaranteed in the specified range for the
+ * specified access direction.
+ * @dmabuf:	[in]	buffer to prepare cpu access for.
+ * @start:	[in]	start of range for cpu access.
+ * @len:	[in]	length of range for cpu access.
+ * @direction:	[in]	length of range for cpu access.
+ *
+ * Can return negative error values, returns 0 on success.
+ */
+int dma_buf_begin_cpu_access(struct dma_buf *dmabuf, size_t start, size_t len,
+			     enum dma_data_direction direction)
+{
+	int ret = 0;
+
+	if (WARN_ON(!dmabuf))
+		return -EINVAL;
+
+	if (dmabuf->ops->begin_cpu_access)
+		ret = dmabuf->ops->begin_cpu_access(dmabuf, start, len, direction);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dma_buf_begin_cpu_access);
+
+/**
+ * dma_buf_end_cpu_access - Must be called after accessing a dma_buf from the
+ * cpu in the kernel context. Calls end_cpu_access to allow exporter-specific
+ * actions. Coherency is only guaranteed in the specified range for the
+ * specified access direction.
+ * @dmabuf:	[in]	buffer to complete cpu access for.
+ * @start:	[in]	start of range for cpu access.
+ * @len:	[in]	length of range for cpu access.
+ * @direction:	[in]	length of range for cpu access.
+ *
+ * This call must always succeed.
+ */
+void dma_buf_end_cpu_access(struct dma_buf *dmabuf, size_t start, size_t len,
+			    enum dma_data_direction direction)
+{
+	WARN_ON(!dmabuf);
+
+	if (dmabuf->ops->end_cpu_access)
+		dmabuf->ops->end_cpu_access(dmabuf, start, len, direction);
+}
+EXPORT_SYMBOL_GPL(dma_buf_end_cpu_access);
+
+/**
+ * dma_buf_kmap_atomic - Map a page of the buffer object into kernel address
+ * space. The same restrictions as for kmap_atomic and friends apply.
+ * @dmabuf:	[in]	buffer to map page from.
+ * @page_num:	[in]	page in PAGE_SIZE units to map.
+ *
+ * This call must always succeed, any necessary preparations that might fail
+ * need to be done in begin_cpu_access.
+ */
+void *dma_buf_kmap_atomic(struct dma_buf *dmabuf, unsigned long page_num)
+{
+	WARN_ON(!dmabuf);
+
+	return dmabuf->ops->kmap_atomic(dmabuf, page_num);
+}
+EXPORT_SYMBOL_GPL(dma_buf_kmap_atomic);
+
+/**
+ * dma_buf_kunmap_atomic - Unmap a page obtained by dma_buf_kmap_atomic.
+ * @dmabuf:	[in]	buffer to unmap page from.
+ * @page_num:	[in]	page in PAGE_SIZE units to unmap.
+ * @vaddr:	[in]	kernel space pointer obtained from dma_buf_kmap_atomic.
+ *
+ * This call must always succeed.
+ */
+void dma_buf_kunmap_atomic(struct dma_buf *dmabuf, unsigned long page_num,
+			   void *vaddr)
+{
+	WARN_ON(!dmabuf);
+
+	if (dmabuf->ops->kunmap_atomic)
+		dmabuf->ops->kunmap_atomic(dmabuf, page_num, vaddr);
+}
+EXPORT_SYMBOL_GPL(dma_buf_kunmap_atomic);
+
+/**
+ * dma_buf_kmap - Map a page of the buffer object into kernel address space. The
+ * same restrictions as for kmap and friends apply.
+ * @dmabuf:	[in]	buffer to map page from.
+ * @page_num:	[in]	page in PAGE_SIZE units to map.
+ *
+ * This call must always succeed, any necessary preparations that might fail
+ * need to be done in begin_cpu_access.
+ */
+void *dma_buf_kmap(struct dma_buf *dmabuf, unsigned long page_num)
+{
+	WARN_ON(!dmabuf);
+
+	return dmabuf->ops->kmap(dmabuf, page_num);
+}
+EXPORT_SYMBOL_GPL(dma_buf_kmap);
+
+/**
+ * dma_buf_kunmap - Unmap a page obtained by dma_buf_kmap.
+ * @dmabuf:	[in]	buffer to unmap page from.
+ * @page_num:	[in]	page in PAGE_SIZE units to unmap.
+ * @vaddr:	[in]	kernel space pointer obtained from dma_buf_kmap.
+ *
+ * This call must always succeed.
+ */
+void dma_buf_kunmap(struct dma_buf *dmabuf, unsigned long page_num,
+		    void *vaddr)
+{
+	WARN_ON(!dmabuf);
+
+	if (dmabuf->ops->kunmap)
+		dmabuf->ops->kunmap(dmabuf, page_num, vaddr);
+}
+EXPORT_SYMBOL_GPL(dma_buf_kunmap);
+
+
+/**
+ * dma_buf_mmap - Setup up a userspace mmap with the given vma
+ * @dmabuf:	[in]	buffer that should back the vma
+ * @vma:	[in]	vma for the mmap
+ * @pgoff:	[in]	offset in pages where this mmap should start within the
+ * 			dma-buf buffer.
+ *
+ * This function adjusts the passed in vma so that it points at the file of the
+ * dma_buf operation. It alsog adjusts the starting pgoff and does bounds
+ * checking on the size of the vma. Then it calls the exporters mmap function to
+ * set up the mapping.
+ *
+ * Can return negative error values, returns 0 on success.
+ */
+int dma_buf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma,
+		 unsigned long pgoff)
+{
+	struct file *oldfile;
+	int ret;
+
+	if (WARN_ON(!dmabuf || !vma))
+		return -EINVAL;
+
+	/* check for offset overflow */
+	if (pgoff + ((vma->vm_end - vma->vm_start) >> PAGE_SHIFT) < pgoff)
+		return -EOVERFLOW;
+
+	/* check for overflowing the buffer's size */
+	if (pgoff + ((vma->vm_end - vma->vm_start) >> PAGE_SHIFT) >
+	    dmabuf->size >> PAGE_SHIFT)
+		return -EINVAL;
+
+	/* readjust the vma */
+	get_file(dmabuf->file);
+	oldfile = vma->vm_file;
+	vma->vm_file = dmabuf->file;
+	vma->vm_pgoff = pgoff;
+
+	ret = dmabuf->ops->mmap(dmabuf, vma);
+	if (ret) {
+		/* restore old parameters on failure */
+		vma->vm_file = oldfile;
+		fput(dmabuf->file);
+	} else {
+		if (oldfile)
+			fput(oldfile);
+	}
+	return ret;
+
+}
+EXPORT_SYMBOL_GPL(dma_buf_mmap);
+
+/**
+ * dma_buf_vmap - Create virtual mapping for the buffer object into kernel
+ * address space. Same restrictions as for vmap and friends apply.
+ * @dmabuf:	[in]	buffer to vmap
+ *
+ * This call may fail due to lack of virtual mapping address space.
+ * These calls are optional in drivers. The intended use for them
+ * is for mapping objects linear in kernel space for high use objects.
+ * Please attempt to use kmap/kunmap before thinking about these interfaces.
+ */
+void *dma_buf_vmap(struct dma_buf *dmabuf)
+{
+	void *ptr;
+
+	if (WARN_ON(!dmabuf))
+		return NULL;
+
+	if (!dmabuf->ops->vmap)
+		return NULL;
+
+	mutex_lock(&dmabuf->lock);
+	if (dmabuf->vmapping_counter) {
+		dmabuf->vmapping_counter++;
+		BUG_ON(!dmabuf->vmap_ptr);
+		ptr = dmabuf->vmap_ptr;
+		goto out_unlock;
+	}
+
+	BUG_ON(dmabuf->vmap_ptr);
+
+	ptr = dmabuf->ops->vmap(dmabuf);
+	if (IS_ERR_OR_NULL(ptr))
+		goto out_unlock;
+
+	dmabuf->vmap_ptr = ptr;
+	dmabuf->vmapping_counter = 1;
+
+out_unlock:
+	mutex_unlock(&dmabuf->lock);
+	return ptr;
+}
+EXPORT_SYMBOL_GPL(dma_buf_vmap);
+
+/**
+ * dma_buf_vunmap - Unmap a vmap obtained by dma_buf_vmap.
+ * @dmabuf:	[in]	buffer to vunmap
+ * @vaddr:	[in]	vmap to vunmap
+ */
+void dma_buf_vunmap(struct dma_buf *dmabuf, void *vaddr)
+{
+	if (WARN_ON(!dmabuf))
+		return;
+
+	BUG_ON(!dmabuf->vmap_ptr);
+	BUG_ON(dmabuf->vmapping_counter == 0);
+	BUG_ON(dmabuf->vmap_ptr != vaddr);
+
+	mutex_lock(&dmabuf->lock);
+	if (--dmabuf->vmapping_counter == 0) {
+		if (dmabuf->ops->vunmap)
+			dmabuf->ops->vunmap(dmabuf, vaddr);
+		dmabuf->vmap_ptr = NULL;
+	}
+	mutex_unlock(&dmabuf->lock);
+}
+EXPORT_SYMBOL_GPL(dma_buf_vunmap);
diff --git a/backport/include/linux/dma-buf.h b/backport/include/linux/dma-buf.h
new file mode 100644
index 0000000..6b280c5
--- /dev/null
+++ b/backport/include/linux/dma-buf.h
@@ -0,0 +1,211 @@
+#ifndef CPTCFG_BACKPORT_BUILD_DMA_SHARED_BUFFER
+#include_next <linux/dma-buf.h>
+#else
+/*
+ * Header file for dma buffer sharing framework.
+ *
+ * Copyright(C) 2011 Linaro Limited. All rights reserved.
+ * Author: Sumit Semwal <sumit.semwal@ti.com>
+ *
+ * Many thanks to linaro-mm-sig list, and specially
+ * Arnd Bergmann <arnd@arndb.de>, Rob Clark <rob@ti.com> and
+ * Daniel Vetter <daniel@ffwll.ch> for their support in creation and
+ * refining of this idea.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __DMA_BUF_H__
+#define __DMA_BUF_H__
+
+#include <linux/file.h>
+#include <linux/err.h>
+#include <linux/scatterlist.h>
+#include <linux/list.h>
+#include <linux/dma-mapping.h>
+#include <linux/fs.h>
+
+struct device;
+struct dma_buf;
+struct dma_buf_attachment;
+
+/**
+ * struct dma_buf_ops - operations possible on struct dma_buf
+ * @attach: [optional] allows different devices to 'attach' themselves to the
+ *	    given buffer. It might return -EBUSY to signal that backing storage
+ *	    is already allocated and incompatible with the requirements
+ *	    of requesting device.
+ * @detach: [optional] detach a given device from this buffer.
+ * @map_dma_buf: returns list of scatter pages allocated, increases usecount
+ *		 of the buffer. Requires atleast one attach to be called
+ *		 before. Returned sg list should already be mapped into
+ *		 _device_ address space. This call may sleep. May also return
+ *		 -EINTR. Should return -EINVAL if attach hasn't been called yet.
+ * @unmap_dma_buf: decreases usecount of buffer, might deallocate scatter
+ *		   pages.
+ * @release: release this buffer; to be called after the last dma_buf_put.
+ * @begin_cpu_access: [optional] called before cpu access to invalidate cpu
+ * 		      caches and allocate backing storage (if not yet done)
+ * 		      respectively pin the objet into memory.
+ * @end_cpu_access: [optional] called after cpu access to flush caches.
+ * @kmap_atomic: maps a page from the buffer into kernel address
+ * 		 space, users may not block until the subsequent unmap call.
+ * 		 This callback must not sleep.
+ * @kunmap_atomic: [optional] unmaps a atomically mapped page from the buffer.
+ * 		   This Callback must not sleep.
+ * @kmap: maps a page from the buffer into kernel address space.
+ * @kunmap: [optional] unmaps a page from the buffer.
+ * @mmap: used to expose the backing storage to userspace. Note that the
+ * 	  mapping needs to be coherent - if the exporter doesn't directly
+ * 	  support this, it needs to fake coherency by shooting down any ptes
+ * 	  when transitioning away from the cpu domain.
+ * @vmap: [optional] creates a virtual mapping for the buffer into kernel
+ *	  address space. Same restrictions as for vmap and friends apply.
+ * @vunmap: [optional] unmaps a vmap from the buffer
+ */
+struct dma_buf_ops {
+	int (*attach)(struct dma_buf *, struct device *,
+			struct dma_buf_attachment *);
+
+	void (*detach)(struct dma_buf *, struct dma_buf_attachment *);
+
+	/* For {map,unmap}_dma_buf below, any specific buffer attributes
+	 * required should get added to device_dma_parameters accessible
+	 * via dev->dma_params.
+	 */
+	struct sg_table * (*map_dma_buf)(struct dma_buf_attachment *,
+						enum dma_data_direction);
+	void (*unmap_dma_buf)(struct dma_buf_attachment *,
+						struct sg_table *,
+						enum dma_data_direction);
+	/* TODO: Add try_map_dma_buf version, to return immed with -EBUSY
+	 * if the call would block.
+	 */
+
+	/* after final dma_buf_put() */
+	void (*release)(struct dma_buf *);
+
+	int (*begin_cpu_access)(struct dma_buf *, size_t, size_t,
+				enum dma_data_direction);
+	void (*end_cpu_access)(struct dma_buf *, size_t, size_t,
+			       enum dma_data_direction);
+	void *(*kmap_atomic)(struct dma_buf *, unsigned long);
+	void (*kunmap_atomic)(struct dma_buf *, unsigned long, void *);
+	void *(*kmap)(struct dma_buf *, unsigned long);
+	void (*kunmap)(struct dma_buf *, unsigned long, void *);
+
+	int (*mmap)(struct dma_buf *, struct vm_area_struct *vma);
+
+	void *(*vmap)(struct dma_buf *);
+	void (*vunmap)(struct dma_buf *, void *vaddr);
+};
+
+/**
+ * struct dma_buf - shared buffer object
+ * @size: size of the buffer
+ * @file: file pointer used for sharing buffers across, and for refcounting.
+ * @attachments: list of dma_buf_attachment that denotes all devices attached.
+ * @ops: dma_buf_ops associated with this buffer object.
+ * @priv: exporter specific private data for this buffer object.
+ */
+struct dma_buf {
+	size_t size;
+	struct file *file;
+	struct list_head attachments;
+	const struct dma_buf_ops *ops;
+	/* mutex to serialize list manipulation, attach/detach and vmap/unmap */
+	struct mutex lock;
+	unsigned vmapping_counter;
+	void *vmap_ptr;
+	void *priv;
+};
+
+/**
+ * struct dma_buf_attachment - holds device-buffer attachment data
+ * @dmabuf: buffer for this attachment.
+ * @dev: device attached to the buffer.
+ * @node: list of dma_buf_attachment.
+ * @priv: exporter specific attachment data.
+ *
+ * This structure holds the attachment information between the dma_buf buffer
+ * and its user device(s). The list contains one attachment struct per device
+ * attached to the buffer.
+ */
+struct dma_buf_attachment {
+	struct dma_buf *dmabuf;
+	struct device *dev;
+	struct list_head node;
+	void *priv;
+};
+
+/**
+ * get_dma_buf - convenience wrapper for get_file.
+ * @dmabuf:	[in]	pointer to dma_buf
+ *
+ * Increments the reference count on the dma-buf, needed in case of drivers
+ * that either need to create additional references to the dmabuf on the
+ * kernel side.  For example, an exporter that needs to keep a dmabuf ptr
+ * so that subsequent exports don't create a new dmabuf.
+ */
+#define get_dma_buf LINUX_BACKPORT(get_dma_buf)
+static inline void get_dma_buf(struct dma_buf *dmabuf)
+{
+	get_file(dmabuf->file);
+}
+
+#define dma_buf_attach LINUX_BACKPORT(dma_buf_attach)
+struct dma_buf_attachment *dma_buf_attach(struct dma_buf *dmabuf,
+							struct device *dev);
+#define dma_buf_detach LINUX_BACKPORT(dma_buf_detach)
+void dma_buf_detach(struct dma_buf *dmabuf,
+				struct dma_buf_attachment *dmabuf_attach);
+#define dma_buf_export LINUX_BACKPORT(dma_buf_export)
+struct dma_buf *dma_buf_export(void *priv, const struct dma_buf_ops *ops,
+			       size_t size, int flags);
+#define dma_buf_fd LINUX_BACKPORT(dma_buf_fd)
+int dma_buf_fd(struct dma_buf *dmabuf, int flags);
+#define dma_buf_get LINUX_BACKPORT(dma_buf_get)
+struct dma_buf *dma_buf_get(int fd);
+#define dma_buf_put LINUX_BACKPORT(dma_buf_put)
+void dma_buf_put(struct dma_buf *dmabuf);
+
+#define dma_buf_map_attachment LINUX_BACKPORT(dma_buf_map_attachment)
+struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *,
+					enum dma_data_direction);
+#define dma_buf_unmap_attachment LINUX_BACKPORT(dma_buf_unmap_attachment)
+void dma_buf_unmap_attachment(struct dma_buf_attachment *, struct sg_table *,
+				enum dma_data_direction);
+#define dma_buf_begin_cpu_access LINUX_BACKPORT(dma_buf_begin_cpu_access)
+int dma_buf_begin_cpu_access(struct dma_buf *dma_buf, size_t start, size_t len,
+			     enum dma_data_direction dir);
+#define dma_buf_end_cpu_access LINUX_BACKPORT(dma_buf_end_cpu_access)
+void dma_buf_end_cpu_access(struct dma_buf *dma_buf, size_t start, size_t len,
+			    enum dma_data_direction dir);
+#define dma_buf_kmap_atomic LINUX_BACKPORT(dma_buf_kmap_atomic)
+void *dma_buf_kmap_atomic(struct dma_buf *, unsigned long);
+#define dma_buf_kunmap_atomic LINUX_BACKPORT(dma_buf_kunmap_atomic)
+void dma_buf_kunmap_atomic(struct dma_buf *, unsigned long, void *);
+#define dma_buf_kmap LINUX_BACKPORT(dma_buf_kmap)
+void *dma_buf_kmap(struct dma_buf *, unsigned long);
+#define dma_buf_kunmap LINUX_BACKPORT(dma_buf_kunmap)
+void dma_buf_kunmap(struct dma_buf *, unsigned long, void *);
+
+#define dma_buf_mmap LINUX_BACKPORT(dma_buf_mmap)
+int dma_buf_mmap(struct dma_buf *, struct vm_area_struct *,
+		 unsigned long);
+#define dma_buf_vmap LINUX_BACKPORT(dma_buf_vmap)
+void *dma_buf_vmap(struct dma_buf *);
+#define dma_buf_vunmap LINUX_BACKPORT(dma_buf_vunmap)
+void dma_buf_vunmap(struct dma_buf *, void *vaddr);
+
+#endif /* __DMA_BUF_H__ */
+#endif /* CPTCFG_BACKPORT_BUILD_DMA_SHARED_BUFFER */
-- 
1.7.10.4

