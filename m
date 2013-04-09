Return-path: <backports-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:13465 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935065Ab3DIIZd (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 9 Apr 2013 04:25:33 -0400
Message-ID: <5163D07B.3040005@linux.intel.com> (sfid-20130409_102540_941187_7C65FC87)
Date: Tue, 09 Apr 2013 10:25:31 +0200
From: Thierry Escande <thierry.escande@linux.intel.com>
MIME-Version: 1.0
To: Hauke Mehrtens <hauke@hauke-m.de>
CC: backports@vger.kernel.org
Subject: Re: [PATCH v3 7/8] build: enable NFC build
References: <1365416773-12836-8-git-send-email-thierry.escande@linux.intel.com> <51631ABB.4000102@hauke-m.de>
In-Reply-To: <51631ABB.4000102@hauke-m.de>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi Hauke,

On 04/08/2013 09:30 PM, Hauke Mehrtens wrote:
>> +
>> +source net/nfc/Kconfig
> 
> Isn't this missing here?
> source drivers/nfc/Kconfig

It's included by net/nfc/Kconfig. That way NFC devices show up in menuconfig only when the NFC subsystem is selected.

Regards,

 Thierry

