Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:48272 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbaEVGSc (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 22 May 2014 02:18:32 -0400
Received: by mail-ie0-f171.google.com with SMTP id to1so3113651ieb.30
        for <backports@vger.kernel.org>; Wed, 21 May 2014 23:18:32 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 21 May 2014 23:18:32 -0700
Message-ID: <CAEsx0Y9sRSEvnx533s+1HjD7MQtVJVxAnn7wyHfw7zQoNgdfCw@mail.gmail.com> (sfid-20140522_081835_166336_273366FA)
Subject: Building Backports Without the Kernel Config
From: Daniel Schultze <kinglag@gmail.com>
To: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

I need a driver that is available in backports but I do not have the
original kernel's source or config. I do have a vanilla kernel of the
same version and can approximate the config to some degree.

Given these conditions can I have a reasonable stable module for a
production system?

Thank you,

Daniel Schultze
