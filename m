Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:51410 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933153Ab3BLTfu (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 12 Feb 2013 14:35:50 -0500
Message-ID: <511A998B.8080204@hauke-m.de>
Date: Tue, 12 Feb 2013 20:35:39 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: "Bitterli, Felix" <felixb@qca.qualcomm.com>
CC: "Rodriguez, Luis" <rodrigue@qca.qualcomm.com>,
	backports@vger.kernel.org
Subject: Re: compat-drivers ./driver-select ath9k builds i915 as well, breaks
 my video
References: <40F35DA312B2CC468349B21A177FEE633C8AD5FA@NASANEXD02E.na.qualcomm.com>
In-Reply-To: <40F35DA312B2CC468349B21A177FEE633C8AD5FA@NASANEXD02E.na.qualcomm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 02/11/2013 10:37 PM, Bitterli, Felix wrote:
> Hello Hauke,
> 
> compat-drivers ./driver-select ath9k builds i915 as well, shouldn't, are
> you available for fixing this or do we wait for Luis to get back from
> Antarctica?
> 
> Best regards, Felix

Hi Felix,

I can not reproduce this with the current version based on linux-next
from [0].

Hauke

[0]: https://www.kernel.org/pub/linux/kernel/projects/backports/2013/02/08/
