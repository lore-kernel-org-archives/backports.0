Return-path: <backports-owner@vger.kernel.org>
Received: from poseidon.ceid.upatras.gr ([150.140.141.169]:43363 "EHLO
	poseidon.ceid.upatras.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510AbaFKMYd (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 11 Jun 2014 08:24:33 -0400
Received: from mail.ceid.upatras.gr (mail.ceid.upatras.gr [10.1.0.174])
	by poseidon.ceid.upatras.gr (Postfix) with ESMTP id 1E04D7FFC7
	for <backports@vger.kernel.org>; Wed, 11 Jun 2014 15:15:45 +0300 (EEST)
Received: from webmail.ceid.upatras.gr (web.ceid.upatras.gr [10.1.0.173])
	(Authenticated sender: stathopou)
	by mail.ceid.upatras.gr (Postfix) with ESMTPSA id 07DE91FFA0
	for <backports@vger.kernel.org>; Wed, 11 Jun 2014 15:15:44 +0300 (EEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Wed, 11 Jun 2014 15:15:43 +0300
From: Stathopoulos Nikolaos <stathopou@ceid.upatras.gr>
To: backports@vger.kernel.org
Subject: Disabling minstrel rate control
Message-ID: <3293ee4ecc5bff7849dcb0de06d58cc0@ceid.upatras.gr> (sfid-20140611_142436_609442_20E2823F)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hello,

While doing some measurements regarding bit rate and SNR using iperf, I 
noticed that at ceratin distances tha bit rate
is reduced. I suppose this is a result of minstrel reducing tha data 
rate. However, I don't want the rate to be adjusted, I need it to be at 
a fixed value, regardless of the consequences. To sum up, how can I 
disable the rate control algorithms? In my experiments I use adapters 
working with ath9k_htc drivers.

Thank you in advance,
Nikos
