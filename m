Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:61623 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758818Ab3DBFCY (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 2 Apr 2013 01:02:24 -0400
Received: by mail-la0-f44.google.com with SMTP id eb20so29475lab.31
        for <backports@vger.kernel.org>; Mon, 01 Apr 2013 22:02:20 -0700 (PDT)
MIME-Version: 1.0
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Mon, 1 Apr 2013 22:02:00 -0700
Message-ID: <CAB=NE6XO=RrAvo-aQ5aoY8vmw5g9XzPdqNvewhpkJK_SyXmxxw@mail.gmail.com> (sfid-20130402_070227_482800_87AD7E76)
Subject: Fifth release based on next-20130328
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

linux-next has stalled now on next-20130328 due toe merge window so we
have a fifth release based on it with quite a few updates, in
particular for DRM -- drm-buf is now available even on kernels
3.2-3.4, this includes also enabing nouveau driver support on 3.2, it
was previously only available on >= 3.3. Additionally the media
subsystem was backported with the first drivers added being v4l2 and
uvcvideo. It should be easy to add more media drivers now.

Please test! (tarball will be available in a few minutes)

https://www.kernel.org/pub/linux/kernel/projects/backports/2013/03/28/compat-drivers-2013-03-28-5-u.tar.bz2

  Luis
