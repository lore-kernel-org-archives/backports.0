Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:33490 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751220AbdKJIEN (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 10 Nov 2017 03:04:13 -0500
Received: by mail-wm0-f43.google.com with SMTP id r68so4897337wmr.0
        for <backports@vger.kernel.org>; Fri, 10 Nov 2017 00:04:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAN+BLYG8yxBbEuGB=rYDJAPA5i7AwPEqknLas1+FM=iP6w5N=w@mail.gmail.com>
References: <CAN+BLYEAyzFaCOt8rM9OMX2RhhFnahXvRJQY+-nTgdjcpGeTLA@mail.gmail.com>
 <CAN+BLYG8yxBbEuGB=rYDJAPA5i7AwPEqknLas1+FM=iP6w5N=w@mail.gmail.com>
From: =?UTF-8?B?5ZCz6YeN5q+F?= <uranus0206@gmail.com>
Date: Fri, 10 Nov 2017 16:03:51 +0800
Message-ID: <CAN+BLYHawvjYt+HK3QKR1jRqmibepNK8wkszHSgpMSNsEqK4qg@mail.gmail.com> (sfid-20171110_090415_622837_13CE9927)
Subject: Re: QCA9984 ap mode with ath10k backport cannot be connect
To: backports@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi:
I also have another card which driver is ath9k. I use the same
backport source to build ath9k module, and get the same result(I do
not get any fail message in dmesg).

Enable wifi ap mode is successful. But cannot be connected. Then i
change to previous built modules( an issue with old module is wifi
card with ath9k cannot use), and i can connect to ap.

Here are both backport source i made(backport to linux4.2):
Old:  https://drive.google.com/open?id=1y00crEiBzpZS9qILvFaPYfZrVKdIXuT4
New:  https://drive.google.com/open?id=1zuxoyysXj2RskxKeMZ4h2sakqJI1wYzT

I diff the backport sources and they are very different.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
