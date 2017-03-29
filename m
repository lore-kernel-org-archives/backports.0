Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ot0-f178.google.com ([74.125.82.178]:35915 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753932AbdC2IEj (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 29 Mar 2017 04:04:39 -0400
Received: by mail-ot0-f178.google.com with SMTP id t8so5208137otf.3
        for <backports@vger.kernel.org>; Wed, 29 Mar 2017 01:04:38 -0700 (PDT)
MIME-Version: 1.0
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
Date: Wed, 29 Mar 2017 10:04:37 +0200
Message-ID: <CAFED-jmLaRiM5b7XotQDrhtphSMtLDO565xCjobTnwhtipuuUQ@mail.gmail.com> (sfid-20170329_100904_084825_40B6ACA5)
Subject: ib-rhashtable.c:90:17: error
To: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hello,

backports generate like this:

./gentree.py --verbose --clean --git-revision next-20170310
--copy-list copy-list.ath ~/linux-next/ ~/backports-output

When compile on 4.4 kernel I hit such error:

  CC [M]  /home/jdziedzx/backports-output/compat/backport-4.8.o
  CC [M]  /home/jdziedzx/backports-output/compat/lib-rhashtable.o
/home/jdziedzx/backports-output/compat/lib-rhashtable.c: In function
=E2=80=98alloc_bucket_locks=E2=80=99:
/home/jdziedzx/backports-output/compat/lib-rhashtable.c:90:17: error:
implicit declaration of function =E2=80=98kvmalloc=E2=80=99
[-Werror=3Dimplicit-function-declaration]
    tbl->locks =3D kvmalloc(size * sizeof(spinlock_t), gfp);
                 ^
/home/jdziedzx/backports-output/compat/lib-rhashtable.c:90:15:
warning: assignment makes pointer from integer without a cast
[-Wint-conversion]
    tbl->locks =3D kvmalloc(size * sizeof(spinlock_t), gfp);
               ^
cc1: some warnings being treated as errors

Is there any fix for that?

--=20
Janusz Dziedzic
--
To unsubscribe from this list: send the line "unsubscribe backports" in
