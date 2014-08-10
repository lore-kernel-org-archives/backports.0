Return-path: <backports-owner@vger.kernel.org>
Received: from test.hauke-m.de ([5.39.93.123]:45611 "EHLO test.hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751215AbaHJWIc (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 10 Aug 2014 18:08:32 -0400
Message-ID: <53E7ED57.3040300@hauke-m.de> (sfid-20140811_000835_523496_5CBC315B)
Date: Mon, 11 Aug 2014 00:08:23 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Patrick Shirkey <pshirkey@boosthardware.com>,
	backports@vger.kernel.org
Subject: Re: backport 3.12 to 3.4
References: <63756.86.107.254.57.1405612909.squirrel@boosthardware.com>
In-Reply-To: <63756.86.107.254.57.1405612909.squirrel@boosthardware.com>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 07/17/2014 06:01 PM, Patrick Shirkey wrote:
> Hi,
> 
> I am running 3.4.39 on an arm platform which I cannot easily upgrade to a
> newer kernel.
> 
> I would like like to test an experimental driver for the nfc chipset pn532
> which is written against 3.12
> 
> Unfortunately the chipset is different enough from pn533 that it needs
> it's own driver.
> 
> Is there a backport of 3.12 nfc codebase to 3.4.39 available somewhere?

Hi,

The version number in backports releases indicates from which kernel
version the code is *from*. backports-3.12, 3.13, ... all contain the
nfc code you need.

Hauke
