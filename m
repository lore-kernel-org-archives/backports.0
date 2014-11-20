Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:55228 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756873AbaKTVQi (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 20 Nov 2014 16:16:38 -0500
Received: by mail-pa0-f54.google.com with SMTP id fb1so3305016pad.41
        for <backports@vger.kernel.org>; Thu, 20 Nov 2014 13:16:37 -0800 (PST)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: julia.lawall@lip6.fr, oblinger@gmail.com,
	"Luis R. Rodriguez" <mcgrof@suse.com>
Subject: [PATCH 2/5] backports: address splitting of v4l2-mediabus.h to two files
Date: Thu, 20 Nov 2014 13:16:20 -0800
Message-Id: <1416518183-7347-3-git-send-email-mcgrof@do-not-panic.com> (sfid-20141120_221639_649322_4322FE46)
In-Reply-To: <1416518183-7347-1-git-send-email-mcgrof@do-not-panic.com>
References: <1416518183-7347-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

The new file media-bus-format.h was derived from contents from
v4l2-mediabus.h, this change might be a bit harder to infer
exactly what to do but based on some contextual examination of
the file, if content integrity has not changed it should be
relatively easy to infer what to do with changes like this.

commit edcf58bc031e621f519c9dfce3c7e1ea6880c70a
Author: Boris BREZILLON <boris.brezillon@free-electrons.com>
Date:   Mon Nov 10 14:28:26 2014 -0300

    [media] Move mediabus format definition to a more standard place

    Define MEDIA_BUS_FMT macros (re-using the values defined in the
    v4l2_mbus_pixelcode enum) into a separate header file so that they can be
    used from the DRM/KMS subsystem without any reference to the V4L2
    subsystem.

    Then set V4L2_MBUS_FMT definitions to the MEDIA_BUS_FMT values using the
    V4L2_MBUS_FROM_MEDIA_BUS_FMT macro.

    Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
    Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
    Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
    Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
    Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
    Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>

 include/uapi/linux/Kbuild             |   1 +
 include/uapi/linux/media-bus-format.h | 125 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/v4l2-mediabus.h    | 184 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------------------------------
 3 files changed, 206 insertions(+), 104 deletions(-)

Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 copy-list | 1 +
 1 file changed, 1 insertion(+)

diff --git a/copy-list b/copy-list
index b7ac165..19017af 100644
--- a/copy-list
+++ b/copy-list
@@ -145,6 +145,7 @@ include/uapi/linux/v4l2-common.h
 include/uapi/linux/v4l2-controls.h
 include/uapi/linux/v4l2-dv-timings.h
 include/uapi/linux/v4l2-mediabus.h
+include/uapi/linux/media-bus-format.h
 include/uapi/linux/v4l2-subdev.h
 include/uapi/linux/videodev2.h
 include/uapi/linux/vsp1.h
-- 
2.1.1

