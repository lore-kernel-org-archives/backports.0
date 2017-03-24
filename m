Return-path: <backports-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:37000 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756696AbdCXKgx (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 24 Mar 2017 06:36:53 -0400
Received: by mail-it0-f47.google.com with SMTP id 190so6964904itm.0
        for <backports@vger.kernel.org>; Fri, 24 Mar 2017 03:36:53 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?5ZCz6YeN5q+F?= <uranus0206@gmail.com>
Date: Fri, 24 Mar 2017 18:36:26 +0800
Message-ID: <CAN+BLYH=tkxSxJSv995+n83Zon0kqweNb6X8nWeKuLFtCepSmQ@mail.gmail.com> (sfid-20170324_113721_904132_74122683)
Subject: Question of backports
To: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi:
I am confuse with backports' parameter. First i found the mail list of
http://lists.infradead.org/pipermail/ath10k/2017-March/009458.html
And i follow the attachment to patch backports' git.
I am success full create the backports-output, but some parameters confused=
 me.
The parameter "--git-revision next-20170310". Is it says i am using
tag next-20170310 of source linux-next?
Currently my git of backports is point at master.
When i use the command in maillist to generate backport-output.
What target of kernel version am i going to backport to ?
kernel of tag next-20170310(linux-next) to which kernel version?
If my backports git is point at tag v4.4.2 and --git-version is point
at v4.11. Can i say i am backporting from 4.11 to 4.4.2?

--=20
=E5=90=B3=E9=87=8D=E6=AF=85 Wu Chung-yi
--
To unsubscribe from this list: send the line "unsubscribe backports" in
