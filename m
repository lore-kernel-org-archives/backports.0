Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:47304 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751971Ab3JaMuq (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 31 Oct 2013 08:50:46 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id BABDA2039F
	for <backports@vger.kernel.org>; Thu, 31 Oct 2013 12:50:41 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 4EB0620318
	for <backports@vger.kernel.org>; Thu, 31 Oct 2013 12:50:37 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: backports@vger.kernel.org
Subject: [Bug 64091] backports build error
Date: Thu, 31 Oct 2013 12:50:37 +0000
Message-ID: <bug-64091-58281-KQad6RCgMv@https.bugzilla.kernel.org/> (sfid-20131031_135052_185680_A27D29A6)
In-Reply-To: <bug-64091-58281@https.bugzilla.kernel.org/>
References: <bug-64091-58281@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=64091

--- Comment #3 from DarinV <darin.vancoevering@gmail.com> ---
#ifndef _LINUX_KERNEL_H
#define _LINUX_KERNEL_H

/*
 * 'kernel.h' contains some often-used function prototypes etc
 */

#ifdef __KERNEL__

#include <stdarg.h>
#include <linux/linkage.h>
#include <linux/stddef.h>
#include <linux/types.h>
#include <linux/compiler.h>
#include <linux/bitops.h>
#include <linux/log2.h>
#include <linux/typecheck.h>
#include <linux/ratelimit.h>
#include <asm/byteorder.h>
#include <asm/bug.h>

extern const char linux_banner[];
extern const char linux_proc_banner[];

#define USHORT_MAX    ((u16)(~0U))

-- 
You are receiving this mail because:
You are the assignee for the bug.
