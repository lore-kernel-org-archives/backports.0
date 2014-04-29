Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ve0-f176.google.com ([209.85.128.176]:34952 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933235AbaD2JjM (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 29 Apr 2014 05:39:12 -0400
Received: by mail-ve0-f176.google.com with SMTP id db11so9279199veb.21
        for <backports@vger.kernel.org>; Tue, 29 Apr 2014 02:39:11 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 29 Apr 2014 02:39:11 -0700
Message-ID: <CAFjWW+ZsCZpmh-CVWX9Y+73tOAS5JG5f7mvrr8biAVgN_a+Fng@mail.gmail.com> (sfid-20140429_113914_869133_9CA0B55C)
Subject: 3.14-1 Compile Problem for 2.6.39.4 Kernel
From: Aaron Hamilton <aaron@logicdatasystems.net>
To: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

In trying to compile backports-3.14-1 with a 2.6.39.4 kernel, I get
the following compilation errors:

backport-include/linux/compat.h:18: error: expected ';', ',' or ')'
before '*' token

If I comment out line 18 in compat.h which just reads "extern int
compat_put_timespec(const struct timespec*, void __user *)", then I
get past that error.

Next, things get stuck on compat/crypto-ccm.c on lines 250 and 255,
stating "too few arguments to function 'scatterwalk_map'" and "too few
arguments to function 'scatterwalk_unmap'".

My kernel headers indicate this function takes two parameters and I
can't find anything in backports that specify otherwise. Am I missing
something?
