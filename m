Return-Path: <SRS0=hnMY=WB=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCE9C433FF
	for <backports@archiver.kernel.org>; Mon,  5 Aug 2019 12:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F20C2086D
	for <backports@archiver.kernel.org>; Mon,  5 Aug 2019 12:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbfHEMIE (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 5 Aug 2019 08:08:04 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:49996 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727259AbfHEMIE (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 5 Aug 2019 08:08:04 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id D1D3C514BC;
        Mon,  5 Aug 2019 14:08:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id QJMiJSfGd0G9; Mon,  5 Aug 2019 14:07:49 +0200 (CEST)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 05/12] header: Add trace_##name##_enabled()
Date:   Mon,  5 Aug 2019 14:06:57 +0200
Message-Id: <20190805120704.13128-6-hauke@hauke-m.de>
In-Reply-To: <20190805120704.13128-1-hauke@hauke-m.de>
References: <20190805120704.13128-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This adds the function trace_##name##_enabled to __DECLARE_TRACE() which
was added in commit 7c65bbc7dc ("tracing: Add
trace_<tracepoint>_enabled() function"). This is now used by ath10k.

__DECLARE_TRACE() got other changes wit kernel 3.16, so add two
different versions.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/backport-include/linux/tracepoint.h | 132 +++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/backport/backport-include/linux/tracepoint.h b/backport/backport-include/linux/tracepoint.h
index a695c6fc..6bb91ad3 100644
--- a/backport/backport-include/linux/tracepoint.h
+++ b/backport/backport-include/linux/tracepoint.h
@@ -7,4 +7,136 @@
 #define TRACE_DEFINE_ENUM(a)
 #endif
 
+#if LINUX_VERSION_IS_LESS(3,15,0)
+#ifdef TRACEPOINTS_ENABLED
+#undef __DECLARE_TRACE
+#define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args) \
+	extern struct tracepoint __tracepoint_##name;			\
+	static inline void trace_##name(proto)				\
+	{								\
+		if (static_key_false(&__tracepoint_##name.key))		\
+			__DO_TRACE(&__tracepoint_##name,		\
+				TP_PROTO(data_proto),			\
+				TP_ARGS(data_args),			\
+				TP_CONDITION(cond),,);			\
+	}								\
+	__DECLARE_TRACE_RCU(name, PARAMS(proto), PARAMS(args),		\
+		PARAMS(cond), PARAMS(data_proto), PARAMS(data_args))	\
+	static inline int						\
+	register_trace_##name(void (*probe)(data_proto), void *data)	\
+	{								\
+		return tracepoint_probe_register(#name, (void *)probe,	\
+						 data);			\
+	}								\
+	static inline int						\
+	unregister_trace_##name(void (*probe)(data_proto), void *data)	\
+	{								\
+		return tracepoint_probe_unregister(#name, (void *)probe, \
+						   data);		\
+	}								\
+	static inline void						\
+	check_trace_callback_type_##name(void (*cb)(data_proto))	\
+	{								\
+	}								\
+	static inline bool						\
+	trace_##name##_enabled(void)					\
+	{								\
+		return static_key_false(&__tracepoint_##name.key);	\
+	}
+
+#else
+#undef __DECLARE_TRACE
+#define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args) \
+	static inline void trace_##name(proto)				\
+	{ }								\
+	static inline void trace_##name##_rcuidle(proto)		\
+	{ }								\
+	static inline int						\
+	register_trace_##name(void (*probe)(data_proto),		\
+			      void *data)				\
+	{								\
+		return -ENOSYS;						\
+	}								\
+	static inline int						\
+	unregister_trace_##name(void (*probe)(data_proto),		\
+				void *data)				\
+	{								\
+		return -ENOSYS;						\
+	}								\
+	static inline void check_trace_callback_type_##name(void (*cb)(data_proto)) \
+	{								\
+	}								\
+	static inline bool						\
+	trace_##name##_enabled(void)					\
+	{								\
+		return false;						\
+	}
+#endif /* TRACEPOINTS_ENABLED */
+#elif LINUX_VERSION_IS_LESS(3,16,0)
+#ifdef TRACEPOINTS_ENABLED
+#undef __DECLARE_TRACE
+#define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args) \
+	extern struct tracepoint __tracepoint_##name;			\
+	static inline void trace_##name(proto)				\
+	{								\
+		if (static_key_false(&__tracepoint_##name.key))		\
+			__DO_TRACE(&__tracepoint_##name,		\
+				TP_PROTO(data_proto),			\
+				TP_ARGS(data_args),			\
+				TP_CONDITION(cond),,);			\
+	}								\
+	__DECLARE_TRACE_RCU(name, PARAMS(proto), PARAMS(args),		\
+		PARAMS(cond), PARAMS(data_proto), PARAMS(data_args))	\
+	static inline int						\
+	register_trace_##name(void (*probe)(data_proto), void *data)	\
+	{								\
+		return tracepoint_probe_register(&__tracepoint_##name,	\
+						(void *)probe, data);	\
+	}								\
+	static inline int						\
+	unregister_trace_##name(void (*probe)(data_proto), void *data)	\
+	{								\
+		return tracepoint_probe_unregister(&__tracepoint_##name,\
+						(void *)probe, data);	\
+	}								\
+	static inline void						\
+	check_trace_callback_type_##name(void (*cb)(data_proto))	\
+	{								\
+	}								\
+	static inline bool						\
+	trace_##name##_enabled(void)					\
+	{								\
+		return static_key_false(&__tracepoint_##name.key);	\
+	}
+
+#else
+#undef __DECLARE_TRACE
+#define __DECLARE_TRACE(name, proto, args, cond, data_proto, data_args) \
+	static inline void trace_##name(proto)				\
+	{ }								\
+	static inline void trace_##name##_rcuidle(proto)		\
+	{ }								\
+	static inline int						\
+	register_trace_##name(void (*probe)(data_proto),		\
+			      void *data)				\
+	{								\
+		return -ENOSYS;						\
+	}								\
+	static inline int						\
+	unregister_trace_##name(void (*probe)(data_proto),		\
+				void *data)				\
+	{								\
+		return -ENOSYS;						\
+	}								\
+	static inline void check_trace_callback_type_##name(void (*cb)(data_proto)) \
+	{								\
+	}								\
+	static inline bool						\
+	trace_##name##_enabled(void)					\
+	{								\
+		return false;						\
+	}
+#endif /* TRACEPOINTS_ENABLED */
+#endif /* < 3.16 */
+
 #endif /* __BACKPORT_LINUX_TRACEPOINT_H */
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
