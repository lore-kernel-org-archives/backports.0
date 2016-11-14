Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33824 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753379AbcKNI4B (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 14 Nov 2016 03:56:01 -0500
Received: by mail-pg0-f44.google.com with SMTP id x23so49205094pgx.1
        for <backports@vger.kernel.org>; Mon, 14 Nov 2016 00:56:01 -0800 (PST)
Received: from [10.176.68.21] ([192.19.213.250])
        by smtp.gmail.com with ESMTPSA id d197sm33337563pfd.38.2016.11.14.00.49.06
        for <backports@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Nov 2016 00:49:06 -0800 (PST)
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Subject: min/max mtu field in struct net_device
Message-ID: <c4682854-87ce-5e28-d049-545f24d48cab@broadcom.com> (sfid-20161114_095807_156709_13DD77F5)
Date: Mon, 14 Nov 2016 09:49:03 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Just wondering. Does anyone have any ideas on how to backport the two
patches below. The struct net_device now holds mtu range which network
subsystem checks. For a number of drivers and mac80211 it means they no
longer have .ndo_change_mtu callback. My guess is that we need patches
in backport of some sort to tackle this.

Regards,
Arend

commit 61e84623ace35ce48975e8f90bbbac7557c43d61
Author: Jarod Wilson <jarod@redhat.com>
Date:   Fri Oct 7 22:04:33 2016 -0400

    net: centralize net_device min/max MTU checking

commit 9c22b4a34eddbaa5b5243c8cd27e31aa36e676e1
Author: Jarod Wilson <jarod@redhat.com>
Date:   Thu Oct 20 13:55:18 2016 -0400

    net: use core MTU range checking in wireless drivers
--
To unsubscribe from this list: send the line "unsubscribe backports" in
