Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58976 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965039Ab3E2ImQ (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 29 May 2013 04:42:16 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so8868420pbb.5
        for <backports@vger.kernel.org>; Wed, 29 May 2013 01:42:16 -0700 (PDT)
Received: from icy ([199.180.254.75])
        by mx.google.com with ESMTPSA id j10sm36483305pbh.23.2013.05.29.01.42.14
        for <backports@vger.kernel.org>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Wed, 29 May 2013 01:42:15 -0700 (PDT)
Date: Wed, 29 May 2013 15:41:57 +0700
From: "Anh K. Huynh" <kyanh@viettug.org>
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: install Backports to a different directory
Message-ID: <20130529154157.481e9fd0@icy> (sfid-20130529_104220_861682_3E1C402C)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hello,

I build Backports drivers on a powerful PC, to use the drivers
on my laptop. However, after the build is complete, I don't know
how to get the modules files and installation script to work
on laptop. By default, `make install` will save files to `/lib/`
on the PC; I need an option to install files to, e.g, `/foobar/`
so that I can create a package for the laptop. Is there anyway
to do that?

(I looked that file `Makefile.real` but it's a bit weird to me.)

Thank you,

--
I am ... 5 dog years old.
