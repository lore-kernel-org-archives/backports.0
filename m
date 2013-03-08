Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:63695 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925Ab3CHLLl (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 8 Mar 2013 06:11:41 -0500
Received: by mail-lb0-f178.google.com with SMTP id n1so1251641lba.9
        for <backports@vger.kernel.org>; Fri, 08 Mar 2013 03:11:39 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 8 Mar 2013 12:11:39 +0100
Message-ID: <CAFbutietUh=r65eZM7tGG+ST3RhS+pB+RJrX=ZK0jZehEyYaNA@mail.gmail.com>
Subject: compat-driver doesn't compile
From: Manu <vbmanu@gmail.com>
To: backports@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

this is the error:

CC [M]
 /compat-drivers-3.8-1/drivers/
>
> net/wireless/ath/ath5k/led.o:
>            /compat-drivers-3.8-1/drivers/net/wireless/ath/ath5k/led.c:
> In function 'ath5k_init_leds':
>
> /compat-drivers-3.8-1/drivers/net/wireless/ath/ath5k/led.c:179:2: error:
> implicit declaration of function 'pci_match_id'
> [-Werror=implicit-function-declaration]
>
> /compat-drivers-3.8-1/drivers/net/wireless/ath/ath5k/led.c:179:8:
> warning: assignment makes pointer from integer without a cast [enabled
> by default]
> cc1: some warnings being treated as errors
