Return-path: <backports-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:47502 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbaGWMNV (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 23 Jul 2014 08:13:21 -0400
Received: by mail-qg0-f51.google.com with SMTP id a108so1227992qge.10
        for <backports@vger.kernel.org>; Wed, 23 Jul 2014 05:13:21 -0700 (PDT)
MIME-Version: 1.0
From: Bartlomiej Grzeskowiak <bartlomiej.grzeskowiak@gmail.com>
Date: Wed, 23 Jul 2014 14:12:50 +0200
Message-ID: <CADaZW1FzEbk_HxwHief9E1wO09RByNCnAfaH1MteUfWCgxWtvA@mail.gmail.com> (sfid-20140723_141324_131076_9200955C)
Subject: WPS_KEY button support
To: backports@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,

I am testing WPS functionality. Everything works ok as long I use
shell to send wpa_cli wps_pbc command. But usually WPS should work
without any shell action. Only by pressing both WPS buttons on router
and on USB Stick.

I do not see WPS_KEY lines in my USB stick driver (backports 3.15.1-1
I also do not see any events, messages when I press WPS button on USB Stick)

Is the functionality of WPS button implemented ?

Thank you in advance and best regards
Bartlomiej Grzeskowiak
