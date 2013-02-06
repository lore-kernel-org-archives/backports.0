Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from cpanelsmarthost1.zen.co.uk ([82.71.204.225]:33666 "EHLO
	cpanelsmarthost1.zen.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758306Ab3BFWEv (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 6 Feb 2013 17:04:51 -0500
Received: from [88.98.24.67] (helo=shcp01.hosting.zen.net.uk)
	by cpanelsmarthost1.zen.co.uk with esmtp (Exim 4.72)
	(envelope-from <graham@somethingshocking.com>)
	id 1U3CTa-0006b7-TC
	for backports@vger.kernel.org; Wed, 06 Feb 2013 21:24:18 +0000
Received: from cpc1-bele6-0-0-cust839.2-1.cable.virginmedia.com ([82.4.39.72]:49883 helo=[192.168.1.9])
	by shcp01.hosting.zen.net.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.80)
	(envelope-from <graham@somethingshocking.com>)
	id 1U3CTW-00031r-Dn
	for backports@vger.kernel.org; Wed, 06 Feb 2013 21:24:14 +0000
Message-ID: <5112C9FA.7040207@somethingshocking.com>
Date: Wed, 06 Feb 2013 21:24:10 +0000
From: Graham Burnside <graham@somethingshocking.com>
MIME-Version: 1.0
To: backports@vger.kernel.org
Subject: 'modprobe -l' usage in Makefile
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,

I tried to use the compat-wireless backport to compile a newer rt2800pci
diver for my rt3290 device under wheezy (b4).

The Makefile is horribly broken due to the use of 'modprobe -l'
throughout, as are a number of the scripts in the scripts/.

Wheezy has moved to kmod, and uses a symlink from modprobe. kmod sees
'-l' as an invalid arguement.


-Graham

-- 

Get my public signing / encryption OpenPGP key at:
https://www.somethingshocking.com/grahamPublicPGP.key

